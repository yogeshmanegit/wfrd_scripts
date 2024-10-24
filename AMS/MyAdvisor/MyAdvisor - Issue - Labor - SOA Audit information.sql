use aesops;

select top 100 s.RequestId, RequestXml.value('(/Request/Body/WOTimeEntryReq/WorkOrderNo/text())[1]','varchar(10)') [work order num],
	RequestXml.value('(/Request/Body/WOTimeEntryReq/EmployeeNo/text())[1]','varchar(10)') EmployeeNo,
	u.FirstName, u.LastName,
	RequestXml.value('(/Request/Body/WOTimeEntryReq/Hours/text())[1]','decimal(10, 2)') [Hours],
	RequestedOn,
	s.RequestDuration,
	s.RequestXml,
	s.ResponseXml
	--,l.StartDateTime
	--,l.StopDateTime
from SOAAuditInformation (NOLOCK) s
join Users u on u.WFTUserName = RequestXml.value('(/Request/Body/WOTimeEntryReq/EmployeeNo/text())[1]','varchar(10)')
--join PFTWO w on w.JDEWorkOrderNum = s.RequestXml.value('(/Request/Body/WOTimeEntryReq/WorkOrderNo/text())[1]','varchar(10)')
--join PFTWOLaborHour l on w.PFTWOId = l.PFTWOID and l.UserID = u.UserId
where AuditTypeId = 14 --and RequestXml.value('(/Request/Body/WOTimeEntryReq/WorkOrderNo/text())[1]','varchar(10)') = '11801735'
	--and RequestDuration > 60
order by RequestId desc