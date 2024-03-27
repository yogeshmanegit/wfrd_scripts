select * from Users where Email ='hesham.omara1@Weatherford.com'

select top 10 
RequestXml.value('(/mail/to/text())[1]','varchar(max)'),
* 
FROM JobQueue
WHERE JobId = 1 AND RequestXml.value('(/mail/to/text())[1]','varchar(max)') ='hesham.omara1@Weatherford.com'
ORDER BY 1 DESC