

select tr.RepairID, t.toolcodetypeid, t.serialnumber, t.jdeassetnumber, pmt.name as "PM Type", TO_TIMESTAMP(tr.lastmodifiedat, 'YYYY-MM-DD') as "Maintainance Date"
FROM tool t
JOIN ToolHistory th on t.Id = th.ToolID 
JOIN PMRule pmr on th.PMRuleID = pmr.Id 
JOIN PMType pmt on pmr.PMTypeID = pmt.Id
JOIN ToolRepair tr on th.RepairID = tr.RepairID and tr.RepairComplete = 1
where serialnumber ='UCCA172' and pmt.name in ('LTP', 'LTP-2', 'CERT', 'MCERT', 'WIPE', 'CAL');


SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema'
order by tablename;