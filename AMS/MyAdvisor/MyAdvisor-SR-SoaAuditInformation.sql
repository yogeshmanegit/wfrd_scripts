select CONVERT(varchar(10), createdon, 101) [CreatedOn], count(*) 
FROM SOAAuditInformation 
WHERE AuditTypeId =1 and CreatedOn > DATEADD(dd, -14, getdate())
GROUP BY CONVERT(varchar(10), createdon, 101)

select top 1000 
	RequestId, 
	AuditTypeId,
	'Parent Child Break' [AuditType],
	CASE WHEN Exception IS NOT NULL THEN 1
		 WHEN ResponseXml IS NULL THEN 1
		 --WHEN ResponseXml.value('(/parentChildStatusInventoryUpdateDataResponse/*/errorCode/text())[1]','char(1)') = 'Y' THEN 1
		ELSE 0 
	END [IsError],

	COALESCE(Exception, ResponseXml.value('(/parentChildStatusInventoryUpdateDataResponse/*/messageText/text())[1]','varchar(max)'), ResponseCode) [Error]
FROM SOAAuditInformation 
WHERE AuditTypeId = 1
ORDER by RequestId desc

--UNION ALL

SELECT top 1000 
	RequestId, 
	AuditTypeId,
	'Salesforce Job' [AuditType],
	CASE WHEN Exception IS NOT NULL THEN 1
		 WHEN ResponseXml IS NULL THEN 1
		 WHEN ResponseXml.value('(/ServiceResponseOfListOfJobHeaderResponse/Result/JobHeaderResponse/Errors/string/text())[1]','varchar(max)') IS NOT NULL THEN 1
		ELSE 0 
	END [IsError],

	COALESCE(Exception, ResponseXml.value('(/ServiceResponseOfListOfJobHeaderResponse/Result/JobHeaderResponse/Errors/string/text())[1]','varchar(max)'), ResponseCode) [Error]
	
FROM SOAAuditInformation 
WHERE AuditTypeId = 2
order by RequestId desc