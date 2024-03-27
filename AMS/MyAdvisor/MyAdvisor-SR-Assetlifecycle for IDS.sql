SELECT  q2.*,q1.* from vwRMassetReport q1 

OUTER APPLY (

SELECT
    a.FixedAssetID,
    CAST(SUM(a.[LifetimeOperHrs]) AS DECIMAL(18,2)) AS [LifetimeOperHrs],
    CAST(SUM(a.[LifetimeCircHrs]) AS DECIMAL(18,2)) AS [LifetimeCircHrs],
    CAST(SUM(a.[LifetimeDrillingHrs]) AS DECIMAL(18,2)) AS [LifetimeDrillingHrs],
    CAST(SUM(a.[SinceLastRepairOperHrs]) AS DECIMAL(18,2)) AS [SinceLastRepairOperHrs],
    CAST(SUM(a.[SinceLastRepairCircHrs]) AS DECIMAL(18,2)) AS [SinceLastRepairCircHrs],
    CAST(SUM(a.[SinceLastRepairDrillHrs]) AS DECIMAL(18,2)) AS [SinceLastRepairDrillHrs],
    SUM(a.[CountOfRuns]) AS [CountOfRuns],
    SUM(a.[LifetimeTFFs]) AS [LifetimeTFFs],
    SUM(a.[LifeTimeNPTHrs]) AS [LifeTimeNPTHrs],
    SUM(a.[LifetimeFailures]) AS [LifetimeFailures],
    MAX(a.[BornOnDate]) AS [BornOnDate],
    SUM(a.[AcquisitionCost]) AS [AcquisitionCost],
    SUM(a.[NetBookValue]) AS [NetBookValue],
    SUM(a.[NoOfDaysInStatus]) AS [NoOfDaysInStatus],
    
    (
        SELECT ISNULL(MIN(DATEDIFF(dd, ISNULL(s.DateAdded, GETDATE()), GETDATE())),0) [DaysSinceLastPFTStep]  
            FROM AssetRepairTrack a
            JOIN PFTWO w ON ISNULL(a.SRPFTWOId, a.ITPFTWOId) = w.PFTWOId
            JOIN PFTWOSeq s ON s.PFTWOId = w.PFTWOId
        WHERE w.FixedAssetId = q1.FixedAssetId  
    ) [DaysSinceLastPFTStep]

  /*************************/
  /***Lifetime Asset Data***/
  /*************************/
  FROM 
  (SELECT
        tc1.FixedAssetID,
        SUM(r1.OperHrs) AS [LifetimeOperHRs],
        SUM(r1.circhrs) AS [LifetimeCircHrs],
        SUM(r1.drillhrs) AS [LifetimeDrillingHrs],
        COUNT(tc1.runid) AS [CountOfRuns],
        SUM(CONVERT(int, tc1.TFF)) AS [LifetimeTFFs],
        SUM(CONVERT(int, tc1.csi)) AS [LifetimeFailures],
        SUM(CONVERT(decimal(18,2), tc1.LostTime)) [LifeTimeNPTHrs],
        0 [NoOfDaysInStatus],
        0 [AcquisitionCost],
        0 [NetBookValue],
        '' [BornOnDate],
        0 [SinceLastRepairOperHrs],
        0 [SinceLastRepairCirchrs],
        0 [SinceLastRepairDrillHrs]
  FROM ToolStringComponentInfo tc1 (NOLOCK)
  INNER JOIN Runs r1 (NOLOCK) ON r1.runid = tc1.runid
  WHERE  q1.FixedAssetId  = tc1.FixedAssetID
  GROUP BY tc1.fixedassetid

  UNION ALL

  /*************************/
  /***Basic Asset Data******/
  /*************************/
  SELECT
    f2.fixedassetid,
    0 [LifetimeOperHrs],
    0 [LifetimeCircHrs],
    0 [LifetimeDrillingHrs],
    0 [CountOfRuns],
    0 [LifetimeTFFs],
    0 [LifetimeFailures],
    0 [LifeTimeNPTHrs],
    DATEDIFF(D, f2.LastStatusChangeDate, GETDATE()) AS [NoOfDaysInStatus],
    f2.cost AS [AcquisitionCost],
    f2.NetBookValue AS [NetBookValue],
    f2.DateAcquired AS [BornOnDate],
    0 [SinceLastRepairOperHrs],
    0 [SinceLastRepairCircHrs],
    0 [SinceLastRepairDrillHrs]
  FROM FixedAssets f2 (NOLOCK) 
  WHERE  q1.FixedAssetId  = f2.FixedAssetId

  UNION ALL

  SELECT
    tca.fixedassetid,
    0 [LifetimeOperHrs],
    0 [LifetimeCircHrs],
    0 [LifetimeDrillingHrs],
    0 [CountOfRuns],
    0 [LifetimeTFFs],
    0 [LifeTimeNPTHrs],
    0 [LifetimeFailures],
    0 [NoOfDaysInStatus],
    0 [AcquisitionCost],
    0 [NetBookValue],
    '' [BornOnDate],
    SUM(RA.OperHrs) AS [SinceLastRepairOperHrs],
    SUM(RA.circHrs) AS [SinceLastRepairCircHrs],
    SUM(RA.DrillHrs) AS [SinceLastRepairDrillHrs]
  FROM Runs ra (NOLOCK) 
  INNER JOIN ToolStringComponentInfo tca (NOLOCK) ON tca.RunID = ra.RunId
  INNER JOIN ( ---Get latest S&R PFT for "Last Repair Date"
          SELECT
            MAX(pwa.dateadded) AS "Dateadded",
            art.FixedAssetId
          FROM AssetRepairTrack art
          INNER JOIN PFTWO pwa (NOLOCK) ON pwa.PFTWOId = art.SRPFTWOId
          WHERE art.FixedAssetId =  q1.FixedAssetId 
            AND pwa.DateAdded < (SELECT MAX(DateAdded) FROM AssetRepairTrack WHere FixedAssetId =  q1.FixedAssetId )
         GROUP BY art.FixedAssetId

  ) B ON b.fixedassetid = tca.fixedassetid AND ra.EndDate > b.Dateadded  
  WHERE  q1.FixedAssetId  = tca.FixedAssetID
  GROUP BY tca.fixedassetid) a
  GROUP BY a.fixedassetid
) q2  where q1.ProductLineId=1 and q1.toolcode in ('ids','IDS (150C)','IDS (200C)')

