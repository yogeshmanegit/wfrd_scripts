;WITH XMLNAMESPACES(DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
select Payload.value('(/DTInfoCollection/MessageDetail/AssetNumber/text())[1]', 'bigint'),
* from SOAMessages (NOLOCK) where ID1 = 15036711
AND Payload.value('(/DTInfoCollection/MessageDetail/AssetNumber/text())[1]', 'bigint') = 3171083

;WITH XMLNAMESPACES ('http://www.wft.com/DeliveryTicketInfo/Response/v1.0' AS inp1,
        DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
select Payload.value('(/DTInfoCollection/MessageDetail/SerialNumber/text())[1]','varchar(max)'),
* from SOAMessages where Id1 = '15316010' 
--and TRIM(Payload.value('(/DTInfoCollection/MessageDetail/SerialNumber/text())[1]','varchar(max)')) = '58427'
order by DateAdded desc