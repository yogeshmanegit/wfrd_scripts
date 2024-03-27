-- https://stackoverflow.com/questions/912194/matching-a-node-based-on-a-siblings-value-with-xpath/31118801#31118801

select CASE WHEN AuditTypeId = 6 THEN 'Document Check In' ELSE 'Document Search' END [Request Type], 
LTRIM(RTRIM(ResponseXml.value('(/Response/Body/Error/ErrorDescription/text())[1]', 'varchar(MAX)'))) [SOA Error], 
Exception,
CreatedOn, s.*
from SOAAuditInformation s
WHERE AuditTypeId in (6, 7) 
AND ( LTRIM(RTRIM(ResponseXml.value('(/Response/Body/Error/ErrorDescription/text())[1]', 'varchar(MAX)'))) IS NOT NULL OR Exception IS NOT NULL)
AND RequestedOn > '2019-02-12'
ORDER BY AuditTypeId ASC, s.CreatedOn desc

select top 100 RequestXml.value('(/Request/Body/checkinDocument/valueMap/entry/value[../key/text()="xSize"]/text())[1]','nvarchar(MAX)'), ResponseXml.value('(/Response/Body/Error/ErrorDescription/text())[1]','nvarchar(MAX)'), *
from SOAAuditInformation 
WHERE AuditTypeId in (6,7)
and ResponseXml.value('(/Response/Body/Error/ErrorDescription/text())[1]','nvarchar(MAX)') = 'Missing password.'
ORDER BY RequestXml.value('(/Request/Body/checkinDocument/valueMap/entry/value[../key/text()="xSize"]/text())[1]','bigint') asc

select j.BusinessUnit, RequestXml.value('(/Request/Body/request/BusinessUnit/text())[1]', 'varchar(MAX)') [BusinessUnit], 
ResponseXml.value('(/Response/Body/Response/MessageDetail/WorkOrderNumber/text())[1]', 'varchar(MAX)'),* 
from JDEWorkOrders j 
join SOAAuditInformation s on s.ResponseXml.value('(/Response/Body/Response/MessageDetail/WorkOrderNumber/text())[1]', 'varchar(MAX)') = j.WorkOrderNumber
where AuditTypeId = 4 and 'OK - OK' = ResponseXml.value('(/Response/Status/text())[1]', 'varchar(MAX)')