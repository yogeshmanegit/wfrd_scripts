select top 10 RequestXml.value('(Request/Body/WOStatusChangeRequest/WONum/text())[1]', 'varchar(max)'), * from SOAAuditInformation (NOLOCK) where AuditTypeId = 5 
and RequestXml.value('(Request/Body/WOStatusChangeRequest/WONum/text())[1]', 'varchar(max)') = '11539435'
