SELECT *
FROM SOAAuditInformation 
Where AuditTypeId = 2 and 
RequestXml.exist('/ArrayOfJobHeader/JobHeader[JobNumber="J0000000"]') = 1
OR ResponseXml.exist('/ServiceResponseOfListOfJobHeaderResponse/Result/JobHeaderResponse[JobNumber="J0002893"]/Status[text()="false"]') = 1



;WITH XMLNAMESPACES(DEFAULT 'http://tempuri.org/XMLSchema.xsd')
SELECT * 
FROM CoreFiles (NOLOCK)
Where InputXML.value('(/NewDataSet/AESIReportingDB/Jobs/*/Job_Number/text())[1]', 'varchar(10)') = '13676941'