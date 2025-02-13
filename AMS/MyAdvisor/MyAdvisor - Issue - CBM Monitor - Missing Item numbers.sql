
select case when aa.AuditTypeId = 2040 then 'Added' else 'Removed' end [Action], 
	aa.ActionDate, 
	u.LastName + ', ' + u.FirstName [Name],
	aa.UserId, a.ItemNum, case when IsParent =0 then 'Component' else 'Parent' end [Is Parent or Component] from auditCBMMonitorAssetItemNums a 
join AuditActions aa on a.AuditActionId = aa.AuditActionId
join Users u on u.UserId = aa.UserId
where CBMMonitorId='320' order by aa.AuditActionId asc