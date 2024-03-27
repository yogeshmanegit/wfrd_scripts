ALTER PROCEDURE [dbo].[sp_ImportMyAdvisorFixedAssetData]      
   AS
BEGIN
   BEGIN TRY
	SET NOCOUNT ON;
   
	-- truncate stage table
	TRUNCATE table StagingFixedAssets;
	
	INSERT INTO StagingFixedAssets 
	(FixedAssetId, SerialNum, InventoryItemNum, AssetNumber, BranchPlant, EquipmentStatus, 
		RNItemNum, AssetDescription, LastStatusChangeDate, CurrencyCode, Revision, CatCode16, 
		ToolPanel, ToolCode, DateAdded, BusinessUnit, ThirdItemNumber, AssetLifeRemaining, Version, [TopLevelFixedAssetId]
	)
	SELECT DISTINCT
		FixedAssetId,      
		SerialNum,      
		InventoryItemNum,        
		AssetNumber,        
		BranchPlant,         
		EquipmentStatus,         
		RNItemNum,          
		AssetDescription,           
		LastStatusChangeDate,          
		CurrencyCode,          
		Revision,        
		CatCode16,                
		SUBSTRING(ToolPanel,0,20),        
		SUBSTRING(ToolCode,0,20),      
		DateAdded,      
		BusinessUnit,      
		ThirdItemNumber,    
		AssetLifeRemaining,    
		SUBSTRING([Version],0,20),
		TopLevelFixedAssetId
	FROM USDCMAVSQLPD002.AesOps.dbo.vw_FixedAsset_Wireline AS fa WITH (NOLOCK) 

	PRINT 'Insert records in StagingFixedAssets table successfully'

	BEGIN TRAN
 
	--update data in asset details table
	--------------------------------------------------------------------------------------------------------
 
	UPDATE AssetDetails
	SET
		AssetDetails.TopLevelFixedAssetId = stg.TopLevelFixedAssetId,
		AssetDetails.AssetNumber = stg.AssetNumber,
		AssetDetails.AssetLifeRemaining = stg.AssetLifeRemaining,
		AssetDetails.LastStatusChangeDate = stg.LastStatusChangeDate
	FROM AssetDetails A 
	INNER JOIN StagingFixedAssets stg
	ON A.FixedAssetId = stg.FixedAssetId
  
	PRINT 'Updated successfully in AssetDetails'   
 
	INSERT INTO AssetDetails (FixedAssetId, TopLevelFixedAssetId, AssetNumber, AssetLifeRemaining, LastStatusChangeDate)
 
	SELECT         
		stg.FixedAssetId,      
		stg.TopLevelFixedAssetId,
		stg.AssetNumber,            
		stg.AssetLifeRemaining,
		stg.LastStatusChangeDate
	FROM StagingFixedAssets stg
	LEFT JOIN AssetDetails details on stg.FixedAssetId = details.FixedAssetId
	WHERE details.FixedAssetId IS NULL

	PRINT 'Insert records in AssetDetails table successfully'
	
	--update data in ToolPanelCodeVersion table
	--------------------------------------------------------------------------------------------------------
 
	INSERT INTO ToolPanelCodeVersion(ID, toolpaneltypeid, toolcodetypeid, version, shortdescription, inserted, updateId, insertId)

    SELECT
		ISNULL((SELECT max(ID)from toolpanelcodeversion), 0) + ROW_NUMBER() over (order by (select null)) [Id],
		SFA.ToolPanel,
		SFA.ToolCode,
		sfa.Version,
		MAX(SFA.AssetDescription) [AssetDescription], 
		0x as inserted,
	   '00000000-0000-0000-0000-000000000000' as updateId,
	   '00000000-0000-0000-0000-000000000000' as insertId

	FROM StagingFixedAssets AS SFA 
	LEFT JOIN ToolPanelCodeVersion TPCV ON TPCV.toolpaneltypeid COLLATE SQL_Latin1_General_CP1_CI_AS = SFA.ToolPanel 
		AND TPCV.ToolCodeTypeId COLLATE SQL_Latin1_General_CP1_CI_AS = SFA.ToolCode
		AND TPCV.Version COLLATE SQL_Latin1_General_CP1_CI_AS = SFA.Version 
	WHERE SFA.ToolCode IS NOT NULL 
		AND SFA.ToolPanel IS NOT NULL 
		AND TPCV.id IS NULL
	GROUP BY SFA.ToolPanel, SFA.ToolCode, SFA.[Version] 
	ORDER BY SFA.ToolPanel, SFA.ToolCode, SFA.[Version] 
	   
	--update data in asset table
	--------------------------------------------------------------------------------------------------------

	UPDATE a
		SET a.toolpanelcodeversionid = tpcv.id,
			a.toolpaneltypeid = stg.ToolPanel,
			a.toolcodetypeid = stg.ToolCode,
			a.[version] = stg.[Version],
			a.serialnumber = stg.SerialNum,
			a.description = stg.AssetDescription,
			a.toolstatusid = CASE WHEN stg.EquipmentStatus in('1S','OR','1X','18') THEN '2' ELSE '1'  END
	FROM Assets a
	JOIN StagingFixedAssets stg on a.jdeitemno = stg.AssetNumber
	JOIN toolpanelcodeversion tpcv on tpcv.toolpaneltypeid = stg.ToolPanel COLLATE SQL_Latin1_General_CP1_CI_AS
			AND TPCV.toolcodetypeid = stg.ToolCode  COLLATE SQL_Latin1_General_CP1_CI_AS
			AND tpcv.[version] = stg.[Version] COLLATE SQL_Latin1_General_CP1_CI_AS

	
	PRINT 'Update Asset records successful'

	INSERT INTO Assets 
	(
		assetID, toolpaneltypeid, toolcodetypeid, version, serialnumber, description, toolstatusid, 
		jdeitemno, inserted, updateId, insertId, toolpanelcodeversionid
	)
	SELECT 
		ISNULL((SELECT max(assetID)from assets A) ,0 ) + ROW_NUMBER() over (order by (select null)) [Id],
		stg.ToolPanel,
		stg.ToolCode, 
		stg.Version,
		stg.SerialNum,
		stg.AssetDescription, 
		CASE WHEN stg.EquipmentStatus in('1S','OR','1X','18') THEN '2' ELSE '1'  END,
		stg.AssetNumber, 
		0x, 
		'00000000-0000-0000-0000-000000000000',
		'00000000-0000-0000-0000-000000000000', 
		(SELECT ID FROM toolpanelcodeversion tpcv 
			WHERE tpcv.toolpaneltypeid = stg.ToolPanel COLLATE SQL_Latin1_General_CP1_CI_AS
				AND TPCV.toolcodetypeid = stg.ToolCode  COLLATE SQL_Latin1_General_CP1_CI_AS
				AND tpcv.[version] = stg.[Version] COLLATE SQL_Latin1_General_CP1_CI_AS
		) [toolpanelcodeversionid]
	FROM StagingFixedAssets stg 
	LEFT JOIN Assets a on stg.AssetNumber = a.jdeitemno
	WHERE a.assetID IS NULL

   PRINT 'Inserted successfully in Assets'

	COMMIT TRAN

END TRY
BEGIN CATCH
  IF (@@TRANCOUNT > 0)
  BEGIN
    ROLLBACK
  END
  DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
  RETURN
END CATCH

END