ALTER PROCEDURE [dbo].[usp_GetDispatchBuildsheetForExport]    
 @DispatchNumber int
AS    
BEGIN    

	SELECT DispatchNumber, BranchPlant as BranchPlant FROM Dispatches WHERE DispatchNumber = @DispatchNumber

	SELECT t.ToolStringId,
			t.SerialNumber as BuildSheetNumber,
			t.Description as ToolDesc,
			t.ToolYear,
			t.BuildNumber,
			t.District
	FROM Dispatches d
	JOIN JarRunTools jt on jt.JobId = d.DispatchId
	JOIN toolstrings t on t.toolstringid = jt.ToolStringId
	WHERE d.DispatchNumber = @DispatchNumber

	SELECT ts.ToolStringId,
		btam.BuildsheetApplicationId [BuildSheetTemplateId],
		attr.AttributeId,
		attrvalues.AttributeValuesId,
		attr.[Name],
		attr.[Description],
		attrvalues.AttributeValue as [Value],
		sl.OptionLabel AS UOM
	FROM Dispatches d
	JOIN JarRunTools jt on jt.JobId = d.DispatchId
	JOIN ToolStrings ts on ts.toolstringid = jt.ToolStringId
	JOIN BuildSheetTemplateAttributeMaps btam on  ts.TemplateId = btam.BuildsheetApplicationId
	JOIN Attributes attr  WITH (NOlock)
		ON attr.AttributeId = btam.AttrId
    JOIN AttributeValues attrvalues  WITH (NOlock)
		ON attrvalues.AttributevaluesId = btam.AttrvaluesId
    JOIN SelectOptions sl  WITH (NOlock)
		ON sl.OptionValue = CONVERT(VARCHAR(10), attr.Uomid)
	WHERE d.DispatchNumber = @DispatchNumber 
		 AND SelectName  = 'formfieldUOM'
         AND btam.active = 1 

	SELECT tsfa.ToolStringFixedAssetsId,
		ts.ToolStringId,
		tsfa.FixedAssetID as FixedAssetId,
		tsfa.SerialNum as SerialNumber,
		tsfa.InventoryItemNum as ItemNum,
		tsfa.ToolCode,
		it.DescShort
	FROM Dispatches d
	JOIN JarRunTools jt on jt.JobId = d.DispatchId
	JOIN ToolStrings ts on ts.toolstringid = jt.ToolStringId
	JOIN ToolStringFixedAssets tsfa on ts.ToolStringId = tsfa.ToolStringID
	LEFT JOIN itemnums it on tsfa.InventoryItemNum = it.ItemNum
	WHERE d.DispatchNumber = @DispatchNumber

	DECLARE @FixedAssetIds TABLE (FixedAssetId uniqueidentifier)

	INSERT INTO @FixedAssetIds 
	SELECT 
		tsfa.FixedAssetID
	FROM Dispatches d
	JOIN JarRunTools jt on jt.JobId = d.DispatchId
	JOIN ToolStrings ts on ts.toolstringid = jt.ToolStringId
	JOIN ToolStringFixedAssets tsfa on ts.ToolStringId = tsfa.ToolStringID
	LEFT JOIN itemnums it on tsfa.InventoryItemNum = it.ItemNum
	WHERE d.DispatchNumber = @DispatchNumber


	--this to handle drilling services scenario where monitors are setup on parent-childs relation
	SELECT 
		DISTINCT CbmMonitorId,
		[ParentFixedAssetId],
		[FixedAssetId] as ChildFixedAssetId,
		SerialNum [ChildSerialNumber],
		MeterReadingTypeId,
		TriggerValue as [Trigger],
		CONVERT(varchar(10),LastMeterReadingValue) as LastMeterReadingValue
	FROM 
	(SELECT 
	c.CBMMonitorId,
	c.FixedAssetId,
	c.[ParentFixedAssetId],
	c.SerialNum,
	c.InventoryItemNum,
	dbo.ufn_CBMMonitor_GetTrigger(c.CBMMonitorId, c.BranchPlant, c.FixedAssetId) [TriggerValue],
	c.MeterReadingTypeId,
	COALESCE(
			/*
				1	Operating Hours
				2	Circulating Hours
				3	Temperature Function
				6	Shock Monitor
				7	Vibration Monitor
			*/
			CASE WHEN c.MeterReadingTypeId IN (1,2,3,6,7) THEN r.LastMeterReadingValue

			--One Time Mandatory
			WHEN c.MeterReadingTypeId = 4 THEN 
			(
				-- if 
				CASE WHEN (select top 1 pftWO_OneTime.PFTWOId 
							FROM PFTWO pftWO_OneTime (NOLOCK)
							JOIN PFTConfig pftConfig_OneTime (NOLOCK) on pftWO_OneTime.PFTConfigId = pftConfig_OneTime.PFTConfigId
							WHERE pftWO_OneTime.FixedAssetId = parentFixedAssetId
									AND pftConfig_OneTime.ObjectNumber = c.ObjectNumber
									AND pftWO_OneTime.PFTType = 3
									AND pftWO_OneTime.ReasonForChange = 'Closed - Passed'
						) IS NULL THEN 0 
					ELSE 1 END
			)
			-- scheduled    
			WHEN c.MeterReadingTypeId = 5 THEN  
					DATEDIFF(dd,  
								COALESCE(r.LastMeterReadingValue   -- Check Last PM PFT Completed    
									,(SELECT MIN(DateofTransaction) FROM PartTransferDtl p (NOLOCK) WHERE Dest = 'IN' AND p.FixedAssetId = c.fixedAssetId) 
									, c.DateAdded), 
					GETDATE())   

			-- AIRT Count
			WHEN c.MeterReadingTypeId = 8 THEN -- AIRT    
					ISNULL(
						(
							SELECT COUNT(*) 
							FROM AssetRepairTrack a
							WHERE a.FixedAssetId = ParentFixedAssetid
								and a.Status = 'Closed'
								and a.DateAdded > ISNULL((SELECT MAX(pw.DateAdded)
													FROM PFTWO pw (NOLOCK)
													JOIN PftConfig pc (NOLOCK) on pw.PFTConfigId = pc.PFTConfigId and pc.ObjectNumber = c.ObjectNumber
													WHERE pw.FixedAssetId = ParentFixedAssetid
														AND PFTType = 3
														AND pw.Active = 0
														AND pw.ReasonForChange = 'Closed - Passed'
													), '1900-01-01')
						),
					0)

			-- Days Since DT Return   
			WHEN c.MeterReadingTypeId IN (10, 11) THEN dbo.ufn_CbmMonitor_GetDTLastMeterReadingValue(c.fixedAssetid, c.CBMMonitorId) 

		END , DefaultMeterReading, 0) AS LastMeterReadingValue
	FROM 
	(
	SELECT c.CBMMonitorId,
			c.ObjectNumber,
			c.MeterReadingTypeId,
			c.CreateJDEWO,
			c.DefaultMeterReading,
			f.FixedAssetId,
			parentFixedAsset.FixedAssetId [ParentFixedAssetId],
			f.SerialNum,
			f.InventoryItemNum,
			f.BranchPlant,
			f.DateAdded
	FROM @FixedAssetIds ids
	JOIN FixedAssets parentFixedAsset (NOLOCK) on ids.FixedAssetId = parentFixedAsset.FixedAssetId
	JOIN FixedAssets f (NOLOCK) ON ISNULL(f.TopLevelFixedAssetId, f.FixedAssetId) = parentFixedAsset.FixedAssetId 
	JOIN CBMMonitorAssetItemNums pItem (NOLOCK) on pItem.ItemNum = parentFixedAsset.InventoryItemNum 
			and pItem.IsParent = 1
	JOIN CBMMonitorAssetItemNums cItem (NOLOCK) on pItem.CBMMonitorId = cItem.CBMMonitorId 
		and cItem.ItemNum = f.InventoryItemNum and cItem.IsParent = 0
	JOIN CBMMonitor c (NOLOCK) on c.CBMMonitorId = cItem.CBMMonitorId
	WHERE c.Active = 1
	--AND parentFixedAsset.FixedAssetId = @FixedAssetId
UNION 
--this change was done for wireline since they are setting up monitors on childs only
	SELECT c.CBMMonitorId,
			c.ObjectNumber,
			c.MeterReadingTypeId,
			c.CreateJDEWO,
			c.DefaultMeterReading,
			f.FixedAssetId,
			f.FixedAssetId [ParentFixedAssetId],
			f.SerialNum,
			f.InventoryItemNum,
			f.BranchPlant,
			f.DateAdded
	FROM @FixedAssetIds ids
	JOIN FixedAssets f (NOLOCK) on ids.FixedAssetId = ISNULL(f.TopLevelFixedAssetId, f.FixedAssetId)
	JOIN CBMMonitorAssetItemNums pItem (NOLOCK) on pItem.ItemNum = f.InventoryItemNum 
			and pItem.IsParent = 1
	JOIN CBMMonitorAssetItemNums cItem (NOLOCK) on pItem.CBMMonitorId = cItem.CBMMonitorId 
		and cItem.ItemNum = f.InventoryItemNum and cItem.IsParent = 0
	JOIN CBMMonitor c (NOLOCK) on c.CBMMonitorId = cItem.CBMMonitorId
	WHERE c.Active = 1
		AND f.AssetNumber != f.ParentNumber
		--AND f.FixedAssetId = @FixedAssetId
	) c
	LEFT JOIN CBMCalculatedMeterReadings r (NOLOCK) ON c.FixedAssetId = r.FixedAssetId AND c.CBMMonitorId = r.CBMMonitorId
	) A
	WHERE (CASE WHEN MeterReadingTypeId = 4 THEN LastMeterReadingValue ELSE 0 END) = 0
	--ORDER BY a.SerialNum, a.InventoryItemNum, a.MeterReadingTypeId 

END
GO

EXEC [dbo].[usp_GetDispatchBuildsheetForExport] '12672508'