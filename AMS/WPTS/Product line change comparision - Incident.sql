SELECT 
pl1.Level1Name [Current Group], 
pl2.Level2Name [Current Segment],
pl3.Level3Name [Current Prodcut Line],
pl4.Level4Name [Current Product Services],
ql1.Level1Name [New Group], 
ql2.Level2Name [New Segment],
ql3.Level3Name [New Prodcut Line],
ql4.Level4Name [New Product Services],
count(1) as [Count]
FROM
(
SELECT g1.Level1ID as [ProdLevel1ID],
g1.Level2ID as [ProdLevel2ID],
g1.Level3ID as [ProdLevel3ID],
g1.Level4ID as [ProdLevel4ID],
g.Level1ID as [QALevel1ID],
g.Level2ID as [QALevel2ID],
g.Level3ID as [QALevel3ID],
g.Level4ID as [QALevel4ID]

FROM DisJobHistoryINT1.dbo.gpi1 g
LEFT JOIN OFIs.dbo.gpi1 g1 ON g.IncidentID = g1.IncidentID
WHERE YEAR(g.ReportDate) >= 2017 and g.ReportDate < '2022-03-31'
) A
LEFT JOIN OFIs.dbo.OrgDataLevel4 pl4 on pl4.Level4ID = a.ProdLevel4ID
LEFT JOIN OFIs.dbo.OrgDataLevel3 pl3 on pl3.Level3ID = pl4.Level3ID
LEFT JOIN OFIs.dbo.OrgDataLevel2 pl2 on pl2.Level2ID = pl3.Level2ID
LEFT JOIN OFIs.dbo.OrgDataLevel1 pl1 on pl1.Level1ID = pl2.Level1ID
LEFT JOIN DisJobHistoryINT1.dbo.OrgDataLevel4 ql4 on ql4.Level4ID = a.QALevel4ID
LEFT JOIN DisJobHistoryINT1.dbo.OrgDataLevel3 ql3 on ql3.Level3ID = ql4.Level3ID
LEFT JOIN DisJobHistoryINT1.dbo.OrgDataLevel2 ql2 on ql2.Level2ID = ql3.Level2ID
LEFT JOIN DisJobHistoryINT1.dbo.OrgDataLevel1 ql1 on ql1.Level1ID = ql2.Level1ID
where pl1.Level1ID is not null
group by pl1.Level1Name, pl2.Level2Name, ql1.Level1Name, ql2.Level2Name,ql3.Level3Name,ql4.Level4Name,pl3.Level3Name,pl4.Level4Name
ORDER BY pl1.Level1Name
, pl2.Level2Name 
, pl3.Level3Name 
, pl4.Level4Name 
, ql1.Level1Name 
, ql2.Level2Name 
, ql3.Level3Name 
, ql4.Level4Name 

