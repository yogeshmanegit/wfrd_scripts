--select top 10 Payload from SOAMessages (NOLOCK) order by DateAdded desc
----where year(dateadded) = 2024  and RunStart is null

--;WITH XMLNAMESPACES(DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
--select Payload.value('(/DTInfoCollection/MessageDetail/AssetNumber/text())[1]', 'bigint'),
--* from SOAMessages (NOLOCK) where ID1 = 15036711
--AND Payload.value('(/DTInfoCollection/MessageDetail/AssetNumber/text())[1]', 'bigint') = 3171083

;WITH XMLNAMESPACES(DEFAULT 'http://www.wft.com/AssetInformation/Outbound/v1.0')
select top 10 Payload.value('(/AssetInfoCollection/MessageDetail/DateofTransaction/text())[1]', 'varchar(12)'),
dbo.ufn_DateOfTransaction_AddTime(Payload.value('(/AssetInfoCollection/MessageDetail/DateofTransaction/text())[1]', 'datetime'), 
								Payload.value('(/AssetInfoCollection/MessageDetail/TimeofTransaction/text())[1]', 'varchar(8)')) [DateOfTransaction]
, DateAdded
from SOAMessages where transactionName IN ('ASSTUPD' , 'ASSTTFR' , 'ASSTDISP' , 'ASSTREV' , 'ASSTADD')
order by DateAdded desc