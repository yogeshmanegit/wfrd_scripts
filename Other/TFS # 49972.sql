--=========================================================================================
--MODIFIED BY: SUYEB MOHAMMAD
--MODIFIED ON :19 Feb 2015
--DESCRIPTION: Added new productline 
--========================================================================================
ALTER VIEW [dbo].[vwFixedAssetsSearch]
AS
SELECT
  fa.FixedAssetId,
  fa.SerialNum,
  fa.InventoryItemNum,
  fa.AssetNumber,
  fa.BranchPlant,
  bp.CompanyName AS BranchPlantName,
  fap.AssetNumber AS ParentNumber,
  fa.EquipmentStatus,
  fa.LegacySerialNumber,
  fa.RNItemNum,
  fa.AssetDescription AS FixedAssetDescription,
  i.DescShort AS AssetDescription,
  ri.DescShort AS RNAssetDescription,
  i.DescLong AS InventoryDescLong,
  fa.Ownership,
  fa.OwnershipDesc,
  fa.LastStatusChangeDate,
  DATEDIFF(DAY, ISNULL(fa.LastStatusChangeDate, GETDATE()), GETDATE()) AS DaysInStatus,
  fa.Cost,
  fa.NetBookValue,
  fa.CurrencyCode,
  fa.MasterFirmwareRevision,
  fa.MasterFirmwareItemNum,
  fa.FirmwareVersion,
  fa.TechId,
  fa.MfgPartNum,
  fa.ThirdItemNumber,
  fa.PhysicalLocation,
  fa.FixedAssetBranchPlant,
  fbp.CompanyName AS FixedAssetBranchPlantName,
  fa.ManufacturersSerialNumber,
  fa.LastComments,
  fa.Revision,
  fa.CatCode16,
  fa.VerifiedBy,
  fa.VerifiedDate,
  fa.VerifiedLocation,
  ps.IsDisposed,
  ps.[Status] AS StatusDesc,
  (SELECT TOP 1 j.JobNumber
	FROM DispatchInstanceItems dii (NOLOCK)
	JOIN DispatchInstances di (NOLOCK) ON di.DispatchInstanceId = dii.DispatchInstanceId
	JOIN Dispatches d (NOLOCK) ON d.DispatchId = di.DispatchId
	JOIN Jobs j (NOLOCK) ON j.JobId = d.JobId
  WHERE dii.FixedAssetId = fa.FixedAssetId AND dii.DateReturned IS NULL) AS JobNumber,
  r.Region,
  r.RegionDesc,
  c.Country,
  c.CountryDesc,
  bp.IsRepair,
  bp.IsGlobalRepair,
  bp.IsOps,
  bp.SAPFuncLoc,
  ISNULL(ri.ToolPanel, i.ToolPanel) AS ToolPanel,
  ISNULL(ri.ToolCode, i.ToolCode) AS ToolCode,
  ISNULL(ri.ItemNum2, i.ItemNum2) AS ItemNum2,
  ISNULL(ri.ItemNum3, i.ItemNum3) AS ItemNum3,
  ISNULL(ri.LegacyNum, i.LegacyNum) AS LegacyNum,
  gl.GLProductLineId AS ProductLineId,
  ISNULL(i.Critical, 0) AS Critical,
  i.DescShort AS ItemNumDescShort,
  i.DescLong AS ItemNumDescLong,
  i.Size,
  CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN (SELECT TOP 1 ir.RegionDesc 
			FROM PartTransferDtl ptd WITH (NOLOCK)
			LEFT OUTER JOIN BranchPlants(NOLOCK) ibp ON ibp.BranchPlant = ptd.SendingLocation
			LEFT OUTER JOIN Regions(NOLOCK) ir ON ir.Region = ibp.Region
			WHERE ptd.FixedAssetId = fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')
			ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC)
		ELSE NULL END AS SourceRegion,

  CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN (SELECT TOP 1 ic.CountryDesc
			FROM PartTransferDtl ptd WITH (NOLOCK) 
			LEFT OUTER JOIN BranchPlants(NOLOCK) ibp ON ibp.BranchPlant = ptd.SendingLocation
			LEFT OUTER JOIN Countries(NOLOCK) ic ON ic.Country = ibp.Country
			WHERE ptd.FixedAssetId = fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')
			ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC)
		ELSE NULL END AS SourceCountry,

  CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN (SELECT TOP 1 SendingLocation
			FROM PartTransferDtl ptd WITH (NOLOCK) 
			WHERE ptd.FixedAssetId = fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT') 
			ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC)
		ELSE NULL END AS SourceBranchPlant,

  CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN (SELECT TOP 1 ibp.CompanyName 
			FROM PartTransferDtl ptd WITH (NOLOCK)
			LEFT OUTER JOIN BranchPlants(NOLOCK) ibp ON ibp.BranchPlant = ptd.SendingLocation
			WHERE ptd.FixedAssetId = fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT') 
			ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC)
		ELSE NULL  END AS SourceBranchPlantName,

  CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN (SELECT TOP 1 ir.RegionDesc
			FROM PartTransferDtl ptd WITH (NOLOCK) 
			LEFT OUTER JOIN BranchPlants(NOLOCK) ibp ON ibp.BranchPlant = ptd.ReceivingLocation
			LEFT OUTER JOIN Regions(NOLOCK) ir ON ir.Region = ibp.Region 
			WHERE ptd.FixedAssetId = fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')
			ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC)
		ELSE NULL END AS DestRegion,

  CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN (SELECT TOP 1 ic.CountryDesc
			FROM PartTransferDtl ptd WITH (NOLOCK)
			LEFT OUTER JOIN BranchPlants(NOLOCK) ibp ON ibp.BranchPlant = ptd.ReceivingLocation
			LEFT OUTER JOIN Countries(NOLOCK) ic ON ic.Country = ibp.Country
			WHERE ptd.FixedAssetId = fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')
			ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC)
		ELSE NULL END AS DestCountry,

  CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN (SELECT TOP 1 ReceivingLocation
			FROM PartTransferDtl ptd WITH (NOLOCK)
			WHERE ptd.FixedAssetId = fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')
			ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC)
		ELSE NULL END AS DestBranchPlant,

  CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN (SELECT TOP 1 ibp.CompanyName
		  FROM PartTransferDtl ptd WITH (NOLOCK)
		  LEFT OUTER JOIN BranchPlants(NOLOCK) ibp ON ibp.BranchPlant = ptd.ReceivingLocation
		  WHERE ptd.FixedAssetId = fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT') 
			  ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC)
		ELSE NULL END AS DestBranchPlantName,

  --CASE WHEN fa.EquipmentStatus IN ('50', 'IN') THEN (SELECT TOP 1 ts.SerialNumber
	 --     FROM ToolStringFixedAssets tsfa (NOLOCK)
		--  JOIN ToolStrings ts (NOLOCK) ON ts.ToolStringId = tsfa.ToolStringID
		--  WHERE ts.Disassembled = 0 AND ts.IsDeleted = 0 AND tsfa.FixedAssetId = fa.FixedAssetId)
		--ELSE NULL END AS ToolString,
  (SELECT TOP 1 ts.SerialNumber
	FROM ToolStringFixedAssets tsfa (NOLOCK)
	JOIN ToolStrings ts (NOLOCK) ON ts.ToolStringId = tsfa.ToolStringID
	WHERE ts.Disassembled = 0 AND ts.IsDeleted = 0 AND tsfa.FixedAssetId = fa.FixedAssetId
	ORDER BY ts.CreateDate DESC) ToolString,

  CASE WHEN soRadioActive.SelectOptionId IS NULL THEN 0 ELSE 1 END AS IsRadioActive,
  CASE WHEN fa.EquipmentStatus IN ('50', 'IN') THEN fatp.SerialNum ELSE NULL END AS TopLevelSerialNum,
  CASE WHEN fa.EquipmentStatus IN ('50', 'IN') THEN pst.Status ELSE NULL END AS TopLevelEquipmentStatus,
  ISNULL(ri.IsAsset, ISNULL(i.IsAsset, 0)) AS IsAsset,
  CASE ISNULL(ri.IsAsset, ISNULL(i.IsAsset, 0)) WHEN 1 THEN 'Y' ELSE 'N' END AS IsAssetDisplay,
  r.Active AS IsRegionActive,
  i.PartCode,
  (SELECT TOP 1 imd.MetaValue FROM ItemNumMetadata(NOLOCK) imd  WHERE imd.MetaName = 'TOOL_SIZE_NOMINAL' AND imd.ItemNum = fa.InventoryItemNum) AS ToolSizeNominal,
  i.NetWeight,
  i.DefaultSerialProfile,
  ISNULL(ri.PartClassification, i.PartClassification) AS PartClassification,
  ISNULL(ri.Revision, i.Revision) AS LatestRevision,
  dbo.GetLastBillableLocation(fa.FixedAssetId,'Region') AS LastBillableRegion,
  dbo.GetLastBillableLocation(fa.FixedAssetId,'Country') AS LastBillableCountry,
  dbo.GetLastBillableLocation(fa.FixedAssetId,'BranchPlant') AS LastBillableBranchPlant,
  dbo.GetLastBillableLocation(fa.FixedAssetId,'BranchPlantName') AS LastBillableBranchPlantName,
  fa.Cost * cc.ConversionFactor AS CostInUSD,
  fa.NetBookValue * cc.ConversionFactor AS NetBookValueInUSD,
  cc.EffectiveStartDate AS CurrencyLastUpdated,
  fa.AcqCode,
  fa.MajorAccountingClass,
  fa.JournalingFlag,
  fa.ApplicationCode
  
FROM dbo.FixedAssets(NOLOCK) fa
LEFT OUTER JOIN FixedAssets(NOLOCK) fap ON fap.FixedAssetId = fa.ParentFixedAssetId
LEFT OUTER JOIN FixedAssets(NOLOCK) fatp ON fatp.FixedAssetId = fa.TopLevelFixedAssetId
LEFT JOIN dbo.ItemNums(NOLOCK) i ON i.ItemNum = fa.InventoryItemNum
LEFT JOIN dbo.ItemNums(NOLOCK) ri ON ri.ItemNum = fa.RNItemNum
LEFT JOIN dbo.BranchPlants(NOLOCK) bp ON bp.BranchPlant = fa.BranchPlant
LEFT JOIN dbo.BranchPlants(NOLOCK) fbp ON fbp.BranchPlant = fa.FixedAssetBranchPlant
LEFT JOIN dbo.SelectOptions(NOLOCK) soRadioActive ON soRadioActive.SelectName = 'AIRTRadioActive'
  AND soRadioActive.OptionValue = ISNULL(ri.ToolCode, i.ToolCode)
LEFT JOIN dbo.PartStatus(NOLOCK) ps ON ps.Code = fa.EquipmentStatus
LEFT JOIN dbo.PartStatus(NOLOCK) pst ON pst.Code = fatp.EquipmentStatus
LEFT JOIN dbo.Regions(NOLOCK) r ON r.Region = bp.Region
LEFT JOIN dbo.Countries(NOLOCK) c ON c.Country = bp.Country
LEFT JOIN GLCodes gl ON gl.GLCode = fa.ProductLineCode
LEFT JOIN (SELECT * FROM CurrencyConversionFactors(NOLOCK) ccf1 
			WHERE ccf1.EffectiveStartDate = (SELECT MAX(ccf2.EffectiveStartDate) 
												FROM CurrencyConversionFactors(NOLOCK) ccf2 
												WHERE ccf2.EffectiveStartDate <= GETDATE() AND ccf2.CurrShortName = ccf1.CurrShortName)
			) cc ON cc.CurrShortName = fa.CurrencyCode