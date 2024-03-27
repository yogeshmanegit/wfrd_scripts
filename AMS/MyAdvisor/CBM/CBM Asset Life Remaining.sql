--DECLARE @FixedAssetId uniqueidentifier = '2F142C72-8C69-4A67-A613-001E679CBF4F'
SELECT *,
			100 - (CASE 
					-- One time mandatory 
					WHEN MeterReadingTypeId = 4 THEN (CASE WHEN LastMeterReadingValue = 1 THEN 0 ELSE 100 END)
					--For all others
					WHEN LastMeterReadingValue < TriggerValue THEN (LastMeterReadingValue / TriggerValue) * 100 ELSE  100 END) [LifeRemaining]

into #tempDetail
		FROM 
		(

		SELECT parentFixedAsset.FixedAssetId [ParentFixedAssetId], f.FixedAssetId [ChildFixedAssetId], c.CBMMonitorId, c.MeterReadingTypeId,
		dbo.ufn_CBMMonitor_GetTrigger(c.CBMMonitorId, f.BranchPlant, f.FixedAssetId) [TriggerValue],

		-- As per CBM history calculations should be as below --------------------------------------------------  
		COALESCE(
			/*
				1	Operating Hours
				2	Circulating Hours
				3	Temperature Function
				6	Shock Monitor
				7	Vibration Monitor
			*/
			CASE WHEN c.MeterReadingTypeId IN (1,2,3,6,7) THEN r.LastMeterReadingValue

			--One Time Mandatory
			WHEN c.MeterReadingTypeId = 4 THEN 
			(
				-- if 
				CASE WHEN (select top 1 pftWO_OneTime.PFTWOId 
							FROM PFTWO pftWO_OneTime (NOLOCK)
							JOIN PFTConfig pftConfig_OneTime (NOLOCK) on pftWO_OneTime.PFTConfigId = pftConfig_OneTime.PFTConfigId
							WHERE pftWO_OneTime.FixedAssetId = parentFixedAsset.FixedAssetId
									AND pftConfig_OneTime.ObjectNumber = c.ObjectNumber
									AND pftWO_OneTime.PFTType = 3
									AND pftWO_OneTime.ReasonForChange = 'Closed - Passed'
						) IS NULL THEN 1 
					ELSE 0 END
			)
			-- scheduled    
			WHEN c.MeterReadingTypeId = 5 THEN  
					DATEDIFF(dd,  
								COALESCE(r.LastMeterReadingValue   -- Check Last PM PFT Completed    
									,(SELECT MIN(DateofTransaction) FROM PartTransferDtl p (NOLOCK) WHERE Dest = 'IN' AND p.FixedAssetId = f.fixedAssetId) 
									, f.DateAdded), 
					GETDATE())   

			-- AIRT Count
			WHEN c.MeterReadingTypeId = 8 THEN -- AIRT    
					ISNULL(
						(
							SELECT COUNT(*) 
							FROM AssetRepairTrack a
							WHERE a.FixedAssetId = parentFixedAsset.FixedAssetId 
								and a.Status = 'Closed'
								and a.DateAdded > ISNULL((SELECT MAX(pw.DateAdded)
													FROM PFTWO pw (NOLOCK)
													JOIN PftConfig pc (NOLOCK) on pw.PFTConfigId = pc.PFTConfigId and pc.ObjectNumber = c.ObjectNumber
													WHERE pw.FixedAssetId = parentFixedAsset.FixedAssetId 
														AND PFTType = 3
														AND pw.Active = 0
														AND pw.ReasonForChange = 'Closed - Passed'
													), '1900-01-01')
						),
					0)

			-- Days Since DT Return   
			WHEN c.MeterReadingTypeId IN (10, 11) THEN dbo.ufn_CbmMonitor_GetDTLastMeterReadingValue(f.fixedAssetid, c.CBMMonitorId) 

		END , DefaultMeterReading, 0) AS LastMeterReadingValue


		FROM CBMMonitor c (NOLOCK) 
		JOIN CBMMonitorAssetItemNums pItem (NOLOCK) on c.CBMMonitorId = pItem.CBMMonitorId and pItem.IsParent = 1
		JOIN CBMMonitorAssetItemNums cItem (NOLOCK) on pItem.CBMMonitorId = cItem.CBMMonitorId and cItem.IsParent = 0
		JOIN FixedAssets f (NOLOCK) on f.InventoryItemNum = cItem.ItemNum
		JOIN FixedAssets parentFixedAsset (NOLOCK) ON ISNULL(f.TopLevelFixedAssetId, f.FixedAssetId) = parentFixedAsset.FixedAssetId and pItem.ItemNum = parentFixedAsset.InventoryItemNum
		JOIN PFTConfig pc (NOLOCK) ON c.ObjectNumber = pc.ObjectNumber AND pc.IsObsolete = 0
		LEFT JOIN CBMCalculatedMeterReadings r (NOLOCK) ON f.FixedAssetId = r.FixedAssetId AND c.CBMMonitorId = r.CBMMonitorId
		JOIN ItemNums inum (NOLOCK) ON inum.ItemNum = f.InventoryItemNum 
		JOIN SelectOptions s (NOLOCK) ON s.SelectName = 'CBMMeterTypes' AND c.MeterReadingTypeId = s.OptionValue
		WHERE c.Active = 1
			AND c.MeterReadingTypeId IN (1,2,3,4,5,6,7)
		) A

select ParentFixedAssetId, MIN(LifeRemaining) [LifeRemaining] into #tempParent from #tempDetail group by ParentFixedAssetId
select ChildFixedAssetId, MIN(LifeRemaining) [LifeRemaining] into #tempChild from #tempDetail where ParentFixedAssetId != ChildFixedAssetId group by ChildFixedAssetId

Update f 
	SET f.AssetLifeRemaining = p.LifeRemaining
FROM FixedAssets f
LEFT JOIN #tempParent p on f.FixedAssetId = p.ParentFixedAssetId
WHERE f.AssetNumber = f.ParentNumber
	AND ISNULL(f.AssetLifeRemaining, -1) != ISNULL(p.LifeRemaining, -1)

Update f 
	SET f.AssetLifeRemaining = c.LifeRemaining
FROM FixedAssets f
LEFT JOIN #tempChild c on f.FixedAssetId = c.ChildFixedAssetId
WHERE f.AssetNumber != f.ParentNumber
	AND ISNULL(f.AssetLifeRemaining, -1) != ISNULL(c.LifeRemaining, -1)


drop table #tempDetail
drop table #tempParent
drop table #tempChild