use AesOps;

select SUM(1) [Total],
SUM(CASE WHEN  ISNULL(LTRIM(RTRIM(ResponseXml.value('(/Response/Body/Error/ErrorDescription/text())[1]', 'varchar(MAX)'))), Exception) IS NOT NULL THEN 1 ELSE 0 END) [Error Count]
from SOAAuditInformation (NOLOCK)
WHERE AuditTypeId in (6) 
AND RequestedOn > '2021-02-01'


select CASE WHEN AuditTypeId = 6 THEN 'Document Check In' ELSE 'Document Search' END [Request Type],
ISNULL(LTRIM(RTRIM(ResponseXml.value('(/Response/Body/Error/ErrorDescription/text())[1]', 'varchar(MAX)'))), Exception) [SOA Error],
Exception,
CreatedOn,
RequestXml.value('(/Request/Body/checkinDocument/valueMap[entry/key/text()="xUserId"]/entry/value/text())[1]', 'varchar(MAX)')

from SOAAuditInformation (NOLOCK)
WHERE AuditTypeId in (6, 7) 
--AND ( LTRIM(RTRIM(ResponseXml.value('(/Response/Body/Error/ErrorDescription/text())[1]', 'varchar(MAX)'))) IS NOT NULL OR Exception IS NOT NULL OR ResponseCode != 'OK')
AND RequestedOn > '2021-02-01'
AND ISNULL(LTRIM(RTRIM(ResponseXml.value('(/Response/Body/Error/ErrorDescription/text())[1]', 'varchar(MAX)'))), Exception) IS NOT NULL
ORDER BY AuditTypeId ASC, CreatedOn desc