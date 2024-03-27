select i.IncidentId	
, cpar.IncidentID as CparId	
, i.CreateDate	
, e.FixedAsstId	
, e.NPTHours [WPTS NPT]	
, e.NCI [WPTS NCI]	
, e.NPT [WPTS NPT]	
, e.TFF [WPTS TFF]	
, e.CSI [WPTS CSI] 	
	
, tsc.LostTime [MyAdv NPT]	
, tsc.NCI [MyAdv NCI]	
, tsc.TFF [MyAdv TFF]	
, tsc.CSI [MyAdv CSI] 	
	
, CASE WHEN (e.NPTHours != CONVERT(DECIMAL(18,2), ISNULL(tsc.LostTime, 0) OR e.CSI != tsc.csi OR e.TFF != tsc.TFF )
	THEN 1
	ELSE 0 END [Not Matching]
from gpi1 cpar
join Equipment e on cpar.IncidentID = e.WPTSIncidentId 
JOIN USDCALADBPD001.aesops.dbo.Incidents i on i.cparid = cpar.IncidentID
JOIN USDCALADBPD001.aesops.dbo.toolstringcomponentInfo tsc on tsc.RunId = i.Runid and tsc.fixedassetid = e.FixedAsstId
where 1 = 1
and (e.NPTHours > 0 OR CONVERT(DECIMAL(18,2), ISNULL(tsc.LostTime, 0)) > 0 OR e.TFF != 0 OR tsc.TFF != 0 OR e.CSI != 0 OR tsc.csi != 0)
and YEAR(cpar.ReportDate) > 2022