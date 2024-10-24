use AesSOA;
DECLARE @Date DATETIME

SET @Date = DATEADD(month, -6, GETDATE())

CREATE TABLE #TempSOAMessages (TransactionId varchar(40), TransactionName varchar(40))
CREATE INDEX IX_TempSoaMessages ON #TempSOAMessages (TransactionId, TransactionName)

WHILE ((select COUNT(*) from SOAMessages WHERE DateAdded < @Date ) > 0)
BEGIN


BEGIN TRAN
	
	INSERT INTO #TempSOAMessages
	SELECT top 2000 TransactionId , TransactionName
	FROM SOAMessages
	WHERE DateAdded < @Date 
	--ORDER BY DateAdded ASC, TransactionId ASC

	INSERT INTO [SOAMessagesHistory1] (TransactionId
, TransactionName
, CompositeName
, CompositeInstance
, Payload
, [TimeStamp]
, ID1
, ID2
, ID3
, ID4
, ID5
, DateAdded
, RunStart
, RunEnd
, [Status]
, ProductLine)
	SELECT s.*
	FROM SOAMessages s
	JOIN #TempSOAMessages t on s.TransactionId = t.TransactionId and s.TransactionName = t.TransactionName
	

	DELETE S 
	FROM  SOAMessages s
	JOIN #TempSOAMessages t on s.TransactionId = t.TransactionId and s.TransactionName = t.TransactionName

	DELETE FROM #TempSOAMessages

	--print GETDATE()

COMMIT TRAN

END
--rollback tran
DROP table #TempSOAMessages

