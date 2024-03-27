SET NOCOUNT ON;

DECLARE @pageSize int = 10000, @pageIndex int = 0, @totalPages int = 0

select @totalPages = max(d.DispatchNumber) / @pageSize + 1
from aesops.dbo.Dispatches d
join (select distinct dispatchNum from SoaDeliveryTicketHistory) a on d.DispatchNumber = a.dispatchNum

while (@pageIndex <= @totalPages)
BEGIN

UPDATE dii
SET RevenueBusinessUnit = CASE WHEN LTRIM(RTRIM(a.revenuebusinessunit)) ='' THEN NULL ELSE LTRIM(RTRIM(a.revenuebusinessunit)) END
from aesops.dbo.Dispatches d
join aesops.dbo.DispatchInstances di on d.DispatchId = di.DispatchId
join aesops.dbo.DispatchInstanceItems dii on di.DispatchInstanceId = dii.DispatchInstanceId
join SoaDeliveryTicketHistory a on d.DispatchNumber = a.dispatchNum and di.ShipType = a.TransactionName and di.SequenceNum = a.sequenceNum and dii.SerialNum = a.serialNum
where d.DispatchNumber BETWEEN @pageIndex * @pageSize AND (@pageIndex + 1) * @pageSize 
	
print @pageIndex

SET @pageIndex =  @pageIndex + 1

END
