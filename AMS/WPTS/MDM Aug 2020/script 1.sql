use OFIs;

select top 10 * from LocationMDMStructure2020
SELECT top 10 * from ProductLineMDMStructure2020

select * 
FROM (select distinct L3Code, L3Name, L2Code, L2Name, L1Code, L1Name from vw_OrgDataLevel) c
LEFT JOIN  (select distinct L3Code, L3Name from vw_OrgDataLevelMDM2020) n on c.L3Code = n.L3Code
LEFT JOIN (select distinct L2Code, L2Name from vw_OrgDataLevelMDM2020) n2 on c.L2Code = n2.L2Code
where n.L3Code is null and n2.L2Code is not null
order by c.L2Code, c.L3Code

select * from OrgDataLevel2 where MDMLevel2Code ='GPL_ALS'

select 
l.L1Id, l.L1Code, l.L1Name, m.L1Code, m.L1Name 
,l.L2Id, l.L2Code, l.L2Name, m.L2Code, m.L2Name 
,l.L3Id, l.L3Code, l.L3Name, m.L3Code, m.L3Name
,l.L4Id, l.L4Code, l.L4Name, m.L4Code, m.L4Name 
from vw_OrgDataLevel l
join vw_OrgDataLevelMDM2020 m on l.L4Code = m.L4Code
where l.L1Code != m.L1Code or l.L2Code != m.L2Code or l.L3Code != m.L3Code
OR l.L1Name != m.L1Name 
--OR l.L2Name != m.L2Name 
--OR l.L3Name != m.L3Name 
OR l.L4Name != m.L4Name

select  l.*
from vw_OrgDataLevelMDM2020 l
left join vw_OrgDataLevel m on l.L4Code = m.L4Code
where m.L4Code is null --and l.L1Code not in ('CMPD', 'DEI', 'OTHER')
order by l.L1Code, l.L2Code, l.L3Code, l.L4Code

select  l.*
from vw_OrgDataLevel l
where l.L1Code not in ('CMPD', 'DEI', 'OTHER')

select 
--'INSERT INTO OrgDataLevel4 (MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnableInJobList, Active) VALUES ('
--+ '''' + l.L4Code +''','
--+ '''' + l.L4Name +''','
--+ CONVERT(varchar(10), (SELECT l3.Level3ID FROM OrgDataLevel3 l3 WHERE l3.MDMLevel3Code = l.L3Code)) +','
--+ '''' + l.L3Code +''','
--+ '1, 1, 1'
--+ ')',
m.Level4ID, (SELECT l3.Level3ID FROM OrgDataLevel3 l3 WHERE l3.MDMLevel3Code = l.L3Code) [Level3id], l.*
from vw_OrgDataLevelMDM2020 l
LEFT join OrgDataLevel4 m on ISNULL(l.L5Code, l.L4Code) = m.MDMLevel4Code
where m.Level4ID IS NULL and l.L4Code is not null --and l.L3Code is not null
order by m.Level4ID, l.L1Code, l.L2Code, l.L3Code, l.L4Code