SELECT ROW_NUMBER() OVER(PARTITION BY c.OriginalFileName, xScreenName, ISNULL(CAST(xApplicationGroupId as varchar(100)), CAST(xApplicationId as varchar(100)))
	ORDER BY RequestedOn ASC, c.OriginalFileName, xScreenName, ISNULL(CAST(xApplicationGroupId as varchar(100)), CAST(xApplicationId as varchar(100)))
	) [RowIndex], 
	DocItemAttachId, 
	RequestedOn,
	c.OriginalFileName, 
	xScreenName, 
	ISNULL(CAST(xApplicationGroupId as varchar(100)), CAST(xApplicationId as varchar(100))) [AppId],
	c.FilePath

FROM SOAAuditInformation s
JOIN Vw_WCC_Documents c ON c.DocItemAttachId =  s.RequestXml.value('(/Request/UniqueId/text())[1]', 'uniqueidentifier')
where AuditTypeId ='6' and RequestedOn > '2019-03-19 18:00:00'
AND ResponseXml.value('(/Response/Body/Error/ErrorCode/text())[1]', 'varchar(100)') ='BEA-380000'
order by CreatedOn asc

SELECT '"'+ CONVERT(varchar(MAX), a.DocItemAttachId) +'",' 
FROM  TempDocumentRetry t
JOIN vwDocItemAttach a on a.DocItemAttachId = t.DocItemAttachId 
WHERE rowindex = '1' and a.WCCDocId IS NULL
ORDER BY RequestedOn DESC
