DECLARE @HistogramXMLData XML

SELECT @HistogramXMLData = BaseXML FROM CoreFiles WHERE CoreId ='E1B8A9C9-E595-4B90-B5F7-3635BABC7C1B'
Order by CreatedOn DESC

exec [usp_Core_ImportHistogram] @HistogramXMLData

SELECT * FROM CBMHistogramRuns 
SELECT * FROM CBMHistogramRunTools 
SELECT * FROM CBMHistogramMonitorTool 
SELECT * FROM dbo.CBMHistogram 
SELECT * FROM dbo.CBMHistogramBin 

SELECT * 
FROM [dbo].[CBMHistogramRuns] r
JOIN [dbo].[CBMHistogramMonitorTool] t ON t.[CBMHistogramRunId] = r.[CBMHistogramRunId]
JOIN [dbo].[CBMHistogram] h ON h.CBMMonitorToolId = t.CBMMonitorToolId 
WHERE t.MonitorName ='THERMAL'