DELETE FROM CBMMonitorAssetItemNums
WHERE CBMMonitorAssetItemNumId IN (
SELECT CBMMonitorAssetItemNumId FROM (
select ROW_NUMBER() OVER (PARTITION BY p.CBMMonitorId, p.ItemNum, p.IsParent ORDER BY p.CBMMonitorId, p.ItemNum, p.IsParent, createdon) [RowNum], 
CBMMonitorAssetItemNumId from CBMMonitorAssetItemNums p
JOIN (select CBMMonitorId, ItemNum, IsParent, count(*) [Count] from CBMMonitorAssetItemNums group by CBMMonitorId, ItemNum, IsParent
	having count(*) > 1) b on p.CBMMonitorId = b.CBMMonitorId and p.ItemNum = b.ItemNum and p.IsParent = b.IsParent
	) a where a.RowNum = 2
)