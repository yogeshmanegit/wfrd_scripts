--select * from SOAMessages where TransactionName ='DT-INVOICE' and id1 IN (15034013, 15033384, 15036305, 15037547, 15038551)
use AesSOA;

;WITH XMLNAMESPACES(DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
SELECT DISTINCT payload.value('(/DTInfoCollection/MessageDetail/DateofTransaction/text())[1]', 'varchar(10)') [Invoice Date], id1 [DeliveryTicketNumber],
'exec dbo.usp_Job_CloseByInvoiceDate ' + ID1 +',' + ''''+ payload.value('(/DTInfoCollection/MessageDetail/DateofTransaction/text())[1]', 'varchar(10)') + ''''
FROM SOAMessages (NOLOCK) where TransactionName ='DT-INVOICE' and id1  IN (
15514301
, 15517713
, 15514301
, 15479926)

order by 2, 1
