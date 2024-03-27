UPDATE fa 
		SET 
			fa.AssetLifeRemaining = alr.AssetLifeRemaining
		FROM FixedAssets fa
		JOIN VW_FixedAsset_LifeConsumed alr on fa.FixedAssetId=alr.FixedAssetId
		JOIN (select Distinct FixedAssetId from CBMCalculatedMeterReadings 
				where UpdatedOn ='2023-03-12' and MeterReadingTypeId = 1) a on a.FixedAssetId = fa.FixedAssetId