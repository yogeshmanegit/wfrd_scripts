USE [oneviewtest]
GO
/****** Object:  StoredProcedure [dbo].[sp_ImportMyAdvisorFixedAssetData]    Script Date: 3/19/2024 12:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_ImportMyAdvisorFixedAssetData]
   AS  
BEGIN  
   BEGIN TRY  
 SET NOCOUNT ON;  
     
 -- truncate stage table  
 TRUNCATE table StagingFixedAssets;  
   
 INSERT INTO StagingFixedAssets   
 (
	FixedAssetId, SerialNum, InventoryItemNum, AssetNumber, ParentNumber, BranchPlant, EquipmentStatus,   
	RNItemNum, AssetDescription, LastStatusChangeDate, DateDisposed, CurrencyCode, Revision, CatCode16,   
	ToolPanel, ToolCode, DateAdded, BusinessUnit, ThirdItemNumber, AssetLifeRemaining, 
	ProductVersion, [TopLevelFixedAssetId]  
 )
 SELECT DISTINCT  
  FixedAssetId,        
  SUBSTRING(SerialNum,0, 20),        
  InventoryItemNum,          
  AssetNumber,   
  ParentNumber,       
  BranchPlant,           
  EquipmentStatus,           
  RNItemNum,            
  AssetDescription,             
  LastStatusChangeDate,   
  DateDisposed,         
  CurrencyCode,            
  Revision,          
  CatCode16,                  
  SUBSTRING(ToolPanel,0,20),          
  SUBSTRING(ToolCode,0,20),        
  DateAdded,        
  BusinessUnit,        
  ThirdItemNumber,      
  AssetLifeRemaining,      
  
  CAST('<x>' + REPLACE(ThirdItemNumber,'_','</x><x>') + '</x>' AS XML).value('/x[3]','varchar(100)') [Version],
  TopLevelFixedAssetId  
 FROM USDCMAVSQLPD002.AesOps.dbo.vw_FixedAsset_Wireline AS fa WITH (NOLOCK)   
  
 PRINT 'Insert records in StagingFixedAssets table successfully'  
 
 
 -- update tool code and tool panel table
 
 UPDATE S
	SET s.ProductVersion =  RTRIM(LTRIM(AttributeValue))
 FROM StagingFixedAssets s
 JOIN [USDCSCDSQLPD001].[Windchill_Data].[dbo].[ItemAttributes] w on s.InventoryItemNum = w.Item and [AttributeName] ='Product Version'
 WHERE LTRIM(RTRIM(AttributeValue)) NOT IN ('UNSPECIFIED','NOT SPECIFIED', 'DEFAULT') AND LEN(AttributeValue) <= 20
 

 UPDATE S
	SET s.EquipmentDivision = AttributeValue
 FROM StagingFixedAssets s
 JOIN [USDCSCDSQLPD001].[Windchill_Data].[dbo].[ItemAttributes] w on s.InventoryItemNum = w.Item and [AttributeName] ='Equipment Division'
 
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
 --New entries started from 44153  

 INSERT INTO ToolPanelCodeVersion(ID, toolpaneltypeid, toolcodetypeid, version, shortdescription, toolclassid,categorization)  
  
  SELECT  
	  ISNULL((SELECT max(ID)from toolpanelcodeversion), 0) + ROW_NUMBER() over (order by (select null)) [Id],  
	  SFA.ToolPanel,  
	  SFA.ToolCode,  
	  sfa.ProductVersion,  
	  MAX(SFA.AssetDescription) [AssetDescription],   
	  2,
	  1
  
 FROM StagingFixedAssets AS SFA   
 LEFT JOIN ToolPanelCodeVersion TPCV ON TPCV.toolpaneltypeid COLLATE SQL_Latin1_General_CP1_CI_AS = SFA.ToolPanel   
  AND TPCV.ToolCodeTypeId COLLATE SQL_Latin1_General_CP1_CI_AS = SFA.ToolCode  
  AND TPCV.Version COLLATE SQL_Latin1_General_CP1_CI_AS = SFA.ProductVersion   
 WHERE SFA.ToolCode IS NOT NULL   
  AND SFA.ToolPanel IS NOT NULL  
  AND  SFA.ProductVersion IS NOT NULL
  AND TPCV.id IS NULL  
 GROUP BY SFA.ToolPanel, SFA.ToolCode, SFA.ProductVersion   
 ORDER BY SFA.ToolPanel, SFA.ToolCode, SFA.ProductVersion
      
 --update data in asset table  
 --------------------------------------------------------------------------------------------------------  
  
 UPDATE a  
  SET a.toolpanelcodeversionid = tpcv.id,  
   a.toolpaneltypeid = stg.ToolPanel,  
   a.toolcodetypeid = stg.ToolCode,  
   a.[version] = stg.ProductVersion,  
   a.serialnumber = stg.SerialNum,  
   a.description = stg.AssetDescription,  
   a.toolstatusid = CASE WHEN stg.EquipmentStatus in('PT','IN','WK','AV','MB','SB') THEN '1' ELSE '2'  END  
 FROM Assets a  
 JOIN StagingFixedAssets stg on a.jdeitemno = stg.AssetNumber  
 JOIN toolpanelcodeversion tpcv on tpcv.toolpaneltypeid = stg.ToolPanel COLLATE SQL_Latin1_General_CP1_CI_AS  
   AND TPCV.toolcodetypeid = stg.ToolCode  COLLATE SQL_Latin1_General_CP1_CI_AS  
   AND tpcv.[version] = stg.ProductVersion COLLATE SQL_Latin1_General_CP1_CI_AS  
  
   
 PRINT 'Update Asset records successful'  
    
 INSERT INTO Assets   
 (  
  assetID, toolpaneltypeid, toolcodetypeid, version, serialnumber, description, toolstatusid,   
  jdeitemno, toolpanelcodeversionid  
 )  
 SELECT   
  ISNULL((SELECT max(assetID)from assets A) ,0 ) + ROW_NUMBER() over (order by (select null)) [Id],  
  stg.ToolPanel,  
  stg.ToolCode,   
  stg.ProductVersion,  
  stg.SerialNum,  
  stg.AssetDescription,   
  CASE WHEN stg.EquipmentStatus in('PT','IN','WK','AV','MB','SB') THEN '1' ELSE '2'  END,  
  stg.AssetNumber,   
  (SELECT MAX(ID) FROM toolpanelcodeversion tpcv   
   WHERE tpcv.toolpaneltypeid = stg.ToolPanel COLLATE SQL_Latin1_General_CP1_CI_AS  
    AND TPCV.toolcodetypeid = stg.ToolCode  COLLATE SQL_Latin1_General_CP1_CI_AS  
    AND tpcv.[version] = stg.ProductVersion COLLATE SQL_Latin1_General_CP1_CI_AS  
  ) [toolpanelcodeversionid]  
 FROM StagingFixedAssets stg   
 LEFT JOIN Assets a on stg.AssetNumber = a.jdeitemno  
 WHERE a.assetID IS NULL  
  
  PRINT 'Inserted records in Assets'  

  INSERT INTO EquipmentPanelType (equipmentPanelTypeID, [name])
  SELECT distinct toolpaneltypeid, toolpaneltypeid as toolpaneltypeid_name
  FROM toolpanelcodeversion v
  LEFT JOIN EquipmentPanelType e on v.toolpaneltypeid = e.equipmentPanelTypeID
  where e.equipmentPanelTypeID IS NULL
  
  INSERT INTO EquipmentCodeType (equipmentCodeTypeID, [name])
  select distinct toolcodetypeid, toolcodetypeid as toolcodetypeid_name
  from toolpanelcodeversion v
  LEFT JOIN EquipmentCodeType e on v.toolcodetypeid = e.equipmentCodeTypeID
  WHERE e.equipmentCodeTypeID IS NULL

  SET IDENTITY_INSERT EquipmentToolPanelCodeVersion ON;

  INSERT INTO EquipmentToolPanelCodeVersion
  (
	equipmentToolPanelCodeVersionID,
	toolPanelID,
	toolCodeID,
	toolVersionID,
	[description],
	equipmentCategorizationID,
	equipmentToolPanelCodeVersionStatusID
  )
  SELECT t.[id]
      ,t.[toolpaneltypeid]
      ,t.[toolcodetypeid]
      ,t.[version]
      ,cast(t.[description] as NVARCHAR(1000)) as description
      --,cast([shortdescription] as NVARCHAR(1000)) as shortdescription
      ,coalesce(t.[categorization],-1) as categorization
	  ,1 as status
  FROM [dbo].[toolpanelcodeversion] t
  LEFT JOIN EquipmentToolPanelCodeVersion e on e.equipmentToolPanelCodeVersionID = t.id
  WHERE e.equipmentToolPanelCodeVersionID IS NULL

  SET IDENTITY_INSERT EquipmentToolPanelCodeVersion OFF;

  SET IDENTITY_INSERT Equipment ON;

INSERT INTO Equipment
(
	EquipmentID
	, BranchPlantID
	, assetDescription1
	, ParentEquipmentID
	, BusinessUnitID
	, serialNumber
	, dateDisposed
	, equipmentStatusID
	, equipmentToolPanelCodeVersionID
	, GWIS_AssetID
	, ParentGWIS_AssetID
)

select a.assetid
	,coalesce(ol.gwis_locationid,-1) as BranchPlantId
	,stg.AssetDescription as description
	,cast(stg.ParentNumber as int) as ParentNumber
	,coalesce(ol2.gwis_locationid,-1) as BusinessUnitId
	,stg.SerialNum as serialnumber
	,cast(stg.DateDisposed as datetime) as dateDisposed
	,a.toolstatusid
	,ISNULL(a.toolpanelcodeversionid,1) as toolpanelcodeversionid
	,cast(AssetNumber as int) as AssetNumber
	,a2.assetid as topsParentToolId
from assets a
join StagingFixedAssets stg on stg.AssetNumber = a.jdeitemno
left join OperationalLocation ol2 on stg.BusinessUnit = ol2.attrVal and ol2.lvl =6 
left join OperationalLocation ol on stg.BranchPlant = ol.attrVal and ol.lvl =5 and ol2.parentId = ol.gwis_locationid
left join EquipmentStatus fae on stg.EquipmentStatus = fae.[status]
left join assets a2 on a2.jdeitemno = stg.ParentNumber and stg.ParentNumber != '0' and stg.ParentNumber IS NOT NULL
join EquipmentToolPanelCodeVersion c on a.toolpanelcodeversionid = c.equipmentToolPanelCodeVersionID
LEFT JOIN Equipment e on a.assetID = e.EquipmentID
where e.EquipmentID is null
order by a.assetID

SET IDENTITY_INSERT Equipment OFF;

PRINT 'Inserted records in Equipments'  

INSERT INTO Units
( 
	id,
	unitstatusid,
	unittypeid,
	unitdivisionid,
	toolid
)
SELECT 
	a.serialnumber,
	1 as unitstatusid,
	1 as unittypeid,
	1 as unitdivisionid,
	a.assetID as toolid
from assets a
join StagingFixedAssets stg on stg.AssetNumber = a.jdeitemno
left join Units u on a.assetID = u.toolid or u.id = a.serialnumber
WHERE stg.EquipmentDivision = 'UNIT' and u.toolid is null and ISNUMERIC(a.serialnumber) = 1 

PRINT 'Inserted records in Units'  

 COMMIT TRAN  
  
END TRY  
BEGIN CATCH  
  IF (@@TRANCOUNT > 0)  
  BEGIN  
    ROLLBACK  
  END  
  
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
	
	RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
  RETURN  
END CATCH  
  
END
