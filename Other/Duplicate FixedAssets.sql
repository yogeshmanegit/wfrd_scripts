SELECT AssetNumber, COUNT(*), (SELECT TOP 1 FixedAssetId FROM FixedAssets WHERE AssetNumber = a.AssetNumber ORDER BY DATEADDED DESC)
FROM FixedAssets a
WHERE AssetNumber IS NOT NULL
GROUP BY AssetNumber
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC