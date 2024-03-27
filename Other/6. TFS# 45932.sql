
ALTER TABLE [dbo].[AssetLifeCycleReportDataset] DROP CONSTRAINT [DF_AssetLifeCycleReportDataset_CreatedOn]
GO

/****** Object:  Table [dbo].[AssetLifeCycleReportDataset]    Script Date: 9/26/2016 6:56:30 PM ******/
DROP TABLE [dbo].[AssetLifeCycleReportDataset]
GO

/****** Object:  Table [dbo].[AssetLifeCycleReportDataset]    Script Date: 9/26/2016 6:56:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AssetLifeCycleReportDataset](
	[FixedAssetId] [uniqueidentifier] NOT NULL,
	[SerialNum] [varchar](50) NULL,
	[AssetNumber] [varchar](30) NULL,
	[EquipmentStatus] [varchar](2) NULL,
	[RNItemNum] [varchar](30) NULL,
	[InventoryItemNum] [varchar](30) NULL,
	[ProductLineId] [int] NULL,
	[DescShort] [varchar](60) NULL,
	[ToolCode] [varchar](30) NULL,
	[ToolPanel] [varchar](30) NULL,
	[CurrentBranchplant] [varchar](12) NULL,
	[CompanyName] [varchar](50) NULL,
	[Country] [varchar](25) NULL,
	[Region] [varchar](25) NULL,
	[LastBillableBranchPlant] [varchar](250) NULL,
	[LastBillableBranchPlantName] [varchar](250) NULL,
	[LastBillableCountry] [varchar](250) NULL,
	[LastBillableRegion] [varchar](250) NULL,
	[DateToolTransferedfromOpsBillable] [varchar](10) NULL,
	[LatestAIRT] [varchar](25) NULL,
	[BPcreatingAIRT] [varchar](12) NULL,
	[BPrepairingAIRT] [varchar](12) NULL,
	[CurrentAIRTStatus] [varchar](20) NULL,
	[DateAIRTCreated] [varchar](10) NULL,
	[DateAIRTClosed] [varchar](10) NULL,
	[DispositionofAIRT] [varchar](19) NULL,
	[AIRTDispositionComments] [varchar](2048) NULL,
	[AIRTDispositionDate] [varchar](10) NULL,
	[Agesincelastrun] [varchar](10) NULL,
	[AgesincelastAIRTwasCreated] [varchar](10) NULL,
	[AgesincelastTIPFTstep] [varchar](10) NULL,
	[AgesinceAIRTwasDispositioned] [varchar](10) NULL,
	[DatesincetoolwaslastinOpsBillableBP] [varchar](10) NULL,
	[DateshippedtoAIRTshiptolocation] [varchar](10) NULL,
	[DatereceivedinAIRTshiptolocation] [varchar](10) NULL,
	[Dateoflastshipmentoftool] [varchar](10) NULL,
	[Datereceiptoftool] [varchar](10) NULL,
	[TransittimefromTesttoRepairlocation] [varchar](23) NULL,
	[latestrunenddate] [varchar](10) NULL,
	[latestjob] [varchar](50) NULL,
	[latestrunnumber] [varchar](50) NULL,
	[TotalLifetimeCSI] [int] NULL,
	[TotalLifetimeTFF] [int] NULL,
	[TotalLifetimeOperHrs] [float] NULL,
	[TotalLifetimeCircHrs] [float] NULL,
	[TotalLifetimeNPT] [decimal](18, 2) NULL,
	[LifetimeMaxTempC] [int] NULL,
	[LifetimeMaxTempF] [int] NULL,
	[TotalCSISLT] [int] NULL,
	[TotalTFFSLT] [int] NULL,
	[OperHrsSLT] [float] NULL,
	[CircHrsSLT] [float] NULL,
	[NPTHrsSLT] [decimal](18, 2) NULL,
	[MaxTempSLTC] [int] NULL,
	[MaxTempSLTF] [int] NULL,
	[AIRTCheck] [varchar](7) NULL,
	[JobCheck] [varchar](11) NULL,
	[MovementCheck] [varchar](16) NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[AssetLifeCycleReportDataset] ADD  CONSTRAINT [DF_AssetLifeCycleReportDataset_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO

GO
--=======================================================================
--CREATED BY : SUYEB MOHAMMAD
--CREATED ON : 11 July 2016
--DESCRIPTION: To get RM asset report
--=======================================================================
ALTER VIEW dbo.vwRMassetReport
AS
SELECT * FROM dbo.AssetLifeCycleReportDataset

GO