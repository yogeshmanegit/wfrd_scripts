--select * from SOAMessages where TransactionName ='DT-INVOICE' and id1 IN (15034013, 15033384, 15036305, 15037547, 15038551)
use AesSOA;

;WITH XMLNAMESPACES(DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
SELECT DISTINCT payload.value('(/DTInfoCollection/MessageDetail/DateofTransaction/text())[1]', 'varchar(10)') [Invoice Date], id1 [DeliveryTicketNumber],
'exec dbo.usp_Job_CloseByInvoiceDate ' + ID1 +',' + ''''+ payload.value('(/DTInfoCollection/MessageDetail/DateofTransaction/text())[1]', 'varchar(10)') + ''''
FROM SOAMessages (NOLOCK) where TransactionName ='DT-INVOICE' and id1  IN (
15742693
, 15745104
, 15745689
, 15741151
, 15731618
, 15740600
, 15741143
, 15742270
, 15742799
, 15714209
, 15723896
, 15738246
, 15738250
, 15738874
, 15739765
, 15747007
, 15715056
, 15742752
, 15742754
, 15739333
)

order by 2, 1
