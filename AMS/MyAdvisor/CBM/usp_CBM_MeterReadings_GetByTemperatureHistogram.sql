USE [AesOpsDevDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_CBM_MeterReadings_GetByTemperatureHistogram]    Script Date: 10/3/2023 11:55:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--=====================================================
--CREATED BY : Yogesh Mane
--CREATED ON : 27th Dec 2016
--DESCRIPTION: To get meter reading for asset using temprature historgram
--=======================================================
--TFS 77962: SACHIN MHALUNGEKAR - 29 June 2020 - ADDED selection on curvename insted ToolMnem
--=======================================================
ALTER PROCEDURE [dbo].[usp_CBM_MeterReadings_GetByTemperatureHistogram]
	@FixedAssetId UNIQUEIDENTIFIER,
	@LastReadingValue DECIMAL(18,2) OUTPUT,
	@TotalMeterReadingValue DECIMAL(18,2) OUTPUT
AS
BEGIN

	DECLARE @startDateTime DATETIME, @runId UNIQUEIDENTIFIER;
	SET @startDateTime = GETDATE();
	SET @runId = NEWID();

	EXEC usp_MyAdvisor_Logs @runId, 'usp_CBM_MeterReadings_GetByTemperatureHistogram', 'Get max priority from CBMHistogramCurve', @startDateTime;
	SET @startDateTime = GETDATE();

	--Use curve name for temp
	--Ignore priority table
	
	DECLARE @LastMaintenancePerformedDate DATETIME

	SELECT @LastMaintenancePerformedDate = MAX(p.DateAdded)
				FROM CBMCalculatedMeterReadings c (NOLOCK)
				JOIN PFTWO p (NOLOCK) ON p.PFTWOId = c.LastPFTWOId AND c.MeterReadingTypeId = 3
						AND p.Active = 0 AND p.ReasonForChange ='Closed - Passed'
				WHERE c.FixedAssetId = @FixedAssetId
				GROUP BY c.FixedAssetId

	SELECT @LastMaintenancePerformedDate = ISNULL(@LastMaintenancePerformedDate, getdate())

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
							DESC ) [RowIndex],
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
			JOIN Runs r ON r.RunID = c.RunId
			LEFT JOIN CBMHistogramRuns hr (NOLOCK) on hr.RunId = c.RunId
			LEFT JOIN CBMHistogramBins b (NOLOCK) on b.CBMHistogramRunId = hr.CBMHistogramRunId
			LEFT JOIN CBMHistograms h with(index([IX_CBMHistograms])) on h.CBMHistogramRunId = hr.CBMHistogramRunId
				and h.CBMHistogramId = b.CBMHistogramId
			LEFT JOIN CBMHistogramMonitorTools t (NOLOCK) ON t.CBMMonitorToolId = h.CBMMonitorToolId

			WHERE t.MonitorName = 'THERMAL'
			
				AND c.FixedAssetId = @FixedAssetId
			GROUP BY c.FixedAssetId, hr.JobNumber, hr.WellName, hr.RunId, r.OperHrs, r.StartDate, h.MetricName, h.CurveName, h.Recorded, t.ToolMnem 
	) a
	WHERE a.RowIndex < 3
	GROUP BY FixedAssetId, JobNumber, WellName,	RunId, OperHrs, StartDate


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

	DROP TABLE #TEMP

	EXEC usp_MyAdvisor_Logs @runId, 'usp_CBM_MeterReadings_GetByTemperatureHistogram', 'Get meter readings ByTemperatureHistogram', @startDateTime

END


