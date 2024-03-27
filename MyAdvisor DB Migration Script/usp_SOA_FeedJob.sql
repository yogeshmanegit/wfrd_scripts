-- =============================================
-- Author:		Yogesh Mane
-- Create date: 4/20/2017
-- Description:	This procedure is used to read SOA Asset XML feed from remote server 
--				and process it in MyAdvisor 
-- =============================================
CREATE PROCEDURE [dbo].[usp_SOA_FeedJob] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @JobQueueId INT, @JobStartDate datetime
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;  

	--IF NOT EXISTS (SELECT * FROM JobQueue (NOLOCK) WHERE JobId = 48 AND JobQueueStatusId = 1)
	BEGIN

		SELECT @JobStartDate = GETDATE()

		INSERT INTO JobQueue (JobId, CreateDate, RequestXml, RunStart, RunEnd, JobQueueStatusId, CurrentRetry)
		VALUES (48, @JobStartDate, '<usp_SOA_FeedJob/>', @JobStartDate, NULL, 1, 0)

		SELECT @JobQueueId = SCOPE_IDENTITY()

		BEGIN TRY

			-- Insert statements for procedure here
			DECLARE @transactionId varchar(40), @transactionName varchar(40), @payload xml, @Id1 VARCHAR(200), @RunStart datetime,  @RunEnd datetime, @flag bit

			DECLARE db_cursor1 CURSOR FOR  
				SELECT top 10000 TransactionId, TransactionName, PayLoad, ID1 FROM (SELECT TransactionId, TransactionName, PayLoad, ID1, [TimeStamp]
				FROM USDCALADBBL01.aesSoa.dbo.vwSOAMessagesRemote
				WHERE Status IS NULL 
					AND TransactionName IN ('ASSTADD', 'ASSTDISP', 'ASSTREV', 'ASSTTFR', 'ASSTUPD', 'WO-CHANGE-OUT', 'WO-CREATE-OUT', 'WO-CLOSE', 'WOISSUE'
						, 'DT-INVOICE' ,'DT-RETURN' ,'DT-SEQ-ADD' ,'DT-SEQ-CHANGE' ,'DT-SEQ-DELETE' ,'DT-SHIP' ,'DT-UNRETURN')
					--AND DateAdded > '5/31/2018'
				) A ORDER BY [TimeStamp] ASC, TransactionId ASC
 
			OPEN db_cursor1   
			FETCH NEXT FROM db_cursor1 INTO @transactionId, @transactionName, @payload, @Id1

			WHILE @@FETCH_STATUS = 0   
			BEGIN   
	
				DECLARE @TranCounter INT;  
				SET @TranCounter = @@TRANCOUNT;  

				--Declare Transaction
				--IF @TranCounter > 0  
				--	SAVE TRANSACTION ProcedureSave;  
				--ELSE  
				--	BEGIN TRANSACTION;  
    
				BEGIN TRY  

					-- Do the actual work here
					SELECT @RunStart = GETDATE(), @flag = 0
		 
					print 'Started ' + convert(varchar(100), @transactionId)

					IF(@transactionName = 'ASSTUPD' OR @transactionName = 'ASSTTFR' OR @transactionName = 'ASSTDISP' OR @transactionName = 'ASSTREV' OR @transactionName = 'ASSTADD')
						BEGIN 
							EXEC AesOps.[dbo].[usp_SOA_AssetFeedProcess] @payload, @flag output, @ErrorMessage output
						END

					ELSE IF (@transactionName = 'WO-CREATE-OUT' OR @transactionName = 'WO-CHANGE-OUT')
						BEGIN
							EXEC AesOps.[dbo].[usp_ProcessJDEWOOutboundFeedXml] @payload
							SET @flag = 1
						END
					ELSE IF (@transactionName = 'WO-CLOSE')
						BEGIN
							EXEC AesOps.[dbo].[usp_ProcessJDEWOSummaryFeedXml] @payload
							SET @flag = 1
						END
					ELSE IF (@transactionName = 'WOISSUE')
						BEGIN
							EXEC AesOps.[dbo].[usp_ProcessJDEWOSwapInFeedXml] @payload
							SET @flag = 1
						END
					ELSE
						BEGIN
							EXEC AesOps.[dbo].[spDeliveryTicketToDispatchSOA] @payload
							SET @flag = 1
						END
						 
					--IF @TranCounter = 0  
					--	BEGIN
					--		COMMIT TRANSACTION;  
					--	END

					print 'End ' + convert(varchar(100), @transactionId)

				END TRY  
				BEGIN CATCH  

					SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();  

					
					--IF @TranCounter = 0  
					--	ROLLBACK TRANSACTION;  
					--ELSE  
            
					--	IF XACT_STATE() <> -1  
					--		ROLLBACK TRANSACTION ProcedureSave;
				END CATCH  

				-- if message processing failed due to validation or error log it
				if(@flag != 1)
				BEGIN
					DECLARE @payloadstring NVARCHAR(MAX) = CONVERT(Nvarchar(MAX), @payload)
					exec [AesOps].dbo.[usp_AddException] @RunStart, @ErrorMessage, @payloadstring, 'system', 'SOAApp-Feed', @transactionId
				END

				-- log error 
				SET @RunEnd = GETDATE()
	
				--TODO : Update flag
				exec USDCALADBBL01.AESSOA.dbo.[usp_SOAMessage_UpdateStatus] @transactionId, @transactionName, @RunStart, @RunEnd, @flag

				FETCH NEXT FROM db_cursor1 INTO @transactionId, @transactionName, @payload, @Id1
			END

			CLOSE db_cursor1   
			DEALLOCATE db_cursor1

			UPDATE JobQueue 
			SET RunEnd = GETDATE(),
				JobQueueStatusId = 3
			WHERE JobQueueId = @JobQueueId

		END TRY  
			BEGIN CATCH  
				
				UPDATE JobQueue  SET RunEnd = GETDATE(), JobQueueStatusId = 4 WHERE JobQueueId = @JobQueueId
			
				SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE(); 

				print @ErrorMessage

				INSERT INTO [dbo].[JobLog] ([JobId],[RunStart],[RunEnd],[RequestXml],[JobLogStatusId],[JobQueueId],[Exception],[RetryNumber])
				VALUES (48, @JobStartDate, Getdate(), null, 4, @JobQueueId, @ErrorMessage, 0)

				
				CLOSE db_cursor1   
				DEALLOCATE db_cursor1

			END CATCH
	END

END





