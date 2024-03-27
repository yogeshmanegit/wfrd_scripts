select 
c.FixedAssetId, c.CBMMonitorId, c.PFTWOId, --cr.LastPFTWOId, 
	CONVERT(varchar(10), [Last Seq Completion Date], 101) [Correct Meter Reading Date], 
	CONVERT(varchar(10), CONVERT(DateTime, LastMeterReadingValue, 101), 103) [Actual Date in DB],
	CASE WHEN CONVERT(Datetime, CONVERT(varchar(10), [Last Seq Completion Date], 103), 103) != CONVERT(Datetime, CONVERT(varchar(10), CONVERT(DateTime, LastMeterReadingValue, 101), 103), 103)
				OR cr.Id is null THEN 1 
		ELSE 0 END [Has Issue]

FROM (

	select * , ROW_NUMBER() OVER (Partition BY CBMMonitorId, FixedAssetId ORDER BY [Last Seq Completion Date] DESC) [RowIndex]
	from 
	(
		select a.*, max(ps.DateAdded) [Last Seq Completion Date]
		from 
		(
			select p.PFTWOId, cm.CBMMonitorId, p.FixedAssetId
			from PFTWO p
			join PFTConfig pc on p.PFTConfigId = pc.PFTConfigId and p.ReasonForChange = 'Closed - Passed'
			join CBMMonitor cm on cm.ObjectNumber = pc.ObjectNumber and cm.active = 1
			join CBMMonitorAssetItemNums childitem on childitem.CBMMonitorId = cm.CBMMonitorId 
				and childitem.ItemNum = p.ItemNum and childitem.IsParent = 0
			where cm.MeterReadingTypeId = 5 and PFTType = 3
		) a
		join PFTWOSeq ps on a.PFTWOId = ps.PFTWOId
		group by a.CBMMonitorId, a.FixedAssetId, a.PFTWOId
	) b
) c 
LEFT JOIN CBMCalculatedMeterReadings cr on c.CBMMonitorId = cr.CBMMonitorId 
	and c.FixedAssetId = cr.FixedAssetId and cr.MeterReadingTypeId = 5
	
where c.[RowIndex] = 1
--and (
--	CONVERT(Datetime, CONVERT(varchar(10), [Last Seq Completion Date], 103), 103) != CONVERT(Datetime, CONVERT(varchar(10), CONVERT(DateTime, LastMeterReadingValue, 101), 103), 103)
--	OR 
--	cr.Id is null   --- missing records
--	)
