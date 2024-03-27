CREATE VIEW dbo.vw_FixedAsset_Wireline
AS

SELECT fa.FixedAssetId,      
	  fa.SerialNum,      
	  fa.InventoryItemNum,        
	  fa.AssetNumber,        
	  fa.BranchPlant,         
	  fa.EquipmentStatus,         
	  fa.RNItemNum,          
	  ISNULL(i.DescShort, ri.DescShort) AS AssetDescription,           
	  fa.LastStatusChangeDate,          
	  fa.CurrencyCode,          
	  fa.Revision,        
	  fa.CatCode16,                
	  COALESCE(ri.ToolPanel, i.ToolPanel, 'NA') AS ToolPanel,        
	  COALESCE(ri.ToolCode, i.ToolCode, 'NA') AS ToolCode,      
	  fa.DateAdded,      
	  fa.BusinessUnit,      
	  fa.ThirdItemNumber,    
	  fa.AssetLifeRemaining,    
	  COALESCE((SELECT TOP 1 imd.MetaValue FROM dbo.ItemNumMetadata imd (NOLOCK) 
				WHERE imd.ItemNum = fa.InventoryItemNum and imd.MetaName = 'versionInfo'), 
				(SELECT TOP 1 imd.MetaValue FROM dbo.ItemNumMetadata imd (NOLOCK) 
				WHERE imd.ItemNum = fa.RNitemNum and imd.MetaName = 'versionInfo'),
				'NA') AS [Version],
		fa.TopLevelFixedAssetId
  FROM dbo.FixedAssets AS fa (NOLOCK)
  INNER JOIN dbo.businessunits bu (NOLOCK) ON bu.businessunit = fa.businessunit
  INNER JOIN dbo.glcodes g (NOLOCK) ON g.glcode = bu.glcode
  INNER JOIN dbo.partstatus p (NOLOCK) ON p.code = fa.EquipmentStatus
  LEFT JOIN dbo.ItemNums i (NOLOCK) ON i.ItemNum = fa.InventoryItemNum        
  LEFT JOIN dbo.ItemNums ri (NOLOCK) ON ri.ItemNum = fa.RNItemNum
  WHERE fa.majoraccountingclass = '30' 
			AND fa.EquipmentStatus != '50' 
			AND p.IsDisposed = '0' 
			AND g.GLProductLineId = '3' --wireline only
			AND fa.AssetNumber IS NOT NULL