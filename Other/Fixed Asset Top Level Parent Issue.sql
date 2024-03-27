DECLARE @FixedAssetId uniqueIdentifier
DECLARE @TopLevelFixedAssetId uniqueIdentifier

DECLARE db_cursor1 CURSOR FOR  
	SELECT fa.fixedAssetId From AesOps.dbo.FixedAssets fa Where fa.ParentFixedAssetId IS NOT NULL
OPEN db_cursor1   
FETCH NEXT FROM db_cursor1 INTO @fixedAssetId

WHILE @@FETCH_STATUS = 0   
BEGIN   
  --select @assetNumber, @branchPlant

	BEGIN TRY
		SELECT @TopLevelFixedAssetId = (Select top 1 FixedAssetId from AesOps.dbo.fnGetTopMostParent(@FixedAssetId))
	END TRY
	BEGIN CATCH
		print '''' + CONVERT(VARCHAR(MAX),@FixedAssetId) + ''','
	END CATCH
	
  FETCH NEXT FROM db_cursor1 INTO @fixedAssetId
END

CLOSE db_cursor1   
DEALLOCATE db_cursor1
