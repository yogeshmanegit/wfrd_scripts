ALTER VIEW [dbo].[VW_FixedAsset_LifeConsumed]
AS
SELECT FixedAssetId,
[AssetLifeConsumed],
100 - [AssetLifeConsumed] As [AssetLifeRemaining]
FROM (
	SELECT c.FixedAssetId, Max(c.AssetLifeConsumed) as [AssetLifeConsumed] FROM
(SELECT m.FixedAssetId,
		CONVERT(DECIMAL(10,2), 
					MAX(CASE WHEN CONVERT(DECIMAL(10,2), m.LastMeterReadingValue) > cm.GlobalTrigger THEN 100.00
							ELSE (CONVERT(DECIMAL(10,2), m.LastMeterReadingValue) / CONVERT(INT, cm.GlobalTrigger)) * 100.00 end))  [AssetLifeConsumed]
	FROM dbo.CBMCalculatedMeterReadings m (NOLOCK)
	JOIN FixedAssets f (NOLOCK) ON f.FixedAssetId = m.FixedAssetId
	JOIN BranchPlants b (NOLOCK) ON b.BranchPlant = f.BranchPlant
	JOIN CBMMonitor cm (NOLOCK) ON cm.CBMMonitorId = m.CBMMonitorId 
			AND m.MeterReadingTypeId = cm.MeterReadingTypeId
	WHERE cm.MeterReadingTypeId IN (1,2,3,6,7) AND ISNUMERIC(m.LastMeterReadingValue) = 1
	GROUP by m.FixedAssetId
UNION
	SELECT b.FixedAssetId, max(b.AssetLifeConsumed) FROM 
	(SELECT f1.FixedAssetId,  m.MeterReadingTypeId,	 
	CONVERT(DECIMAL(10,2), MAX(	CASE WHEN m.MeterReadingTypeId = 5 THEN
										CASE WHEN CONVERT(DECIMAL(10,2), scheduledCount) > m.GlobalTrigger THEN 100.00
										ELSE (CONVERT(DECIMAL(10,2), scheduledCount) / CONVERT(INT, m.GlobalTrigger)) * 100.00 
										END 
									WHEN m.MeterReadingTypeId = 8 THEN
										CASE WHEN artCount = 0 OR (artCount % m.GlobalTrigger) = 0 THEN 0 
										ELSE ((artCount % m.GlobalTrigger)/m.GlobalTrigger) * 100 
										END
									WHEN m.MeterReadingTypeId = 10 THEN
										CASE WHEN CONVERT(DECIMAL(10,2), dtCount) > m.GlobalTrigger THEN 100.00
										ELSE (CONVERT(DECIMAL(10,2), dtCount) / CONVERT(INT, m.GlobalTrigger)) * 100.00 
										END
									WHEN m.MeterReadingTypeId = 11 THEN
										CASE WHEN CONVERT(DECIMAL(10,2), dtSCount) > m.GlobalTrigger THEN 100.00
										ELSE (CONVERT(DECIMAL(10,2), dtSCount) / CONVERT(INT, m.GlobalTrigger)) * 100.00 
										END
								END)) [AssetLifeConsumed]
	
	FROM CBMMonitor m (NOLOCK)   
	JOIN CBMMonitorAssetItemNums p (NOLOCK) on p.CBMMonitorId = m.CBMMonitorId and p.IsParent = 1  
	JOIN CBMMonitorAssetItemNums C (NOLOCK) ON c.CBMMonitorId = m.CBMMonitorId and c.IsParent = 0  
	JOIN AssetRepairTrack a (NOLOCK) on a.ItemNum = c.ItemNum  
	JOIN FixedAssets f (NOLOCK) ON a.FixedAssetId = f.FixedAssetId  
	JOIN FixedAssets f1 (NOLOCK) ON f1.FixedAssetId = ISNULL(f.TopLevelFixedAssetId, f.FixedAssetId) AND f1.InventoryItemNum = p.ItemNum  
	LEFT JOIN CBMCalculatedMeterReadings r  (NOLOCK) ON r.FixedAssetId = f1.FixedAssetid AND r.MeterReadingTypeId = m.MeterReadingTypeId AND r.CBMMonitorId = m.CBMMonitorId --AND r.MeterReadingTypeId = 5
	CROSS APPLY(SELECT artCount = (SELECT COUNT(*) FROM AssetRepairTrack art (NOLOCK) WHERE art.FixedAssetId = f.FixedAssetId)) ac --- airt count
	CROSS APPLY (SELECT scheduledCount =	DATEDIFF(dd,    --- scheduled
											COALESCE(r.LastMeterReadingValue
													--,(SELECT  MAX(pws.DateAdded) [DateAdded] FROM PFTWO pw JOIN PFTWOSeq pws on pw.PFTWOId = pws.PFTWOId
													--	WHERE pw.FixedAssetId = f1.FixedAssetId AND pw.PFTConfigId = m.PFTConfigId AND m.MeterReadingTypeId = 5 AND pw.PFTType = 3 and pw.Active = 0) -- PMPFT  
													,(SELECT MIN(DateofTransaction) [DateofTransaction] FROM PartTransferDtl p (NOLOCK) Where Dest = 'IN' AND p.FixedAssetId = f1.fixedAssetId)  
													, f1.DateAdded)  
													,GETDATE())) sc
	CROSS APPLY (SELECT dtCount = CASE WHEN ---check active Days Since DT pmpft
					(SELECT COUNT(pw.PFTWOId) FROM PFTWO pw (NOLOCK)
					WHERE pw.FixedAssetId = f1.FixedAssetId AND pw.PFTType = 3 AND pw.PFTConfigId = m.PFTConfigId AND m.MeterReadingTypeId = 10 AND pw.Active = 1) >= 1 
					THEN 0 ELSE 
					(
					SELECT TOP 1 
					CASE di.ShipType 
					WHEN 'DT-RETURN' THEN
						CASE	
								WHEN --check latest DT pmpft
									(SELECT COUNT(pw.PFTWOId) FROM PFTWO pw (NOLOCK)
									WHERE pw.FixedAssetId = f1.FixedAssetId AND pw.PFTType = 3 AND pw.PFTConfigId = m.PFTConfigId AND m.MeterReadingTypeId = 10) = 0
								THEN DATEDIFF(dd, dii.DateReturned , GETDATE()) 
								WHEN 
									dii.DateReturned > (SELECT MAX(pws.DateAdded) [DateAdded] FROM PFTWO pw (NOLOCK) JOIN PFTWOSeq pws (NOLOCK) on pw.PFTWOId = pws.PFTWOId
									WHERE pw.FixedAssetId = f1.FixedAssetId and pw.PFTType = 3 AND pw.PFTConfigId = m.PFTConfigId AND m.MeterReadingTypeId = 10 AND pw.Active = 0)
								THEN DATEDIFF(dd, dii.DateReturned , GETDATE()) 
						END 
					ELSE null END
					FROM	Dispatches d (NOLOCK) JOIN
							DispatchInstances di (NOLOCK) on d.DispatchId=di.DispatchId JOIN
							DispatchInstanceItems dii (NOLOCK) on di.DispatchInstanceId=dii.DispatchInstanceId
					WHERE	dii.FixedAssetId = f.FixedAssetId AND di.ShipType = 'DT-RETURN'
					ORDER BY dii.DateAdded DESC
					) 
					END
					) dc
	 CROSS APPLY (SELECT dtSCount = CASE WHEN ---check active Days Since DT Ship pmpft
					(SELECT COUNT(pw.PFTWOId) FROM PFTWO pw (NOLOCK)
					WHERE pw.FixedAssetId = f1.FixedAssetId AND pw.PFTType = 3 AND pw.PFTConfigId = m.PFTConfigId AND m.MeterReadingTypeId = 11 AND pw.Active = 1) >= 1 
					THEN 0 ELSE 
					(
					SELECT TOP 1 
					CASE di.ShipType 
					WHEN 'DT-SEQ-ADD' THEN
						CASE	
								WHEN --check latest DT pmpft
									(SELECT COUNT(pw.PFTWOId) FROM PFTWO pw (NOLOCK) 
									WHERE pw.FixedAssetId = f1.FixedAssetId AND pw.PFTType = 3 AND pw.PFTConfigId = m.PFTConfigId AND m.MeterReadingTypeId = 11) = 0
								THEN DATEDIFF(dd, di.DateShipped , GETDATE()) 
								WHEN 
									di.DateShipped > (SELECT MAX(pws.DateAdded) [DateAdded] FROM PFTWO pw (NOLOCK) JOIN PFTWOSeq pws (NOLOCK) on pw.PFTWOId = pws.PFTWOId
									WHERE pw.FixedAssetId = f1.FixedAssetId and pw.PFTType = 3 AND pw.PFTConfigId = m.PFTConfigId AND m.MeterReadingTypeId = 11 AND pw.Active = 0)
								THEN DATEDIFF(dd, di.DateShipped , GETDATE()) 
						END 
					ELSE null END
					FROM	Dispatches d (NOLOCK) JOIN
							DispatchInstances di (NOLOCK) on d.DispatchId=di.DispatchId JOIN
							DispatchInstanceItems dii (NOLOCK) on di.DispatchInstanceId=dii.DispatchInstanceId
					WHERE	dii.FixedAssetId = f.FixedAssetId AND di.ShipType = 'DT-SEQ-ADD'
					ORDER BY dii.DateAdded DESC
					) 
					END
					) dsc
	WHERE m.MeterReadingTypeId in ( 5, 8, 10, 11)
	GROUP BY f1.FixedAssetId, m.MeterReadingTypeId
	) b
	WHERE b.AssetLifeConsumed is not null 
	group by b.FixedAssetId) c
	GROUP BY c.FixedAssetId
) AS A

