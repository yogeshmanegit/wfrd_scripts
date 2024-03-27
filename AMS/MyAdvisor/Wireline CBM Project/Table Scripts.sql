USE [AesOps]
GO

ALTER TABLE [dbo].[OneViewCBMRunAssetMappings] DROP CONSTRAINT [DF_OneViewCBMRunAssetMappings_CreateOn]
GO

/****** Object:  Table [dbo].[OneViewCBMRunAssetMappings]    Script Date: 1/22/2023 3:28:41 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OneViewCBMRunAssetMappings]') AND type in (N'U'))
DROP TABLE [dbo].[OneViewCBMRunAssetMappings]
GO

/****** Object:  Table [dbo].[OneViewCBMRunAssetMappings]    Script Date: 1/22/2023 3:28:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OneViewCBMRunAssetMappings](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RunId] [uniqueidentifier] NOT NULL,
	[CbmMonitorId] int NOT NULL,
	[FixedAssetId] [uniqueidentifier] NOT NULL,
	[DurationInMinutes] [float] NOT NULL,
	[ImportDate] [datetime] NOT NULL,
	[ParentFixedAssetId] [uniqueidentifier] NULL,
	[TopLevelFixedAssetId] [uniqueidentifier] NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_OneViewCBMRunAssetMappings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OneViewCBMRunAssetMappings] ADD  CONSTRAINT [DF_OneViewCBMRunAssetMappings_CreateOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO

CREATE NONCLUSTERED INDEX [IX_OneViewCBMRunAssetMappings] ON [dbo].[OneViewCBMRunAssetMappings]
(
	[RunId], [CbmMonitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



USE [AesImport]
GO
CREATE NONCLUSTERED INDEX [IX_OneviewDurations_AssetNumber]
ON [dbo].[OneView_Job_JobOperations_assets_w_duration_for_MyAdvisor] ([AssetNumber])
INCLUDE ([Id],[DurationInMinutes],[DateUploaded])
GO