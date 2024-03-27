use WPTS_DataMart;

-- finds the equipment that is to blame and assigns the NPT to the proper PL
SELECT
b.*, jobs.wellname AS 'WellName_Jobs'
--drop table tempNew
into tempNew
FROM
(
	SELECT 
	gpi1.IncidentID [WPTSIncidentId]
	,runs.[WptsReportId]
	,COALESCE(cost.CustAgreedNPTHours, cost.NPTHours, SUM(eqp.NPTHours)) [NPTHours]
	,MAX(CASE /*case to determine product line*/
				WHEN ToolStrings.[Type] in ('CMP', 'EM', 'EM/HYPERPULSE', 'GEOLINK', 'HEL/EM', 'HYPERPULSE', /*'SURFACE',*/ 'Tensor', 'WPR', 'BECFIELD', 'DMT/AMS') THEN 'MWD'
				WHEN ToolStrings.[Type] in ('AGS', 'ML', 'MOTOR') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'DIR') THEN 'DD'
				WHEN ToolStrings.[Type] in ('GWD', 'Hel/LWD') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'LWD') THEN 'LWD'
				WHEN ToolStrings.[Type] in ('RSS') OR (ToolStrings.[Type] in ('SURFACE') AND FixedAssets.toolpanel = 'RSS') THEN 'RSS'
				WHEN ToolStrings.[Type] in ('SURFACE') THEN 'MWD'
				ELSE NULL 
				END) [ProductLine],
	runs.Well [WellName_MyAdvisor],
	gpi1.WellName [WellName_CPAR],
	'ToolType' [QueryType]

	FROM [DisJobHistory].[dbo].[Equipment] Eqp (NOLOCK)
	LEFT JOIN [DisJobHistory].[dbo].[EquipmentGroup]  (NOLOCK) EqpGrp ON Eqp.EquipmentGroup = EqpGrp.[GroupId]
	LEFT JOIN [DisJobHistory].[dbo].[FixedAssets] (NOLOCK) ON FixedAssets.FixedAssetId = Eqp.FixedAsstId
	LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[ToolStrings] ON ToolStrings.SerialNumber = EqpGrp.GroupName
	LEFT JOIN [DisJobHistory].[dbo].gpi1  (NOLOCK) ON gpi1.IncidentID = Eqp.[WPTSIncidentId]
	LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[Incidents] RIL (NOLOCK) ON RIL.CPARID = Eqp.[WPTSIncidentId]
	LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[vwRelBusinessIntelligenceDataSet] runs ON runs.runid = ril.runid
	LEFT JOIN [DisJobHistory].dbo.CostofFailure [cost] (NOLOCK) on gpi1.IncidentID = cost.IncidentID

	WHERE --[FixedAssets].ProductLine = 1 -- DS Tools only
		isnull(Eqp.[WPTSIncidentId], 0) <> 0
		AND (gpi1.IsDeleted = 0 or gpi1.IsDeleted is null)
		AND (ToolStrings.[Type] IS NOT NULL)

	GROUP BY gpi1.IncidentID, cost.CustAgreedNPTHours, cost.NPTHours, runs.[WptsReportId], runs.Well, gpi1.wellname

UNION ALL

-- If not tool types are found from the equipment, or the equipment tab has a procedure failure due to no equipment at fault, it grabs the PL from runs and divides the NPT up among the PLs
	SELECT 
	[WPTSIncidentId]
	,[WptsReportId]
	,([NPTHours] / CASE WHEN [plCount] = 0 THEN 1 ELSE [plCount] END) AS [NPTHours]
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

		FROM [DisJobHistory].[dbo].[Equipment] Eqp (NOLOCK) 
		LEFT JOIN [DisJobHistory].[dbo].gpi1 (NOLOCK) ON gpi1.IncidentID = Eqp.[WPTSIncidentId]
		LEFT JOIN [DisJobHistory].[dbo].[EquipmentGroup] EqpGrp (NOLOCK) ON Eqp.EquipmentGroup = EqpGrp.[GroupId]
		LEFT JOIN [DisJobHistory].[dbo].[FixedAssets] (NOLOCK) ON FixedAssets.FixedAssetId = Eqp.FixedAsstId
		LEFT JOIN [DisJobHistory].dbo.CostofFailure [cost] (NOLOCK) on gpi1.IncidentID = cost.IncidentID
		LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[Incidents] RIL ON RIL.CPARID = Eqp.[WPTSIncidentId]
		LEFT JOIN [USDCALADBPD001].[AesOps].[dbo].[vwRelBusinessIntelligenceDataSet] runs ON runs.runid = ril.runid

		WHERE --[FixedAssets].ProductLine = 1 -- DS Tools only
				isnull(Eqp.[WPTSIncidentId], 0) <> 0
				AND (gpi1.IsDeleted = 0 or gpi1.IsDeleted is null)
				AND ISNULL(runs.TFFToolString,'') = ''

		GROUP BY Eqp.[WPTSIncidentId]
				,runs.[WptsReportId]
				,WellName
				,Well
				,runs.AllMWD
				,runs.MotorWFT
				,runs.RSS
				,runs.LWD,
				cost.CustAgreedNPTHours, 
				cost.NPTHours

	) A
	unpivot
	(
		PL FOR R IN (AllMWD, MotorWFT, RSS, LWD)
	) AS unPiv
	WHERE PL = 1
) b
LEFT JOIN [DisJobHistory].dbo.HdrProfile jobs ON jobs.reportid = b.[WptsReportId]
LEFT JOIN [DisJobHistory].dbo.gpi1 cpars on cpars.IncidentID = WPTSIncidentId
LEFT JOIN [DisJobHistory].dbo.CostofFailure [cost] on cost.IncidentID = cpars.IncidentID

--WHERE WPTSIncidentId = 3797490



GO


select p.WPTSIncidentId, p.NPTHours, n.WPTSIncidentId, n.NPTHours 
from ( select WPTSIncidentId, SUM(NPTHours) [NPTHours] from tempPrev group by WPTSIncidentId) p 
left join ( select WPTSIncidentId, SUM(NPTHours) [NPTHours] from tempNew group by WPTSIncidentId) n on p.WPTSIncidentId = n.WPTSIncidentId
where p.NPTHours != isnull(n.NPTHours,0)
order by 1 desc;