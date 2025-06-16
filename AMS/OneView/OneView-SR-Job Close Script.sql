use oneview;

DECLARE @jobId uniqueidentifier

select @jobId = jobID from Job where financialSystemID = '15676586_A'

BEGIN TRAN

UPDATE Job SET invoiceDateTime = '2025-05-07' WHERE jobID = @jobId

UPDATE TMPSOADTPipelineMessageProcessing SET processed = 1 WHERE jobID = @jobId

--UPDATE JobCharges 
--	SET adjustedNativeItemPrice = null, 
--		adjustedNativeTotal = null
--		,adjustedItemQuantity = null
--WHERE jobID =  @jobId and ISNULL(deleted,0) = 0


UPDATE JobCharges 
	SET adjustedNativeItemPrice = nativeItemPrice, 
		adjustedNativeTotal = nativeTotal
		,adjustedItemQuantity = itemQuantity
WHERE jobID =  @jobId and ISNULL(deleted,0) = 0

commit TRAN
