
--SELECT top 10 * FROM Jobs
--DROP TABLE JobInformationETL
--DROP TABLE EquipmentETL

BEGIN TRAN

	--- Update existing data

	Update j
	SET BranchPlant = e.BranchPlant,
		CustomerId = (SELECT top 1 CustomerId FROM Customers c WHERE c.CustomerName = e.CustomerName), 
		StartDate = e.StartDate, 
		EndDate = e.EndDate, 
		LocationCountry = e.LocationCountry, 
		Rig = e.Rig, 
		JarWell = e.WellName, 
		Offshore = e.OffShore, 
		Coordinator = e.Coordinator, 
		Longitude = e.Longitude, 
		Latitude = e.Latitude, 
		DispatchNumber = e.JDEDeliveryTicketNumber,
		WFTUserName = e.WFTUserName, 
		SFLastModifiedDate = WPTSLastUpdatedDate
	FROM Jobs j (NOLOCK) 
	INNER JOIN JobInformationETL e (NOLOCK) ON j.ReportId = e.WPTSreportId
	WHERE j.SalesforceId IS NULL and SFLastModifiedDate < WPTSLastUpdatedDate

	DECLARE @NewJobs TABLE (WPTSReportId int)

	INSERT INTO @NewJobs
	SELECT e.WPTSReportId
	FROM JobInformationETL e (NOLOCK) 
	LEFT JOIN Jobs j (NOLOCK) ON j.ReportId = e.WPTSReportId
	WHERE j.ReportId IS NULL

	INSERT INTO Jobs (JobId, ReportId, BranchPlant, CustomerId, JobNumber, StartDate, EndDate, LocationCountry, Rig, JarWell, Offshore, Coordinator,
			Longitude, Latitude, DispatchNumber, CreateUserId, CreateDate, WFTUserName, SFCreatedDate, SFLastModifiedDate)
	SELECT 
			NEWID(),
			e.WPTSReportId, 
			ISNULL(e.BranchPlant,0), 
			--j.CustomerName,
			(SELECT top 1 CustomerId FROM Customers c WHERE c.CustomerName = e.CustomerName) [CustomerId], 
			ISNULL(e.JobNumber, e.WPTSreportId), 
			e.StartDate, 
			e.EndDate, 
			e.LocationCountry, 
			e.Rig, 
			WellName, 
			e.OffShore, 
			e.Coordinator, 
			e.Longitude,
			e.Latitude, 
			0, --JDEDeliveryTicketNumber, 
			1, -- System
			GETDATE(),
			e.WFTUserName, 
			WPtsCreateDate, 
			WPTSLastUpdatedDate
	FROM JobInformationETL e (NOLOCK) 
	WHERE WPTSReportId in (SELECT WPTSReportId FROM @NewJobs)
	--and WPTSReportId = '1308643'

	INSERT INTO Wells (WellId, JobId, Well, IsDeleted)
	SELECT 
		NEWID(), 
		j.JobId, 
		e.WellName,
		0 IsDeleted
	FROM JobInformationETL e (NOLOCK) 
	JOIN Jobs j (NOLOCK) ON j.ReportId = e.WPTSReportId
	LEFT JOIN Wells w (NOLOCK) ON w.JobId = j.JobId and e.WellName = w.Well
	WHERE j.SalesforceId IS NULL AND w.WellID IS NULL

	INSERT INTO Runs (RunId, WellId, RunNumber, ReportNumber, StartDate, EndDate, OperHrs)
	SELECT NEWID(), w.WellID, '01', '01', e.Startdate, e.EndDate, e.OperatingHours
	FROM JobInformationETL e (NOLOCK) 
	JOIN Jobs j (NOLOCK) ON j.ReportId = e.WPTSReportId
	JOIN Wells w (NOLOCK) ON w.JobID = j.JobId and e.WellName = w.Well
	LEFT JOIN Runs r (NOLOCK) ON r.WellId = w.WellId
	WHERE j.SalesforceId IS NULL AND r.RunID IS NULL

	INSERT INTO Incidents
		(IncidentID
		,RunID
		,IncidentNumber
		,CreateDate
		,FailureDate
		,FieldSummary
		,FieldSurfCheckSummary
		,ImportUserID
		,ImportDate
		,IsDeleted
		,Criticality
		,CPARId)
	
	SELECT NEWID(), 
	*
	FROM
	(SELECT DISTINCT 
		r.RunID,
		e.CPARId [IncidentNumber],
		GETDATE() [CreateDate],
		e.FailureDate,
		null FailureDescription,
		null FieldSymptom,
		1 [ImportUserID],
		GETDATE() [ImportDate],
		0 [IsDeleted],
		e.PriorityCode,
		e.CPARId
	FROM EquipmentETL e 
	JOIN Jobs (NOLOCK) j ON j.ReportId = e.WPTSReportId
	JOIN Wells (NOLOCK) w ON w.JobID = j.JobId
	JOIN Runs (NOLOCK) r ON r.WellID = w.WellID
	LEFT JOIN Incidents i ON i.CPARId = e.CPARId
	WHERE i.IncidentID IS NULL
	) A

	INSERT INTO ToolStrings
	(ToolStringId, SerialNumber, Description, CreatedBy, CreateDate, CreateUserId, IsDeleted, CPARId)
	SELECT NEWID(), *
	FROM
	(
	SELECT DISTINCT 
		CASE WHEN ISNULL(e.GroupName,'') = '' OR e.GroupName = '00000000-0000-0000-0000-000000000000' THEN 'Default' ELSE e.GroupName END  [SerialNumber],
		'WPTS' [Description],
		1 CreatedBy,
		CPARDate,
		1 [CreateUserId],
		0 IsDeleted,
		e.CPARId
	FROM EquipmentETL e 
	JOIN Jobs (NOLOCK) j ON j.ReportId = e.WPTSReportId
	JOIN Wells (NOLOCK) w ON w.JobID = j.JobId
	JOIN Runs (NOLOCK) r ON r.WellID = w.WellID
	JOIN Incidents i ON i.CPARId = e.CPARId
	LEFT JOIN ToolStrings t ON t.CPARId = e.CPARId and t.SerialNumber = e.GroupName
	WHERE t.ToolStringId IS NULL
	) A

	INSERT INTO ToolStringComponentInfo
	(ToolStringInfoID, ToolStringId, SerialNum, RunID, IncidentID, 
	TFF, CSI, NCI, OS, PR, LostTime, FixedAssetID, CompFailureCodeID, OutOfSpecCodeID, ProceduralCodeID, 
	FailureDesc, CorrectiveAction, FieldSymptom, CPARId)
	SELECT NEWID(), *
	FROM
	(
	SELECT DISTINCT 
		t.ToolStringId, f.SerialNum, r.RunID, i.IncidentID,
	e.TFF, e.CSI, e.NCI, e.OS, e.PR, e.NPTHours, e.FixedAssetID, e.EquipmentCodeId, e.OutOfSpecCodeID, e.ProceduralCodeID, 
	CONVERT(VARCHAR(MAX), FailureDesc) [FailureDesc], CONVERT(VARCHAR(MAX), e.CorrectiveAction) [CorrectiveAction], CONVERT(VARCHAR(MAX), e.FieldSymptom) [FieldSymptom], e.CPARId
	FROM EquipmentETL e 
	JOIN Jobs (NOLOCK) j ON j.ReportId = e.WPTSReportId
	JOIN Wells (NOLOCK) w ON w.JobID = j.JobId
	JOIN Runs (NOLOCK) r ON r.WellID = w.WellID
	JOIN Incidents i ON i.CPARId = e.CPARId
	JOIN ToolStrings t ON t.CPARId = e.CPARId and t.SerialNumber = e.GroupName
	Join FixedAssets f ON f.fixedAssetId = e.FixedAssetId
	LEFT JOIN ToolStringComponentInfo tsc ON tsc.CPARId = e.CPARId and tsc.FixedAssetID = e.FixedAssetId
	WHERE tsc.ToolStringId IS NULL
	) A

ROLLBACK TRAN