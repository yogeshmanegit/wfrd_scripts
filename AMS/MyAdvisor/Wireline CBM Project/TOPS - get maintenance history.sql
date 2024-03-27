

select tr.RepairID, t.toolcodetypeid, t.serialnumber, t.jdeassetnumber, pmt.name as "PM Type", TO_TIMESTAMP(tr.lastmodifiedat, 'YYYY-MM-DD') as "Maintainance Date"
FROM tool t
JOIN ToolHistory th on t.Id = th.ToolID 
JOIN PMRule pmr on th.PMRuleID = pmr.Id 
JOIN PMType pmt on pmr.PMTypeID = pmt.Id
JOIN ToolRepair tr on th.RepairID = tr.RepairID and tr.RepairComplete = 1
where serialnumber ='UCCA172' and pmt.name in ('LTP', 'LTP-2', 'CERT', 'MCERT', 'WIPE', 'CAL');


select t.toolcodetypeid, t.serialnumber, 
t.jdeassetnumber, pmt.name as "PM Type", pmr.MaxDays,
MAX(tr.lastmodifiedat) as lastmodifiedate
--TO_TIMESTAMP(tr.lastmodifiedat, 'YYYY-MM-DD') as "Maintainance Date"
FROM tool t
JOIN ToolHistory th on t.Id = th.ToolID 
JOIN PMRule pmr on th.PMRuleID = pmr.Id 
JOIN PMType pmt on pmr.PMTypeID = pmt.Id
JOIN ToolRepair tr on th.RepairID = tr.RepairID and tr.RepairComplete = 1
where 1 = 1 
	--and serialnumber ='UCCA172' 
	and pmt.name in ('LTP', 'LTP-2', 'CERT', 'MCERT', 'WIPE', 'CAL')
    and jdeassetnumber > 0
group by t.toolcodetypeid, t.serialnumber, t.jdeassetnumber, pmt.name , pmr.MaxDays;


SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema'
order by tablename;