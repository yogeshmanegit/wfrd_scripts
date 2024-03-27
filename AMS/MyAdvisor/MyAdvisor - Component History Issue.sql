
	   DECLARE @FixedAssetId UNIQUEIDENTIFIER = '6DFD5DF8-C1C6-4EF6-B024-96709B22AE86'
		
	   select * from FixedAssets where SerialNum ='15146876-01-05'

	  --get the initial fa results based upon filters.
      CREATE TABLE #tblFixedAssets (
        FixedAssetId uniqueidentifier,
        SerialNum varchar(30),
        InventoryItemNum varchar(30),
        RNItemNum varchar(30),
        TopFixedAssetId uniqueidentifier
      )

      INSERT INTO #tblFixedAssets
        SELECT
          FixedAssetId,
          SerialNum,
          InventoryItemNum,
          RNItemNum,
          TopLevelFixedAssetId
        FROM FixedAssets(NOLOCK)
        WHERE ParentFixedAssetId = @FixedAssetId

	  --select * from #tblFixedAssets where FixedAssetId = 'E86DEE76-D9F4-4E02-AC49-ABD3006FDC19'

      CREATE TABLE #tblFixedAssetHistory (
        FixedAssetId uniqueidentifier,
        SerialNum varchar(30),
        InventoryItemNum varchar(30),
        RNItemNum varchar(30),
        Revision varchar(2),
        Qty int NULL,
        TopFixedAssetId uniqueidentifier,
        TopSerialNum varchar(30),
        TopInventoryItemNum varchar(30),
        WorkOrderIdInstalled uniqueidentifier NULL,
        WorkOrderIdRemoved uniqueidentifier NULL
      )

		INSERT INTO #tblFixedAssetHistory
		SELECT
			fah.FixedAssetId,
			fah.SerialNum,
			fah.InventoryItemNum,
			fah.RNItemNum,
			fah.Revision,
			fah.Qty,
			wo.FixedAssetId AS TopFixedAssetId,
			wo.SerialNum AS TopSerialNum,
			wo.InventoryItemNum AS TopInventoryItemNum,
			(SELECT TOP 1 ptd.RefId
				FROM PartTransferDtl(NOLOCK) ptd
				LEFT JOIN PartTransfers(NOLOCK) pt ON pt.PartTransferId = ptd.PartTransferId
				LEFT JOIN (SELECT TOP 1 wo.WorkOrderId, fah.FixedAssetId, wo.DateAdded
							FROM FixedAssetHistory(NOLOCK) fah2
							INNER JOIN WorkOrders(NOLOCK) wo2 ON wo2.WorkOrderId = fah2.WorkOrderId
							WHERE fah2.FixedAssetId = fah.FixedAssetId AND wo.FixedAssetId = wo2.FixedAssetId AND fah2.DatedAdded <= fah.DatedAdded
							ORDER BY fah2.DatedAdded ASC) firstEntry ON ptd.FixedAssetId = firstEntry.FixedAssetId
			WHERE ptd.DateAdded < firstEntry.DateAdded AND ptd.RefType = 'WO' AND pt.TransferType = 9 AND ptd.Dest = 'IN'
			ORDER BY ptd.DateAdded DESC) AS WorkOrderIdInstalled,
			(SELECT TOP 1 ptd.RefId 
				FROM PartTransferDtl(NOLOCK) ptd
				LEFT JOIN PartTransfers(NOLOCK) pt ON pt.PartTransferId = ptd.PartTransferId
				LEFT JOIN (SELECT TOP 1 wo.WorkOrderId, fah.FixedAssetId, wo.DateAdded
					FROM FixedAssetHistory(NOLOCK) fah2
					INNER JOIN WorkOrders(NOLOCK) wo2 ON wo2.WorkOrderId = fah2.WorkOrderId 
					WHERE fah2.FixedAssetId = fah.FixedAssetId AND wo.FixedAssetId = wo2.FixedAssetId AND fah2.DatedAdded >= fah.DatedAdded
					ORDER BY fah2.DatedAdded DESC) lastEntry ON ptd.FixedAssetId = lastEntry.FixedAssetId
			WHERE ptd.DateAdded > lastEntry.DateAdded AND ptd.RefType = 'WO' AND pt.TransferType = 9 AND ptd.Source = 'IN'
			ORDER BY ptd.DateAdded ASC) AS WorkOrderIdRemoved
		FROM FixedAssetHistory(NOLOCK) fah
		INNER JOIN #tblFixedAssets(NOLOCK) falocal ON falocal.FixedAssetId = fah.FixedAssetId
		INNER JOIN WorkOrders(NOLOCK) wo ON wo.WorkOrderId = fah.WorkOrderId

	

      INSERT INTO #tblFixedAssetHistory
        SELECT
          ptd.FixedAssetId,
          ptd.SerialNum,
          ptd.InventoryItemNum,
          ptd.RNItemNum,
          ptd.Revision,
          ptd.Quantity AS Qty,
          wo.FixedAssetId AS TopFixedAssetId,
          wo.SerialNum AS TopSerialNum,
          wo.InventoryItemNum AS TopInventoryItemNum,
          ptd.RefId AS WorkOrderIdInstalled,
          (SELECT TOP 1
            RefId
			FROM PartTransferDtl(NOLOCK) ptd2
			LEFT JOIN PartTransfers(NOLOCK) pt2 ON pt2.PartTransferId = ptd2.PartTransferId
          WHERE ptd2.RefType = 'WO' AND pt2.TransferType = 9 AND ptd2.Source = 'IN' AND ptd2.FixedAssetId = ptd.FixedAssetId 
			AND ptd2.DateAdded > ptd.DateAdded
          ORDER BY ptd.DateAdded ASC)
          AS WorkOrderIdRemoved
        FROM PartTransferDtl(NOLOCK) ptd
        LEFT JOIN PartTransfers(NOLOCK) pt ON pt.PartTransferId = ptd.PartTransferId
        INNER JOIN #tblFixedAssets(NOLOCK) falocal ON falocal.FixedAssetId = ptd.FixedAssetId
        INNER JOIN WorkOrders(NOLOCK) wo ON wo.WorkOrderId = ptd.RefId
        WHERE ptd.RefType = 'WO' AND pt.TransferType = 9 AND ptd.Dest = 'IN'

      INSERT INTO #tblFixedAssetHistory

        SELECT
          fa.FixedAssetId,
          fa.SerialNum,
          fa.InventoryItemNum,
          fa.RNItemNum,
          fa.Revision,
          fa.CurrentItemQty AS Qty,
          fap.FixedAssetId AS TopFixedAssetId,
          fap.SerialNum AS TopSerialNum,
          fap.InventoryItemNum AS TopInventoryItemNum,
          NULL AS WorkOrderIdInstalled,
          NULL AS WorkOrderIdRemoved
        FROM FixedAssets(NOLOCK) fa
        INNER JOIN #tblFixedAssets falocal ON falocal.FixedAssetId = fa.FixedAssetId 
		INNER JOIN FixedAssets(NOLOCK) fap ON fap.FixedAssetId = fa.TopLevelFixedAssetId
        LEFT JOIN #tblFixedAssetHistory fah ON fah.FixedAssetId = fa.FixedAssetId AND fah.TopFixedAssetId = fa.TopLevelFixedAssetId
        WHERE fa.EquipmentStatus = 'IN' AND fah.FixedAssetId IS NULL

	  --select * from #tblFixedAssetHistory where FixedAssetId = 'E86DEE76-D9F4-4E02-AC49-ABD3006FDC19'
	  
      --get parents.

      CREATE TABLE #tblFixedAssetParents (
        FixedAssetId uniqueidentifier,
        SerialNum varchar(30),
        InventoryItemNum varchar(30),
        RNItemNum varchar(30),
        Revision varchar(2),
        Qty int NULL,
        TopFixedAssetId uniqueidentifier,
        TopSerialNum varchar(30),
        TopInventoryItemNum varchar(30),
        WorkOrderIdInstalled uniqueidentifier NULL,
        WorkOrderNumInstalled varchar(30),
        JDEWorkOrderNumInstalled varchar(30),
        WorkOrderBranchPlantInstalled varchar(12),
        WorkOrderBranchPlantNameInstalled varchar(50),
        DateInstalled datetime NULL,
        WorkOrderIdRemoved uniqueidentifier NULL,
        WorkOrderNumRemoved varchar(30),
        JDEWorkOrderNumRemoved varchar(30),
        WorkOrderBranchPlantRemoved varchar(12),
        WorkOrderBranchPlantNameRemoved varchar(50),
        DateRemoved datetime NULL
      )

      INSERT INTO #tblFixedAssetParents

        SELECT DISTINCT
          fah.FixedAssetId,
          fah.SerialNum,
          fah.InventoryItemNum,
          fah.RNItemNum,
          fah.Revision,
          fah.Qty,
          fah.TopFixedAssetId,
          fah.TopSerialNum,
          fah.TopInventoryItemNum,
          fah.WorkOrderIdInstalled,
          woi.WorkOrderNum AS WorkOrderNumInstalled,
          woi.JDEWorkOrderNum AS JDEWorkOrderNumInstalled,
          woi.BranchPlant AS WorkOrderBranchPlantInstalled,
          woibp.CompanyName AS WorkOrderBranchPlantNameInstalled,
          ISNULL(woi.DateAdded, CONVERT(datetime, '08/12/2014')) AS DateInstalled,
          fah.WorkOrderIdRemoved,
          wor.WorkOrderNum AS WorkOrderNumRemoved,
          wor.JDEWorkOrderNum AS JDEWorkOrderNumRemoved,
          wor.BranchPlant AS WorkOrderBranchPlantRemoved,
          worbp.CompanyName AS WorkOrderBranchPlantNameRemoved,
          wor.DateAdded AS DateRemoved
        FROM #tblFixedAssetHistory fah
        LEFT JOIN WorkOrders(NOLOCK) woi ON woi.WorkOrderId = fah.WorkOrderIdInstalled
		LEFT JOIN BranchPlants(NOLOCK) woibp ON woibp.BranchPlant = woi.BranchPlant
		LEFT JOIN WorkOrders(NOLOCK) wor ON wor.WorkOrderId = fah.WorkOrderIdRemoved
		LEFT JOIN BranchPlants(NOLOCK) worbp ON worbp.BranchPlant = wor.BranchPlant
	  
	  select * from #tblFixedAssetParents where FixedAssetId ='E86DEE76-D9F4-4E02-AC49-ABD3006FDC19'

      SELECT
        fa.FixedAssetId,
        fa.SerialNum,
        fa.InventoryItemNum,
    fa.RNItemNum,
        fa.Revision,
        fa.Qty,
        fa.TopFixedAssetId,
        fa.TopSerialNum,
        fa.TopInventoryItemNum,
        fa.WorkOrderIdInstalled,
        fa.WorkOrderNumInstalled,
        fa.JDEWorkOrderNumInstalled,
        fa.WorkOrderBranchPlantInstalled,
        fa.WorkOrderBranchPlantNameInstalled,
        fa.DateInstalled,
        fa.WorkOrderIdRemoved,
        fa.WorkOrderNumRemoved,
        fa.JDEWorkOrderNumRemoved,
        fa.WorkOrderBranchPlantRemoved,
        fa.WorkOrderBranchPlantNameRemoved,
        fa.DateRemoved,
        ts.SerialNumber AS ToolString,
        j.JobId,
        j.JobNumber,
        well.Well,
        j.BranchPlant AS JobBranchPlant,
        b.CompanyName AS JobBranchPlantName,
        reg.Region,
        reg.RegionDesc,
        co.Country,
        co.CountryDesc,
        dbo.DensityConvert(md.DensityEnd, md.DensityUnits, 'ppg') AS MudWeight,
        dbo.VolumeConvert(h.FlowRate, h.FlowRateUOM, 'gpm') AS FlowRate,
        run.RunID,
        run.RunNumber,
        run.StartDate,
        run.EndDate,
        run.OperHrs,
        run.CircHrs,
        run.DrillHrs,
        run.PulseCount,
        dbo.TempConvert(md.BoreHoleTempMax, md.BoreHoleTempUnits, '°F') AS MaxTempF,
        dbo.LengthConvert(h.HoleSize, h.HoleSizeUOM, 'in') AS HoleSize,
        ISNULL(comp.LostTime, i.AcceptedLostTime) AS NPTonTopLevelSN,
        i.AcceptedLostTime AS NPTbyRun,
        ISNULL(comp.TFF, 0) AS TFF,
        comp.SerialNum TopLevelSN,
        ifc.LevelOneCode + ifc.LevelTwoCode + ifc.LevelThreeCode AS FaultCodeTFF 
		INTO #tblRunInfo
		FROM #tblFixedAssetParents fa
		INNER JOIN ToolStringComponentInfo(NOLOCK) tsci ON tsci.SerialNum = fa.TopSerialNum AND tsci.InventoryItemNum = fa.TopInventoryItemNum
		LEFT JOIN ToolStrings(NOLOCK) ts ON ts.ToolStringId = tsci.ToolStringID 
		LEFT JOIN Runs(NOLOCK) run ON run.RunID = tsci.RunID  AND run.IsDownHole = 1  AND run.IsDeleted = 0 
			AND CONVERT(date, fa.DateInstalled, 101) <= CONVERT(date, run.StartDate, 101)
			AND (fa.DateRemoved IS NULL OR run.EndDate IS NULL OR CONVERT(date, fa.DateRemoved, 101) >= CONVERT(date, run.EndDate, 101))
		LEFT JOIN Wells(NOLOCK) well ON well.WellID = run.WellID AND well.IsDeleted = 0
		LEFT JOIN Jobs(NOLOCK) j ON j.JobId = well.JobID AND j.IsDeleted = 0
		LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = j.BranchPlant
		LEFT JOIN Regions reg WITH (NOLOCK) ON reg.Region = j.Region
		LEFT JOIN Countries co WITH (NOLOCK) ON co.Country = j.Country
		LEFT JOIN MudData md WITH (NOLOCK) ON md.RunID = run.RunID
		LEFT JOIN Hydraulics h WITH (NOLOCK) ON h.RunID = run.RunID
		LEFT JOIN Incidents i WITH (NOLOCK) ON i.RunID = run.RunID
		LEFT JOIN vwIncidentFaultCodes ifc WITH (NOLOCK) ON ifc.IncidentId = I.IncidentID
		LEFT JOIN 
		(
				SELECT  tsci.IncidentID, tsci.TFF, tsci.SerialNum, tsci.LostTime
				FROM ToolStringComponentInfo tsci WITH (NOLOCK)
				LEFT JOIN ToolStrings t WITH (NOLOCK) ON t.ToolStringID = tsci.ToolStringID
				LEFT JOIN PartTypes pt WITH (NOLOCK)  ON pt.PartTypeID = tsci.PartTypeID
				WHERE tsci.TFF = 1
		) AS comp ON comp.IncidentID = i.IncidentID
      WHERE run.RunID IS NOT NULL

	  --select * from #tblRunInfo where FixedAssetId ='E86DEE76-D9F4-4E02-AC49-ABD3006FDC19'

	  select CONVERT(date, fa.DateInstalled, 101) [DateInstalled], CONVERT(date, fa.DateRemoved, 101) [DateRemoved],
	  run.RunNumber, CONVERT(date, run.StartDate, 101) [RunStartDate]
	  FROM #tblFixedAssetParents fa
	  INNER JOIN ToolStringComponentInfo(NOLOCK) tsci ON tsci.SerialNum = fa.TopSerialNum AND tsci.InventoryItemNum = fa.TopInventoryItemNum
	  LEFT JOIN ToolStrings(NOLOCK) ts ON ts.ToolStringId = tsci.ToolStringID 
	  LEFT JOIN Runs(NOLOCK) run ON run.RunID = tsci.RunID  AND run.IsDownHole = 1  AND run.IsDeleted = 0 
		--AND CONVERT(date, fa.DateInstalled, 101) <= CONVERT(date, run.StartDate, 101)
		--AND (fa.DateRemoved IS NULL OR run.EndDate IS NULL OR CONVERT(date, fa.DateRemoved, 101) >= CONVERT(date, run.EndDate, 101))
	  where fa.FixedAssetId ='E86DEE76-D9F4-4E02-AC49-ABD3006FDC19'

  --    SELECT
		--f.FixedAssetId,
  --      f.SerialNum,
  --      f.InventoryItemNum,
  --      f.RNItemNum,
		--f.Revision,
		--i.DescShort AS ItemDesc,
		--CONVERT(VARCHAR, MAX(ri.DateInstalled),106) As DateInstalled,
		--CONVERT(BIT, (CASE WHEN (SELECT count(*) FROM ItemNumConfigs (NOLOCK) WHERE ISNULL(IsToolString, 0) = 0 and ParentItemNum = i.ItemNum) > 0 THEN 1 ELSE 0 END)) AS HasBOM,
  --      CAST(SUM(ISNULL(OperHrs,0)) AS DECIMAL(19,2)) [LifetimeOperHrs],
		--CAST(SUM(ISNULL(CircHrs,0)) AS DECIMAL(19,2)) [LifetimeCircHrs],
		--CAST(SUM(ISNULL(DrillHrs,0)) AS DECIMAL(19,2)) [LifetimeDrillHrs],
  --      SUM(CASE WHEN ri.TopFixedAssetId = f.TopLevelFixedAssetId THEN  CAST(OperHrs AS DECIMAL(19,2)) ELSE 0 END) [CurrentOperHrs],
		--SUM(CASE WHEN ri.TopFixedAssetId = f.TopLevelFixedAssetId THEN CAST(CircHrs AS DECIMAL(19,2)) ELSE 0 END) [CurrentCircHrs],
  --      SUM(CASE WHEN ri.TopFixedAssetId = f.TopLevelFixedAssetId THEN CAST(DrillHrs AS DECIMAL(19,2)) ELSE 0 END) [CurrentDrillHrs]
  --    FROM FixedAssets f
	 -- LEFT JOIN ItemNums i ON i.ItemNum = f.InventoryItemNum 
	 -- LEFT JOIN #tblRunInfo ri ON ri.FixedAssetId = f.FixedAssetId
	 -- Where f.ParentFixedAssetId = @FixedAssetId AND i.DefaultSerialProfile = 'S'

  --    GROUP BY f.SerialNum,
  --             f.InventoryItemNum,
  --             f.RNItemNum,
		--	   f.FixedAssetId,
		--	   f.Revision,
		--	   --ri.DateInstalled,
		--	   i.DescShort,
		--	   i.ItemNum
  --    ORDER BY f.SerialNum, f.InventoryItemNum, f.RNItemNum

      DROP TABLE #tblFixedAssets
      DROP TABLE #tblFixedAssetHistory
      DROP TABLE #tblFixedAssetParents
      DROP TABLE #tblRunInfo
