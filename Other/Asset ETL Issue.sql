
DECLARE @FixedAssetId uniqueidentifier
		, @TopLevelFixedAssetId uniqueidentifier

DECLARE db_cursor2 CURSOR FOR  
	SELECT fa.FixedAssetId
	From AesOps.dbo.FixedAssets fa 
	Where fa.ParentFixedAssetId IS NOT NULL and fa.FixedAssetId NOT IN ('9C3B0C07-88FA-4C9B-9A05-1D214910AE8E','615B14F0-148F-40F0-B1BE-341B19251FB3', '6226177A-62AC-4F47-8027-5774795B29D2', '6226177A-62AC-4F47-8027-5774795B29D2')
			
	OPEN db_cursor2   
	FETCH NEXT FROM db_cursor2 INTO @FixedAssetId

	WHILE @@FETCH_STATUS = 0   
	BEGIN   

		print @FixedAssetId

		SET @TopLevelFixedAssetId = (Select top 1 FixedAssetId from AesOps.dbo.fnGetTopMostParent(@FixedAssetId))

		FETCH NEXT FROM db_cursor2 INTO  @FixedAssetId
	END
	CLOSE db_cursor2 
	DEALLOCATE db_cursor2