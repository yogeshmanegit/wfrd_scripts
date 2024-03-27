ALTER TABLE BusinessUnits
ADD GLCode VARCHAR(20)

GO

UPDATE b
SET GLCode = ltrim(rtrim(j.mcrp02))
from BusinessUnits b
join uspdsqlshr01.dstopsprd.dbo.f0006 j on ltrim(rtrim(mcmcu)) = b.BusinessUnit 
GO


ALTER VIEW [dbo].[vwFixedAssets]
AS

SELECT 
  fa.FixedAssetId, fa.AssetNumber, fap.AssetNumber as ParentNumber, fa.ParentFixedAssetId, fa.SerialNum
  , fa.CurrentItemQty, fa.EquipmentStatus, fa.BranchPlant, bp.CompanyName AS BranchPlantDesc
  , fa.FixedAssetBranchPlant  
  , IsNull(i.DescShort, ISNULL(ri.DescShort, fa.AssetDescription)) as AssetDescription
  , fa.InventoryItemNum
  , ISNULL(nui.NewItemNum, fa.InventoryItemNum) as NewItemNum
  , nui.UsedItemNum
  , ISNULL(nui.NewUsedItem, 'N') as NewUsedItem
  , fa.RNItemNum
  , (CASE WHEN ISNULL(fa.RNItemNum, '') <> '' THEN 'RN' ELSE 'I' END) as RNI
  , fa.ThirdItemNumber, fa.LegacySerialNumber
  , fa.IsAdvisorOnly, fa.NotUsed, fa.IsAddByWorkOrder
  , i.ItemNumId,i.PartCode, i.DescShort
  , fa.Revision
  , i.Revision as ItemNumRevision
  , IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) AS IsAsset
  , (CASE IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) WHEN 1 THEN 'Yes' ELSE 'No' END) AS IsAssetDisplay
  , (CASE i.DefaultSerialProfile WHEN 'S' THEN 0 ELSE 1 END) AS IsBatch
  , (CASE i.DefaultSerialProfile WHEN 'S' THEN 'No' ELSE 'Yes' END) AS IsBatchDisplay
  , ps.[Status] AS StatusDesc
  , CASE WHEN isnull(so.optionvalue,'') = '' THEN 0 ELSE 1 END AS IsRadioActive
  , ISNULL(ri.ToolPanel, i.ToolPanel) as ToolPanel, fa.LastComments
  
  , fa.TopLevelFixedAssetId
  , (CASE WHEN (Select COUNT(b.FixedAssetId) from FixedAssets b WITH(NOLOCK) Where b.ParentFixedAssetId = fa.FixedAssetId) > 0 THEN 1 ELSE 0 END) as HasChildren
	
	, ISNULL(ps.IsSrcWorkOrder, 1) as IsSrcWorkOrder
	, ISNULL(ps.IsSrcWorkOrderChild, 1) as IsSrcWorkOrderChild
	, ISNULL(ps.IsSrcDispatch, 1) as IsSrcDispatch
	, ISNULL(ps.IsSrcAIRT, 1) as IsSrcAIRT
	, ISNULL(ps.IsSrcPFT, 1) as IsSrcPFT
	, ISNULL(ps.IsSrcBuildSheet, 1) as IsSrcBuildSheet
	, ISNULL(ps.IsDisposed, 0) as IsDisposed
	, ISNULL(ps.IsSrcStatus, 1) as IsSrcStatus
	, ISNULL(bp.IsNonLiveLocation,0) AS IsNonLiveLocation
	, ISNULL(gl.GLProductLineId,0) [ProductlineId]
FROM FixedAssets(NOLOCK) fa
LEFT OUTER JOIN FixedAssets (NOLOCK) fap ON fap.FixedAssetId = fa.ParentFixedAssetId
LEFT JOIN dbo.ItemNums(NOLOCK) i ON i.ItemNum = fa.InventoryItemNum
LEFT JOIN dbo.ItemNums(NOLOCK) ri ON ri.ItemNum = fa.RNItemNum
LEFT JOIN NewUsedItemNums(NOLOCK) nui ON nui.KeyItemNum = fa.InventoryItemNum
LEFT JOIN BranchPlants(NOLOCK) bp on bp.BranchPlant = fa.BranchPlant
LEFT JOIN SelectOptions(NOLOCK) so on so.SelectName = 'AIRTRadioActive' AND so.OptionValue = ISNULL(ri.ToolCode, i.ToolCode)
LEFT JOIN PartStatus(NOLOCK) ps ON ps.Code = fa.EquipmentStatus
LEFT JOIN BusinessUnits bu on bu.BusinessUnit = fa.BusinessUnit
LEFT JOIN GLCodes gl (NOLOCK) ON gl.GLCode = bu.GLCode
GO
--=========================================================================================  
--MODIFIED BY: SUYEB MOHAMMAD  
--MODIFIED ON :19 Feb 2015  
--DESCRIPTION: Added new productline   
--========================================================================================  
ALTER VIEW [dbo].[vwFixedAssetsSearch]
AS  
SELECT f.*,
	
	CASE WHEN f.EquipmentStatus IN ('PT', 'IT') THEN rsloc.RegionDesc END SourceRegion,
	CASE WHEN f.EquipmentStatus IN ('PT', 'IT') THEN csloc.CountryDesc END AS SourceCountry,
	CASE WHEN f.EquipmentStatus IN ('PT', 'IT') THEN p.SendingLocation END AS SourceBranchPlant,
	CASE WHEN f.EquipmentStatus IN ('PT', 'IT') THEN sloc.CompanyName END AS SourceBranchPlantName,
  
	CASE WHEN f.EquipmentStatus IN ('PT', 'IT') THEN rrloc.RegionDesc END DestRegion,
	CASE WHEN f.EquipmentStatus IN ('PT', 'IT') THEN crloc.CountryDesc END AS DestCountry,
	CASE WHEN f.EquipmentStatus IN ('PT', 'IT') THEN p.ReceivingLocation END AS DestBranchPlant,
	CASE WHEN f.EquipmentStatus IN ('PT', 'IT') THEN rloc.CompanyName END AS DestBranchPlantName,

	regLastbillable.RegionDesc AS LastBillableRegion,
	clastbillable.CountryDesc AS LastBillableCountry,
	bpLastbillable.BranchPlant LastBillableBranchPlant,
	bpLastbillable.CompanyName AS LastBillableBranchPlantName	

FROM 
(
SELECT   
  fa.FixedAssetId,
  (SELECT TOP 1 ptd.PartTransferDtlId FROM PartTransferDtl ptd WITH (NOLOCK) WHERE ptd.FixedAssetId = fa.FixedAssetId 
	ORDER BY ptd.DateofTransaction DESC) [PartTransferDtlId],
  (SELECT TOP 1 ReceivingLocation FROM [PartTransferDtl] [PTD] WITH (NOLOCK)
					LEFT OUTER JOIN [BranchPlants](NOLOCK) [BP] ON [BP].[BranchPlant] = [PTD].ReceivingLocation
			WHERE	[PTD].[FixedAssetId] = fa.FixedAssetId AND [BP].[IsOperationsBillableLocation] = 1
			ORDER BY [PTD].[DateofTransaction] DESC) [LastBillableBranchPlantNum],
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
  ISNULL(r.Active,0) AS IsRegionActive,   
  i.PartCode,  
  (SELECT TOP 1 imd.MetaValue FROM ItemNumMetadata(NOLOCK) imd  WHERE imd.MetaName = 'TOOL_SIZE_NOMINAL' AND imd.ItemNum = fa.InventoryItemNum) AS ToolSizeNominal,  
  i.NetWeight,  
  i.DefaultSerialProfile,  
  ISNULL(ri.PartClassification, i.PartClassification) AS PartClassification,  
  ISNULL(ri.Revision, i.Revision) AS LatestRevision,  
  fa.Cost * cc.ConversionFactor AS CostInUSD,  
  fa.NetBookValue * cc.ConversionFactor AS NetBookValueInUSD, 
  cc.EffectiveStartDate AS CurrencyLastUpdated,  
  fa.AcqCode,  
  fa.MajorAccountingClass,  
  fa.JournalingFlag,  
  fa.ApplicationCode,
  fa.AssetLifeRemaining,
  bp.[IsOperationsBillableLocation]  
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
LEFT JOIN BusinessUnits (NOLOCK) bu on bu.BusinessUnit = fa.BusinessUnit
LEFT JOIN GLCodes gl (NOLOCK) ON gl.GLCode = bu.GLCode
LEFT JOIN (SELECT * FROM CurrencyConversionFactors(NOLOCK) ccf1   
   WHERE ccf1.EffectiveStartDate = (SELECT MAX(ccf2.EffectiveStartDate)   
            FROM CurrencyConversionFactors(NOLOCK) ccf2   
            WHERE ccf2.EffectiveStartDate <= GETDATE() AND ccf2.CurrShortName = ccf1.CurrShortName)  
   ) cc ON cc.CurrShortName = fa.CurrencyCode
) f
LEFT JOIN PartTransferDtl p (NOLOCK) ON p.PartTransferDtlId = f.PartTransferDtlId and p.DocumentType IN ('S0','S5','S9','ST','S1')
LEFT JOIN BranchPlants sloc (NOLOCK) on sloc.BranchPlant = p.SendingLocation
LEFT OUTER JOIN Regions(NOLOCK) rsloc ON rsloc.Region = sloc.Region  
LEFT OUTER JOIN Countries(NOLOCK) csloc ON csloc.Country = sloc.Country  
   
LEFT JOIN BranchPlants rloc (NOLOCK) ON rloc.BranchPlant = p.ReceivingLocation
LEFT OUTER JOIN Regions(NOLOCK) rrloc ON rrloc.Region = rloc.Region  
LEFT OUTER JOIN Countries(NOLOCK) crloc ON crloc.Country = rloc.Country  

LEFT JOIN BranchPlants bpLastbillable (NOLOCK) ON bpLastbillable.BranchPlant = f.LastBillableBranchPlantNum
LEFT OUTER JOIN Regions(NOLOCK) regLastbillable ON regLastbillable.Region = bpLastbillable.Region  
LEFT OUTER JOIN Countries(NOLOCK) clastbillable ON bpLastbillable.Country = clastbillable.Country  
GO
ALTER VIEW [dbo].[vwSerialNumLookup] AS

Select NEWID() as LookupId, 
		fa.SerialNum, 
		fa.InventoryItemNum,
		ISNULL(nui.NewItemNum, fa.InventoryItemNum) as NewItemNum,
	    nui.UsedItemNum,
	    ISNULL(nui.NewUsedItem, 'N') as NewUsedItem,
	    fa.RNItemNum,
		(CASE WHEN ISNULL(fa.RNItemNum, '') <> '' THEN 'RN' ELSE 'I' END) as RNI,
		i.DescShort as ItemNumDesc,
		fa.BranchPlant,
		bp.CompanyName AS BranchPlantDesc,
		fa.EquipmentStatus,
		ps.Status as StatusDesc,
		fa.CurrentItemQty,
		fa.Revision,
		IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) AS IsAsset,
		(CASE IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) WHEN 1 THEN 'Yes' ELSE 'No' END) AS IsAssetDisplay,
		0 AS IsBatch,
		'No' AS IsBatchDisplay,
		ISNULL(ps.IsSrcWorkOrder, 1) as IsSrcWorkOrder,
		ISNULL(ps.IsSrcWorkOrderChild, 1) as IsSrcWorkOrderChild,
		ISNULL(ps.IsSrcDispatch, 1) as IsSrcDispatch,
		ISNULL(ps.IsSrcAIRT, 1) as IsSrcAIRT,
		ISNULL(ps.IsSrcPFT, 1) as IsSrcPFT,
		ISNULL(ps.IsSrcBuildSheet, 1) as IsSrcBuildSheet,
		ISNULL(ps.IsDisposed, 0) as IsDisposed,
		ISNULL(ps.IsSrcStatus, 1) as IsSrcStatus,
		gl.GLProductLineId [ProductLineId]
from FixedAssets(NOLOCK) fa
LEFT JOIN ItemNums(NOLOCK) i ON i.ItemNum = fa.InventoryItemNum
LEFT JOIN NewUsedItemNums(NOLOCK) nui ON nui.KeyItemNum = fa.InventoryItemNum
LEFT JOIN dbo.ItemNums(NOLOCK) ri ON ri.ItemNum = fa.RNItemNum
LEFT JOIN PartStatus(NOLOCK) ps ON ps.Code = fa.EquipmentStatus
LEFT JOIN BranchPlants(NOLOCK) bp ON bp.BranchPlant = fa.BranchPlant
LEFT Join BusinessUnits (NOLOCK) bu on bu.BusinessUnit = fa.BusinessUnit
LEFT JOIN GLCodes gl (NOLOCK) ON gl.GLCode = bu.GLCode
Where i.DefaultSerialProfile = 'S'

UNION

Select  NEWID() as LookupId, 
		fa.SerialNum, 
		fa.InventoryItemNum,
		ISNULL(nui.NewItemNum, fa.InventoryItemNum) as NewItemNum,
	    nui.UsedItemNum,
	    ISNULL(nui.NewUsedItem, 'N') as NewUsedItem,
	    ISNULL(fa.RNItemNum, '') as RNItemNum,
		(CASE WHEN ISNULL(fa.RNItemNum, '') <> '' THEN 'RN' ELSE 'I' END) as RNI,
		i.DescShort as ItemNumDesc,
		'' as BranchPlant,
		'' as BranchPlantDesc,
		'AV' as EquipmentStatus,
		ps.Status as StatusDesc,
		fa.CurrentItemQty,
		ISNULL(fa.Revision, '') as Revision,
		IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) AS IsAsset,
		(CASE IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) WHEN 1 THEN 'Yes' ELSE 'No' END) AS IsAssetDisplay,
		1 AS IsBatch,
		'Yes' AS IsBatchDisplay,
		1 as IsSrcWorkOrder,
		1 as IsSrcWorkOrderChild,
		1 as IsSrcDispatch,
		1 as IsSrcAIRT,
		1 as IsSrcPFT,
		1 as IsSrcBuildSheet,
		0 as IsDisposed,
		1 as IsSrcStatus,
		gl.GLProductLineId [ProductLineId]
from FixedAssets(NOLOCK) fa
LEFT JOIN ItemNums(NOLOCK) i ON i.ItemNum = fa.InventoryItemNum
LEFT JOIN NewUsedItemNums(NOLOCK) nui ON nui.KeyItemNum = fa.InventoryItemNum
LEFT JOIN dbo.ItemNums(NOLOCK) ri ON ri.ItemNum = fa.RNItemNum
LEFT JOIN PartStatus(NOLOCK) ps ON ps.Code = 'AV'
--LEFT JOIN BranchPlants(NOLOCK) bp ON bp.BranchPlant = fa.BranchPlant
LEFT JOIN BusinessUnits bu (NOLOCK) on bu.BusinessUnit = fa.BusinessUnit
LEFT JOIN GLCodes gl (NOLOCK) ON gl.GLCode = bu.GLCode
Where ISNULL(i.DefaultSerialProfile, '') <> 'S'
GROUP by SerialNum, fa.InventoryItemNum, ISNULL(fa.RNItemNum, ''), ISNULL(nui.NewItemNum, fa.InventoryItemNum), nui.UsedItemNum, ISNULL(nui.NewUsedItem, 'N'),
	i.DescShort, ps.Status, ISNULL(fa.Revision, ''), 
	IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)), i.DefaultSerialProfile, 
	fa.CurrentItemQty, gl.GLProductLineId

GO
ALTER VIEW [dbo].[vw_FixedAssetLookup] AS

SELECT fa.FixedAssetId, 
		fa.SerialNum, 
		fa.InventoryItemNum,
		ISNULL(nui.NewItemNum, fa.InventoryItemNum) as NewItemNum,
	    nui.UsedItemNum,
	    ISNULL(nui.NewUsedItem, 'N') as NewUsedItem,
	    fa.RNItemNum,
		(CASE WHEN ISNULL(fa.RNItemNum, '') <> '' THEN 'RN' ELSE 'I' END) as RNI,
		i.DescShort as ItemNumDesc,
		fa.BranchPlant,
		bp.CompanyName AS BranchPlantDesc,
		fa.EquipmentStatus,
		ps.Status as StatusDesc,
		fa.CurrentItemQty,
		fa.Revision,
		IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) AS IsAsset,
		(CASE IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) WHEN 1 THEN 'Yes' ELSE 'No' END) AS IsAssetDisplay,
		0 AS IsBatch,
		'No' AS IsBatchDisplay,
		ISNULL(ps.IsSrcWorkOrder, 1) as IsSrcWorkOrder,
		ISNULL(ps.IsSrcWorkOrderChild, 1) as IsSrcWorkOrderChild,
		ISNULL(ps.IsSrcDispatch, 1) as IsSrcDispatch,
		ISNULL(ps.IsSrcAIRT, 1) as IsSrcAIRT,
		ISNULL(ps.IsSrcPFT, 1) as IsSrcPFT,
		ISNULL(ps.IsSrcBuildSheet, 1) as IsSrcBuildSheet,
		ISNULL(ps.IsDisposed, 0) as IsDisposed,
		ISNULL(ps.IsSrcStatus, 1) as IsSrcStatus,
		gl.GLProductLineId [ProductLineId]
from FixedAssets(NOLOCK) fa
LEFT JOIN ItemNums(NOLOCK) i ON i.ItemNum = fa.InventoryItemNum
LEFT JOIN NewUsedItemNums(NOLOCK) nui ON nui.KeyItemNum = fa.InventoryItemNum
LEFT JOIN dbo.ItemNums(NOLOCK) ri ON ri.ItemNum = fa.RNItemNum
LEFT JOIN PartStatus(NOLOCK) ps ON ps.Code = fa.EquipmentStatus
LEFT JOIN BranchPlants(NOLOCK) bp ON bp.BranchPlant = fa.BranchPlant
LEFT JOIN BusinessUnits (NOLOCK) bu on bu.BusinessUnit = fa.BusinessUnit
LEFT JOIN GLCodes gl (NOLOCK) ON gl.GLCode = bu.GLCode
Where i.DefaultSerialProfile = 'S'

UNION

Select  fa.FixedAssetId,
		fa.SerialNum, 
		fa.InventoryItemNum,
		ISNULL(nui.NewItemNum, fa.InventoryItemNum) as NewItemNum,
	    nui.UsedItemNum,
	    ISNULL(nui.NewUsedItem, 'N') as NewUsedItem,
	    ISNULL(fa.RNItemNum, '') as RNItemNum,
		(CASE WHEN ISNULL(fa.RNItemNum, '') <> '' THEN 'RN' ELSE 'I' END) as RNI,
		i.DescShort as ItemNumDesc,
		'' as BranchPlant,
		'' as BranchPlantDesc,
		'AV' as EquipmentStatus,
		ps.Status as StatusDesc,
		fa.CurrentItemQty,
		ISNULL(fa.Revision, '') as Revision,
		IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) AS IsAsset,
		(CASE IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)) WHEN 1 THEN 'Yes' ELSE 'No' END) AS IsAssetDisplay,
		1 AS IsBatch,
		'Yes' AS IsBatchDisplay,
		1 as IsSrcWorkOrder,
		1 as IsSrcWorkOrderChild,
		1 as IsSrcDispatch,
		1 as IsSrcAIRT,
		1 as IsSrcPFT,
		1 as IsSrcBuildSheet,
		0 as IsDisposed,
		1 as IsSrcStatus,
		gl.GLProductLineId [ProductLineId]
from FixedAssets(NOLOCK) fa
LEFT JOIN ItemNums(NOLOCK) i ON i.ItemNum = fa.InventoryItemNum
LEFT JOIN NewUsedItemNums(NOLOCK) nui ON nui.KeyItemNum = fa.InventoryItemNum
LEFT JOIN dbo.ItemNums(NOLOCK) ri ON ri.ItemNum = fa.RNItemNum
LEFT JOIN PartStatus(NOLOCK) ps ON ps.Code = 'AV'
--LEFT JOIN BranchPlants(NOLOCK) bp ON bp.BranchPlant = fa.BranchPlant
LEFT JOIN BusinessUnits (NOLOCK) bu on bu.BusinessUnit = fa.BusinessUnit
LEFT JOIN GLCodes gl (NOLOCK) ON gl.GLCode = bu.GLCode
Where ISNULL(i.DefaultSerialProfile, '') <> 'S'
GROUP by fa.FixedAssetId,SerialNum, fa.InventoryItemNum, ISNULL(fa.RNItemNum, ''), ISNULL(nui.NewItemNum, fa.InventoryItemNum), nui.UsedItemNum, ISNULL(nui.NewUsedItem, 'N'),
	i.DescShort, ps.Status, ISNULL(fa.Revision, ''), 
	IsNull(ri.IsAsset, ISNULL(i.IsAsset, 0)), i.DefaultSerialProfile, 
	fa.CurrentItemQty, gl.GLProductLineId

GO
----=========================================================================================            
-- Created BY: Mangesh V Taware        
-- Created ON : 08 Jan 2018        
-- DESCRIPTION: For Use Fixed Assets search         
----========================================================================================            
ALTER VIEW [dbo].[vw_FixedAssetParentChildSearch]  
 AS            
SELECT             
  fa.FixedAssetId,            
  fa.SerialNum,            
  fa.InventoryItemNum,            
  fa.AssetNumber,  
  fa.BranchPlant,            
  bp.CompanyName AS BranchPlantName,            
  fa.ParentNumber,    
  faa.SerialNum as TopLevelSerialNum,  
  fa.ParentFixedAssetId,    
  fa.EquipmentStatus,            
  fa.LegacySerialNumber,            
  fa.RNItemNum,            
  fa.AssetDescription AS FixedAssetDescription,            
  i.DescShort AS AssetDescription,            
  i.DescLong AS InventoryDescLong,            
  fa.FixedAssetBranchPlant,            
  fbp.CompanyName AS FixedAssetBranchPlantName,            
  fa.ManufacturersSerialNumber,            
  fa.Revision,            
  fa.CatCode16,            
  ps.[Status] AS StatusDesc,        
  ps.IsDisposed,       
  r.Region,            
  r.RegionDesc,            
  c.Country,            
  c.CountryDesc,        
  ISNULL(ri.ToolPanel, i.ToolPanel) AS ToolPanel,  
  ISNULL(ri.ToolCode, i.ToolCode) AS ToolCode,  
  gl.GLProductLineId AS ProductLineId,  
  ISNULL(ri.IsAsset, ISNULL(i.IsAsset, 0)) AS IsAsset,        
  CASE fa.EquipmentStatus  WHEN '50' THEN 'Y' ELSE 'N' END AS Is50Equipment,  
  (SELECT COUNT(*)   
 FROM FixedAssets fc (NOLOCK)  
  LEFT JOIN dbo.ItemNums(NOLOCK) i1 ON i1.ItemNum = fc.InventoryItemNum
  LEFT JOIN dbo.ItemNums(NOLOCK) ri1 ON ri1.ItemNum = fc.RNItemNum
 WHERE ParentFixedAssetId = fa.FixedAssetId AND ISNULL(fc.InventoryItemNum,'0') != '0'
   AND ISNULL(ri1.IsAsset, ISNULL(i1.IsAsset, 0)) = 1  
 ) AS ChildAssetCount  
FROM dbo.FixedAssets(NOLOCK) fa            
LEFT JOIN dbo.ItemNums(NOLOCK) i ON i.ItemNum = fa.InventoryItemNum            
LEFT JOIN dbo.ItemNums(NOLOCK) ri ON ri.ItemNum = fa.RNItemNum           
LEFT JOIN dbo.BranchPlants(NOLOCK) bp ON bp.BranchPlant = fa.BranchPlant            
LEFT JOIN dbo.BranchPlants(NOLOCK) fbp ON fbp.BranchPlant = fa.FixedAssetBranchPlant            
LEFT JOIN dbo.PartStatus(NOLOCK) ps ON ps.Code = fa.EquipmentStatus            
LEFT JOIN dbo.Regions(NOLOCK) r ON r.Region = bp.Region            
LEFT JOIN dbo.Countries(NOLOCK) c ON c.Country = bp.Country
LEFT JOIN dbo.BusinessUnits (NOLOCK) bu ON bu.BusinessUnit = fa.BusinessUnit
LEFT JOIN GLCodes gl (NOLOCK) ON gl.GLCode = bu.BusinessUnit
Left JOIN FixedAssets faa (NOLOCK) ON faa.FixedAssetId  = fa.TopLevelFixedAssetId  
WHERE ISNULL(ri.IsAsset, ISNULL(i.IsAsset, 0)) = 1
GO
ALTER VIEW [dbo].[VW_FixedAssets_WPTS]
AS 
  select 
	f.FixedAssetId, 
	f.SerialNum [SerialNumber],
	f.InventoryItemNum [InventoryItemNumber],
	f.AssetNumber [JDEAssetNumber],
	f.ParentNumber [ParentAssetNumber],
	f.RNItemNum [RentalItemNumber],
	i.DescShort [PartDescription],
	f.AssetDescription [JDEAssetDescription],
	f.ProductLineCode [GLCode],
	i.ToolPanel [ToolPanel],
	i.ToolCode [ToolCode],
	f.BranchPlant,
	f.FixedAssetBranchPlant [OwnershipBranchPlant],
	p.Id [ProductLineId],
	i.IsAsset [IsAsset],
	f.LastStatusChangeDate [LastUpdatedOn]
	from FixedAssets f (NOLOCK)
	left join ItemNums i (NOLOCK) on i.ItemNum = f.inventoryitemnum
	left join ItemNums rn (NOLOCK) on rn.ItemNum = f.inventoryitemnum
	left join BusinessUnits b (NOLOCK) on b.BusinessUnit = f.BusinessUnit
	left join GLCodes gc (NOLOCK) on gc.GLCode = b.GLCode
	left join GLProductLines p (NOLOCK) on p.Id = gc.GLProductLineId
GO
ALTER VIEW [dbo].[vwAssetRepairTrackSearch]  
AS  
  
SELECT art.AssetRepairTrackId  
  , art.ARTNumber  
  , art.FixedAssetId  
  , art.ItemNum as PartNum  
  , art.RNItemNum as RNPartNum  
  , art.ItemDesc as PartDesc  
  , art.SerialNum  
  , art.AssetNumber  
  , CASE WHEN isnull(sl.optionvalue,'') = '' THEN 0 ELSE 1 END AS IsRadioActive  
  , art.IncidentId  
  , inc.IncidentNumber  
  , j.JobNumber  
  , art.NCRNumber  
  , (Select TOP 1 d.DispositionId from ARTDispositions d Where d.AssetRepairTrackId = art.AssetRepairTrackId ORDER by DispositionId DESC) as CurrentDispositionId  
  , (Select TOP 1 d.Status from ARTDispositions d Where d.AssetRepairTrackId = art.AssetRepairTrackId ORDER by DispositionId DESC) as CurrentDispositionStatus  
  , (SELECT TOP 1 CASE WHEN d.Status ='Approved' THEN DispositionDate ELSE NULL END   
    FROM ARTDispositions (NOLOCK) d WHERE d.AssetRepairTrackId = art.AssetRepairTrackId ORDER by DispositionId DESC) [DispositionDate]  
  , art.FromBranchPlant  
  , art.ShipToBranchPlant  
  , art.Status  
  , art.DateClosed  
  , art.PartRepairCost  
  , art.IsAssetFromField  
  , art.IsRedTag  
  , art.AddedBy  
  , art.DateAdded  
  , pftIT.WO_NO AS ITPFTWONumber  
  , art.SRPFTWOId  
  , pftSR.WO_NO AS SRPFTWONumber  
  , i.ProductLine  
  , art.FailureType  
  , slf.OptionLabel AS FailureTypeDisplay  
  , fa.EquipmentStatus  
  , ps.Status as EquipmentStatusDesc  
  , fbp.CompanyName as FromBPCompanyName  
  , sbp.CompanyName as ShipBPCompanyName  
  , c.CustomerName as Client  
  , art.WorkOrderNum  
  , art.NeedsCustomerFeedback  
  , ISNULL(gc.GLProductLineId,1) [GLProductLineId]
FROM dbo.AssetRepairTrack art (NOLOCK)  
LEFT OUTER JOIN ItemNums(NOLOCK) i ON i.ItemNum = art.ItemNum  
LEFT OUTER JOIN ItemNums(NOLOCK) ri ON ri.ItemNum = art.RNItemNum  
LEFT OUTER JOIN Jobs j (NOLOCK) ON art.JobId = j.JobId  
LEFT OUTER JOIN PFTWO pftIT (NOLOCK) ON art.ITPFTWOID = pftIT.PFTWOID  
LEFT OUTER JOIN PFTWO pftSR (NOLOCK) ON art.SRPFTWOID = pftSR.PFTWOID  
LEFT OUTER JOIN SelectOptions sl (NOLOCK) on sl.SelectName = 'AIRTRadioActive' AND sl.optionvalue = ISNULL(ri.ToolCode, i.ToolCode)  
LEFT OUTER JOIN Incidents inc (NOLOCK) on art.IncidentId = inc.IncidentID  
LEFT OUTER JOIN SelectOptions slf (NOLOCK) on slf.optionvalue = art.FailureType and slf.SelectName = 'FailureType'  
LEFT OUTER JOIN FixedAssets fa (NOLOCK) on fa.FixedAssetId = art.FixedAssetId  
LEFT OUTER JOIN PartStatus ps (NOLOCK) on ps.Code = fa.EquipmentStatus  
LEFT OUTER JOIN BranchPlants (NOLOCK) sbp ON sbp.BranchPlant= art.ShipToBranchPlant  
LEFT OUTER JOIN BranchPlants (NOLOCK) fbp ON fbp.BranchPlant= art.FromBranchPlant  
LEFT OUTER JOIN Customers (NOLOCK) c ON c.CustomerId = j.CustomerId 
LEFT OUTER JOIN BusinessUnits (NOLOCK) bu on bu.BusinessUnit = fa.BusinessUnit
LEFT OUTER JOIN GLCodes gc (NOLOCK) ON gc.GLCode = bu.GLCode
GO
ALTER VIEW [dbo].[vwCBMMeterReading] 
AS    
SELECT 
		f.SerialNum, 
		f.InventoryItemNum,
		i.DescShort, 
		LastMeterReadingValue, 
		LifeTimeValue,
		cm.GlobalTrigger,
		ps.Status [EquipmentStatus], 
		f.LastStatusChangeDate,
		b.BranchPlant,
		CompanyName, 
		Region [GeoZone], 
		f1.SerialNum [TopLevelSerialNum],
		i2.DescShort [TopLevelPartDesc], 
		i2.ToolCode,
		i2.ToolPanel,
		a.Operhrs,
		gl.SegmentPL,
		gl.GLProductLineId AS ProductLineId
FROM 
		dbo.CBMCalculatedMeterReadings(NOLOCK) m
		JOIN FixedAssets(NOLOCK) f on f.fixedassetid = m.fixedassetid
		JOIN itemnums(NOLOCK) i on i.itemnum = f.inventoryitemnum
		JOIN BranchPlants(NOLOCK) b on b.branchplant = f.branchplant
		JOIN PartStatus(NOLOCK) ps on ps.Code = f.EquipmentStatus
		JOIN (
				SELECT 
						FixedAssetId, 
						TopLevelFixedAssetId,
						SUM(OperHrs)[Operhrs]
				FROM 
						CBMRunAssetMappings(NOLOCK) cam
				JOIN Runs(NOLOCK) r on r.runid = cam.runid
				GROUP BY fixedassetid, toplevelfixedassetid) a on a.FixedAssetId = m.FixedAssetId
		JOIN FixedAssets(NOLOCK) f1 on f1.FixedAssetId = a.TopLevelFixedAssetId
		JOIN CBMMonitorAssetItemNums(NOLOCK) ca1 on ca1.ItemNum = f1.InventoryItemNum and ca1.IsParent = 1
		JOIN CBMMonitorAssetItemNums(NOLOCK) ca2 on ca2.ItemNum = f.InventoryItemNum and ca2.IsParent = 0
		JOIN CBMMonitor(NOLOCK) cm on cm.CBMMonitorId = ca1.CBMMonitorId and cm.CBMMonitorId = ca2.CBMMonitorId and cm.MeterReadingTypeId = '3'
		JOIN ItemNums(NOLOCK) i2 on i2.ItemNum = f1.InventoryItemNum
		JOIN BusinessUnits (NOLOCK) bu on bu.BusinessUnit = f.BusinessUnit
		JOIN GLCodes(NOLOCK) gl on bu.GLCode = gl.GLCode
WHERE m.MeterReadingTypeId = '3'
GO
