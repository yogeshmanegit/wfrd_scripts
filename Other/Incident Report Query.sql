
SELECT ARTNumber, IncidentID, 'Update AssetRepairTrack SET IncidentId ='''+ CONVERT(VARCHAR(MAX), IncidentID) +''' WHERE ARTNumber =''' + ARTNumber +'''',
'UPDATE t SET t.CompFailureCodeID = a.FailureCodeId, t.ProceduralCodeID = a.ProceduralCodeId, t.OutOfSpecCodeID = a.OutOfSpecCodeId
 FROM ToolStringComponentInfo t  join Incidents i on i.RunID = t.RunID JOIN AssetRepairTrack a ON a.IncidentId = i.IncidentID  AND t.FixedAssetID = a.FixedAssetId WHERE a.Artnumber = ''' + ARTNumber +''''
FROM 
(SELECT ROW_NUMBER() OVER(PARTITION BY a.ARTNumber ORDER BY a.ARTNumber asc, r.RunNumber asc) [Index], a.ARTNumber, i.IncidentID, r.RunNumber
FROM Incidents i
JOIN ToolStringComponentInfo t ON t.runid = i.RunID
JOIN runs r ON r.runid = i.RunID
JOIN Wells w ON r.Wellid = w.WellID
JOIN Jobs J ON J.jobid = w.jobid
JOIN AssetRepairTrack a ON a.JobId = j.JobId AND a.FixedAssetId = t.FixedAssetID
Where a.AssetRepairTrackId IN (SELECT AssetRepairTrackId FROM ARTDispositions WHERE  DateAdded >='11/11/2016')
 and a.IsRedTag  = 1 and a.IncidentId is null and a.JobId is not null
) A
WHERE [Index] = 1