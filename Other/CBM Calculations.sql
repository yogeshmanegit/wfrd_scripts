DECLARE @FixedAssetId UNIQUEIDENTIFIER =  '9A9FF88D-220F-41C6-97C5-A82601077B63'

SELECT j.JobNumber, w.Well, r.RunNumber, [End], [Value], cbm_s.MetricName, 
	(CASE WHEN cbm_s.MetricName = 'Axial RMS' AND [END] > 0.5 THEN [End] * [End] * [Value] / 1600 
		 WHEN cbm_s.MetricName = 'Lateral RMS' AND [END] > 1 THEN [End] * [End] * [Value] / 3200 
		 WHEN cbm_s.MetricName = 'Torsional RMS' AND [END] > 1 THEN [End] * [End] * [Value] / 1600 
	ELSE 0 END) * 100,
    ((([End] * [End] * (CASE WHEN cbm_s.MetricName = 'Axial RMS' AND [End] > 0.5 THEN Value
							 WHEN cbm_s.MetricName = 'Lateral RMS' AND [End] > 1 THEN Value
							 WHEN cbm_s.MetricName = 'Torsional RMS' AND [End] > 1 THEN Value ELSE 0 END))
		 / CASE WHEN cbm_s.MetricName = 'Lateral RMS' THEN 3200.0 ELSE 1600 END)) * 100 [Total]
	FROM CBMRunAssetMappings ra (NOLOCK)
	INNER JOIN Runs r (NOLOCK) ON r.RunId = ra.RunId
	JOIN Wells w ON w.WellId = r.WellId
	JOIN Jobs j ON j.JobId = w.JobId
	JOIN dbo.CBMHistogramRuns cbm_r (NOLOCK) ON cbm_r.RunId = r.RunID
	join CBMHistogramBins cbm_b (NOLOCK) on cbm_b.CBMHistogramRunId = cbm_r.CBMHistogramRunId
	join CBMHistograms cbm_h (NOLOCK) on cbm_h.CBMHistogramRunId = cbm_r.CBMHistogramRunId and cbm_h.CBMHistogramId = cbm_b.CBMHistogramId
	join CBMHistogramMonitorTools cbm_t (NOLOCK) ON cbm_t.CBMMonitorToolId = cbm_h.CBMMonitorToolId
	-- TFS# 50574
	--Add toolMnem logic: TVM2+-1, if not found, TVM2-1, if not found, TVM-1
	-- And recorded flag = 1

	JOIN (SELECT ROW_NUMBER() OVER(PARTITION BY JobNumber, RunNumber, MonitorName, MetricName, Toolmnem 
				ORDER BY JobNumber, RunNumber, MonitorName, MetricName, Toolmnem, [ToolMnemPriority] ASC, Recorded DESC) [Selection],
				JobNumber, RunNumber, MonitorName, MetricName, Toolmnem, CBMHistogramId, CBMMonitorToolId
			FROM 
			(select DISTINCT h.CBMHistogramId, t.CBMMonitorToolId, hr.JobNumber, hr.RunNumber, t.MonitorName, h.MetricName, t.Toolmnem, 
			(CASE WHEN ToolMnem = 'TVM2-2' THEN 1 WHEN ToolMnem = 'TVM2+-1' THEN 2 WHEN ToolMnem = 'TVM2-1' THEN 3  ELSE 4 END) [ToolMnemPriority], Recorded
			from CBMRunAssetMappings c (NOLOCK) 
			join CBMCalculatedMeterReadings m (NOLOCK) on c.FixedAssetId = m.FixedAssetId
			join CBMHistogramRuns hr (NOLOCK) on hr.RunId = c.RunId
			join CBMHistogramBins b (NOLOCK) on b.CBMHistogramRunId = hr.CBMHistogramRunId
			join CBMHistograms h (NOLOCK) on h.CBMHistogramRunId = hr.CBMHistogramRunId
			join CBMHistogramMonitorTools t (NOLOCK) ON t.CBMMonitorToolId = h.CBMMonitorToolId
			where c.FixedAssetId = @FixedAssetId and m.MeterReadingTypeId = '7' and MetricName IN ('Axial RMS', 'Lateral RMS', 'Torsional RMS')
				AND t.MonitorName = 'SHOCK'
			) A
	) cbm_s ON cbm_h.CBMHistogramId = cbm_s.CBMHistogramId and cbm_s.CBMMonitorToolId = cbm_t.CBMMonitorToolId 
		and cbm_s.Selection = 1

	WHERE ra.FixedAssetId = @FixedAssetId and cbm_b.[End] >= 1 and [value] > 0 --and cbm_h.CBMHistogramRunId = '7675B2C8-72B7-4CBE-9FD9-EE071A601226'

ORDER BY j.JobNumber, w.Well, r.RunNumber, cbm_s.MetricName,[End], [Value]

SELECT j.JobNumber, w.Well, r.RunNumber, 
	SUM(CASE WHEN cbm_s.MetricName = 'Lateral RMS' THEN ([End] * [End] * CASE WHEN [END] > 1 THEN Value ELSE 0 END) / 3200.0 ELSE 0 END) * 100 [Lateral], 
	SUM(CASE WHEN cbm_s.MetricName = 'Axial RMS' THEN ([End] * [End] * CASE WHEN [END] > 0.5 THEN Value ELSE 0 END) / 1600.0 ELSE 0 END) * 100 [Axial],
	SUM(CASE WHEN cbm_s.MetricName = 'Torsional RMS' THEN ([End] * [End] * CASE WHEN [END] > 1 THEN Value ELSE 0 END) / 1600.0 ELSE 0 END) * 100 [Torsional],
	SUM((CASE WHEN cbm_s.MetricName = 'Axial RMS' AND [END] > 0.5 THEN [End] * [End] * [Value] / 1600 
		 WHEN cbm_s.MetricName = 'Lateral RMS' AND [END] > 1 THEN [End] * [End] * [Value] / 3200 
		 WHEN cbm_s.MetricName = 'Torsional RMS' AND [END] > 1 THEN [End] * [End] * [Value] / 1600 
	ELSE 0 END)) * 100 [Total]
	FROM CBMRunAssetMappings ra (NOLOCK)
	INNER JOIN Runs r (NOLOCK) ON r.RunId = ra.RunId
	JOIN Wells w ON w.WellId = r.WellId
	JOIN Jobs j ON j.JobId = w.JobId
	JOIN dbo.CBMHistogramRuns cbm_r (NOLOCK) ON cbm_r.RunId = r.RunID
	join CBMHistogramBins cbm_b (NOLOCK) on cbm_b.CBMHistogramRunId = cbm_r.CBMHistogramRunId
	join CBMHistograms cbm_h (NOLOCK) on cbm_h.CBMHistogramRunId = cbm_r.CBMHistogramRunId and cbm_h.CBMHistogramId = cbm_b.CBMHistogramId
	join CBMHistogramMonitorTools cbm_t (NOLOCK) ON cbm_t.CBMMonitorToolId = cbm_h.CBMMonitorToolId
	-- TFS# 50574
	--Add toolMnem logic: TVM2+-1, if not found, TVM2-1, if not found, TVM-1
	-- And recorded flag = 1

	JOIN (SELECT ROW_NUMBER() OVER(PARTITION BY JobNumber, RunNumber, MonitorName, MetricName, Toolmnem 
				ORDER BY JobNumber, RunNumber, MonitorName, MetricName, Toolmnem, [ToolMnemPriority] ASC, Recorded DESC) [Selection],
				JobNumber, RunNumber, MonitorName, MetricName, Toolmnem, CBMHistogramId, CBMMonitorToolId
			FROM 
			(select DISTINCT h.CBMHistogramId, t.CBMMonitorToolId, hr.JobNumber, hr.RunNumber, t.MonitorName, h.MetricName, t.Toolmnem, 
			(CASE WHEN ToolMnem = 'TVM2-2' THEN 1 WHEN ToolMnem = 'TVM2+-1' THEN 2 WHEN ToolMnem = 'TVM2-1' THEN 3  ELSE 4 END) [ToolMnemPriority], Recorded
			from CBMRunAssetMappings c (NOLOCK) 
			join CBMCalculatedMeterReadings m (NOLOCK) on c.FixedAssetId = m.FixedAssetId
			join CBMHistogramRuns hr (NOLOCK) on hr.RunId = c.RunId
			join CBMHistogramBins b (NOLOCK) on b.CBMHistogramRunId = hr.CBMHistogramRunId
			join CBMHistograms h (NOLOCK) on h.CBMHistogramRunId = hr.CBMHistogramRunId
			join CBMHistogramMonitorTools t (NOLOCK) ON t.CBMMonitorToolId = h.CBMMonitorToolId
			where c.FixedAssetId = @FixedAssetId and m.MeterReadingTypeId = '7' and MetricName IN ('Axial RMS', 'Lateral RMS', 'Torsional RMS')
				AND t.MonitorName = 'SHOCK'
			) A
	) cbm_s ON cbm_h.CBMHistogramId = cbm_s.CBMHistogramId and cbm_s.CBMMonitorToolId = cbm_t.CBMMonitorToolId 
		and cbm_s.Selection = 1

	LEFT JOIN (SELECT MAX(p.DateAdded) [LastPFTDate], c.FixedAssetId
					FROM CBMCalculatedMeterReadings c(NOLOCK) 
					JOIN PFTWO p (NOLOCK) ON p.PFTWOId = c.LastPFTWOId AND c.MeterReadingTypeId = 7
					WHERE c.FixedAssetId = @FixedAssetId
					GROUP BY c.FixedAssetId
				) b ON b.FixedAssetId = ra.FixedAssetId
	WHERE ra.FixedAssetId = @FixedAssetId and cbm_b.[End] >= 1 and [value] > 0 --and cbm_h.CBMHistogramRunId = '7675B2C8-72B7-4CBE-9FD9-EE071A601226'
GROUP BY j.JobNumber, w.Well, r.RunNumber