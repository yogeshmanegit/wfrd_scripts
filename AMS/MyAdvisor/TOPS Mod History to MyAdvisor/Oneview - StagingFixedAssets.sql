USE [oneviewtest]
GO

/****** Object:  Table [dbo].[StagingFixedAssets]    Script Date: 11/29/2023 7:11:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StagingFixedAssets](
	[FixedAssetId] [uniqueidentifier] NOT NULL,
	[SerialNum] [varchar](50) NULL,
	[InventoryItemNum] [varchar](30) NULL,
	[AssetNumber] [varchar](30) NULL,
	[BranchPlant] [varchar](75) NULL,
	[EquipmentStatus] [varchar](2) NULL,
	[RNItemNum] [varchar](30) NULL,
	[AssetDescription] [varchar](60) NULL,
	[LastStatusChangeDate] [datetime] NULL,
	[CurrencyCode] [varchar](3) NULL,
	[Revision] [varchar](2) NULL,
	[CatCode16] [varchar](3) NULL,
	[ToolPanel] [varchar](30) NULL,
	[ToolCode] [varchar](30) NULL,
	[DateAdded] [datetime] NULL,
	[BusinessUnit] [varchar](12) NULL,
	[ThirdItemNumber] [varchar](40) NULL,
	[AssetLifeRemaining] [numeric](6, 2) NULL,
	[Version] [varchar](4000) NOT NULL,
	[TopLevelFixedAssetId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO

USE [oneviewtest]
GO

/****** Object:  Index [IX_StagingFixedAssets]    Script Date: 11/29/2023 7:12:12 PM ******/
CREATE NONCLUSTERED INDEX [IX_StagingFixedAssets] ON [dbo].[StagingFixedAssets]
(
	[FixedAssetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

