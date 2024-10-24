SELECT t.jdeassetnumber, 
t.sapid, 
tpcv.toolcodetypeid, 
tpcv.toolpaneltypeid, 
tpcv.version, 
t.serialnumber, 
tpcv.description, 
tpcv.shortdescription ,
division."name" as "Division", 
tpcv.partnumber, 
tpcv.jdelinenumber as "S Line Number", 
cat.name as "Asset Categorization",
(SELECT s.bptopsdisplayname 
	FROM ToolTransfer transfer 
	left join station s  on transfer.receivestationid  = s.id 
	left join locatio
	where transfer.ToolID = t.id and transfer.ToolTransferStatusID in ( 1, 5, 17, 3, 6, 19, 4, 10, 18, 13, 14, 20, 21, 7, 22, 8, 24, 9, 23) 
	order by transfer.id desc
	limit 1
) as "Received Location"
FROM tool t
JOIN toolpanelcodeversion tpcv on t.toolpanelcodeversionid = tpcv.id
JOIN public.toolclass tc on tpcv.toolclassid = tc.id
JOIN tooldivision division on t.tooldivisionid = division.id 
JOIN toolcategorization cat on cat.id  = tpcv.categorization 
WHERE  tc.id IN (6, 11) 
and t.serialnumber ='40007-7763/110846';