
--query to add schedule
INSERT INTO CBMCalculatedMeterReadings(FixedAssetId, MeterReadingTypeId, LastMeterReadingValue, UpdatedOn, CBMMonitorId)
select f.FixedAssetId, monitor.MeterReadingTypeId, 
	CASE WHEN monitor.MeterReadingTypeId = 5 THEN w.[MaintenanceDate] ELSE NULL END [LastMeterReadingValue], 
	'2023-03-12' [UpdatedOn], 
	monitor.CBMMonitorId
from (
		select jdeassetnumber, 
			   max([last maintenance date]) [MaintenanceDate] 
		from aesimport.dbo.Wireline_LastScheduleMaintenancePerformed
		GROUP BY jdeassetnumber
	 ) w
join fixedassets f on w.jdeassetnumber = f.AssetNumber
join CBMMonitorAssetItemNums childpart on f.InventoryItemNum = childpart.ItemNum and childpart.IsParent = 0
join CBMMonitorAssetItemNums parentpart on parentpart.CBMMonitorId = childpart.CBMMonitorId 
	and f.InventoryItemNum = parentpart.ItemNum and parentpart.IsParent = 1
join CBMMonitor monitor on childpart.CBMMonitorId = monitor.CBMMonitorId 
		and MeterReadingTypeId IN (5, 1)
LEFT JOIN CBMCalculatedMeterReadings c on c.FixedAssetId = f.FixedAssetId and c.MeterReadingTypeId = monitor.MeterReadingTypeId
where c.Id is null

select * from CBMCalculatedMeterReadings where UpdatedOn ='2023-03-12'


select DISTINCT f.FixedAssetId, duration.AssetNumber, duration.DurationInMinutes, duration.DateUploaded
INTO #tempDurations
FROM aesimport.dbo.OneView_Job_JobOperations_assets_w_duration_for_MyAdvisor duration
join FixedAssets f on duration.AssetNumber = f.AssetNumber
where duration.JobStatusId IN (1, 5, 10, 13) and duration.AssetNumber > 0 and DateUploaded is not null


select c.CBMMonitorId, c.FixedAssetId, 
	SUM(CASE WHEN CONVERT(datetime, maintenance.MaintenanceDate) < durations.DateUploaded THEN durations.DurationInMinutes ELSE 0 END) * 1.0 /60 [DurationInHour], 
	SUM(durations.DurationInMinutes) * 1.0 /60 [LifeTimeDurationInHour]
INTO #tempReading
FROM CBMCalculatedMeterReadings c
join FixedAssets f on c.FixedAssetId = f.FixedAssetId and c.MeterReadingTypeId = 1
JOIN (select jdeassetnumber, max([last maintenance date]) [MaintenanceDate] 
		from aesimport.dbo.Wireline_LastScheduleMaintenancePerformed
		GROUP BY jdeassetnumber
	) maintenance on maintenance.jdeassetnumber = f.AssetNumber
JOIN (SELECT * FROM #tempDurations) durations on c.FixedAssetId = durations.FixedAssetId 
			and c.MeterReadingTypeId = 1 
WHERE c.UpdatedOn = '2023-03-12' AND MeterReadingTypeId = 1
GROUP BY c.CBMMonitorId, c.FixedAssetId

UPDATE c
SET LastMeterReadingValue = r.DurationInHour,
	LifeTimeValue = r.LifeTimeDurationInHour
FROM CBMCalculatedMeterReadings c
JOIN #tempReading r on c.CBMMonitorId = r.CBMMonitorId and c.FixedAssetId = r.FixedAssetId


DROP TABLE #tempDurations
DROP TABLE #tempReading
