--DECLARE @transactionId varchar(40), @transactionName varchar(40), @payload xml, @Id1 VARCHAR(200), @RunStart datetime,  @RunEnd datetime, @flag bit

--	DECLARE db_cursor1 CURSOR FOR  
--	SELECT  TransactionId, TransactionName, 
--	CONVERT(XML,'<inp1:DeliveryTicketInfo xmlns:inp1="http://www.wft.com/DeliveryTicketInfo/Response/v1.0">' + PayLoad + '</inp1:DeliveryTicketInfo>'), ID1
--		from USDCALADBBL01.aesSoa.dbo.vwSOAMessagesRemote r
--		JOIN Dispatches d ON r.Id1 = d.DispatchNumber
--		LEFT JOIN DispatchInstances di ON r.Id5 = di.SequenceNum AND d.DispatchId = di.DispatchId AND ShipType ='DT-SEQ-ADD'
--		WHERE TransactionName ='DT-SEQ-ADD' AND di.DispatchId IS NULL
--		ORDER BY [TimeStamp] ASC

 
--	OPEN db_cursor1   
--	FETCH NEXT FROM db_cursor1 INTO @transactionId, @transactionName, @payload, @Id1

--	WHILE @@FETCH_STATUS = 0   
--	BEGIN   
	 
--	--print @transactionid
--    exec dbo.spDeliveryTicketToDispatchSOA @payload

--	FETCH NEXT FROM db_cursor1 INTO @transactionId, @transactionName, @payload, @Id1
--	END

--	CLOSE db_cursor1   
--	DEALLOCATE db_cursor1


--BEGIN TRAN

--SET NOCOUNT ON;

--DECLARE @transactionId varchar(40), @transactionName varchar(40), @payload xml, @Id1 VARCHAR(200), @RunStart datetime,  @RunEnd datetime, @flag bit

--DECLARE @SOADTInstanceItems TABLE (TransactionId varchar(40), TransactionName varchar(40))

--INSERT INTO @SOADTInstanceItems
--SELECT top 1000000 TransactionId, TransactionName
--FROM SOADTInstanceItems (NOLOCK) WHERE Status IS NULL

--DECLARE db_cursor1 CURSOR FOR  SELECT TransactionId, TransactionName FROM @SOADTInstanceItems

 
--	SELECT @payload = CONVERT(XML,'<inp1:DeliveryTicketInfo xmlns:inp1="http://www.wft.com/DeliveryTicketInfo/Response/v1.0">' + PayLoad + '</inp1:DeliveryTicketInfo>'),
--			@Id1 = Id1
--	FROM USDCALADBBL01.aesSoa.dbo.vwSOAMessagesRemote r
--	WHERE TransactionId = @transactionId AND TransactionName = @transactionName

--	OPEN db_cursor1   
--	FETCH NEXT FROM db_cursor1 INTO @transactionId, @transactionName

--	WHILE @@FETCH_STATUS = 0   
--	BEGIN   
	 
--	-- print @transactionid
--    exec dbo.spDeliveryTicketToDispatchSOA @payload

--	update SOADTInstanceItems SET Status = '1' WHERE TransactionId = @transactionId AND TransactionName = @transactionName

--	FETCH NEXT FROM db_cursor1 INTO @transactionId, @transactionName
--	END

--	CLOSE db_cursor1   
--	DEALLOCATE db_cursor1


--SET NOCOUNT OFF;

------ROLLBACK TRAN
