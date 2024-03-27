--this stored procedure will read azure data factory information and store it in cbm tables
-- for which assets CBM is setup
ALTER PROCEDURE dbo.usp_CBM_OneView_RunAssetMappings
AS

	--find distinct asset numbers
	CREATE TABLE #Assets_Wireline (AssetNumber VARCHAR(30))
	INSERT INTO #Assets_Wireline SELECT distinct AssetNumber FROM AesImport.dbo.OneView_Job_JobOperations_assets_w_duration_for_MyAdvisor

	CREATE TABLE #CbmConfiguration_Wireline 
	(
		AssetNumber VARCHAR(30),
		CbmMonitorId INT,
		FixedAssetId UNIQUEIDENTIFIER,
		ParentFixedAssetId UNIQUEIDENTIFIER,
		TopLevelFixedAssetId UNIQUEIDENTIFIER
	)

	--pull wireline cbm configurations
	INSERT INTO #CbmConfiguration_Wireline
	SELECT childFixedAsset.AssetNumber,
		m.CBMMonitorId,
		childFixedAsset.FixedAssetId,
		childFixedAsset.ParentFixedAssetId,
		childFixedAsset.TopLevelFixedAssetId
	FROM CBMMonitor m (NOLOCK)
	JOIN CBMMonitorAssetItemNums parentPart (NOLOCK) ON m.Active = 1 and m.CBMMonitorId = parentPart.CBMMonitorId and parentPart.IsParent = 1
	JOIN CBMMonitorAssetItemNums childPart (NOLOCK) ON m.CBMMonitorId = childPart.CBMMonitorId and childPart.IsParent = 0
	JOIN FixedAssets parentFixedAsset (NOLOCK) ON parentFixedAsset.InventoryItemNum = parentPart.ItemNum
	JOIN FixedAssets childFixedAsset (NOLOCK) ON parentFixedAsset.TopLevelFixedAssetId = childFixedAsset.TopLevelFixedAssetId and childFixedAsset.InventoryItemNum = childPart.ItemNum
	JOIN #Assets_Wireline wireline_assets ON wireline_assets.AssetNumber = childFixedAsset.AssetNumber

	--save durations in CBM tables
	INSERT INTO [dbo].[OneViewCBMRunAssetMappings] 
	(
		RunId, 
		FixedAssetId,
		CbmMonitorId,
		DurationInMinutes, 
		ImportDate, 
		ParentFixedAssetId, 
		TopLevelFixedAssetId
	)
	SELECT durations.Id, 
		config.FixedAssetId, 
		config.CbmMonitorId,
		durations.DurationInMinutes, 
		durations.DateUploaded, 
		config.ParentFixedAssetId, 
		config.TopLevelFixedAssetId
	FROM #CbmConfiguration_Wireline config
	JOIN AesImport.dbo.OneView_Job_JobOperations_assets_w_duration_for_MyAdvisor durations on config.AssetNumber = durations.AssetNumber
	LEFT JOIN [OneViewCBMRunAssetMappings] runs on durations.Id = runs.RunId and config.CbmMonitorId = runs.CbmMonitorId
	WHERE runs.RunId IS NULL

	DROP TABLE #Assets_Wireline
	DROP TABLE #CbmConfiguration_Wireline

GO

select * from [OneViewCBMRunAssetMappings]