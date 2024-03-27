
select --e.NPTHours, e.TFF, e.CSI, tsc.LostTime, tsc.tff, tsc.csi, --tsc.*,
'UPDATE toolstringcomponentInfo SET LostTime = ' + CONVERT(varchar(10), e.NPTHours) + ', TFF = ' + convert(varchar(10), e.TFF) 
	+ ', CSI = ' + convert(varchar(10), e.CSI) + ', NCI = ' + convert(varchar(10), e.NCI) 
	+ ' WHERE ToolStringInfoId = ''' + CONVERT(VARCHAR(MAX), tsc.ToolStringInfoId) + ''';',
'UPDATE RelBusinessIntelligenceDataSet SET npt = ' + CONVERT(varchar(10), e.NPTHours) + ', TFF = ' + convert(varchar(10), e.TFF) 
	+ ', CSI = ' + convert(varchar(10), e.CSI) + ', NCI = ' + convert(varchar(10), e.NCI) 
+ ', NPTRun = ' + CASE WHEN e.NPTHours = 0 THEN '0' ELSE '1' END
+ ' WHERE WptsCparId = ''' + CONVERT(VARCHAR(MAX), cpar.IncidentID) + ''''
from gpi1 cpar
join Equipment e on cpar.IncidentID = e.WPTSIncidentId 
JOIN USDCALADBPD001.aesops.dbo.Incidents i on i.cparid = cpar.IncidentID
JOIN USDCALADBPD001.aesops.dbo.toolstringcomponentInfo tsc on tsc.RunId = i.Runid and tsc.fixedassetid = e.FixedAsstId
where 1 = 1
and (e.NPTHours > 0 OR CONVERT(DECIMAL(18,2), ISNULL(tsc.LostTime, 0)) > 0 OR e.TFF != 0 OR tsc.TFF != 0 OR e.CSI != 0 OR tsc.csi != 0 OR e.NCI != 0 OR tsc.nci != 0)
and YEAR(cpar.ReportDate) > 2022
AND (CASE WHEN (e.NPTHours != CONVERT(DECIMAL(18,2), ISNULL(tsc.LostTime, 0)) OR e.CSI != tsc.csi OR e.TFF != tsc.TFF OR e.NCI != tsc.NCI)
	THEN 0
	ELSE 1 END) = 0

select i.IncidentId	
, cpar.IncidentID as CparId	
, i.CreateDate	
, e.FixedAsstId	
, e.NPTHours [WPTS NPT]	
, e.NCI [WPTS NCI]	
--, e.NPT [WPTS NPT]	
, e.TFF [WPTS TFF]	
, e.CSI [WPTS CSI] 
	
, tsc.LostTime [MyAdv NPT]	
, tsc.NCI [MyAdv NCI]	
, tsc.TFF [MyAdv TFF]	
, tsc.CSI [MyAdv CSI]

, CASE WHEN (e.NPTHours != CONVERT(DECIMAL(18,2), ISNULL(tsc.LostTime, 0)) OR e.CSI != tsc.csi OR e.TFF != tsc.TFF OR e.NCI != tsc.NCI)
	THEN 0
	ELSE 1 END [Matching]
from gpi1 cpar
join Equipment e on cpar.IncidentID = e.WPTSIncidentId 
JOIN USDCALADBPD001.aesops.dbo.Incidents i on i.cparid = cpar.IncidentID
JOIN USDCALADBPD001.aesops.dbo.toolstringcomponentInfo tsc on tsc.RunId = i.Runid and tsc.fixedassetid = e.FixedAsstId
where 1 = 1
and (e.NPTHours > 0 OR CONVERT(DECIMAL(18,2), ISNULL(tsc.LostTime, 0)) > 0 OR e.TFF != 0 OR tsc.TFF != 0 OR e.CSI != 0 OR tsc.csi != 0 OR e.NCI != 0 OR tsc.nci != 0)
and YEAR(cpar.ReportDate) > 2022
AND (CASE WHEN (e.NPTHours != CONVERT(DECIMAL(18,2), ISNULL(tsc.LostTime, 0)) OR e.CSI != tsc.csi OR e.TFF != tsc.TFF OR e.NCI != tsc.NCI)
	THEN 0
	ELSE 1 END) = 0