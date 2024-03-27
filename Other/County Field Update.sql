;WITH XMLNAMESPACES(DEFAULT 'http://tempuri.org/XMLSchema.xsd')
SELECT DISTINCT InputXML.value('(/NewDataSet/AESIReportingDB/Jobs/*/Job_Number/text())[1]', 'varchar(10)') [JobNumber],  
	   InputXML.value('(/NewDataSet/AESIReportingDB/Jobs/*/County/text())[1]', 'varchar(10)') [County]
FROM CoreFiles 
WHERE Status = 1 AND InputXML.value('(/NewDataSet/AESIReportingDB/Jobs/*/County/text())[1]', 'varchar(10)')  IS NOT NULL
