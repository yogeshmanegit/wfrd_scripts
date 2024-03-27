SELECT top 10 
RequestXML.value('(/EAssetRequest/request/ParentAssetNumber)[1]', 'varchar(max)') [ParentAssetNumber],
RequestXML.value('(/EAssetRequest/request/ParentItemNumber)[1]', 'varchar(max)') [ParentItemNumber],
RequestXML.value('(/EAssetRequest/request/ParentAssetNumber)[1]', 'varchar(max)') [ParentSerialNumber],
RequestXML.value('(/EAssetRequest/request/ParentAssetNumber)[1]', 'varchar(max)') [ChildAssetNumber],
RequestXML.value('(/EAssetRequest/request/ParentAssetNumber)[1]', 'varchar(max)') [ChildItemNumber],
RequestXML.value('(/EAssetRequest/request/ParentAssetNumber)[1]', 'varchar(max)') [ChildSerialNumber],
RequestXML.value('(/EAssetRequest/request/ParentAssetNumber)[1]', 'varchar(max)') [SwapINOUTFlag],
RequestXML.value('(/EAssetRequest/request/ParentAssetNumber)[1]', 'varchar(max)') [ChildToInspection],
ResponseXml.value('declare namespace ns0="http://oracle.e1.bssv.JP550020/"; (/parentChildStatusInventoryUpdateDataResponse/ns0:parentChildStatusInventoryUpdateDataResponse/errorCode)[1]', 'varchar(max)') [ErrorCode]
FROM [dbo].[SOAAuditInformation] Where AuditTypeId = 1 
AND CONVERT(VARCHAR(MAX), RequestXML) LIKE '%403817784%'
order by RequestedOn desc