USE [AesOps]
GO
/****** Object:  StoredProcedure [dbo].[usp_CBM_ImportOneViewHoursForWireline]    Script Date: 11/1/2023 11:18:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_CBM_ImportOneViewHoursForWireline]
AS 
BEGIN
	--Fetch newly created records from wireline oneview app
	INSERT INTO dbo.Runs_Wireline
	SELECT f.FixedAssetId, 
			duration.JobId, 
			duration.FinancialSystemId,
			duration.ServiceOrder,
			duration.RigName,
			a.attrVal BranchPlant,
			c.jdeCompanyID [CustomerId],
			duration.JobOperationId,
			duration.OperationType,
			duration.JdeAssetNumber,
			duration.Operation_Duration_Minutes,
			duration.Operation_Duration_Minutes / 60.0 [Operation_Duration_Hours],
			duration.DateUploaded,
			duration.jobOperationEndTime as OperationEndTime,
			getdate() as DateAdded, 
			GETDATE() as UpdatedOn
	FROM USDCSHRSQLPD005.oneview.dbo.OneView_Job_JobOperations_assets_w_duration_for_MyAdvisor duration (NOLOCK)
	JOIN FixedAssets f (NOLOCK) on duration.JdeAssetNumber = f.AssetNumber
	JOIN USDCSHRSQLPD005.oneview.dbo.Job j (NOLOCK) on j.jobID = duration.jobID
	LEFT JOIN USDCSHRSQLPD005.oneview.dbo.Company c (NOLOCK) on c.oneViewCompanyID = j.oneViewCompanyID

	--below is taken from view vOperationalTree in OneView system
	LEFT JOIN (select a.gwis_locationid, 
				a.value as attrVal
		FROM USDCSHRSQLPD005.oneview.dbo.Gwis_Location l 
			INNER JOIN USDCSHRSQLPD005.oneview.dbo.gwis_locationattributes a ON (l.gwis_locationid=a.gwis_locationid AND a.GWIS_LocationRelationTypeID=1 
							AND a.GWIS_LocationAttributeValueID=38 AND (a.deleted IS NULL OR a.deleted=0))
			JOIN (SELECT m.value as value, m.GWIS_LocationAttributeID FROM USDCSHRSQLPD005.oneview.dbo.GWIS_LocationAttributeMatrix m 
						WHERE m.GWIS_LocationAttributeValueID=96) as dispOv ON dispOv.GWIS_LocationAttributeID=a.GWIS_LocationAttributeID
		WHERE (dispOv.value = '1')) a on j.operationalLocationID = a.GWIS_LocationID

	LEFT JOIN Runs_Wireline r on duration.jobOperationID = r.jobOperationID and f.FixedAssetId = r.FixedAssetId
	WHERE duration.JobStatusId IN (1, 5, 9, 10, 11, 13) AND duration.JdeAssetNumber > 0
	and duration.DateUploaded > DATEADD(MONTH, -6, GETDATE())
	and r.FixedAssetId IS NULL

	-- update any modifications made to runs information in last 6 months
	UPDATE r
	SET r.Operation_Duration_Minutes = duration.Operation_Duration_Minutes,
	r.FinancialSystemId = duration.FinancialSystemId,
	r.ServiceOrder = duration.ServiceOrder,
	r.RigName = duration.RigName,
	r.BranchPlant = a.attrVal,
	r.[CustomerId] = c.jdeCompanyID,
	r.OperationEndTime = duration.jobOperationEndTime
	FROM USDCSHRSQLPD005.oneview.dbo.OneView_Job_JobOperations_assets_w_duration_for_MyAdvisor duration
	JOIN FixedAssets f (NOLOCK) on duration.JdeAssetNumber = f.AssetNumber
	JOIN USDCSHRSQLPD005.oneview.dbo.Job j (NOLOCK) on j.jobID = duration.jobID
	LEFT JOIN USDCSHRSQLPD005.oneview.dbo.Company c (NOLOCK) on c.oneViewCompanyID = j.oneViewCompanyID

	--below is taken from view vOperationalTree in OneView system
	LEFT JOIN (select a.gwis_locationid, 
				a.value as attrVal
		FROM USDCSHRSQLPD005.oneview.dbo.Gwis_Location l 
			INNER JOIN USDCSHRSQLPD005.oneview.dbo.gwis_locationattributes a ON (l.gwis_locationid=a.gwis_locationid AND a.GWIS_LocationRelationTypeID=1 
							AND a.GWIS_LocationAttributeValueID=38 AND (a.deleted IS NULL OR a.deleted=0))
			JOIN (SELECT m.value as value, m.GWIS_LocationAttributeID FROM USDCSHRSQLPD005.oneview.dbo.GWIS_LocationAttributeMatrix m 
						WHERE m.GWIS_LocationAttributeValueID=96) as dispOv ON dispOv.GWIS_LocationAttributeID=a.GWIS_LocationAttributeID
		WHERE (dispOv.value = '1')) a on j.operationalLocationID = a.GWIS_LocationID

	JOIN Runs_Wireline r on duration.jobOperationID = r.jobOperationID and f.FixedAssetId = r.FixedAssetId
	WHERE duration.JobStatusId IN (1, 5, 9, 10, 11, 13) AND duration.JdeAssetNumber > 0
	and r.Operation_Duration_Minutes != duration.Operation_Duration_Minutes
	and duration.DateUploaded > DATEADD(MONTH, -6, GETDATE())

	SELECT DISTINCT f.FixedAssetId, duration.JdeAssetNumber, duration.operation_duration_minutes, duration.DateUploaded
	INTO #tempDurations
	FROM Runs_Wireline duration
	join FixedAssets f (NOLOCK) on duration.JdeAssetNumber = f.AssetNumber
	--where duration.JobStatusId IN (1, 5, 9, 10, 11, 13) and duration.JdeAssetNumber > 0 and DateUploaded is not null


	INSERT INTO CBMCalculatedMeterReadings (FixedAssetId, MeterReadingTypeId, UpdatedOn, CBMMonitorId)
	SELECT f.FixedAssetId, m.MeterReadingTypeId, getdate(), m.CBMMonitorId
	FROM CBMMonitor m (NOLOCK)   
	JOIN CBMMonitorAssetItemNums p (NOLOCK) on p.CBMMonitorId = m.CBMMonitorId and p.IsParent = 1  and m.Active = 1
	JOIN CBMMonitorAssetItemNums C (NOLOCK) ON c.CBMMonitorId = m.CBMMonitorId and c.IsParent = 0  
	JOIN FixedAssets f (NOLOCK) ON c.ItemNum = f.InventoryItemNum
	JOIN FixedAssets f1 (NOLOCK) ON f1.FixedAssetId = ISNULL(f.TopLevelFixedAssetId, f.FixedAssetId) AND f1.InventoryItemNum = p.ItemNum
	JOIN (SELECT distinct FixedAssetId from #tempDurations)  r on f.FixedAssetId = r.FixedAssetId
	LEFT JOIN CBMCalculatedMeterReadings cr (NOLOCK) on f.FixedAssetId = cr.FixedAssetId and m.CBMMonitorId = cr.CBMMonitorId
	where m.MeterReadingTypeId = 1 and cr.Id is null 

	SELECT r.FixedAssetId, r.CBMMonitorId, ISNULL(MAX(s.dateadded), [MaintenanceDate]) [MaintenanceDate]
	INTO #tempMaintenanceInfo
	FROM (SELECT DISTINCT jdeassetnumber as assetnumber from Runs_Wireline) c
	JOIN FixedAssets f on f.AssetNumber = c.assetnumber
	JOIN CBMCalculatedMeterReadings r on f.FixedAssetId = r.FixedAssetId and r.MeterReadingTypeId = 1
	LEFT JOIN PFTWO w on r.LastPFTWOId = w.PFTWOId
	LEFT JOIN PFTWOSeq s on s.PFTWOId = w.PFTWOId
	LEFT JOIN (SELECT jdeassetnumber, max([last maintenance date]) [MaintenanceDate]
				FROM aesimport.dbo.Wireline_LastScheduleMaintenancePerformed
				GROUP BY jdeassetnumber) tops ON tops.jdeassetnumber = f.AssetNumber
	--WHERE f.SerialNum ='CRMB127'
	GROUP BY r.FixedAssetId, r.CBMMonitorId, tops.[MaintenanceDate]

	select c.CBMMonitorId, c.FixedAssetId, 
		SUM(CASE WHEN ISNULL(CONVERT(datetime, maintenance.MaintenanceDate), f.DateAdded) < durations.DateUploaded THEN durations.operation_duration_minutes ELSE 0 END) * 1.0 /60 [DurationInHour], 
		SUM(durations.operation_duration_minutes) * 1.0 /60 [LifeTimeDurationInHour]
	INTO #tempReading
	FROM CBMCalculatedMeterReadings c
	join FixedAssets f on c.FixedAssetId = f.FixedAssetId and c.MeterReadingTypeId = 1
	LEFT JOIN #tempMaintenanceInfo maintenance on maintenance.FixedAssetId = f.FixedAssetId and c.CBMMonitorId = maintenance.CBMMonitorId
	JOIN (SELECT * FROM #tempDurations) durations on c.FixedAssetId = durations.FixedAssetId
	GROUP BY c.CBMMonitorId, c.FixedAssetId

	UPDATE c
	SET LastMeterReadingValue = r.DurationInHour,
		LifeTimeValue = r.LifeTimeDurationInHour
	FROM CBMCalculatedMeterReadings c
	JOIN #tempReading r on c.CBMMonitorId = r.CBMMonitorId and c.FixedAssetId = r.FixedAssetId


	DROP TABLE #tempDurations
	DROP TABLE #tempReading
	DROP TABLE #tempMaintenanceInfo

END