
while exists(SELECT 1)
BEGIN
	UPDATE TOP (2000) SOAMEssages
	SET Status = 1
	WHERE (TransactionName like 'ASS%') and Status is null AND DateAdded < '5/31/2018'
END
GO

--WO-CREATE-OUT
--WO-CHANGE-OUT
ALTER PROCEDURE [dbo].[usp_ProcessJDEWOOutboundFeedXml]
	@xmlData xml
AS
BEGIN
	SET NOCOUNT ON
	
--BEGIN TRANSACTION
	
	DECLARE @JDEWorkOrderId as uniqueidentifier
	DECLARE @WorkOrderNumber as varchar(30)
	DECLARE @Source as varchar(30)
	DECLARE @Target as varchar(30)
	DECLARE @Method as varchar(30)
	DECLARE @TransactionUserId as varchar(30)
	DECLARE @TransactionId as varchar(30)
	DECLARE @TransactionName as varchar(30)
	DECLARE @EdgeKey as varchar(30)
	DECLARE @EquipmentStatus as varchar(4)
	DECLARE @OrderType as varchar(4)
	DECLARE @OrderSuffix as varchar(30)
	DECLARE @RelatedOrderType as varchar(4)
	DECLARE @RelatedWONumber as varchar(30)
	DECLARE @ParentWONumber as varchar(30)
	DECLARE @TypeWO as varchar(6)
	DECLARE @WorkOrderPriority as int
	DECLARE @Description as varchar(255)
	DECLARE @StatusComment as varchar(255)
	DECLARE @Company as varchar(50)
	DECLARE @BusinessUnit as varchar(30)
	DECLARE @Branch as varchar(12)
	DECLARE @WorkOrderStatusCode as varchar(4)
	
	DECLARE @StatusChangedDateStr as varchar(40)
	DECLARE @StatusChangedDate as datetime
	
	DECLARE @Subsidiary as varchar(30)
	
	DECLARE @TransactionDateStr as varchar(40)
	DECLARE @TransactionDate as datetime
	
	DECLARE @StartDateStr as varchar(40)
	DECLARE @StartDate as datetime
	
	DECLARE @RequestedDateStr as varchar(40)
	DECLARE @RequestedDate as datetime
	
	DECLARE @CompletionDateStr as varchar(40)
	DECLARE @CompletionDate as datetime
	
	DECLARE @AssignedToDateStr as varchar(40)
	DECLARE @AssignedToDate as datetime
	
	DECLARE @AssignedToInspectorDateStr as varchar(40)
	DECLARE @AssignedToInspectorDate as datetime
	
	DECLARE @Reference as varchar(50)
	DECLARE @Reference2 as varchar(50)
	DECLARE @EstimatedAmount as float
	DECLARE @OriginalDollarsAmount as float
	DECLARE @EstimatedHours as float
	DECLARE @OriginalHours as float
	DECLARE @ActualAmount as float
	DECLARE @ActualHours as float
	DECLARE @ShortItemNumber as varchar(30)
	DECLARE @SecondItemNumber as varchar(30)
	DECLARE @ThirdItemNumber as varchar(30)
	DECLARE @AssetItemNumber as varchar(30)
	DECLARE @PostingEdit as varchar(30)
	DECLARE @LotNumber as varchar(30)
	DECLARE @LotPotency as varchar(30)
	DECLARE @LotGrade as varchar(30)
	
	DECLARE @UpdatedDateStr as varchar(40)
	DECLARE @UpdatedDate as datetime
	
	DECLARE @TimeOfDay as varchar(30)
	DECLARE @ParentNumber as varchar(30)
	DECLARE @WorkOrderCriticality as varchar(30)
	DECLARE @EstimatedDowntimeHours as float
	DECLARE @ActualDowntimeHours as float
	DECLARE @MeterPosition as varchar(30)
	DECLARE @EstimatedLaborAmount as float
	DECLARE @EstimatedMaterialAmount as float
	DECLARE @EstimatedOtherAmount as float
	DECLARE @ActualLaborAmount as float
	DECLARE @ActualMaterialAmount as float
	DECLARE @DocumentType as varchar(6)
	
	DECLARE @DispatchNumber varchar(30), 
	@CustomerNumber int

	;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
	Select @Source = T.C.value('(Source/text())[1]', 'varchar(30)'),
		@Target = T.C.value('(Target/text())[1]', 'varchar(30)'),
		@Method = T.C.value('(Method/text())[1]', 'varchar(30)'),
		@TransactionUserId = T.C.value('(TransactionUserId/text())[1]', 'varchar(30)'),
		@TransactionId = T.C.value('(TransactionId/text())[1]', 'varchar(30)'),
		@TransactionName = T.C.value('(TransactionName/text())[1]', 'varchar(30)')
	FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageHeader') AS T(c)
	
	;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
	Select @WorkOrderNumber = T.C.value('(WorkOrderNumber/text())[1]', 'varchar(30)'),
		@EdgeKey = T.C.value('(EdgeKey/text())[1]', 'varchar(30)'),
		@EquipmentStatus = T.C.value('(EquipmentStatus/text())[1]', 'varchar(4)'),
		@OrderType = T.C.value('(OrderType/text())[1]', 'varchar(4)'),
		@OrderSuffix = T.C.value('(OrderSuffix/text())[1]', 'varchar(30)'),
		@RelatedOrderType = T.C.value('(RelatedOrderType/text())[1]', 'varchar(4)'),
		@RelatedWONumber = T.C.value('(RelatedWONumber/text())[1]', 'varchar(30)'),
		@ParentWONumber = T.C.value('(ParentWONumber/text())[1]', 'varchar(30)'),
		@TypeWO = T.C.value('(TypeWO/text())[1]', 'varchar(6)'),
		@WorkOrderPriority = T.C.value('(WorkOrderPriority/text())[1]', 'int'),
		@Description = T.C.value('(Description/text())[1]', 'varchar(255)'),
		@StatusComment = T.C.value('(StatusComment/text())[1]', 'varchar(255)'),
		@Company = T.C.value('(Company/text())[1]', 'varchar(50)'),
		@BusinessUnit = T.C.value('(BusinessUnit/text())[1]', 'varchar(30)'),
		@Branch = T.C.value('(Branch/text())[1]', 'varchar(12)'),
		@WorkOrderStatusCode = T.C.value('(WorkOrderStatusCode/text())[1]', 'varchar(4)'),
		@Subsidiary = T.C.value('(Subsidiary/text())[1]', 'varchar(30)'),
		@Reference = T.C.value('(Reference/text())[1]', 'varchar(50)'),
		@Reference2 = T.C.value('(Reference2/text())[1]', 'varchar(50)'),
		@EstimatedAmount = T.C.value('(EstimatedAmount/text())[1]', 'float'),
		@OriginalDollarsAmount = T.C.value('(OriginalDollarsAmount/text())[1]', 'float'),
		@EstimatedHours = T.C.value('(EstimatedHours/text())[1]', 'float'),
		@OriginalHours = T.C.value('(OriginalHours/text())[1]', 'float'),
		@ActualAmount = T.C.value('(ActualAmount/text())[1]', 'float'),
		@ActualHours = T.C.value('(ActualHours/text())[1]', 'float'),
		@ShortItemNumber = T.C.value('(ShortItemNumber/text())[1]', 'varchar(30)'),
		@SecondItemNumber = T.C.value('(SecondItemNumber/text())[1]', 'varchar(30)'),
		@ThirdItemNumber = T.C.value('(ThirdItemNumber/text())[1]', 'varchar(30)'),
		@AssetItemNumber = T.C.value('(AssetItemNumber/text())[1]', 'varchar(30)'),
		@PostingEdit = T.C.value('(PostingEdit/text())[1]', 'varchar(30)'),
		@LotNumber = T.C.value('(LotNumber/text())[1]', 'varchar(30)'),
		@LotPotency = T.C.value('(LotPotency/text())[1]', 'varchar(30)'),
		@LotGrade = T.C.value('(LotGrade/text())[1]', 'varchar(30)'),
		@TimeOfDay = T.C.value('(TimeOfDay/text())[1]', 'varchar(30)'),
		@ParentNumber = T.C.value('(ParentNumber/text())[1]', 'varchar(30)'),
		@WorkOrderCriticality = T.C.value('(WorkOrderCriticality/text())[1]', 'varchar(30)'),
		@EstimatedDowntimeHours = T.C.value('(EstimatedDowntimeHours/text())[1]', 'float'),
		@ActualDowntimeHours = T.C.value('(ActualDowntimeHours/text())[1]', 'float'),
		@MeterPosition = T.C.value('(MeterPosition/text())[1]', 'varchar(30)'),
		@EstimatedLaborAmount = T.C.value('(EstimatedLaborAmount/text())[1]', 'float'),
		@EstimatedMaterialAmount = T.C.value('(EstimatedMaterialAmount/text())[1]', 'float'),
		@EstimatedOtherAmount = T.C.value('(EstimatedOtherAmount/text())[1]', 'float'),
		@ActualLaborAmount = T.C.value('(ActualLaborAmount/text())[1]', 'float'),
		@ActualMaterialAmount = T.C.value('(ActualMaterialAmount/text())[1]', 'float'),
		@DocumentType = T.C.value('(DocumentType/text())[1]', 'varchar(6)'),
		@DispatchNumber = T.C.value('(DTNumber/text())[1]', 'varchar(30)'),
		@CustomerNumber = T.C.value('(CustomerNo/text())[1]', 'int')
	FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	
	;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
	Select @StatusChangedDateStr = T.C.value('(StatusChangedDate/text())[1]', 'varchar(40)'),
		   @TransactionDateStr = T.C.value('(TransactionDate/text())[1]', 'varchar(40)'),
		   @StartDateStr = T.C.value('(StartDate/text())[1]', 'varchar(40)'),
		   @RequestedDateStr = T.C.value('(RequestedDate/text())[1]', 'varchar(40)'),
		   @CompletionDateStr = T.C.value('(CompletionDate/text())[1]', 'varchar(40)'),
		   @AssignedToDateStr = T.C.value('(AssignedToDate/text())[1]', 'varchar(40)'),
		   @AssignedToInspectorDateStr = T.C.value('(AssignedToInspectorDate/text())[1]', 'varchar(40)'),
		   @UpdatedDateStr = T.C.value('(UpdatedDate/text())[1]', 'varchar(40)')
	FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	
	IF (@StatusChangedDateStr <> '0')
	BEGIN
		;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
		Select @StatusChangedDate = T.C.value('(StatusChangedDate/text())[1]', 'datetime')
		FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	END
	
	IF (@TransactionDateStr <> '0')
	BEGIN
		;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
		Select @TransactionDate = T.C.value('(TransactionDate/text())[1]', 'datetime')
		FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	END
	
	IF (@StartDateStr <> '0')
	BEGIN
		;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
		Select @StartDate = T.C.value('(StartDate/text())[1]', 'datetime')
		FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	END
	
	IF (@RequestedDateStr <> '0')
	BEGIN
		;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
		Select @RequestedDate = T.C.value('(RequestedDate/text())[1]', 'datetime')
		FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	END
	
	IF (@CompletionDateStr <> '0')
	BEGIN
		;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
		Select @CompletionDate = T.C.value('(CompletionDate/text())[1]', 'datetime')
		FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	END
	
	IF (@AssignedToDateStr <> '0')
	BEGIN
		;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
		Select @AssignedToDate = T.C.value('(AssignedToDate/text())[1]', 'datetime')
		FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	END
	
	IF (@AssignedToInspectorDateStr <> '0')
	BEGIN
		;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
		Select @AssignedToInspectorDate = T.C.value('(AssignedToInspectorDate/text())[1]', 'datetime')
		FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	END
	
	IF (@UpdatedDateStr <> '0')
	BEGIN
		;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
		Select @UpdatedDate = T.C.value('(UpdatedDate/text())[1]', 'datetime')
		FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)
	END
	
	SET @JDEWorkOrderId = null
	
	Select @JDEWorkOrderId = JDEWorkOrderId From AesOps.dbo.JDEWorkOrders Where WorkOrderNumber = @WorkOrderNumber
	
	IF (ISNUMERIC(@DispatchNumber) = 0)
		SET @DispatchNumber = null

	if @JDEWorkOrderId is null
	BEGIN
	
	INSERT INTO JDEWorkOrders 
	(
		JDEWorkOrderId,
		WorkOrderNumber,
		[Source],
		[Target],
		Method,
		TransactionUserId,
		TransactionId,
		TransactionName,
		EdgeKey,
		EquipmentStatus,
		OrderType,
		OrderSuffix,
		RelatedOrderType,
		RelatedWONumber,
		ParentWONumber,
		TypeWO,
		WorkOrderPriority,
		[Description],
		StatusComment,
		Company,
		BusinessUnit,
		Branch,
		WorkOrderStatusCode,
		StatusChangedDate,
		Subsidiary,
		TransactionDate,
		StartDate,
		RequestedDate,
		CompletionDate,
		AssignedToDate,
		AssignedToInspectorDate,
		Reference,
		Reference2,
		EstimatedAmount,
		OriginalDollarsAmount,
		EstimatedHours,
		OriginalHours,
		ActualAmount,
		ActualHours,
		ShortItemNumber,
		SecondItemNumber,
		ThirdItemNumber,
		AssetItemNumber,
		PostingEdit,
		LotNumber,
		LotPotency,
		LotGrade,
		UpdatedDate,
		TimeOfDay,
		ParentNumber,
		WorkOrderCriticality,
		EstimatedDowntimeHours,
		ActualDowntimeHours,
		MeterPosition,
		EstimatedLaborAmount,
		EstimatedMaterialAmount,
		EstimatedOtherAmount,
		ActualLaborAmount,
		ActualMaterialAmount,
		DocumentType,
		DateAdded,
		LastUpdatedDate,
		DispatchNumber,
		CustomerNumber
	)
	SELECT 
		NEWID(),
		@WorkOrderNumber,
		@Source,
		@Target,
		@Method,
		@TransactionUserId,
		@TransactionId,
		@TransactionName,
		@EdgeKey,
		@EquipmentStatus,
		@OrderType,
		@OrderSuffix,
		@RelatedOrderType,
		@RelatedWONumber,
		@ParentWONumber,
		@TypeWO,
		@WorkOrderPriority,
		@Description,
		@StatusComment,
		@Company,
		@BusinessUnit,
		@Branch,
		@WorkOrderStatusCode,
		@StatusChangedDate,
		@Subsidiary,
		@TransactionDate,
		@StartDate,
		@RequestedDate,
		@CompletionDate,
		@AssignedToDate,
		@AssignedToInspectorDate,
		@Reference,
		@Reference2,
		@EstimatedAmount,
		@OriginalDollarsAmount,
		@EstimatedHours,
		@OriginalHours,
		@ActualAmount,
		@ActualHours,
		@ShortItemNumber,
		@SecondItemNumber,
		@ThirdItemNumber,
		@AssetItemNumber,
		@PostingEdit,
		@LotNumber,
		@LotPotency,
		@LotGrade,
		@UpdatedDate,
		@TimeOfDay,
		@ParentNumber,
		@WorkOrderCriticality,
		@EstimatedDowntimeHours,
		@ActualDowntimeHours,
		@MeterPosition,
		@EstimatedLaborAmount,
		@EstimatedMaterialAmount,
		@EstimatedOtherAmount,
		@ActualLaborAmount,
		@ActualMaterialAmount,
		@DocumentType,
		GETDATE(),
		GETDATE(),
		@DispatchNumber,
		@CustomerNumber
	END
	ELSE
	BEGIN
	
	UPDATE JDEWorkOrders 
	SET [Source] = @Source,
		[Target] = @Target,
		Method = @Method,
		TransactionUserId = @TransactionUserId,
		TransactionId = @TransactionId,
		TransactionName = @TransactionName,
		EdgeKey = @EdgeKey,
		EquipmentStatus = @EquipmentStatus,
		OrderType = @OrderType,
		OrderSuffix = @OrderSuffix,
		RelatedOrderType = @RelatedOrderType,
		RelatedWONumber = @RelatedWONumber,
		ParentWONumber = @ParentWONumber,
		TypeWO = @TypeWO,
		WorkOrderPriority = @WorkOrderPriority,
		[Description] = @Description,
		StatusComment = @StatusComment,
		Company = @Company,
		BusinessUnit = @BusinessUnit,
		Branch = @Branch,
		WorkOrderStatusCode = @WorkOrderStatusCode,
		StatusChangedDate = @StatusChangedDate,
		Subsidiary = @Subsidiary,
		TransactionDate = @TransactionDate,
		StartDate = @StartDate,
		RequestedDate = @RequestedDate,
		CompletionDate = @CompletionDate,
		AssignedToDate = @AssignedToDate,
		AssignedToInspectorDate = @AssignedToInspectorDate,
		Reference = @Reference,
		Reference2 = @Reference2,
		EstimatedAmount = @EstimatedAmount,
		OriginalDollarsAmount = @OriginalDollarsAmount,
		EstimatedHours = @EstimatedHours,
		OriginalHours = @OriginalHours,
		ActualAmount = @ActualAmount,
		ActualHours = @ActualHours,
		ShortItemNumber = @ShortItemNumber,
		SecondItemNumber = @SecondItemNumber,
		ThirdItemNumber = @ThirdItemNumber,
		AssetItemNumber = @AssetItemNumber,
		PostingEdit = @PostingEdit,
		LotNumber = @LotNumber,
		LotPotency = @LotPotency,
		LotGrade = @LotGrade,
		UpdatedDate = @UpdatedDate,
		TimeOfDay = @TimeOfDay,
		ParentNumber = @ParentNumber,
		WorkOrderCriticality = @WorkOrderCriticality,
		EstimatedDowntimeHours = @EstimatedDowntimeHours,
		ActualDowntimeHours = @ActualDowntimeHours,
		MeterPosition = @MeterPosition,
		EstimatedLaborAmount = @EstimatedLaborAmount,
		EstimatedMaterialAmount = @EstimatedMaterialAmount,
		EstimatedOtherAmount = @EstimatedOtherAmount,
		ActualLaborAmount = @ActualLaborAmount,
		ActualMaterialAmount = @ActualMaterialAmount,
		DocumentType = @DocumentType,
		LastUpdatedDate = GETDATE(),
		DispatchNumber = @DispatchNumber,
		CustomerNumber = @CustomerNumber
	WHERE JDEWorkOrderId = @JDEWorkOrderId 
	END

	;WITH XMLNAMESPACES ('http://www.wft.com/OutboundWO/Response/v1.0' AS inp1,
	DEFAULT 'http://www.wft.com/OutboundWO/Response/v1.0')
	insert into AesImport.dbo.SOAProcessedLog (TransactionId, TransactionName, DateAdded)
	select 
        ltrim(rtrim(T.c.value('(TransactionId/text())[1]', 'int'))) AS TransactionId,
        ltrim(rtrim(T.c.value('(TransactionName/text())[1]', 'varchar(25)'))) AS TransactionName,
		GETDATE()
	FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageHeader') AS T(c)

--IF @@ERROR <> 0
--BEGIN
--	ROLLBACK
--	RAISERROR ('Error in Processing JDE WO Outbound Feed, using usp_ProcessJDEWOOutboundFeedXml', 16, 1)
--	RETURN
--END

--COMMIT

END
GO

-- WO-CLOSE 
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	For WO-CLOSE transaction name
-- =============================================
ALTER PROCEDURE [dbo].[usp_ProcessJDEWOSummaryFeedXml]
	@xmlData xml
AS
BEGIN
	SET NOCOUNT ON
	
-- BEGIN TRANSACTION
	DECLARE @JDEWorkOrderId as uniqueidentifier
	DECLARE @WorkOrderNumber as varchar(30)
	DECLARE @Description as varchar(255)
	DECLARE @Source as varchar(30)
	DECLARE @Target as varchar(30)
	DECLARE @Method as varchar(30)
	DECLARE @TransactionUserId as varchar(30)
	DECLARE @TransactionId as varchar(30)
	DECLARE @TransactionName as varchar(30)
	DECLARE @WorkOrderStatus as varchar(6)
	DECLARE @DocumentType as varchar(6)
	DECLARE @MiscCost as float
	DECLARE @ExchangeRate as float
	DECLARE @ActaulLaborInUSD as float
	DECLARE @ActualMaterialInUSD as float
	DECLARE @ActaulMiscCostInUSD as float
	DECLARE @MiscCostInUSD as float
	
	;WITH XMLNAMESPACES ('http://www.wft.com/WOSummary/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/WOSummary/Response/v1.0')
	Select @Source = T.C.value('(Source/text())[1]', 'varchar(30)'),
		@Target = T.C.value('(Target/text())[1]', 'varchar(30)'),
		@Method = T.C.value('(Method/text())[1]', 'varchar(30)'),
		@TransactionUserId = T.C.value('(TransactionUserId/text())[1]', 'varchar(30)'),
		@TransactionId = T.C.value('(TransactionId/text())[1]', 'varchar(30)'),
		@TransactionName = T.C.value('(TransactionName/text())[1]', 'varchar(30)')
	FROM @xmlData.nodes('/WOSummaryInfo/WOSummaryCollection/MessageHeader') AS T(c)
			
	;WITH XMLNAMESPACES ('http://www.wft.com/WOSummary/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/WOSummary/Response/v1.0')
	Select @WorkOrderNumber = T.C.value('(WorkOrderNumber/text())[1]', 'varchar(30)'),
		@Description = T.C.value('(Description/text())[1]', 'varchar(255)'),
		@WorkOrderStatus = T.C.value('(WorkOrderStatus/text())[1]', 'varchar(6)'),
		@DocumentType = T.C.value('(DocumentType/text())[1]', 'varchar(6)'),
		@MiscCost = T.C.value('(MiscCost/text())[1]', 'float'),
		@ExchangeRate = T.C.value('(ExchangeRate/text())[1]', 'float'),
		@ActaulLaborInUSD = T.C.value('(ActaulLaborInUSD/text())[1]', 'float'),
		@ActualMaterialInUSD = T.C.value('(ActualMaterialInUSD/text())[1]', 'float'),
		@ActaulMiscCostInUSD = T.C.value('(ActaulMiscCostInUSD/text())[1]', 'float'),
		@MiscCostInUSD = T.C.value('(MiscCostInUSD/text())[1]', 'float')
	FROM @xmlData.nodes('/WOSummaryInfo/WOSummaryCollection/MessageDetail') AS T(c)
	
	SET @JDEWorkOrderId = null
	
	Select @JDEWorkOrderId = JDEWorkOrderId From dbo.JDEWorkOrders Where WorkOrderNumber = @WorkOrderNumber
	
	if @JDEWorkOrderId is null
	BEGIN
	
	INSERT INTO JDEWorkOrders 
	(
		JDEWorkOrderId,
		WorkOrderNumber,
		[Source],
		[Target],
		Method,
		TransactionUserId,
		TransactionId,
		TransactionName,
		[Description],
		DocumentType,
		WorkOrderStatus,
		MiscCost,
		ExchangeRate,
		ActaulLaborInUSD,
		ActualMaterialInUSD,
		ActaulMiscCostInUSD,
		MiscCostInUSD,
		DateAdded,
		LastUpdatedDate
	)
	SELECT 
		NEWID(),
		@WorkOrderNumber,
		@Source,
		@Target,
		@Method,
		@TransactionUserId,
		@TransactionId,
		@TransactionName,
		@Description,
		@DocumentType,
		@WorkOrderStatus,
		@MiscCost,
		@ExchangeRate,
		@ActaulLaborInUSD,
		@ActualMaterialInUSD,
		@ActaulMiscCostInUSD,
		@MiscCostInUSD,
		GETDATE(),
		GETDATE()
	END
	ELSE
	BEGIN
	
	UPDATE JDEWorkOrders 
	SET [Source] = @Source,
		[Target] = @Target,
		Method = @Method,
		TransactionUserId = @TransactionUserId,
		TransactionId = @TransactionId,
		TransactionName = @TransactionName,
		[Description] = @Description,
		DocumentType = @DocumentType,
		WorkOrderStatus = @WorkOrderStatus,
		MiscCost = @MiscCost,
		ExchangeRate = @ExchangeRate,
		ActaulLaborInUSD = @ActaulLaborInUSD,
		ActualMaterialInUSD = @ActualMaterialInUSD,
		ActaulMiscCostInUSD = @ActaulMiscCostInUSD,
		MiscCostInUSD = @MiscCostInUSD,
		LastUpdatedDate = GETDATE()
	WHERE JDEWorkOrderId = @JDEWorkOrderId
	END
	
	;WITH XMLNAMESPACES ('http://www.wft.com/WOSummary/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/WOSummary/Response/v1.0')
	insert into AesImport.dbo.SOAProcessedLog (TransactionId, TransactionName, DateAdded)
	select 
        ltrim(rtrim(@TransactionId)) AS TransactionId,
        ltrim(rtrim(@TransactionName)) AS TransactionName,
		GETDATE()

--IF @@ERROR <> 0
--BEGIN
--	ROLLBACK
--	RAISERROR ('Error in Processing JDE WO Summary Feed, using usp_ProcessJDEWOSummaryFeedXml', 16, 1)
--	RETURN
--END

--COMMIT

END
GO

--WOISSUE
ALTER PROCEDURE [dbo].[usp_ProcessJDEWOSwapInFeedXml]
	@xmlData xml
AS
BEGIN
	SET NOCOUNT ON
	
BEGIN TRANSACTION
	
	DECLARE @JDEWOSwapInFeedId as uniqueidentifier
	DECLARE @InventoryItemNum as varchar(255)
	DECLARE @SerialNum as varchar(255)
	
	Set @JDEWOSwapInFeedId = NEWID()
	
	;WITH XMLNAMESPACES ('http://www.wft.com/WorkOrderIssueInfo/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/WorkOrderIssueInfo/Response/v1.0')
	Select @SerialNum = T.c.value('(LotNumber/text())[1]', 'varchar(30)'),
		@InventoryItemNum = T.c.value('(ItemNumberShort/text())[1]', 'varchar(30)')
	FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)

	;WITH XMLNAMESPACES ('http://www.wft.com/WorkOrderIssueInfo/Response/v1.0' AS inp1,
		DEFAULT 'http://www.wft.com/WorkOrderIssueInfo/Response/v1.0')
	
	INSERT INTO JDEWOSwapInFeeds 
	(
		JDEWOSwapInFeedId, 
		WorkOrderNum, 
		BranchPlant,
		LineNumber,
		JournalEntryLineNumber,
		SerialNum, 
		InventoryItemNum, 
		AssetNumber, 
		Quantity,
		Revision,
		TransactionDate,
		TransactionReference,
		UniqueKeyID,
		ParentSerialNum,
		ProcessState
	)
	SELECT 
		@JDEWOSwapInFeedId,
		T.c.value('(WorkOrderNumber/text())[1]', 'varchar(30)') AS WorkOrderNum,
		T.c.value('(InventoryBranchPlant/text())[1]', 'varchar(12)') AS BranchPlant,
		T.c.value('(LineNumber/text())[1]', 'int') AS LineNumber,
		T.c.value('(JournalEntryLineNumber/text())[1]', 'int') AS JournalEntryLineNumber,
		T.c.value('(LotNumber/text())[1]', 'varchar(30)') AS SerialNum,
		T.c.value('(ItemNumberShort/text())[1]', 'varchar(30)') AS InventoryItemNum,
		T.c.value('(AssetItemNumber/text())[1]', 'varchar(30)') AS AssetNumber,
		T.c.value('(QuantityAvailable/text())[1]', 'int') AS Quantity,
		T.c.value('(LotGrade/text())[1]', 'varchar(2)') AS Revision,
		T.c.value('(TransactionDate/text())[1]', 'datetime') AS TransactionDate,
		T.c.value('(TransactionReference/text())[1]', 'varchar(30)') AS TransactionReference,
		T.c.value('(UniqueKeyID/text())[1]', 'int') AS UniqueKeyID,
		T.c.value('(Reference2/text())[1]', 'varchar(30)') AS ParentSerialNum,
		0 AS ProcessState
	FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageDetail') AS T(c)

	;WITH XMLNAMESPACES ('http://www.wft.com/WorkOrderIssueInfo/Response/v1.0' AS inp1,
	DEFAULT 'http://www.wft.com/WorkOrderIssueInfo/Response/v1.0')

	insert into AesImport.dbo.SOAProcessedLog (TransactionId, TransactionName, DateAdded)
	select 
        ltrim(rtrim(T.c.value('(TransactionId/text())[1]', 'int'))) AS TransactionId,
        ltrim(rtrim(T.c.value('(TransactionName/text())[1]', 'varchar(25)'))) AS TransactionName,
		GETDATE()
	FROM @xmlData.nodes('/WorkOrderInfo/WorkOrderCollection/MessageHeader') AS T(c)
	

--IF @@ERROR <> 0
--BEGIN
--	ROLLBACK
--	RAISERROR ('Error in Processing JDE WO Swap-In Feed, using usp_ProcessJDEWOSwapInFeedXml', 16, 1)
--	RETURN
--END

--COMMIT

END

GO
ALTER PROCEDURE [dbo].[spDeliveryTicketToDispatchSOA]
    @xmlData xml
AS
BEGIN
    SET NOCOUNT ON
    
    DECLARE @jobId UNIQUEIDENTIFIER
    DECLARE @transactionName VARCHAR(MAX)
    DECLARE @transactionId INT
    -- Dispatch fields
    DECLARE @dispatchId UNIQUEIDENTIFIER
    DECLARE @dispatchNum VARCHAR(8)
    DECLARE @jarJobNum VARCHAR(8)
    DECLARE @branchPlant VARCHAR(12)
    DECLARE @jdeCustomerNumber varchar(8)
    DECLARE @dateAdded datetime
    DECLARE @wellName varchar(50)
    DECLARE @wellNameSOA varchar(50)
    DECLARE @wellDetails1 varchar(50)
    DECLARE @wellDetails3 varchar(50)
    DECLARE @rigName varchar(50)
    DECLARE @rigNameSOA varchar(50)
    
    -- Dispatch Instance fields
    DECLARE @dispatchInstanceId UNIQUEIDENTIFIER
    DECLARE @sequenceNum INT
    DECLARE @returnSequenceNum INT
    DECLARE @dateShipped DATETIME
    DECLARE @shipTo VARCHAR(8)
    
    -- Dispatch Instance Item fields
    DECLARE @dispatchInstanceItemId UNIQUEIDENTIFIER
    DECLARE @lineNum INT
    DECLARE @assetNum VARCHAR(15)
    DECLARE @serialNum VARCHAR(20)
    DECLARE @partNum VARCHAR(30)
    DECLARE @description VARCHAR(255)
    DECLARE @qtyShipped INT

    -- Dispatch Instance Item Return fields
    DECLARE @qtyReturned INT
    DECLARE @dateReturned DATETIME
    DECLARE @reasonCode VARCHAR(50)

    -- Dispatch Instance Invoice fields
    DECLARE @invoiceSequence INT
    DECLARE @invoiceNum VARCHAR(20)
    DECLARE @invoiceType VARCHAR(4)
    DECLARE @invoiceCompany VARCHAR(12)
    DECLARE @amountExtendedPrice DECIMAL(19,4)
    DECLARE @foreignExtendedPrice DECIMAL(19,4)
    DECLARE @trxnCurrency VARCHAR(4)
    DECLARE @baseCurrency VARCHAR(4)
    DECLARE @qtySold INT
    DECLARE @dateBilled DATETIME

	DECLARE @jobType varchar(50)

    ;WITH XMLNAMESPACES ('http://www.wft.com/DeliveryTicketInfo/Response/v1.0' AS inp1,
        DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
    SELECT @transactionName = ltrim(rtrim(T.c.value('(TransactionName/text())[1]', 'varchar(MAX)')))
        , @transactionId = ltrim(rtrim(T.c.value('(TransactionId/text())[1]', 'int')))
    FROM @xmlData.nodes('/DTInfoCollection/MessageHeader') AS T(c)

	-- print'TransactionName ' 
	-- print@transactionName
        
    IF (@transactionName = 'DT-SEQ-ADD')
    BEGIN       
        ;WITH XMLNAMESPACES ('http://www.wft.com/DeliveryTicketInfo/Response/v1.0' AS inp1,
            DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
        SELECT @dispatchNum = ltrim(rtrim(T.c.value('(OrderNumber/text())[1]', 'VARCHAR(8)')))
            , @jarJobNum = ltrim(rtrim(T.c.value('(JobNumber/text())[1]', 'VARCHAR(50)')))
			, @jobType = ltrim(rtrim(T.c.value('(JobType/text())[1]', 'VARCHAR(50)')))
            , @jdeCustomerNumber = ltrim(rtrim(T.c.value('(Customer/text())[1]', 'VARCHAR(10)')))
            , @branchPlant = ltrim(rtrim(T.c.value('(BranchPlant/text())[1]', 'VARCHAR(12)')))
            , @dateAdded = T.c.value('(CreationDate/text())[1]', 'DATETIME')
            , @sequenceNum = T.c.value('(SequenceNumber)[1]', 'INT')
            , @shipTo = ltrim(rtrim(T.c.value('(ShipTo/text())[1]', 'VARCHAR(8)')))
            , @wellDetails1 = ltrim(rtrim(T.c.value('(WellDetails1/text())[1]','VARCHAR(50)')))
            , @wellDetails3 = ltrim(rtrim(T.c.value('(WellDetails3/text())[1]','VARCHAR(50)')))
            , @wellNameSOA = ltrim(rtrim(T.c.value('(WellName/text())[1]','VARCHAR(50)')))
            , @rigNameSOA = ltrim(rtrim(T.c.value('(Rig/text())[1]','VARCHAR(50)')))
        FROM @xmlData.nodes('/DTInfoCollection/MessageDetail') AS T(c)
    
        --if ((select DispatchId from Dispatches where JDEJobNumber = @jarJobNum) is not null)
        --begin
        --  --TODO: new warning system
        --  select '200'
        --end
        
        SET @wellName = NULL
        SET @rigName = NULL
        
if (@jarJobNum <> '')
        begin
			SELECT 
				@jobId = j.JobId
				, @rigName = j.Rig
				, @wellName = w.well
			FROM Jobs (NOLOCK) j
			left join Wells (NOLOCK) w ON w.JobID = j.JobId
			WHERE j.JobNumber = @jarJobNum
        end

		if (@jobId is null)
		begin
			select
				@jobId = j.JobId
				, @rigName = j.Rig
				, @wellName = w.well
			from Jobs (NOLOCK) j
			left join Wells (NOLOCK) w on w.JobID = j.JobId
			where j.DispatchNumber = @dispatchNum
		end
		
        if @wellName is null
        begin
            SET @wellName = @wellNameSOA
        end
        
        if @rigName is null
        begin
            SET @rigName = @rigNameSOA
        end
        
        -- Check Dispatch whether exists
        set @dispatchId = null
        SELECT @dispatchId = DispatchId FROM Dispatches (NOLOCK) WHERE DispatchNumber = @dispatchNum
        
        IF (@dispatchId IS NULL)
        BEGIN
            SET @dispatchId = NEWID()
            INSERT INTO Dispatches (DispatchId, DispatchNumber, JDEJobNumber, JDECustomerNumber, BranchPlant, WellName, WellDetails1, WellDetails3, RigName, DateLastEdit, DateAdded, JobId)
            VALUES (@dispatchId, @dispatchNum, @jarJobNum, @jdeCustomerNumber, @branchPlant, @wellName, @wellDetails1, @wellDetails3, @rigName, GETDATE(), @dateAdded, @jobId)
        END
        
        set @dispatchInstanceId = null
        SELECT @dispatchInstanceId = DispatchInstanceId 
        FROM DispatchInstances (NOLOCK) 
        WHERE SequenceNum = @sequenceNum
            AND DispatchId = @dispatchId
            AND (ShipType = 'DT-SEQ-ADD')
                    
        IF (@dispatchInstanceId IS NULL)
        BEGIN
            SET @dispatchInstanceId = NEWID()
            INSERT INTO DispatchInstances (DispatchInstanceId, SequenceNum, DispatchId, ShipTo, DateLastEdit, DateAdded, ShipType, JobType)
            VALUES (@dispatchInstanceId, @sequenceNum, @dispatchId, @shipTo, GETDATE(), @dateAdded, @transactionName, @jobType)
        END
    END
    ELSE IF (@transactionName = 'DT-SEQ-CHANGE')
    BEGIN       
        ;WITH XMLNAMESPACES ('http://www.wft.com/DeliveryTicketInfo/Response/v1.0' AS inp1,
            DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
        SELECT @dispatchNum = ltrim(rtrim(T.c.value('(OrderNumber/text())[1]', 'VARCHAR(8)')))
            , @jarJobNum = ltrim(rtrim(T.c.value('(JobNumber/text())[1]', 'VARCHAR(8)')))
            , @jdeCustomerNumber = ltrim(rtrim(T.c.value('(Customer/text())[1]', 'VARCHAR(10)')))
            , @branchPlant = ltrim(rtrim(T.c.value('(BranchPlant/text())[1]', 'VARCHAR(12)')))
            , @sequenceNum = T.c.value('(SequenceNumber)[1]', 'INT')
            , @shipTo = ltrim(rtrim(T.c.value('(ShipTo/text())[1]', 'VARCHAR(8)')))
            , @wellDetails1 = ltrim(rtrim(T.c.value('(WellDetails1/text())[1]','VARCHAR(50)')))
            , @wellDetails3 = ltrim(rtrim(T.c.value('(WellDetails3/text())[1]','VARCHAR(50)')))
            , @wellNameSOA = ltrim(rtrim(T.c.value('(WellName/text())[1]','VARCHAR(50)')))
            , @rigNameSOA = ltrim(rtrim(T.c.value('(Rig/text())[1]','VARCHAR(50)')))
        FROM @xmlData.nodes('/DTInfoCollection/MessageDetail') AS T(c)
        
        set @dispatchId = null
        SELECT @dispatchId = DispatchId
        FROM Dispatches (NOLOCK) 
        WHERE DispatchNumber = @dispatchNum
        
        set @dispatchInstanceId = null
        SELECT @dispatchInstanceId = DispatchInstanceId
        FROM DispatchInstances (NOLOCK) 
        WHERE DispatchId = @dispatchId
            AND SequenceNum = @sequenceNum
            
        SET @wellName = NULL
        SET @rigName = NULL
        SELECT 
            @jobId = j.JobId
            , @rigName = j.Rig
            , @wellName = w.well
        FROM Jobs (NOLOCK) j
        left join Wells (NOLOCK) w ON w.JobID = j.JobId
        WHERE j.JobNumber = LTRIM(RTRIM(@jarJobNum))

        if @wellName is null
    begin
            SET @wellName = @wellNameSOA
        end
        
        if @rigName is null
        begin
   SET @rigName = @rigNameSOA
        end

        if @dispatchId is null
        begin
            --select '-200'
            return          -- Dispatch is not found
        end
        else
        begin
            UPDATE Dispatches SET JDEJobNumber = @jarJobNum
                , JDECustomerNumber = @jdeCustomerNumber
                , BranchPlant = @branchPlant
                , WellName = @wellName
                , WellDetails1 = @wellDetails1
                , WellDetails3 = @wellDetails3
                , RigName = @rigName
                , JobId = @jobId
            WHERE DispatchId = @dispatchId
        end
                
        if @dispatchInstanceId is null
        begin
            --select '-201'
            return          -- Dispatch Instance is not found
        end
        else
        begin
            UPDATE DispatchInstances SET ShipTo = @shipTo
            WHERE DispatchInstanceId = @dispatchInstanceId
        end
        
    END
    ELSE IF (@transactionName = 'DT-SHIP')
    BEGIN
        
        ;WITH XMLNAMESPACES ('http://www.wft.com/DeliveryTicketInfo/Response/v1.0' AS inp1,
            DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
        SELECT @dispatchNum = ltrim(rtrim(T.c.value('(OrderNumber/text())[1]', 'VARCHAR(8)')))
            , @sequenceNum = T.c.value('(SequenceNumber)[1]', 'INT')
            , @lineNum = T.c.value('(LineNumber)[1]', 'INT')
            , @assetNum = ltrim(rtrim(T.c.value('(AssetNumber/text())[1]', 'VARCHAR(15)')))
            , @serialNum = ltrim(rtrim(T.c.value('(SerialNumber/text())[1]', 'VARCHAR(20)')))
            , @partNum = ltrim(rtrim(T.c.value('(LongItemNumber/text())[1]', 'VARCHAR(30)')))
            , @description = ltrim(rtrim(T.c.value('(Description1/text())[1]', 'VARCHAR(255)')))
            , @dateShipped = T.c.value('(DateShipConfirmed/text())[1]', 'DATETIME')
            , @qtyShipped = T.c.value('(QuantityShipped)[1]', 'INT')
            , @dateAdded = T.c.value('(DateofTransaction/text())[1]', 'DATETIME')
			, @shipTo = ltrim(rtrim(T.c.value('(ShipTo/text())[1]', 'VARCHAR(8)')))
        FROM @xmlData.nodes('/DTInfoCollection/MessageDetail') AS T(c)
        


        if @serialNum is null or @serialNum = ''
        begin
			--select '-205'
			return
        end
        
        set @dispatchId = null
        SELECT @dispatchId = DispatchId
        FROM Dispatches (NOLOCK) 
        WHERE DispatchNumber = @dispatchNum
        
		 print'dispatchid'
		 print @dispatchid

        if @dispatchId is null
        begin
            --select '-200'
            return          -- Dispatch is not found
        end
        else
        begin
            set @dispatchInstanceId = null
            SELECT @dispatchInstanceId = DispatchInstanceId
            FROM DispatchInstances (NOLOCK) 
            WHERE DispatchId = @dispatchId
                AND SequenceNum = @sequenceNum
                AND (ShipType = 'DT-SEQ-ADD')           

			
            if @dispatchInstanceId is null
            begin
				
				SET @dispatchInstanceId = NEWID()

				INSERT INTO DispatchInstances (DispatchInstanceId, SequenceNum, DispatchId, ShipTo, DateLastEdit, DateAdded, ShipType, JobType)
				VALUES (@dispatchInstanceId, @sequenceNum, @dispatchId, @shipTo, GETDATE(), @dateAdded, 'DT-SEQ-ADD', 'Missing Message')

                --select '-201'
                --return      -- Dispatch Instance is not found
            end
            --else
            --begin
                UPDATE DispatchInstances SET DateShipped = @dateShipped
                WHERE DispatchInstanceId = @dispatchInstanceId
                
                set @dispatchInstanceItemId = null
                SELECT @dispatchInstanceItemId = DispatchInstanceItemId 
                FROM DispatchInstanceItems (NOLOCK) 
                WHERE DispatchInstanceId = @dispatchInstanceId
                    AND LineNumber = @lineNum
                    
                if @dispatchInstanceItemId is null
                begin   
                    INSERT INTO DispatchInstanceItems (DispatchInstanceItemId, DispatchInstanceId, LineNumber, AssetNumber, SerialNum, ItemNum, Description, QtyShipped, DateAdded, JDETxnNum)
                    VALUES (NEWID(), @dispatchInstanceId, @lineNum, @assetNum, @serialNum, @partNum, @description, @qtyShipped, @dateAdded, @transactionId)
                end
                --else
                --begin
                --  select 'warning- line item exists'
                --end
            --end
        end
    END
    ELSE IF (@transactionName = 'DT-RETURN')
    BEGIN
        ;WITH XMLNAMESPACES ('http://www.wft.com/DeliveryTicketInfo/Response/v1.0' AS inp1,
        DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
        SELECT @dispatchNum = ltrim(rtrim(T.c.value('(OrderNumber/text())[1]', 'VARCHAR(8)')))
            , @sequenceNum = T.c.value('(SequenceNumber)[1]', 'INT')
            , @returnSequenceNum = T.c.value('(ReturnSequence)[1]', 'INT')
            , @lineNum = T.c.value('(LineNumber)[1]', 'INT')
            , @assetNum = ltrim(rtrim(T.c.value('(AssetNumber/text())[1]', 'VARCHAR(15)')))
            , @serialNum = ltrim(rtrim(T.c.value('(SerialNumber/text())[1]', 'VARCHAR(20)')))
            , @partNum = ltrim(rtrim(T.c.value('(LongItemNumber/text())[1]', 'VARCHAR(30)')))
            , @description = ltrim(rtrim(T.c.value('(Description1/text())[1]', 'VARCHAR(255)')))
            , @qtyReturned = T.c.value('(ReturnQuantity)[1]', 'INT')
            , @dateReturned = T.c.value('(ReturnDate/text())[1]', 'DATETIME')
            , @reasonCode = ltrim(rtrim(T.c.value('(ReasonCode/text())[1]', 'VARCHAR(50)')))
			, @jobType = ltrim(rtrim(T.c.value('(JobType/text())[1]', 'VARCHAR(50)')))
        FROM @xmlData.nodes('/DTInfoCollection/MessageDetail') AS T(c)
        
        set @dispatchId = null
        SELECT @dispatchId = DispatchId
        FROM Dispatches (NOLOCK) 
        WHERE DispatchNumber = @dispatchNum
        
        if @dispatchId is null
        begin
            --select '-200'
            return              -- Dispatch is not found
        end
        begin
            set @dispatchInstanceId = null
            SELECT @dispatchInstanceId = DispatchInstanceId 
            FROM DispatchInstances (NOLOCK) 
            WHERE DispatchId = @dispatchId
                AND SequenceNum = @sequenceNum
                AND ShipType = 'DT-SEQ-ADD'
                
            if @dispatchInstanceId is null
            begin
                --select '-201'
                return          -- Dispatch Instance is not found
            end
            begin
                select @dispatchInstanceItemId = DispatchInstanceItemId
                from DispatchInstanceItems (NOLOCK) 
                WHERE DispatchInstanceId = @dispatchInstanceId
                    AND AssetNumber = @assetNum
                    
                if (@dispatchInstanceItemId is null)
                begin
                    --select '-203'
                    return      -- Asset was not found on DT-SHIP sequence
                end
                else
                begin
                    UPDATE DispatchInstanceItems SET QtyReturned = @qtyReturned
                        , DateReturned = @dateReturned
                        , ReasonCode = @reasonCode
                    where DispatchInstanceItemId = @dispatchInstanceItemId
                end
            end

            SET @dispatchInstanceId = null
            SELECT @dispatchInstanceId = DispatchInstanceId 
            FROM DispatchInstances (NOLOCK) 
            WHERE DispatchId = @dispatchId
                AND SequenceNum = @ReturnSequenceNum
                AND ShipType = @transactionName

            if @dispatchInstanceId is null
            begin
                -- Create new instance for returns
                SET @dispatchInstanceId = NEWID()
                INSERT INTO DispatchInstances (DispatchInstanceId, SequenceNum, DispatchId, DateAdded, ShipType, DateShipped, ReturnSequenceNum, JobType)
                VALUES (@dispatchInstanceId, @returnSequenceNum, @dispatchId, GETDATE(), @transactionName, @dateReturned, @returnSequenceNum, @jobType)
            end

            SET @dispatchInstanceItemId = null
            SELECT @dispatchInstanceItemId = DispatchInstanceItemId
            FROM DispatchInstanceItems (NOLOCK) 
            WHERE DispatchInstanceId = @dispatchInstanceId
                AND AssetNumber = @assetNum
            
            if @dispatchInstanceItemId is null
            begin
            SET @dispatchInstanceItemId = NEWID()
                INSERT INTO DispatchInstanceItems (DispatchInstanceItemId, DispatchInstanceId, LineNumber, AssetNumber, SerialNum, ItemNum, QtyReturned, DateReturned, ReasonCode, Description, QtyShipped, DateAdded, JDETxnNum)
                VALUES (@dispatchInstanceItemId, @dispatchInstanceId, @lineNum, @assetNum, @serialNum, @partNum, @qtyReturned, @dateReturned, @reasonCode, @description, 0, GETDATE(), @transactionId)
            end
        end
    END
    ELSE IF (@transactionName = 'DT-INVOICE')
    BEGIN
        ;WITH XMLNAMESPACES ('http://www.wft.com/DeliveryTicketInfo/Response/v1.0' AS inp1,
        DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
        SELECT @dispatchNum = ltrim(rtrim(T.c.value('(OrderNumber/text())[1]', 'VARCHAR(8)')))
            , @sequenceNum = T.c.value('(SequenceNumber)[1]', 'INT')
            , @lineNum = T.c.value('(LineNumber)[1]', 'INT')
            , @shipTo = ltrim(rtrim(T.c.value('(ShipTo/text())[1]', 'VARCHAR(8)')))
            , @assetNum = ltrim(rtrim(T.c.value('(AssetNumber/text())[1]', 'VARCHAR(15)')))
            , @serialNum = ltrim(rtrim(T.c.value('(SerialNumber/text())[1]', 'VARCHAR(20)')))
            , @partNum = ltrim(rtrim(T.c.value('(LongItemNumber/text())[1]', 'VARCHAR(30)')))
            , @description = ltrim(rtrim(T.c.value('(Description1/text())[1]', 'VARCHAR(255)')))
            , @qtyShipped = T.c.value('(QuantityShipped)[1]', 'INT')
            , @dateAdded = T.c.value('(DateofTransaction/text())[1]', 'DATETIME')
            , @reasonCode = ltrim(rtrim(T.c.value('(ReasonCode/text())[1]', 'VARCHAR(50)')))
            , @invoiceSequence = T.c.value('(InvoiceSequence)[1]', 'INT')
            , @invoiceNum = ltrim(rtrim(T.c.value('(InvoiceNum)[1]', 'VARCHAR(20)')))
            , @invoiceType = ltrim(rtrim(T.c.value('(InvoiceType)[1]','VARCHAR(4)')))
            , @invoiceCompany = ltrim(rtrim(T.c.value('(InvoiceCompany)[1]', 'VARCHAR(12)')))
            , @amountExtendedPrice = T.c.value('(AmountExtendedPrice)[1]', 'DECIMAL(19,4)')
            , @foreignExtendedPrice = T.c.value('(ForeignExtendedPrice)[1]', 'DECIMAL(19,4)')
            , @trxnCurrency = ltrim(rtrim(T.c.value('(TransactionCurrency)[1]', 'VARCHAR(4)')))
            , @baseCurrency = ltrim(rtrim(T.c.value('(BaseCurrency)[1]', 'VARCHAR(4)')))
            , @qtySold = T.c.value('(SoldQuantity)[1]', 'INT')
            , @dateBilled = T.c.value('(BillDate)[1]', 'DATETIME')
			, @jobType = ltrim(rtrim(T.c.value('(JobType/text())[1]', 'VARCHAR(50)')))
        FROM @xmlData.nodes('/DTInfoCollection/MessageDetail') AS T(c)       
            
        set @dispatchId = null
        SELECT @dispatchId = DispatchId
        FROM Dispatches (NOLOCK) 
        WHERE DispatchNumber = @dispatchNum
        
        if @dispatchId is null
        begin
            --select '-200'
            return                  -- Dispatch is not found
   end
        begin
            set @dispatchInstanceId = null
            SELECT @dispatchInstanceId = DispatchInstanceId
            FROM DispatchInstances (NOLOCK) 
            WHERE DispatchId = @dispatchId
                AND InvoiceSequenceNum = @invoiceSequence
                AND InvoiceNum = @invoiceNum
                AND (ShipType = 'DT-INVOICE')           

           if @dispatchInstanceId is not null
            begin
                UPDATE DispatchInstances SET InvoiceType = @invoiceType, InvoiceCompany = @invoiceCompany
                WHERE DispatchInstanceId = @dispatchInstanceId
                
                set @dispatchInstanceItemId = null
                SELECT @dispatchInstanceItemId = DispatchInstanceItemId 
                FROM DispatchInstanceItems (NOLOCK) 
                WHERE DispatchInstanceId = @dispatchInstanceId
                    AND LineNumber = @lineNum
            end
            else
            begin
                SET @dispatchInstanceId = NEWID()
                INSERT INTO DispatchInstances (DispatchInstanceId, SequenceNum, DispatchId, ShipTo, DateLastEdit, DateAdded, ShipType,
                    InvoiceSequenceNum, InvoiceNum, InvoiceType, InvoiceCompany, JobType)
                VALUES (@dispatchInstanceId, @sequenceNum, @dispatchId, @shipTo, GETDATE(), @dateAdded, @transactionName,
                    @invoiceSequence, @invoiceNum, @invoiceType, @invoiceCompany, @jobType)
            end

            if @dispatchInstanceItemId is null
            begin   
                INSERT INTO DispatchInstanceItems (DispatchInstanceItemId, DispatchInstanceId, LineNumber, AssetNumber, SerialNum, ItemNum, Description, QtyShipped, DateAdded, JDETxnNum, 
                    AmountExtendedPrice, ForeignExtendedPrice, TrxnCurrency, BaseCurrency, QtySold, DateBilled)
                VALUES (NEWID(), @dispatchInstanceId, @lineNum, @assetNum, @serialNum, @partNum, @description, @qtyShipped, @dateAdded, @transactionId,
                    @amountExtendedPrice, @foreignExtendedPrice, @trxnCurrency, @baseCurrency, @qtySold, @dateBilled)
            end
            --TODO: throw exception
            --else
            --begin
            --end
        end
    END
    ELSE IF (@transactionName = 'DT-UNRETURN')
    BEGIN
        ;WITH XMLNAMESPACES ('http://www.wft.com/DeliveryTicketInfo/Response/v1.0' AS inp1,
        DEFAULT 'http://www.wft.com/DeliveryTicketInfo/Response/v1.0')
        SELECT @dispatchNum = ltrim(rtrim(T.c.value('(OrderNumber/text())[1]', 'VARCHAR(8)')))
            , @sequenceNum = T.c.value('(SequenceNumber)[1]', 'INT')
            , @returnSequenceNum = T.c.value('(ReturnSequence)[1]', 'INT')
            , @lineNum = T.c.value('(LineNumber)[1]', 'INT')
            , @assetNum = ltrim(rtrim(T.c.value('(AssetNumber/text())[1]', 'VARCHAR(15)')))
            , @serialNum = ltrim(rtrim(T.c.value('(SerialNumber/text())[1]', 'VARCHAR(20)')))
            , @partNum = ltrim(rtrim(T.c.value('(LongItemNumber/text())[1]', 'VARCHAR(30)')))
            , @qtyReturned = T.c.value('(ReturnQuantity)[1]', 'INT')
            , @dateReturned = T.c.value('(ReturnDate/text())[1]', 'DATETIME')
            , @reasonCode = ltrim(rtrim(T.c.value('(ReasonCode/text())[1]', 'VARCHAR(50)')))
        FROM @xmlData.nodes('/DTInfoCollection/MessageDetail') AS T(c)
        
        set @dispatchId = null
        SELECT @dispatchId = DispatchId
        FROM Dispatches (NOLOCK) 
        WHERE DispatchNumber = @dispatchNum
        
        if @dispatchId is null
        begin
            --select '-200'
            return                  -- Dispatch is not found
        end
        begin
            set @dispatchInstanceId = null
            SELECT @dispatchInstanceId = DispatchInstanceId
            FROM DispatchInstances (NOLOCK) 
            WHERE DispatchId = @dispatchId
                AND SequenceNum = @sequenceNum
                AND ShipType = 'DT-SEQ-ADD'

            -- Undo QtyReturned for original ship record
            if @dispatchInstanceId is null
            begin
                --select '-201'
                return                  -- Dispatch Instance (DT-SHIP) is not found
            end
            else            
            begin
                select @dispatchInstanceItemId = DispatchInstanceItemId 
                from DispatchInstanceItems (NOLOCK) 
                WHERE DispatchInstanceId = @dispatchInstanceId
                    AND AssetNumber = @assetNum
                    
                if (@dispatchInstanceItemId is null)
                begin
                    --select '-203'
                    return              -- Asset item not found on DT-SHIP seq
          end
                else
                begin
                    UPDATE DispatchInstanceItems 
                    SET QtyReturned = QtyReturned - @qtyReturned
                        --, DateReturned = NULL
                        --, ReasonCode = NULL
                    where DispatchInstanceItemId = @dispatchInstanceItemId              

                    UPDATE DispatchInstanceItems
                    SET DateReturned = NULL
                    WHERE QtyReturned = 0
                        and DispatchInstanceItemId = @dispatchInstanceItemId                
                end
            end             

            set @dispatchInstanceId = null
            SELECT @dispatchInstanceId = DispatchInstanceId
            FROM DispatchInstances (NOLOCK) 
            WHERE DispatchId = @dispatchId
                AND SequenceNum = @sequenceNum
                AND ReturnSequenceNum = @returnSequenceNum
                AND ShipType = 'DT-RETURN'
        
            -- Undo QtyReturned for Return Item record
            if @dispatchInstanceId is null
            begin
                --select '-202'
                return              -- Dispatch Instance (DT-Return) is not found
            end
            begin
                select @dispatchInstanceItemId = DispatchInstanceItemId
                from DispatchInstanceItems  (NOLOCK) 
                WHERE DispatchInstanceId = @dispatchInstanceId
                    AND AssetNumber = @assetNum

                if @dispatchInstanceItemId is null
                begin
                    --select '-204'
                    return          -- Asset is not found on DT-Return 
                end
                else
                begin
                    UPDATE DispatchInstanceItems 
                    SET QtyReturned = QtyReturned - @qtyReturned
                        , DateReturned = NULL
                        --, ReasonCode = NULL
                    where DispatchInstanceItemId = @dispatchInstanceItemId              

                    DELETE FROM DispatchInstanceItems 
                    WHERE DispatchInstanceId = @dispatchInstanceId
                        AND QtyReturned <= 0
                end
            end
        end
    END
    
	insert into AesImport.dbo.SOAProcessedLog (TransactionId, TransactionName, DateAdded)
	values (@transactionId, @transactionName, GETDATE())

--    select '0'
END

GO
/****** Object:  StoredProcedure [dbo].[usp_SOA_AssetFeedJob]    Script Date: 5/31/2018 11:44:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 4/20/2017
-- Description:	This procedure is used to read SOA Asset XML feed from remote server 
--				and process it in MyAdvisor 
-- =============================================
ALTER PROCEDURE [dbo].[usp_SOA_AssetFeedJob] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @JobQueueId INT, @JobStartDate datetime
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;  

	IF NOT EXISTS (SELECT * FROM JobQueue (NOLOCK) WHERE JobId = 48 AND JobQueueStatusId = 1)
	BEGIN

		SELECT @JobStartDate = GETDATE()

		INSERT INTO JobQueue (JobId, CreateDate, RequestXml, RunStart, RunEnd, JobQueueStatusId, CurrentRetry)
		VALUES (48, @JobStartDate, '<usp_SOA_FeedJob/>', @JobStartDate, NULL, 1, 0)

		SELECT @JobQueueId = SCOPE_IDENTITY()

		BEGIN TRY

			-- Insert statements for procedure here
			DECLARE @transactionId varchar(40), @transactionName varchar(40), @payload xml, @Id1 VARCHAR(200), @RunStart datetime,  @RunEnd datetime, @flag bit

			DECLARE db_cursor1 CURSOR FOR  
				SELECT TransactionId, TransactionName, PayLoad, ID1
				FROM USDCALADBBL01.aesSoa.dbo.vwSOAMessagesRemote
				WHERE Status IS NULL 
					AND TransactionName IN ('ASSTADD', 'ASSTDISP', 'ASSTREV', 'ASSTTFR', 'ASSTUPD', 'WO-CHANGE-OUT', 'WO-CREATE-OUT', 'WO-CLOSE', 'WOISSUE'
						, 'DT-INVOICE' ,'DT-RETURN' ,'DT-SEQ-ADD' ,'DT-SEQ-CHANGE' ,'DT-SEQ-DELETE' ,'DT-SHIP' ,'DT-UNRETURN')
					--AND TransactionId > (SELECT MAX(JDETransactionId) FROM Aesops.dbo.PartTransferDtl (NOLOCK))
				ORDER BY [TimeStamp] ASC
 
			OPEN db_cursor1   
			FETCH NEXT FROM db_cursor1 INTO @transactionId, @transactionName, @payload, @Id1

			WHILE @@FETCH_STATUS = 0   
			BEGIN   
	
				DECLARE @TranCounter INT;  
				SET @TranCounter = @@TRANCOUNT;  

				--Declare Transaction
				IF @TranCounter > 0  
					SAVE TRANSACTION ProcedureSave;  
				ELSE  
					BEGIN TRANSACTION;  
    
				BEGIN TRY  

					-- Do the actual work here
					SELECT @RunStart = GETDATE(), @flag = 0
		 

					IF(@transactionName = 'ASSTUPD' OR @transactionName = 'ASSTTFR' OR @transactionName = 'ASSTDISP' OR @transactionName = 'ASSTREV' OR @transactionName = 'ASSTADD')
						BEGIN 
							EXEC AesOps.[dbo].[usp_SOA_AssetFeedProcess] @payload, @flag output, @ErrorMessage output
						END

					ELSE IF (@transactionName = 'WO-CREATE-OUT' OR @transactionName = 'WO-CHANGE-OUT')
						BEGIN
							EXEC AesOps.[dbo].[usp_ProcessJDEWOOutboundFeedXml] @payload
						END
					ELSE IF (@transactionName = 'WO-CLOSE')
						BEGIN
							EXEC AesOps.[dbo].[usp_ProcessJDEWOSummaryFeedXml] @payload
						END
					ELSE IF (@transactionName = 'WOISSUE')
						BEGIN
							EXEC AesOps.[dbo].[usp_ProcessJDEWOSwapInFeedXml] @payload
						END
					ELSE
						BEGIN
							EXEC AesOps.[dbo].[spDeliveryTicketToDispatchSOA] @payload
						END
						 
					IF @TranCounter = 0  
						BEGIN
							COMMIT TRANSACTION;  
						END
				END TRY  
				BEGIN CATCH  

					IF @TranCounter = 0  
						ROLLBACK TRANSACTION;  
					ELSE  
            
						IF XACT_STATE() <> -1  
							ROLLBACK TRANSACTION ProcedureSave;  
            
					SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();  

					--RAISERROR (@ErrorMessage, @ErrorSeverity, , @ErrorState);  
				END CATCH  

				-- if message processing failed due to validation or error log it
				if(@flag != 1)
				BEGIN
					DECLARE @payloadstring VARCHAR(MAX) = CONVERT(varchar(MAX), @payload)
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
				SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE(); 

				INSERT INTO [dbo].[JobLog] ([JobId],[RunStart],[RunEnd],[RequestXml],[JobLogStatusId],[JobQueueId],[Exception],[RetryNumber])
				VALUES (48, @JobStartDate, Getdate(), null, 4, @JobQueueId, @ErrorMessage, 0)

			END CATCH
	END

END

