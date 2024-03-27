--SELECT TransactionDate, AVG(timetaken) [Average Time Taken], max(timetaken) [Max Time Taken], 
--Count(*) [Total Transaction Count], 
--SUM(CASE WHEN ResponseCode = 'OK' OR ResponseCode ='BadRequest' THEN 1 ELSE 0 END) [Success Count],
--SUM(CASE WHEN ResponseCode = 'OK' OR ResponseCode ='BadRequest' THEN 0 ELSE 1 END) [Failure Count]
--from SOAWorkOrderRequest r
--JOIN SOAWorkOrderResponseHeader h ON r.RequestId = h.RequestId
--Where TransactionDate >'2018-03-28'
--group by TransactionDate
----ORDER By CreatedOn DESC'

----usp_MergeFixedAssets

SELECT 
	f.AssetNumber,
	s.AssetNumber [Scrap_AssetNumber],
	f.SerialNum,
	f.InventoryItemNum,
	s.SerialNum [Scrap_SerialNum],
	s.InventoryItemNum [Scrap_ItemNum],
	f.Source,
	s.Source [Scrap_Source],
	f.FixedAssetId,
	s.FixedAssetId [Scrap_FixedAssetId],
	f.DateAdded,
	s.DateAdded [Scrap_DateAdded],
	'exec  [dbo].[usp_MergeFixedAssets] ''' + CONVERT(varchar(max), f.FixedAssetId) + ''', ''' + CONVERT(varchar(max), s.FixedAssetId) + ''''
FROM FixedAssets f (NOLOCK)
JOIN FixedAssets s (NOLOCK) ON f.SerialNum = s.SerialNum and f.InventoryItemNum = s.InventoryItemNum
JOIN vwfixedassets v (NOLOCK) on v.FixedAssetId = f.FixedAssetId
WHERE v.IsAsset =  1 AND s.Source IN ('JDEWO') AND f.Source IN ('JDEETL')
order by s.DateAdded asc
