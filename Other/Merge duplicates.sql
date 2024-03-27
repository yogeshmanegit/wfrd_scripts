DECLARE @serialnum varchar(max) = '13798572-3'

SELECT * from FixedAssets where SerialNum = @serialnum

SELECT 'exec usp_MergeFixedAssets ''' + CONVERT(varchar(MAX), a.fixedassetid) + ''', ''' 
+ CONVERT(varchar(MAX), f.fixedassetid) + ''''
from FixedAssets f 
LEFT JOIN (SELECT DISTINCT FixedAssetId, AssetNumber from PFTWO p WHERE p.SerialNum = @serialnum) a ON f.AssetNumber = a.AssetNumber
where f.SerialNum = @serialnum and a.FixedAssetId != f.FixedAssetId

--------------------------------------------------------------------------------------------------------------------------------------

SELECT
'exec usp_MergeFixedAssets ''' + CONVERT(VARCHAR(MAX), KeepId) + ''', ''' + CONVERT(VARCHAR(MAX), ScrapId) + ''''

FROM 
(
SELECT 
f.AssetNumber, f.FixedAssetId [ScrapId], 
ISNULL((select top 1 FixedAssetId from PFTWO p1 (NOLOCK) WHERE p1.assetNumber = a.assetnumber), 
	  (SELECT TOP 1 FixedAssetId FROM FixedAssets f1 (NOLOCK) WHERE f1.AssetNumber = a.AssetNumber order by f1.ParentNumber desc, 
		f1.DateAdded asc))
	  as [KeepId]
FROM Fixedassets f (NOLOCK)
JOIN (SELECT assetnumber
from FixedAssets (NOLOCK)
where AssetNumber is not null
group by AssetNumber
HAVING count(*) > 1
) A On f.AssetNumber = a.AssetNumber

) B
WHERE ScrapId != KeepId --and b.AssetNumber ='3031292'