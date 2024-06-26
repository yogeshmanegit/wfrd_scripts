USE [JDEJobs]
GO
/****** Object:  StoredProcedure [dbo].[hdrProfile_InsertUpdateUserChoice]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[hdrProfile_InsertUpdateUserChoice]
	@ReportId INT,
	@OperationId INT,
	@DeliveryTicketNumber BIGINT,
	@Level1Id INT,
	@Level2Id INT,
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;

    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('hdrProfile_InsertUpdateUserChoice'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;

	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START hdrProfile User Choice PROCESS');
	--Audit Notification ********************************************************************************************
    BEGIN TRY

	

	CREATE TABLE #MDMLevels (Level3Id INT, Level4Id INT);

	--IF OperationId=200, use RentalEquipment.  If OperationId= 204, Use SalesEquipment
	IF @OperationId = 200
	BEGIN
		--  Select distinct Level3Id, Level4Id from {Sales/Rental}Equipment where DeliveryTicketNumber = @DT and Level2ID = @LEvel2
		INSERT INTO #MDMLevels (Level3Id, Level4Id)
		SELECT DISTINCT Level3Id, Level4Id FROM WPTSRentalEquipment a
		JOIN DISJobHistory.dbo.OrgDataLevels b ON a.HyperionPLCode= b.MDMLevel4Code
		WHERE 
		a.DeliveryTicketNumber = @DeliveryTicketNumber
		AND b.level2id = @Level2Id

	END
	ELSE IF @OperationId = 204
	BEGIN
		--  Select distinct Level3Id, Level4Id from {Sales/Rental}Equipment where DeliveryTicketNumber = @DT and Level2ID = @LEvel2	
		INSERT INTO #MDMLevels (Level3Id, Level4Id)
		SELECT DISTINCT Level3Id, Level4Id FROM WPTSSalesEquipment a
		JOIN DISJobHistory.dbo.OrgDataLevels b ON a.HyperionPLCode= b.MDMLevel4Code
		WHERE 
		a.DeliveryTicketNumber = @DeliveryTicketNumber
		AND b.level2id = @Level2Id

	END

	   DECLARE @Level3ID INT;
	   DECLARE @Level4ID INT;
	   DECLARE @Level3IdUserChoice INT;
	   DECLARE @Level4IdUserChoice INT;	   
	   Declare @level3DbFieldId INT
	   Declare @level4DbFieldId INT
	   
	   select @level3DbFieldId=id from DISJobHistory.dbo.dbFields where dbFieldName = 'Level3ID' and T = 'HdrProfile'
	   select @level4DbFieldId=id from DISJobHistory.dbo.dbFields where dbFieldName = 'Level4ID' and T = 'HdrProfile'	

	  --BEGIN TRANSACTION

	  --Delete the UserChoiceValues
	  --print 'Delete User Choice Values'
	  EXEC [DISJobHistory].[dbo].[sp_DeleteUserChoiceValue] @dbFieldID=@level3DbFieldId, @ReportID=@ReportID,@RunNo=NULL
	  EXEC [DISJobHistory].[dbo].[sp_DeleteUserChoiceValue] @dbFieldID=@level4DbFieldId, @ReportID=@ReportID,@RunNo=NULL

	   --Loop across Level 3 Results
	   WHILE (SELECT COUNT(1) FROM #MDMLevels WHERE Level3ID IS NOT NULL) > 0
	   BEGIN
		  SELECT TOP 1 @Level3ID = Level3ID FROM #MDMLevels WHERE Level3Id IS NOT NULL;

		  --Insert the UserChoiceValues
		  --print 'Insert User Choice Values'
		  EXEC [DISJobHistory].[dbo].[sp_InsertUserChoiceValue] @KeyID=0, @dbFieldID=@level3DbFieldId, @ReportID=@ReportID, @UserChoice=@Level3ID, @SubTableCounter=NULL, @RunNo=NULL, @UserChoiceKeyID = @Level3IdUserChoice OUTPUT, @UserChoiceString=NULL

		  UPDATE #MDMLevels SET Level3Id = NULL WHERE Level3Id = @Level3ID
	   END


	   --Loop across Level 4 Results
	   WHILE (SELECT COUNT(1) FROM #MDMLevels WHERE Level4ID IS NOT NULL) > 0
	   BEGIN
		  SELECT TOP 1 @Level4ID = Level4ID FROM #MDMLevels WHERE Level4Id IS NOT NULL;

		  --Insert the UserChoiceValues
		  EXEC [DISJobHistory].[dbo].[sp_InsertUserChoiceValue] @KeyID=0, @dbFieldID=@level4DbFieldId, @ReportID=@ReportID, @UserChoice=@Level4ID, @SubTableCounter=NULL, @RunNo=NULL, @UserChoiceKeyID = @Level4IdUserChoice OUTPUT, @UserChoiceString=NULL

		  UPDATE #MDMLevels SET Level4Id = NULL WHERE Level4Id = @Level4ID
	   END

	   --UPDATE hdrProfile
	   UPDATE DISJobHistory.dbo.HdrProfile SET Level1ID = @Level1ID, Level2ID = @Level2ID, Level3Id = @Level3IdUserChoice, Level4Id = @Level4IdUserChoice WHERE ReportId = @ReportId;

	  --COMMIT TRANSACTION
	   DROP TABLE #MDMLevels;


    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************
    END CATCH
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END hdrProfile User Choice PROCESS');
	--Audit Notification ********************************************************************************************


	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END
END
GO
/****** Object:  StoredProcedure [dbo].[hdrProfile_InsertUpdateUserChoice_General]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[hdrProfile_InsertUpdateUserChoice_General]
	@ReportId INT,
	@OperationId INT,
	@DeliveryTicketNumber BIGINT,
	@Level1Id INT,
	@Level2Id INT,
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
	,@Level3Id Int,
	@Level4Id int
AS
BEGIN
    SET NOCOUNT ON;

    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('hdrProfile_InsertUpdateUserChoice'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;

	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START hdrProfile User Choice PROCESS');
	--Audit Notification ********************************************************************************************
    BEGIN TRY

	

	--CREATE TABLE #MDMLevels (Level3Id INT, Level4Id INT);

	----IF OperationId=200, use RentalEquipment.  If OperationId= 204, Use SalesEquipment
	--IF @OperationId = 200
	--BEGIN
	--	--  Select distinct Level3Id, Level4Id from {Sales/Rental}Equipment where DeliveryTicketNumber = @DT and Level2ID = @LEvel2
	--	INSERT INTO #MDMLevels (Level3Id, Level4Id)
	--	SELECT DISTINCT Level3Id, Level4Id FROM WPTSRentalEquipment a
	--	JOIN DISJobHistory.dbo.OrgDataLevels b ON a.HyperionPLCode= b.MDMLevel4Code
	--	WHERE 
	--	a.DeliveryTicketNumber = @DeliveryTicketNumber
	--	AND b.level2id = @Level2Id

	--END
	--ELSE IF @OperationId = 204
	--BEGIN
	--	--  Select distinct Level3Id, Level4Id from {Sales/Rental}Equipment where DeliveryTicketNumber = @DT and Level2ID = @LEvel2	
	--	INSERT INTO #MDMLevels (Level3Id, Level4Id)
	--	SELECT DISTINCT Level3Id, Level4Id FROM WPTSSalesEquipment a
	--	JOIN DISJobHistory.dbo.OrgDataLevels b ON a.HyperionPLCode= b.MDMLevel4Code
	--	WHERE 
	--	a.DeliveryTicketNumber = @DeliveryTicketNumber
	--	AND b.level2id = @Level2Id

	--END

	   --DECLARE @Level3ID INT;
	   --DECLARE @Level4ID INT;
	   DECLARE @Level3IdUserChoice INT;
	   DECLARE @Level4IdUserChoice INT;	   	
	   Declare @level3DbFieldId INT
	   Declare @level4DbFieldId INT
	   
	   select @level3DbFieldId=id from DISJobHistory.dbo.dbFields where dbFieldName = 'Level3ID' and T = 'HdrProfile'
	   select @level4DbFieldId=id from DISJobHistory.dbo.dbFields where dbFieldName = 'Level4ID' and T = 'HdrProfile'
	  --BEGIN TRANSACTION
	  --DKG: we need to change the way this works. This is probably what is causing things to be overwritten in jobs that are completed.
	  --Delete the UserChoiceValues
	  EXEC [DISJobHistory].[dbo].[sp_DeleteUserChoiceValue] @dbFieldID=@level3DbFieldId, @ReportID=@ReportID,@RunNo=NULL
	  EXEC [DISJobHistory].[dbo].[sp_DeleteUserChoiceValue] @dbFieldID=@level4DbFieldId, @ReportID=@ReportID,@RunNo=NULL

	   --Loop across Level 3 Results
	   --WHILE (SELECT COUNT(1) FROM #MDMLevels WHERE Level3ID IS NOT NULL) > 0
	   --BEGIN
		  --SELECT TOP 1 @Level3ID = Level3ID FROM #MDMLevels WHERE Level3Id IS NOT NULL;

		  --Insert the UserChoiceValues
	  EXEC [DISJobHistory].[dbo].[sp_InsertUserChoiceValue] @KeyID=0, @dbFieldID=@level3DbFieldId, @ReportID=@ReportID, @UserChoice=@Level3ID, @SubTableCounter=NULL, @RunNo=NULL, @UserChoiceKeyID = @Level3IdUserChoice OUTPUT, @UserChoiceString=NULL

		  --UPDATE #MDMLevels SET Level3Id = NULL WHERE Level3Id = @Level3ID
	   --END


	   --Loop across Level 4 Results
	   --WHILE (SELECT COUNT(1) FROM #MDMLevels WHERE Level4ID IS NOT NULL) > 0
	   --BEGIN
		  --SELECT TOP 1 @Level4ID = Level4ID FROM #MDMLevels WHERE Level4Id IS NOT NULL;

		  --Insert the UserChoiceValues
		  EXEC [DISJobHistory].[dbo].[sp_InsertUserChoiceValue] @KeyID=0, @dbFieldID=@level4DbFieldId, @ReportID=@ReportID, @UserChoice=@Level4ID, @SubTableCounter=NULL, @RunNo=NULL, @UserChoiceKeyID = @Level4IdUserChoice OUTPUT, @UserChoiceString=NULL

		  --UPDATE #MDMLevels SET Level4Id = NULL WHERE Level4Id = @Level4ID
	   --END

	   --UPDATE hdrProfile
	   UPDATE DISJobHistory.dbo.HdrProfile SET Level1ID = @Level1ID, Level2ID = @Level2ID, Level3Id = @Level3IdUserChoice, Level4Id = @Level4IdUserChoice WHERE ReportId = @ReportId;

	  --COMMIT TRANSACTION
	   --DROP TABLE #MDMLevels;


    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************
    END CATCH
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END hdrProfile User Choice PROCESS');
	--Audit Notification ********************************************************************************************


	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END
END

GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromETLtoStaging]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Rental_MoveFromETLtoStaging]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ReturnCode INT;
    DECLARE @mEmailAddress NVARCHAR(50);
    DECLARE @mEmailSubject NVARCHAR(200);
    DECLARE @mEmailHTML NVARCHAR(MAX);

    SET @mEmailAddress = 'DLGBSMPerformanceTrackingSystem@weatherford.com';
    SET @mEmailSubject = 'Warning: JDE Integration Error.';
    SET @mEmailHTML = 'Check the AuditLogs in JDEJobs table.  An error occurred in one of the Rental_MoveFromETLtoStaging stored procedures.';


    ----STEP 1:  Mark records without details as IsProcessed so they will be skipped.
    --UPDATE ETLSequence SET IsProcessed = 1 WHERE NOT EXISTS (
	   --SELECT DISTINCT b.DeliveryTicketNumber FROM ETLSequenceEquipment b WHERE ETLSequence.DeliveryTicketNumber = b.DeliveryTicketNumber 
    --)

    --UPDATE ETLHeader SET IsProcessed = 1 WHERE NOT EXISTS (
	   --SELECT DISTINCT b.DeliveryTicketNumber FROM ETLSequence b WHERE ETLHeader.DeliveryTicketNumber = b.DeliveryTicketNumber
    --)
    ----Mark Header records as processed if the Product Line Id is missing
    --UPDATE ETLHeader SET IsProcessed = 1 WHERE (ProductLineId IS NULL OR ProductLineId ='') AND IsProcessed = 0
	--STEP 1:  Mark records without details as IsProcessed so they will be skipped.
    UPDATE ETLSequence SET IsProcessed = 1 WHERE NOT EXISTS (
	   SELECT DISTINCT b.DeliveryTicketNumber 
	   FROM ETLSequenceEquipment b 
	   join ETLSequence etls on b.DeliveryTicketNumber = etls.DeliveryTicketNumber	   
	   join ETLHeader etlh on etls.DeliveryTicketNumber = etlh.DeliveryTicketNumber
	   left join ProductLineOrgLevel4 plo4 on etlh.ProductLineId = plo4.ProductLineId	   
	   WHERE ETLSequence.DeliveryTicketNumber = b.DeliveryTicketNumber 
	   and etls.OrderStatus in( 'SHP','CLD', 'RTN' , 'PAR')
	   and plo4.Level4Id is null
    )

    UPDATE ETLHeader SET IsProcessed = 1 WHERE NOT EXISTS (
	   SELECT DISTINCT etls.DeliveryTicketNumber 
	   FROM ETLSequence etls 	   
	   join ETLHeader etlh on etls.DeliveryTicketNumber = etlh.DeliveryTicketNumber
	   left join ProductLineOrgLevel4 plo4 on etlh.ProductLineId = plo4.ProductLineId
	   WHERE ETLHeader.DeliveryTicketNumber = etls.DeliveryTicketNumber 
	   and etls.OrderStatus in( 'SHP','CLD', 'RTN' , 'PAR')
	   and plo4.Level4Id is null
    )
    --Mark Header records as processed if the Product Line Id is missing
 --   UPDATE ETLHeader SET IsProcessed = 1 
	--from ProductLineOrgLevel4 plo4 
	--WHERE (ProductLineId IS NULL OR ProductLineId ='') AND IsProcessed = 0

    --Step 2: Process the Header Records
    EXEC @ReturnCode = [dbo].[Rental_MoveFromETLtoStaging_HEADER] @aIsAuditEnabled

    --Step 3: Process the Rental Records
    IF @ReturnCode = 1
    BEGIN
	   EXEC @ReturnCode = [dbo].[Rental_MoveFromETLtoStaging_RENTAL] @aIsAuditEnabled
    END

    --Step 4: Process the Equipment Records
    IF @ReturnCode = 1
    BEGIN
	   --Process the Equipment Records 10,000 at a time
	   WHILE (SELECT COUNT(1)
	   FROM ETLSequenceEquipment a
	   JOIN WPTSRental b ON a.DeliveryTicketNumber = b.DeliveryTicketNumber AND a.Sequence = b.Sequence and a.invoicenumber = b.invoicenumber
	   WHERE a.IsProcessed = 0) > 0
		  BEGIN
			 IF @ReturnCode = 1
			 BEGIN
				EXEC @ReturnCode = [dbo].[Rental_MoveFromETLtoStaging_EQUIPMENT] @aIsAuditEnabled
			 END

			 IF @ReturnCode = 0
				BREAK
			 ELSE
				CONTINUE
		  END
    END

    --Step 5: Send error e-mail if needed.
    IF @ReturnCode = 0
    BEGIN
        EXEC [DISJobHistory].[dbo].usp_smtp_sendmail @To = @mEmailAddress ,@Subject = @mEmailSubject, @message = @mEmailHTML
    END
END



GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromETLtoStaging_EQUIPMENT]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Rental_MoveFromETLtoStaging_EQUIPMENT]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromETLtoStaging_EQUIPMENT'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mReturnValue		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mReturnValue		= 1;


	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   BEGIN TRANSACTION


	   PRINT 'START WPTSRentalEquipment PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START WPTSRentalEquipment PROCESS');
	   --Audit Notification ********************************************************************************************


	   --Insert/Update WPTS Rental Equipment Records
	   CREATE TABLE #ETLSequenceEquipment (DeliveryTicketNumber BIGINT, Sequence INT, OrderLineNumber FLOAT, InvoiceNumber BIGINT) ON [PRIMARY]
	   CREATE UNIQUE CLUSTERED INDEX #IX_TempETLSequenceEquipment on #ETLSequenceEquipment (DeliveryTicketNumber,Sequence,OrderLineNumber);

	   --Only select ALS records
	   INSERT INTO #ETLSequenceEquipment (DeliveryTicketNumber, Sequence, OrderLineNumber) 
	   SELECT TOP 10000 a.DeliveryTicketNumber, a.Sequence, a.OrderLineNumber
	   FROM ETLSequenceEquipment a
	   JOIN WPTSRental b ON a.DeliveryTicketNumber = b.DeliveryTicketNumber AND a.Sequence = b.Sequence and a.invoicenumber = b.invoicenumber
	   WHERE a.IsProcessed = 0;

	   DECLARE @OrderLineNumber FLOAT;
	   DECLARE @DeliveryTicketNumber BIGINT;
	   DECLARE @Sequence INT;


	   WHILE (SELECT COUNT(1) FROM #ETLSequenceEquipment) > 0
	   BEGIN
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, @Sequence = Sequence, @OrderLineNumber = OrderLineNumber FROM #ETLSequenceEquipment;

		  --CONVERT Sequence to RENTAL
		  IF EXISTS (SELECT * FROM WPTSRentalEquipment WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND OrderLineNumber = @OrderLineNumber)
			 BEGIN
				UPDATE Destination
				SET
				    Destination.LineNumber = Source.SequenceLineNumber,
				    Destination.Quantity = Source.Quantity,
				    Destination.SerialNumber = Source.SerialNumber,
				    Destination.Description = Source.Description,
				    Destination.ItemNumber = Source.ItemNumber,
				    Destination.ReferenceNumber = Source.ReferenceNumber,
				    Destination.InvUOM = Source.InvUOM,
				    Destination.PriceUOM = Source.PriceUOM,
				    Destination.BillUnits = Source.BillUnits,
				    Destination.GLCode = CASE WHEN Source.GLCode = '' THEN NULL ELSE Source.GLCode END,
				    Destination.HyperionPLCode = Source.HyperionPLCode,
				    Destination.LastJDEUpdateDate = Source.LastJDEUpdateDate,
				    Destination.InvoiceNumber = Source.InvoiceNumber,
				    Destination.IsProcessed = 0
				FROM WPTSRentalEquipment Destination
				JOIN ETLSequenceEquipment Source ON Destination.DeliveryTicketNumber = Source.DeliveryTicketNumber AND Destination.Sequence = Source.Sequence AND Destination.OrderLineNumber = Source.OrderLineNumber
				WHERE
				    Destination.DeliveryTicketNumber = @DeliveryTicketNumber
				    AND Destination.Sequence = @Sequence
				    AND Destination.OrderLineNumber = @OrderLineNumber
				    --AND Destination.InvoiceNumber = @InvoiceNumber
			 END
		  ELSE
			 BEGIN
				INSERT INTO WPTSRentalEquipment (
				    DeliveryTicketNumber,
				    Sequence,
				    LineNumber,
				    OrderLineNumber,
				    Quantity,
				    SerialNumber,
				    Description,
				    ItemNumber,
				    ReferenceNumber,
				    InvUOM,
				    PriceUOM,
				    BillUnits,
				    InvoiceNumber,
				    GLCode,
				    HyperionPLCode,
				    LastJDEUpdateDate,
				    IsProcessed)
				SELECT
				    DeliveryTicketNumber,
				    Sequence,
				    SequenceLineNumber,
				    OrderLineNumber,
				    Quantity,
				    SerialNumber,
				    Description,
				    ItemNumber,
				    ReferenceNumber,
				    InvUOM,
				    PriceUOM,
				    BillUnits,
				    InvoiceNumber,
				    CASE WHEN GLCode = '' THEN NULL ELSE GLCode END,
				    HyperionPLCode,
				    LastJDEUpdateDate,
				    0
				FROM ETLSequenceEquipment
				WHERE DeliveryTicketNumber = @DeliveryTicketNumber
				AND Sequence = @Sequence
				AND OrderLineNumber = @OrderLineNumber
				--ANd InvoiceNumber = @InvoiceNumber
			 END

		  UPDATE ETLSequenceEquipment SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND @OrderLineNumber = OrderLineNumber;

		  DELETE FROM #ETLSequenceEquipment WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND @OrderLineNumber = OrderLineNumber;
	   END

	   DROP TABLE #ETLSequenceEquipment;


	   PRINT 'END WPTSRentalEquipment PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END WPTSRentalEquipment PROCESS');
	   --Audit Notification ********************************************************************************************


	   COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************    


    
	--If Audit Logging is enabled, write the Table Variable to the database
	--Else, only write the Warnings and Errors
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END


    RETURN @mReturnValue;
END



GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromETLtoStaging_HEADER]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Rental_MoveFromETLtoStaging_HEADER]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromETLtoStaging_HEADER'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mLocation_Land		INT;
    DECLARE @mLocation_Offshore	INT;
    DECLARE @mReturnValue		INT;
	DECLARE @mOperationID		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mTemplateName		= 'Rental';
    SET	  @mLocation_Land		= 2444;
    SET	  @mLocation_Offshore	= 2446;
    SET	  @mReturnValue		= 1;
	SET   @mOperationID		= 200; -- Hard Coded Rental Operation ID.


	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   BEGIN TRANSACTION




	   PRINT 'Start Move from ETL to WPTS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Move from ETL to WPTS');
	   --Audit Notification ********************************************************************************************

	   CREATE TABLE #ETLHeader (DeliveryTicketNumber BIGINT, Level1ID INT, Level2ID INT, Level3ID INT, Level4ID INT,WFTLocationId INT) ON [PRIMARY]
	   CREATE UNIQUE CLUSTERED INDEX #IX_TempETLHeader on #ETLHeader (DeliveryTicketNumber);
	   
	   --Insert/Update WPTS Header Records
	   --Only get ALS records
	   INSERT INTO #ETLHeader (DeliveryTicketNumber,Level1ID,Level2ID,WFTLocationId)
	   SELECT distinct a.DeliveryTicketNumber,c.Level1ID,c.Level2ID,
	   --coalesce((select top 1 locationid from disjobhistory.dbo.hdrwftlocations where propertyid =mpl.LEASE_NUM),(select top 1 WFTLocationId from BranchPlantWFTLocation where a.BusinessUnitId = BranchPlantId)) as WFTLocationId	   
	   coalesce(
			(select top 1 locationid 
			from disjobhistory.dbo.hdrwftlocations hl
			join
			--where propertyid =
			(select top 1 mpl.LEASE_NUM 
			from DISJobHistory.mdm.MDMPhysicalLocation mpl 
			where a.BusinessUnitId = mpl.BRANCH_PLANT_NUMBER
			order by branch_plant_number, PRIMARY_USE_FLG desc, ACTV_FLG desc
			) tmpdata on hl.PropertyID = tmpdata.LEASE_NUM
			)
			,(select top 1 WFTLocationId from BranchPlantWFTLocation where a.BusinessUnitId = BranchPlantId)
		) as WFTLocationId
	   FROM ETLHeader a
	   left join ETLSequence ets on ets.DeliveryTicketNumber = a.DeliveryTicketNumber
	   --left join DISJobHistory.mdm.MDMPhysicalLocation mpl on a.BusinessUnitId = mpl.BRANCH_PLANT_NUMBER and (coalesce(a.ProductLineId,ets.ProductLineId) is not null and mpl.PRODLN_CD like '%'+ coalesce(a.ProductLineId,ets.ProductLineId)+'%' )
	   JOIN EDI_MDM_MAPPING b ON coalesce(a.ProductLineId,ets.ProductLineId) = b.EDI
	   JOIN DISJobHistory.dbo.OrgDataLevel2 c ON b.MDM= c.MDMLevel2Code
	   WHERE (c.MDMLevel1Code = 'ALS' or c.MDMLevel1Code = 'RS'
	   )
	   AND a.IsProcessed = 0;
	   
	   --CREATE TABLE #ETLHeader (DeliveryTicketNumber BIGINT, Level1ID INT, Level2ID INT) ON [PRIMARY]
	   --CREATE UNIQUE CLUSTERED INDEX #IX_TempETLHeader on #ETLHeader (DeliveryTicketNumber);

	   ----Only get ALS records
	   --INSERT INTO #ETLHeader (DeliveryTicketNumber,Level1ID,Level2ID) 
	   --SELECT a.DeliveryTicketNumber,c.Level1ID,c.Level2ID
	   --FROM ETLHeader a
	   --JOIN EDI_MDM_MAPPING b ON a.ProductLineId = b.EDI
	   --JOIN DISJobHistory.dbo.OrgDataLevel2 c ON b.MDM= c.MDMLevel2Code
	   --WHERE (c.MDMLevel1Code = 'ALS' --or c.MDMLevel1Code = 'RS'
	   --)
	   --AND a.IsProcessed = 0;

	   DECLARE @DeliveryTicketNumber BIGINT;
	   --WPTS Header Fields
	   DECLARE @JobStart DATETIME;
	   DECLARE @CustomerId INT;
	   DECLARE @WellPhysicalLocationId INT;
	   DECLARE @WellName NVARCHAR(75);
	   DECLARE @Rig NVARCHAR(50);
	   DECLARE @Field NVARCHAR(75);
	   DECLARE @WellLocationCountryId INT;
	   DECLARE @Lease NVARCHAR(75);
	   DECLARE @ContactName NVARCHAR(100);
	   DECLARE @ContactPhoneOffice NVARCHAR(50);
	   DECLARE @WFTSalesName NVARCHAR(100);
	   DECLARE @OrderNumber NVARCHAR(50);
	   DECLARE @InputById INT;
	   DECLARE @ETLCustomerId BIGINT;
	   DECLARE @ETLCustomerName NVARCHAR(MAX);
	   DECLARE @JDECreatedDate DATETIME;
	   DECLARE @Level1ID INT;
	   DECLARE @Level2ID INT;
	   DECLARE @Level3ID INT;
	   DECLARE @Level4ID INT;
	   DECLARE @WFTLocationId int;


	   PRINT 'START WPTSHeader PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START WPTSHeader PROCESS');
	   --Audit Notification ********************************************************************************************

	   WHILE (SELECT COUNT(1) FROM #ETLHeader) > 0
	   BEGIN
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, @Level1ID = Level1ID, @Level2ID = Level2ID, @WFTLocationId=WFTLocationId FROM #ETLHeader;

		  --Reset Values used in later statements
		  SET @WellLocationCountryId = NULL;
		  SET @WellPhysicalLocationId = NULL;
		  SET @WellName = NULL;
		  SET @Rig = NULL;
		  SET @Field = NULL;
		  SET @Lease = NULL;
		  SET @OrderNumber = NULL;
		  SET @ETLCustomerId = NULL;
		  SET @ETLCustomerName = NULL;
		  SET @JDECreatedDate = NULL;

		  PRINT 'START PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) );
		  --Audit Notification ********************************************************************************************


		  PRINT 'START GET VALUES FROM HEADER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START GET VALUES FROM HEADER');
		  --Audit Notification ********************************************************************************************

		  -- GET VALUES FROM HEADER
		  SELECT 
			 @WellLocationCountryId = WPTSCountry.countryID,
			 @WellPhysicalLocationId = CASE WHEN WellPhysicalLocation = 'LAN' THEN @mLocation_Land WHEN WellPhysicalLocation = 'OFF' THEN @mLocation_Offshore ELSE NULL END,
			 @WellName = ETLHeader.WellNameNumber,
			 @Rig = ETLHeader.Rig,
			 @Field = ETLHeader.Field,
			 @Lease = ETLHeader.Lease,
			 @OrderNumber =  CASE WHEN ETLHeader.OrderNumber = '' THEN NULL ELSE ETLHeader.OrderNumber END,
			 @ETLCustomerId = ETLHeader.CustomerId,
			 @ETLCustomerName = ETLCustomer.Name,
			 @JDECreatedDate = ETLHeader.JDECreatedDate
		  FROM ETLHeader
		  LEFT JOIN WPTSCountry ON ETLHeader.WellLocationCountryCode = WPTSCountry.CountryCode
		  JOIN ETLCustomer ON ETLHeader.CustomerId = ETLCustomer.Id
		  WHERE ETLHeader.DeliveryTicketNumber = @DeliveryTicketNumber


		  PRINT 'END GET VALUES FROM HEADER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END GET VALUES FROM HEADER');
		  --Audit Notification ********************************************************************************************





		  PRINT 'START GET VALUES FROM FIRST SEQUENCE RECORD'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START GET VALUES FROM FIRST SEQUENCE RECORD');
		  --Audit Notification ********************************************************************************************
		  
		  -- GET VALUES FROM FIRST SEQUENCE RECORD
		  SELECT TOP (1) 
			 @InputById = DISJobHistory.dbo.fnGetUserIDforUserName(ETLSequence.PreparedBy),
			 @JobStart = ETLSequence.ShippedDate,
			 @WFTSalesName = ETLSequence.WFTSalesman,
			 @ContactName = ETLSequence.CustomerContactName,
			 @ContactPhoneOffice = ETLSequence.CustomerContactPhone
		  FROM ETLSequence
		  WHERE ETLSequence.DeliveryTicketNumber = @DeliveryTicketNumber
		  and ETLSequence.OrderStatus in( 'SHP','CLD', 'RTN' , 'PAR')
		  ORDER BY Sequence ASC


		  PRINT 'END GET VALUES FROM FIRST SEQUENCE RECORD'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END GET VALUES FROM FIRST SEQUENCE RECORD');
		  --Audit Notification ********************************************************************************************



		  PRINT 'START GET VALUES FROM CUSTOMER Id: ' + CAST(@CustomerId as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START GET VALUES FROM CUSTOMER');
		  --Audit Notification ********************************************************************************************


		  -- GET Value FROM Customer
 		  EXEC [DISJobHistory].[dbo].[sp_InsertUpdateCustomers] @ETLCustomerName, @ETLCustomerId, @CustomerId OUTPUT


		  PRINT 'END GET VALUES FROM CUSTOMER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END GET VALUES FROM CUSTOMER');
		  --Audit Notification ********************************************************************************************





		  PRINT 'START INSERT/UPDATE WPTSHeader'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START INSERT/UPDATE WPTSHeader');
		  --Audit Notification ********************************************************************************************

		  --INSERT/UPDATE WPTSHeader
		  IF EXISTS (SELECT * FROM WPTSHeader WHERE DeliveryTicketNumber = @DeliveryTicketNumber)
			 BEGIN
				UPDATE WPTSHeader SET
					WPTSHeader.Level1ID = @Level1ID,
					WPTSHeader.Level2ID = @Level2ID,
					WPTSHeader.OperationId = @mOperationID,
				    WPTSHeader.JobStart		  = @JDECreatedDate,
				    WPTSHeader.CustomerId	  = @CustomerId,
				    WPTSHeader.WellLocationId	  = @WellPhysicalLocationId,
				    WPTSHeader.WellName		  = @WellName,
				    WPTSHeader.Field		  = @Field,
				    WPTSHeader.Rig			  = @Rig,
				    WPTSHeader.CountryId		  = @WellLocationCountryId,
				    WPTSHeader.Lease		  = @Lease,
				    WPTSHeader.ContactNme	  = @ContactName,
				    WPTSHeader.ContactPhoneOffice = @ContactPhoneOffice,
				    WPTSHeader.WFDSalesNme	  = @WFTSalesName,
				    WPTSHeader.CustOrderNo	  = @OrderNumber,
				    WPTSHeader.InputById		  = @InputById,
				    WPTSHeader.IsProcessed	  = 0,
					WPTSHeader.WFTLocationId = @WFTLocationId
				WHERE DeliveryTicketNumber	  = @DeliveryTicketNumber
			 END
		  ELSE
			 BEGIN
				INSERT INTO WPTSHeader (
				    DeliveryTicketNumber,
				    OperationId,
					Level1ID,
					Level2ID,
				    JobStart,
				    CustomerId,
				    WellLocationId,
				    WellName,
				    Field,
				    Rig,
				    CountryId,
				    Lease,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    CustOrderNo,
				    InputById,
				    IsProcessed,
					WFTLocationId)
				VALUES (
				    @DeliveryTicketNumber,
				    @mOperationID,
					@Level1ID,
					@Level2ID,
				    @JDECreatedDate,
				    @CustomerId,
				    @WellPhysicalLocationId,
				    @WellName,
				    @Field,
				    @Rig,
				    @WellLocationCountryId,
				    @Lease,
				    @ContactName,
				    @ContactPhoneOffice,
				    @WFTSalesName,
				    @OrderNumber,
				    @InputById,
				    0,
					@WFTLocationId)
			 END


		  UPDATE ETLHeader SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber;





		  PRINT 'END INSERT/UPDATE WPTSHeader'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END INSERT/UPDATE WPTSHeader');
		  --Audit Notification ********************************************************************************************


		  PRINT 'END PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) );
		  --Audit Notification ********************************************************************************************


		  DELETE FROM #ETLHeader WHERE DeliveryTicketNumber = @DeliveryTicketNumber;
	   END

	   DROP TABLE #ETLHeader;


	   PRINT 'END WPTSHeader PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END WPTSHeader PROCESS');
	   --Audit Notification ********************************************************************************************


	   PRINT 'End Move from ETL to WPTS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Move from ETL to WPTS');
	   --Audit Notification ********************************************************************************************


	   COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************    


    
	--If Audit Logging is enabled, write the Table Variable to the database
	--Else, only write the Warnings and Errors
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END



GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromETLtoStaging_HEADER_General]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Rental_MoveFromETLtoStaging_HEADER_General]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromETLtoStaging_HEADER_General'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    --DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mLocation_Land		INT;
    DECLARE @mLocation_Offshore	INT;
    DECLARE @mReturnValue		INT;
	--DECLARE @mOperationID		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    --SET	  @mTemplateName		= 'Rental';
    SET	  @mLocation_Land		= 2444;
    SET	  @mLocation_Offshore	= 2446;
    SET	  @mReturnValue		= 1;
	--SET   @mOperationID		= 200; -- Hard Coded Rental Operation ID.


	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   BEGIN TRANSACTION




	   PRINT 'Start Move from ETL to WPTS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Move from ETL to WPTS');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Header Records
	   CREATE TABLE #ETLHeader (DeliveryTicketNumber BIGINT, Level1ID INT, Level2ID INT, Level3ID INT, Level4ID INT,WFTLocationId INT) ON [PRIMARY]
	   CREATE UNIQUE CLUSTERED INDEX #IX_TempETLHeader on #ETLHeader (DeliveryTicketNumber);

	   --Only get records with Bp to WFT Location Mappings
	   INSERT INTO #ETLHeader (DeliveryTicketNumber,WFTLocationId,Level1ID,Level2ID,Level3ID,Level4ID) 
	   select eh.DeliveryTicketNumber,bpl.WFTLocationId,ol1.Level1ID,ol2.Level2ID,ol3.Level3ID,ol4.Level4ID
		from ETLHeader eh
		join BranchPlantWFTLocation bpl on eh.BusinessUnitId = bpl.BranchPlantId
		--join ProductLineOrgLevel4 plo4 on plo4.ProductLineId = eh.ProductLineId
		join ProductLineOrgLevel4 plo4 on plo4.ProductLineId = coalesce(nullif(eh.ProductLineId,''),(select top 1 productlineid
		from ETLSequence ets where ets.deliveryticketnumber =eh.DeliveryTicketNumber))
		join DISJobHistory.dbo.OrgDataLevel4 ol4 on plo4.Level4Id = ol4.Level4ID
		join DISJobHistory.dbo.OrgDataLevel3 ol3 on ol4.Level3ID = ol3.Level3ID
		join DISJobHistory.dbo.OrgDataLevel2 ol2 on ol3.Level2ID = ol2.Level2ID
		join DISJobHistory.dbo.OrgDataLevel1 ol1 on ol2.Level1ID = ol1.Level1ID
	   --SELECT a.DeliveryTicketNumber,c.Level1ID,c.Level2ID
	   --FROM ETLHeader a
	   --JOIN EDI_MDM_MAPPING b ON a.ProductLineId = b.EDI
	   --JOIN DISJobHistory.dbo.OrgDataLevel2 c ON b.MDM= c.MDMLevel2Code
	   --WHERE c.MDMLevel1Code = 'ALS'
	   where eh.IsProcessed = 0 and eh.JDECreatedDate >= '2017-2-22'
	   and bpl.BranchPlantId not in (10249, 10250);
	  
	   --select * from #ETLHeader
	   --drop table #ETLHeader;
	   -- return;
	   DECLARE @DeliveryTicketNumber BIGINT;
	   --WPTS Header Fields
	   DECLARE @JobStart DATETIME;
	   DECLARE @CustomerId INT;
	   DECLARE @WellPhysicalLocationId INT;
	   DECLARE @WellName NVARCHAR(75);
	   DECLARE @Rig NVARCHAR(50);
	   DECLARE @Field NVARCHAR(75);
	   DECLARE @WellLocationCountryId INT;
	   DECLARE @Lease NVARCHAR(75);
	   DECLARE @ContactName NVARCHAR(100);
	   DECLARE @ContactPhoneOffice NVARCHAR(50);
	   DECLARE @WFTSalesName NVARCHAR(100);
	   DECLARE @OrderNumber NVARCHAR(50);
	   DECLARE @InputById INT;
	   DECLARE @ETLCustomerId BIGINT;
	   DECLARE @ETLCustomerName NVARCHAR(MAX);
	   DECLARE @JDECreatedDate DATETIME;
	   DECLARE @Level1ID INT;
	   DECLARE @Level2ID INT;
	   DECLARE @Level3ID INT;
	   DECLARE @Level4ID INT;
	   DECLARE @WFTLocationId int;


	   PRINT 'START WPTSHeader_General PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START WPTSHeader_General PROCESS');
	   --Audit Notification ********************************************************************************************

	   WHILE (SELECT COUNT(1) FROM #ETLHeader) > 0
	   BEGIN
		  SELECT TOP 1 
		  @DeliveryTicketNumber = DeliveryTicketNumber, 
		  @Level1ID = Level1ID, 
		  @Level2ID = Level2ID, 
		  @Level3ID = Level3ID, 
		  @Level4ID = Level4ID,
		  @WFTLocationId =WFTLocationId
		  FROM #ETLHeader;		  
		  --Reset Values used in later statements
		  SET @WellLocationCountryId = NULL;
		  SET @WellPhysicalLocationId = NULL;
		  SET @WellName = NULL;
		  SET @Rig = NULL;
		  SET @Field = NULL;
		  SET @Lease = NULL;
		  SET @OrderNumber = NULL;
		  SET @ETLCustomerId = NULL;
		  SET @ETLCustomerName = NULL;
		  SET @JDECreatedDate = NULL;

		  PRINT 'START PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) );
		  --Audit Notification ********************************************************************************************


		  PRINT 'START GET VALUES FROM HEADER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START GET VALUES FROM HEADER');
		  --Audit Notification ********************************************************************************************

		  -- GET VALUES FROM HEADER
		  SELECT 
			 @WellLocationCountryId = WPTSCountry.countryID,
			 @WellPhysicalLocationId = CASE WHEN WellPhysicalLocation = 'LAN' THEN @mLocation_Land WHEN WellPhysicalLocation = 'OFF' THEN @mLocation_Offshore ELSE NULL END,
			 @WellName = ETLHeader.WellNameNumber,
			 @Rig = ETLHeader.Rig,
			 @Field = ETLHeader.Field,
			 @Lease = ETLHeader.Lease,
			 @OrderNumber =  CASE WHEN ETLHeader.OrderNumber = '' THEN NULL ELSE ETLHeader.OrderNumber END,
			 @ETLCustomerId = ETLHeader.CustomerId,
			 @ETLCustomerName = ETLCustomer.Name,
			 @JDECreatedDate = ETLHeader.JDECreatedDate
		  FROM ETLHeader
		  LEFT JOIN WPTSCountry ON ETLHeader.WellLocationCountryCode = WPTSCountry.CountryCode
		  JOIN ETLCustomer ON ETLHeader.CustomerId = ETLCustomer.Id
		  WHERE ETLHeader.DeliveryTicketNumber = @DeliveryTicketNumber


		  PRINT 'END GET VALUES FROM HEADER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END GET VALUES FROM HEADER');
		  --Audit Notification ********************************************************************************************





		  PRINT 'START GET VALUES FROM FIRST SEQUENCE RECORD'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START GET VALUES FROM FIRST SEQUENCE RECORD');
		  --Audit Notification ********************************************************************************************
		  
		  -- GET VALUES FROM FIRST SEQUENCE RECORD
		  SELECT TOP (1) 
			 @InputById = DISJobHistory.dbo.fnGetUserIDforUserName(ETLSequence.PreparedBy),
			 @JobStart = ETLSequence.ShippedDate,
			 @WFTSalesName = ETLSequence.WFTSalesman,
			 @ContactName = ETLSequence.CustomerContactName,
			 @ContactPhoneOffice = ETLSequence.CustomerContactPhone
		  FROM ETLSequence
		  WHERE ETLSequence.DeliveryTicketNumber = @DeliveryTicketNumber
		  ORDER BY Sequence ASC


		  PRINT 'END GET VALUES FROM FIRST SEQUENCE RECORD'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END GET VALUES FROM FIRST SEQUENCE RECORD');
		  --Audit Notification ********************************************************************************************



		  PRINT 'START GET VALUES FROM CUSTOMER Id: ' + CAST(@CustomerId as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START GET VALUES FROM CUSTOMER');
		  --Audit Notification ********************************************************************************************


		  -- GET Value FROM Customer
 		  EXEC [DISJobHistory].[dbo].[sp_InsertUpdateCustomers] @ETLCustomerName, @ETLCustomerId, @CustomerId OUTPUT


		  PRINT 'END GET VALUES FROM CUSTOMER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END GET VALUES FROM CUSTOMER');
		  --Audit Notification ********************************************************************************************





		  PRINT 'START INSERT/UPDATE WPTSHeader_General'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START INSERT/UPDATE WPTSHeader_General');
		  --Audit Notification ********************************************************************************************

		  --INSERT/UPDATE WPTSHeader_General
		  IF EXISTS (SELECT * FROM WPTSHeader_General WHERE DeliveryTicketNumber = @DeliveryTicketNumber)
			 BEGIN
				UPDATE WPTSHeader_General SET
					WPTSHeader_General.Level1ID = @Level1ID,
					WPTSHeader_General.Level2ID = @Level2ID,
					WPTSHeader_General.Level3ID = @Level3ID,
					WPTSHeader_General.Level4ID = @Level4ID,
					--WPTSHeader_General.OperationId = @mOperationID,
				    WPTSHeader_General.JobStart		  = @JDECreatedDate,
				    WPTSHeader_General.CustomerId	  = @CustomerId,
				    WPTSHeader_General.WellLocationId	  = @WellPhysicalLocationId,
				    WPTSHeader_General.WellName		  = @WellName,
				    WPTSHeader_General.Field		  = @Field,
				    WPTSHeader_General.Rig			  = @Rig,
				    WPTSHeader_General.CountryId		  = @WellLocationCountryId,
				    WPTSHeader_General.Lease		  = @Lease,
				    WPTSHeader_General.ContactNme	  = @ContactName,
				    WPTSHeader_General.ContactPhoneOffice = @ContactPhoneOffice,
				    WPTSHeader_General.WFDSalesNme	  = @WFTSalesName,
				    WPTSHeader_General.CustOrderNo	  = @OrderNumber,
				    WPTSHeader_General.InputById		  = @InputById,
				    WPTSHeader_General.IsProcessed	  = 0,
					WPTSHeader_General.WFTLocationId = @WFTLocationId
				WHERE DeliveryTicketNumber	  = @DeliveryTicketNumber
			 END
		  ELSE
			 BEGIN
				INSERT INTO WPTSHeader_General (
				    DeliveryTicketNumber,
				    --OperationId,
					Level1ID,
					Level2ID,
					Level3ID,
					Level4ID,
				    JobStart,
				    CustomerId,
				    WellLocationId,
				    WellName,
				    Field,
				    Rig,
				    CountryId,
				    Lease,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    CustOrderNo,
				    InputById,
				    IsProcessed,
					WFTLocationId)
				VALUES (
				    @DeliveryTicketNumber,
				    --@mOperationID,
					@Level1ID,
					@Level2ID,
					@Level3ID,
					@Level4ID,
				    @JDECreatedDate,
				    @CustomerId,
				    @WellPhysicalLocationId,
				    @WellName,
				    @Field,
				    @Rig,
				    @WellLocationCountryId,
				    @Lease,
				    @ContactName,
				    @ContactPhoneOffice,
				    @WFTSalesName,
				    @OrderNumber,
				    @InputById,
				    0,
					@WFTLocationId)
			 END

--Only set IsProcessed = true if the record gets created in WPTSHeader_General
		  UPDATE ETLHeader SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber
		  and exists (select top 1 DeliveryTicketNumber from WPTSHeader_General where DeliveryTicketNumber = @DeliveryTicketNumber);





		  PRINT 'END INSERT/UPDATE WPTSHeader_General'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END INSERT/UPDATE WPTSHeader_General');
		  --Audit Notification ********************************************************************************************


		  PRINT 'END PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) );
		  --Audit Notification ********************************************************************************************


		  DELETE FROM #ETLHeader WHERE DeliveryTicketNumber = @DeliveryTicketNumber;
	   END

	   DROP TABLE #ETLHeader;


	   PRINT 'END WPTSHeader_General PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END WPTSHeader_General PROCESS');
	   --Audit Notification ********************************************************************************************


	   PRINT 'End Move from ETL to WPTS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Move from ETL to WPTS');
	   --Audit Notification ********************************************************************************************


	   COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************    


    
	--If Audit Logging is enabled, write the Table Variable to the database
	--Else, only write the Warnings and Errors
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END






GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromETLtoStaging_RENTAL]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Rental_MoveFromETLtoStaging_RENTAL]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromETLtoStaging_RENTAL'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mReturnValue		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mReturnValue		= 1;


	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   BEGIN TRANSACTION


	   PRINT 'START WPTSRental PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START WPTSRental PROCESS');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Rental Records
	   CREATE TABLE #ETLSequence (DeliveryTicketNumber BIGINT, Sequence INT, InvoiceNumber BIGINT) ON [PRIMARY]
	   CREATE UNIQUE CLUSTERED INDEX #IX_TempETLSequence on #ETLSequence (DeliveryTicketNumber,Sequence, InvoiceNumber);

	   --Only select ALS Records
	   INSERT INTO #ETLSequence (DeliveryTicketNumber, Sequence, InvoiceNumber) 
	   SELECT a.DeliveryTicketNumber, a.Sequence, a.InvoiceNumber
	   FROM ETLSequence a
   	   JOIN WPTSHeader b ON a.DeliveryTicketNumber = b.DeliveryTicketNumber
	   WHERE a.IsProcessed = 0
	   and a.OrderStatus in( 'SHP','CLD', 'RTN' , 'PAR')
	   ;


	   DECLARE @Sequence INT;
	   DECLARE @DeliveryTicketNumber BIGINT;
	   DECLARE @InvoiceNumber BIGINT;

	   WHILE (SELECT COUNT(1) FROM #ETLSequence) > 0
	   BEGIN
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, @Sequence = Sequence, @InvoiceNumber = InvoiceNumber FROM #ETLSequence;

		  --CONVERT Sequence to RENTAL
		  IF EXISTS (SELECT * FROM WPTSRental WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND InvoiceNumber = @InvoiceNumber)
			 BEGIN
				UPDATE Destination
				SET
				    Destination.ShippedDate = Source.ShippedDate,
					Destination.Level2Id = c.Level2Id,
				    Destination.OrderStatusId = DISJobHistory.dbo.fnGetCodeValueIdByUniversalId(WPTSMappingOrderStatus.WPTSUniversalId),
				    Destination.ContactNme = Source.CustomerContactName,
				    Destination.ContactPhoneOffice = Source.CustomerContactPhone,
				    Destination.WFDSalesNme = Source.WFTSalesman,
				    Destination.InputById = DISJobHistory.dbo.fnGetUserIDforUserName(Source.PreparedBy),
				    Destination.BranchPlantCode = dbo.TRIM(Source.BranchPlantCode),
				    IsProcessed = 0
				FROM WPTSRental Destination
				JOIN ETLSequence Source ON Destination.DeliveryTicketNumber = Source.DeliveryTicketNumber AND Destination.Sequence = Source.Sequence
			    LEFT JOIN EDI_MDM_MAPPING b ON Source.ProductLineId = b.EDI
			    LEFT JOIN DISJobHistory.dbo.OrgDataLevel2 c ON b.MDM= c.MDMLevel2Code
				JOIN WPTSMappingOrderStatus ON Source.OrderStatus = WPTSMappingOrderStatus.ETLId
				WHERE
				    Destination.DeliveryTicketNumber = @DeliveryTicketNumber
				    AND Destination.Sequence = @Sequence
				    AND Destination.InvoiceNumber = @InvoiceNumber
					and Source.OrderStatus in( 'SHP','CLD', 'RTN' , 'PAR')
			 END
		  ELSE
			 BEGIN
				INSERT INTO WPTSRental (
				    DeliveryTicketNumber,
				    Sequence,
				    ShippedDate,
					Level2Id,
				    OrderStatusId,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    InputById,
				    BranchPlantCode,
				    InvoiceNumber,
				    IsProcessed)
				SELECT TOP 1
				    ETLSequence.DeliveryTicketNumber,
				    ETLSequence.Sequence,
				    ETLSequence.ShippedDate,
					c.Level2Id,
				    DISJobHistory.dbo.fnGetCodeValueIdByUniversalId(WPTSMappingOrderStatus.WPTSUniversalId),
				    ETLSequence.CustomerContactName,
				    ETLSequence.CustomerContactPhone,
				    ETLSequence.WFTSalesman,
				    DISJobHistory.dbo.fnGetUserIDforUserName(ETLSequence.PreparedBy),
				    dbo.TRIM(ETLSequence.BranchPlantCode),
				    ETLSequence.InvoiceNumber,
				    0
				FROM ETLSequence
			    LEFT JOIN EDI_MDM_MAPPING b ON ETLSequence.ProductLineId = b.EDI
			    LEFT JOIN DISJobHistory.dbo.OrgDataLevel2 c ON b.MDM= c.MDMLevel2Code
				JOIN WPTSMappingOrderStatus ON ETLSequence.OrderStatus = WPTSMappingOrderStatus.ETLId
				WHERE 
				    ETLSequence.DeliveryTicketNumber = @DeliveryTicketNumber
				    AND ETLSequence.Sequence = @Sequence
				    AND ETLSequence.InvoiceNumber = @InvoiceNumber
					and ETLSequence.OrderStatus in( 'SHP','CLD', 'RTN' , 'PAR')
			 END
		  
		  --Check to make sure record exists.  If not, set IsProcessed = 1 for Equipment.
		  IF NOT EXISTS(SELECT * FROM WPTSRental WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND InvoiceNumber = @InvoiceNumber)
			 BEGIN
				UPDATE ETLSequenceEquipment SET IsProcessed = 1, ProcessedDate = NULL WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND InvoiceNumber = @InvoiceNumber;
				UPDATE ETLSequence SET IsProcessed = 1, ProcessedDate = NULL WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND InvoiceNumber = @InvoiceNumber;
			 END
	       ELSE
			 BEGIN
				UPDATE ETLSequence SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND InvoiceNumber = @InvoiceNumber;
			 END

		  DELETE FROM #ETLSequence WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND Sequence = @Sequence AND InvoiceNumber = @InvoiceNumber;
	   END

	   DROP TABLE #ETLSequence;

	   PRINT 'END WPTSRental PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END WPTSRental PROCESS');
	   --Audit Notification ********************************************************************************************


	   COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************    


    
	--If Audit Logging is enabled, write the Table Variable to the database
	--Else, only write the Warnings and Errors
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END



GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromJDEJobtoWPTS]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Rental_MoveFromJDEJobtoWPTS]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ReturnCode INT;
    DECLARE @mEmailAddress NVARCHAR(50);
    DECLARE @mEmailSubject NVARCHAR(200);
    DECLARE @mEmailHTML NVARCHAR(MAX);

    SET @mEmailAddress = 'DLGBSMPerformanceTrackingSystem@weatherford.com';
    SET @mEmailSubject = 'Warning: JDE Integration Error.';
    SET @mEmailHTML = 'Check the AuditLogs in JDEJobs table.  An error occurred in one of the Rental_MoveFromJDEJobtoWPTS stored procedures.';


    --Process the Header Records
    EXEC @ReturnCode = [dbo].[Rental_MoveFromJDEJobtoWPTS_HEADER] @aIsAuditEnabled

    IF @ReturnCode = 1
    BEGIN
	   --Process the Rental Records
	   EXEC @ReturnCode = [dbo].[Rental_MoveFromJDEJobtoWPTS_RENTAL] @aIsAuditEnabled
    END

    IF @ReturnCode = 1
    BEGIN
	   --Process the Equipment Records 10,000 at a time
	   WHILE (SELECT COUNT(1)
			 FROM WPTSHeader 
			 JOIN WPTSRental ON WPTSRental.DeliveryTicketNumber = WPTSHeader.DeliveryTicketNumber 
			 JOIN WPTSRentalEquipment ON WPTSRental.DeliveryTicketNumber = WPTSRentalEquipment.DeliveryTicketNumber AND WPTSRental.Sequence = WPTSRentalEquipment.Sequence AND WPTSRental.InvoiceNumber = WPTSRentalEquipment.InvoiceNumber
			 WHERE WPTSRentalEquipment.IsProcessed = 0) > 0
		  BEGIN
			 IF @ReturnCode = 1
			 BEGIN
				EXEC @ReturnCode = [dbo].[Rental_MoveFromJDEJobtoWPTS_EQUIPMENT] @aIsAuditEnabled
			 END

			 IF @ReturnCode = 0
				BREAK
			 ELSE
				CONTINUE
		  END
    END

    IF @ReturnCode = 0
    BEGIN
        EXEC [DISJobHistory].[dbo].usp_smtp_sendmail @To = @mEmailAddress ,@Subject = @mEmailSubject, @message = @mEmailHTML
    END
END

GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromJDEJobtoWPTS_EQUIPMENT]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Rental_MoveFromJDEJobtoWPTS_EQUIPMENT]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromJDEJobtoWPTS_EQUIPMENT'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mReturnValue		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mTemplateName		= 'Rental';
    SET	  @mReturnValue		= 1;


    BEGIN TRY
	   BEGIN TRANSACTION


	   PRINT 'Start Insert/Update WPTS Rental Equipment Records'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Insert/Update WPTS Rental Equipment Records');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Rental Equipment Records
	   CREATE TABLE #JDESequenceEquipment (ReportId INT, Sequence INT, OrderLineNumber FLOAT);
	   INSERT INTO #JDESequenceEquipment (ReportId, Sequence, OrderLineNumber)
		  SELECT TOP 1000 WPTSHeader.ReportId, WPTSRentalEquipment.Sequence, WPTSRentalEquipment.OrderLineNumber 
		  FROM WPTSHeader 
		  JOIN WPTSRental ON WPTSRental.DeliveryTicketNumber = WPTSHeader.DeliveryTicketNumber 
		  JOIN WPTSRentalEquipment ON WPTSRental.DeliveryTicketNumber = WPTSRentalEquipment.DeliveryTicketNumber AND WPTSRental.Sequence = WPTSRentalEquipment.Sequence AND WPTSRental.InvoiceNumber = WPTSRentalEquipment.InvoiceNumber
		  WHERE WPTSRentalEquipment.IsProcessed = 0;

	   DECLARE @OrderLineNumber FLOAT;
	   DECLARE @ReportId INT;
	   DECLARE @Sequence INT;

	   WHILE (SELECT COUNT(1) FROM #JDESequenceEquipment) > 0
	   BEGIN
		  SELECT TOP 1 @Reportid = ReportId, @Sequence = Sequence, @OrderLineNumber = OrderLineNumber FROM #JDESequenceEquipment;

		  IF EXISTS (SELECT * FROM DISJobHistory.dbo.RentalEquipment WHERE ReportId = @ReportId AND RunNo = @Sequence AND OrderLineNumber = @OrderLineNumber)
			 BEGIN
			 UPDATE Destination SET
				Destination.LineNumber = Source.LineNumber,
				Destination.Quantity = Source.Quantity,
				Destination.SerialNumber = Source.SerialNumber,
				Destination.Description = Source.Description,
				Destination.ItemNumber = Source.ItemNumber,
				Destination.ReferenceNumber = Source.ReferenceNumber,
				Destination.InvUOM = Source.InvUOM,
				Destination.PriceUOM = Source.PriceUOM,
				Destination.BillUnits = Source.BillUnits,
				Destination.EquipmentInvoiceNumber = Source.InvoiceNumber,
				Destination.GLCode = Source.GLCode,
				Destination.HyperionPLCode = Source.HyperionPLCode,
				Destination.LastJDEUpdateDate = Source.LastJDEUpdateDate
			 FROM DISJobHistory.dbo.RentalEquipment Destination
			 JOIN WPTSHeader ON Destination.ReportId = WPTSHeader.ReportId
			 JOIN WPTSRentalEquipment Source ON WPTSHeader.DeliveryTicketNumber = Source.DeliveryTicketNumber AND Destination.RunNo = Source.Sequence AND Destination.OrderLineNumber = Source.OrderLineNumber
			 WHERE 
				WPTSHeader.ReportId = @ReportId
				AND Source.Sequence = @Sequence
				AND Source.OrderLineNumber = @OrderLineNumber
			 END
		  ELSE
			 BEGIN
				IF EXISTS (SELECT * FROM DISJobHistory.dbo.hdrProfile WHERE ReportId = @ReportId)
				BEGIN
				INSERT INTO DISJobHistory.dbo.RentalEquipment(
				    ReportId,
				    RunNo,
				    LineNumber,
				    OrderLineNumber,
				    TemplateName,
				    Quantity,
				    SerialNumber,
				    Description,
				    ItemNumber,
				    ReferenceNumber,
				    InvUOM,
				    PriceUOM,
				    BillUnits,
				    GLCode,
				    HyperionPLCode,
				    EquipmentInvoiceNumber,
				    LastJDEUpdateDate
				)
				SELECT
				    WPTSHeader.ReportId,
				    Sequence,
				    LineNumber,
				    OrderLineNumber,
				    @mTemplateName,
				    Quantity,
				    SerialNumber,
				    Description,
				    ItemNumber,
				    ReferenceNumber,
				    InvUOM,
				    PriceUOM,
				    BillUnits,
				    GLCode,
				    HyperionPLCode,
				    InvoiceNumber,
				    LastJDEUpdateDate
				FROM WPTSRentalEquipment
				JOIN WPTSHeader ON WPTSRentalEquipment.DeliveryTicketNumber = WPTSHeader.DeliveryTicketNumber
				WHERE 
				    WPTSHeader.ReportId = @ReportId	
				    AND WPTSRentalEquipment.Sequence = @Sequence	
				    AND WPTSRentalEquipment.OrderLineNumber = @OrderLineNumber	 
				    AND WPTSRentalEquipment.IsProcessed = 0;
			 END
			 END

		  UPDATE Destination SET IsProcessed = 1, ProcessedDate = GETDATE()
		  FROM WPTSRentalEquipment Destination
		  JOIN WPTSHeader Source ON Destination.DeliveryTicketNumber = Source.DeliveryTicketNumber
		  WHERE ReportId = @ReportId AND Sequence = @Sequence AND OrderLineNumber = @OrderLineNumber;

		  DELETE FROM #JDESequenceEquipment WHERE ReportId = @ReportId AND Sequence = @Sequence AND OrderLineNumber = @OrderLineNumber;

	   END

	   DROP TABLE #JDESequenceEquipment;

	   PRINT 'End Insert/Update WPTS Rental Equipment Records'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Insert/Update WPTS Rental Equipment Records');
	   --Audit Notification ********************************************************************************************

	   COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************    


    
	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END


GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromJDEJobtoWPTS_HEADER]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Rental_MoveFromJDEJobtoWPTS_HEADER]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromJDEJobtoWPTS_HEADER'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mJDEUser			INT;
    DECLARE @mReturnValue		INT;
	DECLARE @mOperationId		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mTemplateName		= 'Rental';
    SET	  @mReturnValue		= 1;
	SET	  @mOperationId		= 200;

	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   SELECT @mJDEUser = ID FROM DISJobHistory.dbo.UserAuth WHERE UserName = 'JDESystemUser';


	   PRINT 'Start Insert/Update WPTS Header'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Insert/Update WPTS Header');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Header Records
	   --CREATE TABLE #JDEJobs (DeliveryTicketNumber BIGINT, ReportId INT, Level1ID INT, Level2ID INT);
	   CREATE TABLE #JDEJobs (DeliveryTicketNumber BIGINT, ReportId INT, Level1ID INT, Level2ID INT, Level3ID INT, Level4ID INT,WFTLocationId INT);
	   INSERT INTO #JDEJobs (DeliveryTicketNumber, ReportId,Level1ID,Level2ID,WFTLocationId) SELECT DeliveryTicketNumber, ReportId,Level1ID,Level2ID,WFTLocationId FROM WPTSHeader WHERE IsProcessed = 0;

	   DECLARE @DeliveryTicketNumber BIGINT;
	   DECLARE @ReportId INT;
	   DECLARE @Level1ID INT;
	   DECLARE @Level2ID INT;
	   DECLARE @WFTLocationId int;

	   WHILE (SELECT COUNT(1) FROM #JDEJobs) > 0
	   BEGIN
		  BEGIN TRANSACTION
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, @ReportId = ReportId, @Level1ID = Level1ID, @Level2ID = Level2ID,@WFTLocationId=WFTLocationId FROM #JDEJobs;

		  --If the Report Id exists in WPTS, update using the Report Id.
		  --If the Report Id is NULL, Insert using Delivery Ticket Number.
		  --If Report Id does not exist in WPTS, ignore it since it was deleted.

		  IF EXISTS (SELECT * FROM DISJobHistory.dbo.HdrProfile WHERE ReportId = @ReportId)
			 BEGIN
			 UPDATE Destination SET
				Destination.OperationId = Source.OperationId,
				Destination.JobStart = Source.JobStart,
				Destination.CustomerId = Source.CustomerId,
				Destination.WellLocationId = Source.WellLocationId,
				Destination.WellName = Source.WellName,
				Destination.Field = Source.Field,
				Destination.Rig = Source.Rig,
				Destination.WellCountryID = Source.CountryId,
				Destination.Lease = Source.Lease,
				Destination.ContactNme = Source.ContactNme,
				Destination.ContactPhoneOffice = Source.ContactPhoneOffice,
				Destination.WFDSalesNme = Source.WFDSalesNme,
				Destination.CustOrderNo = Source.CustOrderNo,
				Destination.InputByID = Source.InputByID,
				Destination.WFDLocationID = @WFTLocationId
			 FROM DISJobHistory.dbo.HdrProfile Destination
			 JOIN WPTSHeader Source ON Destination.ReportID = Source.ReportId
			 WHERE Source.ReportId = @ReportId
			 END
		  ELSE
			 BEGIN
				IF @ReportId IS NULL
				BEGIN
				--FIRST INSERT INTO HdrProfile to get Report Id
				INSERT INTO DISJobHistory.dbo.HdrProfile(
				    OperationID,
				    JobStart,
				    CustomerId,
				    WellLocationId,
				    WellName,
				    Field,
				    Rig,
				    WellCountryID,
				    Lease,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    CustOrderNo,
				    InputByID,
				    CreatedBy,
					WFDLocationID
				)
				SELECT
				    OperationId,
				    JobStart,
				    CustomerId,
				    WellLocationId,
				    WellName,
				    Field,
				    Rig,
				    CountryId,
				    Lease,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    CustOrderNo,
				    InputById,
				    @mJDEUser,
					@WFTLocationId
				FROM WPTSHeader 
				WHERE DeliveryTicketNumber = @DeliveryTicketNumber;

				SELECT @ReportId = SCOPE_IDENTITY();

				--SECOND INSERT INTO JobPerfv2 to save Delivery Ticket Number
				INSERT INTO DISJobHistory.dbo.JobPerfv2 (ReportId, JobNo) VALUES (@ReportId,@DeliveryTicketNumber);

				--THIRD UPDATE WPTSHeader
				UPDATE WPTSHeader SET ReportId = @ReportId WHERE DeliveryTicketNumber = @DeliveryTicketNumber
				END
			 END

		  --remove orphans, needed due to implementation. This needs to be fixed at some point to insure that a productlineid exists before a job is populated
		  delete from disjobhistory..userchoicekey where reportid =@ReportId
		  and disjobhistory..userchoicekey.dbFieldID in (38031,38032)
		  and id not in
		  (
			select level3id from disjobhistory..hdrprofile where ReportID = @ReportId
			UNION
			select level4id from disjobhistory..hdrprofile where ReportID = @ReportId
		  )
		
		  --Get Level3 and Level4 User Choice Values and Update hdrProfile
		  EXEC hdrProfile_InsertUpdateUserChoice @ReportId = @ReportId, @OperationId = @mOperationId, @DeliveryTicketNumber = @DeliveryTicketNumber, @Level1ID = @Level1ID, @Level2ID = @Level2ID, @aIsAuditEnabled = 0


		  UPDATE WPTSHeader SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber;

		  DELETE FROM #JDEJobs WHERE DeliveryTicketNumber = @DeliveryTicketNumber;


		  COMMIT TRANSACTION
	   END

	   DROP TABLE #JDEJobs;

	   PRINT 'End Insert/Update WPTS Header'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Insert/Update WPTS Header');
	   --Audit Notification ********************************************************************************************
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END


GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromJDEJobtoWPTS_HEADER_General]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Rental_MoveFromJDEJobtoWPTS_HEADER_General]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromJDEJobtoWPTS_HEADER_General'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mJDEUser			INT;
    DECLARE @mReturnValue		INT;
	DECLARE @mOperationId		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    --SET	  @mTemplateName		= 'Rental';
    SET	  @mReturnValue		= 1;
	--SET	  @mOperationId		= 200;

	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   SELECT @mJDEUser = ID FROM DISJobHistory.dbo.UserAuth WHERE UserName = 'JDESystemUser';


	   PRINT 'Start Insert/Update WPTS Header'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Insert/Update WPTS Header');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Header Records
	   CREATE TABLE #JDEJobs (DeliveryTicketNumber BIGINT, ReportId INT, Level1ID INT, Level2ID INT, Level3ID INT, Level4ID INT,WFTLocationId INT);
	   INSERT INTO #JDEJobs (DeliveryTicketNumber, ReportId,WFTLocationId, Level1ID,Level2ID,Level3ID,Level4ID) 
	   SELECT DeliveryTicketNumber, ReportId,WFTLocationId,Level1ID,Level2ID,Level3ID,Level4ID 
	   FROM WPTSHeader_General 
	   WHERE IsProcessed = 0;	  

	   DECLARE @DeliveryTicketNumber BIGINT;
	   DECLARE @ReportId INT;
	   DECLARE @Level1ID INT;
	   DECLARE @Level2ID INT;
	   DECLARE @Level3ID INT;
	   DECLARE @Level4ID INT;
	   DECLARE @WFTLocationId int;
	   WHILE (SELECT COUNT(1) FROM #JDEJobs) > 0
	   BEGIN
		  BEGIN TRANSACTION
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, 
		  @ReportId = ReportId, 
		  @Level1ID = Level1ID, 
		  @Level2ID = Level2ID,
		  @Level3ID = Level3ID, 
		  @Level4ID = Level4ID,
		  @WFTLocationId =WFTLocationId
		   FROM #JDEJobs;
		  --If the Report Id or the Delivery Ticket exists in WPTS, update using the Report Id or DT # (This prevents duplicate job creation).
		  --If the Report Id is NULL, Insert using Delivery Ticket Number.
		  --If Report Id does not exist in WPTS, ignore it since it was deleted.
		  IF EXISTS (select top 1 * from DISJobHistory.dbo.HdrProfile hp 
join DISJobHistory.dbo.jobPerfv2 jp2 on jp2.ReportID = hp.ReportID  WHERE hp.ReportId = @ReportId or jp2.JobNo = cast(@DeliveryTicketNumber as NVARCHAR(75)))
			 BEGIN
			 PRINT 'Update WPTS Header (HdrProfile)'
			 print cast(@Level1ID as NVARCHAR(max)) + ':' +cast(@Level2ID as NVARCHAR(max)) + ':'+cast(@Level3ID as NVARCHAR(max)) + ':'+cast(@Level4ID as NVARCHAR(max))
			 UPDATE Destination SET
				Destination.OperationId = Source.OperationId,
				Destination.JobStart = Source.JobStart,
				Destination.CustomerId = Source.CustomerId,
				Destination.WellLocationId = Source.WellLocationId,
				Destination.WellName = Source.WellName,
				Destination.Field = Source.Field,
				Destination.Rig = Source.Rig,
				Destination.WellCountryID = Source.CountryId,
				Destination.Lease = Source.Lease,
				Destination.ContactNme = Source.ContactNme,
				Destination.ContactPhoneOffice = Source.ContactPhoneOffice,
				Destination.WFDSalesNme = Source.WFDSalesNme,
				Destination.CustOrderNo = Source.CustOrderNo,
				Destination.InputByID = Source.InputByID,				
				Destination.WFDLocationID = @WFTLocationId
				,Destination.Level1ID = @Level1ID
				,Destination.Level2ID = @Level2ID
				,Destination.Level3ID = @Level3ID
				,Destination.Level4ID = @Level4ID
			 FROM DISJobHistory.dbo.HdrProfile Destination
			 JOIN WPTSHeader_General Source ON Destination.ReportID = Source.ReportId
			 join DISJobHistory.dbo.jobPerfv2 jp2 on jp2.ReportID = Destination.ReportID  
			 --WHERE hp.ReportId = @ReportId 
			 WHERE Source.ReportId = @ReportId or jp2.JobNo = cast(@DeliveryTicketNumber as NVARCHAR(75))
			 
			 --Populate ReportId if it is not set
			 --This case will happen if a job is created in WPTS and the DT is later created in JDE
			 --at which time the JDE DT will be processed
			 --
			 if @ReportId is null 
			 BEGIN
				select @ReportId = hp.Reportid from DISJobHistory.dbo.HdrProfile hp 
				join DISJobHistory.dbo.jobPerfv2 jp2 on jp2.ReportID = hp.ReportID  
				WHERE jp2.JobNo = cast(@DeliveryTicketNumber as NVARCHAR(75)) 
			 end
			 END
		  ELSE
			 BEGIN
				IF @ReportId IS NULL
				BEGIN
				PRINT 'Insert WPTS Header'
				--FIRST INSERT INTO HdrProfile to get Report Id
				INSERT INTO DISJobHistory.dbo.HdrProfile(
				    OperationID,
				    JobStart,
				    CustomerId,
				    WellLocationId,
				    WellName,
				    Field,
				    Rig,
				    WellCountryID,
				    Lease,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    CustOrderNo,
				    InputByID,
				    CreatedBy,					
					WFDLocationID
					,Level1ID	
					,Level2ID	
					,Level3ID	
					,Level4ID	
				)
				SELECT
				    OperationId,
				    JobStart,
				    CustomerId,
				    WellLocationId,
				    WellName,
				    Field,
				    Rig,
				    CountryId,
				    Lease,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    CustOrderNo,
				    InputById,
				    @mJDEUser,					
					WFTLocationId
					,Level1ID
					,Level2ID
					,Level3ID
					,Level4ID
				FROM WPTSHeader_General 
				WHERE DeliveryTicketNumber = @DeliveryTicketNumber;

				SELECT @ReportId = SCOPE_IDENTITY();

				PRINT 'Insert Delivery Ticket # with reportid=' + cast(@ReportId as nvarchar(max))
				--SECOND INSERT INTO JobPerfv2 to save Delivery Ticket Number
				INSERT INTO DISJobHistory.dbo.JobPerfv2 (ReportId, JobNo) VALUES (@ReportId,@DeliveryTicketNumber);

				--THIRD UPDATE WPTSHeader_General
				PRINT 'Update WPTSHeader_General ReportId'
				UPDATE WPTSHeader_General SET ReportId = @ReportId WHERE DeliveryTicketNumber = @DeliveryTicketNumber
				END
			 
			 PRINT 'Update User Choice Values'
			 print @ReportId
			  --Get Level3 and Level4 User Choice Values and Update hdrProfile
			  EXEC [hdrProfile_InsertUpdateUserChoice_General] @ReportId = @ReportId, @OperationId = @mOperationId, @DeliveryTicketNumber = @DeliveryTicketNumber, @Level1ID = @Level1ID, @Level2ID = @Level2ID, @aIsAuditEnabled = 0,@Level3Id = @Level3ID, @Level4Id=@Level4ID
		  END
		  PRINT 'Update WPTS Header Set Processed to True'
		  UPDATE WPTSHeader_General SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber;

		  DELETE FROM #JDEJobs WHERE DeliveryTicketNumber = @DeliveryTicketNumber;


		  COMMIT TRANSACTION
	   END

	   DROP TABLE #JDEJobs;

	   PRINT 'End Insert/Update WPTS Header'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Insert/Update WPTS Header');
	   --Audit Notification ********************************************************************************************
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END





GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromJDEJobtoWPTS_HEADER_General_Test]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rental_MoveFromJDEJobtoWPTS_HEADER_General_Test]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromJDEJobtoWPTS_HEADER_General'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mJDEUser			INT;
    DECLARE @mReturnValue		INT;
	DECLARE @mOperationId		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    --SET	  @mTemplateName		= 'Rental';
    SET	  @mReturnValue		= 1;
	--SET	  @mOperationId		= 200;

	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


   -- BEGIN TRY
	   SELECT @mJDEUser = ID FROM DISJobHistory.dbo.UserAuth WHERE UserName = 'JDESystemUser';
	   
	    
	   PRINT 'Start Insert/Update WPTS Header'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Insert/Update WPTS Header');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Header Records
	   CREATE TABLE #JDEJobs (DeliveryTicketNumber BIGINT, ReportId INT, Level1ID INT, Level2ID INT, Level3ID INT, Level4ID INT,WFTLocationId INT);
	   INSERT INTO #JDEJobs (DeliveryTicketNumber, ReportId,WFTLocationId, Level1ID,Level2ID,Level3ID,Level4ID) 
	   SELECT DeliveryTicketNumber, ReportId,WFTLocationId,Level1ID,Level2ID,Level3ID,Level4ID 
	   FROM WPTSHeader_General 
	   WHERE IsProcessed = 0;	  
	   
	   DECLARE @DeliveryTicketNumber BIGINT;
	   DECLARE @ReportId INT;
	   DECLARE @Level1ID INT;
	   DECLARE @Level2ID INT;
	   DECLARE @Level3ID INT;
	   DECLARE @Level4ID INT;
	   DECLARE @WFTLocationId int;
	   WHILE (SELECT COUNT(1) FROM #JDEJobs) > 0
	   BEGIN
		  --BEGIN TRANSACTION
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, 
		  @ReportId = ReportId, 
		  @Level1ID = Level1ID, 
		  @Level2ID = Level2ID,
		  @Level3ID = Level3ID, 
		  @Level4ID = Level4ID,
		  @WFTLocationId =WFTLocationId
		   FROM #JDEJobs;
		  --If the Report Id or the Delivery Ticket exists in WPTS, update using the Report Id or DT # (This prevents duplicate job creation).
		  --If the Report Id is NULL, Insert using Delivery Ticket Number.
		  --If Report Id does not exist in WPTS, ignore it since it was deleted.
		  IF EXISTS (select top 1 * from DISJobHistory.dbo.HdrProfile hp 
join DISJobHistory.dbo.jobPerfv2 jp2 on jp2.ReportID = hp.ReportID  WHERE hp.ReportId = @ReportId or jp2.JobNo = cast(@DeliveryTicketNumber as NVARCHAR(75)))
			 BEGIN
			 PRINT 'Update WPTS Header (HdrProfile)'
			 print cast(@Level1ID as NVARCHAR(max)) + ':' +cast(@Level2ID as NVARCHAR(max)) + ':'+cast(@Level3ID as NVARCHAR(max)) + ':'+cast(@Level4ID as NVARCHAR(max))
			 print @ReportId
			 print @Level4ID

			 UPDATE Destination SET
				Destination.OperationId = Source.OperationId,
				Destination.JobStart = Source.JobStart,
				Destination.CustomerId = Source.CustomerId,
				Destination.WellLocationId = Source.WellLocationId,
				Destination.WellName = Source.WellName,
				Destination.Field = Source.Field,
				Destination.Rig = Source.Rig,
				Destination.WellCountryID = Source.CountryId,
				Destination.Lease = Source.Lease,
				Destination.ContactNme = Source.ContactNme,
				Destination.ContactPhoneOffice = Source.ContactPhoneOffice,
				Destination.WFDSalesNme = Source.WFDSalesNme,
				Destination.CustOrderNo = Source.CustOrderNo,
				Destination.InputByID = Source.InputByID,				
				Destination.WFDLocationID = @WFTLocationId
				,Destination.Level1ID = @Level1ID
				,Destination.Level2ID = @Level2ID
				,Destination.Level3ID = @Level3ID
				,Destination.Level4ID = @Level4ID
			 FROM DISJobHistory.dbo.HdrProfile Destination
			 JOIN WPTSHeader_General Source ON Destination.ReportID = Source.ReportId
			 join DISJobHistory.dbo.jobPerfv2 jp2 on jp2.ReportID = Destination.ReportID  
			 --WHERE hp.ReportId = @ReportId 
			 WHERE Source.ReportId = @ReportId or jp2.JobNo = cast(@DeliveryTicketNumber as NVARCHAR(75))
			 

			 --Populate ReportId if it is not set
			 --This case will happen if a job is created in WPTS and the DT is later created in JDE
			 --at which time the JDE DT will be processed
			 --
			 if @ReportId is null 
			 BEGIN
				select @ReportId = hp.Reportid from DISJobHistory.dbo.HdrProfile hp 
				join DISJobHistory.dbo.jobPerfv2 jp2 on jp2.ReportID = hp.ReportID  
				WHERE jp2.JobNo = cast(@DeliveryTicketNumber as NVARCHAR(75)) 
			 end
			 END
		  ELSE
			 BEGIN
				IF @ReportId IS NULL
				BEGIN
				PRINT 'Insert WPTS Header'
				--FIRST INSERT INTO HdrProfile to get Report Id
				INSERT INTO DISJobHistory.dbo.HdrProfile(
				    OperationID,
				    JobStart,
				    CustomerId,
				    WellLocationId,
				    WellName,
				    Field,
				    Rig,
				    WellCountryID,
				    Lease,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    CustOrderNo,
				    InputByID,
				    CreatedBy,					
					WFDLocationID
					,Level1ID	
					,Level2ID	
					,Level3ID	
					,Level4ID	
				)
				SELECT
				    OperationId,
				    JobStart,
				    CustomerId,
				    WellLocationId,
				    WellName,
				    Field,
				    Rig,
				    CountryId,
				    Lease,
				    ContactNme,
				    ContactPhoneOffice,
				    WFDSalesNme,
				    CustOrderNo,
				    InputById,
				    @mJDEUser,					
					WFTLocationId
					,Level1ID
					,Level2ID
					,Level3ID
					,Level4ID
				FROM WPTSHeader_General 
				WHERE DeliveryTicketNumber = @DeliveryTicketNumber;

				SELECT @ReportId = SCOPE_IDENTITY();

				PRINT 'Insert Delivery Ticket # with reportid=' + cast(@ReportId as nvarchar(max))
				--SECOND INSERT INTO JobPerfv2 to save Delivery Ticket Number
				INSERT INTO DISJobHistory.dbo.JobPerfv2 (ReportId, JobNo) VALUES (@ReportId,@DeliveryTicketNumber);

				--THIRD UPDATE WPTSHeader_General
				PRINT 'Update WPTSHeader_General ReportId'
				UPDATE WPTSHeader_General SET ReportId = @ReportId WHERE DeliveryTicketNumber = @DeliveryTicketNumber
				END
			 
			 PRINT 'Update User Choice Values'
			 print @ReportId
			  --Get Level3 and Level4 User Choice Values and Update hdrProfile
			  EXEC [hdrProfile_InsertUpdateUserChoice_General] @ReportId = @ReportId, @OperationId = @mOperationId, @DeliveryTicketNumber = @DeliveryTicketNumber
			  , @Level1ID = @Level1ID, @Level2ID = @Level2ID, @aIsAuditEnabled = 0,@Level3Id = @Level3ID, @Level4Id=@Level4ID
		  END
		  PRINT 'Update WPTS Header Set Processed to True'
		  UPDATE WPTSHeader_General SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber;

		  DELETE FROM #JDEJobs WHERE DeliveryTicketNumber = @DeliveryTicketNumber;


		 -- COMMIT TRANSACTION
	   END

	   DROP TABLE #JDEJobs;

	   PRINT 'End Insert/Update WPTS Header'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Insert/Update WPTS Header');
	   --Audit Notification ********************************************************************************************
    --END TRY
    --BEGIN CATCH
	   --IF @@TRANCOUNT > 0
			 --ROLLBACK TRANSACTION;
					
	   --PRINT 'Error #: ' + ltrim(str(error_number()))
	   --PRINT 'Error: ' + error_message()
	   ----Audit Error ********************************************************************************************
	   --INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    --END CATCH
    
    
	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END


GO
/****** Object:  StoredProcedure [dbo].[Rental_MoveFromJDEJobtoWPTS_RENTAL]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Rental_MoveFromJDEJobtoWPTS_RENTAL]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into WellData_AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Rental_MoveFromJDEJobtoWPTS_RENTAL'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mReturnValue		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mReturnValue		= 1;

    BEGIN TRY
	   PRINT 'Start Insert/Update WPTS Rental Records'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Insert/Update WPTS Rental Records');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Rental Records
	   CREATE TABLE #JDESequence (ReportId INT, Sequence INT, InvoiceNumber BIGINT);
	   INSERT INTO #JDESequence (ReportId, Sequence,InvoiceNumber) SELECT WPTSHeader.ReportId, WPTSRental.Sequence, WPTSRental.InvoiceNumber FROM WPTSRental JOIN WPTSHeader ON WPTSRental.DeliveryTicketNumber = WPTSHeader.DeliveryTicketNumber WHERE WPTSRental.IsProcessed = 0;

	   DECLARE @Sequence INT;
	   DECLARE @ReportId INT;
	   DECLARE @InvoiceNumber BIGINT;

	   WHILE (SELECT COUNT(1) FROM #JDESequence) > 0
	   BEGIN
		  BEGIN TRANSACTION
		  SELECT TOP 1 @Reportid = ReportId, @Sequence = Sequence, @InvoiceNumber = InvoiceNumber FROM #JDESequence;

		  IF EXISTS (SELECT * FROM DISJobHistory.dbo.Rental WHERE ReportId = @ReportId AND RunNo = @Sequence AND InvoiceNumber = @InvoiceNumber)
			 BEGIN
			 UPDATE Destination SET
				Destination.ShippedDate = Source.ShippedDate,
				Destination.Level2Id = Source.Level2Id,
				Destination.OrderStatusId = Source.OrderStatusId,
				Destination.CustomerContactName = Source.ContactNme,
				Destination.CustomerContactPhoneNumber = Source.ContactPhoneOffice,
				Destination.WFTSalesmanName = Source.WFDSalesNme,
				Destination.BranchPlantCode = Source.BranchPlantCode,
				Destination.InputByID = Source.InputByID
			 FROM DISJobHistory.dbo.Rental Destination
			 JOIN WPTSHeader ON Destination.ReportId = WPTSHeader.ReportId
			 JOIN WPTSRental Source ON WPTSHeader.DeliveryTicketNumber = Source.DeliveryTicketNumber AND Destination.RunNo = Source.Sequence
			 WHERE 
				WPTSHeader.ReportId = @ReportId
				AND Source.Sequence = @Sequence
				AND Source.InvoiceNumber = @InvoiceNumber
			 END
		  ELSE
			 BEGIN
				IF EXISTS (SELECT * FROM DISJobHistory.dbo.hdrProfile WHERE ReportId = @ReportId)
				BEGIN
				INSERT INTO DISJobHistory.dbo.Rental(
				    ReportId,
				    RunNo,
				    ShippedDate,
					Level2Id,
				    OrderStatusId,
				    CustomerContactName,
				    CustomerContactPhoneNumber,
				    WFTSalesmanName,
				    BranchPlantCode,
				    InvoiceNumber,
				    InputByID
				)
				SELECT
				    WPTSHeader.ReportId,
				    Sequence,
				    ShippedDate,
					WPTSRental.Level2Id,
				    OrderStatusId,
				    WPTSRental.ContactNme,
				    WPTSRental.ContactPhoneOffice,
				    WPTSRental.WFDSalesNme,
				    WPTSRental.BranchPlantCode,
				    WPTSRental.InvoiceNumber,
				    WPTSRental.InputById
				FROM WPTSRental
				JOIN WPTSHeader ON WPTSRental.DeliveryTicketNumber = WPTSHeader.DeliveryTicketNumber
				WHERE 
				    WPTSHeader.ReportId = @ReportId	
				    AND WPTSRental.Sequence = @Sequence
				    AND WPTSRental.InvoiceNumber = @InvoiceNumber		 
				    AND WPTSRental.IsProcessed = 0;
			 END
			 END

		  UPDATE Destination SET IsProcessed = 1, ProcessedDate = GETDATE()
		  FROM WPTSRental Destination
		  JOIN WPTSHeader Source ON Destination.DeliveryTicketNumber = Source.DeliveryTicketNumber
		  WHERE ReportId = @ReportId AND Sequence = @Sequence AND InvoiceNumber = @InvoiceNumber;

		  DELETE FROM #JDESequence WHERE ReportId = @ReportId AND Sequence = @Sequence AND InvoiceNumber = @InvoiceNumber;


		  COMMIT TRANSACTION
	   END

	   DROP TABLE #JDESequence;

	   PRINT 'End Insert/Update WPTS Rental Records'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Insert/Update WPTS Rental Records');
	   --Audit Notification ********************************************************************************************
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END


GO
/****** Object:  StoredProcedure [dbo].[Sales_MoveFromETLtoStaging]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sales_MoveFromETLtoStaging]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ReturnCode INT;
    DECLARE @mEmailAddress NVARCHAR(50);
    DECLARE @mEmailSubject NVARCHAR(200);
    DECLARE @mEmailHTML NVARCHAR(MAX);

    SET @mEmailAddress = 'DLGBSMPerformanceTrackingSystem@weatherford.com';
    SET @mEmailSubject = 'Warning: JDE Integration Error.';
    SET @mEmailHTML = 'Check the AuditLogs in JDEJobs table.  An error occurred in one of the Sales_MoveFromETLtoStaging stored procedures.';


    ----STEP 1:  Mark records without details as IsProcessed so they will be skipped.

    --UPDATE ETLSalesHeader SET IsProcessed = 1 WHERE NOT EXISTS (
	   --SELECT DISTINCT b.DeliveryTicketNumber FROM ETLSalesEquipment b WHERE ETLSalesHeader.DeliveryTicketNumber = b.DeliveryTicketNumber
    --)
    ----Mark Header records as processed if the Product Line Id is missing
    --UPDATE ETLSalesHeader SET IsProcessed = 1 WHERE (ProductLineId IS NULL OR ProductLineId ='') AND IsProcessed = 0

	--STEP 1:  Mark records without details as IsProcessed so they will be skipped.

    UPDATE ETLSalesHeader SET IsProcessed = 1 WHERE NOT EXISTS (
	   SELECT DISTINCT b.DeliveryTicketNumber 
	   FROM ETLSalesEquipment b 
	   join ETLSalesHeader etlh on b.DeliveryTicketNumber = etlh.DeliveryTicketNumber
	   left join ProductLineOrgLevel4 plo4 on etlh.ProductLineId = plo4.ProductLineId
	   --WHERE ETLHeader.DeliveryTicketNumber = etls.DeliveryTicketNumber 
	   WHERE ETLSalesHeader.DeliveryTicketNumber = b.DeliveryTicketNumber and plo4.Level4Id is null
    )
    --Mark Header records as processed if the Product Line Id is missing
    --UPDATE ETLSalesHeader SET IsProcessed = 1 WHERE (ProductLineId IS NULL OR ProductLineId ='') AND IsProcessed = 0

    --Step 2: Process the Header Records
    EXEC @ReturnCode = [dbo].[Sales_MoveFromETLtoStaging_HEADER] @aIsAuditEnabled

    --Step 3: Process the Equipment Records
    IF @ReturnCode = 1
    BEGIN
	   --Process the Equipment Records 10,000 at a time
	   WHILE (SELECT COUNT(1)
	   FROM ETLSalesEquipment a
	   JOIN WPTSSalesHeader b ON a.DeliveryTicketNumber = b.DeliveryTicketNumber 
	   WHERE a.IsProcessed = 0) > 0
		  BEGIN
			 IF @ReturnCode = 1
			 BEGIN
				EXEC @ReturnCode = [dbo].[Sales_MoveFromETLtoStaging_EQUIPMENT] @aIsAuditEnabled
			 END

			 IF @ReturnCode = 0
				BREAK
			 ELSE
				CONTINUE
		  END
    END

    --Step 5: Send error e-mail if needed.
    IF @ReturnCode = 0
    BEGIN
        EXEC [DISJobHistory].[dbo].usp_smtp_sendmail @To = @mEmailAddress ,@Subject = @mEmailSubject, @message = @mEmailHTML
    END
END




GO
/****** Object:  StoredProcedure [dbo].[Sales_MoveFromETLtoStaging_EQUIPMENT]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sales_MoveFromETLtoStaging_EQUIPMENT]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Sales_MoveFromETLtoStaging_EQUIPMENT'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mReturnValue		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mReturnValue		= 1;


	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'SALES - START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   BEGIN TRANSACTION


	   PRINT 'START WPTSSalesEquipment PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START WPTSSalesEquipment PROCESS');
	   --Audit Notification ********************************************************************************************


	   --Create temporary table for Order Status ids instead of hitting the database for each record.
	   CREATE TABLE #StatusIds (ETLStatusId INT, WPTSStatusId INT) ON [PRIMARY]

	   INSERT INTO #StatusIds (ETLStatusId, WPTSStatusId)
	   SELECT LocalStatus.Id, LinkedStatus.Id
	   FROM ETLSalesStatus LocalStatus
	   JOIN DISJobHistory.dbo.CodeValue LinkedStatus ON LocalStatus.WPTSId = LinkedStatus.UniversalId


	   --Insert/Update WPTS Rental Equipment Records
	   CREATE TABLE #ETLSalesEquipment (DeliveryTicketNumber BIGINT, OrderLineNumber FLOAT) ON [PRIMARY]
	   CREATE UNIQUE CLUSTERED INDEX #IX_TempETLSalesEquipment on #ETLSalesEquipment (DeliveryTicketNumber,OrderLineNumber);

	   --Only select ALS records
	   INSERT INTO #ETLSalesEquipment (DeliveryTicketNumber, OrderLineNumber) 
	   SELECT TOP 10000 a.DeliveryTicketNumber, a.OrderLineNumber
	   FROM ETLSalesEquipment a
	   JOIN WPTSSalesHeader b ON a.DeliveryTicketNumber = b.DeliveryTicketNumber
	   WHERE a.IsProcessed = 0;

	   DECLARE @OrderLineNumber FLOAT;
	   DECLARE @DeliveryTicketNumber BIGINT;

	   WHILE (SELECT COUNT(1) FROM #ETLSalesEquipment) > 0
	   BEGIN
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, @OrderLineNumber = OrderLineNumber FROM #ETLSalesEquipment;

		  --CONVERT Sequence to RENTAL
		  IF EXISTS (SELECT * FROM WPTSSalesEquipment WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND OrderLineNumber = @OrderLineNumber)
			 BEGIN
				UPDATE Destination
				SET
				    Destination.InvoiceNumber = Source.InvoiceNumber,
				    Destination.BranchPlantCode = Source.BranchPlantCode,
				    Destination.Quantity = Source.Quantity,
				    Destination.SerialNumber = Source.SerialNumber,
				    Destination.Description = Source.Description,
				    Destination.ItemNumber = Source.ItemNumber,
				    Destination.ReferenceNumber = Source.ReferenceNumber,
				    Destination.InvUOM = Source.InvUOM,
				    Destination.GLCode = CASE WHEN Source.GLCode = '' THEN NULL ELSE Source.GLCode END,
				    Destination.HyperionPLCode = Source.HyperionPLCode,
				    Destination.ShippedDate = Source.ShippedDate,
				    Destination.SalesStatusId = #StatusIds.WPTSStatusId,
				    Destination.LastJDEUpdateDate = Source.LastJDEUpdateDate,
				    Destination.IsProcessed = 0
				FROM WPTSSalesEquipment Destination
				JOIN ETLSalesEquipment Source ON Destination.DeliveryTicketNumber = Source.DeliveryTicketNumber AND Destination.OrderLineNumber = Source.OrderLineNumber
				LEFT JOIN #StatusIds ON Source.SalesStatusId = #StatusIds.ETLStatusId
				WHERE
				    Destination.DeliveryTicketNumber = @DeliveryTicketNumber
				    AND Destination.OrderLineNumber = @OrderLineNumber
			 END
		  ELSE
			 BEGIN
				INSERT INTO WPTSSalesEquipment (
				    DeliveryTicketNumber,
				    OrderLineNumber,
				    InvoiceNumber,
				    BranchPlantCode,
				    Quantity,
				    SerialNumber,
				    Description,
				    ItemNumber,
				    ReferenceNumber,
				    InvUOM,
				    GLCode,
				    HyperionPLCode,
				    ShippedDate,
				    SalesStatusId,
				    LastJDEUpdateDate,
				    IsProcessed)
				SELECT
				    DeliveryTicketNumber,
				    OrderLineNumber,
				    InvoiceNumber,
				    BranchPlantCode,
				    Quantity,
				    SerialNumber,
				    Description,
				    ItemNumber,
				    ReferenceNumber,
				    InvUOM,
				    CASE WHEN GLCode = '' THEN NULL ELSE GLCode END,
				    HyperionPLCode,
				    ShippedDate,
				    #StatusIds.WPTSStatusId,
				    LastJDEUpdateDate,
				    0
				FROM ETLSalesEquipment
				LEFT JOIN #StatusIds ON ETLSalesEquipment.SalesStatusId = #StatusIds.ETLStatusId
				WHERE DeliveryTicketNumber = @DeliveryTicketNumber
				AND OrderLineNumber = @OrderLineNumber
			 END

		  UPDATE ETLSalesEquipment SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND @OrderLineNumber = OrderLineNumber;

		  DELETE FROM #ETLSalesEquipment WHERE DeliveryTicketNumber = @DeliveryTicketNumber AND @OrderLineNumber = OrderLineNumber;
	   END

	   DROP TABLE #ETLSalesEquipment;
	   DROP TABLE #StatusIds;

	   PRINT 'END WPTSSalesEquipment PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END WPTSSalesEquipment PROCESS');
	   --Audit Notification ********************************************************************************************


	   COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'SALES - END MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************    


    
	--If Audit Logging is enabled, write the Table Variable to the database
	--Else, only write the Warnings and Errors
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END


    RETURN @mReturnValue;
END




GO
/****** Object:  StoredProcedure [dbo].[Sales_MoveFromETLtoStaging_HEADER]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sales_MoveFromETLtoStaging_HEADER]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Sales_MoveFromETLtoStaging_HEADER'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mLocation_Land		INT;
    DECLARE @mLocation_Offshore	INT;
    DECLARE @mReturnValue		INT;
	DECLARE @mOperationID		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mTemplateName		= 'Sales';
    SET	  @mReturnValue		= 1;
	SET   @mOperationID		= 204; -- Hard Coded Sales Operation ID.

	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'SALES - START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   BEGIN TRANSACTION




	   PRINT 'Sales - Start Move from ETL to WPTS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Move from ETL to WPTS');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Header Records
	   --CREATE TABLE #ETLSalesHeader (DeliveryTicketNumber BIGINT, Level1ID INT, Level2ID INT) ON [PRIMARY]
	   --CREATE UNIQUE CLUSTERED INDEX #IX_TempETLSalesHeader on #ETLSalesHeader (DeliveryTicketNumber);
	   CREATE TABLE #ETLSalesHeader (DeliveryTicketNumber BIGINT, Level1ID INT, Level2ID INT, Level3ID INT, Level4ID INT,WFTLocationId INT) ON [PRIMARY]
	   CREATE UNIQUE CLUSTERED INDEX #IX_TempETLSalesHeader on #ETLSalesHeader (DeliveryTicketNumber);

	   --Only get ALS records
	   --INSERT INTO #ETLSalesHeader (DeliveryTicketNumber,Level1ID,Level2ID) 
	   --SELECT a.DeliveryTicketNumber,c.Level1ID,c.Level2ID
	   --FROM ETLSalesHeader a
	   --JOIN EDI_MDM_MAPPING b ON a.ProductLineId = b.EDI
	   --JOIN DISJobHistory.dbo.OrgDataLevel2 c ON b.MDM= c.MDMLevel2Code
	   --WHERE (c.MDMLevel1Code = 'ALS' --or c.MDMLevel1Code = 'RS'
	   --)
	   --AND a.IsProcessed = 0;
	   INSERT INTO #ETLSalesHeader (DeliveryTicketNumber,Level1ID,Level2ID,WFTLocationId)
	   SELECT distinct a.DeliveryTicketNumber,c.Level1ID,c.Level2ID,
	   --coalesce((select top 1 locationid from disjobhistory.dbo.hdrwftlocations where propertyid =mpl.LEASE_NUM),(select top 1 WFTLocationId from BranchPlantWFTLocation where a.BusinessUnitId = BranchPlantId)) as WFTLocationId	   
	   coalesce(
			(select top 1 locationid 
			from disjobhistory.dbo.hdrwftlocations hl
			join
			--where propertyid =
			(select top 1 mpl.LEASE_NUM 
			from DISJobHistory.mdm.MDMPhysicalLocation mpl 
			where a.BusinessUnitId = mpl.BRANCH_PLANT_NUMBER
			order by branch_plant_number, PRIMARY_USE_FLG desc, ACTV_FLG desc
			) tmpdata on hl.PropertyID = tmpdata.LEASE_NUM
			)
			,(select top 1 WFTLocationId from BranchPlantWFTLocation where a.BusinessUnitId = BranchPlantId)
		) as WFTLocationId
	   FROM ETLSalesHeader a
	   left join ETLSequence ets on ets.DeliveryTicketNumber = a.DeliveryTicketNumber
	   --left join DISJobHistory.mdm.MDMPhysicalLocation mpl on a.BusinessUnitId = mpl.BRANCH_PLANT_NUMBER and (coalesce(a.ProductLineId,ets.ProductLineId) is not null and mpl.PRODLN_CD like '%'+ coalesce(a.ProductLineId,ets.ProductLineId)+'%' )
	   JOIN EDI_MDM_MAPPING b ON coalesce(a.ProductLineId,ets.ProductLineId) = b.EDI
	   JOIN DISJobHistory.dbo.OrgDataLevel2 c ON b.MDM= c.MDMLevel2Code
	   WHERE (c.MDMLevel1Code = 'ALS' or c.MDMLevel1Code = 'RS'
	   )
	   AND a.IsProcessed = 0;

	   DECLARE @DeliveryTicketNumber BIGINT;
	   --WPTS Header Fields
	   DECLARE @CustomerId INT;
	   DECLARE @WellLocationCountryId INT;
	   DECLARE @ETLCustomerId BIGINT;
	   DECLARE @ETLCustomerName NVARCHAR(MAX);
	   DECLARE @JDECreatedDate DATETIME;
	   DECLARE @Level1ID INT;
	   DECLARE @Level2ID INT;
	   DECLARE @Level3ID INT;
	   DECLARE @Level4ID INT;
	   DECLARE @WFTLocationId int;


	   PRINT 'START WPTSSalesHeader PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START WPTSSalesHeader PROCESS');
	   --Audit Notification ********************************************************************************************

	   WHILE (SELECT COUNT(1) FROM #ETLSalesHeader) > 0
	   BEGIN
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, @Level1ID = Level1ID, @Level2ID = Level2ID,@WFTLocationId=WFTLocationId FROM #ETLSalesHeader;

		  --Reset Values used in later statements
		  SET @WellLocationCountryId = NULL;
		  SET @ETLCustomerId = NULL;
		  SET @ETLCustomerName = NULL;
		  SET @JDECreatedDate = NULL;

		  PRINT 'START PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) );
		  --Audit Notification ********************************************************************************************


		  PRINT 'START GET VALUES FROM HEADER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START GET VALUES FROM HEADER');
		  --Audit Notification ********************************************************************************************

		  -- GET VALUES FROM HEADER
		  SELECT 
			 @WellLocationCountryId = WPTSCountry.countryID,
			 @ETLCustomerId = ETLSalesHeader.CustomerId,
			 @ETLCustomerName = ETLCustomer.Name,
			 @JDECreatedDate = ETLSalesHeader.JDECreatedDate
		  FROM ETLSalesHeader
		  LEFT JOIN WPTSCountry ON ETLSalesHeader.ShipToCountryCode = WPTSCountry.CountryCode
		  JOIN ETLCustomer ON ETLSalesHeader.CustomerId = ETLCustomer.Id
		  WHERE ETLSalesHeader.DeliveryTicketNumber = @DeliveryTicketNumber


		  PRINT 'END GET VALUES FROM HEADER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END GET VALUES FROM HEADER');
		  --Audit Notification ********************************************************************************************






		  PRINT 'START GET VALUES FROM CUSTOMER Id: ' + CAST(@CustomerId as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START GET VALUES FROM CUSTOMER');
		  --Audit Notification ********************************************************************************************


		  -- GET Value FROM Customer
 		  EXEC [DISJobHistory].[dbo].[sp_InsertUpdateCustomers] @ETLCustomerName, @ETLCustomerId, @CustomerId OUTPUT


		  PRINT 'END GET VALUES FROM CUSTOMER'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END GET VALUES FROM CUSTOMER');
		  --Audit Notification ********************************************************************************************


		  PRINT 'START INSERT/UPDATE WPTSSalesHeader'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'START INSERT/UPDATE WPTSSalesHeader');
		  --Audit Notification ********************************************************************************************

		  --INSERT/UPDATE WPTSSalesHeader
		  IF EXISTS (SELECT * FROM WPTSSalesHeader WHERE DeliveryTicketNumber = @DeliveryTicketNumber)
			 BEGIN
				UPDATE WPTSSalesHeader SET
				    WPTSSalesHeader.OperationId	  = @mOperationId,
					WPTSSalesHeader.Level1ID = @Level1ID,
					WPTSSalesHeader.Level2ID = @Level2ID,
				    WPTSSalesHeader.JobStart		  = @JDECreatedDate,
				    WPTSSalesHeader.CustomerId	  = @CustomerId,
				    WPTSSalesHeader.CountryId		  = @WellLocationCountryId,
				    WPTSSalesHeader.IsProcessed	  = 0,
					WPTSSalesHeader.WFTLocationId=@WFTLocationId
				WHERE DeliveryTicketNumber	  = @DeliveryTicketNumber
			 END
		  ELSE
			 BEGIN
				INSERT INTO WPTSSalesHeader (
				    DeliveryTicketNumber,
				    OperationId,
					Level1ID,
					Level2ID,
				    JobStart,
				    CustomerId,
				    CountryId,
				    IsProcessed,
					WFTLocationId)
				VALUES (
				    @DeliveryTicketNumber,
				    @mOperationID,
					@Level1ID,
					@Level2ID,
				    @JDECreatedDate,
				    @CustomerId,
				    @WellLocationCountryId,
				    0,
					@WFTLocationId)
			 END


		  UPDATE ETLSalesHeader SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber;





		  PRINT 'END INSERT/UPDATE WPTSSalesHeader'
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END INSERT/UPDATE WPTSSalesHeader');
		  --Audit Notification ********************************************************************************************


		  PRINT 'END PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) 
		  --Audit Notification ********************************************************************************************
		  INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END PROCESSING Delivery Ticket Number: ' + CAST(@DeliveryTicketNumber as nvarchar) );
		  --Audit Notification ********************************************************************************************


		  DELETE FROM #ETLSalesHeader WHERE DeliveryTicketNumber = @DeliveryTicketNumber;
	   END

	   DROP TABLE #ETLSalesHeader;


	   PRINT 'END WPTSSalesHeader PROCESS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'END WPTSSalesHeader PROCESS');
	   --Audit Notification ********************************************************************************************


	   PRINT 'Sales - End Move from ETL to WPTS'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Move from ETL to WPTS');
	   --Audit Notification ********************************************************************************************


	   COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'SALES - END MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************    


    
	--If Audit Logging is enabled, write the Table Variable to the database
	--Else, only write the Warnings and Errors
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END




GO
/****** Object:  StoredProcedure [dbo].[Sales_MoveFromJDEJobtoWPTS]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Sales_MoveFromJDEJobtoWPTS]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ReturnCode INT;
    DECLARE @mEmailAddress NVARCHAR(50);
    DECLARE @mEmailSubject NVARCHAR(200);
    DECLARE @mEmailHTML NVARCHAR(MAX);

    SET @mEmailAddress = 'DLGBSMPerformanceTrackingSystem@weatherford.com';
    SET @mEmailSubject = 'Warning: JDE Integration Error.';
    SET @mEmailHTML = 'Check the AuditLogs in JDEJobs table.  An error occurred in one of the Sales_MoveFromJDEJobtoWPTS stored procedures.';


    --Process the Header Records
    EXEC @ReturnCode = [dbo].[Sales_MoveFromJDEJobtoWPTS_HEADER] @aIsAuditEnabled


    IF @ReturnCode = 1
    BEGIN
	   --Process the Equipment Records 1,000 at a time
	   WHILE (SELECT COUNT(1)
			 FROM WPTSSalesHeader 
			 JOIN WPTSSalesEquipment ON WPTSSalesHeader.DeliveryTicketNumber = WPTSSalesEquipment.DeliveryTicketNumber
			 WHERE WPTSSalesEquipment.IsProcessed = 0) > 0
		  BEGIN
			 IF @ReturnCode = 1
			 BEGIN
				EXEC @ReturnCode = [dbo].[Sales_MoveFromJDEJobtoWPTS_EQUIPMENT] @aIsAuditEnabled
			 END

			 IF @ReturnCode = 0
				BREAK
			 ELSE
				CONTINUE
		  END
    END

    IF @ReturnCode = 0
    BEGIN
        EXEC [DISJobHistory].[dbo].usp_smtp_sendmail @To = @mEmailAddress ,@Subject = @mEmailSubject, @message = @mEmailHTML
    END
END


GO
/****** Object:  StoredProcedure [dbo].[Sales_MoveFromJDEJobtoWPTS_EQUIPMENT]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Sales_MoveFromJDEJobtoWPTS_EQUIPMENT]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Sales_MoveFromJDEJobtoWPTS_EQUIPMENT'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mReturnValue		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mTemplateName		= 'Sales';
    SET	  @mReturnValue		= 1;


    BEGIN TRY
	   PRINT 'Start Insert/Update WPTS Rental Equipment Records'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'SALES - Start Insert/Update WPTS Rental Equipment Records');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Sales Equipment Records
	   CREATE TABLE #JDESalesEquipment (ReportId INT, OrderLineNumber FLOAT);
	   INSERT INTO #JDESalesEquipment (ReportId, OrderLineNumber)
		  SELECT TOP 1000 WPTSSalesHeader.ReportId, WPTSSalesEquipment.OrderLineNumber 
		  FROM WPTSSalesHeader 
		  JOIN WPTSSalesEquipment ON WPTSSalesHeader.DeliveryTicketNumber = WPTSSalesEquipment.DeliveryTicketNumber
		  WHERE WPTSSalesEquipment.IsProcessed = 0;

	   DECLARE @OrderLineNumber FLOAT;
	   DECLARE @ReportId INT;
	   DECLARE @Sequence INT;

	   WHILE (SELECT COUNT(1) FROM #JDESalesEquipment) > 0
	   BEGIN
		  BEGIN TRANSACTION
		  SELECT TOP 1 @Reportid = ReportId, @OrderLineNumber = OrderLineNumber FROM #JDESalesEquipment;

		  IF EXISTS (SELECT * FROM DISJobHistory.dbo.SalesEquipment WHERE ReportId = @ReportId AND OrderLineNumber = @OrderLineNumber)
			 BEGIN
			 UPDATE Destination SET
				Destination.InvoiceNumber = Source.InvoiceNumber,
				Destination.BranchPlantCode = Source.BranchPlantCode,
				Destination.Quantity = Source.Quantity,
				Destination.SerialNumber = Source.SerialNumber,
				Destination.Description = Source.Description,
				Destination.ItemNumber = Source.ItemNumber,
				Destination.ReferenceNumber = Source.ReferenceNumber,
				Destination.InvUOM = Source.InvUOM,
				Destination.GLCode = Source.GLCode,
				Destination.HyperionPLCode = Source.HyperionPLCode,
				Destination.ShippedDate = Source.ShippedDate,
				Destination.SalesStatusId = Source.SalesStatusId,
				Destination.LastJDEUpdateDate = Source.LastJDEUpdateDate
			 FROM DISJobHistory.dbo.SalesEquipment Destination
			 JOIN WPTSSalesHeader ON Destination.ReportId = WPTSSalesHeader.ReportId
			 JOIN WPTSSalesEquipment Source ON WPTSSalesHeader.DeliveryTicketNumber = Source.DeliveryTicketNumber AND Destination.OrderLineNumber = Source.OrderLineNumber
			 WHERE 
				WPTSSalesHeader.ReportId = @ReportId
				AND Source.OrderLineNumber = @OrderLineNumber
			 END
		  ELSE
			 BEGIN
			 INSERT INTO DISJobHistory.dbo.SalesEquipment(
				TemplateName,
				ReportId,
				OrderLineNumber,
				InvoiceNumber,
				BranchPlantCode,
				Quantity,
				SerialNumber,
				Description,
				ItemNumber,
				ReferenceNumber,
				InvUOM,
				GLCode,
				HyperionPLCode,
				ShippedDate,
				SalesStatusId,
				LastJDEUpdateDate
			 )
			 SELECT
				@mTemplateName,
				WPTSSalesHeader.ReportId,
				OrderLineNumber,
				InvoiceNumber,
				BranchPlantCode,
				Quantity,
				SerialNumber,
				Description,
				ItemNumber,
				ReferenceNumber,
				InvUOM,
				GLCode,
				HyperionPLCode,
				ShippedDate,
				SalesStatusId,
				LastJDEUpdateDate
			 FROM WPTSSalesEquipment
			 JOIN WPTSSalesHeader ON WPTSSalesEquipment.DeliveryTicketNumber = WPTSSalesHeader.DeliveryTicketNumber
			 WHERE 
				WPTSSalesHeader.ReportId = @ReportId	
				AND WPTSSalesEquipment.OrderLineNumber = @OrderLineNumber	 
				AND WPTSSalesEquipment.IsProcessed = 0;
			 END

		  UPDATE Destination SET IsProcessed = 1, ProcessedDate = GETDATE()
		  FROM WPTSSalesEquipment Destination
		  JOIN WPTSSalesHeader Source ON Destination.DeliveryTicketNumber = Source.DeliveryTicketNumber
		  WHERE ReportId = @ReportId AND OrderLineNumber = @OrderLineNumber;

		  DELETE FROM #JDESalesEquipment WHERE ReportId = @ReportId AND OrderLineNumber = @OrderLineNumber;

		  COMMIT TRANSACTION
	   END

	   DROP TABLE #JDESalesEquipment;

	   PRINT 'End Insert/Update WPTS Rental Equipment Records'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'End Insert/Update WPTS Rental Equipment Records');
	   --Audit Notification ********************************************************************************************
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'SALES - END MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************    


    
	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END



GO
/****** Object:  StoredProcedure [dbo].[Sales_MoveFromJDEJobtoWPTS_HEADER]    Script Date: 12/12/2019 2:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Sales_MoveFromJDEJobtoWPTS_HEADER]
    @aIsAuditEnabled BIT = 1 --Default to enabling Audit
AS
BEGIN
    SET NOCOUNT ON;



    --Create a Table Variable to store all of the Audit information.
    --If Auditing is turned on, insert into AuditLog
    DECLARE @AuditLogs TABLE (
	   DateTime DATETIME NOT NULL DEFAULT(getdate()),
	   AuditTypeId INT NOT NULL,
	   Caller NVARCHAR(50) NOT NULL DEFAULT('Sales_MoveFromJDEJobtoWPTS_HEADER'),
	   Message NVARCHAR(MAX) NOT NULL,
	   ExceptionMessage NVARCHAR(MAX) NULL
    )


    DECLARE @NotificationAuditType	INT;
    DECLARE @WarningAuditType		INT;
    DECLARE @ErrorAuditType		INT;
    DECLARE @mTemplateName		NVARCHAR(30);
    DECLARE @mJDEUser			INT;
    DECLARE @mReturnValue		INT;
	DECLARE @mOperationId		INT;
    SET	  @NotificationAuditType	= 1;
    SET	  @WarningAuditType		= 2;
    SET	  @ErrorAuditType		= 3;
    SET	  @mTemplateName		= 'Sales';
    SET	  @mReturnValue		= 1;
	SET	  @mOperationId		= 204;

	--Audit Notification ********************************************************************************************
	INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'SALES - START MOVE TO WPTS PROCESS');
	--Audit Notification ********************************************************************************************


    BEGIN TRY
	   SELECT @mJDEUser = ID FROM DISJobHistory.dbo.UserAuth WHERE UserName = 'JDESystemUser';


	   PRINT 'Start Insert/Update WPTS Header'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'Start Insert/Update WPTS Header');
	   --Audit Notification ********************************************************************************************

	   --Insert/Update WPTS Header Records
	   CREATE TABLE #SalesJobs (DeliveryTicketNumber BIGINT, ReportId INT, Level1ID INT, Level2ID INT,WFTLocationId INT);
	   INSERT INTO #SalesJobs (DeliveryTicketNumber, ReportId,Level1ID,Level2ID,WFTLocationId) SELECT DeliveryTicketNumber, ReportId,Level1ID,Level2ID,WFTLocationId FROM WPTSSalesHeader WHERE IsProcessed = 0;

	   DECLARE @DeliveryTicketNumber BIGINT;
	   DECLARE @ReportId INT;
	   DECLARE @Level1ID INT;
	   DECLARE @Level2ID INT;
	   DECLARE @WFTLocationId int;

	   WHILE (SELECT COUNT(1) FROM #SalesJobs) > 0
	   BEGIN
		  BEGIN TRANSACTION
		  SELECT TOP 1 @DeliveryTicketNumber = DeliveryTicketNumber, @ReportId = ReportId, @Level1ID = Level1ID, @Level2ID = Level2ID,@WFTLocationId =WFTLocationId FROM #SalesJobs;

		  --If the Report Id exists in WPTS, update using the Report Id.
		  --If the Report Id is NULL, Insert using Delivery Ticket Number.
		  --If Report Id does not exist in WPTS, ignore it since it was deleted.

		  IF EXISTS (SELECT * FROM DISJobHistory.dbo.HdrProfile WHERE ReportId = @ReportId)
			 BEGIN

			 UPDATE Destination SET
				Destination.OperationId = Source.OperationId,
				Destination.JobStart = Source.JobStart,
				Destination.CustomerId = Source.CustomerId,
				Destination.WellCountryID = Source.CountryId,
				Destination.WFDLocationID = @WFTLocationId
			 FROM DISJobHistory.dbo.HdrProfile Destination
			 JOIN WPTSSalesHeader Source ON Destination.ReportID = Source.ReportId
			 WHERE Source.ReportId = @ReportId
			 END
		  ELSE
			 BEGIN
				IF @ReportId IS NULL
				BEGIN
				--FIRST INSERT INTO HdrProfile to get Report Id
				INSERT INTO DISJobHistory.dbo.HdrProfile(
				    OperationID,
				    JobStart,
				    CustomerId,
				    WellCountryID,
				    CreatedBy,
					WFDLocationID
				)
				SELECT
				    OperationId,
				    JobStart,
				    CustomerId,
				    CountryId,
				    @mJDEUser,
					@WFTLocationId
				FROM WPTSSalesHeader 
				WHERE DeliveryTicketNumber = @DeliveryTicketNumber;

				SELECT @ReportId = SCOPE_IDENTITY();

				--SECOND INSERT INTO JobPerfv2 to save Delivery Ticket Number
				INSERT INTO DISJobHistory.dbo.JobPerfv2 (ReportId, JobNo) VALUES (@ReportId,@DeliveryTicketNumber);

				--THIRD UPDATE WPTSHeader
				UPDATE WPTSSalesHeader SET ReportId = @ReportId WHERE DeliveryTicketNumber = @DeliveryTicketNumber

				--Fourth INSERT INTO Sales Table
				INSERT INTO DISJobHistory.dbo.Sales (ReportId) VALUES (@ReportId);
				END
			 END
		--remove orphans, needed due to implementation. This needs to be fixed at some point to insure that a productlineid exists before a job is populated
		  delete from disjobhistory..userchoicekey where reportid =@ReportId
		  and disjobhistory..userchoicekey.dbFieldID in (38031,38032)
		  and id not in
		  (
			select level3id from disjobhistory..hdrprofile where ReportID = @ReportId
			UNION
			select level4id from disjobhistory..hdrprofile where ReportID = @ReportId
		  )
		  --Get Level3 and Level4 User Choice Values and Update hdrProfile
		  EXEC hdrProfile_InsertUpdateUserChoice @ReportId = @ReportId, @OperationId = @mOperationId, @DeliveryTicketNumber = @DeliveryTicketNumber, @Level1ID = @Level1ID, @Level2ID = @Level2ID, @aIsAuditEnabled = 0

		  UPDATE WPTSSalesHeader SET IsProcessed = 1, ProcessedDate = GETDATE() WHERE DeliveryTicketNumber = @DeliveryTicketNumber;

		  DELETE FROM #SalesJobs WHERE DeliveryTicketNumber = @DeliveryTicketNumber;


		  COMMIT TRANSACTION
	   END

	   DROP TABLE #SalesJobs;

	   PRINT 'End Insert/Update WPTS Header'
	   --Audit Notification ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@NotificationAuditType,'SALES - End Insert/Update WPTS Header');
	   --Audit Notification ********************************************************************************************
    END TRY
    BEGIN CATCH
	   IF @@TRANCOUNT > 0
			 ROLLBACK TRANSACTION;
					
	   PRINT 'Error #: ' + ltrim(str(error_number()))
	   PRINT 'Error: ' + error_message()
	   --Audit Error ********************************************************************************************
	   INSERT INTO @AuditLogs (AuditTypeId, Message) VALUES (@ErrorAuditType,'Error #: ' + ltrim(str(error_number())) + '.  Error: ' + error_message());
	   --Audit Error ********************************************************************************************

	   SET @mReturnValue = 0;
    END CATCH
    
    
	--If Audit Logging is enabled, write the Table Variable to the database
	IF (@aIsAuditEnabled = 1)
		BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs
		END    	
     ELSE
	   BEGIN
			INSERT INTO AuditLog (DateTime, AuditTypeId, Caller, Message, ExceptionMessage)
			SELECT DateTime, AuditTypeId, Caller, Message, ExceptionMessage FROM @AuditLogs WHERE AuditTypeId > 1	   
	   END

    RETURN @mReturnValue;
END



GO
