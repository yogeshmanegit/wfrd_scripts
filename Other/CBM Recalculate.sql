SELECT DISTINCT ' exec usp_CBM_MonitorCalculatedMeterReadings ' +''''+ JobNumber +'''', '; print ' +'''' + JobNumber + ''''
FROM CBMRunAssetMappings m
JOIN Runs r on m.RunId = r.RunID
JOIN Wells w on w.WellID = r.WellID
join Jobs j on j.JobId = w.JobID
WHERE JobNumber in (
SELECT distinct JobNumber 
FROM Jobs j
JOIN Wells w on j.jobid = w.jobid
join runs r on r.WellID = w.WellID
join CBMRunAssetMappings a on a.RunId = r.RunID
where a.FixedAssetId ='9A9FF88D-220F-41C6-97C5-A82601077B63')