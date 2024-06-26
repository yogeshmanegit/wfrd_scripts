USE [AesImport]
GO
/****** Object:  StoredProcedure [dbo].[sp_BranchPlantDataFix]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BranchPlantDataFix]
AS
BEGIN

DECLARE @FixedAssetId uniqueidentifier

DECLARE db_cursor CURSOR FOR SELECT f.FixedAssetId 
FROM aesops.dbo.FixedAssets f WITH (NOLOCK)
LEFT JOIN aesops.dbo.PartStatus p  WITH (NOLOCK) on p.Code = f.EquipmentStatus
WHERE BranchPlant is null AND AssetNumber is not null 
AND p.IsDisposed = '0' AND InventoryItemNum is not null AND RNItemNum is not null AND FixedAssetBranchPlant not in ('65893', '150318')

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @FixedAssetId   

WHILE @@FETCH_STATUS = 0   
BEGIN   
	
	DECLARE @sql nvarchar(500);
	DECLARE @ParmDefinition nvarchar(500);

	SET @sql =  N'aesops.dbo.spAuditRecordsGuid @AuditTypeId = @AuditTypeId, -- AUDIT_ACTION_MODIFY
		@UserId = @UserId,
		@ActionDesc = @ActionDesc,
		@RemoteHost = @RemoteHost,
		@KeyId = @KeyId,
		@TableName = @TableName,
		@KeyFieldName = @KeyFieldName,
		@AuditTable = @AuditTable,
		@AuditActionId = @AuditActionId OUTPUT;';
	SET @ParmDefinition = N'@AuditTypeId int, @UserId int, @ActionDesc varchar(1024), @RemoteHost varchar(75), @KeyId uniqueidentifier, @TableName varchar(255), @KeyFieldName varchar(255), @AuditTable varchar(255), @AuditActionId int OUTPUT';
	
	DECLARE @AuditTypeId int = 9106
	, @UserId int = 0
	, @ActionDesc varchar(1024) = 'DATA FIX FOR NULL BRANCHPLANT'
	, @RemoteHost varchar(75)  = null
	, @KeyId uniqueidentifier = @FixedAssetId
	, @TableName varchar(255) = 'FixedAssets'
	, @KeyFieldName varchar(255) = 'FixedAssetId'
	, @AuditTable varchar(255) = 'AuditFixedAssets'
	, @AuditActionId int

	-- Save data to audit table before making any changes
	EXECUTE sp_executesql @sql, 
		@ParmDefinition,
		@AuditTypeId = @AuditTypeId, -- AUDIT_ACTION_MODIFY
		@UserId = @UserId,
		@ActionDesc = @ActionDesc,
		@RemoteHost = @RemoteHost,
		@KeyId = @KeyId,
		@TableName = @TableName,
		@KeyFieldName = @KeyFieldName,
		@AuditTable = @AuditTable,
		@AuditActionId = @AuditActionId OUTPUT;
		
		UPDATE aesops.dbo.FixedAssets  SET BranchPlant = FixedAssetBranchPlant WHERE FixedAssetId = @FixedAssetId
		
       FETCH NEXT FROM db_cursor INTO @FixedAssetId
END   

CLOSE db_cursor   
DEALLOCATE db_cursor

END



GO
/****** Object:  StoredProcedure [dbo].[spImportAllProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImportAllProd]
AS
BEGIN
  SET NOCOUNT ON

  EXEC spImportBranchPlantsProd
  EXEC spImportItemNumsProd
  EXEC spImportAssetsProd
  EXEC spImportInventoryRNItemNumsProd
  EXEC spImportCustomersProd
  EXEC spImportItemCrossReferenceProd
  
  EXEC spImportBillOfMaterialProd
  --EXEC spImportComponentLocatorProd
  
  EXEC spImportWorkOrderHeaderProd
  
  SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[spImportAssetsProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImportAssetsProd]
as
BEGIN

	SET NOCOUNT ON

	TRUNCATE TABLE AesImport.dbo.AssetImport

	INSERT INTO AesImport.dbo.AssetImport
	SELECT LTRIM(RTRIM([Asset_Number]))
		  ,LTRIM(RTRIM([Fixed_Asset_Company]))
		  ,LTRIM(RTRIM([Fixed_Asset_Branch_Plant]))
		  ,LTRIM(RTRIM([Asset_description1]))
		  ,LTRIM(RTRIM([Asset_description2]))  -- old serial number
		  ,LTRIM(RTRIM([Asset_description3]))  -- techid and other stuff
		  ,LTRIM(RTRIM([Parent_Number]))
		  ,LTRIM(RTRIM([Manufacturers_Serial_Number]))
		  ,LTRIM(RTRIM([Business_Unit]))
		  ,case LTRIM(RTRIM([Item_No])) when '.' then null else LTRIM(RTRIM([Item_No])) end
		  ,case LTRIM(RTRIM([Serial_No])) when '.' then null else LTRIM(RTRIM([Serial_No])) end
		  ,[Current_Item_Qty]
		  ,LTRIM(RTRIM([Currency_code]))
		  ,[Cost]
		  ,[Accum_depreciation]
		  ,[Net_Book_Value]
		  ,LTRIM(RTRIM([Product_line_code]))
		  ,LTRIM(RTRIM([Unit_number]))
		  ,[Inventory_part_number]
		  ,LTRIM(RTRIM([Inventory_Item_Branch_Plant]))
		  ,LTRIM(RTRIM([Inventory_Item_Ownership_Code]))
		  ,LTRIM(RTRIM([Lot_Grade]))  -- Revision
		  ,LTRIM(RTRIM([Legacy_part_number]))  -- legacy serial number (SAP)
		  ,LTRIM(RTRIM([AFE_Number]))
		  ,LTRIM(RTRIM([State]))
		  ,LTRIM(RTRIM([Contract_Account]))
		  ,LTRIM(RTRIM([Ownership]))
		  ,[Date_acquired]
		  ,[Life_Months]
		  ,[Start_Depreciation_Date]
		  ,[New_or_used]
		  ,LTRIM(RTRIM([Manufacturer]))
		  ,LTRIM(RTRIM([Model_Year]))
		  ,LTRIM(RTRIM([Third_item_number]))
		  ,[Date_Disposed]
		  ,LTRIM(RTRIM([Equipment_Status]))
		  ,[Fiscal_Year]
		  ,LTRIM(RTRIM([Ledger_Type]))
		  ,LTRIM(RTRIM([Cat_Code_16]))
	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[Asset] Asset
	WHERE Asset.[Cat_Code_16] = 'DIR'

	SET NOCOUNT OFF

END

GO
/****** Object:  StoredProcedure [dbo].[spImportBillOfMaterialProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImportBillOfMaterialProd]
as
BEGIN

	SET NOCOUNT ON

	TRUNCATE TABLE AesImport.dbo.BillOfMaterialImport

	INSERT INTO AesImport.dbo.BillOfMaterialImport
	SELECT [BOM_Type]
      ,[Branch_Plant]
      ,[Parent_Short_Item]
      ,[Parent_Description_1]
      ,[Parent_Description_2]
      ,[Component_Line]
      ,[Item_Number_Short_Component]
      ,[Component_Description_1]
      ,[Component_Description_2]
      ,[Component_Quantity]
      ,[User_Reference]
      ,[FEAT_Percent]
      ,[FEAT]
      ,[Effective_From_Date]
      ,[Effective_Thru_Date]
      ,[Issue_Code]
      ,[Revision]
      ,[Date_Updated]
      ,[Time_of_Day]
   	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[BillOfMaterial] bom

	SET NOCOUNT OFF

END


GO
/****** Object:  StoredProcedure [dbo].[spImportBranchPlantsProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImportBranchPlantsProd]
AS
BEGIN
  SET NOCOUNT ON
  
  TRUNCATE TABLE BranchPlantImport

/*
    select top 100 * From [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0006] F0006CC
    Where F0006CC.MCSTYL in ('CC', 'MF') 
      AND LTRIM(RTRIM(F0006CC.MCMCU)) in ('30392', '12880')
*/

  INSERT INTO AesImport.dbo.BranchPlantImport (BranchPlant,
    BranchPlantCode,
    CompanyName,
    City,
    State,
    Country,
    ZipCode,
    Region,
    IsOps,
    IsManufacturer,
    ProductLine,
    Division,
    Active,
    DateAdded)
Select 
  LTRIM(RTRIM(F0006.MCMCU)) AS BranchPlant,
  LTRIM(RTRIM(F0006.MCDL01)) AS BranchPlantCode,
  LTRIM(RTRIM(F0006.MCDL01)) AS CompanyName,
  LTRIM(RTRIM(F0006.MCRP21)) AS City,
  LTRIM(RTRIM(F0006.MCRP20)) AS State,
  LTRIM(RTRIM(F0006.MCRP19)) AS Country,
  LTRIM(RTRIM(F0116.ALADDZ)) AS ZipCode,
  LTRIM(RTRIM(F0006.MCRP11)) AS Region,
  CASE WHEN LTRIM(RTRIM(F0006.MCSTYL))='BD' THEN 1 ELSE 0 END AS IsOps,
  CASE WHEN LTRIM(RTRIM(F0006.MCSTYL))='BM' THEN 1 ELSE 0 END AS IsManufacturer,
  LTRIM(RTRIM(F0006.MCRP02)) AS ProductLine,
  LTRIM(RTRIM(F0006.MCRP01)) AS Division,
  CASE WHEN LTRIM(RTRIM(F0006.MCSBLI))='I' OR LTRIM(RTRIM(F0006.MCPECC))='N' THEN 0 ELSE 1 END AS Active
  , GETDATE()
From [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0006] F0006
LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0116] F0116 ON convert(varchar(12), F0116.ALAN8) = ltrim(rtrim(F0006.MCMCU))
Where
(   
  LTRIM(RTRIM(F0006.MCMCU)) = '30392' 
  OR LTRIM(RTRIM(F0006.MCMCU)) = '12880'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '119251'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '121135'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '91170'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '113676'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '61852'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '126188'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '80090'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '102804'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '47871'
  OR LTRIM(RTRIM(F0006.MCMCU)) = '117295'
  -- SLS
  OR LTRIM(RTRIM(F0006.MCMCU)) = '51120'
  
  OR LTRIM(RTRIM(F0006.MCMCU)) = '169980'
  
  OR ltrim(rtrim(F0006.MCMCU)) in (
    Select F0006CC.MCRP22 --F0006CC.*, F0005CC.*
    From [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0006] F0006CC
    Where F0006CC.MCSTYL in ('CC', 'MF')
      AND F0006CC.MCRP02 in (
        'DDP'
        ,'DDS'
        ,'DGA'
        ,'DGD'
        ,'DGF'
        ,'DGG'
        ,'DGH'
        ,'DGK'
        ,'DGL'
        ,'DGM'
        ,'DGN'
        ,'DGO'
        ,'DSG'
		,'DNA' -- SL- Mud Logging Services
		,'DNB' -- Auto LOADER
		,'DNC' -- SL- Well Hub
		,'DND' -- SL- Geo Pressure Consulting (P
		,'DNE' -- SL- Wellsite Geologist +DOC (W
		,'DNF' -- SL- GC Tracer
		,'DNG' -- SL- Gas Wizard
		,'DNH' -- SL- EDR
		,'DNI' -- SL - Wellsite Geochemistry
		,'DNZ' -- SL- Other
	) 
  )
)
  AND F0006.MCSTYL in ('BD','BM')

-- can be used for a better name
--LTRIM(RTRIM(F0005BP.DRDL01)) AS BranchPlantName
--Left Join [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] F0005BP ON ltrim(rtrim(F0005BP.DRSY))='00' And ltrim(rtrim(F0005BP.DRRT))='05' And ltrim(rtrim(F0005BP.DRKY)) = ltrim(rtrim(F0006.MCRP05))

  SET NOCOUNT OFF

END


GO
/****** Object:  StoredProcedure [dbo].[spImportComponentLocatorProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImportComponentLocatorProd]
as
BEGIN

	SET NOCOUNT ON

	TRUNCATE TABLE AesImport.dbo.ComponentLocatorImport

	INSERT INTO AesImport.dbo.ComponentLocatorImport
	SELECT 
		[Parent_Short_Item]
      ,[Item_Number_Short_Component]
      ,[Component_Line]
      ,[Locator]
      ,[Date_Updated]
   	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[ComponentLocator] cl

	SET NOCOUNT OFF

END


GO
/****** Object:  StoredProcedure [dbo].[spImportCustomersProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spImportCustomersProd]
AS
BEGIN
  SET NOCOUNT ON
  
  TRUNCATE TABLE AesImport.dbo.CustomerImport

  INSERT INTO AesImport.dbo.CustomerImport ( CustomerNumber
    , CustomerName
    , ParentNumber
    , AddressType
    , BillTo
    , AC02Desc
    , AC03Desc
    , AC04Desc
    , Line0MailName
    , Line1MailName
    , Line2MailName
    , EffectiveDate
    , AddressLine1
    , AddressLine2
    , AddressLine3
    , AddressLine4
    , City
    , State
    , Country
    , County
    , ZipCode
    , A5HOLD
    , A6HOLD )
  SELECT
    CUSTOMER.ABAN8 AS CustomerNumber
    , LTRIM(RTRIM(CUSTOMER.ABALPH)) AS CustomerName
    , NULL AS ParentNumber
  --  , (SELECT MAPA8 FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0150], [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0101]
		--WHERE MAPA8 = ABAN8 AND MAAN8 = CUSTOMER.ABAN8
		--AND (MAAN8 <> 2466503 AND MAPA8 <> 2465843)) AS ParentNumber
    , LTRIM(RTRIM(CUSTOMER.ABAT1)) AS AddressType
    , CUSTOMER.ABAN82 AS BillTo
    , LTRIM(RTRIM(AC02.DRDL01)) AS AC02Desc
    , LTRIM(RTRIM(AC03.DRDL01)) AS AC03Desc
    , LTRIM(RTRIM(AC04.DRDL01)) AS AC04Desc
    , LTRIM(RTRIM(Line0.WWMLNM)) AS Line0MailName
    , LTRIM(RTRIM(Line1.WWMLNM)) AS Line1MailName
    , LTRIM(RTRIM(Line2.WWMLNM)) AS Line2MailName
    --, LTRIM(RTRIM(F0116.[ALAN8]))
    , LTRIM(RTRIM(F0116.[ALEFTB])) AS EffectiveDate
    , LTRIM(RTRIM(F0116.[ALADD1])) AS AddressLine1
    , LTRIM(RTRIM(F0116.[ALADD2])) AS AddressLine2
    , LTRIM(RTRIM(F0116.[ALADD3])) AS AddressLine3
    , LTRIM(RTRIM(F0116.[ALADD4])) AS AddressLine4
    , LTRIM(RTRIM(F0116.[ALCTY1])) AS City
    , LTRIM(RTRIM(F0116.[ALADDS])) AS State
    , LTRIM(RTRIM(F0116.[ALCTR])) AS Country
    , LTRIM(RTRIM(F0116.[ALCOUN])) AS County
    , LTRIM(RTRIM(F0116.[ALADDZ])) AS ZipCode
    , LTRIM(RTRIM(F0301.A5HOLD)) AS A5HOLD
    , LTRIM(RTRIM(F0401.A6HOLD)) AS A6HOLD
  FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0101] CUSTOMER
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] AS AC02 ON (ltrim(rtrim(CUSTOMER.ABAC02))=ltrim(rtrim(AC02.drky)) AND ltrim(rtrim(AC02.DRSY))='01' AND ltrim(rtrim(AC02.DRRT))='02' AND ltrim(rtrim(CUSTOMER.ABAT1))!='CW')
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] AS AC03 ON (ltrim(rtrim(CUSTOMER.ABAC03))=ltrim(rtrim(AC03.drky)) AND ltrim(rtrim(AC03.DRSY))='01' AND ltrim(rtrim(AC03.DRRT))='03' AND ltrim(rtrim(CUSTOMER.ABAT1))!='CW')
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] AS AC04 ON (ltrim(rtrim(CUSTOMER.ABAC04))=ltrim(rtrim(AC04.drky)) AND ltrim(rtrim(AC04.DRSY))='01' AND ltrim(rtrim(AC04.DRRT))='04' AND ltrim(rtrim(CUSTOMER.ABAT1))!='CW')
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0111] AS Line0 ON CUSTOMER.ABAN8=Line0.WWAN8 AND line0.WWIDLN=0
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0111] AS Line1 ON CUSTOMER.ABAN8=Line1.WWAN8 AND line1.WWIDLN=1
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0111] AS Line2 ON CUSTOMER.ABAN8=Line2.WWAN8 AND line2.WWIDLN=2
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0116] ON CUSTOMER.ABAN8=F0116.ALAN8
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0301] ON CUSTOMER.ABAN8=F0301.A5AN8
  LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0401] ON CUSTOMER.ABAN8=F0401.A6AN8
  WHERE 
    LTRIM(RTRIM(CUSTOMER.ABAT1)) IN ('PC','C')

  UPDATE AesImport.dbo.CustomerImport 
  SET ParentNumber = MAPA8
  FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0150]
  WHERE 
    CustomerNumber = MAAN8
	  AND MAPA8 IN (SELECT ABAN8 FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0101])
	  AND (MAAN8 <> 2466503 AND MAPA8 <> 2465843)
      
  SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[spImportInventoryRNItemNumsProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImportInventoryRNItemNumsProd]
as
BEGIN
	SET NOCOUNT ON

	truncate table AesImport.dbo.[InventoryRNItemNumImport]

	INSERT INTO AesImport.dbo.[InventoryRNItemNumImport]
	(
		[From_Item_number]
		  ,[From_Item_Description]
		  ,[To_Item_number]
		  ,[To_Item_Description]
	)
	SELECT 
	  [From_Item_number]
	  ,[From_Item_Description]
	  ,[To_Item_number]
	  ,[To_Item_Description]
	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F5541008]

	SET NOCOUNT OFF
END



GO
/****** Object:  StoredProcedure [dbo].[spImportItemCrossReferenceProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImportItemCrossReferenceProd]
AS
BEGIN
  SET NOCOUNT ON
  
  TRUNCATE TABLE AesImport.dbo.ItemCrossReferenceImport

  INSERT INTO AesImport.dbo.ItemCrossReferenceImport ( 
    [XRT],
	[ITM],
	[EXDJ],
	[EFTJ],
	[CITM],
	[DSC1],
	[DSC2],
	[LITM],
	[AITM]
  )
  SELECT
    [XRT],
	[ITM],
	[EXDJ],
	[EFTJ],
	[CITM],
	[DSC1],
	[DSC2],
	[LITM],
	[AITM]
  FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[ItemCrossReference] ItemCrossReference
      
  SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[spImportItemNumsProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImportItemNumsProd]
as
BEGIN
	SET NOCOUNT ON

	truncate table AesImport.dbo.[ItemNumImport]
	truncate table AesImport.dbo.[ItemBranchAndCostImport]

	INSERT INTO AesImport.dbo.[ItemNumImport]
	(
		[ItemNum]
		,[ItemNum2]
		,[ItemNum3]
		,[DescShort]
		,[PC3]
		,[PC4]
		,[PC5]
		,[PC6]
		,[PC7]
		,[DescDocNum]
		,[Revision]
		,[DefaultUOM]
		,[DefaultSerialProfile]
		,[PartState]
		,[Active]
		,[LastEdit]
		,PC3Desc
		,PC4Desc
		,PC5Desc
		,PC6Desc
		,PC7Desc
		,StockType
		,IMLNTY
	)
	SELECT 
	  convert(varchar(8), f4101.IMITM)
	  ,ltrim(rtrim(f4101.IMLITM))
	  ,ltrim(rtrim(f4101.IMAITM))
	  ,ltrim(rtrim(f4101.IMDSC1)) + IsNull(ltrim(rtrim(f4101.IMDSC2)), '')
	  ,ltrim(rtrim(f4101.IMSRP3))
	  ,ltrim(rtrim(f4101.IMSRP4))
	  ,ltrim(rtrim(f4101.IMSRP5))
	  ,ltrim(rtrim(f4101.IMSRP6))
	  ,ltrim(rtrim(f4101.IMSRP7))
	  ,ltrim(rtrim(f4101.IMDRAW))
	  ,ltrim(rtrim(f4101.IMRVNO))
	  ,ltrim(rtrim(f4101.IMUOM1))
	  , null
	  --, case ltrim(rtrim((select top 1 ibac.Lot_Process_Type from [USPDSQLSHR01].[DSTOPSPRD].[dbo].[ItemBranchAndCost] ibac where f4101.IMITM = ibac.Item_Number)))
	  --  when '4' then 'S' when '5' then 'S' when '6' then 'S' when '7' then 'S' else 'B' end
	  ,ltrim(rtrim(f4101.IMPTSC))
	  , 1
	  , GETDATE()
	  , ltrim(rtrim(s3.DRDL01)) as PC3Desc
	  , ltrim(rtrim(s4.DRDL01)) as PC4Desc
	  , ltrim(rtrim(s5.DRDL01)) as PC5Desc
	  ,NULL --, s6.DRDL01 as PC6Desc
	  , NULL --, s7.DRDL01 as PC7Desc
	  ,ltrim(rtrim(f4101.IMSTKT))
	  ,ltrim(rtrim(f4101.IMLNTY))
	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F4101] f4101
	LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] s3 on s3.DRRT='S3' and ltrim(rtrim(s3.DRKY)) = f4101.IMSRP3
	LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] s4 on s4.DRRT='S4' and ltrim(rtrim(s4.DRKY)) = f4101.IMSRP4
	LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] s5 on s5.DRRT='S5' and ltrim(rtrim(s5.DRKY)) = f4101.IMSRP5
	--LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] s6 on s6.DRRT='S6' and ltrim(rtrim(s6.DRKY)) = f4101.IMSRP6
	--LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] s7 on s7.DRRT='S7' and ltrim(rtrim(s7.DRKY)) = f4101.IMSRP7
	WHERE
	  (
		f4101.IMSRP3 in ('017','003', '010', '009', '075', '016', '025', '057', '052', '016', '044')
		OR f4101.IMSRP4 in ('121', '547', '427', '560')
	  )
	  OR f4101.IMITM in ('1307212', '1306941', '1266580')

	insert into ItemBranchAndCostImport
	(
		[Branch_plant]
	   ,[Item_Number]
	   ,[Second_Item_Number]
	   ,[Third_Item_Number]
	   ,[Make_Buy]
	   ,[Reorder_Point]
	   ,[Maximum_Reorder_Quantity]
	   ,[Minimum_Reorder_Quantity]
	   ,[Safety_Stock]
	   ,[Lot_Status_Code]
	   ,[Lot_Process_Type]
	   ,[GL_Class_Code]
	   ,[Cost_Method]
	   ,[Cost]
	   ,[Date_Added]
	   ,[Date_Changed]
	   ,[Export_Commodity_Control_Number]
	   ,[Harmonized_Tariff_Begin_Digits]
	   ,[Harmonized_Tariff_End_Digits]
	)
	select
		ltrim(rtrim([Branch_plant]))
	   ,convert(varchar(8), [Item_Number])
	   ,ltrim(rtrim([Second_Item_Number]))
	   ,ltrim(rtrim([Third_Item_Number]))
	   ,ltrim(rtrim([Make_Buy]))
	   ,[Reorder_Point]
	   ,[Maximum_Reorder_Quantity]
	   ,[Minimum_Reorder_Quantity]
	   ,[Safety_Stock]
	   ,[Lot_Status_Code]
	   ,[Lot_Process_Type]
	   ,ltrim(rtrim([GL_Class_Code]))
	   ,ltrim(rtrim([Cost_Method]))
	   ,[Cost]
	   ,[Date_Added]
	   ,[Date_Changed]
	   ,ltrim(rtrim([Export_Commodity_Control_Number]))
	   ,ltrim(rtrim([Harmonized_Tariff_Begin_Digits]))
	   ,ltrim(rtrim([Harmonized_Tariff_End_Digits]))
	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[ItemBranchAndCost] ibac
	JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F4101] f4101 on f4101.IMITM = ibac.Item_Number
	--WHERE
	--  ibac.Item_Number in (select ini.ItemNum from ItemNumImport ini where ini.ItemNum = ibac.Item_Number)
	WHERE
	  (
		f4101.IMSRP3 in ('017','003', '010', '009', '075', '016', '025', '057', '052', '016', '044')
		OR f4101.IMSRP4 in ('121', '547', '427', '560')
	  )
	  OR f4101.IMITM in ('1307212', '1306941', '1266580')

	Update AesImport.dbo.ItemNumImport
	set DefaultSerialProfile = case ltrim(rtrim((select top 1 ibac.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac 
	  where ibac.Item_Number = AesImport.dbo.ItemNumImport.ItemNum and ibac.Branch_plant = '30392' )))
		when '0' then 'N' when '4' then 'S' when '5' then 'S' when '6' then 'S' when '7' then 'S' else 'B' end
	where DefaultSerialProfile is null and 
	  (select ibac2.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac2 
	  where AesImport.dbo.ItemNumImport.ItemNum = ibac2.Item_Number and ibac2.Branch_plant = '30392') is not null

	Update AesImport.dbo.ItemNumImport
	set DefaultSerialProfile = case ltrim(rtrim((select top 1 ibac.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac 
	  where ibac.Item_Number = AesImport.dbo.ItemNumImport.ItemNum and ibac.Branch_plant = '61852' )))
		when '0' then 'N' when '4' then 'S' when '5' then 'S' when '6' then 'S' when '7' then 'S' else 'B' end
	where 
	  DefaultSerialProfile is null and 
	  (select ibac2.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac2 
	  where AesImport.dbo.ItemNumImport.ItemNum = ibac2.Item_Number and ibac2.Branch_plant = '61852') is not null

	Update AesImport.dbo.ItemNumImport
	set DefaultSerialProfile = case ltrim(rtrim((select top 1 ibac.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac 
	  where ibac.Item_Number = AesImport.dbo.ItemNumImport.ItemNum and ibac.Branch_plant = '12880' )))
		when '0' then 'N' when '4' then 'S' when '5' then 'S' when '6' then 'S' when '7' then 'S' else 'B' end
	where 
	  DefaultSerialProfile is null and (select ibac2.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac2 
	  where AesImport.dbo.ItemNumImport.ItemNum = ibac2.Item_Number and ibac2.Branch_plant = '12880') is not null

	Update AesImport.dbo.ItemNumImport
	set DefaultSerialProfile = case ltrim(rtrim((select top 1 ibac.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac 
	  where ibac.Item_Number = AesImport.dbo.ItemNumImport.ItemNum and ibac.Branch_plant = '113676' )))
		when '0' then 'N' when '4' then 'S' when '5' then 'S' when '6' then 'S' when '7' then 'S' else 'B' end
	where (select ibac2.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac2 
	  where DefaultSerialProfile is null and AesImport.dbo.ItemNumImport.ItemNum = ibac2.Item_Number and ibac2.Branch_plant = '113676') is not null

	Update AesImport.dbo.ItemNumImport
	set DefaultSerialProfile = case ltrim(rtrim((select top 1 ibac.Lot_Process_Type from AesImport.dbo.ItemBranchAndCostImport ibac where ItemNum = ibac.Item_Number)))
		when '0' then 'N' when '4' then 'S' when '5' then 'S' when '6' then 'S' when '7' then 'S' else 'B' end
	where DefaultSerialProfile is null

/*
	Update AesOps.dbo.ItemNums
	set DefaultSerialProfile = case ltrim(rtrim((select ibac.SerialProfile from ItemNumBranchPlants ibac where AesOps.dbo.ItemNums.ItemNum = ibac.ItemNum and ibac.BranchPlant = '30392')))
		when '4' then 'S' when '5' then 'S' when '6' then 'S' when '7' then 'S' else 'B' end
	where (select ibac2.SerialProfile from ItemNumBranchPlants ibac2 where AesOps.dbo.ItemNums.ItemNum = ibac2.ItemNum and ibac2.BranchPlant = '30392') is not null
*/

/*
	update ItemNums 
	set Revision = (select max(inm.MetaValue) from ItemNumMetadata inm where inm.ItemNum = ItemNums.ItemNum and inm.MetaName = 'versionIdentifer.versionId')
	where 
	  Revision = '' or Revision is null

	delete from AesImport.dbo.ItemNumImport
	where ItemNum not in (select a.Item_Number from AesImport.dbo.ItemBranchAndCostImport a)
*/

	SET NOCOUNT OFF

END

GO
/****** Object:  StoredProcedure [dbo].[spImportWorkOrderHeaderProd]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spImportWorkOrderHeaderProd]
AS

SET NOCOUNT ON

insert into AesImport.dbo.WorkOrderHeader
select *, 0 from [USPDSQLSHR01].[DSTOPSPRD].[dbo].WorkOrderHeader
where Super_Category = '003'
  and Work_Order_Number not in (select Work_Order_Number from AesImport.dbo.WorkOrderHeader)

SET NOCOUNT OFF

GO
/****** Object:  StoredProcedure [dbo].[spProcessAll]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spProcessAll]
AS
BEGIN
  SET NOCOUNT ON

  EXEC spProcessBranchPlant
  EXEC spProcessItemNums
  EXEC spProcessAssets
  EXEC spProcessInventoryRNItemNums
  EXEC spProcessCustomers
  EXEC spProcessItemCrossReference
  
  EXEC spProcessWorkOrderHeader
  
  EXEC spProcessFixedAssetSnapshots

  -- DO NOT RUN every night
  --EXEC spProcessBillOfMaterial
  --EXEC spProcessComponentLocatorImport
  
  EXEC sp_BranchPlantDataFix

  SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[spProcessAssets]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spProcessAssets]
AS
BEGIN
  SET NOCOUNT ON

declare @todayDate datetime
set @todayDate = GETDATE()

-- TODO: AssetWarnings
--   BranchPlant, EquipmentStatus, InventoryItemNum, RNItemNum, SerialNum
/*
-- TODO: validate children in same BP as parent
insert into AssetWarnings ()
select 
from AesOps.dbo.FixedAssets fa
join AesOps.dbo.FixedAssets fa2 on fa.ParentFixedAssetId = fa2.FixedAssetId
where fa.BranchPlant <> fa2.BranchPlant
*/

insert into AssetWarnings (FixedAssetId, WarningMsg, OldBranchPlant, NewBranchPlant, DateAdded, IsProcessed)
(
SELECT fa.FixedAssetId, 'Different BP', fa.BranchPlant, ai.InventoryItemBranchPlant, @todayDate, 0
FROM AesImport.dbo.AssetImport ai
JOIN [AesOps].[dbo].[FixedAssets] fa on fa.[AssetNumber] = ai.[Asset_Number]
WHERE IsNull(fa.BranchPlant, '') <> IsNull(ai.InventoryItemBranchPlant, '')
)

insert into AssetWarnings (FixedAssetId, WarningMsg, OldEquipmentStatus, NewEquipmentStatus, DateAdded, IsProcessed)
(
SELECT fa.FixedAssetId, 'Different ES', fa.EquipmentStatus, ai.Equipment_Status, @todayDate, 0
FROM AesImport.dbo.AssetImport ai
JOIN [AesOps].[dbo].[FixedAssets] fa on fa.[AssetNumber] = ai.[Asset_Number]
WHERE IsNull(fa.EquipmentStatus, '') <> IsNull(ai.Equipment_Status, '')
)

insert into AssetWarnings (FixedAssetId, WarningMsg, OldSerialNum, NewSerialNum, DateAdded, IsProcessed)
(
SELECT fa.FixedAssetId, 'Different SN', fa.SerialNum, ai.Serial_No, @todayDate, 0
FROM AesImport.dbo.AssetImport ai
JOIN [AesOps].[dbo].[FixedAssets] fa on fa.[AssetNumber] = ai.[Asset_Number]
WHERE IsNull(fa.SerialNum, '') <> IsNull(ai.Serial_No, '')
)

insert into AssetWarnings (FixedAssetId, WarningMsg, DateAdded, IsProcessed)
(
SELECT fa.FixedAssetId, 'No longer mapped in MA', @todayDate, 0
FROM [AesOps].[dbo].[FixedAssets] fa
LEFT JOIN AesImport.dbo.AssetImport ai on ai.[Asset_Number] = fa.[AssetNumber]
WHERE fa.[AssetNumber] is not null and ai.[Asset_Number] is null
)

UPDATE AesOps.dbo.FixedAssets
set LastStatusChangeDate = @todayDate
where FixedAssetId in (
	SELECT fa.FixedAssetId
	FROM AesImport.dbo.AssetImport ai WITH (NOLOCK) 
	JOIN [AesOps].[dbo].[FixedAssets] fa WITH (NOLOCK) on fa.[AssetNumber] = ai.[Asset_Number]
	WHERE IsNull(fa.BranchPlant, '') <> IsNull(ai.InventoryItemBranchPlant, '')
)

UPDATE AesOps.dbo.FixedAssets
set LastStatusChangeDate = @todayDate
where FixedAssetId in (
	SELECT fa.FixedAssetId
	FROM AesImport.dbo.AssetImport ai WITH (NOLOCK) 
	JOIN [AesOps].[dbo].[FixedAssets] fa WITH (NOLOCK) on fa.[AssetNumber] = ai.[Asset_Number]
	WHERE IsNull(fa.EquipmentStatus, '') <> IsNull(ai.Equipment_Status, '')
)

UPDATE AesOps.dbo.FixedAssets
set EquipmentStatus = 'NA'
	, LastStatusChangeDate = @todayDate
where FixedAssetId in (
	SELECT fa.FixedAssetId
	FROM [AesOps].[dbo].[FixedAssets] fa WITH (NOLOCK) 
	LEFT JOIN AesImport.dbo.AssetImport ai WITH (NOLOCK) on ai.[Asset_Number] = fa.[AssetNumber]
	WHERE fa.[AssetNumber] is not null and ai.[Asset_Number] is null
)

DECLARE @assetNumber VARCHAR(30)
DECLARE @branchPlant VARCHAR(75)
DECLARE @fixedAssetId uniqueidentifier

DECLARE db_cursor1 CURSOR FOR  
SELECT fa.FixedAssetId, fa.AssetNumber, ai.InventoryItemBranchPlant
FROM AesImport.dbo.AssetImport ai WITH (NOLOCK) 
JOIN [AesOps].[dbo].[FixedAssets] fa WITH (NOLOCK) on fa.[AssetNumber] = ai.[Asset_Number]
WHERE IsNull(fa.BranchPlant, '') <> IsNull(ai.InventoryItemBranchPlant, '')
--  and fa.EquipmentStatus <> 'IN'

OPEN db_cursor1   
FETCH NEXT FROM db_cursor1 INTO @fixedAssetId, @assetNumber, @branchPlant

WHILE @@FETCH_STATUS = 0   
BEGIN   
  --select @assetNumber, @branchPlant
  insert into AesOps.dbo.PartTransferDtl (FixedAssetId, AssetNumber, DocumentType, InventoryItemNum, RNItemNum, SerialNum, Revision, Quantity, AssetStatus, DateShipConfirmed
    , UserCreatedDocument, SendingLocation, ReceivingLocation, DateofTransaction, OwnershipCode, DateAdded, ParentNumber)
  select FixedAssetId, AssetNumber, 'JDE', InventoryItemNum, RNItemNum, SerialNum, Revision, CurrentItemQty, EquipmentStatus, @todayDate
    , 'JDE', BranchPlant, @branchPlant, @todayDate, Ownership, @todayDate, ParentNumber
  from AesOps.dbo.FixedAssets fa2 WITH (NOLOCK) where fa2.AssetNumber = @assetNumber		
		
  exec AesOps.dbo.usp_TransferChildComponents @fixedAssetId, @branchPlant
  update AesOps.dbo.FixedAssets set BranchPlant = @branchPlant where FixedAssetId = @fixedAssetId

  FETCH NEXT FROM db_cursor1 INTO @fixedAssetId, @assetNumber, @branchPlant
END

CLOSE db_cursor1   
DEALLOCATE db_cursor1

	UPDATE [AesOps].[dbo].[FixedAssets]
	  SET [Company] = ai.[FixedAssetCompany]
--	  ,[BranchPlant] = ai.[InventoryItemBranchPlant]
	  ,[FixedAssetBranchPlant] = ai.[FixedAssetBranch_Plant]
	  ,[AssetDescription] = ai.[Asset_description1]
	  ,[ParentNumber] = ai.[Parent_Number]
	  ,[ManufacturersSerialNumber] = ai.[Manufacturers_Serial_Number]
	  ,[BusinessUnit] = ai.[Business_Unit]
	  ,[RNItemNum] = ai.[Item_No]
	  ,[SerialNum] = ai.Serial_No
	  ,[CurrentItemQty] = ai.[Current_Item_Qty]
	  ,[CurrencyCode] = ai.[Currency_Code]
	  ,[Cost] = ai.[Cost]
	  ,[AccumDepreciation] = ai.[Accum_Depreciation]
	  ,[NetBookValue] = ai.[Net_Book_Value]
	  ,[ProductLineCode] = ai.[Product_Line_Code]
	  ,[UnitNumber] = ai.[Unit_Number]
	  ,[InventoryItemNum] = case convert(varchar(30), ai.[Inventory_Part_Number])
		when NULL then [InventoryItemNum] 
		when '0' then [InventoryItemNum] 
		else convert(varchar(30), ai.[Inventory_Part_Number]) end
	  ,[LegacySerialNumber] = ai.[Legacy_Part_Number]
	  ,[AFENumber] = ai.[AFE_Number]
	  ,[State] = ai.[State]
	  ,[ContractAccount] = ai.[Contract_Account]
	  ,[Ownership] = ai.[Ownership]
	  ,[DateAcquired] = ai.[Date_Acquired]
	  ,[LifeMonths] = ai.[Life_Months]
	  ,[StartDepreciation_Date] = ai.[Start_Depreciation_Date]
	  ,[NewUsed] = ai.[New_or_Used]
	  ,[Manufacturer] = ai.[Manufacturer]
	  ,[ModelYear] = ai.[Model_Year]
	  ,[ThirdItemNumber] = ai.[Third_Item_Number]
	  ,[DateDisposed] = ai.[Date_Disposed]
	  ,[EquipmentStatus] = ai.[Equipment_Status]
	  ,[FiscalYear] = ai.[Fiscal_Year]
	  ,[LedgerType] = ai.[Ledger_Type]
	  ,Revision = ai.Lot_Grade
	  ,[CatCode16] = ai.[Cat_Code_16]
	FROM AesImport.dbo.AssetImport ai WITH (NOLOCK)
	WHERE [AesOps].[dbo].[FixedAssets].[AssetNumber] = ai.[Asset_Number]

	TRUNCATE TABLE [AesImport].[dbo].[FixedAssetsStaging]

	print 'here1'
	
	INSERT INTO [AesImport].[dbo].[FixedAssetsStaging] (
		[FixedAssetId]
		,[Asset_Number]
		,[FixedAssetCompany]
		,[InventoryItemBranchPlant]
		,FixedAssetBranch_Plant
		,[Asset_description1]
		,[Parent_Number]
		,[Manufacturers_Serial_Number]
		,[Business_Unit]
		,[Item_No]
		,Serial_No
		,[Current_Item_Qty]
		,[Currency_code]
		,[Cost]
		,[Accum_depreciation]
		,[Net_Book_Value]
		,[Product_line_code]
		,[Unit_number]
		,[Inventory_part_number]
		,[Legacy_part_number]
		,[AFE_Number]
		,[State]
		,[Contract_Account]
		,[Ownership]
		,[Date_acquired]
		,[Life_Months]
		,[Start_Depreciation_Date]
		,[New_or_used]
		,[Manufacturer]
		,[Model_Year]
		,[Third_item_number]
		,[Date_Disposed]
		,[Equipment_Status]
		,[Fiscal_Year]
		,[Ledger_Type]
		,Lot_Grade
		,[Cat_Code_16]
	)
	SELECT
		NEWID()
		,ai.[Asset_Number]
		,ai.[FixedAssetCompany]
		,ai.[InventoryItemBranchPlant]
		,ai.FixedAssetBranch_Plant
		,ai.[Asset_description1]
		,ai.[Parent_Number]
		,ai.[Manufacturers_Serial_Number]
		,ai.[Business_Unit]
		,ai.[Item_No]
		,ai.Serial_No
		,ai.[Current_Item_Qty]
		,ai.[Currency_code]
		,ai.[Cost]
		,ai.[Accum_depreciation]
		,ai.[Net_Book_Value]
		,ai.[Product_line_code]
		,ai.[Unit_number]
		,ai.[Inventory_part_number]
		,ai.[Legacy_part_number]
		,ai.[AFE_Number]
		,ai.[State]
		,ai.[Contract_Account]
		,ai.[Ownership]
		,ai.[Date_acquired]
		,ai.[Life_Months]
		,ai.[Start_Depreciation_Date]
		,ai.[New_or_used]
		,ai.[Manufacturer]
		,ai.[Model_Year]
		,ai.[Third_item_number]
		,ai.[Date_Disposed]
		,ai.[Equipment_Status]
		,ai.[Fiscal_Year]
		,ai.[Ledger_Type]
		,ai.Lot_Grade
		,ai.[Cat_Code_16]
	FROM [AesImport].[dbo].[AssetImport] ai  WITH (NOLOCK)
		left join [AesOps].[dbo].[FixedAssets] fa  WITH (NOLOCK) on fa.AssetNumber = ai.Asset_Number
	where fa.FixedAssetId is null

	print 'here2'
			
	DECLARE @inventoryItemNum numeric(8,0)
		, @serialNum varchar(30)
		, @newFixedAssetId uniqueidentifier
		, @faCount int
		
	print 'here3'

	DECLARE db_cursor2 CURSOR FOR  
	SELECT fas.FixedAssetId, fas.Inventory_part_number, fas.Serial_No
	FROM AesImport.dbo.FixedAssetsStaging fas

	print 'here4'
			
	OPEN db_cursor2   
	FETCH NEXT FROM db_cursor2 INTO @newFixedAssetId, @inventoryItemNum, @serialNum

	print 'here5'

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
--		print @serialnum

		set @faCount = 0
		select @faCount = COUNT(1)
		from [AesOps].dbo.FixedAssets WITH (NOLOCK)
		where SerialNum = @serialNum and InventoryItemNum = convert(varchar(30), @inventoryItemNum)
		
		if @faCount = 0
		begin
			--print @serialnum
			
			INSERT INTO [AesOps].[dbo].[FixedAssets] (
			  [FixedAssetId]
			  ,[AssetNumber]
			  ,[Company]
			  ,[BranchPlant]
			  ,FixedAssetBranchPlant
			  ,[AssetDescription]
			  ,[ParentNumber]
			  ,[ManufacturersSerialNumber]
			  ,[BusinessUnit]
			  ,[RNItemNum]
			  ,[SerialNum]
			  ,[CurrentItemQty]
			  ,[CurrencyCode]
			  ,[Cost]
			  ,[AccumDepreciation]
			  ,[NetBookValue]
			  ,[ProductLineCode]
			  ,[UnitNumber]
			  ,[InventoryItemNum]
			  ,[LegacySerialNumber]
			  ,[AFENumber]
			  ,[State]
			  ,[ContractAccount]
			  ,[Ownership]
			  ,[DateAcquired]
			  ,[LifeMonths]
			  ,[StartDepreciation_Date]
			  ,[NewUsed]
			  ,[Manufacturer]
			  ,[ModelYear]
			  ,[ThirdItemNumber]
			  ,[DateDisposed]
			  ,[EquipmentStatus]
			  ,[FiscalYear]
			  ,[LedgerType]
			  ,Revision
			  ,[CatCode16]
			  ,LastStatusChangeDate
			  ,DateAdded
			  ,Source
			)
			SELECT
				[FixedAssetId]
				,[Asset_Number]
				,[FixedAssetCompany]
				,[InventoryItemBranchPlant]
				,FixedAssetBranch_Plant
				,[Asset_description1]
				,[Parent_Number]
				,[Manufacturers_Serial_Number]
				,[Business_Unit]
				,[Item_No]
				,Serial_No
				,[Current_Item_Qty]
				,[Currency_code]
				,[Cost]
				,[Accum_depreciation]
				,[Net_Book_Value]
				,[Product_line_code]
				,[Unit_number]
				,[Inventory_part_number]
				,[Legacy_part_number]
				,[AFE_Number]
				,[State]
				,[Contract_Account]
				,[Ownership]
				,[Date_acquired]
				,[Life_Months]
				,[Start_Depreciation_Date]
				,[New_or_used]
				,[Manufacturer]
				,[Model_Year]
				,[Third_item_number]
				,[Date_Disposed]
				,[Equipment_Status]
				,[Fiscal_Year]
				,[Ledger_Type]
				,Lot_Grade
				,[Cat_Code_16]
				,@todayDate
				,@todayDate
				,'JDEETL'
			from FixedAssetsStaging  WITH (NOLOCK)
			where FixedAssetId = @newFixedAssetId

		end
		else if @faCount = 1
		begin
			--print @serialnum

			UPDATE fa
			SET fa.[Company] = fas.[FixedAssetCompany]
				, fa.AssetNumber = fas.Asset_Number
				--, fa.[BranchPlant] = fas.[InventoryItemBranchPlant]
				, fa.[FixedAssetBranchPlant] = fas.[FixedAssetBranch_Plant]
				, fa.[AssetDescription] = fas.[Asset_description1]
				, fa.[ParentNumber] = fas.[Parent_Number]
				, fa.[ManufacturersSerialNumber] = fas.[Manufacturers_Serial_Number]
				, fa.[BusinessUnit] = fas.[Business_Unit]
				, fa.[RNItemNum] = fas.[Item_No]
				, fa.[SerialNum] = fas.[Serial_No]
				, fa.[CurrentItemQty] = fas.[Current_Item_Qty]
				, fa.[CurrencyCode] = fas.[Currency_Code]
				, fa.[Cost] = fas.[Cost]
				, fa.[AccumDepreciation] = fas.[Accum_Depreciation]
				, fa.[NetBookValue] = fas.[Net_Book_Value]
				, fa.[ProductLineCode] = fas.[Product_Line_Code]
				, fa.[UnitNumber] = fas.[Unit_Number]
				, fa.[InventoryItemNum] = fas.[Inventory_Part_Number]
				, fa.[LegacySerialNumber] = fas.[Legacy_Part_Number]
				, fa.[AFENumber] = fas.[AFE_Number]
				, fa.[State] = fas.[State]
				, fa.[ContractAccount] = fas.[Contract_Account]
				, fa.[Ownership] = fas.[Ownership]
				, fa.[DateAcquired] = fas.[Date_Acquired]
				, fa.[LifeMonths] = fas.[Life_Months]
				, fa.[StartDepreciation_Date] = fas.[Start_Depreciation_Date]
				, fa.[NewUsed] = fas.[New_or_Used]
				, fa.[Manufacturer] = fas.[Manufacturer]
				, fa.[ModelYear] = fas.[Model_Year]
				, fa.[ThirdItemNumber] = fas.[Third_Item_Number]
				, fa.[DateDisposed] = fas.[Date_Disposed]
				, fa.[EquipmentStatus] = fas.[Equipment_Status]
				, fa.[FiscalYear] = fas.[Fiscal_Year]
				, fa.[LedgerType] = fas.[Ledger_Type]
				, fa.Revision = fas.[Lot_Grade]
				, fa.[CatCode16] = fas.[Cat_Code_16]
				, fa.[LastEdit] = @todayDate
			FROM [AesOps].dbo.[FixedAssets] fa
				join AesImport.dbo.FixedAssetsStaging fas  WITH (NOLOCK) on CONVERT(VARCHAR(MAX),fas.Inventory_Part_Number) = fa.InventoryItemNum 
					and fas.Serial_No = fa.SerialNum
			WHERE fas.FixedAssetId = @newFixedAssetId	
		end
		else
		begin
			insert into AesImport.dbo.AssetWarnings (FixedAssetId, WarningMsg, OldInventoryItemNum, OldSerialNum, DateAdded, IsProcessed)
			select FixedAssetId, 'Duplicate IN/SN (ETL)', InventoryItemNum, SerialNum, @todayDate, 0
			from [AesOps].dbo.[FixedAssets]  WITH (NOLOCK)
			where InventoryItemNum = @inventoryItemNum 
				and SerialNum = @serialNum 
		end
		
		FETCH NEXT FROM db_cursor2 INTO  @newFixedAssetId, @inventoryItemNum, @serialNum
	END
	
	CLOSE db_cursor2 
	DEALLOCATE db_cursor2

    --WHERE 
    --  (SELECT fa1.[AssetNumber] FROM [AesOps].[dbo].[FixedAssets] fa1 where ai.Asset_Number = fa1.AssetNumber) is null

	--update AesOps.dbo.FixedAssets
	--set ParentFixedAssetId = (select fa1.FixedAssetId from AesOps.dbo.FixedAssets fa1 where fa1.AssetNumber = ParentNumber)
	--where
	--  AssetNumber <> ParentNumber
	print 'here6'

	UPDATE fa
	Set fa.ParentFixedAssetId = (Select fa1.FixedAssetId From AesOps.dbo.FixedAssets fa1 Where fa1.AssetNumber = fa.ParentNumber)
	FROM AesOps.dbo.FixedAssets fa
	where 
	  fa.AssetNumber is not null 
	  --and fa.ParentFixedAssetId is null 
	  and fa.ParentNumber is not null 
	  and fa.ParentNumber <> '' 
	  and fa.AssetNumber <> fa.ParentNumber
--	  and fa.Source = 'JDEETL'

	print 'here7'
	
	UPDATE fa
	Set fa.ParentFixedAssetId = NULL
	FROM AesOps.dbo.FixedAssets fa
	where 
	  fa.AssetNumber is not null 
	  --and fa.ParentFixedAssetId is null 
	  and fa.ParentNumber is not null 
	  and fa.ParentNumber <> '' 
	  and fa.AssetNumber = fa.ParentNumber
	  and fa.ParentFixedAssetId is not null
--	  and fa.Source = 'JDEETL'

	print 'here8'

	Update fa
	 Set TopLevelFixedAssetId = (Select top 1 FixedAssetId from AesOps.dbo.fnGetTopMostParent(fa.FixedAssetId))
	From AesOps.dbo.FixedAssets fa
	Where fa.ParentFixedAssetId IS NOT NULL

	print 'here9'

	UPDATE AesOps.dbo.FixedAssets
	SET LastStatusChangeDate = 
	(SELECT TOP 1 ptd.DateAdded FROM AesOps.dbo.PartTransferDtl ptd WITH (NOLOCK) WHERE ptd.FixedAssetId = FixedAssets.FixedAssetId ORDER BY ptd.DateAdded DESC)
	WHERE EXISTS
	(SELECT TOP 1 ptd.DateAdded FROM AesOps.dbo.PartTransferDtl ptd WITH (NOLOCK) WHERE ptd.FixedAssetId = FixedAssets.FixedAssetId ORDER BY ptd.DateAdded DESC)
	  AND LastStatusChangeDate IS NULL
	  And AssetNumber is not null 
	  AND LastStatusChangeDate <> (SELECT TOP 1 ptd.DateAdded FROM AesOps.dbo.PartTransferDtl ptd WITH (NOLOCK) WHERE ptd.FixedAssetId = FixedAssets.FixedAssetId ORDER BY ptd.DateAdded DESC)

	print 'here10'

	UPDATE AesOps.dbo.FixedAssets
	SET LastStatusChangeDate = ISNULL(LastEdit, DateAdded)
	WHERE LastStatusChangeDate IS NULL
	  And AssetNumber is not null
	  And LastStatusChangeDate <> ISNULL(LastEdit, DateAdded)

	SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[spProcessBillOfMaterial]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spProcessBillOfMaterial]
AS
BEGIN
  SET NOCOUNT ON

	SET NOCOUNT ON

	insert into AesOps.dbo.ItemNumConfigs (
		[BranchPlant]
       ,[LineNum]
       ,[ItemNum]
       ,[ParentItemNum]
       ,[OptionText]
       ,[ECNNumber]
       ,[LastDateModified]
       ,[LastUserModified]
       ,[Qty]
       ,[Reference]
       ,[EffectiveFromDate]
       ,[EffectiveThruDate]
       ,[IsRequired]
       ,[ItemLevel]
       ,[IsToolString]
       ,[ToolSizeID]
       ,[IsActive]
       ,[IsMandatoryReplacement])
	select
	  NULL
	  , Component_Line
	  , CONVERT(varchar(50), Item_Number_Short_Component)
	  , CONVERT(varchar(50), Parent_Short_Item)
	  , LTRIM(RTRIM(User_Reference))
	  , NULL
	  , Date_Updated
	  , NULL
	  , CONVERT(int, Component_Quantity)
	  , NULL -- TODO:
	  , Effective_From_Date
	  , Effective_Thru_Date
	  , 0 -- 
	  , NULL
	  , 0
	  , NULL
	  , 1
	  , 0
	from AesImport.dbo.BillOfMaterialImport bm
	left join AesOps.dbo.ItemNumConfigs b on convert(varchar(20), bm.Parent_Short_Item) = b.ParentItemNum
	where b.ItemNumConfigId is null

/*	update AesOps.dbo.ItemNumConfigs
	set IsRequired = 1
	where 
	  Qty > 0 
	  and OptionText <> 'OPTIONAL' 
	  and OptionText <> 'AR'
	  and OptionText <> 'REF'
	  and (OptionText like '%1' or OptionText = '')
*/	  
	SET NOCOUNT OFF

END

GO
/****** Object:  StoredProcedure [dbo].[spProcessBranchPlant]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spProcessBranchPlant]
AS
BEGIN
  SET NOCOUNT ON

  UPDATE AesOps.dbo.BranchPlants
  SET MCDL01 = bpi.BranchPlantCode,
	  City = bpi.City,
	  StateProvince = bpi.State,
	  Country = IsNull(bpi.Country, AesOps.dbo.BranchPlants.Country),
	  Region = IsNull(bpi.Region, AesOps.dbo.BranchPlants.Region),
	  ZipCode = CASE WHEN LEN(bpi.ZipCode) <=  10 THEN bpi.ZipCode else SUBSTRING(bpi.ZipCode, LEN(bpi.ZipCode) -  9, 10) end,
	  --IsOps = bpi.IsOps,
	  --IsManufacturing = bpi.IsManufacturer,
	  Active = bpi.Active
  FROM BranchPlantImport bpi WITH (NOLOCK)
  WHERE AesOps.dbo.BranchPlants.BranchPlant = bpi.BranchPlant


  INSERT INTO AesOps.dbo.BranchPlants (BranchPlantId, BranchPlant, MCDL01, CompanyName, City, StateProvince, 
    Country, Region, ZipCode, IsOps, IsManufacturing, IsRepair, IsGlobalRepair, Active, DateAdded, LastEdit)
  SELECT NEWID(), BranchPlant, BranchPlantCode, CompanyName, City, State, 
    Country, Region, 
	CASE WHEN LEN(ZipCode) <=  10 THEN ZipCode else SUBSTRING(ZipCode, LEN(ZipCode) -  9, 10) end [ZipCode],
	 IsOps, IsManufacturer, 0, 0, Active, GETDATE(), GETDATE()
  FROM BranchPlantImport WITH (NOLOCK)
  WHERE BranchPlant NOT IN (SELECT BranchPlant FROM AesOps.dbo.BranchPlants)
  
  update AesOps.dbo.BranchPlants 
  set Country ='RU', Region='CIS'
  where BranchPlant in ('121135', '91170', '126188', '47871')
  and (Country = '' or Country is null)

  update AesOps.dbo.BranchPlants 
  set Region ='CA'
  where BranchPlant in ('11524')
  and (Region = '' or Region is null)
  
  update AesOps.dbo.BranchPlants 
  set Region ='US'
  where BranchPlant in ('101988', '100357')
  and (Region = '' or Region is null)
  
  update AesOps.dbo.BranchPlants
  set Hemisphere = (select r.Hemisphere from AesOps.dbo.Regions r WITH (NOLOCK) where r.Region = BranchPlants.Region)
  where Hemisphere is null

	update AesOps.dbo.BranchPlants
	set Active = 1
	where IsNonLiveLocation = 1
	  and Active = 0 

	update AesOps.dbo.BranchPlants
	set Region = 'LAO'
	where Region = 'MX'

/*
update Regions set Region='US' where Region='North America USA'
update Regions set Region='CA' where Region='North America Canada'

update Regions set Region='ME' where Region='Middle East North Africa'
update Regions set Region='WAF' where Region='SSA (Sub-Saharan Africa)'
update Regions set Region='CIS' where Region='Russia'
update Regions set Region='LAO' where Region='Latin America'
update Regions set Region='EU' where Region='Europe'
update Regions set Region='AP' where Region='Asia Pacific'
*/

/*
update Countries set RegionCode='US' where RegionCode ='North America USA'
update Countries set RegionCode='WAF' where RegionCode='SSA (Sub-Saharan Africa)'
update Countries set RegionCode='CIS' where RegionCode='Russia'
update Countries set RegionCode='CA' where RegionCode='North America Canada'
update Countries set RegionCode='ME' where RegionCode='Middle East North Africa'
update Countries set RegionCode='LAO' where RegionCode='Latin America'
update Countries set RegionCode='EU' where RegionCode='Europe'
update Countries set RegionCode='AP' where RegionCode='Asia Pacific'
*/

  SET NOCOUNT OFF

END

GO
/****** Object:  StoredProcedure [dbo].[spProcessComponentLocatorImport]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spProcessComponentLocatorImport]
AS
BEGIN
  SET NOCOUNT ON

	SET NOCOUNT ON

	

	SET NOCOUNT OFF

END

GO
/****** Object:  StoredProcedure [dbo].[spProcessCustomers]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spProcessCustomers]
AS
BEGIN
  SET NOCOUNT ON

  UPDATE AesOps.dbo.Customers 
  SET CustomerName = ci.CustomerName
      , AddressType = ci.AddressType
      , ParentNumber = ci.ParentNumber
      , BillTo = ci.BillTo
      , AC02Desc = ci.AC02Desc
      , AC03Desc = ci.AC03Desc
      , AC04Desc = ci.AC04Desc
      , Line0MailName = ci.Line0MailName
      , Line1MailName = ci.Line1MailName
      , Line2MailName = ci.Line2MailName
      , EffectiveDate = ci.EffectiveDate
      , AddressLine1 = ci.AddressLine1
      , AddressLine2 = ci.AddressLine2
      , AddressLine3 = ci.AddressLine3
      , AddressLine4 = ci.AddressLine4
      , City = ci.City
      , State = ci.State
      , Country = ci.Country
      , County = ci.County
      , ZipCode = ci.ZipCode
      , A5HOLD = ci.A5HOLD
      , A6HOLD  = ci.A6HOLD
  FROM AesImport.dbo.CustomerImport ci
  WHERE AesOps.dbo.Customers.CustomerNumber = ci.CustomerNumber

  INSERT INTO AesOps.dbo.Customers (CustomerNumber
    , CustomerName
    , ParentNumber
    , AddressType
    , BillTo
    , AC02Desc
    , AC03Desc
    , AC04Desc
    , Line0MailName
    , Line1MailName
    , Line2MailName
    , EffectiveDate
    , AddressLine1
    , AddressLine2
    , AddressLine3
    , AddressLine4
    , City
    , State
    , Country
    , County
    , ZipCode
    , A5HOLD
    , A6HOLD
    , IsActive)
  SELECT CustomerNumber
    , CustomerName
    , ParentNumber
    , AddressType
    , BillTo
    , AC02Desc
    , AC03Desc
    , AC04Desc
    , Line0MailName
    , Line1MailName
    , Line2MailName
    , EffectiveDate
    , AddressLine1
    , AddressLine2
    , AddressLine3
    , AddressLine4
    , City
    , State
    , Country
    , County
    , ZipCode
    , A5HOLD
    , A6HOLD
    , 1
    FROM AesImport.dbo.CustomerImport
    WHERE CustomerNumber NOT IN (SELECT CustomerNumber FROM AesOps.dbo.Customers WHERE CustomerNumber IS NOT NULL)
  
  SET NOCOUNT OFF

END

GO
/****** Object:  StoredProcedure [dbo].[spProcessFixedAssetSnapshots]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spProcessFixedAssetSnapshots] 
AS
BEGIN
	SET NOCOUNT ON;

	declare @InventoryDate DATE
	set @InventoryDate = GETDATE();

	declare @PrevInventoryDate DATE	
	set @PrevInventoryDate = (select MAX(InventoryDate) from AesWarehouse.dbo.FixedAssetSnapshots)

	insert into AesWarehouse.dbo.FixedAssetSnapshots (FixedAssetSnaphotId
		, FixedAssetId
		, AssetNumber
		, SerialNum
		, InventoryItemNum
		, RNItemNum
		, Revision
		, BranchPlant
		, EquipmentStatus
		, NetBookValue
		, LastStatusChangeDate
		, InventoryDate
		, LastBranchPlant
		, LastEquipmentStatus
		, NumDaysInBranchPlant
		, NumDaysInEquipmentStatus)
	select NEWID()
		, fa.FixedAssetId
		, fa.AssetNumber
		, fa.SerialNum
		, fa.InventoryItemNum
		, fa.RNItemNum
		, fa.Revision
		, fa.BranchPlant
		, fa.EquipmentStatus
		, IsNull(fa.NetBookValue, 0)
		, ISNULL(fa.LastStatusChangeDate, ISNULL(fa.LastEdit, ISNULL(DateAdded, @inventoryDate)))
		, @InventoryDate as InventoryDate
		, (select top 1 BranchPlant from AesWarehouse.dbo.FixedAssetSnapshots fas where fas.FixedAssetId = fa.FixedAssetId and fas.BranchPlant <> fa.BranchPlant order by fas.InventoryDate desc) as LastBranchPlant
		, (select top 1 EquipmentStatus from AesWarehouse.dbo.FixedAssetSnapshots fas where fas.FixedAssetId = fa.FixedAssetId and fas.EquipmentStatus <> fa.EquipmentStatus order by fas.InventoryDate desc) as LastEquipmentStatus
		, case when (select top 1 fas.BranchPlant from AesWarehouse.dbo.FixedAssetSnapshots fas where fas.FixedAssetId = fa.FixedAssetId order by InventoryDate desc) = fa.BranchPlant then
		IsNull((select top 1 fas.NumDaysInBranchPlant from AesWarehouse.dbo.FixedAssetSnapshots fas where fas.FixedAssetId = fa.FixedAssetId order by InventoryDate desc) + DATEDIFF(dd, @PrevInventoryDate, @InventoryDate), 1)
		else 1 end as NumDaysInBranchPlant
		, DATEDIFF(dd, fa.LastStatusChangeDate, @InventoryDate) as NumDaysInEquipmentStatus
	from AesOps.dbo.FixedAssets fa
	where fa.AssetNumber is not null


	DELETE FROM AesWarehouse.dbo.FixedAssetSnapshots
	WHERE InventoryDate < DateAdd(dd,-30,@InventoryDate)
		and DATEPART(DW, InventoryDate) <> 2

	
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[spProcessInventoryRNItemNums]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spProcessInventoryRNItemNums]
AS
BEGIN
	SET NOCOUNT ON

	delete from AesOps.dbo.ItemNumReferences where RefType = 'R' and Source='J'

	insert into AesOps.dbo.ItemNumReferences (ItemNum, RefItemNum, RefType, Source)
	select LTRIM(RTRIM(a.From_Item_number)), LTRIM(RTRIM(a.To_Item_number)), 'R', 'J'
	from AesImport.dbo.InventoryRNItemNumImport a

	update AesOps.dbo.ItemNums
	set IsAsset = 1
	where ItemNum in (select ItemNum from AesOps.dbo.ItemNumReferences where RefType = 'R')

	update AesOps.dbo.ItemNums
	set IsAsset = 1
	where ItemNum in (select RefItemNum from AesOps.dbo.ItemNumReferences where RefType = 'R')

/*
	update AesOps.dbo.ItemNums
	set IsAsset = 0
	where ItemNum in not (select RefItemNum from AesOps.dbo.ItemNumReferences where RefType = 'R')
	  and ItemNum in (select ItemNum from AesOps.dbo.ItemNumReferences where RefType = 'R')
*/

	update i 
		set i.ToolPanel = rn.ToolPanel
		, i.ToolCode = rn.ToolCode
	from AesOps.dbo.ItemNums i
		left join AesOps.dbo.ItemNumReferences ir on ir.ItemNum = i.ItemNum
		left join AesOps.dbo.ItemNums rn on rn.ItemNum = ir.RefItemNum
	where ir.RefType = 'R'
	  and (i.ToolPanel <> rn.ToolPanel or (i.ToolPanel is null and rn.ToolPanel is not null))
	
	  
	update i 
		set i.ToolPanel = rn.ToolPanel
		, i.ToolCode = rn.ToolCode
	from AesOps.dbo.ItemNums i
		left join AesOps.dbo.ItemNumReferences ir on ir.ItemNum = i.ItemNum
		left join AesOps.dbo.ItemNums rn on rn.ItemNum = ir.RefItemNum
	where ir.RefType = 'R'
	  and (i.ToolCode <> rn.ToolCode or (i.ToolCode is null and rn.ToolCode is not null))
	  
	SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[spProcessItemCrossReference]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spProcessItemCrossReference]
AS
BEGIN
  SET NOCOUNT ON

	SET NOCOUNT ON

	delete from AesOps.dbo.ItemNumReferences where RefType = 'U' and Source='J'

	insert into AesOps.dbo.ItemNumReferences (ItemNum, RefItemNum, RefType, Source)
	select LTRIM(RTRIM(a.LITM)), LTRIM(RTRIM(a.CITM)), 'U', 'J'
	from AesImport.dbo.ItemCrossReferenceImport a where a.CITM is not null

	delete from AesOps.dbo.ItemNumReferences
	where ItemNumReferenceId in (
	select ir.ItemNumReferenceId from AesOps.dbo.ItemNumReferences ir
	left join AesOps.dbo.ItemNums i on i.ItemNum = ir.ItemNum
	where i.ItemNum is null
	)

	delete from AesOps.dbo.ItemNumReferences
	where ItemNumReferenceId in (
	select ir.ItemNumReferenceId from AesOps.dbo.ItemNumReferences ir
	left join AesOps.dbo.ItemNums i on i.ItemNum = ir.RefItemNum
	where i.ItemNum is null
	)

	SET NOCOUNT OFF

END


GO
/****** Object:  StoredProcedure [dbo].[spProcessItemNums]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spProcessItemNums]
AS
BEGIN
  SET NOCOUNT ON

	UPDATE [AesOps].[dbo].ItemNums
	SET 
--	   [ItemNum] = ini.ItemNum,
	   [ItemNum2] = ini.ItemNum2
	   ,[ItemNum3] = ini.ItemNum3
	   ,[DescShort] = ini.DescShort
	   ,[DescDocNum] = ini.DescDocNum
	   ,[Revision] = ini.Revision
--	   ,[DefaultUOM] = ini.DefaultUOM
--	   ,[DefaultSerialProfile] = ini.DefaultSerialProfile

	   ,[IsObsolete] = 0
	   ,[IsRestrictPurchasing] = 0
	   --,[IsAsset] = case ini.IMLNTY when 'RN' then 1 else 0 end

	   ,[PartClassification] = IsNull(ini.PC3Desc,'')+IsNull('\'+ini.PC4Desc,'')+IsNull('\'+ini.PC5Desc,'')+IsNull('\'+ini.PC6Desc,'')+IsNull('\'+ini.PC7Desc,'')
	   ,[ProductLine] = ini.PC4Desc
	   ,[ServiceLine] = ini.PC5Desc
	   
	   ,StockType = ini.StockType

	   ,[Active] = ini.Active
	   --,[LastEdit] =  ini.LastEdit
	FROM AesImport.dbo.ItemNumImport ini
	WHERE [AesOps].[dbo].ItemNums.[ItemNum] = ini.[ItemNum]

	insert into AesOps.dbo.ItemNums
	(
	   [ItemNum]
	   ,[ItemNum2]
	   ,[ItemNum3]
	   ,[DescShort]
	   ,[DescDocNum]
	   ,[Revision]
	   ,[DefaultUOM]
	   ,[DefaultSerialProfile]

	   ,[IsObsolete]
	   ,[IsRestrictPurchasing]
	   ,[IsAsset]

	   ,[PartClassification]
	   ,[ProductLine]
	   ,[ServiceLine]
	   
	   ,StockType

	   ,[Active]
	   ,[LastEdit]
	   ,[DateAdded]
	)
	select 
		[ItemNum]
		,[ItemNum2]
		,[ItemNum3]
		,[DescShort]
		,[DescDocNum]
		,[Revision]
		,[DefaultUOM]
		,[DefaultSerialProfile]

		,0 --[IsObsolete]
		,0 --[IsRestrictPurchasing]
		,0 --,case ini.IMLNTY when 'RN' then 1 else 0 end --[IsAsset]

		,IsNull(PC3Desc,'')+IsNull('\'+PC4Desc,'')+IsNull('\'+PC5Desc,'')+IsNull('\'+PC6Desc,'')+IsNull('\'+PC7Desc,'')

		,PC4Desc
		,PC5Desc
		,StockType

		,[Active]
		,[LastEdit]
		,GETDATE()

	from AesImport.dbo.ItemNumImport ini
	where ini.ItemNum NOT IN (SELECT i.ItemNum FROM AesOps.dbo.ItemNums i WHERE i.ItemNum = ini.ItemNum)

	update AesOps.dbo.ItemNums
	set DefaultSerialProfile = t.DefaultSerialProfile
	from (
	select i.ItemNum, i.DefaultSerialProfile 
	from AesImport.dbo.ItemNumImport i 
	where 
	  not exists (select FixedAssetId from AesOps.dbo.FixedAssets fa where fa.InventoryItemNum = i.ItemNum or fa.RNItemNum = i.ItemNum)
	) t
	where t.ItemNum = AesOps.dbo.ItemNums.ItemNum and t.DefaultSerialProfile <> AesOps.dbo.ItemNums.DefaultSerialProfile

	insert into AesOps.dbo.ItemNumRevisions
	( ItemNum, Revision, ItemNum3, IsObsolete, Active, DateAdded )
	select
	  in1.ItemNum, in1.Revision, in1.ItemNum3, in1.IsObsolete, in1.Active, GETDATE()
	from AesOps.dbo.ItemNums in1
	left join AesOps.dbo.ItemNumRevisions inr1 on inr1.ItemNum = in1.ItemNum and inr1.Revision = in1.Revision
	where 
	  inr1.ItemNumRevisionId is null and in1.Revision is not null and in1.Revision <> ''
	  and in1.PartClassification <> 'DRILLING SERVICES\SOFTWARE\FIRMWARE'

	update AesOps.dbo.ItemNumBranchPlants
	set
	   --,[Version]
	   [SerialProfile] = ibci.Lot_Process_Type
	   ,LotStatusCode = ibci.Lot_Status_Code
	   ,[MinReorder] = ibci.Minimum_Reorder_Quantity
	   ,[MaxInStock] = ibci.Maximum_Reorder_Quantity
	   ,[OptimumStock] = ibci.Safety_Stock
	   --,[IsProvidingLoc]
	   --,[CurrShortName]
	   ,[StdUnitCost] = ibci.Cost
	   --,[MovingAverageCost]
	   , CostMethod = ibci.Cost_Method
	   , ECCN = ibci.Export_Commodity_Control_Number
	   , HTSUS = ibci.Harmonized_Tariff_Begin_Digits + IsNull(ibci.Harmonized_Tariff_End_Digits, '')
	   ,[LastEdit] = isnull(ibci.Date_Changed, GETDATE())
	   ,[DateAdded] = isnull(ibci.Date_Added, GETDATE())
	FROM AesImport.dbo.ItemBranchAndCostImport ibci
	WHERE AesOps.dbo.ItemNumBranchPlants.[ItemNum] = convert(varchar(8), ibci.item_number)
	  and AesOps.dbo.ItemNumBranchPlants.BranchPlant = ibci.Branch_plant

	insert into AesOps.dbo.ItemNumBranchPlants
	(
		[BranchPlant]
	   ,[ItemNum]
	   ,[Version]
	   ,[SerialProfile]
	   ,LotStatusCode
	   ,[MinReorder]
	   ,[MaxInStock]
	   ,[OptimumStock]
	   ,[IsProvidingLoc]
	   ,[CurrShortName]
	   ,[StdUnitCost]
	   ,[MovingAverageCost]
	   , CostMethod
	   , ECCN
	   , HTSUS
	   ,[LastEdit]
	   ,[DateAdded]
	)
	select
	  ibci.branch_plant
	  , convert(varchar(8), ibci.item_number)
	  , null --IMRVNO
	  , ibci.Lot_Process_Type
	  , ibci.Lot_Status_Code
	  , ibci.Minimum_Reorder_Quantity
	  , ibci.Maximum_Reorder_Quantity
	  , ibci.Safety_Stock
	  , 0  -- is providing loc
	  , NULL  -- curr short name
	  , ibci.Cost
	  , null -- moving average cost
	  , ibci.Cost_Method
	  , ibci.Export_Commodity_Control_Number
	  , ibci.Harmonized_Tariff_Begin_Digits + IsNull(ibci.Harmonized_Tariff_End_Digits, '')
	  , isnull(ibci.Date_Changed, GETDATE())
	  , isnull(ibci.Date_Added, GETDATE())
	from AesImport.dbo.ItemBranchAndCostImport ibci
	left join AesOps.dbo.ItemNumBranchPlants x on x.BranchPlant=ibci.Branch_plant and x.ItemNum=ibci.Item_Number
	where 
	  x.ItemNumBranchPlantId is null

	Update a 
	set a.StdUnitCost = ISNULL((Select TOP 1 b.StdUnitCost from AesOps.dbo.ItemNumBranchPlants b 
		Where b.ItemNum = a.ItemNum 
		AND ISNULL(b.StdUnitCost, 0) <> 0 and b.CurrShortName = 'USD' ORDER by b.LastEdit DESC
	), a.StdUnitCost)
	FROM AesOps.dbo.ItemNums a

   delete from AesOps.dbo.ItemNumBranchPlants
	where ItemNumBranchPlantId in (
	select ir.ItemNumBranchPlantId from AesOps.dbo.ItemNumBranchPlants ir
	left join AesOps.dbo.ItemNums i on i.ItemNum = ir.ItemNum
	where i.ItemNum is null
	)

   delete from AesOps.dbo.ItemNumBranchPlants
	where ItemNumBranchPlantId in (
	select ir.ItemNumBranchPlantId from AesOps.dbo.ItemNumBranchPlants ir
	left join AesOps.dbo.BranchPlants bp on bp.BranchPlant = ir.BranchPlant
	where bp.BranchPlantId is null
	)

  SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[spProcessWorkOrderHeader]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spProcessWorkOrderHeader]
AS

SET NOCOUNT ON

/*
select [Work_Order_Number]
      ,[Completion_Date]
      ,[Item_Number]
      ,[Description]
      ,[Branch_Plant]
      ,[Serial]
      ,[Super_Category]
      ,[Super_Category_Desc]
      ,[Transaction_Time]
      ,[Bill_Revision_Level]
      ,[Date_Updated]
      ,[Time_Updated]
      ,[Processed]
from AesImport.dbo.WorkOrderHeader
where Processed = 0
*/

insert into AesOps.dbo.JobQueue (JobId, CreateDate, JobQueueStatusId, RequestXml)
select distinct 37, getdate(), 1, '<workorderheader>
  <woNum>' + convert(varchar(120), [Work_Order_Number]) + '</woNum>
  <itemNum>' + ltrim(rtrim([Item_Number])) + '</itemNum>
  <bp>' + ltrim(rtrim([Branch_Plant])) + '</bp>
  <serialNum>' + ltrim(rtrim([Serial])) + '</serialNum>
  <revision>' + ltrim(rtrim([Bill_Revision_Level])) + '</revision>
</workorderheader>'
from AesImport.dbo.WorkOrderHeader a
where a.Processed = 0
  and exists (select b.FixedAssetId from AesOps.dbo.FixedAssets b where b.InventoryItemNum=ltrim(rtrim([Item_Number]))
    and b.SerialNum=ltrim(rtrim([Serial])))
    
update AesImport.dbo.WorkOrderHeader
set Processed = 1
where Processed = 0

--select * from AesOps.dbo.JobQueue where JobId = 37
--delete from AesOps.dbo.JobQueue where JobId = 37

SET NOCOUNT OFF

GO
/****** Object:  StoredProcedure [dbo].[usp_GetEquipmentStructure]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetEquipmentStructure]
	@SAPEquipmentId varchar(30)
AS

WITH RecursiveCTE(
	PartId, Loc, Qty
  , SAPEquipmentId, ParentSerialNum, ParentPartNum
  , ParentMaterialNum
  , SerialNum, PartNum
  , SAPMaterialNum, Revision
  , Level
)
	AS 
	( 
		select tp.PartId, tp.Loc, tp.Qty
		  , pp.SAPEquipmentId, pp.SerialNum as ParentSerialNum, pp.PartNum as ParentPartNum
		  , ppd.SAPMaterialNum as ParentMaterialNum
		  , pc.SerialNum, pc.PartNum
		  , pcd.SAPMaterialNum, pcd.RevCode
		  , 0 as Level 
		from [10.225.127.4].Imarks.dbo.ToolParts tp
		join [10.225.127.4].Imarks.dbo.Parts pp on pp.PartId = tp.ParentPartId
		join [10.225.127.4].Imarks.dbo.Parts pc on pc.PartId = tp.PartId
		join [10.225.127.4].Imarks.dbo.PartDesc ppd on ppd.PartNum = pp.PartNum
		join [10.225.127.4].Imarks.dbo.PartDesc pcd on pcd.PartNum = pc.PartNum
		where  pp.SAPEquipmentId = @SAPEquipmentId
 
		UNION ALL

		SELECT 
		pc.PartId as ChildPartId, tp.Loc, tp.Qty
		  , pp.SAPEquipmentId, pp.SerialNum as ParentSerialNum, pp.PartNum as ParentPartNum
		  , ppd.SAPMaterialNum as ParentMaterialNum
		  , pc.SerialNum, pc.PartNum
		  , pcd.SAPMaterialNum, pcd.RevCode
		  , Level+1
		from [10.225.127.4].Imarks.dbo.ToolParts tp
		join [10.225.127.4].Imarks.dbo.Parts pp on pp.PartId = tp.ParentPartId
		join [10.225.127.4].Imarks.dbo.Parts pc on pc.PartId = tp.PartId
		join [10.225.127.4].Imarks.dbo.PartDesc ppd on ppd.PartNum = pp.PartNum
		join [10.225.127.4].Imarks.dbo.PartDesc pcd on pcd.PartNum = pc.PartNum
		join RecursiveCTE ct  ON pp.SerialNum = ct.SerialNum 
) 

INSERT INTO tmpEquipment (BranchPlant, AssetDesc, ParentNumber, ParentFixedAssetId,
	SerialNum, Qty, ItemNum, EquipmentStatus, Revision, LastEditDate, LastStatusChangeDate,
	Level, ParentSerialNum, ParentPartNum, ParentMaterialNum)
SELECT 
	NULL AS BranchPlant
	, NULL AS AssetDesc
	, NULL AS ParentNumber
	, NULL AS ParentFixedAssetId
	, SerialNum
	, Qty
	, pm.MappedTo_JDE_S_Item AS ItemNum
	, 'IN' AS EquipmentStatus
	, Revision
	, GETDATE() AS LastEditDate
	, GETDATE() AS LastStatusChangeDate
	, Level
	, ParentSerialNum
	, ParentPartNum
    , ParentMaterialNum
FROM RecursiveCTE 
left join PartMapping pm on pm.SAP_Part = RecursiveCTE.SAPMaterialNum
order by level, ParentSerialNum




GO
/****** Object:  StoredProcedure [dbo].[usp_ImportMRPItemNumConfigs]    Script Date: 3/27/2016 11:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_ImportMRPItemNumConfigs]
as
Begin

	Select * INTO #tempItemNumConfigs
	FROM [AesImport].[dbo].[ItemNumConfigs]

	Update #tempItemNumConfigs
	set ItemNum = 'tbd-' + PartCode
	where ItemNum is null

	Insert Into [AesOps].[dbo].[ItemNumConfigs] (
	       ItemNumConfigId, BranchPlant, LineNum, ItemNum, ParentItemNum, OptionText, ECNNumber, LastDateModified, LastUserModified, Qty, Reference, EffectiveFromDate, EffectiveThruDate, ItemLevel, IsToolString, ToolSizeID, IsActive, IsMandatoryReplacement, IsRequired)
	Select ItemNumConfigId, BranchPlant, LineNum, ItemNum, ParentItemNum, OptionText, ECNNumber, GETDATE(), LastUserModified, Qty, Reference, EffectiveFromDate, EffectiveThruDate, ItemLevel, IsToolString, ToolSizeID, IsActive, IsMandatoryReplacement, IsRequired
	from #tempItemNumConfigs

	drop table #tempItemNumConfigs

End
GO
