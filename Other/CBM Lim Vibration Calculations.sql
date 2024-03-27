
select b.CBMHistogramRunId, h.CBMHistogramId, b.CBMHistogramBinId, MetricName, [End], Value, ([End] * [End] * Value) / (CASE WHEN MetricName = 'Axial RMS' THEN 1600.0 ELSE 3200.0 END)
from CBMRunAssetMappings c 
join CBMCalculatedMeterReadings m on c.FixedAssetId = m.FixedAssetId
join CBMHistogramRuns hr on hr.RunId = c.RunId
join CBMHistogramBins b on b.CBMHistogramRunId = hr.CBMHistogramRunId
join CBMHistograms h on h.CBMHistogramRunId = hr.CBMHistogramRunId and h.CBMHistogramId = b.CBMHistogramId
join CBMHistogramMonitorTools t ON t.CBMMonitorToolId = h.CBMMonitorToolId
join FixedAssets f on f.FixedAssetId = m.FixedAssetId
where f.SerialNum = '136142940122' and m.MeterReadingTypeId = '7' and MetricName IN ('Lateral RMS', 'Axial RMS')
	AND t.MonitorName = 'SHOCK' AND Recorded = 1 and [End] >= 1 and [value] > 0 AND h.CBMHistogramRunId = '7675B2C8-72B7-4CBE-9FD9-EE071A601226'
ORDER BY CBMHistogramRunId, CBMHistogramId, MetricName, [end]



SELECT SUM(([End] * [End] * Value) / (CASE WHEN cbm_s.MetricName = 'Axial RMS' THEN 1600.0 ELSE 3200.0 END)) * 100
FROM CBMRunAssetMappings ra 
INNER JOIN Runs r ON r.RunId = ra.RunId
JOIN dbo.CBMHistogramRuns cbm_r (NOLOCK) ON cbm_r.RunId = r.RunID
join CBMHistogramBins cbm_b on cbm_b.CBMHistogramRunId = cbm_r.CBMHistogramRunId
join CBMHistograms cbm_h on cbm_h.CBMHistogramRunId = cbm_r.CBMHistogramRunId and cbm_h.CBMHistogramId = cbm_b.CBMHistogramId
join CBMHistogramMonitorTools cbm_t ON cbm_t.CBMMonitorToolId = cbm_h.CBMMonitorToolId
-- TFS# 50574
--Add toolMnem logic: TVM2+-1, if not found, TVM2-1, if not found, TVM-1
-- And recorded flag = 1

JOIN (SELECT ROW_NUMBER() OVER(PARTITION BY JobNumber, RunNumber, MonitorName, MetricName, Toolmnem 
			ORDER BY JobNumber, RunNumber, MonitorName, MetricName, Toolmnem, [ToolMnemPriority] ASC, Recorded DESC) [Selection],
			JobNumber, RunNumber, MonitorName, MetricName, Toolmnem, CBMHistogramId, CBMMonitorToolId
		FROM 
		(select DISTINCT h.CBMHistogramId, t.CBMMonitorToolId, hr.JobNumber, hr.RunNumber, t.MonitorName, h.MetricName, t.Toolmnem, 
		(CASE WHEN ToolMnem = 'TVM2+-1' THEN 1 WHEN ToolMnem = 'TVM2-1' THEN 2  ELSE 3 END) [ToolMnemPriority], Recorded
		from CBMRunAssetMappings c 
		join CBMCalculatedMeterReadings m on c.FixedAssetId = m.FixedAssetId
		join CBMHistogramRuns hr on hr.RunId = c.RunId
		join CBMHistogramBins b on b.CBMHistogramRunId = hr.CBMHistogramRunId
		join CBMHistograms h on h.CBMHistogramRunId = hr.CBMHistogramRunId
		join CBMHistogramMonitorTools t ON t.CBMMonitorToolId = h.CBMMonitorToolId
		where c.FixedAssetId = '6B67D873-DE4D-43DF-91C5-A82C00EC28DA' and m.MeterReadingTypeId = '7' and MetricName IN ('Axial RMS', 'Lateral RMS')
			AND t.MonitorName = 'SHOCK'
		) A
) cbm_s ON cbm_h.CBMHistogramId = cbm_s.CBMHistogramId and cbm_s.CBMMonitorToolId = cbm_t.CBMMonitorToolId 
	and cbm_s.Selection = 1
WHERE ra.FixedAssetId = '6B67D873-DE4D-43DF-91C5-A82C00EC28DA' and cbm_b.[End] >= 1 and [value] > 0 and cbm_h.CBMHistogramRunId = '7675B2C8-72B7-4CBE-9FD9-EE071A601226'


SELECT ROW_NUMBER() OVER(PARTITION BY JobNumber, RunNumber, MonitorName, MetricName, Toolmnem 
	ORDER BY JobNumber, RunNumber, MonitorName, MetricName, Toolmnem, [ToolMnemPriority] ASC, Recorded DESC) [Selection],
	JobNumber, RunNumber, MonitorName, MetricName, Toolmnem, Recorded, CBMHistogramId, CBMMonitorToolId
FROM 
(select DISTINCT h.CBMHistogramId, t.CBMMonitorToolId, hr.JobNumber, hr.RunNumber, t.MonitorName, h.MetricName, t.ToolMnem, 
(CASE WHEN ToolMnem = 'TVM2+-1' THEN 1 WHEN ToolMnem = 'TVM2-1' THEN 2  ELSE 3 END) [ToolMnemPriority], Recorded
from CBMRunAssetMappings c 
join CBMCalculatedMeterReadings m on c.FixedAssetId = m.FixedAssetId
join CBMHistogramRuns hr on hr.RunId = c.RunId
join CBMHistogramBins b on b.CBMHistogramRunId = hr.CBMHistogramRunId
join CBMHistograms h on h.CBMHistogramRunId = hr.CBMHistogramRunId
join CBMHistogramMonitorTools t ON t.CBMMonitorToolId = h.CBMMonitorToolId
where c.FixedAssetId = '6B67D873-DE4D-43DF-91C5-A82C00EC28DA' and m.MeterReadingTypeId = '7' and MetricName IN ('Axial RMS', 'Lateral RMS')
	AND t.MonitorName = 'SHOCK'
) A
