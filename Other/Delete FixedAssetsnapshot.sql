DELETE FROM FixedAssetSnapshots
WHERE FixedAssetSnaphotId IN (
SELECT FixedAssetSnaphotId 
FROM (
	SELECT ROW_NUMBER() OVER(Partition By FixedAssetId, inventorydate, LastStatusChangeDate ORDER BY FixedAssetId, inventorydate, LastStatusChangeDate) [Index], FixedAssetSnaphotId 
	FROM FixedAssetSnapshots (NOLOCK) WHERE CONVERT(DATETIME,CONVERT(char(10), inventorydate, 103),103) > '2017-02-01'
) A WHERE [Index] > 1
)
