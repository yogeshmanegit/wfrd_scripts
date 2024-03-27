use AesOps;

--Use curve name for temp
--Use same example provided
--Ignore priority table
--go with logic provided in example 
--Follow up next week for testing 

DECLARE @LastReadingValue DECIMAL(18,2),
@TotalMeterReadingValue DECIMAL(18,2)

DECLARE @FixedAssetId UNIQUEIDENTIFIER = '46454AC2-9C09-422A-BAF7-147962A4D9C0'
DECLARE @LastMaintenancePerformedDate DATETIME

SELECT @LastMaintenancePerformedDate = MAX(p.DateAdded)
			FROM CBMCalculatedMeterReadings c (NOLOCK)
			JOIN PFTWO p (NOLOCK) ON p.PFTWOId = c.LastPFTWOId AND c.MeterReadingTypeId = 3
					AND p.Active = 0 AND p.ReasonForChange ='Closed - Passed'
			WHERE c.FixedAssetId = @FixedAssetId
			GROUP BY c.FixedAssetId

select @LastMaintenancePerformedDate = ISNULL(@LastMaintenancePerformedDate, getdate())

SELECT 
	FixedAssetId,
	JobNumber,
	WellName,
	RunId,
	OperHrs,
	StartDate,
	CAST(SUM(CASE WHEN RowIndex = 1 THEN TempratureOprHrs ELSE 0 END) AS float) [FirstTempratureOprHrs],
	CAST(SUM(CASE WHEN RowIndex = 2 THEN TempratureOprHrs ELSE 0 END) AS float) [SecondTempratureOprHrs]
	INTO #TEMP
FROM (
	SELECT 
		ROW_NUMBER() OVER(PARTITION BY hr.JobNumber, hr.WellName, hr.RunId, c.FixedAssetId
			ORDER BY SUM(CASE WHEN b.[END] <= 135 THEN 1
								WHEN b.[END] <=	145	THEN 2
								WHEN b.[END] <=	155	THEN 4
								WHEN b.[END] <=	165	THEN 8
								WHEN b.[END] <=	175	THEN 16
								WHEN b.[END] <=	185	THEN 32
								WHEN b.[END] <=	195	THEN 64
								WHEN b.[END] >= 195 THEN 128
								ELSE 1 END * Value)
						) [RowIndex],
		c.FixedAssetId, hr.JobNumber, hr.WellName, hr.RunId, t.ToolMnem, h.CurveName,  h.Recorded, r.OperHrs, r.StartDate,
		SUM(CASE WHEN b.[END] <= 135 THEN 1
							WHEN b.[END] <=	145	THEN 2
							WHEN b.[END] <=	155	THEN 4
							WHEN b.[END] <=	165	THEN 8
							WHEN b.[END] <=	175	THEN 16
							WHEN b.[END] <=	185	THEN 32
							WHEN b.[END] <=	195	THEN 64
							WHEN b.[END] >= 195 THEN 128
							ELSE 1 END * Value)  [TempratureOprHrs]
		from CBMRunAssetMappings c (NOLOCK)
		JOIN CBMCalculatedMeterReadings m (NOLOCK) on c.FixedAssetId = m.FixedAssetId
		JOIN Runs r ON r.RunID = c.RunId
		LEFT JOIN CBMHistogramRuns hr (NOLOCK) on hr.RunId = c.RunId
		LEFT JOIN CBMHistogramBins b (NOLOCK) on b.CBMHistogramRunId = hr.CBMHistogramRunId
		LEFT JOIN CBMHistograms h with(index([IX_CBMHistograms])) on h.CBMHistogramRunId = hr.CBMHistogramRunId
		LEFT JOIN CBMHistogramMonitorTools t (NOLOCK) ON t.CBMMonitorToolId = h.CBMMonitorToolId

		WHERE m.MeterReadingTypeId = '3' AND t.MonitorName = 'THERMAL'
			--AND hr.JobNumber ='KC1909094'
			AND c.FixedAssetId = '46454AC2-9C09-422A-BAF7-147962A4D9C0'
		GROUP BY c.FixedAssetId, hr.JobNumber, hr.WellName, hr.RunId, r.OperHrs, r.StartDate, h.MetricName, h.CurveName, h.Recorded, t.ToolMnem 
) a
WHERE a.RowIndex < 3
GROUP BY FixedAssetId, JobNumber, WellName,	RunId, OperHrs, StartDate
ORDER BY 2,3,4

-- SELECT * FROM #TEMP 

SELECT @LastReadingValue = SUM(CASE WHEN StartDate < @LastMaintenancePerformedDate THEN TempOperHrs ELSE 0 END),
	@TotalMeterReadingValue = SUM(TempOperHrs)
FROM (
	SELECT FixedAssetId, JobNumber, WellName, RunId, StartDate,
			CASE
				--when don't have temp histogram for any run then take operating hrs from runs table
				WHEN FirstTempratureOprHrs IS NULL OR OperHrs > FirstTempratureOprHrs THEN OperHrs
				WHEN ISNULL(SecondTempratureOprHrs,0) = 0 THEN FirstTempratureOprHrs
				--if max temprature OperHrs is with in range of 20% second max temp OperHrs then take 1st otherwise take 2nd value
				WHEN (FirstTempratureOprHrs * 0.8) <= SecondTempratureOprHrs THEN FirstTempratureOprHrs
				ELSE SecondTempratureOprHrs
			END [TempOperHrs]
	FROM #TEMP
) A

SELECT @LastReadingValue, @TotalMeterReadingValue

DROP TABLE #TEMP