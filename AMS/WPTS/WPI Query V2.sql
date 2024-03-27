-- finds the equipment that is to blame and assigns the NPT to the proper PL
SELECT
b.WPTSIncidentId, b.WptsReportId, ProductLine, WellName_MyAdvisor, WellName_CPAR, QueryType, jobs.wellname AS 'WellName_Jobs', NPTHours

FROM
(
SELECT 
		CASE WHEN SUM(eqp.NPTHours) > 0 THEN COALESCE(cost.CustAgreedNPTHours, cost.NPTHours, SUM(eqp.NPTHours)) ELSE 0 END AS [NPTHours]
		,Eqp.[WPTSIncidentId]
		,runs.[WptsReportId]
		,CASE /*case to determine product line*/
			WHEN ToolStrings.[Type] in ('CMP', 'EM', 'EM/HYPERPULSE', 'GEOLINK', 'HEL/EM', 'HYPERPULSE', /*'SURFACE',*/ 'Tensor', 'WPR', 'BECFIELD', 'DMT/AMS') THEN 'MWD'
			WHEN ToolStrings.[Type] in ('AGS', 'ML', 'MOTOR') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'DIR') THEN 'DD'
			WHEN ToolStrings.[Type] in ('GWD', 'Hel/LWD') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'LWD') THEN 'LWD'
			WHEN ToolStrings.[Type] in ('RSS') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'RSS') THEN 'RSS'
			WHEN ToolStrings.[Type] in ('SURFACE') THEN 'MWD'
			ELSE NULL 
			END 
		AS [ProductLine]
		, runs.Well AS 'WellName_MyAdvisor'
		, gpi1.WellName AS 'WellName_CPAR'
		, 'ToolType' AS 'QueryType'

FROM [DisJobHistory].[dbo].[Equipment] Eqp
LEFT JOIN [DisJobHistory].[dbo].[EquipmentGroup] EqpGrp ON Eqp.EquipmentGroup = EqpGrp.[GroupId]
LEFT JOIN [DisJobHistory].[dbo].[FixedAssets] ON FixedAssets.FixedAssetId = Eqp.FixedAsstId
LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[ToolStrings] ON ToolStrings.SerialNumber = EqpGrp.GroupName
LEFT JOIN [DisJobHistory].[dbo].gpi1 ON gpi1.IncidentID = Eqp.[WPTSIncidentId]
LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[Incidents] RIL ON RIL.CPARID = Eqp.[WPTSIncidentId]
LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[vwRelBusinessIntelligenceDataSet] runs ON runs.runid = ril.runid
LEFT JOIN [DisJobHistory].dbo.CostofFailure [cost] (NOLOCK) on gpi1.IncidentID = cost.IncidentID

WHERE --[FixedAssets].ProductLine = 1 -- DS Tools only
		isnull(Eqp.[WPTSIncidentId], 0) <> 0
		AND (gpi1.IsDeleted = 0 or gpi1.IsDeleted is null)
		AND (ToolStrings.[Type] IS NOT NULL)
		
GROUP BY Eqp.[WPTSIncidentId]
		,runs.[WptsReportId]
		,runs.Well
		,gpi1.WellName
		,CASE /*case to determine product line*/
			WHEN ToolStrings.[Type] in ('CMP', 'EM', 'EM/HYPERPULSE', 'GEOLINK', 'HEL/EM', 'HYPERPULSE', /*'SURFACE',*/ 'Tensor', 'WPR', 'BECFIELD', 'DMT/AMS') THEN 'MWD'
			WHEN ToolStrings.[Type] in ('AGS', 'ML', 'MOTOR') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'DIR') THEN 'DD'
			WHEN ToolStrings.[Type] in ('GWD', 'Hel/LWD') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'LWD') THEN 'LWD'
			WHEN ToolStrings.[Type] in ('RSS') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'RSS') THEN 'RSS'
			WHEN ToolStrings.[Type] in ('SURFACE') THEN 'MWD'
			ELSE NULL END
		,cost.CustAgreedNPTHours, cost.NPTHours

UNION ALL

-- If not tool types are found from the equipment, or the equipment tab has a procedure failure due to no equipment at fault, it grabs the PL from runs and divides the NPT up among the PLs
SELECT ([NPTHours] / CASE WHEN [plCount] = 0 THEN 1 ELSE [plCount] END) AS [NPTHours]
,[WPTSIncidentId]
,[WptsReportId]
,CASE   WHEN R = 'AllMWD' THEN 'MWD'
		WHEN R = 'MotorWFT' THEN 'DD'
		WHEN R = 'RSS' THEN 'RSS'
		WHEN R = 'LWD' THEN 'LWD'
		ELSE NULL
 END AS [ProductLine]
		,WellName_MyAdvisor
		,WellName_CPAR
,'RunType' AS 'QueryType'
FROM
(
SELECT 
		COALESCE(cost.CustAgreedNPTHours, cost.NPTHours, SUM(eqp.NPTHours)) AS [NPTHours]
		,runs.[WptsReportId]
		,Eqp.[WPTSIncidentId]
		,runs.Well AS 'WellName_MyAdvisor'
		,gpi1.WellName AS 'WellName_CPAR'
		,runs.AllMWD
		,runs.MotorWFT
		,runs.RSS
		,runs.LWD
		,ISNULL(runs.AllMWD, 0) + ISNULL(runs.MotorWFT, 0) + ISNULL(runs.RSS, 0) + ISNULL(runs.LWD, 0) AS [plCount]

FROM [DisJobHistory].[dbo].[Equipment] Eqp
LEFT JOIN [DisJobHistory].[dbo].[EquipmentGroup] EqpGrp ON Eqp.EquipmentGroup = EqpGrp.[GroupId]
LEFT JOIN [DisJobHistory].[dbo].[FixedAssets] ON FixedAssets.FixedAssetId = Eqp.FixedAsstId
LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[ToolStrings] ON ToolStrings.SerialNumber = EqpGrp.GroupName
LEFT JOIN [DisJobHistory].[dbo].gpi1 ON gpi1.IncidentID = Eqp.[WPTSIncidentId]
LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[Incidents] RIL ON RIL.CPARID = Eqp.[WPTSIncidentId]
LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[vwRelBusinessIntelligenceDataSet] runs ON runs.runid = ril.runid
LEFT JOIN [DisJobHistory].dbo.CostofFailure [cost] (NOLOCK) on gpi1.IncidentID = cost.IncidentID

WHERE --[FixedAssets].ProductLine = 1 -- DS Tools only
		isnull(Eqp.[WPTSIncidentId], 0) <> 0
		AND (gpi1.IsDeleted = 0 or gpi1.IsDeleted is null)
		AND ToolStrings.[Type] IS NULL
		
GROUP BY Eqp.[WPTSIncidentId]
		,runs.[WptsReportId]
		,WellName
		,Well
		,runs.AllMWD
		,runs.MotorWFT
		,runs.RSS
		,runs.LWD
		,cost.CustAgreedNPTHours, cost.NPTHours
) A
unpivot
(
PL FOR R IN (AllMWD, MotorWFT, RSS, LWD)
) AS unPiv

WHERE PL = 1

) B

LEFT JOIN [DisJobHistory].dbo.HdrProfile jobs ON jobs.reportid = b.[WptsReportId]
--WHERE b.WPTSIncidentId = 4076605