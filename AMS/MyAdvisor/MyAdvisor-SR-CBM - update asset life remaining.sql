

DECLARE @FixedAssetId uniqueidentifier

DECLARE db_cursor CURSOR FOR  
	
	SELECT DISTINCT fixedAssetId FROM CBMCalculatedMeterReadings
	
	OPEN db_cursor   
	FETCH NEXT FROM db_cursor INTO @FixedAssetId 

	WHILE @@FETCH_STATUS = 0   
	BEGIN   

		UPDATE fa 
		SET 
			fa.AssetLifeRemaining = (SELECT AssetLifeRemaining FROM VW_FixedAsset_LifeConsumed WHERE FixedAssetId = @FixedAssetId)
		FROM FixedAssets fa
		WHERE fa.FixedAssetId = @FixedAssetId

		WAITFOR DELAY '00:00:01'

		FETCH NEXT FROM db_cursor INTO @FixedAssetId
	END

	CLOSE db_cursor   
	DEALLOCATE db_cursor