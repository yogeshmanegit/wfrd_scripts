	DECLARE @Runs TABLE
	(
		JobNumber varchar(max),
		ReportId int,
		RunNo int,
		RunNumber varchar(100),
		RunId UniqueIdentifier
	)

	INSERT INTO @Runs
	SELECT r.JobNumber, 
		j.ReportId, 
		ROW_NUMBER () OVER (partition by r.jobnumber Order by r.Well, r.RunNumber ASC) [RunNo],
		r.RunNumber,
		r.RunId
FROM RelBusinessIntelligenceDataSet r
INNER JOIN Jobs J on r.JobNumber = j.JobNumber
WHERE r.JobNumber IN (SELECT DISTINCT JobNumber FROM RelBusinessIntelligenceDataSet Where OutHoleDate >= '2013-01-01')

--SELECT JobNumber, RunNo, COUNT(*) 
--FROM @Runs
--GROUP BY JobNumber, RunNo
--HAVING COUNT(*) > 2


--SELECT * FROM @Runs	
--ORDER By JobNumber, RunNo

	SELECT r.ReportId, 
	r.RunNo
	,v.JobNumber
	,r.ReportId [WptsReportId]
	,v.RunId
	,v.CustomerName
	,v.Rig
	,v.TFF
	,v.NCI
	,v.CSI
	,v.OS
	,v.PR
	,v.Others
	,v.GFA
	,v.NonTFFRun
	,v.NPT
	,v.NPTRun
	,v.NonNPTRun
	,v.NPTRunNoTFF
	,v.CIRunNoNPT
	,v.B2B
	,v.MaxTempF
	,v.MaxTempWindowF
	,v.MaxTempC
	,v.MaxTempWindowC
	,v.OperHrs
	,v.CircHrs
	,v.DrillHrs
	,v.CircHrsWindow
	,v.Less30CircHrEvents
	,v.Less30CircHr
	,v.LWD
	,v.HELEM
	,v.EM
	,v.PP
	,v.RSS
	,v.MotorWFT
	,v.RentalMotor
	,v.AllMWD
	,v.BECFIELD
	,v.TENSOR
	,v.GEOLINK
	,v.Well
	,v.RunNumber
	,v.RunNumberCnt
	,v.InHoleDate
	,v.EndDate
	,v.Greater30HrsNPTEvents
	,v.Greater30HrNPTHrs
	,v.Is3030
	,v.Non3030
	,v.MDStart
	,v.MDEnd
	,v.MDEndWindow
	,v.MDDistance
	,v.TVDStart
	,v.TVDEnd
	,v.HoleSize
	,v.HoleSizeWindow
	,v.MaxHydrostaticPressure
	,v.MaxOperPressure
	,v.MaxObservedPressure
	,v.MudDensity
	,v.BaseFluidEnd
	,v.MaxDoglegRotating
	,v.MaxDoglegRotatingWindow
	,v.MaxDoglegSliding
	,v.MaxDoglegSlidingWindow
	,v.MaxInc
	,v.FlowRate
	,v.MotorSerialNumber
	,v.MotorSize
	,v.MotorLength
	,v.MotorType
	,v.Manufacturer
	,v.LobesRS
	,v.MotorRPM
	,v.MotorOnBottom
	,v.MotorOffBottom
	,v.MotorDifferential
	,v.ToolSize
	,v.FieldSymptom
	,v.FieldSymptom2
	,v.RSSFailureTFF
	,v.RSSFailureCSI
	,v.RSSNPTnonTFF
	,v.TotalRSSNPTTFF
	,v.RSSOT
	,v.LWDFailureTFF
	,v.LWDFailureCSI
	,v.LWDNPTTFF
	,v.LWDNPTnonTFF
	,v.TotalLWDNPT
	,v.LWDOT
	,v.PRModes
	,v.PRNPT
	,v.AverageROP
	,v.RunLeadEngineers
	,v.RunEngineers
	,v.TVM
	,v.LWDDirOnly
	,v.LWDDirGam
	,v.LWDDirGamMFRCombo
	,v.LWDTripleCombo
	,v.LWDQuadCombo
	,v.EMDirOnly
	,v.EMDirGam
	,v.PPDirOnly
	,v.PPDirGam
	,v.TotalComponentCount
	,v.TotalCSICount
	,v.TotalNCICount
	,v.SolidPercentageMax
	,v.SandPercentageMax
	,v.WaterPercentageMax
	,v.OilPercentageMax
	,v.pHMax
	,v.RotatingHrs
	,v.ReasonsForPooh
	,v.WaterDepth
	,v.BitDeltaP
	,v.WeightOnBit
	,v.Torque
	,v.SurfaceRPM
	,v.UnderBalanced
	,v.GasFlowRate
	,v.SPP
	,v.OrificeSize
	,v.MotorFailureTFF
	,v.MotorFailureCSI
	,v.MotorNPTTFF
	,v.EMFailureTFF
	,v.EMFailureCSI
	,v.EMNPTTFF
	,v.PPFailureTFF
	,v.PPFailureCSI
	,v.PPNPTTFF
	,v.MWDFailureTFF
	,v.MWDFailureCSI
	,v.MWDNPTTFF
	,v.MWDOT
	,v.EMOT
	,v.HPOT
	,v.MotorOT
	,v.IncidentId
	,v.IncidentNumber
	,v.FieldSummary
	,v.FieldSymptomSummary
	,v.LoadDate
	,v.PulseCount
	,v.RSSRevolutions
	,v.ExtendedRange
	,v.Criticality
	,v.TOTALRSSNPT
	FROM vwdownhole2 (NOLOCK) v
	INNER JOIN @Runs r on r.RunId = v.RunId
	Where r.ReportId > 0
	ORDER BY r.JobNumber, r.RunNo

	SELECT 
	r.ReportId, 
	r.RunNo
	,v.JobNumber
	,v.RunNumber
	,v.TemplateName
	,v.ToolStringInfoID
	,v.FixedAssetID
	,v.AssetNumber
	,v.SerialNum
	,v.RNItemNum
	,v.InventoryItemNum
	,v.DescShort
	,v.RunID
	,v.CumulativeValveCycles
	,v.FailureDesc
	,v.IsUsed
	,v.CorrectiveAction
	,v.FieldSymptom
	,v.LostTime
	,v.TFF
	,v.CSI
	,v.NCI
	,v.OS
	,v.PR
	,v.FA
	,v.RC
	,v.CN
	,v.IncidentDate
	,v.CompFailureCode
	,v.OutOfSpecCodeID
	,v.ProceduralCodeID
	,v.FailedNonPartName
	,v.Revision
	,v.ToolCode
	,v.MasterFirmwareRevision
	,v.FailedNonPartType 
	FROM vwdownhole2Tools v (NOLOCK)
	INNER JOIN @Runs r on r.RunId = v.RunId
	Where r.ReportId > 0 
	Order by r.JobNumber, r.RunNo

	SELECT r1.ReportId,
		r1.[RunNo]
		, dbo.NumCheck(r.OperHrs) As OpHours
		, ISNULL(i.AcceptedLostTime, 0) as NPTHours
		--, w.WellID
		--, r1.RunNumber
	FROM Jobs j WITH(NOLOCK)
	INNER JOIN Wells w WITH(NOLOCK) ON w.JobID = j.JobID AND w.IsDeleted = 0
	INNER JOIN Runs r WITH(NOLOCK) ON r.WellID = w.WellID AND r.IsDeleted = 0 --AND r.IsDownhole = 1
	INNER JOIN @Runs r1 ON r.RunID = r1.RunId
	LEFT JOIN Incidents i WITH(NOLOCK) ON i.RunID = r.RunID AND i.IsDeleted = 0
	Where r1.ReportId > 0
	Order by j.JobNumber, r1.RunNo

DELETE FROM downhole2 WHere JobNumber IN ('11346332', '11346325', 'W7160003', 'MB160110','RE140025', 'RI140033')
DELETE FROM downhole2Tools WHere JobNumber IN ('11346332', '11346325', 'W7160003', 'MB160110','RE140025', 'RI140033')
DELETE FROM jobperfhours WHere ReportId in (836341, 737277, 672374, 546666)
