USE [AesImport]
GO
/****** Object:  StoredProcedure [dbo].[spProcessItemNums]    Script Date: 11/11/2016 2:48:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spProcessItemNums]
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
	where not exists (select FixedAssetId from AesOps.dbo.FixedAssets fa where fa.InventoryItemNum = i.ItemNum or fa.RNItemNum = i.ItemNum)
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

	-- Serialize parts changed on 3/4/2016	
	UPDATE AesOps.dbo.ItemNums SET DefaultSerialProfile = 'S' 
	WHERE ItemNum IN 
	(
		Select r.ItemNum
		from AesOps.dbo.ItemNums i  
		inner join AesOps.dbo.ItemNumReferences r on i.ItemNum = r.RefItemNum 
		where i.PartClassification like 'RENTALS%' and i.DefaultSerialProfile <> 'S' 
	) and ItemNum NOT IN (SELECT ItemNum from AesImport.dbo.ItemNumImport Where [AllowDefaultSerialOverride] = 0)


	UPDATE AesOps.dbo.ItemNums SET DefaultSerialProfile = 'S'
	WHERE ItemNum IN 
	(
		Select i.ItemNum from AesOps.dbo.ItemNums i  
		where i.PartClassification like 'RENTALS%' and i.DefaultSerialProfile <> 'S'
	) and ItemNum NOT IN (SELECT ItemNum from AesImport.dbo.ItemNumImport Where [AllowDefaultSerialOverride] = 0)

	UPDATE AesOps.dbo.ItemNums 
	SET DefaultSerialProfile = 'S'
	Where ItemNum IN 
	(
		select DISTINCT ParentItemNum from AesOps.dbo.ItemNumConfigs
	)
	AND DefaultSerialProfile <> 'S' 
	and (ItemNum NOT IN (SELECT ItemNum from AesImport.dbo.ItemNumImport Where [AllowDefaultSerialOverride] = 0)
		OR IsAsset = '1')


	

	------------- New Change to get the ItemNumMetadata from WindChill SQL database  -----------------

DECLARE @LastModifiedDate datetime
DECLARE @ItemNum VARCHAR(30)
DECLARE @ItemNums table 
( ItemNum VARCHAR(30),
	[AttributeName] nvarchar(100),
	[AttributeValue] nvarchar(1500),
	[UOM] nvarchar(50)
)


SELECT @LastModifiedDate = CAST(SUBSTRING(MAX(MetaValue), 0, 21) as datetime) FROM Aesops.dbo.ItemNumMetadata WITH (NOLOCK) WHERE MetaName = 'modifyTimestamp'

INSERT INTO @ItemNums
SELECT	si.Item, 
		si.[AttributeName], 
		si.[AttributeValue],
		si.[AttributeValueUOM]
FROM USDCSCDSQLPD001.windchill_data.dbo.ItemAttributes si WITH (NOLOCK) 
WHERE si.Item IN (SELECT Item 
					FROM USDCSCDSQLPD001.windchill_data.dbo.ItemAttributes si WITH (NOLOCK) 
					WHERE si.AttributeName = 'modifyTimestamp' AND CAST(SUBSTRING(si.AttributeValue, 0, 21) as datetime) > @LastModifiedDate)


DECLARE db_cursor1 CURSOR FOR  
SELECT ItemNum
	FROM @ItemNums
	WHERE AttributeName = 'modifyTimestamp'
	order by CAST(SUBSTRING(AttributeValue, 0, 21) as datetime) asc

OPEN db_cursor1   
FETCH NEXT FROM db_cursor1 INTO @ItemNum

WHILE @@FETCH_STATUS = 0
BEGIN   

	DELETE FROM Aesops.dbo.ItemNumMetadata
	WHERE ItemNum = @ItemNum
	
	INSERT INTO Aesops.dbo.ItemNumMetadata (ItemNumMetaDataId, ItemNum, MetaName, MetaValue, UOM)
	SELECT newid(), s.ItemNum, s.AttributeName, s.AttributeValue, s.UOM FROM @ItemNums s WHERE s.ItemNum = @ItemNum

	Update AesOps.dbo.ItemNums  SET ToolPanel = [AttributeValue]  FROM AesOps.dbo.ItemNums t WITH (NOLOCK) INNER JOIN @ItemNums s on t.ItemNum = s.ItemNum WHERE s.AttributeName = 'EQUIPMENT PANEL' AND s.ItemNum = @ItemNum
	Update AesOps.dbo.ItemNums  SET ToolCode = [AttributeValue]  FROM AesOps.dbo.ItemNums t WITH (NOLOCK) INNER JOIN @ItemNums s on t.ItemNum = s.ItemNum WHERE s.AttributeName = 'TOOL CODE' AND s.ItemNum = @ItemNum
	Update AesOps.dbo.ItemNums  SET Revision = [AttributeValue]  FROM AesOps.dbo.ItemNums t WITH (NOLOCK) INNER JOIN @ItemNums s on t.ItemNum = s.ItemNum WHERE s.AttributeName = 'SOFTWARE VERSION' AND s.ItemNum = @ItemNum
	Update AesOps.dbo.ItemNums  SET Revision = [AttributeValue]  FROM AesOps.dbo.ItemNums t WITH (NOLOCK) INNER JOIN @ItemNums s on t.ItemNum = s.ItemNum WHERE s.AttributeName = 'VERSIONINFO' AND s.ItemNum = @ItemNum
	Update AesOps.dbo.ItemNums  SET NetWeight = [AttributeValue]  FROM AesOps.dbo.ItemNums t WITH (NOLOCK) INNER JOIN @ItemNums s on t.ItemNum = s.ItemNum WHERE s.AttributeName = 'WEIGHT' AND s.ItemNum = @ItemNum
	Update AesOps.dbo.ItemNums  SET PartClassification = [AttributeValue]  FROM AesOps.dbo.ItemNums t WITH (NOLOCK) INNER JOIN @ItemNums s on t.ItemNum = s.ItemNum WHERE s.AttributeName = 'CLASSIFICATION' AND s.ItemNum = @ItemNum
	
	--TODO : Need Confirmation on changing IsObsolete 
	--Update AesOps.dbo.ItemNums  SET IsObsolete = 1  FROM AesOps.dbo.ItemNums WHERE ItemNum IN (SELECT ItemNum FROM @ItemNums WHERE s.AttributeName = 'LIFE CYCLE STATE' and s.[AttributeValue] = 'Obsolute')


	------------- New Change to get the ItemNumConfigs (BillOfMaterial) from WindChill SQL database  -----------------

	-- Save REVISION IN HISTORY
	INSERT INTO aesops.dbo.ItemNumConfigHistory(
			BranchPlant ,LineNum, ItemNum, ParentItemNum, OptionText
           ,ECNNumber, LastDateModified, LastUserModified, LastModifiedUserName, Qty, Reference
           ,EffectiveFromDate, EffectiveThruDate, ItemLevel, IsMandatoryReplacement, IsRequired
           ,DateAdded, UserIdAdded, AddedByUserName, HistoryDateAdded)
    Select 
		c.BranchPlant, c.LineNum, c.ItemNum, c.ParentItemNum, c.OptionText
        ,c.ECNNumber, c.LastDateModified, c.LastUserModified, u.UserName, c.Qty, c.Reference
        ,c.EffectiveFromDate, c.EffectiveThruDate, c.ItemLevel, c.IsMandatoryReplacement, c.IsRequired
        ,c.DateAdded, c.UserIdAdded, ua.UserName, GETDATE()
    FROM aesops.dbo.ItemNumConfigs c (NOLOCK)
    LEFT JOIN aesops.dbo.users u (NOLOCK) on u.UserId = c.LastUserModified
    LEFT JOIN aesops.dbo.users ua (NOLOCK) on ua.UserId = c.UserIdAdded
    WHERE ParentItemNum = @ItemNum AND ISNULL(IsToolString, 0) = 0
    ORDER by LineNum
        
    --DELETE OLD CONFIGURATION RECORDS
	DELETE FROM  aesops.dbo.ItemNumConfigs WHERE ParentItemNum =  @ItemNum AND ISNULL(IsToolString, 0) = 0

	-- ADD NEW CHANGES
	INSERT INTO aesops.dbo.ItemNumConfigs
	(
		ItemNum, 
		ParentItemNum, 
		OptionText, 
		LineNum, 
		Qty, 
		IsToolString, 
		IsActive, 
		IsMandatoryReplacement, 
		IsRequired, 
		UserIdAdded, 
		DateAdded
	)
	SELECT
		b.[CompItem], 
		b.[ParentItem], 
		LTRIM(RTRIM(b.[FindNumber])), 
		b.[Sequence], 
		b.[Qty], 
		0 [ToolString], 
		1 [IsActive], 
		0 [IsMandatoryReplacement],  
		CASE WHEN (b.[Qty] > 0 
				  and b.[FindNumber] <> 'OPTIONAL' 
				  and b.[FindNumber] <> 'AR'
				  and b.[FindNumber] <> 'REF'
				  and (b.[FindNumber] like '%1' or b.[FindNumber] = ''))
			THEN 1 
			ELSE 0 
		END [IsRequired], 
		0 [UserIdAdded]
		, GETDATE() [DateAdded]
	FROM USDCSCDSQLPD001.windchill_data.dbo.BillOfMaterials b  WITH (NOLOCK) 
	WHERE ParentItem = @ItemNum


  FETCH NEXT FROM db_cursor1 INTO @ItemNum
END

CLOSE db_cursor1   
DEALLOCATE db_cursor1



---- Update Part Classifications table

TRUNCATE TABLE dbo.PartClassifications

INSERT INTO dbo.PartClassifications(PartClassification, Level1, Level2, Level3, Level4, Level5)

SELECT DISTINCT SRP3 + (CASE WHEN ISNULL(SRP4,'') ='' THEN '' ELSE '/'+ SRP4 END) + (CASE WHEN ISNULL(SRP5,'') = '' THEN '' ELSE '/'+ SRP5 END) + (CASE WHEN ISNULL(SRP6,'') = '' THEN '' ELSE '/'+ SRP6 END),
SRP3, SRP4, SRP5, SRP6, NULL
FROM USDCSCDSQLPD001.[Windchill_Data].[dbo].[ClassPaths]
ORDER BY SRP3, SRP4, SRP5,SRP6

  SET NOCOUNT OFF
END
GO


USE [AESOPS]


ALTER TABLE [dbo].[DocItems] ADD [DocumentCategory] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
ALTER TABLE [dbo].[PFTWOSeq] ALTER COLUMN [Hours] [decimal] (10,2) NULL
GO
ALTER TABLE [dbo].[PFTWO] ADD [AssetRepairTrackId] [uniqueidentifier] NULL
GO
ALTER TABLE [dbo].[JDEWorkOrders] ADD [WorkOrderId] [uniqueidentifier] NULL
GO
ALTER TABLE [dbo].[AuditPFTWO] ADD [AssetRepairTrackId] [uniqueidentifier] NULL
GO
ALTER TABLE [dbo].[AssetLifeCycleReportDataset] 
ADD [Age_Since_Issued_To_DT] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Age_Since_Returned_From_DT] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
CREATE TABLE [dbo].[PartClassifications]
(
	[Id] [int] IDENTITY (1,1) NOT NULL,
	[PartClassification] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Level1] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Level2] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Level3] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Level4] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Level5] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

--===================================================
--MODIFIED BY: SUYEB MOHAMMAD
--MODIFIED ON: 21 Oct 2016
--DESCRIPTION: To get attachment info for pft sequence
--====================================================
ALTER VIEW [dbo].[vwPFTWOSeq]
AS
SELECT (CASE WHEN (DA.GuidKeyId IS NULL ) THEN 0
			WHEN (DA.GuidKeyId IS NOT NULL)THEN 1 ELSE 0 END) AS HasAttachment, 
  PFTWOSeq.PFTWOSeqId, PFTWOSeq.PFTWOId, PFTWOSeq.PFTResult, PFTWOSeq.PFTConfigSeqId, PFTWOSeq.FailureCode, 
  PFTWOSeq.FailureComponent, PFTWOSeq.Comment, PFTWOSeq.UserId, PFTWOSeq.DateAdded, PFTWOSeq.IsDebug, PFTWOSeq.IsRTV, PFTConfigSeq.Seq, 
  PFTConfigSeq.SeqName, PFTConfigSeq.PFTLabId, PFTConfigSeq.SeqDesc, PFTLabs.LabName, SelectOptions.OptionLabel AS PFTResultDesc, 
  Users.UserName AS UserNameSess, PFTWOSeq.Hours, PFTWOSeq.UserName, PFTWOSeq.NCRRequestId
FROM 
  PFTWOSeq (NOLOCK)
  LEFT OUTER JOIN Users (NOLOCK) ON Users.UserId = PFTWOSeq.UserId 
  LEFT OUTER JOIN SelectOptions (NOLOCK) ON SelectOptions.OptionValue = PFTWOSeq.PFTResult AND SelectOptions.SelectName='PFTResults'
  LEFT OUTER JOIN PFTConfigSeq (NOLOCK) ON PFTWOSeq.PFTConfigSeqId = PFTConfigSeq.PFTConfigSeqId
  LEFT OUTER JOIN PFTLabs (NOLOCK) ON PFTLabs.PFTLabId = PFTConfigSeq.PFTLabId
  LEFT OUTER JOIN DocItemAttach DA(NOLOCK) ON DA.GuidKeyId = PFTWOSeq.PFTWOId AND PFTConfigSeq.Seq=DA.SubKeyId
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 8/17/2016
-- Description:	Updates the AssetLifeCycleReportDataset nightly
-- =============================================
ALTER PROCEDURE [dbo].[usp_AssetLifeCycleReportDatasetUpdate] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	TRUNCATE TABLE dbo.AssetLifeCycleReportDataset

	INSERT INTO AssetLifeCycleReportDataset
	SELECT
	  f.FixedAssetId,
	  f.SerialNum,
	  f.AssetNumber,
	  f.EquipmentStatus,
	  f.RNItemNum,
	  f.InventoryItemNum,
	  f.ProductLineId,
	  i.DescShort,
	  i.ToolCode,
	  i.ToolPanel,
	  bp.BranchPlant AS "CurrentBranchplant",
	  bp.CompanyName,
	  bp.Country,
	  bp.Region

	  /*Last Billable info*/,
	  ISNULL(f.LastBillableBranchPlant, '') AS "LastBillableBranchPlant",
	  ISNULL(f.LastBillableBranchPlantName, '') AS "LastBillableBranchPlantName",
	  ISNULL(f.LastBillableCountry, '') AS "LastBillableCountry",
	  ISNULL(f.LastBillableRegion, '') AS "LastBillableRegion",
	  ISNULL(CONVERT(varchar(10), ptd.[DatetoolTransferedfromOpsBillable], 101), '') AS "DateToolTransferedfromOpsBillable"

	  /*AIRT info*/,
	  ISNULL(b.artnumber, '') AS "LatestAIRT",
	  ISNULL(b.FromBranchPlant, '') AS "BPcreatingAIRT",
	  ISNULL(b.ShipToBranchPlant, '') AS "BPrepairingAIRT",
	  ISNULL(b.CurrentAirtStatus, '') AS "CurrentAIRTStatus",
	  ISNULL(CONVERT(varchar(10), b.DateAdded, 101), '') AS "DateAIRTCreated",
	  ISNULL(CONVERT(varchar(10), b.DateClosed, 101), '') AS "DateAIRTClosed",
	  ISNULL(B.[DispositionofAIRT], '') AS "DispositionofAIRT",
	  ISNULL(B.[AIRTDispositionComments], '') AS "AIRTDispositionComments",
	  ISNULL(CONVERT(varchar(10), b.[AIRTdispositiondate], 101), '') AS "AIRTDispositionDate"


	  /*Aging*/,
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, d.EndDate, GETDATE()), 101), '') AS "Agesincelastrun",
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, b.dateadded, GETDATE()), 101), '') AS "AgesincelastAIRTwasCreated",
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, (SELECT
		MAX(dateadded)
	  FROM pftwoseq psq
	  WHERE psq.PFTWOId = b.ITPFTWOId), GETDATE()), 101), '') AS "AgesincelastTIPFTstep",
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, b.[AIRTdispositiondate], GETDATE()), 101), '') AS "AgesinceAIRTwasDispositioned",
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, ptd.[DatetoolTransferedfromOpsBillable], GETDATE()), 101), '') AS "DatesincetoolwaslastinOpsBillableBP",
	  ISNULL(CONVERT(varchar(10), pt1.dateshipped, 101), '') AS "DateshippedtoAIRTshiptolocation",
	  ISNULL(CONVERT(varchar(10), pt2.DateReceived, 101), '') AS "DatereceivedinAIRTshiptolocation",
	  ISNULL(CONVERT(varchar(10), pt3.dateshipped, 101), '') AS "Dateoflastshipmentoftool",
	  ISNULL(CONVERT(varchar(10), pt4.dateReceived, 101), '') AS "Datereceiptoftool",

	  CASE WHEN b.[DispositionofAIRT] = 'Repair in Global' AND pt1.dateshipped IS NULL THEN 'No Shipping information'
		   WHEN b.[DispositionofAIRT] = 'Repair in Global' AND pt2.DateReceived IS NULL THEN 'No Receipt information'
		   ELSE ISNULL(CONVERT(varchar(10), DATEDIFF(dd, pt1.dateshipped, pt2.DateReceived), 101), '')
	  END AS "TransittimefromTesttoRepairlocation"
	  
	  /*reliability selects*/

	  /*Last Job History*/,
	  ISNULL(CONVERT(varchar(10), d.EndDate, 101), '') AS "latestrunenddate",
	  ISNULL(d.JobNumber, '') AS "latestjob",
	  ISNULL(d.RunNumber, '') AS "latestrunnumber"


	  /*Lifetime job data*/,
	  ISNULL(rel1.[TotalCSI], 0) AS "TotalLifetimeCSI",
	  ISNULL(rel1.[TotalTFF], 0) AS "TotalLifetimeTFF",
	  ISNULL(rel1.[TotalOperHrs], 0) AS "TotalLifetimeOperHrs",
	  ISNULL(rel1.[TotalCircHrs], 0) AS "TotalLifetimeCircHrs",
	  ISNULL(CONVERT(decimal(18, 2), rel1.[TotalNPTHrs]), 0) AS "TotalLifetimeNPT",
	  ISNULL(rel1.[MaxTempLifetimeC], '') AS "LifetimeMaxTempC",
	  ISNULL(rel1.[MaxTempLifetimeF], '') AS "LifetimeMaxTempF"



	  /*Since Last AIRT*/,
	  ISNULL(b.[TotalCSISLA], 0) AS "TotalCSISLT",
	  ISNULL(b.[TotalTFFSLA], 0) AS "TotalTFFSLT",
	  ISNULL(b.[OperHrsSLA], 0) AS "OperHrsSLT",
	  ISNULL(b.[CircHrsSLA], 0) AS "CircHrsSLT",
	  ISNULL(CONVERT(decimal(18, 2), b.[NPTHrsSLA]), 0) AS "NPTHrsSLT",
	  ISNULL(b.[MaxTempSLAC], 0) AS "MaxTempSLTC",
	  ISNULL(b.[MaxTempSLAF], 0) AS "MaxTempSLTF"



	  /*Data Flags*/,
	  CASE WHEN b.ARTNumber IS NULL THEN 'No AIRT' ELSE '' END AS AIRTCheck,
	  CASE WHEN d.JobNumber IS NULL THEN 'No Job Info' ELSE '' END AS "JobCheck",
	  CASE WHEN f.LastBillableBranchPlant IS NULL THEN 'No billable info' ELSE '' END AS MovementCheck,

	  (select DATEDIFF(day,MAX(dii.DateAdded),GETDATE()) 
			from dispatchinstanceitems dii 
			left join DispatchInstances di on di.DispatchInstanceId = dii.DispatchInstanceId
			where di.ShipType = 'DT-SEQ-ADD' and dii.SerialNum = f.SerialNum and dii.ItemNum = f.RNItemNum) [Age_Since_Issued_To_DT],

	  (select DATEDIFF(day,MAX(dii.DateAdded),GETDATE()) 
			from dispatchinstanceitems dii 
			left join DispatchInstances di on di.DispatchInstanceId = dii.DispatchInstanceId
			where di.ShipType = 'DT-RETURN' and dii.SerialNum = f.SerialNum and dii.ItemNum = f.RNItemNum) [Age_Since_Returned_From_DT],

	  GETDATE() [CreatedOn]

	FROM vwFixedAssetsSearch f
	LEFT JOIN PartStatus(NOLOCK) ps ON ps.code = f.EquipmentStatus
	LEFT JOIN BranchPlants(NOLOCK) bp ON bp.BranchPlant = f.BranchPlant
	LEFT JOIN ItemNums(NOLOCK) i ON i.ItemNum = f.InventoryItemNum
	LEFT JOIN FixedAssets(NOLOCK) f1 ON f1.FixedAssetId = f.FixedAssetId
	LEFT JOIN GLCodes(NOLOCK) gc ON gc.GLCode = f1.ProductLineCode 
	LEFT JOIN GLProductLines(NOLOCK) gp ON gp.Id = gc.GLProductLineId
	
	/*Subquery for Latest AIRT with information about that AIRT*/
	
	LEFT JOIN (SELECT
		  ar.ITPFTWOId,
		  artnumber,
		  ar.dateadded,
		  dateclosed,
		  ar.fixedassetid,
		  d.[AIRTDispositionComments],
		  d.[AIRTdispositiondate],
		  d.[DispositionofAIRT],
		  d.ShipToBranchPlant,
		  ar.FromBranchPlant,
		  SUM(rel2.OperHrs) AS "OperHrsSLA",
		  SUM(rel2.circhrs) AS "CircHrsSLA",
		  SUM(rel2.[NPTHrs]) AS "NPTHrsSLA",
		  SUM(rel2.CSI) AS "TotalCSISLA",
		  SUM(rel2.tff) AS "TotalTFFSLA",
		  MAX(rel2.[MaxTempF]) AS "MaxTempSLAF",
		  MAX(rel2.[MaxTempC]) AS "MaxTempSLAC",

		  CASE WHEN ar.DateClosed IS NOT NULL THEN 'AIRT Closed'
			WHEN ar.SRPFTWOId IS NOT NULL THEN 'S&R PFT'
			WHEN ar.SRPFTWOId IS NULL AND d.[AIRTdispositiondate] IS NOT NULL THEN 'Approved disposition'
			WHEN ar.SRPFTWOId IS NULL AND d.[AIRTdispositiondate] IS NULL THEN 'In Inspection'
			ELSE 'unknown status' 
		 END AS [CurrentAirtStatus]

		FROM AssetRepairTrack(NOLOCK) ar

		/*current reliability data*/

		LEFT JOIN (SELECT
		  fixedassetid,
		  r6.OutHoleDate,
		  r6.operhrs,
		  r6.circhrs,
		  CONVERT(decimal(18, 5), ISNULL(tc6.losttime, 0)) AS "NPTHrs",
		  CONVERT(int, tc6.CSI) AS "CSI",
		  CONVERT(int, tc6.TFF) AS "TFF",
		  CONVERT(int, r6.MaxTempF) AS "MaxTempF",
		  CONVERT(int, r6.MaxTempc) AS "MaxTempC"

		FROM relbusinessintelligencedataset r6

		LEFT JOIN ToolStringComponentInfo(NOLOCK) tc6
		  ON tc6.RunID = r6.runid

		GROUP BY FixedAssetID,
				 r6.OutHoleDate,
				 r6.OperHrs,
				 r6.CircHrs,
				 tc6.losttime,
				 TC6.CSI,
				 tc6.TFF,
				 r6.MaxTempC,
				 r6.MaxTempF) rel2
		  ON rel2.FixedAssetID = ar.FixedAssetId
		  AND rel2.OutHoleDate > ar.DateAdded

	/*latest AIRT*/
	INNER JOIN (SELECT
	  MAX(dateadded) AS "dateadded",
	  FixedAssetId

	FROM AssetRepairTrack(NOLOCK)

	GROUP BY FixedAssetId) a
	  ON a.FixedAssetId = ar.FixedAssetId
	  AND ar.DateAdded = a.dateadded


	/*disposition*/


	LEFT JOIN (SELECT
					  a4.AssetRepairTrackid,
					  a4.ARTNumber AS "AIRTNumber",
					  ad4.DispositionComments AS "AIRTDispositionComments",
					  a4.ShipToBranchPlant,
					  a4.FromBranchPlant,

					  ad5.[Disposition Date] AS "AIRTdispositiondate",

					  CASE WHEN ad4.Disposition = '1' THEN 'Repair in District'
						WHEN ad4.Disposition = '4' THEN 'Use as is'
						WHEN ad4.Disposition = '2' THEN 'Repair in Global'
						WHEN ad4.Disposition = '3' THEN 'Scrap'
							ELSE 'unknown disposition' END AS [DispositionofAIRT]

					FROM AssetRepairTrack(NOLOCK) a4
					LEFT JOIN ARTDispositions(NOLOCK) ad4 ON ad4.AssetRepairTrackId = a4.AssetRepairTrackId

					INNER JOIN (SELECT ad.assetrepairtrackid,
									  MAX(ad.dateadded) [Disposition Date]
									  FROM ARTDispositions(NOLOCK) ad  
									  GROUP BY assetrepairtrackid) ad5
									  ON ad5.AssetRepairTrackId = a4.AssetRepairTrackId
									  AND ad4.DateAdded = ad5.[Disposition Date]
	  
					  ) d ON d.AssetRepairTrackId = ar.AssetRepairTrackId
					GROUP BY ar.ITPFTWOId,
							artnumber,
							ar.dateadded,
							dateclosed,
							ar.fixedassetid,
							d.[AIRTDispositionComments],
							d.[AIRTdispositiondate],
							d.[DispositionofAIRT],
							d.ShipToBranchPlant,
							ar.FromBranchPlant,

							CASE WHEN ar.DateClosed IS NOT NULL THEN 'AIRT Closed'
							WHEN ar.SRPFTWOId IS NOT NULL THEN 'S&R PFT' 
							WHEN ar.SRPFTWOId IS NULL AND d.[AIRTdispositiondate] IS NOT NULL THEN 'Approved disposition'
							WHEN ar.SRPFTWOId IS NULL AND d.[AIRTdispositiondate] IS NULL THEN 'In Inspection'
							ELSE 'unknown status' END
		) B ON b.fixedassetid = f.FixedAssetId



	/*Subquery to get Job information*/


	LEFT JOIN (SELECT
				  ts.FixedAssetID,
				  j.JobNumber,
				  r.EndDate,
				  r.RunNumber
				  FROM ToolStringComponentInfo(NOLOCK) ts
				  LEFT JOIN Runs r ON r.runid = ts.runid
				  LEFT JOIN wells w ON w.wellid = r.wellid 
				  LEFT JOIN JobS j ON j.JobId = w.JobID 
				  
				  INNER JOIN (SELECT tc1.fixedassetid,
									MAX(r1.enddate) AS "enddate" 
								  FROM ToolStringComponentInfo(NOLOCK) tc1 
								  LEFT JOIN Runs r1 ON r1.RunID = tc1.runid 
									  GROUP BY FixedAssetID) C ON c.FixedAssetID = ts.FixedAssetID AND c.enddate = r.EndDate
				) D ON d.FixedAssetID = f.FixedAssetId


	/*********************************************/

	/*** All Part Transfer Dtl data starts here***/

	/*********************************************/

	/*subquery to pull last ops location date*/


	LEFT JOIN (SELECT MAX(dateadded) AS [DatetoolTransferedfromOpsBillable],
					sendinglocation,
					FixedAssetId
				FROM PartTransferDtl(NOLOCK)
				WHERE source = 'pt'
				GROUP BY FixedAssetId,
					SendingLocation) ptd
	  ON ptd.SendingLocation = LastBillableBranchPlant
	  AND ptd.FixedAssetId = f.FixedAssetId



	/*subquery to get date shipped to repair location*/


	LEFT JOIN (SELECT MAX(pd1.dateadded) AS [dateshipped], 
					pd1.fixedassetid, 
					ReceivingLocation
				FROM parttransferdtl(NOLOCK) pd1
				WHERE source = 'pt' AND Dest = 'IT'
				GROUP BY fixedassetid,
					ReceivingLocation) PT1 ON pt1.ReceivingLocation = b.ShipToBranchPlant
	  AND f.FixedAssetId = pt1.FixedAssetId



	/*subquery to get date received in repair location*/


	LEFT JOIN (SELECT MAX(pd2.dateadded) AS [DateReceived], 
					ReceivingLocation,
					pd2.FixedAssetId
				FROM parttransferdtl(NOLOCK) pd2
				WHERE source = 'IT' AND Dest = 'AV'
				GROUP BY ReceivingLocation, fixedassetid

				) PT2 ON pt2.ReceivingLocation = b.ShipToBranchPlant AND f.FixedAssetId = pt2.FixedAssetId

	/*subquery to get date shipped*/

	LEFT JOIN (SELECT MAX(pd3.dateadded) AS [dateshipped],
					pd3.fixedassetid
				FROM parttransferdtl(NOLOCK) pd3
				WHERE Dest = 'av' AND Source = 'IT'
				GROUP BY fixedassetid) PT3 ON f.FixedAssetId = pt3.FixedAssetId

	/*subquery to get date date received*/


	LEFT JOIN (SELECT MAX(pd4.dateadded) AS [dateReceived], 
						pd4.FixedAssetId

				FROM parttransferdtl(NOLOCK) pd4
				WHERE source = 'it' AND Dest = 'av'
				GROUP BY fixedassetid) PT4 ON f.FixedAssetId = pt4.FixedAssetId


	/*subquery to pull sums of LIFETIME operations history of asset*/

	LEFT JOIN (SELECT
	  fixedassetid,
	  SUM(r5.operhrs) AS "TotalOperHrs",
	  SUM(r5.circhrs) AS "TotalCircHrs",
	  SUM(CONVERT(decimal(18, 5), ISNULL(tc5.losttime, 0))) AS "TotalNPTHrs",
	  SUM(CONVERT(int, tc5.CSI)) AS "TotalCSI",
	  SUM(CONVERT(int, tc5.TFF)) AS "TotalTFF",
	  MAX(CONVERT(int, r5.MaxTempF)) AS "MaxTempLifetimeF",
	  MAX(CONVERT(int, r5.MaxTempc)) AS "MaxTempLifetimeC"

	FROM relbusinessintelligencedataset(NOLOCK) r5
	LEFT JOIN ToolStringComponentInfo tc5 ON tc5.RunID = r5.runid

	GROUP BY FixedAssetID) rel1
	 ON rel1.FixedAssetID = f.FixedAssetId


	WHERE f.assetnumber IS NOT NULL
	AND ps.IsDisposed = '0'
	AND f.EquipmentStatus <> '50'
	AND gp.Id = '1'
	AND f.RNItemNum IS NOT NULL


END
GO
ALTER PROCEDURE [dbo].[usp_GetFixedAssetInfo]
	@xmlData AS XML
AS
BEGIN

SET NOCOUNT ON;

DECLARE @FixedAssetId UNIQUEIDENTIFIER
--DECLARE @AssetNumber varchar(10) 

SELECT @FixedAssetId = T.c.value('(FixedAssetId/text())[1]', 'uniqueidentifier')
FROM @xmlData.nodes('/Filters') T(c);

--select @AssetNumber = AssetNumber from FixedAssets (NOLOCK)
--where FixedAssetId = @FixedAssetId 

--- Asset Info Panel ---
SELECT  fa.FixedAssetId, fa.SerialNum, fa.LegacySerialNumber, fa.InventoryItemNum, fa.RNItemNum,
		pfa.SerialNum AS ParentSerialNum,pfa.InventoryItemNum As ParentInventoryItemNum, pfa.RNItemNum AS ParentRNItemNum, pfa.AssetNumber AS ParentAssetNumber,				
		fa.AssetDescription as FixedAssetDescription,
		i.DescShort as AssetDescription,
		ri.DescShort as RNAssetDescription,
		i.DescLong as InventoryDescLong,
		fa.BranchPlant, fa.Ownership, fa.AssetNumber,
		fa.ManufacturersSerialNumber, 
		fa.EquipmentStatus, fa.LastStatusChangeDate,
		fa.PhysicalLocation, fa.CatCode16, fa.Cost, fa.NetBookValue, 
		fa.AccumDepreciation, fa.CurrencyCode, fa.ContractAccount, fa.DateAcquired, fa.LifeMonths, 
		fa.StartDepreciation_Date, fa.NewUsed, fa.Manufacturer, fa.ModelYear, fa.DateDisposed, 
		fa.FiscalYear,fa.LedgerType
		, CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN
			(SELECT TOP 1 SendingLocation FROM PartTransferDtl ptd WITH(NOLOCK)
				WHERE ptd.FixedAssetId=fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')
				ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC) ELSE NULL 
		  END AS SourceBranchPlant
		, CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN
			(SELECT TOP 1 ReceivingLocation FROM PartTransferDtl ptd WITH(NOLOCK)
				WHERE ptd.FixedAssetId=fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')
				ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC) ELSE NULL
		  END AS DestBranchPlant
		, (SELECT TOP 1 ReceivingLocation FROM PartTransferDtl ptd WITH(NOLOCK)
				LEFT OUTER JOIN BranchPlants(NOLOCK) ibp ON ibp.BranchPlant = ptd.ReceivingLocation
				WHERE ptd.FixedAssetId = fa.FixedAssetId AND ibp.IsOperationsBillableLocation = 1 
				ORDER BY ptd.DateofTransaction DESC, ptd.JDETransactionID DESC, ptd.DateAdded DESC
			) AS LastBillableBranchPlant,
		ISNULL(ri.ToolPanel, i.ToolPanel) as ToolPanel, 
		ISNULL(ri.ToolCode, i.ToolCode) as ToolCode, 
		ISNULL(ri.ItemNum3, i.ItemNum3) as ItemNum3, 
		ISNULL(ri.PartClassification, i.PartClassification) as PartClassification,
		i.Size, i.DescShort, i.DescLong, i.Critical, i.ToolPerJob, fa.ThirdItemNumber,
		fa.FirmwareVersion,
		fa.MasterFirmwareItemNum,
		fa.MasterFirmwareRevision,
		
		inbp.HTSUS, inbp.ECCN,
		
		bp.Country, bp.Region, 
		
		ps.Status AS StatusDesc,
		
		j.JobNumber, bp.CompanyName as BranchPlantName, j.JobId

FROM dbo.FixedAssets (NOLOCK) fa
LEFT JOIN dbo.ItemNums (NOLOCK) i ON i.ItemNum = fa.InventoryItemNum
LEFT JOIN dbo.ItemNums (NOLOCK) ri ON ri.ItemNum = fa.RNItemNum
LEFT JOIN dbo.ItemNumBranchPlants (NOLOCK) inbp ON inbp.BranchPlant = fa.BranchPlant AND inbp.ItemNum = fa.InventoryItemNum
LEFT JOIN dbo.BranchPlants (NOLOCK) bp ON bp.BranchPlant = fa.BranchPlant
LEFT JOIN dbo.PartStatus (NOLOCK) ps ON ps.Code = fa.EquipmentStatus
LEFT JOIN dbo.DispatchInstanceItems (NOLOCK) dii ON dii.SerialNum = fa.SerialNum
LEFT JOIN dbo.DispatchInstances (NOLOCK) di ON di.DispatchInstanceId = dii.DispatchInstanceId
LEFT JOIN dbo.Dispatches (NOLOCK) d ON d.DispatchId = di.DispatchId
LEFT JOIN dbo.Jobs (NOLOCK) j ON j.JobId = d.JobId
LEFT OUTER JOIN dbo.FixedAssets (NOLOCK) pfa ON pfa.FixedAssetId = fa.ParentFixedAssetId
WHERE fa.FixedAssetId=@FixedAssetId


--- Documents Grid ---
SELECT dia.DocItemId, di.DocItemTitle, di.DocItemDesc, di.DocItemFileSize, di.DocItemDate, p.WO_NO, p.PFTWOId,di.DocumentCategory
FROM dbo.DocItemAttach (NOLOCK) dia
LEFT JOIN dbo.DocItems (NOLOCK) di ON di.DocItemId = dia.DocItemId
LEFT JOIN dbo.PFTWO (NOLOCK) p ON p.PFTWOId = dia.GuidKeyId
WHERE di.DocItemType = 1 AND p.FixedAssetId = @FixedAssetId
UNION
SELECT dia.DocItemId, di.DocItemTitle, di.DocItemDesc, di.DocItemFileSize, di.DocItemDate, NULL, NULL,di.DocumentCategory
FROM dbo.DocItemAttach (NOLOCK) dia
LEFT JOIN dbo.DocItems (NOLOCK) di ON di.DocItemId = dia.DocItemId
WHERE di.DocItemType = 1 AND dia.GuidKeyId = @FixedAssetId

ORDER BY di.DocItemTitle



END

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Yogesh
-- Create date: 10/13/2016
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[udf_GetAIRTApproverLevel]
(
	-- Add the parameters for the function here
	@ProductLine varchar(50),
	@LocId VARCHAR(16),
	@UserId int
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ApproverLevel INT = 0

	
    -- AIRT ADMIN
	IF EXISTS(SELECT DISTINCT u.UserId 
					FROM MCApprovers a (NOLOCK)
					INNER JOIN Users u (NOLOCK) ON u.UserId = a.UserId
					INNER JOIN UserProfile p on u.UserId = p.UserId			-- for Approval delegate
					LEFT JOIN Users u1 ON p.ApproverDelegate = u1.UserName
					WHERE ApprovalCode='AIRT' 
					AND ApproverType = 10
					AND (u.UserId = @UserId OR (u1.UserId = @UserId AND p.ApproverDelegateExpiryDate > GETDATE()))
					AND ((ProductLine = @ProductLine AND LocId = @LocId OR (ProductLine = @ProductLine AND LocId IS NULL)  
						OR (LocId = @LocId AND ProductLine IS NULL) OR (ProductLine IS NULL AND LocId IS NULL ) )))
		BEGIN
			SET @ApproverLevel = 2
		END
	-- Level 2 Approver
	ELSE IF EXISTS(SELECT DISTINCT u.UserId 
					FROM MCApprovers a (NOLOCK)
					INNER JOIN Users u (NOLOCK) ON u.UserId = a.UserId
					INNER JOIN UserProfile p on u.UserId = p.UserId			-- for Approval delegate
					LEFT JOIN Users u1 ON p.ApproverDelegate = u1.UserName
					WHERE ApprovalCode='AIRT' 
					AND ApproverType = 6
					AND (u.UserId = @UserId OR (u1.UserId = @UserId AND p.ApproverDelegateExpiryDate > GETDATE()))
					AND ((ProductLine = @ProductLine AND LocId = @LocId OR (ProductLine = @ProductLine AND LocId IS NULL)  OR (LocId = @LocId AND ProductLine IS NULL) OR (ProductLine IS NULL AND LocId IS NULL ) )))
		BEGIN
			SET @ApproverLevel = 2
		END
	-- Level 1 Approver
	ELSE IF EXISTS(SELECT DISTINCT u.UserId 
					FROM MCApprovers a (NOLOCK)
					INNER JOIN Users u (NOLOCK) ON u.UserId = a.UserId
					INNER JOIN UserProfile p on u.UserId = p.UserId			-- for Approval delegate
					LEFT JOIN Users u1 ON p.ApproverDelegate = u1.UserName
					WHERE ApprovalCode='AIRT' 
					AND ApproverType = 5
					AND (u.UserId = @UserId OR (u1.UserId = @UserId AND p.ApproverDelegateExpiryDate > GETDATE()))
					AND ((ProductLine = @ProductLine AND LocId = @LocId OR (ProductLine = @ProductLine AND LocId IS NULL)  OR (LocId = @LocId AND ProductLine IS NULL) OR (ProductLine IS NULL AND LocId IS NULL ) )))
		BEGIN
			SET @ApproverLevel = 1
		END
	ELSE IF EXISTS (SELECT * FROM UserRoles WHERE UserId = @UserId AND RoleId in (1))
		BEGIN
			SET @ApproverLevel = 2
		END


	-- Return the result of the function
	RETURN @ApproverLevel

END
GO
--==================================================================
--CREATED BY : SUYEB MOHAMMAD
--CREATED ON : 20 Oct 2016
--DESCIPTION : To get asset status for job history icon
--===================================================================
CREATE FUNCTION [dbo].[ufnGetAssetStatusforJobHistory](@RunId UNIQUEIDENTIFIER,@FixedAssetId UNIQUEIDENTIFIER)
RETURNS INT
AS
BEGIN
	DECLARE @CSISUM INT = 0;
	DECLARE @Result INT = 1;
	SELECT  @CSISUM = ISNULL(SUM(CAST(CSI AS INT)), 0) FROM ToolStringComponentInfo(NOLOCK) WHERE RunID = @RunId AND FixedAssetID = @FixedAssetId
	
	IF(@CSISUM >= 1)
	BEGIN SET @Result = 3 END
	ELSE
		BEGIN
		SELECT  @CSISUM = ISNULL(SUM(CAST(CSI AS INT)), 0) FROM ToolStringComponentInfo(NOLOCK) WHERE RunID = @RunId AND FixedAssetID != @FixedAssetId	
		IF(@CSISUM >= 1)
		SET @Result = 2				
	END

	RETURN @Result
END
GO
-- =============================================
-- Author:	Yogesh Mane
-- Create date: 7 Oct 2016
-- Description:	Get Disposition History
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetDispositionHistory]
	@AssetRepairTrackId uniqueidentifier
AS

BEGIN

	SET NOCOUNT ON;
	
	--Get Disposition history 
	SELECT d.DispositionId,
			d.Disposition,
			so.OptionLabel [DispositionDesc],
			CONVERT(VARCHAR(MAX), d.shiptolocation) + ' - ' + ISNULL(b.CompanyName,'') [ShipToBranchPlantName],
			u.FirstName + ' ' + u.LastName [DispositionedBy],
			d.DispositionDate,
			d.ShipToLocation,
			d.DispositionComments,
			d.[Status],
			d.ApprovalLevel
	FROM AssetRepairTrack A
	LEFT JOIN AuditARTDispositions d on a.AssetRepairTrackId = d.AssetRepairTrackId
	LEFT JOIN Users u on u.userid = d.DispositionedById
	LEFT JOIN BranchPlants b on b.branchplant = d.shiptolocation
	LEFT OUTER JOIN SelectOptions so (NOLOCK) ON  so.SelectName = 'Disposition' AND so.OptionValue = d.Disposition
	WHERE A.AssetRepairTrackId = @AssetRepairTrackId
	ORDER BY d.DateAdded DESC

END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/25/2016
-- Description:	Get Job Information
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetJobInfo] 
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT a.JobId,
			a.IsAssetFromField, 
			a.IsRedTag [IsAssociatedWithFieldFailure], 
			a.NeedsCustomerFeedback,
			j.JobNumber,
			j.CustomerId,
			c.CustomerName,
			r.Well [FailedWell],
			r.RunNumber [FailedRunNumber],
			a.IncidentId
	FROM AssetRepairTrack a (NOLOCK)
	LEFT JOIN Jobs J (NOLOCK) ON J.JobId = a.JobId
	LEFT JOIN Customers c (NOLOCK) ON C.CustomerId = J.CustomerId
	LEFT JOIN (SELECT TOP 1 j.JobId, 
					r.Well, 
					r.RunNumber
			FROM RelBusinessIntelligenceDataSet r (NOLOCK)
			Join Jobs J (NOLOCK) on j.JobNumber = r.JobNumber
			JOIN AssetRepairTrack a (NOLOCK) ON a.JobId = j.JobId
			Where a.AssetRepairTrackId = @AssetRepairTrackId and r.TFF = '1') R ON r.JobId = a.JobId
	WHERE a.AssetRepairTrackId = @AssetRepairTrackId
END
GO
-- =============================================
-- Author:	Yogesh Mane
-- Create date: 7 Oct 2016
-- Description:	Get Disposition Failure Codes
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetDispositionFailureCodes]
	@AssetRepairTrackId uniqueidentifier
AS

BEGIN

	SET NOCOUNT ON;

	
 --Failure codes
	SELECT 
		f.FailureCodeId,
		f1.FailureCategoryCode + f2.FailureSubCategoryCode + f.FailureCode [FailureCode],
		f1.FailureCategoryId,
		f2.FailureSubCategoryId,
		F.FailureDesc FailureCodeDesc,
		P.FailureCodeId ProcedureCodeId,
	    P1.FailureCategoryCode + P2.FailureSubCategoryCode + P.FailureCode [ProcedureCode],
		P.FailureDesc ProcedureCodeDesc,
		O.FailureCodeId OutOfSpecCodeId,
		O1.FailureCategoryCode + O2.FailureSubCategoryCode + O.FailureCode [OutOfSpecCode],

		O.FailureDesc OutOfSpecCodeDesc,
		A.ItemNum,A.Status
	FROM AssetRepairTrack A 
	LEFT JOIN FailureCodes F ON F.FailureCodeId = A.FailureCodeId
	LEFT JOIN FailureCategories F1 ON F1.FailureCategoryId = f.FailureCategoryId
	LEFT JOIN FailureSubCategories F2 ON F2.FailureSubCategoryId = f.FailureSubCategoryId

	LEFT JOIN FailureCodes P ON P.FailureCodeId = A.ProceduralCodeId
	LEFT JOIN FailureCategories P1 ON P1.FailureCategoryId = P.FailureCategoryId
	LEFT JOIN FailureSubCategories P2 ON P2.FailureSubCategoryId = P.FailureSubCategoryId

	LEFT JOIN FailureCodes O ON O.FailureCodeId = A.OutOfSpecCodeId
	LEFT JOIN FailureCategories O1 ON O1.FailureCategoryId = O.FailureCategoryId
	LEFT JOIN FailureSubCategories O2 ON O2.FailureSubCategoryId = O.FailureSubCategoryId
	WHERE A.AssetRepairTrackId=@AssetRepairTrackId

END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/31/2016
-- Description:	Get PFT Details
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetPFT] 
	-- Add the parameters for the stored procedure here
	@PFTWOId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FixedAssetId uniqueidentifier, @IsFirmwarePresent bit
	SELECT @FixedAssetId = (SELECT FixedAssetId 
								FROM AssetRepairTrack a (NOLOCK)
								WHERE a.ITPFTWOId = @PFTWOId OR a.SRPFTWOId = @PFTWOId)

	IF EXISTS(SELECT ItemNum FROM SensorItemNums WHERE ItemNum = (SELECT InventoryItemNum FROM FixedAssets Where FixedAssetId = @FixedAssetId))
		BEGIN
			SET @IsFirmwarePresent=1
		END
    ELSE IF EXISTS(SELECT BoardItemNum FROM BoardItemNums WHERE BoardItemNum = (SELECT InventoryItemNum FROM FixedAssets Where FixedAssetId = @FixedAssetId))
		BEGIN
			SET @IsFirmwarePresent=1
		END

	-- PFT Header

	SELECT p.PFTWOId, 
			pc.ProcessName, 
			p.Active, 
			p.PFTType,
			ISNULL(@IsFirmwarePresent,0) [IsFirmwarePresent]
	FROM PFTWO p (NOLOCK)
	LEFT JOIN PFTConfig pc (NOLOCK) on p.PFTConfigId = pc.PFTConfigId
	WHERE p.PFTWOId = @PFTWOId

	-- PFT Detail

	SELECT 
	p.HasAttachment, 
	p.Seq, 
	p.SeqName, 
	p.SeqDesc, 
	p.PFTResult, 
	p.Hours, 
	p.Comment, 
	p.LabName, 
	p.UserName, 
	ISNULL(u.LastName,'') + ', ' + ISNULL(u.FirstName,'') [UserFullName], 
	p.DateAdded
	FROM vwPFTWOSeq p (NOLOCK)
	LEFT JOIN Users u (NOLOCK)  ON p.UserId = u.UserId
	WHERE PFTWOId = @PFTWOId
	ORDER BY p.DateAdded ASC
END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/25/2016
-- Description:	Get Job Information
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetScoreBoard] 
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FixedAssetId Uniqueidentifier

	SELECT @FixedAssetId = FixedAssetId FROM AssetRepairTrack (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId

	SELECT (SELECT CASE WHEN (SELECT COUNT(*)  
									FROM AssetRepairTrack a 
									LEFT JOIN PFTWO p (NOLOCK) on a.ITPFTWOId = p.PFTWOId
									LEFT JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
									WHERE a.AssetRepairTrackId = @AssetRepairTrackId AND ps.PFTResult = 'F') > 0 THEN 4

							WHEN (SELECT COUNT(*)  
								FROM AssetRepairTrack a 
								LEFT JOIN PFTWO p (NOLOCK) on a.ITPFTWOId = p.PFTWOId
								LEFT JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
								WHERE a.AssetRepairTrackId = @AssetRepairTrackId AND ps.PFTResult != 'F') > 0 THEN 3

							WHEN (SELECT 1  
									FROM AssetRepairTrack a (NOLOCK) 
									WHERE a.AssetRepairTrackId = @AssetRepairTrackId AND ITPFTWOId IS NOT NULL) > 0 THEN 2

							ELSE 1 END) [TIPFT],

			(SELECT CASE WHEN  Status = 'Approved' THEN 3
										WHEN Status = 'District Approved' THEN 2
										WHEN Status = 'Submitted' THEN 1
									ELSE NULL END
							FROM (SELECT TOP 1 Status
							FROM ARTDispositions a (NOLOCK)
							Where a.AssetRepairTrackId = @AssetRepairTrackId
							ORDER BY DateAdded desc) A) [Disposition],

							-- If SR PFT is closed show green
			(SELECT CASE WHEN (SELECT 1 FROM AssetRepairTrack a 
								LEFT JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
								WHERE a.AssetRepairTrackId = @AssetRepairTrackId AND p.Active = 0) > 0 THEN 3

							WHEN (SELECT COUNT(*)  
								FROM AssetRepairTrack a 
								LEFT JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
								LEFT JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
								WHERE a.AssetRepairTrackId = @AssetRepairTrackId AND ps.PFTResult = 'F') > 0 THEN 4

							WHEN (SELECT COUNT(*)  
								FROM AssetRepairTrack a 
								LEFT JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
								LEFT JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
								WHERE a.AssetRepairTrackId = @AssetRepairTrackId AND ps.PFTResult != 'F' and p.Active = 0) > 0 THEN 3

							WHEN (SELECT 1
										FROM AssetRepairTrack a 
										JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
										WHERE a.AssetRepairTrackId = @AssetRepairTrackId AND p.PFTConfigId IS NOT NULL) > 0 THEN 2

							WHEN (SELECT 1  
									FROM AssetRepairTrack a (NOLOCK) 
									WHERE a.AssetRepairTrackId = @AssetRepairTrackId AND SRPFTWOId IS NOT NULL) > 0 THEN 1
							END) [SRPFT],

			(SELECT CASE WHEN w.Status = 'Closed' THEN 3
										WHEN w.JDEWorkOrderNum IS NULL THEN 2
										WHEN w.Status = 'Open' THEN 1
									ELSE NULL END
								FROM AssetRepairTrack a (NOLOCK) 
								JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
								JOIN WorkOrders w (NOLOCK) on w.WorkOrderId = p.WorkOrderId
								WHERE a.AssetRepairTrackId = @AssetRepairTrackId) [WorkOrder],

			(SELECT p.WorkOrderId
								FROM AssetRepairTrack a (NOLOCK) 
								JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
								WHERE a.AssetRepairTrackId = @AssetRepairTrackId) [WorkOrderId],

			(SELECT CASE WHEN a.IsAssetFromField = 1 AND JobId IS NOT NULL THEN 3
										WHEN a.IsAssetFromField = 1 AND JobId IS NULL THEN 2
										ELSE 1 END
								 FROM AssetRepairTrack a (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId) [JobMapping],

			(CASE WHEN (SELECT COUNT(*) 
					FROM VwChangeNoticeParts				 
					WHERE (FixedAssetId = @FixedAssetId OR TopLevelFixedAssetId = @FixedAssetId) 
					AND ( NotApplicable = 0 ))  > 0 THEN 1 
					ELSE 2 END) [TCN],

			(SELECT CASE WHEN  LOWER(OpenClosed) = 'c' THEN 1
					WHEN LOWER(OpenClosed) In('o','i','h') THEN 2
					ELSE NULL END
				FROM (SELECT R.OpenClosed FROM Requests R
				INNER JOIN AssetRepairTrack AR ON AR.NCRNumber = R.RequestId
				WHERE AR.AssetRepairTrackId=  @AssetRepairTrackId) A) [NCR],

			(SELECT NCRNumber FROM AssetRepairTrack WHERE AssetRepairTrackId = @AssetRepairTrackId) [NCRNumber]

END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/25/2016
-- Description:	Get Asset Data 
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetAssetData] 
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Get Asset History
	exec dbo.usp_CBM_GetAssetHistory @AssetRepairTrackId, @UserId
	
	-- Get Job History
	exec dbo.usp_CBM_GetJobHistory @AssetRepairTrackId, @UserId
	
END
GO
-- =============================================
-- Author:	Yogesh Mane
-- Create date: 7 Oct 2016
-- Description:	Get Disposition
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetDispositionHeader]
	@AssetRepairTrackId uniqueidentifier
AS

BEGIN

	SET NOCOUNT ON;

	--Disposition Types (for dropdownlist) 
	SELECT 
		OptionValue,
		OptionLabel 
	FROM SelectOptions 
	WHERE selectname='Disposition'
	ORDER BY SortOrder, OptionValue

	--Branch Plant - for dropdownlist

	SELECT BranchPlant, 
			BranchPlant + ' - ' + CompanyName BranchPlantName
	FROM BranchPlants 
	WHERE IsGlobalRepair = 1
	Order By BranchPlant
	
	--Get failed sequence details
	SELECT 
		A.SeqName,
		A.Comment,
		A.UserName,
		A.DateAdded
	FROM vwPFTWOSeq A
	INNER JOIN AssetRepairTrack B ON B.ITPFTWOId = A.PFTWOId
	WHERE B.AssetRepairTrackId = @AssetRepairTrackId and a.PFTResult = 'F'

END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/25/2016
-- Description:	Get Asset History
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetAssetHistory] 
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FixedAssetId Uniqueidentifier

	SELECT @FixedAssetId = FixedAssetId FROM AssetRepairTrack (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId

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
		WHERE w.FixedAssetId = @FixedAssetId
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
		0 [NoOfDaysInStatus],
		0 [AcquisitionCost],
		0 [NetBookValue],
		'' [BornOnDate],
		0 [SinceLastRepairOperHrs],
		0 [SinceLastRepairCirchrs],
		0 [SinceLastRepairDrillHrs]
  FROM ToolStringComponentInfo tc1 (NOLOCK)
  INNER JOIN Runs r1 (NOLOCK) ON r1.runid = tc1.runid
  WHERE @fixedassetid = tc1.FixedAssetID
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
    DATEDIFF(D, f2.LastStatusChangeDate, GETDATE()) AS [NoOfDaysInStatus],
    f2.cost AS [AcquisitionCost],
    f2.NetBookValue AS [NetBookValue],
    f2.DateAcquired AS [BornOnDate],
    0 [SinceLastRepairOperHrs],
    0 [SinceLastRepairCircHrs],
    0 [SinceLastRepairDrillHrs]
  FROM FixedAssets f2 (NOLOCK) 
  WHERE @fixedassetid = f2.FixedAssetId

  UNION ALL

  SELECT
    tca.fixedassetid,
    0 [LifetimeOperHrs],
    0 [LifetimeCircHrs],
    0 [LifetimeDrillingHrs],
    0 [CountOfRuns],
    0 [LifetimeTFFs],
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
		  WHERE art.FixedAssetId = @fixedassetid
			AND pwa.DateAdded < (SELECT DateAdded FROM AssetRepairTrack WHere AssetRepairTrackId = @AssetRepairTrackId)
		  GROUP BY art.FixedAssetId

  ) B ON b.fixedassetid = tca.fixedassetid AND ra.EndDate > b.Dateadded  
  WHERE @fixedassetid = tca.FixedAssetID
  GROUP BY tca.fixedassetid) a
  GROUP BY a.fixedassetid

END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/25/2016
-- Description:	Get Initial data for AIRT Edit Screen
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetInitData] 
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Get Control Enable/Diable or Show/Hide flags
	exec dbo.usp_CBM_GetControlDefaults @AssetRepairTrackId, @UserId

	-- Get Asset information
	exec dbo.usp_CBM_GetAssetInformation @AssetRepairTrackId, @UserId

	-- Get Score board
	exec dbo.usp_CBM_GetScoreBoard @AssetRepairTrackId, @UserId

	-- Get Job Information
	exec dbo.usp_CBM_GetJobInfo @AssetRepairTrackId, @UserId

	SELECT 'TI' [Type], ITPFTWOId [PFTId] FROM AssetRepairTrack Where AssetRepairTrackId = @AssetRepairTrackId
	UNION ALL
	SELECT 'SR' [Type], SRPFTWOId [PFTId] FROM AssetRepairTrack Where AssetRepairTrackId = @AssetRepairTrackId
END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/25/2016
-- Description:	Get Job Information
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetJobHistory] 
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FixedAssetId Uniqueidentifier

	SELECT @FixedAssetId = FixedAssetId FROM AssetRepairTrack (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId

	  SELECT
		dbo.ufnGetAssetStatusforJobHistory(r.RunID, @FixedAssetId) AS [status],
		r.RunID,
		j.JobId,
		CustomerName,
		JobNumber,
		b.BranchPlant,
		b.CompanyName AS BranchPlantCompanyName,
		Well,
		RunNumber,
		r.StartDate,
		r.EndDate,
		MdStart,
		MdStartUOM,
		MdEnd,
		MdEndUOM,
		p.SerialNum,
		itemNum.DescShort AS CompDesc,
		OperHrs,
		CircHrs,
		DrillHrs,
		IncidentNumber,
		i.IncidentId
  FROM ToolStringComponentInfo tsci WITH (NOLOCK) 
  INNER JOIN FixedAssets p WITH (NOLOCK) ON p.FixedAssetId = tsci.FixedAssetID
  INNER JOIN Runs r WITH (NOLOCK) ON r.RunID = tsci.RunID AND r.IsDeleted = 0
  INNER JOIN Wells w WITH (NOLOCK) ON w.WellID = r.WellID AND w.IsDeleted = 0
  INNER JOIN Jobs j WITH (NOLOCK) ON j.JobId = w.JobID AND j.IsDeleted = 0
  LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = j.BranchPlant
  LEFT JOIN Customers C WITH (NOLOCK) ON C.CustomerId = j.CustomerId
  LEFT JOIN Incidents i WITH (NOLOCK) ON i.RunID = r.RunID
  LEFT JOIN ItemNums itemNum WITH (NOLOCK) ON itemNum.ItemNum = p.InventoryItemNum
  WHERE p.FixedAssetId = @FixedAssetId
  ORDER BY r.EndDate DESC

END
GO
-- =============================================
-- Author:	Umesh Lade
-- Create date:11/02/2016
-- Description:	Get work order details
-- =============================================

CREATE PROCEDURE [dbo].[usp_CBM_GetWorkOrder] 
	@AssetRepairTrackId uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
--The query for Total Work Order cost
 SELECT 
	'$'+CONVERT(VARCHAR, CAST(ISNULL(j.actaullaborinusd,0) AS MONEY),1) [TotalLabor], 
	'$'+CONVERT(VARCHAR, CAST(ISNULL(j.ActualMaterialInUSD,0) AS MONEY),1) [TotalMaterial],
	'$'+CONVERT(VARCHAR, CAST(ISNULL(j.MiscCostInUSD,0)  AS MONEY),1) [TotalMiscCost],
	'$'+CONVERT(VARCHAR, CAST(ISNULL(j.actaulmisccostinusd,0) AS MONEY),1) [TotalWorkOrderCost]

FROM WorkOrders w
INNER JOIN PFTWO p ON p.WorkOrderId = w.WorkOrderId
INNER JOIN AssetRepairTrack a ON a.SRPFTWOId = p.PFTWOId
LEFT JOIN JDEWorkOrders j ON w.JDEWorkOrderNum = j.WorkOrderNumber
WHERE a.AssetRepairTrackId = @AssetRepairTrackId

--The query for Total Corrective Work Order cost 
SELECT 
	'$'+CONVERT(VARCHAR, CAST(ISNULL(j.actaullaborinusd,0) AS MONEY),1) [TotalLabor], 
	'$'+CONVERT(VARCHAR, CAST(ISNULL(j.ActualMaterialInUSD,0) AS MONEY),1) [TotalMaterial],
	'$'+CONVERT(VARCHAR, CAST(ISNULL(j.MiscCostInUSD,0)  AS MONEY),1) [TotalMiscCost],
	'$'+CONVERT(VARCHAR, CAST(ISNULL(j.actaulmisccostinusd,0) AS MONEY),1) [TotalWorkOrderCost]
FROM WorkOrders w
INNER JOIN PFTWO p ON p.WorkOrderId = w.WorkOrderId
INNER JOIN AssetRepairTrack a ON a.SRPFTWOId = p.PFTWOId
LEFT JOIN JDEWorkOrders j ON w.JDEWorkOrderNum = j.WorkOrderNumber and j.ordertype = 'wc'
WHERE a.AssetRepairTrackId = @AssetRepairTrackId 

--The Query for JDE work order
SELECT 
	j.WorkOrderNumber AS [JDEWONumber],	
	j.OrderType AS [WorkOrderType],
	j.WorkOrderStatusCode AS [WorkOrderStatus],
	j.DateAdded AS [DateCreated],
	j.CompletionDate AS [DateClosed],
	'$'+CONVERT(VARCHAR, CAST(j.actaullaborinusd AS MONEY),1) [Labor], 
	'$'+CONVERT(VARCHAR, CAST(j.ActualMaterialInUSD AS MONEY),1) [Material],
	'$'+CONVERT(VARCHAR, CAST(j.MiscCostInUSD  AS MONEY),1) [Misc],
	'$'+CONVERT(VARCHAR, CAST(j.actaulmisccostinusd AS MONEY),1) [TotalCost]

FROM JDEWorkOrders j
INNER JOIN WorkOrders w ON w.JDEWorkOrderNum = j.WorkOrderNumber
INNER JOIN PFTWO p ON p.WorkOrderId = w.WorkOrderId
INNER JOIN AssetRepairTrack a ON a.SRPFTWOId = p.PFTWOId
WHERE a.AssetRepairTrackId = @AssetRepairTrackId
END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 11/02/2016
-- Description:	Get TCN
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetToolChangeNotices] 
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FixedAssetId Uniqueidentifier

	SELECT @FixedAssetId = FixedAssetId FROM AssetRepairTrack (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId

	SELECT CNId,
		CNNum, 
		ECNNum, 
		CRNum, 
		CNDesc, 
		CNType, 
		DateCompleted, 
		u.UserName, 
		ISNULL(u.LastName,'') +', ' + ISNULL(u.FirstName, '') [FullName]
	FROM vwChangeNoticeParts v (NOLOCK)
	left join Users u (NOLOCK) on v.UserId = u.UserId 
	Where FixedAssetId = @FixedAssetId OR TopLevelFixedAssetId = @FixedAssetId AND NotApplicable = 0
	ORDER BY DateCompleted DESC

END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/13/2016
-- Description:	Create/Update disposition
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_SubmitDisposition]
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier, 
	@UserId int,
	@ApproverId int,
	@DispositionType int,
	@BranchPlant int,
	@Comments varchar(2048)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DispositionId INT,  @ApproverLevel INT, @sLocId varchar(16), @sProductLine varchar(50)

	SELECT @DispositionId = (SELECT TOP 1 DispositionId FROM ARTDispositions WHERE AssetRepairTrackId = @AssetRepairTrackId ORDER BY DateAdded DESC)
	SELECT @sLocId = a.FromBranchPlant, 
			@sProductLine = f.ProductLineCode
	FROM AssetRepairTrack a (NOLOCK)
	JOIN FixedAssets f (NOLOCK) on a.FixedAssetId = f.FixedAssetId 
	Where AssetRepairTrackId = @AssetRepairTrackId

	SET @ApproverLevel = dbo.udf_GetAIRTApproverLevel(@sProductLine, @sLocId, @UserId) 

	IF (@DispositionId IS NULL)
		BEGIN
			-- INSERT 

			INSERT INTO [dbo].[ARTDispositions]
				   ([AssetRepairTrackId]
				   ,[Disposition]
				   ,[DispositionedById]
				   ,[DispositionDate]
				   ,[DispositionComments]
				   ,[Status]
				   ,[ApproverId]
				   ,[ApprovalLevel]
				   ,[ShipToLocation]
				   ,[UserIdAdded]
				   ,[DateAdded])
			 VALUES
				   (@AssetRepairTrackId
				   ,@DispositionType
				   ,@UserId
				   ,GETDATE()
				   ,@Comments
				   ,CASE WHEN @DispositionType = 1 OR @DispositionType = 4 THEN (CASE WHEN @ApproverLevel > 0 THEN 'Approved' ELSE 'Submitted' END)
						ELSE (CASE WHEN @ApproverLevel > 1 THEN 'Approved' 
								WHEN @ApproverLevel = 1 THEN 'District Approved' 
								ELSE 'Submitted' END) 
						END
				   ,@ApproverId
				   ,@ApproverLevel 
				   ,@BranchPlant
				   ,@UserId
				   ,GETDATE())

				   SET @DispositionId = @@IDENTITY
			exec spAuditRecords 201, @UserId, @DispositionId, null, @DispositionId, 'ARTDispositions', 'DispositionId', 'AuditARTDispositions', null

		END
	ELSE
		BEGIN
	
			-- UPDATE
	
			UPDATE [dbo].[ARTDispositions]
				SET [Disposition] = @DispositionType
					,[DispositionedById] = @UserId
					,[DispositionDate] = GETDATE()
					,[DispositionComments] = @Comments
					,[Status] = CASE WHEN @ApproverLevel = 2 THEN 'Approved' 
									WHEN @ApproverLevel = 1 THEN 'District Approved' 
									ELSE 'Submitted' END
					,[ApproverId] = @ApproverId
					,[ApprovalLevel] = @ApproverLevel
					,[ShipToLocation] = @BranchPlant
					,[UserIdAdded] = @UserId
					,[DateAdded] = GETDATE()
				WHERE DispositionId = @DispositionId

			exec spAuditRecords 201, @UserId, @DispositionId, null, @DispositionId, 'ARTDispositions', 'DispositionId', 'AuditARTDispositions', null

			IF EXISTS(SELECT 1 FROM ARTDispositions WHERE DispositionId = @DispositionId AND Status = 'Approved')
			BEGIN
				UPDATE AssetRepairTrack 
					SET ShipToBranchPlant = @BranchPlant
				Where AssetRepairTrackId = @AssetRepairTrackId
			END
		END

		SELECT TOP 1 * FROM [ARTDispositions] (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId 
		ORDER BY DateAdded DESC
END
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 10/25/2016
-- Description:	Get Asset Information
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetAssetInformation] 
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FixedAssetId Uniqueidentifier

	SELECT @FixedAssetId = FixedAssetId FROM AssetRepairTrack (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId

	SELECT 
		-- General Info
		a.ARTNumber, 
		a.Status, 
		(SELECT ISNULL(LastName,'') + ', '+ ISNULL(FirstName,'') FROM Users Where UserName = a.AddedBy) [AddedBy], 
		a.DateAdded [DateCreated], 
		f.FixedAssetId,
		f.SerialNum, 
		f.AssetNumber, 
		f.Revision, 
		(SELECT Status FROM PartStatus WHERE Code = f.EquipmentStatus) + ' ('+f.EquipmentStatus+')' [AssetStatus],  
		f.EquipmentStatus,
		f.RNItemNum,
		f.InventoryItemNum,
		a.ItemDesc [ItemDescription],
		a.NCRNumber,
		a.ItemNum,

		-- Location Info
		f.FixedAssetBranchPlant,
		a.FromBranchPlant [FromBranchPlant],
		b.CompanyName [FromBranchBranchDesc],
		a.ShipToBranchPlant [ShipToBranchPlant],
		b1.CompanyName [ShipToBranchDesc],
		f.IsDisposed [IsDisposed],
		--CASE WHEN f.EquipmentStatus = 'IN' THEN 1 ELSE 0 END [IsInstalled],
		--CASE WHEN f.EquipmentStatus = 'IT' THEN 1 ELSE 0 END [IsInTransit],
		--CASE WHEN f.EquipmentStatus = 'PT' THEN 1 ELSE 0 END [IsInPendingTransit],
		b1.IsNonLiveLocation,
		CASE WHEN (SELECT COUNT(*) FROM UserRoles Where UserId = @UserId AND RoleId IN (1, 1001)) > 0 THEN 1 ELSE 0 END [IsAIRTAdmin]
	FROM AssetRepairTrack a (NOLOCK)
	LEFT JOIN vwFixedAssets f (NOLOCK) ON a.FixedAssetId = f.FixedAssetId
	LEFT JOIN BranchPlants b (NOLOCK) ON b.BranchPlant = a.FromBranchPlant
	LEFT JOIN BranchPlants b1 (NOLOCK) ON b1.BranchPlant = a.ShipToBranchPlant
	
	Where a.AssetRepairTrackId = @AssetRepairTrackId

END
GO
-- =============================================
-- Author:		Shailesh Patil
-- Create date: 10/14/2016
-- Description:	Rollback Disposition
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_RollbackDisposition]
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier, 
	@UserId int
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @DispositionId INT	

	SELECT @DispositionId = (SELECT TOP 1 DispositionId FROM ARTDispositions WHERE AssetRepairTrackId = @AssetRepairTrackId ORDER BY DateAdded DESC)


	--Set last disposition recored status as 'Submitted' 
	UPDATE ARTDispositions 
		SET DispositionedById = @UserId,
			DispositionDate = GETDATE(),
			Status = 'Submitted',
			DispositionComments = '',
			UserIdAdded = @UserId,
			DateAdded = GETDATE()
			WHERE DispositionId=@DispositionId

	exec spAuditRecords 201, @UserId, @DispositionId, null, @DispositionId, 'ARTDispositions', 'DispositionId', 'AuditARTDispositions', null

	--Delete all other records for this disposition
	DELETE FROM ARTDispositions WHERE AssetRepairTrackId = @AssetRepairTrackId AND DispositionId <> @DispositionId AND Status <> 'Approved'

	--To maintain Audit Log
	--cursor or triggers

END
GO
-- =============================================
-- Author:  	Yogesh Mane
-- Create date: 10/25/2016
-- Description:	Get Control Show/Hide or Enable/Disable flags
-- =============================================
CREATE PROCEDURE [dbo].[usp_CBM_GetControlDefaults]
	-- Add the parameters for the stored procedure here
	@AssetRepairTrackId uniqueidentifier,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @CanCloseAIRT bit = 0,
			@CanReopenAIRT bit = 0,
			@CanUpdateAssetStatus bit = 0,
			@CanUpdateJobInfo bit = 0,
			@CanViewDisposition bit = 0,
			@CanUpdateFailureCode bit = 0,
			@CanPerformDisposition bit = 0,
			@CanPerformRollback bit = 0,
			@CanViewSRPFT bit = 0,
			@CanCreateSRPFT bit = 0,
			@CanViewWorkOrder bit = 0,
			@CanViewTCN bit = 0,
			@CanViewFirmware bit = 0
				
	

	DECLARE @ApproverLevel int, @ProductLine varchar(50), @LocId VARCHAR(16)
	DECLARE @FixedAssetId Uniqueidentifier

	SELECT @FixedAssetId = FixedAssetId FROM AssetRepairTrack (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId

	-- TCN Flag
	
	IF EXISTS(SELECT * FROM vwChangeNoticeParts v (NOLOCK) Where FixedAssetId = @FixedAssetId OR TopLevelFixedAssetId = @FixedAssetId AND NotApplicable = 0)
	BEGIN
		SET @CanViewTCN = 1
	END

	-- If Firmware present	
	IF EXISTS(SELECT ItemNum FROM SensorItemNums WHERE ItemNum = (SELECT InventoryItemNum FROM FixedAssets Where FixedAssetId = @FixedAssetId))
		BEGIN
			SET @CanViewFirmware = 1
		END
    ELSE IF EXISTS(SELECT BoardItemNum FROM BoardItemNums WHERE BoardItemNum = (SELECT InventoryItemNum FROM FixedAssets Where FixedAssetId = @FixedAssetId))
		BEGIN
			SET @CanViewFirmware = 1
		END
   

	-- iF AIRT is open
	IF EXISTS(SELECT * FROM AssetRepairTrack (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND Status = 'Open')
	BEGIN
	
		SELECT @CanUpdateAssetStatus = 1, @CanUpdateJobInfo = 1

		-- If T&I PFT is closed
		IF EXISTS(SELECT COUNT(*) FROM PFTWO p (NOLOCK) WHERE p.PFTType = 2 AND AssetRepairTrackId = @AssetRepairTrackId AND p.Active = 0)
		BEGIN

			--Check if T&I PFT passed
			IF NOT EXISTS(SELECT *
						FROM PFTWO p (NOLOCK)
						JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
						WHERE p.AssetRepairTrackId = @AssetRepairTrackId AND p.PFTType = 2 AND ps.PFTResult = 'F')
				BEGIN
					SET @CanCloseAIRT = 1
				END

			ELSE
				BEGIN

					-- since T&I completed with steps failed, disposition can be viewed
					SET @CanViewDisposition = 1

					SELECT @LocId = a.FromBranchPlant, 
							@ProductLine = f.ProductLineCode
					FROM AssetRepairTrack a (NOLOCK)
					JOIN FixedAssets f (NOLOCK) on a.FixedAssetId = f.FixedAssetId 
					Where AssetRepairTrackId = @AssetRepairTrackId

					SELECT @ApproverLevel = dbo.udf_GetAIRTApproverLevel(@ProductLine, @LocId, @UserId)


					-- If T&I failed and Disposition done
					IF EXISTS(SELECT * FROM ARTDispositions (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND Status = 'Approved')
						BEGIN

								-- Disposition done but tool needs to undergo repair
								IF EXISTS(SELECT * FROM ARTDispositions (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND Status = 'Approved' AND Disposition IN (1,2))
									BEGIN		
										SELECT @CanViewSRPFT = 1

										-- If S&R PFT Not Created 
										IF NOT EXISTS(SELECT * FROM PFTWO (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND PFTType = 1)
											BEGIN
													
												SELECT @CanCreateSRPFT = 1

												-- disposition rollback possible if SRPFT not yet created
												IF (@ApproverLevel = 2)
												BEGIN
													SET @CanPerformRollback = 1
												END

											END
										-- If S&R PFT is created
										ELSE
											BEGIN
													
												SELECT @CanViewWorkOrder = 1

												-- If SR PFT is Created and also closed
												IF EXISTS(SELECT * FROM PFTWO (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND PFTType = 1 AND Active = 0)
													BEGIN
														SELECT @CanCloseAIRT = 1
													END
											END
									END
								ELSE
								
									BEGIN
										-- If Disposition done with 'Use As Is' or 'Scrap'
										SELECT @CanCloseAIRT = 1

									END
						END
					ELSE
						-- if T&I failed and disposition yet pending
						BEGIN
										
							
							DECLARE @DispositionStatus VARCHAR(50)
							SELECT @DispositionStatus = Status FROM ARTDispositions (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId

							IF EXISTS(SELECT * FROM AssetRepairTrack WHERE FailureCodeId IS NOT NULL AND ProceduralCodeId IS NOT NULL AND OutOfSpecCodeId IS NOT NULL)
								BEGIN

									IF(@DispositionStatus IS NULL)
										BEGIN
											SELECT @CanUpdateFailureCode = 1
											SET @CanPerformDisposition = 1
										END
									ELSE 
										BEGIN
												IF (@ApproverLevel > 0)
												BEGIN
												
														IF(@DispositionStatus = 'Submitted')
															BEGIN
																SET @CanPerformDisposition = 1
															END
														ELSE
															BEGIN
																IF (@ApproverLevel = 2)
																BEGIN
																	SET @CanPerformDisposition = 1
																END
															END
												END

										END
									END										 
						END
				END
		END
	END

	-- If AIRT is closed
	ELSE
		BEGIN
			SELECT @CanCloseAIRT = 0,
			@CanReopenAIRT = 1,
			@CanUpdateAssetStatus = 0,
			@CanUpdateJobInfo = 0,
			@CanViewDisposition = 1,
			@CanUpdateFailureCode = 0,
			@CanPerformDisposition = 0,
			@CanViewSRPFT = 1,
			@CanCreateSRPFT = 0,
			@CanViewWorkOrder = 1
		END
		

	-- Insert statements for procedure here
	SELECT  @CanCloseAIRT				[CanCloseAIRT],
			@CanReopenAIRT				[CanReopenAIRT],
			@CanUpdateAssetStatus		[CanUpdateAssetStatus],
			@CanUpdateJobInfo			[CanUpdateJobInfo],
			@CanViewFirmware			[CanViewFirmware],
			@CanViewDisposition			[CanViewDisposition],
			@CanUpdateFailureCode		[CanUpdateFailureCode],
			@CanPerformDisposition		[CanPerformDisposition],
			@CanPerformRollback			[CanPerformRollback],
			@CanViewSRPFT				[CanViewSRPFT],
			@CanCreateSRPFT				[CanCreateSRPFT],
			@CanViewWorkOrder			[CanViewWorkOrder],
			@CanViewTCN					[CanViewTCN],
			@ApproverLevel				[ApproverLevel]

END
GO


/****** Object:  View [dbo].[vwRMassetReport]    Script Date: 10/24/2016 4:41:44 AM ******/
DROP VIEW [dbo].[vwRMassetReport]
GO

/****** Object:  View [dbo].[vwRMassetReport]    Script Date: 10/24/2016 4:41:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--=======================================================================
--CREATED BY : SUYEB MOHAMMAD
--CREATED ON : 11 July 2016
--DESCRIPTION: To get RM asset report
--=======================================================================
CREATE VIEW [dbo].[vwRMassetReport]
AS
	SELECT * FROM dbo.AssetLifeCycleReportDataset 

GO

-- ARTDisposition Audit data generation
INSERT INTO AuditARTDispositions
SELECT (SELECT MAX(DispositionId) FROM AuditARTDispositions) + ROW_NUMBER() OVER(ORDER BY a.dateadded) [AuditActionId], a.* 
FROM ARTDispositions a
LEFT JOIN AuditARTDispositions a1 ON a.DispositionId = a1.DispositionId
WHERE a1.DispositionId is null
order by a.dateadded desc

GO
--T&I PFT
UPDATE P SET P.AssetRepairTrackId = A.AssetRepairTrackId 
FROM PFTWO P 
INNER JOIN AssetRepairTrack A ON A.ITPFTWOId = P.PFTWOId AND P.PFTType=2
	
--S&R PFT
UPDATE P SET P.AssetRepairTrackId = A.AssetRepairTrackId
FROM PFTWO P 
INNER JOIN AssetRepairTrack A ON A.SRPFTWOId = P.PFTWOId AND P.PFTType=1

GO

TRUNCATE TABLE dbo.PartClassifications

INSERT INTO dbo.PartClassifications
(PartClassification
,Level1
,Level2
,Level3
,Level4
,Level5)

SELECT DISTINCT SRP3 + (CASE WHEN ISNULL(SRP4,'') ='' THEN '' ELSE '/'+ SRP4 END) + (CASE WHEN ISNULL(SRP5,'') = '' THEN '' ELSE '/'+ SRP5 END) + (CASE WHEN ISNULL(SRP6,'') = '' THEN '' ELSE '/'+ SRP6 END),
SRP3, SRP4, SRP5, SRP6, NULL
FROM USDCSCDSQLPD001.[Windchill_Data].[dbo].[ClassPaths]
ORDER BY SRP3, SRP4, SRP5,SRP6

--SELECT * FROM dbo.PartClassifications

Update AesOps.dbo.ItemNums 
SET PartClassification = m.MetaValue
FROM AesOps.dbo.ItemNums i (NOLOCK)
JOIN AesOps.dbo.ItemNumMetadata m (NOLOCK) ON m.MetaName = 'Classification' AND i.itemNum = m.itemNum

-- TFS# 46439
update PartStatus set IsSrcStatus=1,IsDestStatus=1 where Code='RR'

-- TFS #46047
insert into SelectOptions values(NEWID(),'DocumentCategory','Damage Documentation','Damage Documentation',1,NULL,NULL,NULL)
insert into SelectOptions values(NEWID(),'DocumentCategory','Material Cert','Material Cert',2,NULL,NULL,NULL)
insert into SelectOptions values(NEWID(),'DocumentCategory','Misc Document','Misc Document',3,NULL,NULL,NULL)
insert into SelectOptions values(NEWID(),'DocumentCategory','Pictures','Pictures',4,NULL,NULL,NULL)
insert into SelectOptions values(NEWID(),'DocumentCategory','Test Results','Test Results',5,NULL,NULL,NULL)

GO
DELETE FROM MCApprovers Where ApproverType IN (5, 6, 10) AND ApprovalCode = 'AIRT'

INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '81482', '1330', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19620', '1330', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '81482', '1928', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19620', '1928', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10159', '1126', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117305', '5101', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117305', '6523', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117305', '6524', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '14790', '1331', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '14790', '4632', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '14790', '3170', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '14790', '4262', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '14790', '3637', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115295', '3614', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115296', '3614', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10246', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36338', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36328', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36330', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10151', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10246', '3351', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36338', '3351', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36328', '3351', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10151', '3351', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36338', '6219', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36338', '5997', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36328', '6219', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36328', '5997', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10151', '6219', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10151', '5997', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '74927', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '74927', '3778', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '112263', '4722', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '112263', '810', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '112263', '3727', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '112263', '4642', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '112263', '5468', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '112263', '3237', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '112263', '6082', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '12020', '3913', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '120241', '3913', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '118642', '3913', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '12020', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '120241', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '118642', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT',  NULL, '711', '10', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '1167', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '2657', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '6643', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '603', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '572', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '582', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '1246', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '4136', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '72325', '4060', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '533', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '2254', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '780', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117305', '5101', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '1061', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117305', '1930', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117305', '1164', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117305', '4545', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117305', '1781', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '14821', '4914', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '110200', '5772', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '21752', '5772', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '110199', '5271', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '110199', '2268', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '23375', '2036', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '23375', '1527', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '31109', '2036', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '31109', '1527', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '110199', '2269', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '23375', '2269', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '31109', '2269', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '21782', '2565', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '21782', '1546', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '21782', '1621', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '21782', '4816', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '21782', '2257', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '5946', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '6621', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '4961', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '4886', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '4762', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '4341', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '1822', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '3364', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '4633', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '4474', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '6289', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '4367', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '5831', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '3002', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '4937', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '3001', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '5274', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '91170', '4937', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '91170', '3002', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '91170', '3001', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '91170', '5274', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '158000', '1825', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '169980', '1825', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '126188', '1825', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '91170', '1825', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '14884', '6499', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '47265', '6499', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '14884', '4846', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '47265', '4846', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39773', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39771', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39774', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39772', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39775', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '1598', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115296', '1598', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115295', '1598', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '30392', '1598', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '184', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115295', '184', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115296', '184', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '30392', '184', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '1431', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115295', '1431', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '30392', '1431', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115295', '2499', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '30392', '2499', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '3614', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115296', '3614', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '115295', '3614', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '30392', '3614', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '76124', '4837', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '76124', '3635', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '76124', '5750', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '4482', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '4482', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '4763', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '4763', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '5505', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '974', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '974', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '974', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '974', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '2278', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '4017', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '4974', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '3253', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '1091', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '1091', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '1091', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '1091', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '152347', '1342', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '152347', '2221', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '152347', '2121', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '152347', '2723', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '171211', '3633', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '171211', '6002', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '171211', '2121', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '171211', '2723', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19302', '5616', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19302', '2121', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19302', '2723', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10151', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10151', '3351', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10151', '6219', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10151', '5997', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10246', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '10246', '3351', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36328', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36328', '3351', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36328', '6219', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36328', '5997', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36330', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36338', '3464', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36338', '3351', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36338', '6219', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '36338', '5997', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '74927', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '74927', '3778', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '125863', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '125863', '3778', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '125863', '3596', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39773', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39773', '1297', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39773', '5836', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39771', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39774', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39772', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '39775', '1892', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '12020', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '12020', '3778', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '12020', '3913', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '118642', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '118642', '3778', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '118642', '3913', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '120241', '2419', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '120241', '3778', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '120241', '3913', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '974', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '4763', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '4482', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '4017', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '3253', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '11505', '1091', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '974', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '4763', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '2278', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '4974', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '4482', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '5505', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '19418', '1091', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117310', '1525', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117310', '3884', '6', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117310', '4489', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117310', '3896', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117310', '4272', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117310', '4492', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117310', '4433', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', '117310', '5481', '5', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '515', '10', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '1484', '10', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '532', '10', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '1237', '10', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '3713', '10', GETDATE(), null, '0', NULL, NULL)
INSERT INTO [dbo].[MCApprovers] ([ApproverId] ,[ApprovalCode] ,[LocId] ,[UserId] ,[ApproverType] ,[DateAdded] ,[Amount] ,[IsDefault] ,[ProductLine] ,[DeptCode])	VALUES (NEWID(),'AIRT', NULL, '1506', '10', GETDATE(), null, '0', NULL, NULL)


SELECT * FROM MCApprovers Where ApproverType IN (5, 6, 10) AND ApprovalCode = 'AIRT'