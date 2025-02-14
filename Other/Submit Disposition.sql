/****** Object:  StoredProcedure [dbo].[usp_AIRTSubmitDisposition]    Script Date: 10/15/2016 7:23:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/13/2016
-- Description:	Create/Update disposition
-- =============================================
ALTER PROCEDURE [dbo].[usp_AIRTSubmitDisposition]
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier, 
	@UserId int,
	@ApproverId int,
	@DispositionType int,
	@BranchPlant int,
	@Comments varchar(2048)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DispositionId INT,  @ApproverLevel INT, @sLocId varchar(16), @sProductLine varchar(50)

	SELECT @DispositionId = (SELECT TOP 1 DispositionId FROM ARTDispositions WHERE AssetRepairTrackId = @AssetRepairTrackId ORDER BY DateAdded DESC)
	SELECT @sLocId = a.FromBranchPlant, 
			@sProductLine = f.ProductLineCode
	FROM AssetRepairTrack a (NOLOCK)
	JOIN FixedAssets f (NOLOCK) on a.FixedAssetId = f.FixedAssetId 
	Where AssetRepairTrackId = @AssetRepairTrackId

	SET @ApproverLevel = dbo.udf_GetAIRTApproverLevel(@sProductLine, @sLocId, @UserId) 

	IF (@DispositionId IS NULL)
		BEGIN
			-- INSERT 

			INSERT INTO [dbo].[ARTDispositions]
				   ([AssetRepairTrackId]
				   ,[Disposition]
				   ,[DispositionedById]
				   ,[DispositionDate]
				   ,[DispositionComments]
				   ,[Status]
				   ,[ApproverId]
				   ,[ApprovalLevel]
				   ,[ShipToLocation]
				   ,[UserIdAdded]
				   ,[DateAdded])
			 VALUES
				   (@AssetRepairTrackId
				   ,@DispositionType
				   ,@UserId
				   ,GETDATE()
				   ,@Comments
				   ,CASE WHEN @ApproverLevel > 1 THEN 'Approved' 
						WHEN @ApproverLevel = 1 THEN 'District Approved' 
						ELSE 'Submitted' END
				   ,@ApproverId
				   ,@ApproverLevel 
				   ,@BranchPlant
				   ,@UserId
				   ,GETDATE())

				   SET @DispositionId = @@IDENTITY
			exec spAuditRecords 201, @UserId, @DispositionId, null, @DispositionId, 'ARTDispositions', 'DispositionId', 'AuditARTDispositions', null

		END
	ELSE
		BEGIN
	
			-- UPDATE
	
			UPDATE [dbo].[ARTDispositions]
				SET [Disposition] = @DispositionType
					,[DispositionedById] = @UserId
					,[DispositionDate] = GETDATE()
					,[DispositionComments] = @Comments
					,[Status] = CASE WHEN @ApproverLevel = 2 THEN 'Approved' 
									WHEN @ApproverLevel = 1 THEN 'District Approved' 
									ELSE 'Submitted' END
					,[ApproverId] = @ApproverId
					,[ApprovalLevel] = @ApproverLevel
					,[ShipToLocation] = @BranchPlant
					,[UserIdAdded] = @UserId
					,[DateAdded] = GETDATE()
				WHERE DispositionId = @DispositionId

			exec spAuditRecords 201, @UserId, @DispositionId, null, @DispositionId, 'ARTDispositions', 'DispositionId', 'AuditARTDispositions', null

			IF EXISTS(SELECT 1 FROM ARTDispositions WHERE DispositionId = @DispositionId AND Status = 'Approved')
			BEGIN
				UPDATE AssetRepairTrack 
					SET ShipToBranchPlant = @BranchPlant
				Where AssetRepairTrackId = @AssetRepairTrackId
			END
		END

		SELECT TOP 1 * FROM [ARTDispositions] (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId 
		ORDER BY DateAdded DESC
END


