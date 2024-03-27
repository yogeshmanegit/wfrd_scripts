select RequestXml.value('(/ReliabilityWPTSJob/jobNumber/text())[1]','varchar(100)'),
* from JobQueue where RunStart > '2024-01-22' and JobId = 29 order by RequestXml.value('(/ReliabilityWPTSJob/jobNumber/text())[1]','varchar(100)') desc
