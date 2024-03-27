select * 
from (
select 
pl1.Level1Name [Current Group], 
pl2.Level2Name [Current Segment],
pl3.Level3Name [Current Product Line],
pl4.Level4Name [Current Product Services],
ql1.Level1Name [New Group], 
ql2.Level2Name [New Segment],
ql3.Level3Name [New Product Line],
ql4.Level4Name [New Product Services],
COUNT(*) [Total] 
from 
(
	SELECT * 
	FROM 
	(
		select 
			pdJobs.ReportID, pdValue.Value[PdLevel4Id]
		from 
			OFIs.dbo.HdrProfile (nolock) pdJobs
			join OFIs.dbo.UserChoiceKey pdKey (nolock) on pdjobs.ReportID = pdKey.ReportID 
				and pdKey.dbFieldID = 38032
			join OFIs.dbo.UserChoiceValue (nolock) pdValue on pdKey.[ID]= pdvalue.[Key]
			join OFIs.dbo.OrgDataLevel4 prodL4 (NOLOCK) on pdValue.Value = prodL4.Level4ID
			WHERE pdValue.[Value] <= (select MAX(level4Id) from OFIs.dbo.OrgDataLevel4)
			AND YEAR(pdJobs.JobStart) > 2017
			and pdjobs.ReportID <= 13165652
	) pd
) pd 
LEFT JOIN 
(
	SELECT * 
	FROM 
	(
		select qaJobs.ReportID, qaValue.Value[QaLevel4Id]
		from 
		DisJobHistoryINT1.dbo.HdrProfile (nolock) qaJobs
		join DisJobHistoryINT1.dbo.UserChoiceKey qaKey (nolock) on qaJobs.ReportID = qaKey.ReportID 
			and qaKey.dbFieldID = 38032
		join DisJobHistoryINT1.dbo.UserChoiceValue (nolock) qaValue on qaKey.[ID]= qavalue.[Key]
		where qaValue.[Value] <= (select MAX(level4Id) from OFIs.dbo.OrgDataLevel4)
		AND YEAR(qaJobs.JobStart) > 2017
	) qa
) qa on pd.ReportID = qa.ReportID and pd.PdLevel4Id = qa.QaLevel4Id

LEFT JOIN OFIs.dbo.OrgDataLevel4 (nolock) pl4 on pl4.Level4ID = pd.PdLevel4Id
LEFT JOIN OFIs.dbo.OrgDataLevel3 (nolock) pl3 on pl3.Level3ID = pl4.Level3ID
LEFT JOIN OFIs.dbo.OrgDataLevel2 (nolock) pl2 on pl2.Level2ID = pl3.Level2ID
LEFT JOIN OFIs.dbo.OrgDataLevel1 (nolock) pl1 on pl1.Level1ID = pl2.Level1ID

LEFT JOIN DisJobHistoryINT1.dbo.OrgDataLevel4 (nolock) ql4 on ql4.Level4ID = qa.qaLevel4Id
LEFT JOIN DisJobHistoryINT1.dbo.OrgDataLevel3 (nolock) ql3 on ql3.Level3ID = ql4.Level3ID
LEFT JOIN DisJobHistoryINT1.dbo.OrgDataLevel2 (nolock) ql2 on ql2.Level2ID = ql3.Level2ID
LEFT JOIN DisJobHistoryINT1.dbo.OrgDataLevel1 (nolock) ql1 on ql1.Level1ID = ql2.Level1ID
group by pl1.Level1Name, pl2.Level2Name, ql1.Level1Name, ql2.Level2Name,ql3.Level3Name,ql4.Level4Name,pl3.Level3Name,pl4.Level4Name
) A
WHERE a.[New Group] IS NOT NULL
ORDER BY [Current Group], [Current Segment], [Current Product Line], [Current Product Services],
[New Group], [New Segment], [New Product Line], [New Product Services]