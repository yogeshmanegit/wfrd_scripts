ALTER PROCEDURE dbo.usp_PFTObjects_CreatePFTUtility
	@PFTConfigName VARCHAR(1024),
	@WindchillDocNumber VARCHAR(100),
	@PFTType INT,
	@ProductlineId INT,
	@CreatedBy VARCHAR(20),
	@PFTStepObjectNumbers VARCHAR(MAX)
AS

DECLARE @PftConfigObjectId int;

BEGIN TRY
		
	BEGIN TRANSACTION

	INSERT INTO [dbo].[PFTObjects]
				([ObjectNumber]
				,[Revision]
				,[Type]
				,[Name]
				,[Description]
				,[ProductLineId]
				,[State]
				,[Field1]
				,[Field2]
				,[CreatedBy]
				,[CreatedOn])
			SELECT
				MAX(ObjectNumber) + 1
				,1
				,1
				,@PFTConfigName
				,@PFTConfigName
				,@ProductlineId
				,1
				,@PFTType
				,@WindchillDocNumber
				,@CreatedBy
				,GETDATE()
		FROM PFTObjects

	SET @PftConfigObjectId = @@IDENTITY

	INSERT INTO [dbo].[PFTObjectMappings]
				([ParentId]
				,[ObjectId]
				,[SequenceNumber]
				,[CreatedBy]
				,[CreatedOn])
			SELECT
				@PftConfigObjectId,
				o.ObjectId,
				s.NodeLevel,
				@CreatedBy,
				GETDATE()
		FROM dbo.Split(',', @PFTStepObjectNumbers) s
		JOIN PFTObjects o ON s.val = o.ObjectNumber and o.[State] = 3
		ORDER BY s.NodeLevel ASC

	COMMIT TRANSACTION

	-- select pft object details
	SELECT * from PFTObjects WHERE ObjectId = @PftConfigObjectId
	SELECT * from PFTObjectMappings WHERE ParentId = @PftConfigObjectId

END TRY
BEGIN CATCH

    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  

	ROLLBACK TRANSACTION

END CATCH


GO