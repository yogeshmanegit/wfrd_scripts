BEGIN TRAN

DECLARE @AssetRepairTrackId UNIQUEIDENTIFIER
DECLARE @WFTNetworkId varchar(100), @Status VARCHAR(100), @ReturnMessage VARCHAR(200)
DECLARE @IsApproved BIT = 0, @UserId INT
DECLARE @DispositionType int, @BranchPlant int, @Comments varchar(2048) =''

SET @AssetRepairTrackId ='515357C6-9ABD-4E58-A0D5-A72200875A10';
SET @WFTNetworkId = 'e220932';

IF NOT EXISTS(SELECT 1 FROM AssetRepairTrack WHERE AssetRepairTrackId = @AssetRepairTrackId)
	BEGIN
		SET @ReturnMessage = 'DB : Invalid AIRT';
	END
ELSE
	BEGIN
		
		DECLARE @ApproverLevel int, @ProductLine varchar(50), @LocId VARCHAR(16)
		SELECT @UserId = UserId FROM Users WHERE WFTUserName = @WFTNetworkId

		SELECT @ApproverLevel = dbo.udf_GetAIRTApproverLevel(f.ProductLineCode , a.FromBranchPlant, @UserId)
		FROM AssetRepairTrack a (NOLOCK)
		JOIN FixedAssets f (NOLOCK) on a.FixedAssetId = f.FixedAssetId
		WHERE AssetRepairTrackId = @AssetRepairTrackId
		
		SELECT	@Status = Status, 
				@DispositionType = Disposition,
				@BranchPlant = ShipToLocation 
		FROM ARTDispositions WHERE AssetRepairTrackId = @AssetRepairTrackId ORDER BY DateAdded DESC

		IF (@Status IS NULL)
			BEGIN
				SET @ReturnMessage = 'DB : Disposition needs to be submitted first to be approved';
			END
		ELSE IF (@Status = 'Approved')
			BEGIN
				SET @ReturnMessage = 'DB : Disposition is already approved';
			END
		IF (@Status = 'Submitted')
			BEGIN
				
				IF(@ApproverLevel > 0)
					BEGIN
						SET @Status = CASE WHEN @ApproverLevel = 2 THEN 'Approved' ELSE 'District Approved' END
						exec dbo.usp_CBM_SubmitDisposition @AssetRepairTrackId, @UserId, @UserId, @DispositionType, @BranchPlant, @Comments
					END
				ELSE
					BEGIN
						SET @ReturnMessage = 'DB : User does not have rights to approve disposition';
					END
			END
		ELSE IF(@Status = 'District Approved')
			BEGIN
				IF(@ApproverLevel > 1)
					BEGIN
						SET @Status = CASE WHEN @ApproverLevel = 2 THEN 'Approved' ELSE 'District Approved' END
						exec dbo.usp_CBM_SubmitDisposition @AssetRepairTrackId, @UserId, @UserId, @DispositionType, @BranchPlant, @Comments
					END
				ELSE
					BEGIN
						SET @ReturnMessage = 'DB : User does not have rights to approve disposition';												
					END
			END
	END

SELECT @ReturnMessage

ROLLBACK TRAN