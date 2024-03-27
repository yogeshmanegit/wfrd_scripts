DECLARE @MeterReadings TABLE (FixedAssetId uniqueidentifier, PFTWOId uniqueidentifier, CBMMonitorId int, GlobalTrigger int, LastMaintenanceDate datetime)

INSERT INTO @MeterReadings
SELECT FixedAssetId, PFTWOId, CBMMonitorId, GlobalTrigger, MaxDate
FROM 
(
	SELECT ROW_NUMBER() OVER(PARTITION BY FixedAssetId, CBMMonitorId ORDER BY FixedAssetId, CBMMonitorId, MaxDate DESC) [RowIndex], *
	from 
	(
		select a.*, max(s.dateadded) [MaxDate] 
		from (
			select childasset.FixedAssetId, p.PFTWOId, m.CBMMonitorId, m.GlobalTrigger, m.MeterReadingTypeId
			from CBMMonitor m 
			join CBMMonitorAssetItemNums parent on m.active = 1 and MeterReadingTypeId = 5 and m.CBMMonitorid = parent.CBMMonitorId and parent.IsParent = 1
			join CBMMonitorAssetItemNums child on m.CBMMonitorid = child.CBMMonitorId and child.IsParent = 0
			join FixedAssets childasset on child.ItemNum = childasset.InventoryItemNum
			join FixedAssets parentasset on parent.ItemNum = parentasset.InventoryItemNum and parentasset.FixedAssetId = ISNULL(childasset.TopLevelFixedAssetId,childasset.FixedAssetId)
			JOIN PFTConfig pc on m.ObjectNumber = pc.ObjectNumber
			Join PFTWO p on childasset.FixedAssetId = p.FixedAssetId and pc.PFTConfigId = p.PFTConfigId and p.PFTType = 3 and p.ReasonForChange ='Closed - Passed'
			WHERE childasset.FixedAssetId ='CF5BA92E-4F06-495F-929B-1256BED83230'
		) a
		JOIN PFTWOSeq s on a.PFTWOId = s.PFTWOId
		GROUP BY FixedAssetId, a.PFTWOId, CBMMonitorId, GlobalTrigger, MeterReadingTypeId
	) b
) c 
where c.RowIndex = 1

select *, DATEDIFF(dd, LastMaintenanceDate, getdate()) [LastMeterReading] from @MeterReadings
select * 
from @MeterReadings m
LEFT JOIN CBMCalculatedMeterReadings r on m.FixedAssetId = r.FixedAssetId and m.CBMMonitorId = r.CBMMonitorId


--select * from CBMCalculatedMeterReadings WHERE FixedAssetId ='CF5BA92E-4F06-495F-929B-1256BED83230'