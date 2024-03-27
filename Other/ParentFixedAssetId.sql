BEGIN TRAN

UPDATE f
SET f.ParentFixedAssetId = a.ParentFixedAssetId--, f.TopLevelFixedAssetId = a.TopLevelFixedAssetId
FROM FixedAssets f
JOIN (
SELECT ROW_NUMBER() OVER (PARTITION BY fh.FixedAssetId ORDER BY fh.FixedAssetId, fh.DatedAdded DESC) [IndexNo], 
	fh.FixedAssetId, fh.DatedAdded, fh.WorkOrderId, fh.ParentFixedAssetId, w.FixedAssetId [TopLevelFixedAssetId],
	p.DocumentNumber
from FixedAssets f
JOIN FixedAssetHistory fh on f.FixedAssetId = fh.FixedAssetId
JOIN WorkOrders w ON fh.WorkOrderId = w.WorkOrderId
LEFT JOIN PartTransferDtl p ON p.RefId = w.WorkOrderId and f.FixedAssetId = p.FixedAssetId
WHERE fh.ParentFixedAssetId IS NOT NULL AND f.ParentFixedAssetId IS NULL AND f.AssetNumber IS NULL
AND w.FixedAssetId IN (SELECT FixedAssetid from WorkOrders WHERE WorkOrderNum ='W152347-1143')
) A ON f.FixedAssetId = a.FixedAssetId
WHERE A.IndexNo = 1 AND DocumentNumber IS NULL --AND WorkOrderId ='784FB397-7FD9-4F83-A438-A8BE006F8BA9'

ROLLBACK TRAN