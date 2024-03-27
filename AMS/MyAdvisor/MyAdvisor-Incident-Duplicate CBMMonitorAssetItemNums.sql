
DELETE FROM CBMMonitorAssetItemNums WHERE CBMMonitorAssetItemNumId IN (
SELECT MAX(b.CBMMonitorAssetItemNumId) from (select CBMMonitorid, ItemNum, IsParent from CBMMonitorAssetItemNums group by CBMMonitorid, ItemNum, IsParent having count(*) > 1) a
join CBMMonitorAssetItemNums b on a.CBMMonitorId = b.CBMMonitorId and a.ItemNum = b.ItemNum and a.IsParent = b.IsParent
group by b.CBMMonitorId, b.ItemNum, b.IsParent)