
SELECT f.FixedAssetId, f1.FixedAssetId, f.InventoryItemNum, r.*
		FROM	FixedAssets f (NOLOCK) 
				JOIN FixedAssets f1 (NOLOCK) ON f.FixedAssetId = f1.TopLevelFixedAssetId
				JOIN CBMCalculatedMeterReadings r (NOLOCK) ON r.FixedAssetId = f1.FixedAssetid
				LEFT JOIN ItemNums inum ON inum.ItemNum = f.InventoryItemNum
				
				JOIN CBMMonitor c (NOLOCK) ON r.MeterReadingTypeId = c.MeterReadingTypeId and c.Active = 1
				--JOIN CBMMonitorAssetItemNums mi (NOLOCK) ON f.InventoryItemNum = mi.ItemNum AND c.CBMMonitorId = mi.CBMMonitorId and IsParent = 1
				--LEFT JOIN CBMMonitorAssetItemNums p(NOLOCK) ON f1.InventoryItemNum = p.ItemNum and  c.CBMMonitorId = p.CBMMonitorId and p.IsParent = 0
				--LEFT JOIN SelectOptions s (NOLOCK) ON s.SelectName = 'CBMMeterTypes' AND s.OptionValue = c.MeterReadingTypeId
				
				--LEFT JOIN AssetRepairTrack a (NOLOCK) ON a.fixedAssetid = f1.FixedAssetid
				--LEFT JOIN PFTConfig G(NOLOCK) ON G.PFTConfigId = c.PFTConfigID
				--LEFT JOIN PMDispositions PD(NOLOCK) ON PD.AssetRepairTrackId = a.AssetRepairTrackId and pd.PFTConfigId = c.PFTConfigId
				--LEFT JOIN PMDispositionItems i (NOLOCK)on i.AssetRepairTrackId = a.AssetrepairTrackId and i.FixedAssetId = f.FixedAssetId
				--		and i.MeterReadingTypeId = c.MeterReadingTypeId and i.PFTConfigId = c.PFTConfigId
			WHERE f.FixedAssetId = '6b0ce12f-645c-4597-b280-3d8a86549fbe'	--a.AssetRepairTrackId =  (SELECT top 1 assetRepairTrackId FROM AssetRepairTrack where FixedAssetId = '6b0ce12f-645c-4597-b280-3d8a86549fbe' order by DateAdded desc)