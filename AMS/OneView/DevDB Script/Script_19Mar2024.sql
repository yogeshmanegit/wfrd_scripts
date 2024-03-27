USE [oneviewtest]
GO
/****** Object:  Table [dbo].[AcquisitionSoftware]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AcquisitionSoftware](
	[acquisitionSoftwareId] [int] IDENTITY(1,1) NOT NULL,
	[acquisitionSoftware] [nvarchar](255) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_AcquisitionSoftware] PRIMARY KEY CLUSTERED 
(
	[acquisitionSoftwareId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AcquisitionSystem]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AcquisitionSystem](
	[acquisitionSystemId] [int] IDENTITY(1,1) NOT NULL,
	[acquisitionSystem] [nvarchar](255) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_AcquisitionSystem] PRIMARY KEY CLUSTERED 
(
	[acquisitionSystemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AcquisitionType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AcquisitionType](
	[acquisitionTypeID] [int] NOT NULL,
	[type] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_AcquisitionType] PRIMARY KEY CLUSTERED 
(
	[acquisitionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[id] [int] NULL,
	[address1] [nvarchar](300) NULL,
	[address2] [nvarchar](300) NULL,
	[city] [nvarchar](300) NULL,
	[province] [nvarchar](300) NULL,
	[country] [nvarchar](300) NULL,
	[postalcode] [nvarchar](300) NULL,
	[phone] [nvarchar](300) NULL,
	[fax] [nvarchar](300) NULL,
	[lat] [nvarchar](300) NULL,
	[long] [nvarchar](300) NULL,
	[primary] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[oneViewAddressID] [uniqueidentifier] NOT NULL,
	[modified] [datetime] NULL,
	[address3] [nvarchar](300) NULL,
	[address4] [nvarchar](300) NULL,
	[isWireline] [bit] NULL,
	[jdeAddressID] [numeric](8, 0) NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY NONCLUSTERED 
(
	[oneViewAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApproxTimeSelectionValues]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApproxTimeSelectionValues](
	[approxTimeSelectionValueID] [int] IDENTITY(1,1) NOT NULL,
	[value] [nvarchar](20) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_ApproxTimeSelectionValues] PRIMARY KEY CLUSTERED 
(
	[approxTimeSelectionValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[created] [datetime] NOT NULL,
	[modified] [datetime] NOT NULL,
	[modified_by] [nvarchar](100) NOT NULL,
	[active] [char](1) NOT NULL,
	[active_date] [datetime] NOT NULL,
	[region_id] [int] NOT NULL,
	[operational] [char](1) NULL,
	[geographic] [char](1) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetDetails]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetDetails](
	[AssetDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[FixedAssetId] [nvarchar](50) NULL,
	[TopLevelFixedAssetId] [nvarchar](50) NULL,
	[AssetNumber] [int] NULL,
	[AssetLifeRemaining] [numeric](6, 2) NULL,
	[LastStatusChangeDate] [nvarchar](50) NULL,
 CONSTRAINT [PK_AssetDetails] PRIMARY KEY CLUSTERED 
(
	[AssetDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[assets]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[assets](
	[assetID] [int] NOT NULL,
	[toolpaneltypeid] [nvarchar](20) NULL,
	[toolcodetypeid] [nvarchar](20) NULL,
	[version] [nvarchar](20) NULL,
	[serialnumber] [nvarchar](20) NULL,
	[stationid] [int] NULL,
	[description] [ntext] NULL,
	[toolstatusid] [int] NULL,
	[sapid] [int] NULL,
	[superiorsapid] [int] NULL,
	[jdeitemno] [int] NULL,
	[licence] [nvarchar](100) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[toolpanelcodeversionid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[assetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetServiceGroupExceptions]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetServiceGroupExceptions](
	[assetServiceGroupExceptionID] [int] IDENTITY(1,1) NOT NULL,
	[serviceGroupID] [int] NOT NULL,
	[assetID] [int] NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_AssetServiceGroupExceptions] PRIMARY KEY CLUSTERED 
(
	[assetServiceGroupExceptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[backup_wpts_jobpostings]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[backup_wpts_jobpostings](
	[jobID] [uniqueidentifier] NOT NULL,
	[wptsID] [int] NULL,
	[wptsPosted] [datetime] NULL,
	[maxLastUpdated] [binary](8) NULL,
	[error] [nvarchar](max) NULL,
	[wptsXML] [nvarchar](4000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticDetonator]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticDetonator](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticGunSize]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticGunSize](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticGunType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticGunType](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticIgniter]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticIgniter](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticInitiatorType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticInitiatorType](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticManufacturer]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticManufacturer](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticPhasing]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticPhasing](
	[id] [int] NOT NULL,
	[name] [smallint] NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticSPF]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticSPF](
	[id] [int] NOT NULL,
	[name] [smallint] NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BallisticTypeOfCharge]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BallisticTypeOfCharge](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[status] [smallint] NULL,
	[orderofdisplay] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BitSizes]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitSizes](
	[bitSizeID] [uniqueidentifier] NOT NULL,
	[size] [float] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_BitSizesNew] PRIMARY KEY NONCLUSTERED 
(
	[bitSizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BitSizes2]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitSizes2](
	[bitSizeID] [uniqueidentifier] NOT NULL,
	[size] [float] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_BitSizesNew2] PRIMARY KEY NONCLUSTERED 
(
	[bitSizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BitSizesMapTable]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitSizesMapTable](
	[oldbitsizeid] [uniqueidentifier] NULL,
	[oldbitsizename] [float] NULL,
	[newbitsizeid] [uniqueidentifier] NULL,
	[newbitsizename] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefCategories]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[Sort] [int] NULL,
	[Active] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefCategoriesLocalized]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefCategoriesLocalized](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[RevenueCenterId] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefCategoriesLocalized] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefFields]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefFields](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FieldType] [nvarchar](50) NOT NULL,
	[Active] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefFields] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefHeaders]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefHeaders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Active] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefHeaders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefQuestionGroup]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefQuestionGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_BriefDebriefFieldGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefQuestions]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FieldId] [int] NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[IsBrief] [bit] NULL,
	[IsDebrief] [bit] NULL,
	[Active] [bit] NULL,
	[CategoryId] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefQuestionsAnswers]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefQuestionsAnswers](
	[Id] [uniqueidentifier] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[Answer] [nvarchar](4000) NULL,
	[IsBrief] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BriefDebriefQuestionsAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefQuestionsAnswersLog]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefQuestionsAnswersLog](
	[Id] [uniqueidentifier] NOT NULL,
	[OldValue] [nvarchar](4000) NULL,
	[NewValue] [nvarchar](4000) NOT NULL,
	[AnswerId] [uniqueidentifier] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BriefDebriefQuestionsAnswersLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefQuestionsLocalized]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefQuestionsLocalized](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[RevenueCenterId] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefQuestionsLocalized] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefQuestionsTypeValues]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefQuestionsTypeValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[TypeId] [int] NOT NULL,
	[Value] [int] NOT NULL,
	[Deleted] [bit] NULL,
	[Modified] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefQuestionsTypeValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefQuestionTemplates]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefQuestionTemplates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[TemplateId] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_BriefDebriefQuestionTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefQuestionTypes]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefQuestionTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Active] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefQuestionTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefTemplate]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Version] [nvarchar](100) NOT NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[Gwis_LocationAttributeId] [int] NULL,
	[Parent] [int] NULL,
 CONSTRAINT [PK_BriefDebriefTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefTemplateHeader]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefTemplateHeader](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BriefDebriefTemplateId] [int] NOT NULL,
	[BriefDebriefHeaderId] [int] NOT NULL,
	[Sort] [int] NOT NULL,
	[Column] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_BriefDebriefTemplateHeader] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BriefDebriefTemplateHeaderLocalized]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BriefDebriefTemplateHeaderLocalized](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateId] [int] NOT NULL,
	[RevenueCenterId] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_BriefDebriefTemplateHeaderLocalized] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ca_job_bonus_dt_data]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ca_job_bonus_dt_data](
	[Order Co] [nvarchar](255) NULL,
	[Order Number] [float] NULL,
	[Or Ty] [nvarchar](255) NULL,
	[Or Ty Description 1] [nvarchar](255) NULL,
	[Or Ty Description 2] [nvarchar](255) NULL,
	[Business Unit] [nvarchar](255) NULL,
	[Seq No#] [float] NULL,
	[Sequence Status] [nvarchar](255) NULL,
	[Sequence Status Description 1] [nvarchar](255) NULL,
	[Prepared By] [nvarchar](255) NULL,
	[Price Book] [nvarchar](255) NULL,
	[Price Book Description 1] [nvarchar](255) NULL,
	[Order Date] [datetime] NULL,
	[Job Number] [nvarchar](255) NULL,
	[Creation Date] [datetime] NULL,
	[Cancel Date] [datetime] NULL,
	[Actual Ship Date] [datetime] NULL,
	[Invoice Date] [datetime] NULL,
	[Date Updated] [datetime] NULL,
	[Time of Day] [float] NULL,
	[Job Type] [nvarchar](255) NULL,
	[Job Type Description 1] [nvarchar](255) NULL,
	[Address Number] [float] NULL,
	[Well Job Type] [nvarchar](255) NULL,
	[Well Job Type Description 1] [nvarchar](255) NULL,
	[Land/ Offshore] [nvarchar](255) NULL,
	[Land/ Offshore Description 1] [nvarchar](255) NULL,
	[CS / LSD] [nvarchar](255) NULL,
	[AFE Number] [nvarchar](255) NULL,
	[Sales Order DT Status] [nvarchar](255) NULL,
	[Revenue Amount] [float] NULL,
	[Amount] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CADWirelineInvoiced]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CADWirelineInvoiced](
	[Business Unit] [int] NULL,
	[Business Unit Name] [nvarchar](255) NULL,
	[Invoice Number] [int] NULL,
	[Inv Ty] [nvarchar](255) NULL,
	[Order Number] [int] NULL,
	[Or Ty] [nvarchar](255) NULL,
	[Inv Seq] [int] NULL,
	[Inv Date] [nvarchar](255) NULL,
	[Billed From] [nvarchar](255) NULL,
	[Billed To] [nvarchar](255) NULL,
	[Sold To Number] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[Ship To Number] [int] NULL,
	[Description1] [nvarchar](255) NULL,
	[Address Line 1] [nvarchar](255) NULL,
	[Address Line 2] [nvarchar](255) NULL,
	[Address Line 3] [nvarchar](255) NULL,
	[Address Line 4] [nvarchar](255) NULL,
	[IV Gross Amount] [float] NULL,
	[IV Discount Amount] [float] NULL,
	[IV Surcharge Amount] [nvarchar](255) NULL,
	[IV Tax Amount] [float] NULL,
	[IV Net Amount] [float] NULL,
	[Cur Cod] [nvarchar](255) NULL,
	[Prepared By] [nvarchar](255) NULL,
	[Credit Reason Code] [nvarchar](255) NULL,
	[Reason Code Description] [nvarchar](255) NULL,
	[Salesprsn Code] [float] NULL,
	[Date Inv Seq Started] [nvarchar](255) NULL,
	[Job Type] [nvarchar](255) NULL,
	[Contract Acct No] [nvarchar](255) NULL,
	[Foreign Amount] [float] NULL,
	[F33] [nvarchar](255) NULL,
	[F34] [nvarchar](255) NULL,
	[Contract Number] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caInvoicesJDE]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caInvoicesJDE](
	[" deliveryTicketID" ] [nvarchar](50) NULL,
	["  OneViewFieldTicket" ] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[canadian_jobs_invoiced_8_27_2004]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[canadian_jobs_invoiced_8_27_2004](
	[Business Unit] [float] NULL,
	[Business Unit Name] [nvarchar](255) NULL,
	[Invoice Number] [float] NULL,
	[Inv Ty] [nvarchar](255) NULL,
	[Order Number] [float] NULL,
	[Or Ty] [nvarchar](255) NULL,
	[Inv Seq] [float] NULL,
	[Inv Date] [datetime] NULL,
	[Billed From] [datetime] NULL,
	[Billed To] [datetime] NULL,
	[Sold To Number] [float] NULL,
	[Description] [nvarchar](255) NULL,
	[Ship To Number] [float] NULL,
	[Description1] [nvarchar](255) NULL,
	[Address Line 1] [nvarchar](255) NULL,
	[Address Line 2] [nvarchar](255) NULL,
	[Address Line 3] [nvarchar](255) NULL,
	[Address Line 4] [nvarchar](255) NULL,
	[IV Gross Amount] [money] NULL,
	[IV Discount Amount] [money] NULL,
	[IV Surcharge Amount] [money] NULL,
	[IV Tax Amount] [money] NULL,
	[IV Net Amount] [money] NULL,
	[Cur Cod] [nvarchar](255) NULL,
	[Prepared By] [nvarchar](255) NULL,
	[Credit Reason Code] [nvarchar](255) NULL,
	[Reason Code Description] [nvarchar](255) NULL,
	[Salesprsn Code] [float] NULL,
	[Date Inv Seq Started] [datetime] NULL,
	[Job Type] [nvarchar](255) NULL,
	[Contract Acct No] [nvarchar](255) NULL,
	[Foreign Amount] [float] NULL,
	[F33] [nvarchar](255) NULL,
	[F34] [nvarchar](255) NULL,
	[Contract Number] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CasedHoleMechanicalTypes]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CasedHoleMechanicalTypes](
	[casedHoleMechanicalTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_CasedHoleMechanicalTypes] PRIMARY KEY CLUSTERED 
(
	[casedHoleMechanicalTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CasingDimensions]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CasingDimensions](
	[casingDimensionID] [uniqueidentifier] NOT NULL,
	[casingOuterDiameter] [float] NOT NULL,
	[casingInnerDiameter] [float] NULL,
	[couplingOuterDiameter] [float] NULL,
	[linearWeight] [float] NOT NULL,
	[bitSizeInnerDiameter] [float] NULL,
	[clearance] [float] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_CasingDimensions] PRIMARY KEY NONCLUSTERED 
(
	[casingDimensionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CasingDimensionsMapTable]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CasingDimensionsMapTable](
	[oldcasingdimensionid] [uniqueidentifier] NULL,
	[oldcasingouterdiameter] [float] NULL,
	[oldlinearweight] [float] NULL,
	[newcasingdimensionid] [uniqueidentifier] NULL,
	[newcasingouterdiameter] [float] NULL,
	[newlinearweight] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CasingType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CasingType](
	[casingTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_CasingType_1] PRIMARY KEY CLUSTERED 
(
	[casingTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cell]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cell](
	[CellID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Color] [nvarchar](15) NULL,
	[RevenueCenterID] [int] NOT NULL,
	[CostCenterID] [int] NOT NULL,
	[OwnerID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateObsolete] [datetime] NULL,
	[DistrictManagerId] [int] NULL,
	[CostCenterDistrictId] [int] NULL,
	[CostCenterBranchPlantId] [int] NULL,
	[RevenueCenterDistrictId] [int] NULL,
	[RevenueCenterBranchPlantId] [int] NULL,
	[SecondaryColor] [nvarchar](15) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[OtherCellAssignments] [nvarchar](max) NULL,
	[EquipmentComments] [nvarchar](max) NULL,
	[UnitAssetId] [int] NULL,
 CONSTRAINT [pk_cell_cellid] PRIMARY KEY CLUSTERED 
(
	[CellID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CellEmployees]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CellEmployees](
	[CellEmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[CellID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [pk_cellEmployees_cellEmployeeid] PRIMARY KEY CLUSTERED 
(
	[CellEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CellLog]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CellLog](
	[CellLogID] [int] IDENTITY(1,1) NOT NULL,
	[CellID] [int] NOT NULL,
	[ModifiedById] [int] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[Category] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[NewValue] [nvarchar](1000) NULL,
	[NewId] [nvarchar](1000) NULL,
	[OldValue] [nvarchar](1000) NULL,
	[OldId] [nvarchar](1000) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [pk_celllog_celllogid] PRIMARY KEY CLUSTERED 
(
	[CellLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[celllog_offline]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[celllog_offline](
	[celllogid] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CellServiceSet]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CellServiceSet](
	[cellServiceSetID] [uniqueidentifier] NOT NULL,
	[cellID] [int] NOT NULL,
	[cellServiceSetName] [nvarchar](255) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__CellServiceSet__0D84EF7E] PRIMARY KEY NONCLUSTERED 
(
	[cellServiceSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CellServiceSetService]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CellServiceSetService](
	[cellServiceSetServiceID] [uniqueidentifier] NOT NULL,
	[cellServiceSetID] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[serviceGroupID] [int] NOT NULL,
 CONSTRAINT [PK__CellServiceSet__7227B923] PRIMARY KEY NONCLUSTERED 
(
	[cellServiceSetServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[ID] [int] NULL,
	[Name] [nvarchar](100) NOT NULL,
	[LegalName] [nvarchar](150) NULL,
	[Active] [bit] NULL,
	[Status] [int] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[oneViewCompanyID] [uniqueidentifier] NOT NULL,
	[isWireline] [bit] NULL,
	[jdeCompanyID] [numeric](8, 0) NULL,
	[isEDI] [bit] NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY NONCLUSTERED 
(
	[oneViewCompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyAddress]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyAddress](
	[CompanyID] [int] NULL,
	[AddressID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[companyAddressID] [uniqueidentifier] NOT NULL,
	[oneViewCompanyID] [uniqueidentifier] NOT NULL,
	[oneViewAddressID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CompanyAddress] PRIMARY KEY NONCLUSTERED 
(
	[companyAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyEDIFields]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyEDIFields](
	[companyEDIFieldID] [int] IDENTITY(1,1) NOT NULL,
	[companyID] [int] NULL,
	[fieldLabel] [nvarchar](255) NOT NULL,
	[label] [nvarchar](255) NULL,
	[sortOrder] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_CompanyEDIFields] PRIMARY KEY CLUSTERED 
(
	[companyEDIFieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyGeneralInstructions]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyGeneralInstructions](
	[companyGeneralInstructionID] [uniqueidentifier] NOT NULL,
	[companyID] [int] NOT NULL,
	[jobTypeID] [int] NOT NULL,
	[feCellRoleTypeID] [int] NOT NULL,
	[instructions] [nvarchar](4000) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_CompanyGeneralInstructions] PRIMARY KEY CLUSTERED 
(
	[companyGeneralInstructionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyPricebook]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyPricebook](
	[CompanyPricebookId] [uniqueidentifier] NOT NULL,
	[CompanyAddressId] [uniqueidentifier] NOT NULL,
	[PricebookId] [int] NOT NULL,
	[Deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_CompanyPricebook] PRIMARY KEY CLUSTERED 
(
	[CompanyPricebookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyRegion]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyRegion](
	[id] [int] NULL,
	[company] [int] NULL,
	[region] [int] NULL,
	[Modified] [datetime] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[oneViewCompanyRegionID] [uniqueidentifier] NOT NULL,
	[oneViewCompanyID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CompanyOperationalRegion] PRIMARY KEY NONCLUSTERED 
(
	[oneViewCompanyRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyStatus]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](30) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_CompanyStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactInfo]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactInfo](
	[contactInfoID] [uniqueidentifier] NOT NULL,
	[personID] [uniqueidentifier] NOT NULL,
	[contactData] [nvarchar](320) NULL,
	[contactTypeContactSubTypeID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ContactInfo] PRIMARY KEY CLUSTERED 
(
	[contactInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactSubTypes]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactSubTypes](
	[contactSubTypeID] [int] IDENTITY(1,1) NOT NULL,
	[subType] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ContactSubTypes] PRIMARY KEY CLUSTERED 
(
	[contactSubTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactTypes]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactTypes](
	[contactTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ContactTypes] PRIMARY KEY CLUSTERED 
(
	[contactTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactTypesContactSubTypes]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactTypesContactSubTypes](
	[contactTypeContactSubTypeID] [int] IDENTITY(1,1) NOT NULL,
	[contactTypeID] [int] NOT NULL,
	[contactSubTypeID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ContactTypesContactSubTypes] PRIMARY KEY CLUSTERED 
(
	[contactTypeContactSubTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConveyanceSubType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConveyanceSubType](
	[conveyanceSubTypeID] [int] NOT NULL,
	[subType] [nvarchar](50) NULL,
	[conveyanceTypeID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ConveyanceSubType] PRIMARY KEY CLUSTERED 
(
	[conveyanceSubTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConveyanceType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConveyanceType](
	[conveyanceTypeID] [int] NOT NULL,
	[type] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ConveyanceType] PRIMARY KEY CLUSTERED 
(
	[conveyanceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country_currency]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country_currency](
	[Country] [nvarchar](255) NULL,
	[Zone] [nvarchar](255) NULL,
	[Currency] [nvarchar](255) NULL,
	[Cross link] [nvarchar](255) NULL,
	[Flag] [nvarchar](255) NOT NULL,
	[Nic code] [nvarchar](255) NULL,
 CONSTRAINT [PK_country_currency] PRIMARY KEY CLUSTERED 
(
	[Flag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[county_parish]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[county_parish](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[district] [int] NOT NULL,
	[created] [datetime] NOT NULL,
	[modified] [datetime] NOT NULL,
	[modified_by] [nvarchar](200) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_county_parish] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[currencyID] [int] NOT NULL,
	[code] [nvarchar](10) NOT NULL,
	[description] [nvarchar](200) NULL,
	[culture] [nvarchar](20) NULL,
	[modified] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[currencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[currency_import]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[currency_import](
	[CurrencyCode] [varchar](50) NULL,
	[Rate] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrencyRate]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyRate](
	[currencyRateID] [int] NOT NULL,
	[currencyID] [int] NOT NULL,
	[rate] [numeric](18, 9) NOT NULL,
	[effectiveDate] [datetime] NOT NULL,
	[modified] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_CurrencyRate] PRIMARY KEY CLUSTERED 
(
	[currencyRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dates]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dates](
	[number] [int] NOT NULL,
	[date1] [datetime] NULL,
	[date2] [datetime] NULL,
	[date3] [datetime] NULL,
	[cost] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DefaultAreaApprovers]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DefaultAreaApprovers](
	[employeeWftId] [nvarchar](100) NOT NULL,
	[countryId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeliveryTickets]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryTickets](
	[DeliveryTicketID] [uniqueidentifier] NOT NULL,
	[DTFileName] [nvarchar](255) NULL,
	[Source] [nvarchar](255) NULL,
	[Target] [nvarchar](255) NULL,
	[Method] [nvarchar](255) NULL,
	[TransactionGroupId] [nvarchar](255) NULL,
	[TransactionId] [nvarchar](255) NULL,
	[TransactionName] [nvarchar](255) NULL,
	[MessageDetail_Id] [float] NULL,
	[OrderNumber] [float] NULL,
	[OrderType] [nvarchar](255) NULL,
	[Company] [nvarchar](255) NULL,
	[BranchPlant] [nvarchar](255) NULL,
	[Customer] [float] NULL,
	[CustomerHoldCode] [nvarchar](255) NULL,
	[ShipTo] [nvarchar](255) NULL,
	[Miscellaneous] [nvarchar](255) NULL,
	[CreationDate] [nvarchar](255) NULL,
	[UserCreatedDocument] [nvarchar](255) NULL,
	[Rig] [nvarchar](255) NULL,
	[SequenceCreationDate] [nvarchar](255) NULL,
	[SequenceNumber] [float] NULL,
	[RevenueBusinessUnit] [nvarchar](255) NULL,
	[LandorOffshore] [nvarchar](255) NULL,
	[DeliveryTicketComplianceHold] [nvarchar](255) NULL,
	[DateShipConfirmed] [nvarchar](255) NULL,
	[JobNumber] [nvarchar](255) NULL,
	[JobType] [nvarchar](255) NULL,
	[ContractAccount] [nvarchar](255) NULL,
	[SalesMans1] [nvarchar](255) NULL,
	[SalesMans2] [nvarchar](255) NULL,
	[SalesMans3] [nvarchar](255) NULL,
	[BillDate] [nvarchar](255) NULL,
	[SerialNumber] [nvarchar](255) NULL,
	[SerialNoDesc1] [nvarchar](255) NULL,
	[SerialNoDesc2] [nvarchar](255) NULL,
	[SerialNoDesc3] [nvarchar](255) NULL,
	[LongItemNumber] [nvarchar](255) NULL,
	[AssetNumber] [nvarchar](255) NULL,
	[AssetStatus] [nvarchar](255) NULL,
	[QuantityShipped] [nvarchar](255) NULL,
	[LotNumber] [nvarchar](255) NULL,
	[LineNumber] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Description1] [nvarchar](255) NULL,
	[Description2] [nvarchar](255) NULL,
	[Weight] [nvarchar](255) NULL,
	[BillType] [nvarchar](255) NULL,
	[LineType] [nvarchar](255) NULL,
	[LineTypeDesc] [nvarchar](255) NULL,
	[CustomsReplacementValue] [nvarchar](255) NULL,
	[CountryofOrigin] [nvarchar](255) NULL,
	[AmountExtendedPrice] [nvarchar](255) NULL,
	[ForeignExtendedPrice] [nvarchar](255) NULL,
	[ReasonCode] [nvarchar](255) NULL,
	[ReturnDate] [nvarchar](255) NULL,
	[ReturnBy] [nvarchar](255) NULL,
	[ReturnSequence] [nvarchar](255) NULL,
	[ReturnQuantity] [nvarchar](255) NULL,
	[SoldQuantity] [nvarchar](255) NULL,
	[DateofTransaction] [nvarchar](255) NULL,
	[TimeofTransaction] [nvarchar](255) NULL,
	[TransactionCurrency] [nvarchar](255) NULL,
	[BaseCurrency] [nvarchar](255) NULL,
	[InvoiceNumber] [nvarchar](255) NULL,
	[InvoiceType] [nvarchar](255) NULL,
	[InvoiceCompany] [nvarchar](255) NULL,
	[InvoiceSequence] [nvarchar](255) NULL,
	[OriginalLine] [nvarchar](255) NULL,
	[WellDetails1] [nvarchar](255) NULL,
	[WellDetails3] [nvarchar](255) NULL,
	[WellName] [nvarchar](255) NULL,
	[LNID] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeliveryTicketSOALog]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryTicketSOALog](
	[deliveryTicketSOALogID] [uniqueidentifier] NOT NULL,
	[DeliveryTicketSOALogTypeID] [int] NOT NULL,
	[fileName] [nvarchar](100) NULL,
	[transactionID] [nvarchar](20) NULL,
	[transactionName] [nvarchar](20) NULL,
	[orderNumber] [nvarchar](20) NULL,
	[logDate] [datetime] NULL,
	[logComment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_DeliveryTicketSOALog] PRIMARY KEY CLUSTERED 
(
	[deliveryTicketSOALogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeliveryTicketSOALogType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryTicketSOALogType](
	[DeliveryTicketSOALogTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_DeliveryTicketSOALogType] PRIMARY KEY CLUSTERED 
(
	[DeliveryTicketSOALogTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[direct_dt_query_headers_only_current]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[direct_dt_query_headers_only_current](
	[Order Number] [varchar](50) NOT NULL,
	[Order Co] [varchar](50) NULL,
	[Or Ty] [varchar](50) NULL,
	[Or Ty Description 1] [varchar](50) NULL,
	[Or Ty Description 2] [varchar](50) NULL,
	[Business Unit] [varchar](50) NULL,
	[Seq No ] [varchar](50) NULL,
	[Sequence Status] [varchar](50) NULL,
	[Sequence Status Description 1] [varchar](50) NULL,
	[Prepared By] [varchar](50) NULL,
	[Price Book] [varchar](50) NULL,
	[Price Book Description 1] [varchar](50) NULL,
	[Order Date] [varchar](50) NULL,
	[Job Number] [varchar](50) NULL,
	[Creation Date] [varchar](50) NULL,
	[Cancel Date] [varchar](50) NULL,
	[Actual Ship Date] [varchar](50) NULL,
	[Invoice Date] [varchar](50) NULL,
	[Date Updated] [varchar](50) NULL,
	[Time of Day] [varchar](50) NULL,
	[Job Type] [varchar](50) NULL,
	[Job Type Description 1] [varchar](50) NULL,
	[Address Number] [varchar](50) NULL,
	[Well Job Type] [varchar](50) NULL,
	[Well Job Type Description 1] [varchar](50) NULL,
	[Land  Offshore] [varchar](50) NULL,
	[Land  Offshore Description 1] [varchar](50) NULL,
	[CS   LSD] [varchar](50) NULL,
	[AFE Number] [varchar](50) NULL,
	[Sales Order DT Status] [varchar](50) NULL,
	[Revenue Amount] [varchar](50) NULL,
	[Amount] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[District]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[District](
	[id] [int] NOT NULL,
	[name] [nvarchar](300) NOT NULL,
	[active] [char](1) NOT NULL,
	[active_date] [datetime] NOT NULL,
	[area] [int] NOT NULL,
	[operational] [char](1) NULL,
	[geographic] [char](1) NULL,
	[modified] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[district_jobtype_to_BU_BP_Mappings]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[district_jobtype_to_BU_BP_Mappings](
	[DistrictID] [nvarchar](50) NULL,
	[District Name] [nvarchar](50) NULL,
	[JobType] [nvarchar](50) NULL,
	[Branch Plant ID] [nvarchar](50) NULL,
	[Branch Plant Name] [nvarchar](50) NULL,
	[Business Unit ID] [nvarchar](50) NULL,
	[Business Unit Name] [nvarchar](50) NULL,
	[No Location in JDE Data] [nvarchar](50) NULL,
	[Ignore (Don't map)] [nvarchar](50) NULL,
	[Create Revenue Bucket] [nvarchar](50) NULL,
	[Not Active] [nvarchar](50) NULL,
	[Research] [nvarchar](50) NULL,
	[Is Duplicate BU] [nvarchar](50) NULL,
	[jobtypeid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DistrictTimezone]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DistrictTimezone](
	[districtID] [int] NOT NULL,
	[timezoneInfoID] [nvarchar](100) NULL,
	[modified] [datetime] NOT NULL,
 CONSTRAINT [PK_DistrictTimezone] PRIMARY KEY CLUSTERED 
(
	[districtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrillingFluidType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrillingFluidType](
	[drillingFluidTypeID] [int] IDENTITY(1,1) NOT NULL,
	[fluidType] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_DrillingFluidType] PRIMARY KEY CLUSTERED 
(
	[drillingFluidTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DTBackup]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DTBackup](
	[DeliveryTicketID] [uniqueidentifier] NOT NULL,
	[DTFileName] [nvarchar](255) NULL,
	[Source] [nvarchar](max) NULL,
	[Target] [nvarchar](max) NULL,
	[Method] [nvarchar](max) NULL,
	[TransactionGroupId] [nvarchar](max) NULL,
	[TransactionId] [nvarchar](max) NULL,
	[TransactionName] [nvarchar](max) NULL,
	[MessageDetail_Id] [float] NULL,
	[OrderNumber] [float] NULL,
	[OrderType] [nvarchar](max) NULL,
	[Company] [nvarchar](max) NULL,
	[BranchPlant] [nvarchar](max) NULL,
	[Customer] [float] NULL,
	[CustomerHoldCode] [nvarchar](max) NULL,
	[ShipTo] [nvarchar](max) NULL,
	[Miscellaneous] [nvarchar](max) NULL,
	[CreationDate] [nvarchar](max) NULL,
	[UserCreatedDocument] [nvarchar](max) NULL,
	[Rig] [nvarchar](max) NULL,
	[SequenceCreationDate] [nvarchar](max) NULL,
	[SequenceNumber] [float] NULL,
	[RevenueBusinessUnit] [nvarchar](max) NULL,
	[LandorOffshore] [nvarchar](max) NULL,
	[DeliveryTicketComplianceHold] [nvarchar](max) NULL,
	[DateShipConfirmed] [nvarchar](max) NULL,
	[JobNumber] [nvarchar](max) NULL,
	[JobType] [nvarchar](max) NULL,
	[ContractAccount] [nvarchar](max) NULL,
	[SalesMans1] [nvarchar](max) NULL,
	[SalesMans2] [nvarchar](max) NULL,
	[SalesMans3] [nvarchar](max) NULL,
	[BillDate] [nvarchar](max) NULL,
	[SerialNumber] [nvarchar](max) NULL,
	[SerialNoDesc1] [nvarchar](max) NULL,
	[SerialNoDesc2] [nvarchar](max) NULL,
	[SerialNoDesc3] [nvarchar](max) NULL,
	[LongItemNumber] [nvarchar](max) NULL,
	[AssetNumber] [nvarchar](max) NULL,
	[AssetStatus] [nvarchar](max) NULL,
	[QuantityShipped] [nvarchar](max) NULL,
	[LotNumber] [nvarchar](max) NULL,
	[LineNumber] [nvarchar](max) NULL,
	[Location] [nvarchar](max) NULL,
	[Description1] [nvarchar](max) NULL,
	[Description2] [nvarchar](max) NULL,
	[Weight] [nvarchar](max) NULL,
	[BillType] [nvarchar](max) NULL,
	[LineType] [nvarchar](max) NULL,
	[LineTypeDesc] [nvarchar](max) NULL,
	[CustomsReplacementValue] [nvarchar](max) NULL,
	[CountryofOrigin] [nvarchar](max) NULL,
	[AmountExtendedPrice] [nvarchar](max) NULL,
	[ForeignExtendedPrice] [nvarchar](max) NULL,
	[ReasonCode] [nvarchar](max) NULL,
	[ReturnDate] [nvarchar](max) NULL,
	[ReturnBy] [nvarchar](max) NULL,
	[ReturnSequence] [nvarchar](max) NULL,
	[ReturnQuantity] [nvarchar](max) NULL,
	[SoldQuantity] [nvarchar](max) NULL,
	[DateofTransaction] [nvarchar](max) NULL,
	[TimeofTransaction] [nvarchar](max) NULL,
	[TransactionCurrency] [nvarchar](max) NULL,
	[BaseCurrency] [nvarchar](max) NULL,
	[InvoiceNumber] [nvarchar](max) NULL,
	[InvoiceType] [nvarchar](max) NULL,
	[InvoiceCompany] [nvarchar](max) NULL,
	[InvoiceSequence] [nvarchar](max) NULL,
	[OriginalLine] [nvarchar](max) NULL,
	[WellDetails1] [nvarchar](max) NULL,
	[WellDetails3] [nvarchar](max) NULL,
	[WellName] [nvarchar](max) NULL,
	[LNID] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EconnectCountryCodes]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EconnectCountryCodes](
	[countryCode] [nvarchar](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[countryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EconnectEmployeeData]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EconnectEmployeeData](
	[emplid] [nvarchar](255) NOT NULL,
	[first_name] [nvarchar](255) NULL,
	[middle_name] [nvarchar](255) NULL,
	[last_name] [nvarchar](255) NULL,
	[second_last_name] [nvarchar](255) NULL,
	[descr2] [nvarchar](1000) NULL,
	[w_region_descr] [nvarchar](255) NULL,
	[w_country] [nvarchar](255) NULL,
	[w_prod_line_descr] [nvarchar](1000) NULL,
	[w_product_line] [nvarchar](255) NULL,
	[w_sub_prd_ln_descr] [nvarchar](1000) NULL,
	[position_nbr] [nvarchar](255) NULL,
	[position_entry_dt] [datetime] NULL,
	[position_title] [nvarchar](255) NULL,
	[reports_to] [nvarchar](255) NULL,
	[manager_id] [nvarchar](255) NULL,
	[jobcode] [nvarchar](255) NULL,
	[w_descr2] [nvarchar](1000) NULL,
	[w_jobfmly_descr] [nvarchar](1000) NULL,
	[w_location_descr] [nvarchar](255) NULL,
	[defaultJobBonusPercentage] [float] NULL,
	[employeeID] [int] NULL,
	[managerEmployeeID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[w_hpyp_cc_id_descr] [nvarchar](255) NULL,
	[w_hpyp_cc_id] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[emplid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EconnectJobCodes]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EconnectJobCodes](
	[econnectJobCode] [nvarchar](255) NOT NULL,
	[econnectJobCodeDescription] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[econnectJobCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id] [int] NOT NULL,
	[wftid] [nvarchar](30) NOT NULL,
	[firstname] [nvarchar](100) NULL,
	[middlename] [nvarchar](100) NULL,
	[lastname] [nvarchar](100) NULL,
	[fullname] [nvarchar](150) NULL,
	[title] [nvarchar](150) NULL,
	[email] [nvarchar](300) NULL,
	[department] [nvarchar](150) NULL,
	[manager] [nvarchar](100) NULL,
	[address] [int] NULL,
	[created] [datetime] NOT NULL,
	[modified] [datetime] NOT NULL,
	[active] [bit] NOT NULL,
	[displayname] [nvarchar](100) NULL,
	[managerid] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[hrmsEmployeeID] [nvarchar](50) NULL,
	[workNumber] [nvarchar](150) NULL,
	[mobileNumber] [nvarchar](150) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_bkp_30082022]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_bkp_30082022](
	[id] [int] NOT NULL,
	[wftid] [nvarchar](30) NOT NULL,
	[firstname] [nvarchar](100) NULL,
	[middlename] [nvarchar](100) NULL,
	[lastname] [nvarchar](100) NULL,
	[fullname] [nvarchar](150) NULL,
	[title] [nvarchar](150) NULL,
	[email] [nvarchar](300) NULL,
	[department] [nvarchar](150) NULL,
	[manager] [nvarchar](100) NULL,
	[address] [int] NULL,
	[created] [datetime] NOT NULL,
	[modified] [datetime] NOT NULL,
	[active] [bit] NOT NULL,
	[displayname] [nvarchar](100) NULL,
	[managerid] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[hrmsEmployeeID] [nvarchar](50) NULL,
	[workNumber] [nvarchar](150) NULL,
	[mobileNumber] [nvarchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeGroups]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeGroups](
	[id] [int] NOT NULL,
	[employeeid] [int] NOT NULL,
	[name] [nvarchar](300) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_EmployeeGroups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[EquipmentID] [int] IDENTITY(1,1) NOT NULL,
	[BranchPlantID] [int] NOT NULL,
	[assetDescription1] [nvarchar](1000) NULL,
	[assetDescription2] [nvarchar](1000) NULL,
	[assetDescription3] [nvarchar](1000) NULL,
	[ParentEquipmentID] [int] NULL,
	[manufacturersSerialNumber] [nvarchar](25) NULL,
	[BusinessUnitID] [int] NOT NULL,
	[serialNumber] [nvarchar](50) NULL,
	[productLineCode] [nvarchar](10) NULL,
	[inventoryPartNumber] [decimal](8, 0) NULL,
	[legacyPartNumber] [nvarchar](25) NULL,
	[dateDisposed] [datetime] NULL,
	[equipmentStatusID] [int] NOT NULL,
	[equipmentToolPanelCodeVersionID] [int] NOT NULL,
	[assetPendingStatusChangeInJDE] [bit] NULL,
	[assetPendingTransferInJDE] [bit] NULL,
	[newToolVersionID] [nvarchar](20) NULL,
	[assetPendingVersionChangeInJDE] [bit] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
	[jdeCompany] [nvarchar](5) NULL,
	[assetPendingTOPSProcessing] [bit] NULL,
	[assetPendingSuperiorInJDE] [bit] NULL,
	[assetOnLoanInTOPS] [bit] NULL,
	[assetOnRepairInTOPS] [bit] NULL,
	[GWIS_AssetID] [int] NULL,
	[ParentGWIS_AssetID] [int] NULL,
	[oldSerialNumber] [nvarchar](100) NULL,
	[creationDate] [datetime] NULL,
	[constructionYear] [datetime] NULL,
	[countryOfOriginId] [int] NULL,
	[CellID] [int] NULL,
 CONSTRAINT [PK_Equipment] PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentAction]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentAction](
	[equipmentActionID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_EquipmentAction] PRIMARY KEY CLUSTERED 
(
	[equipmentActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentAdditionalInformation]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentAdditionalInformation](
	[equipmentID] [int] NOT NULL,
	[currencyID] [int] NULL,
	[grossBookValue] [decimal](18, 2) NULL,
	[accumulatedDepreciation] [decimal](18, 2) NULL,
	[netBookValue] [decimal](18, 2) NULL,
	[afeNumber] [nvarchar](25) NULL,
	[contractAccount] [nvarchar](25) NULL,
	[equipmentOwnershipID] [int] NULL,
	[dateAcquired] [datetime] NULL,
	[lifeInMonths] [int] NULL,
	[depreciationStartDate] [datetime] NULL,
	[newOrUsed] [nvarchar](50) NULL,
	[manufacturer] [nvarchar](3) NULL,
	[modelYear] [nvarchar](3) NULL,
	[history] [ntext] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
	[nativeGrossBookValue] [decimal](18, 2) NULL,
	[nativeNetBookValue] [decimal](18, 2) NULL,
	[nativeAccumulatedDepreciation] [decimal](18, 2) NULL,
 CONSTRAINT [PK_EquipmentAdditionalInformation] PRIMARY KEY CLUSTERED 
(
	[equipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentCategorization]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentCategorization](
	[equipmentCategorizationID] [int] IDENTITY(1,1) NOT NULL,
	[categorization] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EquipmentCategorization] PRIMARY KEY CLUSTERED 
(
	[equipmentCategorizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentClass]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentClass](
	[equipmentClassID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[locationName] [nvarchar](100) NOT NULL,
	[abbreviation] [nvarchar](10) NOT NULL,
	[className] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EquipmentClass] PRIMARY KEY CLUSTERED 
(
	[equipmentClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentCodeType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentCodeType](
	[equipmentCodeTypeID] [nvarchar](20) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_EquipmentCodeType] PRIMARY KEY CLUSTERED 
(
	[equipmentCodeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentDivision]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentDivision](
	[equipmentDivisionID] [int] IDENTITY(1,1) NOT NULL,
	[division] [nvarchar](100) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EquipmentDivision] PRIMARY KEY CLUSTERED 
(
	[equipmentDivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentHistory]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentHistory](
	[equipmentHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[equipmentID] [int] NOT NULL,
	[equipmentColumn] [nvarchar](100) NOT NULL,
	[history] [nvarchar](4000) NULL,
	[deleted] [bit] NOT NULL,
	[dateOfChange] [datetime] NULL,
	[changedBy] [int] NULL,
 CONSTRAINT [PK_EquipmentHistory] PRIMARY KEY CLUSTERED 
(
	[equipmentHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentModificationInformation]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentModificationInformation](
	[equipmentModificationInformationID] [int] IDENTITY(1,1) NOT NULL,
	[equipmentToolPanelCodeVersionID] [int] NOT NULL,
	[mod] [nvarchar](100) NOT NULL,
	[description] [nvarchar](1000) NULL,
	[modificationDate] [datetime] NULL,
	[completionDate] [datetime] NULL,
	[activeModification] [bit] NOT NULL,
	[requiredModificationTypeID] [int] NULL,
	[assumedDone] [bit] NULL,
	[modificationCost] [decimal](18, 9) NULL,
	[hoursToComplete] [decimal](18, 2) NULL,
	[versionChange] [bit] NULL,
	[inserted] [binary](8) NULL,
 CONSTRAINT [PK_EquipmentModificationInformation] PRIMARY KEY CLUSTERED 
(
	[equipmentModificationInformationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentModificationInformationHistory]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentModificationInformationHistory](
	[EquipmentModificationInformationHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentModificationInformationID] [int] NOT NULL,
	[history] [nvarchar](4000) NOT NULL,
	[creationDate] [datetime] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_EquipmentModificationInformationHistory] PRIMARY KEY CLUSTERED 
(
	[EquipmentModificationInformationHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentModificationRecords]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentModificationRecords](
	[equipmentID] [int] NOT NULL,
	[equipmentModificationInformationID] [int] NOT NULL,
	[hasMod] [bit] NULL,
	[modificationIncomplete] [bit] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_EquipmentModificationRecords] PRIMARY KEY CLUSTERED 
(
	[equipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentOwnership]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentOwnership](
	[equipmentOwnershipID] [int] IDENTITY(1,1) NOT NULL,
	[ownership] [nvarchar](10) NULL,
	[description] [nvarchar](1000) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_EquipmentOwnership] PRIMARY KEY CLUSTERED 
(
	[equipmentOwnershipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentPanelType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentPanelType](
	[equipmentPanelTypeID] [nvarchar](20) NOT NULL,
	[name] [nvarchar](100) NULL,
 CONSTRAINT [PK_EquipmentPanelType] PRIMARY KEY CLUSTERED 
(
	[equipmentPanelTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentPendingMaintenance]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentPendingMaintenance](
	[equipmentID] [int] NOT NULL,
	[pendingMaintenanceDue] [datetime] NULL,
	[pendingMaintenanceRuleID] [int] NOT NULL,
	[isCertification] [bit] NULL,
 CONSTRAINT [PK_EquipmentPendingMaintenance] PRIMARY KEY CLUSTERED 
(
	[equipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentPendingMaintenanceRule]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentPendingMaintenanceRule](
	[equipmentPendingMaintenanceRuleID] [int] IDENTITY(1,1) NOT NULL,
	[equipmentPendingMaintenanceTypeID] [int] NOT NULL,
	[maxDays] [int] NULL,
	[maxRuns] [int] NULL,
	[ruleDate] [datetime] NULL,
	[comment] [nvarchar](4000) NULL,
	[cost] [decimal](18, 9) NULL,
	[hoursToComplete] [decimal](18, 9) NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[obsolete] [bit] NULL,
 CONSTRAINT [PK_EquipmentPendingMaintenanceRule] PRIMARY KEY CLUSTERED 
(
	[equipmentPendingMaintenanceRuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentPendingMaintenanceType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentPendingMaintenanceType](
	[equipmentPendingMaintenanceTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](1000) NULL,
	[emailNotification] [bit] NULL,
	[repairRequest] [bit] NULL,
	[daySetting] [bit] NULL,
	[runSetting] [bit] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_EquipmentPendingMaintenanceType] PRIMARY KEY CLUSTERED 
(
	[equipmentPendingMaintenanceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentProduct]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentProduct](
	[equipmentProductID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[equipmentProductGroupID] [int] NOT NULL,
	[description] [nvarchar](1000) NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EquipmentProduct] PRIMARY KEY CLUSTERED 
(
	[equipmentProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentProductGroup]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentProductGroup](
	[equipmentProductGroupID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[xmlFileName] [nvarchar](20) NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EquipmentProductGroup] PRIMARY KEY CLUSTERED 
(
	[equipmentProductGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentStatus]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentStatus](
	[equipmentStatusID] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](10) NULL,
	[description] [nvarchar](1000) NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EquipmentStatus] PRIMARY KEY CLUSTERED 
(
	[equipmentStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentToolPanelCodeVersion]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentToolPanelCodeVersion](
	[equipmentToolPanelCodeVersionID] [int] IDENTITY(1,1) NOT NULL,
	[jdeItemNo] [nvarchar](30) NULL,
	[toolPanelID] [nvarchar](20) NOT NULL,
	[toolCodeID] [nvarchar](20) NOT NULL,
	[toolVersionID] [nvarchar](20) NOT NULL,
	[description] [nvarchar](1000) NULL,
	[equipmentDivisionID] [int] NOT NULL,
	[equipmentCategorizationID] [int] NOT NULL,
	[equipmentToolPanelCodeVersionStatusID] [int] NOT NULL,
	[equipmentProductID] [int] NOT NULL,
	[equipmentClassID] [int] NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
	[sLineItemType] [nvarchar](30) NULL,
	[vendorPartNumber] [nvarchar](100) NULL,
	[useToolDescription] [bit] NOT NULL,
	[partNumber] [nvarchar](100) NULL,
	[depreciationPeriod] [int] NULL,
 CONSTRAINT [PK_EquipmentToolPanelCodeVersion] PRIMARY KEY CLUSTERED 
(
	[equipmentToolPanelCodeVersionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentToolPanelCodeVersionStatus]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentToolPanelCodeVersionStatus](
	[equipmentToolPanelCodeVersionStatusID] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
	[colorCode] [nvarchar](10) NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EquipmentToolPanelCodeVersionStatus] PRIMARY KEY CLUSTERED 
(
	[equipmentToolPanelCodeVersionStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExchangeRate]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRate](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](10) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[rate] [numeric](18, 2) NOT NULL,
	[culture] [nvarchar](20) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_ExchangeRate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[failure_bkp30]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[failure_bkp30](
	[failureID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[failureDateTime] [datetime] NOT NULL,
	[enteredByID] [int] NOT NULL,
	[failureDistrictID] [int] NULL,
	[description] [ntext] NOT NULL,
	[shortTermSolution] [ntext] NOT NULL,
	[lostrigtime] [float] NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[operationalLocationID] [int] NULL,
	[isCpar] [bit] NULL,
	[potentialConsequence] [int] NULL,
	[actualConsequence] [int] NULL,
	[notificationSummary] [ntext] NULL,
	[incidentId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureClassification]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureClassification](
	[failureClassificationID] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NULL,
	[failureCategoryID] [smallint] NULL,
	[failureItemID] [smallint] NULL,
	[failureCategoryDescription] [ntext] NULL,
	[failureMechCategoryID] [smallint] NULL,
	[failureMechanismID] [smallint] NULL,
	[failureMechCategoryDescription] [ntext] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_FailureClassification] PRIMARY KEY NONCLUSTERED 
(
	[failureClassificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureClassification_bkp180123]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureClassification_bkp180123](
	[failureClassificationID] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NULL,
	[failureCategoryID] [smallint] NULL,
	[failureItemID] [smallint] NULL,
	[failureCategoryDescription] [ntext] NULL,
	[failureMechCategoryID] [smallint] NULL,
	[failureMechanismID] [smallint] NULL,
	[failureMechCategoryDescription] [ntext] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureClassification_bkp30]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureClassification_bkp30](
	[failureClassificationID] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NULL,
	[failureCategoryID] [smallint] NULL,
	[failureItemID] [smallint] NULL,
	[failureCategoryDescription] [ntext] NULL,
	[failureMechCategoryID] [smallint] NULL,
	[failureMechanismID] [smallint] NULL,
	[failureMechCategoryDescription] [ntext] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureEventValue]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureEventValue](
	[failureID] [uniqueidentifier] NOT NULL,
	[failureTextID] [int] NOT NULL,
	[value] [nvarchar](200) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FailureEventValue] PRIMARY KEY CLUSTERED 
(
	[failureID] ASC,
	[failureTextID] ASC,
	[failureLossCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureLabel]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureLabel](
	[failureLabelID] [smallint] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_FailureLabel] PRIMARY KEY CLUSTERED 
(
	[failureLabelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureLabel_old]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureLabel_old](
	[failureLabelID] [smallint] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[failureLabelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureLossCategory]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureLossCategory](
	[failureLossCategoryID] [uniqueidentifier] NOT NULL,
	[failureID] [uniqueidentifier] NOT NULL,
	[lossCategoryID] [smallint] NULL,
	[eventID] [smallint] NULL,
	[consequencesID] [smallint] NULL,
	[likelihoodID] [smallint] NULL,
	[wiseNo] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_FailureLossCategory] PRIMARY KEY NONCLUSTERED 
(
	[failureLossCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureLossCategory_bkp_180123]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureLossCategory_bkp_180123](
	[failureLossCategoryID] [uniqueidentifier] NOT NULL,
	[failureID] [uniqueidentifier] NOT NULL,
	[lossCategoryID] [smallint] NULL,
	[eventID] [smallint] NULL,
	[consequencesID] [smallint] NULL,
	[likelihoodID] [smallint] NULL,
	[wiseNo] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureLossCategory_bkp30]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureLossCategory_bkp30](
	[failureLossCategoryID] [uniqueidentifier] NOT NULL,
	[failureID] [uniqueidentifier] NOT NULL,
	[lossCategoryID] [smallint] NULL,
	[eventID] [smallint] NULL,
	[consequencesID] [smallint] NULL,
	[likelihoodID] [smallint] NULL,
	[wiseNo] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Failures]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Failures](
	[failureID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[failureDateTime] [datetime] NOT NULL,
	[enteredByID] [int] NOT NULL,
	[failureDistrictID] [int] NULL,
	[description] [ntext] NOT NULL,
	[shortTermSolution] [ntext] NOT NULL,
	[lostrigtime] [float] NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[operationalLocationID] [int] NULL,
	[isCpar] [bit] NULL,
	[potentialConsequence] [int] NULL,
	[actualConsequence] [int] NULL,
	[notificationSummary] [ntext] NULL,
	[incidentId] [int] NULL,
 CONSTRAINT [PK_Failures] PRIMARY KEY NONCLUSTERED 
(
	[failureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Failures_backup_6_29_2018]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Failures_backup_6_29_2018](
	[failureID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[failureDateTime] [datetime] NOT NULL,
	[enteredByID] [int] NOT NULL,
	[failureDistrictID] [int] NULL,
	[description] [ntext] NOT NULL,
	[shortTermSolution] [ntext] NOT NULL,
	[lostrigtime] [float] NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[operationalLocationID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Failures_bkp180123]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Failures_bkp180123](
	[failureID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[failureDateTime] [datetime] NOT NULL,
	[enteredByID] [int] NOT NULL,
	[failureDistrictID] [int] NULL,
	[description] [ntext] NOT NULL,
	[shortTermSolution] [ntext] NOT NULL,
	[lostrigtime] [float] NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[operationalLocationID] [int] NULL,
	[isCpar] [bit] NULL,
	[potentialConsequence] [int] NULL,
	[actualConsequence] [int] NULL,
	[notificationSummary] [ntext] NULL,
	[incidentId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureText]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureText](
	[failureTextID] [int] IDENTITY(1,1) NOT NULL,
	[failureTextName] [varchar](50) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[status] [smallint] NULL,
 CONSTRAINT [PK_FailureText] PRIMARY KEY CLUSTERED 
(
	[failureTextID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureTool]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureTool](
	[failureLossCategoryID] [uniqueidentifier] NOT NULL,
	[failedToolID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FailureTool] PRIMARY KEY NONCLUSTERED 
(
	[failureLossCategoryID] ASC,
	[failedToolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureToolV2]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureToolV2](
	[failureToolID] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NOT NULL,
	[failedToolID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[GWIS_AssetID] [int] NULL,
 CONSTRAINT [PK_FailureToolV2] PRIMARY KEY NONCLUSTERED 
(
	[failureToolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureToolV2_bkp180123]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureToolV2_bkp180123](
	[failureToolID] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NOT NULL,
	[failedToolID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[GWIS_AssetID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureTree]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureTree](
	[failureTreeID] [int] IDENTITY(1,1) NOT NULL,
	[failureLabelID] [smallint] NOT NULL,
	[parentID] [smallint] NULL,
	[displayLevel] [smallint] NULL,
	[grouping] [smallint] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_FailureTree] PRIMARY KEY CLUSTERED 
(
	[failureTreeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureTree_old]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureTree_old](
	[failureTreeID] [int] NOT NULL,
	[failureLabelID] [smallint] NULL,
	[parentID] [smallint] NULL,
	[displayLevel] [smallint] NULL,
	[grouping] [smallint] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK__FailureTree_old__6A5BAED2] PRIMARY KEY CLUSTERED 
(
	[failureTreeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureValue]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureValue](
	[failureID] [uniqueidentifier] NOT NULL,
	[failureTextID] [int] NOT NULL,
	[value] [nvarchar](200) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_FailureValue] PRIMARY KEY NONCLUSTERED 
(
	[failureID] ASC,
	[failureTextID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureValue_bkp180123]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureValue_bkp180123](
	[failureID] [uniqueidentifier] NOT NULL,
	[failureTextID] [int] NOT NULL,
	[value] [nvarchar](200) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailureValue_bkp30]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailureValue_bkp30](
	[failureID] [uniqueidentifier] NOT NULL,
	[failureTextID] [int] NOT NULL,
	[value] [nvarchar](200) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[failureLossCategoryID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECellAssets]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECellAssets](
	[feCellAssetID] [uniqueidentifier] NOT NULL,
	[feCellID] [uniqueidentifier] NOT NULL,
	[assetID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[GWIS_AssetID] [int] NULL,
 CONSTRAINT [PK_FECellEquipment] PRIMARY KEY NONCLUSTERED 
(
	[feCellAssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECellCompanies]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECellCompanies](
	[feCellCompanyID] [uniqueidentifier] NOT NULL,
	[feCellID] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[oneViewCompanyID] [uniqueidentifier] NOT NULL,
	[oneViewAddressID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FECellCompanies] PRIMARY KEY NONCLUSTERED 
(
	[feCellCompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECellCrew]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECellCrew](
	[feCellCrewID] [uniqueidentifier] NOT NULL,
	[feCellID] [uniqueidentifier] NOT NULL,
	[employeeID] [int] NOT NULL,
	[feCellRoleID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_FECellCrew] PRIMARY KEY NONCLUSTERED 
(
	[feCellCrewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECellRole]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECellRole](
	[feCellRoleID] [int] IDENTITY(1,1) NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
	[feCellRoleTypeID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FECellRoles] PRIMARY KEY CLUSTERED 
(
	[feCellRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECellRoleType]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECellRoleType](
	[feCellRoleTypeID] [int] IDENTITY(1,1) NOT NULL,
	[roleType] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_FECellRoleType] PRIMARY KEY CLUSTERED 
(
	[feCellRoleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECells]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECells](
	[feCellID] [uniqueidentifier] NOT NULL,
	[cellName] [nvarchar](50) NULL,
	[cellColor] [nvarchar](10) NULL,
	[districtID] [int] NULL,
	[previousfeCellID] [uniqueidentifier] NULL,
	[obsolete] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[comments] [nvarchar](2000) NULL,
	[financialSystemTypeID] [int] NULL,
	[geographicAreaID] [int] NULL,
	[pricebookID] [int] NULL,
	[topsDistrictID] [int] NULL,
	[operationalLocationID] [int] NULL,
	[geographicLocationID] [int] NULL,
 CONSTRAINT [PK_FECell] PRIMARY KEY NONCLUSTERED 
(
	[feCellID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECellServiceSets]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECellServiceSets](
	[feCellServiceSetID] [uniqueidentifier] NOT NULL,
	[feCellID] [uniqueidentifier] NOT NULL,
	[fecellServiceSetName] [nvarchar](255) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__FECellServiceSet__0D84EF7E] PRIMARY KEY NONCLUSTERED 
(
	[feCellServiceSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECellServiceSetServices]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECellServiceSetServices](
	[feCellServiceSetServicesID] [uniqueidentifier] NOT NULL,
	[feCellServiceSetID] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[serviceGroupID] [int] NOT NULL,
 CONSTRAINT [PK__FECellServiceSet__7227B923] PRIMARY KEY NONCLUSTERED 
(
	[feCellServiceSetServicesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileDownload]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileDownload](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Disclaimer] [nvarchar](max) NULL,
	[FileName] [nvarchar](max) NULL,
	[WebLink] [nvarchar](200) NULL,
	[OpsLetter] [nvarchar](130) NULL,
	[FilePath] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileDownloadLog]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileDownloadLog](
	[FileDownloadLogID] [int] IDENTITY(1,1) NOT NULL,
	[FileDownloadID] [int] NOT NULL,
	[ModifiedById] [int] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[Category] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[NewValue] [nvarchar](max) NULL,
	[OldValue] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[FileDownloadLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinancialSystem]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinancialSystem](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_FinancialSystem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FixedAssets]    Script Date: 3/19/2024 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FixedAssets](
	[FixedAssetId] [uniqueidentifier] NOT NULL,
	[AssetNumber] [nvarchar](30) NULL,
	[Company] [nvarchar](5) NULL,
	[BranchPlant] [nvarchar](75) NULL,
	[FixedAssetBranchPlant] [nvarchar](75) NULL,
	[AssetDescription] [nvarchar](255) NULL,
	[ParentNumber] [nvarchar](260) NULL,
	[ParentFixedAssetId] [uniqueidentifier] NULL,
	[ManufacturersSerialNumber] [nvarchar](25) NULL,
	[BusinessUnit] [nvarchar](12) NULL,
	[RNItemNum] [nvarchar](30) NULL,
	[SerialNum] [nvarchar](50) NULL,
	[CurrentItemQty] [numeric](15, 2) NULL,
	[CurrencyCode] [nvarchar](3) NULL,
	[Cost] [numeric](15, 2) NULL,
	[AccumDepreciation] [numeric](15, 2) NULL,
	[NetBookValue] [numeric](15, 2) NULL,
	[ProductLineCode] [nvarchar](3) NULL,
	[UnitNumber] [nvarchar](12) NULL,
	[InventoryItemNum] [nvarchar](30) NULL,
	[LegacySerialNumber] [nvarchar](25) NULL,
	[AFENumber] [nvarchar](12) NULL,
	[State] [nvarchar](3) NULL,
	[ContractAccount] [nvarchar](25) NULL,
	[Ownership] [nvarchar](3) NULL,
	[DateAcquired] [date] NULL,
	[LifeMonths] [int] NULL,
	[StartDepreciation_Date] [date] NULL,
	[NewUsed] [nvarchar](1) NULL,
	[Manufacturer] [nvarchar](100) NULL,
	[ModelYear] [nvarchar](3) NULL,
	[ThirdItemNumber] [nvarchar](40) NULL,
	[DateDisposed] [date] NULL,
	[EquipmentStatus] [nvarchar](2) NULL,
	[FiscalYear] [int] NULL,
	[LedgerType] [nvarchar](2) NULL,
	[CatCode16] [nvarchar](3) NULL,
	[IsAdvisorOnly] [bit] NULL,
	[NotUsed] [bit] NULL,
	[IsAddByWorkOrder] [bit] NULL,
	[Revision] [nvarchar](2) NULL,
	[LastEdit] [datetime] NULL,
	[LastStatusChangeDate] [datetime] NULL,
	[Source] [nvarchar](15) NULL,
	[SystemStatus] [nvarchar](470) NULL,
	[MaintPlant] [nvarchar](4) NULL,
	[MaintPlantDesc] [nvarchar](30) NULL,
	[FirmwareVersion] [nvarchar](40) NULL,
	[ModelNum] [nvarchar](20) NULL,
	[PhysicalLoc] [nvarchar](30) NULL,
	[EquipTypeDesc] [nvarchar](40) NULL,
	[ERPNotificationDate] [datetime] NULL,
	[ERPNotificationNumber] [nvarchar](30) NULL,
	[PartInternalStatus] [nvarchar](15) NULL,
	[OriginalLocation] [nvarchar](50) NULL,
	[OriginalStatus] [nvarchar](30) NULL,
	[SerialDescLong] [nvarchar](1024) NULL,
	[Comments] [nvarchar](4000) NULL,
	[SAPLastEdit] [datetime] NULL,
	[ParentPartId] [uniqueidentifier] NULL,
	[CustomsInvoiceDetailId] [uniqueidentifier] NULL,
	[Submt] [nvarchar](18) NULL,
	[LeakTestDate] [datetime] NULL,
	[RadioIsotope] [nvarchar](50) NULL,
	[Activity] [nvarchar](50) NULL,
	[SFC] [nvarchar](50) NULL,
	[SourceModel] [nvarchar](50) NULL,
	[LastComments] [nvarchar](4000) NULL,
	[PhysicalLocation] [nvarchar](150) NULL,
	[VerifiedBy] [nvarchar](15) NULL,
	[VerifiedDate] [datetime] NULL,
	[VerifiedLocation] [nvarchar](50) NULL,
	[StdCost] [money] NULL,
	[StdCostCode] [nvarchar](5) NULL,
	[OwnershipDesc] [nvarchar](20) NULL,
	[Category] [nvarchar](30) NULL,
	[CompanyCodeDesc] [nvarchar](25) NULL,
	[CostCenterDesc] [nvarchar](40) NULL,
	[CostCenterManager] [nvarchar](30) NULL,
	[TechId] [nvarchar](50) NULL,
	[MasterFirmwareItemNum] [nvarchar](30) NULL,
	[MasterFirmwareRevision] [nvarchar](12) NULL,
	[MfgPartNum] [nvarchar](30) NULL,
	[DateAdded] [datetime] NULL,
	[UserIdAdded] [int] NULL,
	[UserIdLastEdit] [int] NULL,
	[TopLevelFixedAssetId] [uniqueidentifier] NULL,
	[AcqCode] [nvarchar](3) NULL,
	[MajorAccountingClass] [nvarchar](3) NULL,
	[JournalingFlag] [nvarchar](1) NULL,
	[ApplicationCode] [nvarchar](3) NULL,
	[ToolPanelCodeVersionId] [int] NULL,
 CONSTRAINT [PK_FixedAssets] PRIMARY KEY CLUSTERED 
(
	[FixedAssetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GeoScienceStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeoScienceStatus](
	[geoScienceStatusID] [int] IDENTITY(1,1) NOT NULL,
	[geoStatus] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_GeoScienceStatus] PRIMARY KEY CLUSTERED 
(
	[geoScienceStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetAdditionalInformation]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetAdditionalInformation](
	[GWIS_AssetID] [int] NOT NULL,
	[currencyID] [int] NOT NULL,
	[grossBookValue] [decimal](18, 2) NOT NULL,
	[accumulatedDepreciation] [decimal](18, 2) NOT NULL,
	[netBookValue] [decimal](18, 2) NOT NULL,
	[afeNumber] [nvarchar](25) NULL,
	[contractAccount] [nvarchar](25) NULL,
	[GWIS_AssetOwnershipID] [int] NOT NULL,
	[dateAcquired] [datetime] NOT NULL,
	[lifeInMonths] [int] NOT NULL,
	[depreciationStartDate] [datetime] NULL,
	[newOrUsed] [nvarchar](50) NULL,
	[manufacturer] [nvarchar](3) NULL,
	[modelYear] [nvarchar](3) NULL,
	[history] [ntext] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_GWIS_AssetAddtionalInformation] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gwis_assetaddtionalinformation_staging]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gwis_assetaddtionalinformation_staging](
	[GWIS_AssetID] [int] NOT NULL,
	[currencyID] [int] NULL,
	[grossBookValue] [numeric](18, 2) NULL,
	[accumulatedDepreciation] [numeric](18, 2) NULL,
	[netBookValue] [numeric](18, 2) NULL,
	[afeNumber] [nvarchar](25) NULL,
	[contractAccount] [nvarchar](25) NULL,
	[GWIS_AssetOwnershipID] [int] NULL,
	[dateAcquired] [datetime] NULL,
	[lifeInMonths] [int] NULL,
	[depreciationStartDate] [datetime] NULL,
	[newOrUsed] [nvarchar](50) NULL,
	[manufacturer] [nvarchar](3) NULL,
	[modelYear] [nvarchar](3) NULL,
	[history] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetCategorization]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetCategorization](
	[GWIS_AssetCategorizationID] [int] NOT NULL,
	[categorization] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_GWIS_AssetCategorization] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetCategorizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetClass]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetClass](
	[GWIS_AssetClassID] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[locationName] [nvarchar](100) NOT NULL,
	[abbreviation] [nvarchar](10) NOT NULL,
	[className] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_GWIS_AssetClass] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetDivision]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetDivision](
	[GWIS_AssetDivisionID] [int] NOT NULL,
	[division] [nvarchar](100) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_GWIS_AssetDivision] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetDivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetOwnership]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetOwnership](
	[GWIS_AssetOwnershipID] [int] NOT NULL,
	[ownership] [nvarchar](10) NULL,
	[description] [nvarchar](1000) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_GWIS_AssetOwnership] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetOwnershipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetProduct]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetProduct](
	[GWIS_AssetProductID] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[GWIS_AssetProductGroupID] [int] NOT NULL,
	[description] [nvarchar](1000) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__GWIS_AssetProduc__55DFB4D9] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetProductGroup]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetProductGroup](
	[GWIS_AssetProductGroupID] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[xmlFileName] [nvarchar](20) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__GWIS_AssetProduc__59B045BD] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetProductGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_Assets]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_Assets](
	[GWIS_AssetID] [int] NOT NULL,
	[branchPlantID] [int] NOT NULL,
	[assetDescription1] [nvarchar](1000) NOT NULL,
	[assetDescription2] [nvarchar](1000) NULL,
	[assetDescription3] [nvarchar](1000) NULL,
	[GWIS_ParentAssetID] [int] NULL,
	[manufacturersSerialNumber] [nvarchar](25) NULL,
	[businessUnitID] [int] NOT NULL,
	[serialNumber] [nvarchar](50) NULL,
	[productLineCode] [nvarchar](10) NULL,
	[inventoryPartNumber] [numeric](8, 0) NULL,
	[legacyPartNumber] [nvarchar](25) NULL,
	[dateDisposed] [datetime] NULL,
	[GWIS_AssetStatusID] [int] NOT NULL,
	[GWIS_AssetToolPanelCodeVersionID] [int] NOT NULL,
	[assetPendingStatusChangeInJDE] [bit] NULL,
	[assetPendingTransferInJDE] [bit] NULL,
	[newToolVersionID] [nvarchar](20) NULL,
	[assetPendingVersionChangeInJDE] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[jdeCompany] [nvarchar](5) NULL,
	[assetPendingTOPSProcessing] [bit] NULL,
	[assetPendingSuperiorInJDE] [bit] NULL,
	[assetOnLoanInTOPS] [bit] NULL,
	[assetOnRepairInTOPS] [bit] NULL,
 CONSTRAINT [PK_GWIS_Assets] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gwis_assets_staging]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gwis_assets_staging](
	[GWIS_AssetToolPanelCodeVersionID] [int] NULL,
	[GWIS_AssetID] [int] NOT NULL,
	[branchPlantID] [int] NULL,
	[assetDescription1] [nvarchar](1000) NULL,
	[assetDescription2] [nvarchar](1000) NULL,
	[assetDescription3] [nvarchar](1000) NULL,
	[GWIS_ParentAssetID] [int] NULL,
	[manufacturersSerialNumber] [nvarchar](25) NULL,
	[businessUnitID] [int] NULL,
	[serialNumber] [nvarchar](50) NULL,
	[productLineCode] [nvarchar](10) NULL,
	[inventoryPartNumber] [numeric](8, 0) NULL,
	[legacyPartNumber] [nvarchar](25) NULL,
	[dateDisposed] [datetime] NULL,
	[GWIS_AssetStatusID] [int] NULL,
	[assetPendingStatusChangeInJDE] [bit] NULL,
	[assetPendingTransferInJDE] [bit] NULL,
	[newToolVersionID] [nvarchar](20) NULL,
	[assetPendingVersionChangeInJDE] [bit] NULL,
	[jdeCompany] [nvarchar](5) NULL,
	[assetPendingTOPSProcessing] [bit] NULL,
	[assetPendingSuperiorInJDE] [bit] NULL,
	[assetOnLoanInTOPS] [bit] NULL,
	[assetOnRepairInTOPS] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetStatus](
	[GWIS_AssetStatusID] [int] NOT NULL,
	[status] [nvarchar](10) NULL,
	[description] [nvarchar](1000) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_GWIS_AssetStatus] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetToolPanelCodeVersion]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetToolPanelCodeVersion](
	[GWIS_AssetToolPanelCodeVersionID] [int] NOT NULL,
	[jdeItemNo] [nvarchar](30) NULL,
	[toolPanelID] [nvarchar](20) NOT NULL,
	[toolCodeID] [nvarchar](20) NOT NULL,
	[toolVersionID] [nvarchar](20) NOT NULL,
	[description] [nvarchar](1000) NULL,
	[GWIS_AssetDivisionID] [int] NOT NULL,
	[GWIS_AssetCategorizationID] [int] NOT NULL,
	[GWIS_AssetToolPanelCodeVersionStatusID] [int] NOT NULL,
	[GWIS_AssetProductID] [int] NOT NULL,
	[GWIS_AssetClassID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[sLineItemType] [nvarchar](30) NULL,
 CONSTRAINT [PK_GWIS_ToolPanelCodeVersion] PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetToolPanelCodeVersionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_AssetToolPanelCodeVersionStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_AssetToolPanelCodeVersionStatus](
	[GWIS_AssetToolPanelCodeVersionStatusID] [int] NOT NULL,
	[status] [nvarchar](100) NOT NULL,
	[colorCode] [nvarchar](10) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GWIS_AssetToolPanelCodeVersionStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_JDEJobType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_JDEJobType](
	[GWIS_JDEJobTypeID] [int] NOT NULL,
	[JDE_JobType] [nchar](3) NOT NULL,
	[JDE_Rollup] [nchar](3) NOT NULL,
	[OneViewJobType] [int] NOT NULL,
 CONSTRAINT [PK_GWIS_JDEJobType] PRIMARY KEY CLUSTERED 
(
	[GWIS_JDEJobTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_Location]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_Location](
	[GWIS_LocationID] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL,
 CONSTRAINT [PK_GWIS_Location] PRIMARY KEY CLUSTERED 
(
	[GWIS_LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_LocationAttributeMatrix]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_LocationAttributeMatrix](
	[GWIS_LocationAttributeMatrixID] [int] NOT NULL,
	[GWIS_LocationAttributeID] [int] NOT NULL,
	[GWIS_LocationAttributeSubID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL,
	[GWIS_LocationAttributeValueID] [int] NULL,
	[value] [nvarchar](1000) NULL,
 CONSTRAINT [PK_GWIS_LocationAttributeMatrix] PRIMARY KEY CLUSTERED 
(
	[GWIS_LocationAttributeMatrixID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_LocationAttributes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_LocationAttributes](
	[GWIS_LocationAttributeID] [int] NOT NULL,
	[GWIS_LocationID] [int] NOT NULL,
	[GWIS_LocationRelationTypeID] [int] NULL,
	[ParentGWIS_LocationID] [int] NULL,
	[GWIS_LocationAttributeValueID] [int] NULL,
	[value] [nvarchar](1000) NULL,
	[modifiedAt] [datetime] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_GWIS_LocationAttributes] PRIMARY KEY CLUSTERED 
(
	[GWIS_LocationAttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_LocationAttributeValue]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_LocationAttributeValue](
	[GWIS_LocationAttributeValueID] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](200) NULL,
	[valueDBType] [nvarchar](20) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL,
	[category] [nvarchar](50) NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_GWIS_LocationAttributeValue] PRIMARY KEY CLUSTERED 
(
	[GWIS_LocationAttributeValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_LocationRelationType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_LocationRelationType](
	[GWIS_LocationRelationTypeID] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL,
 CONSTRAINT [PK_GWIS_LocationRelationType] PRIMARY KEY CLUSTERED 
(
	[GWIS_LocationRelationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingGeographicCountry]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingGeographicCountry](
	[oldGWIS_GeographicCountryID] [int] NOT NULL,
	[oldGWIS_GeographicCountryName] [nvarchar](50) NULL,
	[newGWIS_GeographicCountryID] [int] NULL,
	[newGWIS_GeographicCountryName] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingGeographicCounty]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingGeographicCounty](
	[oldGWIS_GeographicCountyID] [int] NOT NULL,
	[oldGWIS_GeographicCountyName] [nvarchar](50) NULL,
	[newGWIS_GeographicCountyID] [int] NULL,
	[newGWIS_GeographicCountyName] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingGeographicProvince]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingGeographicProvince](
	[oldGWIS_GeographicProvinceID] [int] NOT NULL,
	[oldGWIS_GeographicProvinceName] [nvarchar](50) NULL,
	[newGWIS_GeographicProvinceID] [int] NULL,
	[newGWIS_GeographicProvinceName] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingGeographicRegion]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingGeographicRegion](
	[oldGWIS_GeographicRegionID] [int] NOT NULL,
	[oldGWIS_GeographicRegionName] [nvarchar](50) NULL,
	[newGWIS_GeographicRegionID] [int] NULL,
	[newGWIS_GeographicRegionName] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingOperationalArea]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingOperationalArea](
	[oldGWIS_OperationalAreaID] [int] NOT NULL,
	[oldGWIS_OperationalAreaName] [nvarchar](50) NULL,
	[newGWIS_OperationalAreaID] [int] NULL,
	[newGWIS_OperationalAreaName] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingOperationalDistrict]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingOperationalDistrict](
	[oldGWIS_OperationalDistrictID] [int] NOT NULL,
	[oldGWIS_OperationalDistrictName] [nvarchar](50) NULL,
	[newGWIS_OperationalDistrictID] [int] NULL,
	[newGWIS_OperationalDistrictName] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingOperationalRegion]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingOperationalRegion](
	[oldGWIS_OperationalRegionID] [int] NOT NULL,
	[oldGWIS_OperationalRegionName] [nvarchar](50) NULL,
	[newGWIS_OperationalRegionID] [int] NULL,
	[newGWIS_OperationalRegionName] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingStation2BranchPlant]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingStation2BranchPlant](
	[tops_id] [int] NOT NULL,
	[tops_name] [nvarchar](4000) NOT NULL,
	[tops_stationtypeid] [int] NOT NULL,
	[jdebranchplant] [nvarchar](30) NULL,
	[JDEName] [char](40) NULL,
	[GWIS_LocationID] [int] NULL,
	[GWIS_Location_name] [nvarchar](100) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GWIS_MappingStation2BusinessUnit]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GWIS_MappingStation2BusinessUnit](
	[tops_id] [int] NOT NULL,
	[tops_name] [nvarchar](4000) NOT NULL,
	[tops_stationtypeid] [int] NOT NULL,
	[jde_BranchPlant] [nvarchar](30) NULL,
	[jde_BranchPlantName] [nvarchar](50) NULL,
	[jde_BusinessUnit] [nvarchar](50) NULL,
	[jde_BusinessUnitName] [nvarchar](50) NULL,
	[gwis_BranchPlant_LocationID] [int] NULL,
	[gwis_BranchPlant_Location_name] [nvarchar](100) NULL,
	[gwis_BusinessUnit_LocationID] [int] NULL,
	[gwis_BusinessUnit_Location_name] [nvarchar](100) NULL,
	[wpts_locationid] [int] NULL,
	[newBaseName] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[import_global_2015]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[import_global_2015](
	[price_book_name] [nvarchar](255) NULL,
	[price_book_description] [nvarchar](255) NULL,
	[obsolete] [nvarchar](255) NULL,
	[jdePricebookCode] [nvarchar](255) NULL,
	[country] [nvarchar](255) NULL,
	[ServiceID] [float] NULL,
	[ServiceDetailID] [float] NULL,
	[ServiceType] [nvarchar](255) NULL,
	[ServiceGroup] [nvarchar](255) NULL,
	[line_item_name] [nvarchar](255) NULL,
	[line_item_description] [nvarchar](255) NULL,
	[system_id] [float] NULL,
	[system_code] [float] NULL,
	[pricing_style] [nvarchar](255) NULL,
	[price] [float] NULL,
	[isBonusable] [float] NULL,
	[thirdPartySystemCode] [nvarchar](255) NULL,
	[alternateName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[instructions_too_long]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instructions_too_long](
	[gwis] [int] NULL,
	[engineerinstructionsch] [text] NULL,
	[engineerinstructionsoh] [text] NULL,
	[comstarinstructionsch] [text] NULL,
	[comstarinstructionsoh] [text] NULL,
	[specialinstructions] [text] NULL,
	[specialinstructionsch] [text] NULL,
	[Copy of engineerinstructionsch] [ntext] NULL,
	[Copy of engineerinstructionsoh] [ntext] NULL,
	[Copy of comstarinstructionsch] [ntext] NULL,
	[Copy of comstarinstructionsoh] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JDEEnabled]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JDEEnabled](
	[upGradeMe] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_JDEEnabled] PRIMARY KEY CLUSTERED 
(
	[upGradeMe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job](
	[jobID] [uniqueidentifier] NOT NULL,
	[dateSubmitted] [datetime] NOT NULL,
	[financialSystemTypeID] [int] NOT NULL,
	[financialSystemID] [nvarchar](50) NULL,
	[financialSystemPriceBookGroupID] [int] NOT NULL,
	[financialSystemPriceBookID] [int] NOT NULL,
	[serviceOrder] [nvarchar](50) NULL,
	[scheduledStartDateTime] [datetime] NOT NULL,
	[actualStartDateTime] [datetime] NOT NULL,
	[geographicDistrictID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[endDateTime] [datetime] NOT NULL,
	[operatingDistrictID] [int] NULL,
	[comments] [nvarchar](4000) NULL,
	[specialInstructions] [nvarchar](4000) NULL,
	[jobStatusID] [tinyint] NOT NULL,
	[deleted] [bit] NULL,
	[jobTypeID] [int] NOT NULL,
	[oneViewCompanyID] [uniqueidentifier] NOT NULL,
	[oneViewAddressID] [uniqueidentifier] NOT NULL,
	[createdByEmployeeID] [int] NULL,
	[geoScienceStatusID] [int] NULL,
	[topsServiceOrderID] [int] NULL,
	[poNumber] [nvarchar](50) NULL,
	[quoteNumber] [nvarchar](50) NULL,
	[customerRepresentative] [nvarchar](100) NULL,
	[topsDistrictID] [int] NULL,
	[approvingManagerID] [int] NULL,
	[drivingInformation] [nvarchar](4000) NULL,
	[geographicLocationID] [int] NULL,
	[operationalLocationID] [int] NULL,
	[revenueCenterID] [int] NULL,
	[jdeDeliveryTicketCurrencyID] [int] NULL,
	[jobCancelledReasonID] [int] NULL,
	[jobCancelledReasonComment] [nvarchar](1000) NULL,
	[jobCancelledReasonJobID] [uniqueidentifier] NULL,
	[rentalChargeTypeID] [int] NULL,
	[rentalCompanyName] [nvarchar](150) NULL,
	[rentalPhoneNumber] [nvarchar](50) NULL,
	[rentalContactName] [nvarchar](100) NULL,
	[rentalItems] [nvarchar](4000) NULL,
	[approxTimeSelectionID] [int] NULL,
	[quoteID] [uniqueidentifier] NULL,
	[oneviewToJDEJobID] [int] NULL,
	[invoiceDateTime] [datetime] NULL,
	[oneViewBillToCompanyID] [uniqueidentifier] NULL,
	[oneViewBillToAddressID] [uniqueidentifier] NULL,
	[runNumber] [tinyint] NULL,
	[totalNumberOfRuns] [tinyint] NULL,
	[jobTaxTotal] [decimal](18, 9) NULL,
	[tempCustomerName] [nvarchar](100) NULL,
	[wptsID] [int] NULL,
	[currencyRateID] [int] NULL,
	[actualCurrencyRate] [numeric](18, 9) NULL,
	[jobCurrentlyCheckedOut] [bit] NULL,
	[dateUploaded] [datetime] NULL,
	[acquisitionSystemId] [int] NULL,
	[acquisitionSoftwareId] [int] NULL,
	[JobMarketSegmentTypeId] [int] NULL,
	[estimatedJobValue] [decimal](18, 9) NULL,
	[engineerClientLqcScore] [float] NULL,
	[engineerOperationalLqcScore] [float] NULL,
	[auditorClientLqcScore] [float] NULL,
	[auditorOperationalLqcScore] [float] NULL,
 CONSTRAINT [PK_Job] PRIMARY KEY NONCLUSTERED 
(
	[jobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_auditstatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_auditstatus](
	[jobID] [uniqueidentifier] NOT NULL,
	[jobStatusID] [tinyint] NOT NULL,
	[invoiceDateTime] [datetime] NULL,
	[logDateTime] [datetime] NOT NULL,
	[remoteHost] [nvarchar](128) NULL,
	[remoteUser] [nvarchar](128) NULL,
	[updateDBTS] [varbinary](8) NOT NULL,
	[updateID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobActualServices]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobActualServices](
	[jobActualServiceID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[jobOperationToolID] [uniqueidentifier] NOT NULL,
	[serviceGroupID] [int] NOT NULL,
	[timesRendered] [int] NOT NULL,
	[renderedByEmployee2] [int] NULL,
	[renderedByEmployee] [int] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[performed] [bit] NULL,
	[sortOrder] [int] NULL,
	[isPrimary] [bit] NULL,
 CONSTRAINT [PK_JobActualServices] PRIMARY KEY NONCLUSTERED 
(
	[jobActualServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobAdditionalCharges]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobAdditionalCharges](
	[ID] [uniqueidentifier] NOT NULL,
	[jobId] [uniqueidentifier] NOT NULL,
	[ServiceId] [int] NULL,
	[ChargeType] [int] NULL,
	[ItemQty] [int] NOT NULL,
	[ItemPrice] [numeric](18, 9) NULL,
	[ItemDiscount] [numeric](18, 9) NULL,
	[ItemSurcharge] [numeric](18, 9) NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[ItemName] [nvarchar](100) NULL,
	[serviceDetailID] [int] NULL,
	[itemQtyDec] [decimal](18, 9) NULL,
 CONSTRAINT [PK_JobAdditionalCharges] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobAssets]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobAssets](
	[jobAssetID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[assetID] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[GWIS_AssetID] [int] NULL,
 CONSTRAINT [PK_JobAssets] PRIMARY KEY NONCLUSTERED 
(
	[jobAssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobAudit]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobAudit](
	[jobAuditID] [int] IDENTITY(1,1) NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[username] [nvarchar](200) NOT NULL,
	[remoteHost] [nvarchar](200) NOT NULL,
	[date] [datetime] NOT NULL,
	[comment] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[jobAuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonus](
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[jobBonusTypeID] [int] NOT NULL,
	[jobBonusStatusID] [int] NULL,
	[jobCrewID] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[IsApproved] [bit] NULL,
	[dateApproved] [datetime] NULL,
	[approvedBy] [int] NULL,
	[jobBonusProcessedID] [uniqueidentifier] NULL,
	[jobBonusDeclineReasonID] [int] NULL,
	[jobBonusComments] [nvarchar](255) NULL,
 CONSTRAINT [PK_JobBonus] PRIMARY KEY NONCLUSTERED 
(
	[jobBonusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonus_20221209_01]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonus_20221209_01](
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[jobBonusTypeID] [int] NOT NULL,
	[jobBonusStatusID] [int] NULL,
	[jobCrewID] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[IsApproved] [bit] NULL,
	[dateApproved] [datetime] NULL,
	[approvedBy] [int] NULL,
	[jobBonusProcessedID] [uniqueidentifier] NULL,
	[jobBonusDeclineReasonID] [int] NULL,
	[jobBonusComments] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusCopy]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusCopy](
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[jobBonusTypeID] [int] NOT NULL,
	[jobBonusStatusID] [int] NULL,
	[jobCrewID] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[IsApproved] [bit] NULL,
	[dateApproved] [datetime] NULL,
	[approvedBy] [int] NULL,
	[jobBonusProcessedID] [uniqueidentifier] NULL,
	[jobBonusDeclineReasonID] [int] NULL,
	[jobBonusComments] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusData](
	[jobBonusDataID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[bonusPercentage] [decimal](18, 9) NULL,
	[bonusTotal] [decimal](18, 9) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[bonusNumberOfDays] [decimal](18, 9) NULL,
	[bonusDayRate] [decimal](18, 9) NULL,
	[serviceOrTicketTotal] [decimal](18, 9) NULL,
	[splitPercentage] [decimal](18, 9) NULL,
	[failurePercentage] [decimal](18, 9) NULL,
	[jdeServiceOrTicketTotal] [decimal](18, 9) NULL,
	[jdeBonusTotal] [decimal](18, 9) NULL,
	[recommendedBonusPercentage] [decimal](18, 9) NULL,
	[catsID] [nvarchar](50) NULL,
	[comments] [nvarchar](4000) NULL,
	[nativeBonusTotal] [decimal](18, 9) NULL,
	[nativeServiceOrTicketTotal] [decimal](18, 9) NULL,
	[nativeJDEServiceOrderTicketTotal] [decimal](18, 9) NULL,
	[nativeJDEBonusTotal] [decimal](18, 9) NULL,
 CONSTRAINT [PK_JobBonusData] PRIMARY KEY NONCLUSTERED 
(
	[jobBonusDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusData_20220912]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusData_20220912](
	[jobBonusDataID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[bonusPercentage] [decimal](18, 9) NULL,
	[bonusTotal] [decimal](18, 9) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[bonusNumberOfDays] [decimal](18, 9) NULL,
	[bonusDayRate] [decimal](18, 9) NULL,
	[serviceOrTicketTotal] [decimal](18, 9) NULL,
	[splitPercentage] [decimal](18, 9) NULL,
	[failurePercentage] [decimal](18, 9) NULL,
	[jdeServiceOrTicketTotal] [decimal](18, 9) NULL,
	[jdeBonusTotal] [decimal](18, 9) NULL,
	[recommendedBonusPercentage] [decimal](18, 9) NULL,
	[catsID] [nvarchar](50) NULL,
	[comments] [nvarchar](4000) NULL,
	[nativeBonusTotal] [decimal](18, 9) NULL,
	[nativeServiceOrTicketTotal] [decimal](18, 9) NULL,
	[nativeJDEServiceOrderTicketTotal] [decimal](18, 9) NULL,
	[nativeJDEBonusTotal] [decimal](18, 9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusDataCopy]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusDataCopy](
	[jobBonusDataID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[bonusPercentage] [decimal](18, 9) NULL,
	[bonusTotal] [decimal](18, 9) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[bonusNumberOfDays] [decimal](18, 9) NULL,
	[bonusDayRate] [decimal](18, 9) NULL,
	[serviceOrTicketTotal] [decimal](18, 9) NULL,
	[splitPercentage] [decimal](18, 9) NULL,
	[failurePercentage] [decimal](18, 9) NULL,
	[jdeServiceOrTicketTotal] [decimal](18, 9) NULL,
	[jdeBonusTotal] [decimal](18, 9) NULL,
	[recommendedBonusPercentage] [decimal](18, 9) NULL,
	[catsID] [nvarchar](50) NULL,
	[comments] [nvarchar](4000) NULL,
	[nativeBonusTotal] [decimal](18, 9) NULL,
	[nativeServiceOrTicketTotal] [decimal](18, 9) NULL,
	[nativeJDEServiceOrderTicketTotal] [decimal](18, 9) NULL,
	[nativeJDEBonusTotal] [decimal](18, 9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusDeclineReason]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusDeclineReason](
	[jobBonusDeclineReasonID] [int] IDENTITY(1,1) NOT NULL,
	[jobBonusDeclineReason] [nvarchar](100) NOT NULL,
	[sortOrder] [int] NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_JobBonusDeclineReason] PRIMARY KEY CLUSTERED 
(
	[jobBonusDeclineReasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusExceptionData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusExceptionData](
	[jobBonusExceptionDataID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[bonusException] [decimal](18, 9) NULL,
	[nativeBonusException] [decimal](18, 9) NULL,
	[exceptionBonusableTicketTotal] [decimal](18, 9) NULL,
	[nativeExceptionBonusableTicketTotal] [decimal](18, 9) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobBonusExceptionData] PRIMARY KEY CLUSTERED 
(
	[jobBonusExceptionDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusExceptionData_20221209]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusExceptionData_20221209](
	[jobBonusExceptionDataID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[bonusException] [decimal](18, 9) NULL,
	[nativeBonusException] [decimal](18, 9) NULL,
	[exceptionBonusableTicketTotal] [decimal](18, 9) NULL,
	[nativeExceptionBonusableTicketTotal] [decimal](18, 9) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusExceptionLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusExceptionLog](
	[jobBonusExceptionLogID] [uniqueidentifier] NOT NULL,
	[jobBonusExceptionDataID] [uniqueidentifier] NOT NULL,
	[wftid] [nvarchar](50) NOT NULL,
	[modified] [datetime] NOT NULL,
	[bonusException] [decimal](18, 9) NULL,
	[nativeBonusException] [decimal](18, 9) NULL,
	[exceptionBonusableTicketTotal] [decimal](18, 9) NULL,
	[nativeExceptionBonusableTicketTotal] [decimal](18, 9) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobBonusExceptionLog] PRIMARY KEY CLUSTERED 
(
	[jobBonusExceptionLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusFlatRateData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusFlatRateData](
	[jobBonusFlatRateDataID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[bonusFlatRate] [decimal](18, 9) NULL,
	[nativeBonusFlatRate] [decimal](18, 9) NULL,
	[flatRateBonusableTicketTotal] [decimal](18, 9) NULL,
	[nativeFlatRateBonusableTicketTotal] [decimal](18, 9) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobBonusFlatRateData] PRIMARY KEY CLUSTERED 
(
	[jobBonusFlatRateDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusFlatRateLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusFlatRateLog](
	[jobBonusFlatRateLogID] [uniqueidentifier] NOT NULL,
	[jobBonusFlatRateDataID] [uniqueidentifier] NOT NULL,
	[wftid] [nvarchar](50) NOT NULL,
	[modified] [datetime] NOT NULL,
	[bonusFlatRate] [decimal](18, 9) NULL,
	[nativeBonusFlatRate] [decimal](18, 9) NULL,
	[flatRateBonusableTicketTotal] [decimal](18, 9) NULL,
	[nativeFlatRateBonusableTicketTotal] [decimal](18, 9) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobBonusFlatRateLog] PRIMARY KEY CLUSTERED 
(
	[jobBonusFlatRateLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusHistory]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusHistory](
	[jobBonusHistoryID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[hrmsEmployeeID] [nvarchar](50) NULL,
	[fullname] [nvarchar](150) NULL,
	[serviceOrder] [nvarchar](50) NULL,
	[jobid] [uniqueidentifier] NOT NULL,
	[jobBonusProcessedID] [uniqueidentifier] NOT NULL,
	[processedBy] [nvarchar](50) NOT NULL,
	[dateProcessed] [datetime] NOT NULL,
	[actualBonusTotal] [decimal](18, 9) NOT NULL,
	[country] [nvarchar](50) NOT NULL,
	[currencyCode] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobBonusHistory] PRIMARY KEY NONCLUSTERED 
(
	[jobBonusHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusJobPositionDefaultPercentages]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusJobPositionDefaultPercentages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[econnectJobCode] [nvarchar](255) NULL,
	[gwisLocationRegionID] [int] NULL,
	[gwisLocationCountryID] [int] NULL,
	[jobBonusDefaultPercentage] [float] NULL,
	[countryCode] [nvarchar](3) NOT NULL,
 CONSTRAINT [PK_JobBonusJobPositionDefaultPercentages] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusPersonnelData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusPersonnelData](
	[jobBonusPersonnelDataID] [int] IDENTITY(1,1) NOT NULL,
	[jobBonusTypeID] [int] NOT NULL,
	[serviceGroupID] [int] NULL,
	[dayRate] [decimal](18, 9) NULL,
	[bonusPercentage] [decimal](18, 9) NULL,
	[employeeID] [int] NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobBonusPersonnelData] PRIMARY KEY CLUSTERED 
(
	[jobBonusPersonnelDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusProcess_Special]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusProcess_Special](
	[hrmsEmployeeID] [nvarchar](50) NULL,
	[fullname] [nvarchar](150) NULL,
	[actualBonusTotal] [decimal](18, 9) NOT NULL,
	[serviceOrder] [nvarchar](50) NULL,
	[jobBonusID] [uniqueidentifier] NULL,
	[sortOrder] [smallint] NULL,
	[deleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusProcessed]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusProcessed](
	[jobBonusProcessedID] [uniqueidentifier] NOT NULL,
	[dateProcessed] [datetime] NULL,
	[processedBy] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobBonusProcessed] PRIMARY KEY NONCLUSTERED 
(
	[jobBonusProcessedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusProcessedCurrencyRate]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusProcessedCurrencyRate](
	[jobBonusProcessedCurrencyRateID] [uniqueidentifier] NOT NULL,
	[currencyRateID] [int] NOT NULL,
	[currencyID] [int] NOT NULL,
	[jobBonusProcessedID] [uniqueidentifier] NOT NULL,
	[rate] [numeric](18, 9) NOT NULL,
	[effectiveDate] [datetime] NOT NULL,
	[modified] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_JobBonusProcessedCurrencyRate] PRIMARY KEY CLUSTERED 
(
	[jobBonusProcessedCurrencyRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusStatus](
	[jobBonusStatusID] [int] IDENTITY(1,1) NOT NULL,
	[jobBonusStatusName] [nvarchar](15) NOT NULL,
	[sortOrder] [int] NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_JobBonusStatus] PRIMARY KEY CLUSTERED 
(
	[jobBonusStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusStatusLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusStatusLog](
	[jobBonusStatusLogID] [uniqueidentifier] NOT NULL,
	[wftid] [nvarchar](50) NOT NULL,
	[modified] [datetime] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[oldJobBonusStatusID] [tinyint] NULL,
	[newJobBonusStatusID] [tinyint] NULL,
	[bonusTotal] [decimal](18, 9) NULL,
	[jobBonusDeclineReasonID] [int] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[nativeBonusTotal] [decimal](18, 9) NULL,
 CONSTRAINT [PK_JobBonusStatusLog] PRIMARY KEY CLUSTERED 
(
	[jobBonusStatusLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusTransactionFileLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusTransactionFileLog](
	[fileDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobBonusType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBonusType](
	[jobBonusTypeID] [int] IDENTITY(1,1) NOT NULL,
	[jobBonusTypeName] [nvarchar](25) NOT NULL,
	[label] [nvarchar](25) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_JobBonusType] PRIMARY KEY CLUSTERED 
(
	[jobBonusTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobCancelledReasons]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobCancelledReasons](
	[jobCancelledReasonID] [int] IDENTITY(1,1) NOT NULL,
	[reason] [nvarchar](255) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobCancelledReasons] PRIMARY KEY CLUSTERED 
(
	[jobCancelledReasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobCharges]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobCharges](
	[jobChargeID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[pricingStyleID] [int] NULL,
	[serviceDetailID] [int] NULL,
	[itemQuantity] [decimal](18, 9) NULL,
	[isPercentage] [bit] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[itemPrice] [decimal](18, 9) NULL,
	[parentJobChargeID] [uniqueidentifier] NULL,
	[discount] [decimal](18, 9) NULL,
	[total] [decimal](18, 9) NULL,
	[comments] [nvarchar](4000) NULL,
	[adjustedItemQuantity] [decimal](18, 9) NULL,
	[adjustedItemPrice] [decimal](18, 9) NULL,
	[adjustedDiscount] [decimal](18, 9) NULL,
	[adjustedTotal] [decimal](18, 9) NULL,
	[jdeLineNumber] [float] NULL,
	[sortOrder] [int] NULL,
	[nativeItemPrice] [decimal](18, 9) NULL,
	[nativeTotal] [decimal](18, 9) NULL,
	[adjustedNativeItemPrice] [decimal](18, 9) NULL,
	[adjustedNativeTotal] [decimal](18, 9) NULL,
 CONSTRAINT [PK_JobCharges] PRIMARY KEY NONCLUSTERED 
(
	[jobChargeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobcharges_24012022]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobcharges_24012022](
	[jobChargeID] [uniqueidentifier] NOT NULL,
	[total] [decimal](18, 9) NULL,
	[itemPrice] [decimal](18, 9) NULL,
	[itemQuantity] [decimal](18, 9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobCharges_fix_conversion]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobCharges_fix_conversion](
	[jobChargeID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[pricingStyleID] [int] NULL,
	[serviceDetailID] [int] NULL,
	[itemQuantity] [decimal](18, 9) NULL,
	[isPercentage] [bit] NULL,
	[deleted] [bit] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[itemPrice] [decimal](18, 9) NULL,
	[parentJobChargeID] [uniqueidentifier] NULL,
	[discount] [decimal](18, 9) NULL,
	[total] [decimal](18, 9) NULL,
	[comments] [nvarchar](4000) NULL,
	[adjustedItemQuantity] [decimal](18, 9) NULL,
	[adjustedItemPrice] [decimal](18, 9) NULL,
	[adjustedDiscount] [decimal](18, 9) NULL,
	[adjustedTotal] [decimal](18, 9) NULL,
	[jdeLineNumber] [float] NULL,
	[sortOrder] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobCharges_Year2022_20220413]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobCharges_Year2022_20220413](
	[jobChargeID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[pricingStyleID] [int] NULL,
	[serviceDetailID] [int] NULL,
	[itemQuantity] [decimal](18, 9) NULL,
	[isPercentage] [bit] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[itemPrice] [decimal](18, 9) NULL,
	[parentJobChargeID] [uniqueidentifier] NULL,
	[discount] [decimal](18, 9) NULL,
	[total] [decimal](18, 9) NULL,
	[comments] [nvarchar](4000) NULL,
	[adjustedItemQuantity] [decimal](18, 9) NULL,
	[adjustedItemPrice] [decimal](18, 9) NULL,
	[adjustedDiscount] [decimal](18, 9) NULL,
	[adjustedTotal] [decimal](18, 9) NULL,
	[jdeLineNumber] [float] NULL,
	[sortOrder] [int] NULL,
	[nativeItemPrice] [decimal](18, 9) NULL,
	[nativeTotal] [decimal](18, 9) NULL,
	[adjustedNativeItemPrice] [decimal](18, 9) NULL,
	[adjustedNativeTotal] [decimal](18, 9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobChargesBackup]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobChargesBackup](
	[jobChargeID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[pricingStyleID] [int] NULL,
	[serviceDetailID] [int] NULL,
	[itemQuantity] [decimal](18, 9) NULL,
	[isPercentage] [bit] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[itemPrice] [decimal](18, 9) NULL,
	[parentJobChargeID] [uniqueidentifier] NULL,
	[discount] [decimal](18, 9) NULL,
	[total] [decimal](18, 9) NULL,
	[comments] [nvarchar](4000) NULL,
	[adjustedItemQuantity] [decimal](18, 9) NULL,
	[adjustedItemPrice] [decimal](18, 9) NULL,
	[adjustedDiscount] [decimal](18, 9) NULL,
	[adjustedTotal] [decimal](18, 9) NULL,
	[jdeLineNumber] [float] NULL,
	[sortOrder] [int] NULL,
	[nativeItemPrice] [decimal](18, 9) NULL,
	[nativeTotal] [decimal](18, 9) NULL,
	[adjustedNativeItemPrice] [decimal](18, 9) NULL,
	[adjustedNativeTotal] [decimal](18, 9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobChargesCopy]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobChargesCopy](
	[jobChargeID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[pricingStyleID] [int] NULL,
	[serviceDetailID] [int] NULL,
	[itemQuantity] [decimal](18, 9) NULL,
	[isPercentage] [bit] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[jobOperationID] [uniqueidentifier] NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[itemPrice] [decimal](18, 9) NULL,
	[parentJobChargeID] [uniqueidentifier] NULL,
	[discount] [decimal](18, 9) NULL,
	[total] [decimal](18, 9) NULL,
	[comments] [nvarchar](4000) NULL,
	[adjustedItemQuantity] [decimal](18, 9) NULL,
	[adjustedItemPrice] [decimal](18, 9) NULL,
	[adjustedDiscount] [decimal](18, 9) NULL,
	[adjustedTotal] [decimal](18, 9) NULL,
	[jdeLineNumber] [float] NULL,
	[sortOrder] [int] NULL,
	[nativeItemPrice] [decimal](18, 9) NULL,
	[nativeTotal] [decimal](18, 9) NULL,
	[adjustedNativeItemPrice] [decimal](18, 9) NULL,
	[adjustedNativeTotal] [decimal](18, 9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobChargesLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobChargesLog](
	[jobChargesLog] [uniqueidentifier] NOT NULL,
	[wftid] [nvarchar](50) NOT NULL,
	[modified] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[jobChargesID] [uniqueidentifier] NOT NULL,
	[oldAdjustedItemQuantity] [decimal](18, 9) NULL,
	[newAdjustedItemQuantity] [decimal](18, 9) NULL,
	[oldAdjustedItemPrice] [decimal](18, 9) NULL,
	[newAdjustedItemPrice] [decimal](18, 9) NULL,
	[oldAdjustedDiscount] [decimal](18, 9) NULL,
	[newAdjustedDiscount] [decimal](18, 9) NULL,
	[oldAdjustedTotal] [decimal](18, 9) NULL,
	[newAdjustedTotal] [decimal](18, 9) NULL,
	[note] [nvarchar](1000) NULL,
	[oldAdjustedNativeItemPrice] [decimal](18, 9) NULL,
	[newAdjustedNativeItemPrice] [decimal](18, 9) NULL,
	[oldAdjustedNativeTotal] [decimal](18, 9) NULL,
	[newAdjustedNativeTotal] [decimal](18, 9) NULL,
 CONSTRAINT [PK_JobChargesLog] PRIMARY KEY CLUSTERED 
(
	[jobChargesLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobCompanyEDIFieldData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobCompanyEDIFieldData](
	[jobCompanyEDIFieldDataID] [uniqueidentifier] NOT NULL,
	[companyEDIFieldID] [int] NOT NULL,
	[value] [nvarchar](255) NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobCompanyEDIFieldID] PRIMARY KEY CLUSTERED 
(
	[jobCompanyEDIFieldDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobContacts]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobContacts](
	[jobContactID] [uniqueidentifier] NOT NULL,
	[personID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobContacts] PRIMARY KEY CLUSTERED 
(
	[jobContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobCrew]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobCrew](
	[jobCrewID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[employeeID] [int] NOT NULL,
	[feCellRoleID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobCrew] PRIMARY KEY NONCLUSTERED 
(
	[jobCrewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobCustomerCounts]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobCustomerCounts](
	[customerCountsID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[PersonnelRating] [int] NULL,
	[EquipmentRating] [int] NULL,
	[CommunicationRating] [int] NULL,
	[HSSERating] [int] NULL,
	[OverallRating] [int] NULL,
	[CompanyComments] [ntext] NULL,
	[DeclinedSurvey] [bit] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_JobCustomerCounts] PRIMARY KEY NONCLUSTERED 
(
	[customerCountsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobDeliveryTicketTotals]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobDeliveryTicketTotals](
	[jobid] [uniqueidentifier] NOT NULL,
	[sequencenumber] [int] NOT NULL,
	[deliveryTicketTotalUSD] [decimal](27, 9) NULL,
	[deliveryTicketTotalNative] [decimal](27, 9) NULL,
	[bonusableDeliveryTicketTotalUSD] [decimal](27, 9) NULL,
	[bonusableDeliveryTicketTotalNative] [decimal](27, 9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobInvoice]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobInvoice](
	[id] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[created] [datetime] NOT NULL,
	[created_by] [nvarchar](100) NOT NULL,
	[type] [int] NOT NULL,
	[rate] [int] NOT NULL,
	[pricebook] [int] NOT NULL,
	[hoursInDay] [int] NOT NULL,
	[daysInWeek] [int] NOT NULL,
	[companyName] [nvarchar](100) NULL,
	[companyAddress1] [nvarchar](100) NULL,
	[companyAddress2] [nvarchar](100) NULL,
	[companyCity] [nvarchar](20) NULL,
	[companyStateProvince] [nvarchar](20) NULL,
	[companyPostalCode] [nvarchar](10) NULL,
	[companyPhone1] [nvarchar](20) NULL,
	[companyFax1] [nvarchar](20) NULL,
	[companyImage] [binary](200) NULL,
 CONSTRAINT [PK_JobInvoice] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobInvoiceAdjustment]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobInvoiceAdjustment](
	[id] [uniqueidentifier] NOT NULL,
	[invoiceId] [uniqueidentifier] NOT NULL,
	[adjustmentType] [int] NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[value] [numeric](3, 2) NOT NULL,
	[shown] [bit] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobInvoiceAdjustment] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobInvoiceAdjustmentType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobInvoiceAdjustmentType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [int] NOT NULL,
	[updateId] [int] NOT NULL,
 CONSTRAINT [PK_JobAdjustmentType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobInvoiceItem]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobInvoiceItem](
	[id] [uniqueidentifier] NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[invoiceId] [uniqueidentifier] NOT NULL,
	[serviceID] [nvarchar](max) NOT NULL,
	[itemName] [nvarchar](100) NOT NULL,
	[itemQty] [int] NOT NULL,
	[itemPrice] [numeric](18, 2) NOT NULL,
	[itemActualPrice] [numeric](18, 2) NOT NULL,
	[itemDiscount] [numeric](18, 2) NOT NULL,
	[itemSurcharge] [numeric](18, 2) NOT NULL,
	[itemTotal] [numeric](18, 2) NOT NULL,
	[itemCategory] [nvarchar](200) NULL,
	[itemService] [nvarchar](200) NULL,
	[shown] [bit] NOT NULL,
	[generated] [bit] NOT NULL,
 CONSTRAINT [PK_JobInvoiceItem_1] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobInvoiceType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobInvoiceType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [int] NOT NULL,
	[insertId] [int] NOT NULL,
 CONSTRAINT [PK_JobInvoiceType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobKOCDetails]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobKOCDetails](
	[jobKOCID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[KOCSOFNumber] [nvarchar](50) NOT NULL,
	[contractNumber] [nvarchar](50) NOT NULL,
	[KOCRepresentatives] [nvarchar](100) NOT NULL,
	[briefJobDesc] [nvarchar](500) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobKOCDetails] PRIMARY KEY CLUSTERED 
(
	[jobKOCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobLock]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobLock](
	[JobLockId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[JobId] [uniqueidentifier] NULL,
	[Created] [datetime] NOT NULL,
	[Expiration] [datetime] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[wftid] [nvarchar](50) NULL,
 CONSTRAINT [PK_JobLock_JobLockId] PRIMARY KEY CLUSTERED 
(
	[JobLockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobMarketSegmentType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobMarketSegmentType](
	[jobMarketSegmentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[sort] [int] NOT NULL,
 CONSTRAINT [PK_JobMarketSegmentType] PRIMARY KEY CLUSTERED 
(
	[jobMarketSegmentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobNote]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobNote](
	[jobNoteId] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[employeeID] [int] NOT NULL,
	[deleted] [bit] NULL,
	[created] [datetime] NOT NULL,
	[note] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_JobNote] PRIMARY KEY NONCLUSTERED 
(
	[jobNoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationAuxData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationAuxData](
	[jobOperationAuxDataID] [uniqueidentifier] NOT NULL,
	[jobOperationID] [uniqueidentifier] NOT NULL,
	[qtyRequested] [int] NULL,
	[qtyAttempted] [int] NULL,
	[qtySuccessful] [int] NULL,
	[pressureAttempted] [float] NULL,
	[tightTests] [int] NULL,
	[noSeal] [int] NULL,
	[successfulTests] [int] NULL,
	[odometerStart] [float] NULL,
	[odometerEnd] [float] NULL,
	[startHours] [float] NULL,
	[endHours] [float] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[temperature] [float] NULL,
	[deleted] [bit] NULL,
	[pressureTestsAttempted] [int] NULL,
	[distanceTraveled] [float] NULL,
	[engineHours] [float] NULL,
	[journeyManagement] [nvarchar](200) NULL,
 CONSTRAINT [PK_JobOperationAuxData] PRIMARY KEY NONCLUSTERED 
(
	[jobOperationAuxDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationBranchPlantEditors]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationBranchPlantEditors](
	[JobOperationBranchPlantEditorId] [int] IDENTITY(1,1) NOT NULL,
	[BranchPlantId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JobOperationBranchPlantEditorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationEventAuxData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationEventAuxData](
	[auxillaryDataID] [uniqueidentifier] NOT NULL,
	[jobOperationEventID] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobOperationEventAuxData] PRIMARY KEY NONCLUSTERED 
(
	[auxillaryDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationEventIntervalCharge]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationEventIntervalCharge](
	[ID] [uniqueidentifier] NOT NULL,
	[EventIntervalId] [uniqueidentifier] NOT NULL,
	[ServiceId] [int] NULL,
	[ChargeType] [int] NULL,
	[ItemQty] [int] NOT NULL,
	[ItemPrice] [numeric](18, 9) NULL,
	[ItemDiscount] [numeric](18, 9) NULL,
	[ItemSurcharge] [numeric](18, 9) NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[serviceDetailID] [int] NULL,
	[itemQtyDec] [decimal](18, 9) NULL,
 CONSTRAINT [PK_JobOperationEventCharge] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationEventIntervals]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationEventIntervals](
	[jobOperationEventIntervalID] [uniqueidentifier] NOT NULL,
	[jobOperationEventID] [uniqueidentifier] NULL,
	[eventIntervalStartDepth] [float] NOT NULL,
	[eventIntervalStopDepth] [float] NULL,
	[eventIntervalOrder] [int] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[jobSelectedServicePerforatingDispatchDetailsID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_JobOperationEventIntervals] PRIMARY KEY NONCLUSTERED 
(
	[jobOperationEventIntervalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationEvents]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationEvents](
	[jobOperationEventID] [uniqueidentifier] NOT NULL,
	[jobOperationID] [uniqueidentifier] NOT NULL,
	[jobOperationEventOrder] [int] NOT NULL,
	[jobOperationEventComments] [ntext] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobOperationEvents] PRIMARY KEY NONCLUSTERED 
(
	[jobOperationEventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperations]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperations](
	[jobOperationID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[jobOperationTypeID] [int] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[jobOperationStartTime] [datetime] NOT NULL,
	[jobOperationEndTime] [datetime] NOT NULL,
	[jobOperationComments] [ntext] NULL,
	[deleted] [bit] NULL,
	[jobSelectedServiceDispatchDetailID] [uniqueidentifier] NULL,
	[publicComments] [nvarchar](512) NULL,
 CONSTRAINT [PK_JobOperations] PRIMARY KEY NONCLUSTERED 
(
	[jobOperationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationsCharge]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationsCharge](
	[ID] [uniqueidentifier] NOT NULL,
	[JobOperationId] [uniqueidentifier] NOT NULL,
	[ServiceId] [int] NULL,
	[ChargeType] [int] NULL,
	[ItemQty] [int] NOT NULL,
	[ItemPrice] [numeric](18, 9) NULL,
	[ItemDiscount] [numeric](18, 9) NULL,
	[ItemSurcharge] [numeric](18, 9) NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[serviceDetailID] [int] NULL,
	[itemQtyDec] [decimal](18, 9) NULL,
 CONSTRAINT [PK_JobOperationsCharge] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationTools]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationTools](
	[jobOperationToolID] [uniqueidentifier] NOT NULL,
	[jobOperationID] [uniqueidentifier] NOT NULL,
	[assetID] [int] NULL,
	[toolStringPosition] [int] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[GWIS_AssetID] [int] NULL,
 CONSTRAINT [PK_JobOperationTools] PRIMARY KEY NONCLUSTERED 
(
	[jobOperationToolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOperationTypes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOperationTypes](
	[jobOperationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[operationType] [nvarchar](100) NOT NULL,
	[operationDescription] [ntext] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[sortOrder] [tinyint] NOT NULL,
	[required] [bit] NULL,
	[jobTicketJobOperationCategoryID] [int] NULL,
 CONSTRAINT [PK_JobOperationTypes] PRIMARY KEY CLUSTERED 
(
	[jobOperationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobPrintConfiguration]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPrintConfiguration](
	[jobPrintConfigurationID] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[fontName] [nvarchar](255) NULL,
	[fontSize] [float] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[regionID] [int] NOT NULL,
	[areaID] [int] NULL,
	[districtID] [int] NULL,
	[deleted] [bit] NULL,
	[companyID] [int] NULL,
	[jobTypeID] [int] NULL,
	[operationalRegionID] [int] NULL,
	[operationalAreaID] [int] NULL,
	[operationalDistrictID] [int] NULL,
	[gwisLocationRegionID] [int] NULL,
	[gwisLocationCountryID] [int] NULL,
	[gwisLocationDistrictID] [int] NULL,
 CONSTRAINT [PK_JobPrintConfiguration] PRIMARY KEY CLUSTERED 
(
	[jobPrintConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobPrintConfigurationSections]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPrintConfigurationSections](
	[jobPrintConfigurationSectionID] [uniqueidentifier] NOT NULL,
	[jobPrintSectionID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[jobPrintConfigurationID] [uniqueidentifier] NOT NULL,
	[templateName] [nvarchar](255) NOT NULL,
	[isEnabled] [bit] NULL,
	[deleted] [bit] NULL,
	[precedence] [tinyint] NULL,
 CONSTRAINT [PK_JobPrintConfigurationSections] PRIMARY KEY CLUSTERED 
(
	[jobPrintConfigurationSectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobPrintSections]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPrintSections](
	[jobPrintSectionID] [int] IDENTITY(1,1) NOT NULL,
	[jobPrintSectionName] [nvarchar](255) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[sortOrder] [tinyint] NOT NULL,
 CONSTRAINT [PK_JobPrintSections] PRIMARY KEY CLUSTERED 
(
	[jobPrintSectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobReview]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobReview](
	[jobReviewID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NULL,
	[employeeID] [int] NOT NULL,
	[feCellRoleID] [int] NOT NULL,
	[accepted] [datetime] NULL,
	[deleted] [bit] NULL,
	[Step] [int] NOT NULL,
	[StepName] [nvarchar](200) NULL,
 CONSTRAINT [PK_JobReview_1] PRIMARY KEY NONCLUSTERED 
(
	[jobReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobRoles]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Gwis_LocationAttributeId] [int] NOT NULL,
	[FeCellRoleId] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[StepNumbers] [nvarchar](100) NULL,
 CONSTRAINT [PK_JobRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSchedulingLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSchedulingLog](
	[jobSchedulingLogID] [uniqueidentifier] NOT NULL,
	[lastApproximateTimeSelectionValueID] [int] NULL,
	[currentApproximateTimeSelectionValueID] [int] NULL,
	[lastScheduledStartDate] [datetime] NULL,
	[currentStartDate] [datetime] NOT NULL,
	[logDate] [datetime] NOT NULL,
	[wftid] [nvarchar](30) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobSchedulingLog] PRIMARY KEY CLUSTERED 
(
	[jobSchedulingLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSelectedServiceAssureConveyanceDetails]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSelectedServiceAssureConveyanceDetails](
	[jobSelectedServiceAssureConveyanceDetailID] [uniqueidentifier] NOT NULL,
	[jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL,
	[drillPipeODGrade] [nvarchar](50) NULL,
	[drillPipeThreadPattern] [nvarchar](50) NULL,
	[drillPipeSize] [decimal](18, 9) NULL,
	[drillPipeWeight] [decimal](18, 9) NULL,
	[drillPipeTube] [decimal](18, 9) NULL,
	[drillPipeJoint] [decimal](18, 9) NULL,
	[drillPipeCapacity] [decimal](18, 9) NULL,
	[drillPipeNumberOfJoints] [int] NULL,
	[drillPipeAverageJointLength] [decimal](18, 9) NULL,
	[drillPipeTotalLength] [decimal](18, 9) NULL,
	[drillPipeCrossOverProvidedBy] [nvarchar](50) NULL,
	[hwDrillPipeODGrade] [nvarchar](50) NULL,
	[hwDrillPipeThreadPattern] [nvarchar](50) NULL,
	[hwDrillPipeSize] [decimal](18, 9) NULL,
	[hwDrillPipeWeight] [decimal](18, 9) NULL,
	[hwDrillPipeTube] [decimal](18, 9) NULL,
	[hwDrillPipeJoint] [decimal](18, 9) NULL,
	[hwDrillPipeCapacity] [decimal](18, 9) NULL,
	[hwDrillPipeNumberOfJoints] [int] NULL,
	[hwDrillPipeAverageJointLength] [decimal](18, 9) NULL,
	[hwDrillPipeTotalLength] [decimal](18, 9) NULL,
	[hwDrillPipeScreenProvidedBy] [nvarchar](50) NULL,
	[pumpEfficiency] [decimal](18, 9) NULL,
	[pumpMinStrokeRate] [int] NULL,
	[pumpMaxStrokeRate] [int] NULL,
	[pumpOutput] [decimal](18, 9) NULL,
	[pumpStrokeLength] [decimal](18, 9) NULL,
	[pumpLinerSize] [decimal](18, 9) NULL,
	[pumpOtherLinerSize] [decimal](18, 9) NULL,
	[pumpMaxSafeCirculatingPressure] [decimal](18, 9) NULL,
	[pumpCirculatingStrokeRate] [int] NULL,
	[pumpCirculatingPressure] [decimal](18, 9) NULL,
	[pumpMessengerWith] [nvarchar](50) NULL,
	[pumpRigPump] [bit] NULL,
	[pumpTruck] [bit] NULL,
	[pumpCrippleRig] [bit] NULL,
	[pumpDivertFluidFromRig] [bit] NULL,
	[mudSystemFrictionReducerUsed] [bit] NULL,
	[mudSystemFrictionReducerDetail] [nvarchar](50) NULL,
	[depthSystemUsed] [bit] NULL,
	[depthSystemDetail] [nvarchar](50) NULL,
	[driftingMethodDropCirculatingDrift] [bit] NULL,
	[driftingMethodWhileStrappingIn] [bit] NULL,
	[driftingMethodSignOff] [bit] NULL,
	[driftingProvidedBy] [nvarchar](50) NULL,
	[loaderAvailableToUnloadDrillPipe] [bit] NULL,
	[internalDrillPipeCoating] [bit] NULL,
	[internalDrillPipeCoatingInspectionDate] [datetime] NULL,
	[otherComponentJars] [bit] NULL,
	[otherComponentCollars] [bit] NULL,
	[otherComponentScreens] [bit] NULL,
	[otherComponentCorrosionRings] [bit] NULL,
	[edrSystem] [nvarchar](50) NULL,
	[mudSystem] [nvarchar](50) NULL,
	[lostCirculatingRate] [nvarchar](50) NULL,
	[lcmContent] [nvarchar](50) NULL,
	[estimatedTripInTime] [nvarchar](50) NULL,
	[layingDownDrillPipe] [nvarchar](50) NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobSelectedServiceAssureConveyance] PRIMARY KEY CLUSTERED 
(
	[jobSelectedServiceAssureConveyanceDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSelectedServiceCasedHoleMechanicalDispatchDetails]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSelectedServiceCasedHoleMechanicalDispatchDetails](
	[jobSelectedServiceCasedHoleMechanicalDispatchDetailsID] [uniqueidentifier] NOT NULL,
	[jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL,
	[isSetChecked] [bit] NULL,
	[casedHoleMechanicalTypeID] [int] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobSelectedServiceCasedHoleMechanicalDispatchDetails] PRIMARY KEY CLUSTERED 
(
	[jobSelectedServiceCasedHoleMechanicalDispatchDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSelectedServiceDispatchDetails]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSelectedServiceDispatchDetails](
	[jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL,
	[jobSelectedServiceID] [uniqueidentifier] NOT NULL,
	[comments] [nvarchar](4000) NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobSelectedServiceDispatchDetails] PRIMARY KEY CLUSTERED 
(
	[jobSelectedServiceDispatchDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSelectedServicePerforatingDispatchDetails]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSelectedServicePerforatingDispatchDetails](
	[jobSelectedServicePerforatingDispatchDetailsID] [uniqueidentifier] NOT NULL,
	[ballisticGunTypeID] [int] NULL,
	[isSelectFire] [bit] NULL,
	[ballisticDetonatorTypeID] [int] NULL,
	[ballisticGunSizeID] [int] NULL,
	[ballisticIgniterID] [int] NULL,
	[ballisticInitiatorTypeID] [int] NULL,
	[ballisticManufacturerID] [int] NULL,
	[ballisticPhasingID] [int] NULL,
	[ballisticTypeOfChargeID] [int] NULL,
	[gramWeight] [float] NULL,
	[orientedGun] [bit] NULL,
	[deleted] [bit] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL,
	[ballisticSPFID] [int] NULL,
	[chargePartNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_JobSelectedServicePerforatingDispatchDetails] PRIMARY KEY CLUSTERED 
(
	[jobSelectedServicePerforatingDispatchDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSelectedServicePipeRecoveryDetails]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSelectedServicePipeRecoveryDetails](
	[jobSelectedServicePipeRecoveryDetailID] [uniqueidentifier] NOT NULL,
	[jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL,
	[connectionType] [nvarchar](255) NULL,
	[size] [float] NULL,
	[weight] [float] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobSelectedServicePipeRecovery] PRIMARY KEY CLUSTERED 
(
	[jobSelectedServicePipeRecoveryDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSelectedServices]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSelectedServices](
	[jobSelectedServiceID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[serviceGroupID] [int] NOT NULL,
	[servicePerformed] [bit] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobSelectedServices] PRIMARY KEY NONCLUSTERED 
(
	[jobSelectedServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSnapshot]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSnapshot](
	[jobSnapshotId] [int] IDENTITY(1,1) NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[employeeID] [int] NOT NULL,
	[created] [datetime] NOT NULL,
	[snapshot] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[jobSnapshotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobStatus](
	[jobStatusID] [tinyint] IDENTITY(1,1) NOT NULL,
	[jobStatus] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[sortOrder] [tinyint] NOT NULL,
	[deleted] [bit] NULL,
	[label] [nvarchar](50) NULL,
 CONSTRAINT [PK_JobStatus] PRIMARY KEY NONCLUSTERED 
(
	[jobStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobStatusLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobStatusLog](
	[jobStatusLogID] [uniqueidentifier] NOT NULL,
	[wftid] [nvarchar](50) NOT NULL,
	[modified] [datetime] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[oldJobStatusID] [tinyint] NULL,
	[newJobStatusID] [tinyint] NULL,
	[reason] [nvarchar](1000) NULL,
 CONSTRAINT [PK_JobStatusLog] PRIMARY KEY CLUSTERED 
(
	[jobStatusLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobSuperUsers]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSuperUsers](
	[employeeID] [int] NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_JobSuperUsers] PRIMARY KEY CLUSTERED 
(
	[employeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobTicketJobOperationCategory]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTicketJobOperationCategory](
	[jobTicketJobOperationCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_JobTicketJobOperationCategory] PRIMARY KEY CLUSTERED 
(
	[jobTicketJobOperationCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobWellBoreholeProfile]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobWellBoreholeProfile](
	[jobWellBoreholeProfileID] [uniqueidentifier] NOT NULL,
	[jobWellID] [uniqueidentifier] NOT NULL,
	[bitSizeID] [uniqueidentifier] NOT NULL,
	[startDepth] [float] NOT NULL,
	[endDepth] [float] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_JobWellBoreholeProfile] PRIMARY KEY NONCLUSTERED 
(
	[jobWellBoreholeProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobWellCasingTubingProfile]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobWellCasingTubingProfile](
	[jobWellCasingTubingProfileID] [uniqueidentifier] NOT NULL,
	[jobWellID] [uniqueidentifier] NOT NULL,
	[casingDimensionID] [uniqueidentifier] NOT NULL,
	[casingTypeID] [int] NOT NULL,
	[startDepth] [float] NOT NULL,
	[endDepth] [float] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[casingShoe] [decimal](18, 9) NULL,
 CONSTRAINT [PK_JobWellCasingTubingProfile] PRIMARY KEY NONCLUSTERED 
(
	[jobWellCasingTubingProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobWells]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobWells](
	[jobWellID] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[rigName] [nvarchar](200) NULL,
	[rigTypeID] [int] NULL,
	[drillingFluidTypeID] [int] NULL,
	[bottomHolePressure] [float] NULL,
	[bottomHoleTemperature] [float] NULL,
	[comments] [nvarchar](4000) NULL,
	[maxDeviation] [float] NULL,
	[maxDogLeg] [float] NULL,
	[wellLocationTypeID] [int] NULL,
	[oneViewWellID] [uniqueidentifier] NOT NULL,
	[conveyanceTypeID] [int] NULL,
	[acquisitionTypeID] [int] NULL,
	[conveyanceSubTypeID] [int] NULL,
	[totalDepth] [float] NULL,
	[tightHole] [bit] NULL,
	[deleted] [bit] NULL,
	[seismicWellTypeID] [int] NULL,
	[kellyBushing] [float] NULL,
	[groundLevel] [float] NULL,
	[hasH2S] [bit] NULL,
	[h2sLevel] [float] NULL,
	[hasCO2] [bit] NULL,
	[co2Level] [float] NULL,
	[shutInPressure] [float] NULL,
	[flowingPressure] [float] NULL,
	[hasWirelineControlValve] [bit] NULL,
	[surfacePressure] [float] NULL,
	[minimumID] [float] NULL,
	[wellHeadSize] [nvarchar](50) NULL,
	[wellHead] [nvarchar](100) NULL,
	[isLubricatorRequired] [bit] NULL,
	[isGreaseInjectorRequired] [bit] NULL,
	[lubricatorType] [nvarchar](100) NULL,
	[greaseInjectorType] [nvarchar](100) NULL,
	[mudDensity] [nvarchar](50) NULL,
	[mudViscosity] [nvarchar](50) NULL,
	[casingShoe] [decimal](18, 9) NULL,
	[originalHoleSideTrackedAt] [float] NULL,
	[fluidLevel] [float] NULL,
	[depthAtMinimumID] [float] NULL,
	[isPrimary] [bit] NULL,
	[UBDOrMPDLosses] [bit] NULL,
 CONSTRAINT [PK_JobWells_1] PRIMARY KEY NONCLUSTERED 
(
	[jobWellID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LastRunTimestamp]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LastRunTimestamp](
	[processName] [nvarchar](255) NULL,
	[timeStamp] [binary](8) NULL,
	[updatedDateTime] [datetime] NULL,
	[previousRunTimeStamp] [binary](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[id] [int] NOT NULL,
	[name] [nvarchar](300) NOT NULL,
	[address_id] [int] NOT NULL,
	[district_id] [int] NOT NULL,
	[tops_id] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location_Attribute_Types]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location_Attribute_Types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_Location_Attribute_Types] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location_Attribute_Values]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location_Attribute_Values](
	[id] [int] NOT NULL,
	[type] [int] NOT NULL,
	[value] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_Location_Attribute_Values_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location_Attributes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location_Attributes](
	[id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[value_id] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_Location_Attributes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocationLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GWIS_LocationAttributeID] [int] NOT NULL,
	[value] [nvarchar](2000) NULL,
	[deleted] [bit] NULL,
	[modifiedBy] [int] NOT NULL,
	[dateModified] [datetime] NOT NULL,
 CONSTRAINT [pk_LocationLog_LocationLogId] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceRequestCR]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceRequestCR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentID] [int] NOT NULL,
	[TOPS_Failure_ID] [int] NOT NULL,
	[DistrictManager] [int] NOT NULL,
	[Requester] [int] NOT NULL,
	[DateRequested] [datetime] NOT NULL,
	[PartNumber] [nvarchar](200) NULL,
	[Comments] [nvarchar](2000) NULL,
	[DateIssued] [datetime] NULL,
	[ApprovalReceived] [bit] NULL,
	[Approver] [int] NULL,
	[ApprovalDate] [datetime] NULL,
	[MRStatus] [int] NULL,
	[SerialNum] [nvarchar](100) NOT NULL,
	[Enode] [nvarchar](20) NULL,
	[MrNumber] [int] NULL,
	[WorkOrderNumber] [nvarchar](100) NULL,
	[PurchaseOrderNumber] [nvarchar](100) NULL,
	[JdeInvoiceNumber] [nvarchar](100) NULL,
	[LaborCost] [decimal](18, 9) NULL,
	[PartsCost] [decimal](18, 9) NULL,
	[ShippingCost] [decimal](18, 9) NULL,
	[CurrencyRateId] [int] NULL,
	[Vendor] [int] NULL,
	[Technologist] [int] NULL,
	[BusinessUnitId] [int] NOT NULL,
	[BranchPlantId] [int] NOT NULL,
 CONSTRAINT [pk_MaintenanceRequestCR_equipmentId] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceRequestCR_Status]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceRequestCR_Status](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Deleted] [bit] NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Sorder] [int] NULL,
 CONSTRAINT [pk_MaintenanceRequestCR_Status_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceRequestCRComments]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceRequestCRComments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InsertById] [int] NOT NULL,
	[Inserted] [datetime] NOT NULL,
	[Value] [nvarchar](2000) NULL,
	[MrId] [int] NOT NULL,
	[Deleted] [bit] NULL,
	[Modified] [datetime] NULL,
 CONSTRAINT [PK_MaintenanceRequestCRComments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceRequestCRCommentsLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceRequestCRCommentsLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CommentId] [int] NOT NULL,
	[OldComment] [text] NULL,
	[NewComment] [text] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Modified] [datetime] NOT NULL,
 CONSTRAINT [PK_MaintenanceRequestCRCommentsLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceRequestCRFile]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceRequestCRFile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](max) NOT NULL,
	[MrId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Inserted] [datetime] NOT NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_MaintenanceRequestCRFile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceRequestCRStatusLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceRequestCRStatusLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MrID] [int] NOT NULL,
	[OldStatusId] [int] NULL,
	[NewStatusId] [int] NOT NULL,
	[WftId] [nvarchar](50) NOT NULL,
	[Modified] [datetime] NOT NULL,
 CONSTRAINT [PK_MaintenanceRequestCRStatusLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceRequestCRVendors]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceRequestCRVendors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_MaintenanceRequestCRVendors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MeasurementSystems]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeasurementSystems](
	[measurementSystemID] [int] IDENTITY(1,1) NOT NULL,
	[systemName] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_MeasurementSystems] PRIMARY KEY CLUSTERED 
(
	[measurementSystemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MeasurementTypeDetail]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeasurementTypeDetail](
	[measurementTypeDetailID] [int] IDENTITY(1,1) NOT NULL,
	[measurementTypeID] [int] NOT NULL,
	[value] [nvarchar](50) NOT NULL,
	[measurementSystemID] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_MeasureTypeDetail] PRIMARY KEY CLUSTERED 
(
	[measurementTypeDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MeasurementTypes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeasurementTypes](
	[measurementTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_MeasurementTypes] PRIMARY KEY CLUSTERED 
(
	[measurementTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OneViewGWISSyncQueries]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OneViewGWISSyncQueries](
	[OneViewGWISSyncID] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](300) NULL,
	[selectStmt] [nvarchar](max) NOT NULL,
	[columnCount] [int] NOT NULL,
	[insertStmt] [nvarchar](max) NOT NULL,
	[updateStmt] [nvarchar](max) NOT NULL,
	[processReturn] [bit] NOT NULL,
	[processStmt] [nvarchar](max) NULL,
	[direction] [nvarchar](20) NOT NULL,
	[execOrder] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OneViewGWISSyncUpdateTimes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OneViewGWISSyncUpdateTimes](
	[lastGWISUpdateTime] [datetime] NOT NULL,
	[lastOneViewUpdateTS] [binary](8) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OneViewNotification]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OneViewNotification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WftId] [nvarchar](60) NULL,
	[Description] [nvarchar](200) NULL,
	[Category] [nvarchar](100) NULL,
	[Created] [datetime] NULL,
	[Url] [nvarchar](2000) NULL,
	[IsRead] [bit] NULL,
 CONSTRAINT [PK_OneViewNotification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationalLocation]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationalLocation](
	[gwis_locationattributeid] [int] NOT NULL,
	[gwis_locationid] [int] NOT NULL,
	[name] [nvarchar](300) NOT NULL,
	[parentId] [int] NULL,
	[lvl] [int] NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[attrVal] [nvarchar](1000) NULL,
	[attributeValueId] [int] NULL,
	[isCostCenter] [bit] NULL,
	[isRevenueCenter] [bit] NULL,
	[description] [nvarchar](300) NULL,
	[regionId] [int] NULL,
	[subregionId] [int] NULL,
	[countryId] [int] NULL,
	[areaId] [int] NULL,
	[districtId] [int] NULL,
	[branchplantId] [int] NULL,
	[businessunitId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationLetter]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationLetter](
	[OperationLetterId] [nvarchar](130) NOT NULL,
	[IssueDate] [datetime] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[OperationLetterStatusId] [int] NOT NULL,
	[OperationLetterTypeId] [int] NOT NULL,
	[Region] [int] NULL,
	[VersionChange] [bit] NOT NULL,
	[Cost] [money] NULL,
	[TimeToComplete] [numeric](18, 9) NULL,
	[CompletionDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OperationLetterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationLetterStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationLetterStatus](
	[OperationLetterStatusId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](20) NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OperationLetterStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationLetterTool]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationLetterTool](
	[OperationLetterToolId] [int] IDENTITY(1,1) NOT NULL,
	[OperationLetterId] [nvarchar](130) NOT NULL,
	[ToolPanelCodeVersionId] [int] NOT NULL,
	[EquipmentId] [int] NULL,
	[History] [nvarchar](500) NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OperationLetterToolId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationLetterType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationLetterType](
	[OperationLetterTypeId] [int] IDENTITY(1,1) NOT NULL,
	[OperationLetterType] [nvarchar](20) NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OperationLetterTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpsLetterNotification]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpsLetterNotification](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[wftid] [nvarchar](30) NOT NULL,
	[productId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OVTOPSSync]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OVTOPSSync](
	[lastdbts] [binary](8) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[People]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[personID] [uniqueidentifier] NOT NULL,
	[firstName] [nvarchar](100) NOT NULL,
	[lastName] [nvarchar](150) NULL,
	[middleName] [nvarchar](100) NULL,
	[secondLastName] [nvarchar](150) NULL,
	[nickName] [nvarchar](100) NULL,
	[jobTitle] [nvarchar](100) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[personID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeopleAddresses]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeopleAddresses](
	[peopleAddressID] [uniqueidentifier] NOT NULL,
	[personID] [uniqueidentifier] NOT NULL,
	[addressID] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_PeopleAddresses] PRIMARY KEY CLUSTERED 
(
	[peopleAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeopleCompanies]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeopleCompanies](
	[personID] [uniqueidentifier] NOT NULL,
	[personCompanyID] [uniqueidentifier] NOT NULL,
	[companyID] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
	[addressID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PeopleCompanies_1] PRIMARY KEY CLUSTERED 
(
	[personCompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pricebook]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pricebook](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](300) NOT NULL,
	[description] [nvarchar](300) NOT NULL,
	[book_level] [int] NULL,
	[book_parent] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[currencyRateID] [int] NULL,
	[obsolete] [bit] NULL,
	[jdePricebookCode] [nvarchar](50) NULL,
	[statusid] [tinyint] NULL,
	[CompanyId] [int] NULL,
	[GWIS_LocationAttributeID] [int] NULL,
	[discountable] [bit] NULL,
	[IncludeToSInPdf] [bit] NULL,
 CONSTRAINT [PK_Pricebook] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricebookData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricebookData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[ServiceDetails_id] [int] NULL,
	[Pricebook_id] [int] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_PricebookData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricebookDataLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricebookDataLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[modifiedById] [int] NOT NULL,
	[dateModified] [datetime] NOT NULL,
	[pricebookDataId] [int] NOT NULL,
	[pricebookId] [int] NOT NULL,
	[name] [nvarchar](150) NOT NULL,
	[alternateName] [nvarchar](150) NULL,
	[serviceTypeId] [int] NOT NULL,
	[serviceGroupId] [int] NULL,
	[systemCode] [nvarchar](50) NOT NULL,
	[thirdPartySystemCode] [nvarchar](50) NULL,
	[pricingStyleId] [int] NOT NULL,
	[price] [numeric](18, 9) NOT NULL,
	[isBonusable] [bit] NULL,
	[deleted] [bit] NULL,
	[SpecialLine] [nvarchar](250) NULL,
	[SpecialLineNo] [nvarchar](250) NULL,
	[SpecialToolMnemonic] [nvarchar](250) NULL,
 CONSTRAINT [PK_PricebookDataLog_Id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PriceBookEmployee]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceBookEmployee](
	[priceBookEmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[priceBookID] [int] NOT NULL,
	[employeeID] [int] NOT NULL,
	[priceBookEmployeeRoleID] [tinyint] NOT NULL,
	[deleted] [bit] NULL,
	[modifiedAt] [datetime] NULL,
	[modifiedBy] [nvarchar](30) NULL,
 CONSTRAINT [PK_PriceBookEmployee] PRIMARY KEY CLUSTERED 
(
	[priceBookEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PriceBookEmployeeRole]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceBookEmployeeRole](
	[priceBookEmployeeRoleID] [tinyint] IDENTITY(1,1) NOT NULL,
	[priceBookEmployeeRole] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_priceBookEmployeeRoleID] PRIMARY KEY CLUSTERED 
(
	[priceBookEmployeeRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pricebooks-2016-04-29-Chevron]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pricebooks-2016-04-29-Chevron](
	[Name] [nvarchar](255) NULL,
	[Alt Name] [nvarchar](255) NULL,
	[Service Type] [nvarchar](255) NULL,
	[Service Group] [nvarchar](255) NULL,
	[JDE Part No#] [float] NULL,
	[3rd Party No#] [nvarchar](255) NULL,
	[Pricing Style Name] [nvarchar](255) NULL,
	[Price] [float] NULL,
	[Bounsable] [float] NULL,
	[Discountable] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricebookSectionPdfOptions]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricebookSectionPdfOptions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PricebookId] [int] NOT NULL,
	[ServiceTypeId] [int] NOT NULL,
	[Show] [bit] NOT NULL,
	[Picture] [text] NULL,
	[PageBreak] [bit] NOT NULL,
	[Notes] [ntext] NULL,
	[Conditions] [ntext] NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_PricebookSectionPdfOptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PriceBookStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceBookStatus](
	[priceBookStatusId] [tinyint] IDENTITY(1,1) NOT NULL,
	[priceBookStatus] [nvarchar](40) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_PriceBookStatus] PRIMARY KEY CLUSTERED 
(
	[priceBookStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricebookTree]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricebookTree](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[parent] [int] NOT NULL,
	[system] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_PricebookTree] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricingStyle]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricingStyle](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[uom] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](300) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_PricingStyle] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessSlimlineJobs]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessSlimlineJobs](
	[invoice] [int] NULL,
	[ordernumber] [int] NOT NULL,
	[fieldticketnumber] [nvarchar](255) NOT NULL,
	[value] [decimal](18, 9) NOT NULL,
	[longitemnumber] [int] NULL,
	[processed] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quote]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quote](
	[quoteID] [uniqueidentifier] NOT NULL,
	[isBid] [bit] NULL,
	[contractIdentifier] [nvarchar](100) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[jobID] [uniqueidentifier] NOT NULL,
	[validUntilDateTime] [datetime] NULL,
 CONSTRAINT [PK_Quote] PRIMARY KEY CLUSTERED 
(
	[quoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Region]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[created] [datetime] NOT NULL,
	[modified] [datetime] NOT NULL,
	[modified_by] [nvarchar](100) NOT NULL,
	[active] [char](1) NOT NULL,
	[active_date] [datetime] NOT NULL,
	[non_active_date] [datetime] NULL,
	[operational] [char](1) NULL,
	[geographic] [char](1) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentalChargeTypes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentalChargeTypes](
	[rentalChargeTypeID] [int] IDENTITY(1,1) NOT NULL,
	[chargeType] [nvarchar](50) NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_RentalChargeTypes] PRIMARY KEY CLUSTERED 
(
	[rentalChargeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RigType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RigType](
	[rigTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[wellLocationTypeID] [int] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_RigType] PRIMARY KEY CLUSTERED 
(
	[rigTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_Master]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_Master](
	[RoleId] [smallint] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[RoleDescription] [nvarchar](50) NULL,
	[Role_Category] [nvarchar](15) NULL,
 CONSTRAINT [PK_Role_master] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sample_soa]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sample_soa](
	[sequencecreationdate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SeismicWellTypes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeismicWellTypes](
	[seismicWellTypeID] [int] IDENTITY(1,1) NOT NULL,
	[seismicWellType] [nvarchar](50) NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_SeismicWellTypes] PRIMARY KEY CLUSTERED 
(
	[seismicWellTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sequences]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sequences](
	[Name] [nvarchar](300) NOT NULL,
	[Sequence] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](150) NOT NULL,
	[description] [nvarchar](300) NOT NULL,
	[service_group] [int] NULL,
	[service_type] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
	[alternateName] [nvarchar](150) NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceDetails]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[service_id] [int] NOT NULL,
	[system_id] [nvarchar](50) NOT NULL,
	[system_code] [nvarchar](50) NOT NULL,
	[pricing_style] [int] NOT NULL,
	[price] [numeric](18, 9) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[OneUSDtoCurrency] [decimal](18, 9) NULL,
	[Currency] [nvarchar](10) NULL,
	[DateCurrencyApplied] [datetime] NULL,
	[deleted] [bit] NULL,
	[isBonusable] [bit] NULL,
	[thirdPartySystemCode] [nvarchar](50) NULL,
	[modifiedBy] [nvarchar](30) NULL,
	[modifiedAt] [datetime] NULL,
	[discountable] [bit] NULL,
	[SpecialLine] [nvarchar](250) NULL,
	[SpecialLineNo] [nvarchar](250) NULL,
	[SpecialToolMnemonic] [nvarchar](250) NULL,
 CONSTRAINT [PK_ServiceDetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceGroup]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceGroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](300) NOT NULL,
	[service_type] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ServiceGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceGroupToolType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceGroupToolType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[servicegroupid] [int] NOT NULL,
	[toolpaneltypeid] [nvarchar](20) NOT NULL,
	[toolcodetypeid] [nvarchar](20) NOT NULL,
	[version] [nvarchar](20) NOT NULL,
	[modified] [datetime] NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_ServiceGroupToolType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceTool]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceTool](
	[id] [int] NOT NULL,
	[service_id] [int] NOT NULL,
	[tool_id] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ServiceTool] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](300) NOT NULL,
	[system] [int] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_ServiceType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SOA_Sample]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOA_Sample](
	[sequencecreationdate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SOA-DTMesssages_all_messages_2016]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOA-DTMesssages_all_messages_2016](
	[User ID] [varchar](250) NULL,
	[Transaction Number] [varchar](250) NULL,
	[Batch Number] [varchar](250) NULL,
	[Order Number] [varchar](250) NULL,
	[Or Ty] [varchar](250) NULL,
	[Order Co] [varchar](250) NULL,
	[Business Unit] [varchar](250) NULL,
	[Address Number] [varchar](250) NULL,
	[Hd Cd] [varchar](250) NULL,
	[Ship To Number] [varchar](250) NULL,
	[Referance 2] [varchar](250) NULL,
	[Request Date] [varchar](250) NULL,
	[Ordered By] [varchar](250) NULL,
	[Address Line 4] [varchar](250) NULL,
	[Creation Date] [varchar](250) NULL,
	[Seq No ] [varchar](250) NULL,
	[Header Business Unit] [varchar](250) NULL,
	[Land  Offshore] [varchar](250) NULL,
	[Hd CD2] [varchar](250) NULL,
	[Actual Ship Date] [varchar](250) NULL,
	[Job Number] [varchar](250) NULL,
	[Job Type] [varchar](250) NULL,
	[Cost Center] [varchar](250) NULL,
	[Salesprsn Code] [varchar](250) NULL,
	[Slsprsn 2 Code] [varchar](250) NULL,
	[Salesprsn Code3] [varchar](250) NULL,
	[Invoice Date] [varchar](250) NULL,
	[Lot Serial Number] [varchar](250) NULL,
	[Memo Lot 1] [varchar](250) NULL,
	[Memo Lot 2] [varchar](250) NULL,
	[Memo Lot 3] [varchar](250) NULL,
	[2nd Item Number] [varchar](250) NULL,
	[Asset Number] [varchar](250) NULL,
	[Eq St] [varchar](250) NULL,
	[Quantity Shipped] [varchar](250) NULL,
	[Lot Serial Number4] [varchar](250) NULL,
	[LineNumber] [varchar](250) NULL,
	[Location] [varchar](250) NULL,
	[Description] [varchar](2000) NULL,
	[Description Line 2] [varchar](2000) NULL,
	[Unit Weight] [varchar](250) NULL,
	[IV Bill Type] [varchar](250) NULL,
	[Ln Ty] [varchar](250) NULL,
	[Line Type Description] [varchar](250) NULL,
	[User Quantity] [varchar](250) NULL,
	[Origin Country] [varchar](250) NULL,
	[Extended Price] [varchar](250) NULL,
	[Foreign Extended Price] [varchar](250) NULL,
	[RC] [varchar](250) NULL,
	[Return Date] [varchar](250) NULL,
	[Returned By] [varchar](250) NULL,
	[Number] [varchar](250) NULL,
	[Units Returned] [varchar](250) NULL,
	[Quantity Lost Sold] [varchar](250) NULL,
	[Date Updated] [varchar](250) NULL,
	[Time of Day] [varchar](250) NULL,
	[To Curr] [varchar](250) NULL,
	[Cur Cod] [varchar](250) NULL,
	[Document Number] [varchar](250) NULL,
	[Do Ty] [varchar](250) NULL,
	[Doc Co] [varchar](250) NULL,
	[Invoice Sequence] [varchar](250) NULL,
	[Original Line Number] [varchar](250) NULL,
	[Address Line 1] [varchar](250) NULL,
	[Address Line 3] [varchar](250) NULL,
	[Address Line 2] [varchar](250) NULL,
	[LNID] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SOA-DTMesssages_all_messages_2016_old]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOA-DTMesssages_all_messages_2016_old](
	[User ID] [varchar](50) NULL,
	[Transaction Number] [varchar](50) NULL,
	[Batch Number] [varchar](50) NULL,
	[Order Number] [varchar](50) NULL,
	[Or Ty] [varchar](50) NULL,
	[Order Co] [varchar](50) NULL,
	[Business Unit] [varchar](50) NULL,
	[Address Number] [varchar](50) NULL,
	[Hd Cd] [varchar](50) NULL,
	[Ship To Number] [varchar](50) NULL,
	[Referance 2] [varchar](50) NULL,
	[Request Date] [varchar](50) NULL,
	[Ordered By] [varchar](50) NULL,
	[Address Line 4] [varchar](50) NULL,
	[Creation Date] [varchar](50) NULL,
	[Seq No ] [varchar](50) NULL,
	[Header Business Unit] [varchar](50) NULL,
	[Land  Offshore] [varchar](50) NULL,
	[Hd CD2] [varchar](50) NULL,
	[Actual Ship Date] [varchar](50) NULL,
	[Job Number] [varchar](50) NULL,
	[Job Type] [varchar](50) NULL,
	[Cost Center] [varchar](50) NULL,
	[Salesprsn Code] [varchar](50) NULL,
	[Slsprsn 2 Code] [varchar](50) NULL,
	[Salesprsn Code3] [varchar](50) NULL,
	[Invoice Date] [varchar](50) NULL,
	[Lot Serial Number] [varchar](50) NULL,
	[Memo Lot 1] [varchar](50) NULL,
	[Memo Lot 2] [varchar](50) NULL,
	[Memo Lot 3] [varchar](50) NULL,
	[2nd Item Number] [varchar](50) NULL,
	[Asset Number] [varchar](50) NULL,
	[Eq St] [varchar](50) NULL,
	[Quantity Shipped] [varchar](50) NULL,
	[Lot Serial Number4] [varchar](50) NULL,
	[LineNumber] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Description Line 2] [varchar](50) NULL,
	[Unit Weight] [varchar](50) NULL,
	[IV Bill Type] [varchar](50) NULL,
	[Ln Ty] [varchar](50) NULL,
	[Line Type Description] [varchar](50) NULL,
	[User Quantity] [varchar](50) NULL,
	[Origin Country] [varchar](50) NULL,
	[Extended Price] [varchar](50) NULL,
	[Foreign Extended Price] [varchar](50) NULL,
	[RC] [varchar](50) NULL,
	[Return Date] [varchar](50) NULL,
	[Returned By] [varchar](50) NULL,
	[Number] [varchar](50) NULL,
	[Units Returned] [varchar](50) NULL,
	[Quantity Lost Sold] [varchar](50) NULL,
	[Date Updated] [varchar](50) NULL,
	[Time of Day] [varchar](50) NULL,
	[To Curr] [varchar](50) NULL,
	[Cur Cod] [varchar](50) NULL,
	[Document Number] [varchar](50) NULL,
	[Do Ty] [varchar](50) NULL,
	[Doc Co] [varchar](50) NULL,
	[Invoice Sequence] [varchar](50) NULL,
	[Original Line Number] [varchar](50) NULL,
	[Address Line 1] [varchar](50) NULL,
	[Address Line 3] [varchar](50) NULL,
	[Address Line 2] [varchar](50) NULL,
	[LNID] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SOA-DTMesssages-AllData_Counts]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOA-DTMesssages-AllData_Counts](
	[Order Number] [real] NULL,
	[Batch Number] [varchar](50) NULL,
	[COUNT] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SOA-DTMesssages-AllData_Counts_old]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOA-DTMesssages-AllData_Counts_old](
	[Order Number] [float] NULL,
	[Batch Number] [nvarchar](255) NULL,
	[Count] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SSISErrorLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SSISErrorLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SSISPackageName] [nvarchar](255) NOT NULL,
	[created] [datetime] NOT NULL,
	[ErrorCode] [int] NULL,
	[ErrorDetails] [nvarchar](max) NULL,
	[TaskName] [nvarchar](500) NULL,
 CONSTRAINT [PK_SSISErrorLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StagingFixedAssets]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StagingFixedAssets](
	[FixedAssetId] [uniqueidentifier] NOT NULL,
	[SerialNum] [varchar](50) NULL,
	[InventoryItemNum] [varchar](30) NULL,
	[AssetNumber] [varchar](30) NULL,
	[ParentNumber] [varchar](30) NULL,
	[BranchPlant] [varchar](75) NULL,
	[EquipmentStatus] [varchar](2) NULL,
	[RNItemNum] [varchar](30) NULL,
	[AssetDescription] [varchar](60) NULL,
	[LastStatusChangeDate] [datetime] NULL,
	[DateDisposed] [datetime] NULL,
	[CurrencyCode] [varchar](3) NULL,
	[Revision] [varchar](2) NULL,
	[CatCode16] [varchar](3) NULL,
	[ToolPanel] [varchar](30) NULL,
	[ToolCode] [varchar](30) NULL,
	[DateAdded] [datetime] NULL,
	[BusinessUnit] [varchar](12) NULL,
	[ThirdItemNumber] [varchar](40) NULL,
	[AssetLifeRemaining] [numeric](6, 2) NULL,
	[ProductVersion] [varchar](20) NULL,
	[EquipmentDivision] [varchar](200) NULL,
	[TopLevelFixedAssetId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StagingToolPanel]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StagingToolPanel](
	[ToolPanel] [nvarchar](50) NOT NULL,
	[ToolCode] [nvarchar](50) NOT NULL,
	[Version] [nvarchar](50) NULL,
	[AssetDescription] [nvarchar](max) NULL,
	[EquipmentStatus] [nchar](10) NULL,
	[LastStatusChangeDate] [nvarchar](50) NULL,
	[DateAdded] [nvarchar](50) NULL,
	[ThirditemNumber] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Support]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Support](
	[supportID] [uniqueidentifier] NOT NULL,
	[supportTypeID] [tinyint] NOT NULL,
	[supportStatusID] [tinyint] NOT NULL,
	[dateSubmitted] [datetime] NOT NULL,
	[dateCompleted] [datetime] NULL,
	[submittedByID] [int] NOT NULL,
	[assignedToID] [int] NULL,
	[subject] [varchar](100) NOT NULL,
	[description] [text] NOT NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NULL,
	[insertId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Support] PRIMARY KEY NONCLUSTERED 
(
	[supportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupportLog]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupportLog](
	[supportLogID] [int] IDENTITY(1,1) NOT NULL,
	[supportID] [uniqueidentifier] NULL,
	[submittedByID] [int] NULL,
	[callLog] [varchar](max) NULL,
 CONSTRAINT [PK_SupportLog] PRIMARY KEY CLUSTERED 
(
	[supportLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupportSchedule]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupportSchedule](
	[SupportScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SupportScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupportStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupportStatus](
	[supportStatusID] [tinyint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_SupportStatus] PRIMARY KEY CLUSTERED 
(
	[supportStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupportType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupportType](
	[supportTypeID] [tinyint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_SupportType] PRIMARY KEY CLUSTERED 
(
	[supportTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[System]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[System](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ADGroup] [nvarchar](50) NULL,
	[DatabaseName] [nvarchar](50) NULL,
	[EnumValue]  AS (power((2),[id]-(1))),
	[db_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_System] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemUser]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemUser](
	[SAMAccountName] [nvarchar](255) NOT NULL,
	[displayName] [nvarchar](255) NULL,
	[mobile] [nvarchar](255) NULL,
	[extensionAttribute10] [nvarchar](255) NULL,
	[department] [nvarchar](255) NULL,
	[mail] [nvarchar](320) NULL,
	[l] [nvarchar](255) NULL,
	[initials] [nvarchar](50) NULL,
	[givenName] [nvarchar](255) NULL,
	[extensionAttribute13] [nvarchar](255) NULL,
	[lastLogonTimestamp] [datetime] NULL,
	[objectGUID] [uniqueidentifier] NOT NULL,
	[whenCreated] [datetime] NULL,
	[whenChanged] [datetime] NULL,
	[userAccountControl] [int] NULL,
	[title] [nvarchar](255) NULL,
	[telephoneNumber] [nvarchar](255) NULL,
	[streetAddress] [nvarchar](255) NULL,
	[st] [nvarchar](255) NULL,
	[sn] [nvarchar](255) NULL,
	[postalCode] [nvarchar](255) NULL,
	[physicalDeliveryOfficeName] [nvarchar](255) NULL,
	[managerSAMAccountName] [nvarchar](255) NULL,
	[extensionAttribute11] [nvarchar](255) NULL,
	[co] [nvarchar](255) NULL,
	[manager] [nvarchar](255) NULL,
	[extensionAttribute4] [nvarchar](255) NULL,
	[c] [nvarchar](255) NULL,
	[distinguishedName] [nvarchar](255) NULL,
	[AccumulatedSystemEnumValue] [int] NULL,
	[employeeid] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
 CONSTRAINT [PK__SystemUs__BB913ED50318608F] PRIMARY KEY CLUSTERED 
(
	[objectGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_JobBonusData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_JobBonusData](
	[jobBonusDataID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[jobActualServiceID] [uniqueidentifier] NULL,
	[bonusPercentage] [decimal](18, 9) NULL,
	[bonusTotal] [decimal](18, 9) NULL,
	[deleted] [bit] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[bonusNumberOfDays] [decimal](18, 9) NULL,
	[bonusDayRate] [decimal](18, 9) NULL,
	[serviceOrTicketTotal] [decimal](18, 9) NULL,
	[splitPercentage] [decimal](18, 9) NULL,
	[failurePercentage] [decimal](18, 9) NULL,
	[jdeServiceOrTicketTotal] [decimal](18, 9) NULL,
	[jdeBonusTotal] [decimal](18, 9) NULL,
	[recommendedBonusPercentage] [decimal](18, 9) NULL,
	[catsID] [nvarchar](50) NULL,
	[comments] [nvarchar](4000) NULL,
	[nativeBonusTotal] [decimal](18, 9) NULL,
	[nativeServiceOrTicketTotal] [decimal](18, 9) NULL,
	[nativeJDEServiceOrderTicketTotal] [decimal](18, 9) NULL,
	[nativeJDEBonusTotal] [decimal](18, 9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempADUsers]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempADUsers](
	[name] [nvarchar](255) NULL,
	[ExtensionAttribute13] [nvarchar](255) NULL,
	[ExtensionAttribute4] [nvarchar](255) NULL,
	[co] [nvarchar](255) NULL,
	[c] [nvarchar](255) NULL,
	[sAMAccountName] [nvarchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_data_conversion_failure]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_data_conversion_failure](
	[dropTransactionName] [nvarchar](255) NULL,
	[dropMessageDetail_Id] [numeric](20, 0) NULL,
	[dropAssetNumber] [int] NULL,
	[dropCompany] [nvarchar](255) NULL,
	[dropBranchPlant] [nvarchar](255) NULL,
	[dropDocumentType] [nvarchar](255) NULL,
	[dropDocumentNumber] [int] NULL,
	[dropInvoiceNumber] [nvarchar](255) NULL,
	[dropAddressNumber] [int] NULL,
	[dropAssetDescription1] [nvarchar](255) NULL,
	[dropAssetDescription2] [nvarchar](255) NULL,
	[dropAssetDescription3] [nvarchar](255) NULL,
	[dropRBU] [nvarchar](255) NULL,
	[dropItemNo] [nvarchar](255) NULL,
	[dropSerialNo] [nvarchar](255) NULL,
	[dropQuantity] [nvarchar](255) NULL,
	[dropCurrencyCode] [nvarchar](255) NULL,
	[dropCost] [nvarchar](255) NULL,
	[dropAccumulatedDepreciation] [nvarchar](255) NULL,
	[dropNetBookValue] [nvarchar](255) NULL,
	[dropAssetStatus] [nvarchar](255) NULL,
	[dropProductLineCode] [nvarchar](255) NULL,
	[dropUnitNumber] [nvarchar](255) NULL,
	[dropInventoryPartNumber] [nvarchar](255) NULL,
	[dropLegacyPartNumber] [nvarchar](255) NULL,
	[dropAFE] [nvarchar](255) NULL,
	[dropState] [nvarchar](255) NULL,
	[dropContractAccount] [nvarchar](255) NULL,
	[dropOwnership] [nvarchar](255) NULL,
	[dropDateAcquired] [nvarchar](255) NULL,
	[dropLifeMonthsonAARegister] [nvarchar](255) NULL,
	[dropStartDeprDate] [nvarchar](255) NULL,
	[dropNeworUsed] [nvarchar](255) NULL,
	[dropManufacturer] [nvarchar](255) NULL,
	[dropModelYear] [nvarchar](255) NULL,
	[dropPanelCodeVersion] [nvarchar](255) NULL,
	[dropWhoAddedAsset] [nvarchar](255) NULL,
	[dropAssetAdditionDate] [nvarchar](255) NULL,
	[dropProgramId] [nvarchar](255) NULL,
	[dropWFTRouting] [nvarchar](255) NULL,
	[dropUserDisposed] [nvarchar](255) NULL,
	[dropDateDisposed] [nvarchar](255) NULL,
	[dropParentAsset] [nvarchar](255) NULL,
	[dropShipmentNumber] [int] NULL,
	[dropDateShipConfirmed] [nvarchar](255) NULL,
	[dropUserCreatedDocument] [nvarchar](255) NULL,
	[dropUserApprovedonRecvSide] [nvarchar](255) NULL,
	[dropDateApproved] [nvarchar](255) NULL,
	[dropSendingLocation] [nvarchar](255) NULL,
	[dropReceivingLocation] [nvarchar](255) NULL,
	[dropAssetTransferReqNo] [nvarchar](255) NULL,
	[dropDateofTransaction] [nvarchar](255) NULL,
	[dropTimeofTransaction] [nvarchar](255) NULL,
	[dropOwnershipCode] [nvarchar](255) NULL,
	[dropRevision] [nvarchar](255) NULL,
	[xmlAssetNumber] [numeric](8, 0) NULL,
	[xmlCompany] [varchar](5) NULL,
	[xmlBranchPlant] [varchar](12) NULL,
	[xmlAssetDescription1] [varchar](30) NULL,
	[xmlAssetDescription2] [varchar](30) NULL,
	[xmlAssetDescription3] [varchar](30) NULL,
	[xmlParentAsset] [numeric](8, 0) NULL,
	[xmlManufacturersSerialNo] [varchar](25) NULL,
	[xmlRBU] [varchar](12) NULL,
	[xmlItemNo] [varchar](30) NULL,
	[xmlSerialNo] [varchar](30) NULL,
	[xmlQuantity] [numeric](15, 2) NULL,
	[xmlCost] [decimal](28, 2) NULL,
	[xmlAccumulatedDepreciation] [decimal](28, 2) NULL,
	[xmlProductLineCode] [varchar](3) NULL,
	[xmlUnitNumber] [varchar](12) NULL,
	[xmlInventoryPartNumber] [numeric](8, 0) NULL,
	[xmlLegacyPartNumber] [varchar](25) NULL,
	[xmlAFE] [varchar](12) NULL,
	[xmlState] [varchar](3) NULL,
	[xmlContractAccount] [varchar](25) NULL,
	[xmlOwnership] [varchar](3) NULL,
	[xmlDateAcquired] [datetime] NULL,
	[xmlLifeMonths] [numeric](4, 0) NULL,
	[xmlStartDeprDate] [datetime] NULL,
	[xmlNeworUsed] [varchar](1) NULL,
	[xmlManufacturer] [varchar](3) NULL,
	[xmlModelYear] [varchar](3) NULL,
	[xmlPanelCodeVersion] [varchar](25) NULL,
	[xmlDateDisposed] [datetime] NULL,
	[xmlAssetStatus] [varchar](2) NULL,
	[xmlAddressNumber] [int] NULL,
	[xmlCurrencyCode] [varchar](3) NULL,
	[xmlNetBookValue] [decimal](28, 2) NULL,
	[xmlAssetAdditionDate] [datetime] NULL,
	[xmlDateShipConfirmed] [datetime] NULL,
	[xmlShipmentNumber] [int] NULL,
	[xmlDateApproved] [datetime] NULL,
	[xmlSendingLocation] [varchar](12) NULL,
	[xmlReceivingLocation] [varchar](12) NULL,
	[xmlDateofTransaction] [datetime] NULL,
	[Asset_Number] [numeric](8, 0) NULL,
	[Company] [varchar](5) NULL,
	[Branch_Plant] [varchar](12) NULL,
	[outAsset_Description1] [varchar](1000) NULL,
	[outAsset_Description2] [varchar](1000) NULL,
	[outAsset_Description3] [varchar](1000) NULL,
	[Parent_Number] [numeric](8, 0) NULL,
	[Manfacturers_Serial_Number] [varchar](25) NULL,
	[outBusiness_Unit] [varchar](25) NULL,
	[Item_No] [varchar](30) NULL,
	[Serial_No] [varchar](30) NULL,
	[Current_Item_Qty] [numeric](15, 0) NULL,
	[Currency_Code] [varchar](3) NULL,
	[Cost] [numeric](15, 2) NULL,
	[Accum_Depreciation] [numeric](15, 2) NULL,
	[Net_Book_Value] [numeric](15, 2) NULL,
	[Product_line_code] [varchar](3) NULL,
	[Unit_number] [varchar](12) NULL,
	[Inventory_Part_Number] [numeric](8, 0) NULL,
	[Legacy_Part_Number] [varchar](25) NULL,
	[AFE_Number] [varchar](12) NULL,
	[State] [varchar](3) NULL,
	[Contact_Account] [varchar](25) NULL,
	[outownership] [varchar](3) NULL,
	[Date_Acquired] [datetime] NULL,
	[Life_Months] [numeric](4, 0) NULL,
	[Start_Depreciation_Date] [datetime] NULL,
	[New_Or_Used] [varchar](1) NULL,
	[Manufacturer] [varchar](3) NULL,
	[Model_Year] [varchar](3) NULL,
	[Third_Item_Number] [varchar](25) NULL,
	[Date_Disposed] [datetime] NULL,
	[Fiscal_Year] [numeric](2, 0) NULL,
	[Ledger_Type] [varchar](2) NULL,
	[CAT_Code_16] [varchar](3) NULL,
	[Equipment_Status] [varchar](2) NULL,
	[outDate_Disposed] [datetime] NULL,
	[outStart_Depreciation_Date] [datetime] NULL,
	[outdate_Acquired] [datetime] NULL,
	[Asset_description1] [varchar](30) NULL,
	[Asset_description2] [varchar](30) NULL,
	[Asset_description3] [varchar](30) NULL,
	[Business_Unit] [varchar](12) NULL,
	[Ownership] [varchar](10) NULL,
	[dropManufacturersSerialNo] [nvarchar](255) NULL,
	[ErrorCode] [int] NULL,
	[ErrorColumn] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_fixWPTSDupes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_fixWPTSDupes](
	[jobid] [uniqueidentifier] NOT NULL,
	[wptsID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp2wpts_jobPostings]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp2wpts_jobPostings](
	[wptsid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpCAInvoiceJDE]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpCAInvoiceJDE](
	[deliveryTicketID] [int] NULL,
	[OneViewFieldTicket] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpDTJobRestriction]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpDTJobRestriction](
	[jobid] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpJobBonusAdjustment]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpJobBonusAdjustment](
	[jobBonusAdjustmentID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[hrmsEmployeeID] [nvarchar](50) NULL,
	[fullname] [nvarchar](150) NULL,
	[serviceOrder] [nvarchar](50) NULL,
	[jobid] [uniqueidentifier] NOT NULL,
	[jobBonusProcessedID] [uniqueidentifier] NOT NULL,
	[processedBy] [nvarchar](50) NOT NULL,
	[dateProcessed] [datetime] NOT NULL,
	[actualBonusTotal] [decimal](18, 9) NOT NULL,
	[country] [nvarchar](50) NOT NULL,
	[currencyCode] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tmpJobBonusAdjustment] PRIMARY KEY NONCLUSTERED 
(
	[jobBonusAdjustmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpJobBonusHistory]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpJobBonusHistory](
	[jobBonusHistoryID] [uniqueidentifier] NOT NULL,
	[jobBonusID] [uniqueidentifier] NOT NULL,
	[hrmsEmployeeID] [nvarchar](50) NULL,
	[fullname] [nvarchar](150) NULL,
	[serviceOrder] [nvarchar](50) NULL,
	[jobid] [uniqueidentifier] NOT NULL,
	[jobBonusProcessedID] [uniqueidentifier] NOT NULL,
	[processedBy] [nvarchar](50) NOT NULL,
	[dateProcessed] [datetime] NOT NULL,
	[actualBonusTotal] [decimal](18, 9) NOT NULL,
	[country] [nvarchar](50) NOT NULL,
	[currencyCode] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tmpJobBonusHistory] PRIMARY KEY NONCLUSTERED 
(
	[jobBonusHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TMPSOADTPipelineMessageProcessing]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMPSOADTPipelineMessageProcessing](
	[SOADTPipelineMessageProcessingID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [bigint] NOT NULL,
	[jobID] [uniqueidentifier] NULL,
	[canProcess] [bit] NULL,
	[processed] [bit] NULL,
	[dateProcessed] [datetime] NULL,
	[SequenceNumber] [int] NOT NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_TMPSOADTPipelineMessageProcessing] PRIMARY KEY CLUSTERED 
(
	[SOADTPipelineMessageProcessingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TMPSOADTPipelineMessages]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMPSOADTPipelineMessages](
	[SOADTPipelineMessageID] [bigint] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](255) NULL,
	[Source] [nvarchar](10) NULL,
	[Target] [nvarchar](32) NULL,
	[Method] [nvarchar](10) NULL,
	[TransactionGroupId] [nvarchar](36) NULL,
	[TransactionId] [int] NULL,
	[TransactionName] [nvarchar](32) NULL,
	[MessageDetail_Id] [int] NULL,
	[OrderNumber] [bigint] NULL,
	[OrderType] [nvarchar](6) NULL,
	[Company] [nvarchar](10) NULL,
	[BranchPlant] [int] NULL,
	[Customer] [int] NULL,
	[CustomerHoldCode] [nvarchar](32) NULL,
	[ShipTo] [int] NULL,
	[Miscellaneous] [nvarchar](256) NULL,
	[CreationDate] [datetime] NULL,
	[UserCreatedDocument] [nvarchar](256) NULL,
	[Rig] [nvarchar](256) NULL,
	[SequenceCreationDate] [datetime] NULL,
	[SequenceNumber] [int] NULL,
	[RevenueBusinessUnit] [int] NULL,
	[LandorOffshore] [nvarchar](6) NULL,
	[DeliveryTicketComplianceHold] [nvarchar](32) NULL,
	[DateShipConfirmed] [datetime] NULL,
	[JobNumber] [nvarchar](100) NULL,
	[JobType] [nvarchar](6) NULL,
	[ContractAccount] [nvarchar](32) NULL,
	[SalesMans1] [int] NULL,
	[SalesMans2] [int] NULL,
	[SalesMans3] [int] NULL,
	[BillDate] [datetime] NULL,
	[SerialNumber] [nvarchar](32) NULL,
	[SerialNoDesc1] [nvarchar](256) NULL,
	[SerialNoDesc2] [nvarchar](256) NULL,
	[SerialNoDesc3] [nvarchar](256) NULL,
	[LongItemNumber] [int] NULL,
	[AssetNumber] [int] NULL,
	[AssetStatus] [nvarchar](32) NULL,
	[QuantityShipped] [decimal](18, 9) NULL,
	[LotNumber] [nvarchar](32) NULL,
	[LineNumber] [int] NULL,
	[Location] [nvarchar](32) NULL,
	[Description1] [nvarchar](256) NULL,
	[Description2] [nvarchar](256) NULL,
	[Weight] [float] NULL,
	[BillType] [nvarchar](6) NULL,
	[LineType] [nvarchar](6) NULL,
	[LineTypeDesc] [nvarchar](256) NULL,
	[CustomsReplacementValue] [decimal](18, 9) NULL,
	[CountryofOrigin] [nvarchar](32) NULL,
	[AmountExtendedPrice] [decimal](27, 9) NULL,
	[ForeignExtendedPrice] [decimal](27, 9) NULL,
	[ReasonCode] [nvarchar](32) NULL,
	[ReturnDate] [datetime] NULL,
	[ReturnBy] [nvarchar](50) NULL,
	[ReturnSequence] [int] NULL,
	[ReturnQuantity] [decimal](18, 9) NULL,
	[SoldQuantity] [decimal](18, 9) NULL,
	[DateofTransaction] [datetime] NULL,
	[TimeofTransaction] [int] NULL,
	[TransactionCurrency] [nvarchar](6) NULL,
	[BaseCurrency] [nvarchar](6) NULL,
	[InvoiceNumber] [int] NULL,
	[InvoiceType] [nvarchar](6) NULL,
	[InvoiceCompany] [nvarchar](32) NULL,
	[InvoiceSequence] [int] NULL,
	[OriginalLine] [nvarchar](32) NULL,
	[WellDetails1] [nvarchar](255) NULL,
	[WellDetails3] [nvarchar](255) NULL,
	[WellName] [nvarchar](64) NULL,
	[LNID] [int] NULL,
	[SOADTPipelineMessageProcessingID] [bigint] NULL,
	[ProductDivision] [nvarchar](6) NULL,
	[JobChargeId] [uniqueidentifier] NULL,
	[IsValidated] [bit] NULL,
	[IsValid] [bit] NULL,
	[DateInserted] [datetime] NULL,
 CONSTRAINT [PK_TMPSOADTPipelineMessages] PRIMARY KEY CLUSTERED 
(
	[SOADTPipelineMessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpUpdateWPTS]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpUpdateWPTS](
	[jobid] [uniqueidentifier] NOT NULL,
	[JobNumber] [nvarchar](152) NULL,
	[jobStartDate] [nvarchar](25) NULL,
	[JobEndDate] [nvarchar](25) NULL,
	[Customer] [nvarchar](100) NULL,
	[wellNameAndLocation] [nvarchar](503) NOT NULL,
	[DrillingContractor] [varchar](3) NOT NULL,
	[Rig] [nvarchar](200) NULL,
	[ProductLine] [varchar](2) NOT NULL,
	[WellClassification] [varchar](2) NOT NULL,
	[WellLocation] [varchar](4) NOT NULL,
	[WellDepth] [float] NULL,
	[RigType] [nvarchar](10) NULL,
	[H2SPresent] [varchar](5) NOT NULL,
	[CO2Present] [varchar](5) NOT NULL,
	[personnelrating] [varchar](5) NULL,
	[equipmentrating] [varchar](5) NULL,
	[communicationrating] [varchar](5) NULL,
	[hsserating] [varchar](5) NULL,
	[overallrating] [varchar](5) NULL,
	[companycomments] [ntext] NULL,
	[declinedsurvey] [varchar](5) NOT NULL,
	[url] [varchar](90) NULL,
	[operatingDistrictID] [int] NULL,
	[JobTypeID] [int] NOT NULL,
	[topsDistrictID] [int] NULL,
	[operating_time] [numeric](38, 6) NULL,
	[lost_time] [float] NULL,
	[total_time] [numeric](38, 6) NULL,
	[wptsid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpWPTS_JobPostings]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpWPTS_JobPostings](
	[jobID] [uniqueidentifier] NOT NULL,
	[wptsID] [int] NULL,
	[wptsPosted] [datetime] NULL,
	[maxLastUpdated] [varbinary](8) NULL,
	[error] [nvarchar](max) NULL,
	[wptsXML] [nvarchar](4000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[toolclass]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[toolclass](
	[id] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[locationname] [varchar](100) NOT NULL,
	[abbreviation] [varchar](10) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[toolcodetype]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[toolcodetype](
	[id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](100) NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL,
 CONSTRAINT [PK_toolcodetype] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[toolpanelcodeversion]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[toolpanelcodeversion](
	[id] [int] NOT NULL,
	[toolpaneltypeid] [nvarchar](20) NOT NULL,
	[toolcodetypeid] [nvarchar](20) NOT NULL,
	[version] [nvarchar](20) NULL,
	[description] [ntext] NULL,
	[shortdescription] [ntext] NULL,
	[toolclassid] [int] NULL,
	[categorization] [int] NULL,
	[lastmodifiedat] [datetime] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NOT NULL,
	[jdeType] [int] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_toolpanelcodeversion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[toolpaneltype]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[toolpaneltype](
	[id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](100) NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_toolpaneltype] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Toolstatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Toolstatus](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[lastmodifiedat] [nvarchar](max) NOT NULL,
	[lastmodifiedby] [ntext] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tops_so_ov_guids]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tops_so_ov_guids](
	[serviceorderid] [varchar](50) NULL,
	[guid] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TopsFailure]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopsFailure](
	[logeventfailureid] [int] NOT NULL,
	[wftid] [nvarchar](30) NULL,
	[serviceorder] [nvarchar](200) NULL,
	[closedat] [datetime] NULL,
	[eventtime] [datetime] NULL,
	[max_severity] [int] NULL,
	[assignedstationid] [int] NULL,
	[assignedbusinessunitid] [int] NULL,
	[timesetbyclient] [datetime] NULL,
	[createdat] [datetime] NULL,
	[description] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSLATE_FECellRole_EmpFunction]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSLATE_FECellRole_EmpFunction](
	[OneView_FECellRoleID] [int] NULL,
	[TOPS_EmployeeFunctionID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSLATE_JobStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSLATE_JobStatus](
	[OneView_JobStatusID] [tinyint] NULL,
	[TOPS_JobStatusID] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSLATE_JobType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSLATE_JobType](
	[OneView_JobTypeID] [int] NULL,
	[TOPS_JobTypeID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSLATE_OperationType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSLATE_OperationType](
	[OneView_OperationTypeID] [tinyint] NOT NULL,
	[TOPS_OperationTypeID] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSLATE_RigType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSLATE_RigType](
	[OneView_RigTypeID] [tinyint] NOT NULL,
	[TOPS_RigTypeID] [tinyint] NOT NULL,
	[WPTS_RigTypeID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSLATE_TOPSDistrict]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSLATE_TOPSDistrict](
	[topsDistrictID] [int] NOT NULL,
	[preference] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSLATE_unit_preference]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSLATE_unit_preference](
	[toolpaneltype] [nvarchar](20) NOT NULL,
	[preference] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSLATE_WellLocationType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSLATE_WellLocationType](
	[OneView_WellLocationTypeID] [tinyint] NOT NULL,
	[TOPS_WellLocationTypeID] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[unitID] [int] IDENTITY(1,1) NOT NULL,
	[equipmentID] [int] NOT NULL,
	[vin] [nvarchar](200) NULL,
	[make] [nvarchar](50) NULL,
	[unitStatusID] [int] NULL,
	[branchPlantLocationID] [int] NULL,
	[businessUnitLocationID] [int] NULL,
	[unitTypeID] [int] NULL,
	[unitYear] [int] NULL,
	[phone1] [nvarchar](50) NULL,
	[phone2] [nvarchar](50) NULL,
	[phone3] [nvarchar](50) NULL,
	[phone4] [nvarchar](50) NULL,
	[ipAddress] [nvarchar](200) NULL,
	[comment] [nvarchar](4000) NULL,
	[statusComment] [nvarchar](4000) NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[unitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitBuildInformation]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitBuildInformation](
	[unitID] [int] NOT NULL,
	[expansion] [int] NULL,
	[builderID] [int] NULL,
	[scheduledYear] [int] NULL,
	[scheduledWeek] [int] NULL,
	[expectedYear] [int] NULL,
	[expectedWeek] [int] NULL,
	[chassisEquipmentTPCVID] [int] NULL,
	[chassisVendorID] [int] NULL,
	[vanEquipmentTPCVID] [int] NULL,
	[unitRackTypeID] [int] NULL,
	[skidEquipmentTPCVID] [int] NULL,
	[drum1EquipmentTPCVID] [int] NULL,
	[drum2EquipmentTPCVID] [int] NULL,
	[drum1Wireline1EquipmentTPCVID] [int] NULL,
	[drum1Wireline2EquipmentTPCVID] [int] NULL,
	[drum2Wireline1EquipmentTPCVID] [int] NULL,
	[drum2Wireline2EquipmentTPCVID] [int] NULL,
	[drum1Wireline1MarkingMeasuremenTypeDetailID] [int] NULL,
	[drum1Wireline2MarkingMeasuremenTypeDetailID] [int] NULL,
	[drum2Wireline1MarkingMeasuremenTypeDetailID] [int] NULL,
	[drum2Wireline2MarkingMeasuremenTypeDetailID] [int] NULL,
	[generatorEquipmentTPCVID] [int] NULL,
	[system1EquipmentTPCVID] [int] NULL,
	[system2EquipmentTPCVID] [int] NULL,
	[measureHeadEquipmentTPCVID] [int] NULL,
	[powerConverterEquipmentTPCVID] [int] NULL,
	[shootingPanelEquipmentTPCVID] [int] NULL,
	[destinationCountry] [int] NULL,
	[chassisWBSElement] [nvarchar](100) NULL,
	[vanWBSElement] [nvarchar](100) NULL,
	[generatorWBSElement] [nvarchar](100) NULL,
	[measureHeadWBSElement] [nvarchar](100) NULL,
	[systemWBSElement] [nvarchar](100) NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[comments] [nvarchar](4000) NULL,
 CONSTRAINT [PK_UnitBuildInformation] PRIMARY KEY CLUSTERED 
(
	[unitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitHistory]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitHistory](
	[unitHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[unitID] [int] NOT NULL,
	[unitColumn] [nvarchar](100) NOT NULL,
	[history] [nvarchar](4000) NULL,
	[deleted] [bit] NOT NULL,
	[dateOfChange] [datetime] NULL,
	[changedBy] [int] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_UnitHistory] PRIMARY KEY CLUSTERED 
(
	[unitHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitLicense]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitLicense](
	[unitLicenseID] [int] IDENTITY(1,1) NOT NULL,
	[unitID] [int] NOT NULL,
	[licenseNumber] [int] NULL,
	[licensingLocationID] [int] NOT NULL,
	[license] [nvarchar](50) NOT NULL,
	[expiration] [datetime] NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_UnitLicense] PRIMARY KEY CLUSTERED 
(
	[unitLicenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitRackType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitRackType](
	[unitRackTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_UnitRackType] PRIMARY KEY CLUSTERED 
(
	[unitRackTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[units]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[units](
	[id] [int] NOT NULL,
	[vin] [nvarchar](20) NULL,
	[make] [nvarchar](100) NULL,
	[phone1] [nvarchar](40) NULL,
	[phone2] [nvarchar](40) NULL,
	[unitstatusid] [int] NULL,
	[stationid] [int] NULL,
	[unittypeid] [int] NULL,
	[year] [int] NULL,
	[unitdivisionid] [int] NULL,
	[phone3] [nvarchar](40) NULL,
	[history] [ntext] NULL,
	[statuscomment] [ntext] NULL,
	[sapno] [int] NULL,
	[ipaddress] [nvarchar](50) NULL,
	[phone4] [nvarchar](40) NULL,
	[crossovernum] [nvarchar](15) NULL,
	[driverfirstname] [nvarchar](100) NULL,
	[driverlastname] [nvarchar](100) NULL,
	[drivetype] [nvarchar](20) NULL,
	[gvw] [nvarchar](20) NULL,
	[fueltype] [nvarchar](5) NULL,
	[dot] [bit] NULL,
	[dotcompleted] [datetime] NULL,
	[ifta1] [bit] NULL,
	[modelname] [nvarchar](30) NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
	[GWIS_AssetID] [int] NULL,
	[toolid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitStatus](
	[unitStatusID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_UnitStatus] PRIMARY KEY CLUSTERED 
(
	[unitStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitType](
	[unitTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_UnitType] PRIMARY KEY CLUSTERED 
(
	[unitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitWireline]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitWireline](
	[unitWirelineID] [int] IDENTITY(1,1) NOT NULL,
	[unitID] [int] NOT NULL,
	[wirelineEquipmentID] [int] NOT NULL,
	[reportDate] [datetime] NOT NULL,
	[newInstall] [bit] NOT NULL,
	[installDate] [datetime] NULL,
	[length] [decimal](18, 9) NOT NULL,
	[lineCaliperAtCH] [decimal](18, 9) NULL,
	[lineCaliperAt200m] [decimal](18, 9) NULL,
	[ohms] [decimal](18, 9) NULL,
	[splicesAndStrands] [int] NULL,
	[lastTightenedDate] [datetime] NULL,
	[lineDiameter] [decimal](18, 9) NULL,
	[runsTotal] [int] NULL,
	[runsSinceTightened] [int] NULL,
	[comments] [nvarchar](4000) NULL,
	[modifiedBy] [int] NOT NULL,
	[inserted] [binary](8) NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_UnitWireline] PRIMARY KEY CLUSTERED 
(
	[unitWirelineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UOM]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UOM](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](300) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_UOM] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFilters]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFilters](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WftId] [nvarchar](60) NULL,
	[Module] [nvarchar](100) NULL,
	[Name] [nvarchar](200) NULL,
	[Filter] [ntext] NULL,
 CONSTRAINT [PK_UserFilter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPreferences]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPreferences](
	[userPreferencesID] [uniqueidentifier] NOT NULL,
	[wftid] [nvarchar](50) NOT NULL,
	[userPreferenceTypeID] [int] NOT NULL,
	[preferenceValue] [varbinary](8000) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserPreferences] PRIMARY KEY NONCLUSTERED 
(
	[userPreferencesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPreferenceStorage]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPreferenceStorage](
	[wftid] [nvarchar](50) NOT NULL,
	[userPreferences] [ntext] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserPreferenceStorage] PRIMARY KEY CLUSTERED 
(
	[wftid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPreferenceTypes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPreferenceTypes](
	[userPreferenceTypeID] [int] IDENTITY(1,1) NOT NULL,
	[preferenceType] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserPreferenceTypes] PRIMARY KEY CLUSTERED 
(
	[userPreferenceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[employeeid] [int] NOT NULL,
	[isDeveloper] [smallint] NULL,
	[deleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleMapping]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleMapping](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[RoleId] [smallint] NOT NULL,
	[modifiedBy] [nvarchar](30) NULL,
	[modifiedAt] [datetime] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleMapping_bkp_30082022]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleMapping_bkp_30082022](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[RoleId] [smallint] NOT NULL,
	[modifiedBy] [nvarchar](30) NULL,
	[modifiedAt] [datetime] NULL,
	[Deleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserWebPreferenceStorage]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserWebPreferenceStorage](
	[wftid] [nvarchar](50) NOT NULL,
	[userPreferences] [ntext] NOT NULL,
 CONSTRAINT [PK_UserWebPreferenceStorage] PRIMARY KEY CLUSTERED 
(
	[wftid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Well]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Well](
	[id] [int] NULL,
	[name] [nvarchar](300) NOT NULL,
	[licence] [nvarchar](200) NULL,
	[fieldname] [nvarchar](100) NULL,
	[location] [nvarchar](200) NOT NULL,
	[uwi] [nvarchar](200) NULL,
	[countryid] [int] NULL,
	[provinceid] [int] NULL,
	[complete] [bit] NOT NULL,
	[latitude] [numeric](18, 9) NULL,
	[longitude] [numeric](18, 9) NULL,
	[customerid] [int] NULL,
	[county_parishid] [int] NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[updateId] [uniqueidentifier] NOT NULL,
	[insertId] [uniqueidentifier] NOT NULL,
	[wellID] [uniqueidentifier] NOT NULL,
	[api] [nvarchar](50) NULL,
	[oneViewCompanyID] [uniqueidentifier] NULL,
	[modified] [datetime] NULL,
	[geographicCountryID] [int] NULL,
	[geographicCountyID] [int] NULL,
	[geographicProvinceID] [int] NULL,
	[deleted] [bit] NULL,
	[jdeWellID] [numeric](8, 0) NULL,
	[city] [nvarchar](100) NULL,
 CONSTRAINT [PK_Well] PRIMARY KEY NONCLUSTERED 
(
	[wellID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WellLocationType]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WellLocationType](
	[wellLocationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[locationType] [nvarchar](50) NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_WellLocation] PRIMARY KEY CLUSTERED 
(
	[wellLocationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WellProfileTypes]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WellProfileTypes](
	[wellProfileTypeID] [int] IDENTITY(1,1) NOT NULL,
	[profileType] [nvarchar](50) NOT NULL,
	[isCasedHole] [bit] NOT NULL,
	[isOpenHole] [bit] NOT NULL,
	[isSlimLine] [bit] NOT NULL,
	[inserted] [binary](8) NOT NULL,
	[updated] [timestamp] NULL,
 CONSTRAINT [PK_WellProfileTypes] PRIMARY KEY CLUSTERED 
(
	[wellProfileTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wpts_areas]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wpts_areas](
	[id] [int] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[wpts_countryid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wpts_countries]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wpts_countries](
	[id] [int] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[wpts_regionid] [int] NULL,
	[wpts_subregionid] [int] NULL,
	[lastmodifiedat] [datetime] NOT NULL,
	[lastmodifiedby] [nvarchar](4000) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wpts_countyparish]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wpts_countyparish](
	[id] [int] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[wpts_stateprovid] [int] NOT NULL,
	[lastmodifiedat] [datetime] NOT NULL,
	[lastmodifiedby] [nvarchar](4000) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WPTS_JobPostings]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WPTS_JobPostings](
	[jobID] [uniqueidentifier] NOT NULL,
	[wptsID] [int] NULL,
	[wptsPosted] [datetime] NULL,
	[maxLastUpdated] [binary](8) NULL,
	[error] [nvarchar](max) NULL,
	[wptsXML] [nvarchar](4000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WPTS_KPI_Hours]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WPTS_KPI_Hours](
	[JobID] [uniqueidentifier] NOT NULL,
	[lost_time] [float] NULL,
	[operating_time] [numeric](38, 6) NULL,
	[updated] [timestamp] NOT NULL,
	[total_time] [numeric](38, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wpts_Locations]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wpts_Locations](
	[id] [int] NOT NULL,
	[name] [nvarchar](4000) NOT NULL,
	[importid] [int] NULL,
	[companyname] [nvarchar](255) NULL,
	[propertyname] [nvarchar](255) NULL,
	[physicaladdr1] [nvarchar](255) NULL,
	[physicalcity] [nvarchar](255) NULL,
	[wpts_countryid] [int] NULL,
	[wpts_stateprovid] [int] NULL,
	[physicalzip] [nvarchar](50) NULL,
	[wpts_regionid] [int] NULL,
	[wpts_subregionid] [int] NULL,
	[wpts_areaid] [int] NULL,
	[groupid] [int] NULL,
	[propertyid] [int] NULL,
	[excludefromsearch] [varchar](5) NULL,
	[excludefromjobs] [varchar](5) NULL,
	[active] [varchar](5) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wpts_regions]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wpts_regions](
	[id] [int] NOT NULL,
	[name] [nvarchar](200) NULL,
	[lastupdatedby] [nvarchar](4000) NOT NULL,
	[lastupdatedat] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wpts_stateprov]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wpts_stateprov](
	[id] [int] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[wpts_countryid] [int] NOT NULL,
	[lastmodifiedat] [datetime] NOT NULL,
	[lastmodifiedby] [nvarchar](4000) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wpts_subregions]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wpts_subregions](
	[id] [int] NOT NULL,
	[wpts_regionid] [int] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[lastmodifiedat] [datetime] NOT NULL,
	[lastmodifiedby] [nvarchar](4000) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AcquisitionSoftware] ADD  CONSTRAINT [DF_AcquisitionSoftware_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[AcquisitionSystem] ADD  CONSTRAINT [DF_AcquisitionSystem_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[AcquisitionType] ADD  CONSTRAINT [DF_AcquisitionType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_primary]  DEFAULT ((0)) FOR [primary]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_addressID]  DEFAULT (newid()) FOR [oneViewAddressID]
GO
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_isWireline]  DEFAULT ((0)) FOR [isWireline]
GO
ALTER TABLE [dbo].[ApproxTimeSelectionValues] ADD  CONSTRAINT [DF_ApproxTimeSelectionValues_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Area] ADD  CONSTRAINT [DF_Area_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[assets] ADD  CONSTRAINT [DF_assets_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[assets] ADD  CONSTRAINT [DF_assets_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[assets] ADD  CONSTRAINT [DF_assets_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[AssetServiceGroupExceptions] ADD  CONSTRAINT [DF_AssetServiceGroupExceptions_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BallisticDetonator] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BallisticDetonator] ADD  CONSTRAINT [DF_BallisticDetonator_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BallisticGunSize] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BallisticGunType] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BallisticIgniter] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BallisticInitiatorType] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BallisticManufacturer] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BallisticPhasing] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BallisticPhasing] ADD  CONSTRAINT [DF_BallisticPhasing_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BallisticSPF] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BallisticSPF] ADD  CONSTRAINT [DF_BallisticSPF_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BallisticTypeOfCharge] ADD  DEFAULT ((0)) FOR [orderofdisplay]
GO
ALTER TABLE [dbo].[BitSizes] ADD  CONSTRAINT [DF_BitSizesNew_bitSizeID]  DEFAULT (newid()) FOR [bitSizeID]
GO
ALTER TABLE [dbo].[BitSizes] ADD  CONSTRAINT [DF_BitSizes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BitSizes] ADD  CONSTRAINT [DF_BitSizes_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[BitSizes] ADD  CONSTRAINT [DF_BitSizes_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[BitSizes2] ADD  CONSTRAINT [DF_BitSizesNew_bitSizeID2]  DEFAULT (newid()) FOR [bitSizeID]
GO
ALTER TABLE [dbo].[BitSizes2] ADD  CONSTRAINT [DF_BitSizes_inserted2]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BitSizes2] ADD  CONSTRAINT [DF_BitSizes_updateId2]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[BitSizes2] ADD  CONSTRAINT [DF_BitSizes_insertId2]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[BriefDebriefCategories] ADD  CONSTRAINT [DF_BriefDebriefCategories_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefCategoriesLocalized] ADD  CONSTRAINT [DF_BriefDebriefCategoriesLocalized_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefFields] ADD  CONSTRAINT [DF_BriefDebriefFields_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[BriefDebriefFields] ADD  CONSTRAINT [DF_BriefDebriefFields_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefHeaders] ADD  CONSTRAINT [DF_BriefDebriefHeaders_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionGroup] ADD  CONSTRAINT [DF_BriefDebriefFieldGroup_Deleted]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[BriefDebriefQuestions] ADD  CONSTRAINT [DF_BriefDebriefQuestions_IsBrief]  DEFAULT ((0)) FOR [IsBrief]
GO
ALTER TABLE [dbo].[BriefDebriefQuestions] ADD  CONSTRAINT [DF_BriefDebriefQuestions_IsDebrief]  DEFAULT ((0)) FOR [IsDebrief]
GO
ALTER TABLE [dbo].[BriefDebriefQuestions] ADD  CONSTRAINT [DF_BriefDebriefQuestions_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[BriefDebriefQuestions] ADD  CONSTRAINT [DF_BriefDebriefQuestions_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers] ADD  CONSTRAINT [DF_BriefDebriefQuestionsAnswers_IdTemp]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers] ADD  CONSTRAINT [DF_BriefDebriefQuestionsAnswers_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers] ADD  CONSTRAINT [DF_BriefDebriefQuestionsAnswers_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers] ADD  CONSTRAINT [DF_BriefDebriefQuestionsAnswers_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswersLog] ADD  CONSTRAINT [DF_BriefDebriefQuestionsAnswersLog_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswersLog] ADD  CONSTRAINT [DF_BriefDebriefQuestionsAnswersLog_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswersLog] ADD  CONSTRAINT [DF_BriefDebriefQuestionsAnswersLog_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswersLog] ADD  CONSTRAINT [DF_BriefDebriefQuestionsAnswersLog_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsLocalized] ADD  CONSTRAINT [DF_BriefDebriefQuestionsLocalized_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsTypeValues] ADD  CONSTRAINT [DF_BriefDebriefQuestionsTypeValues_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionTemplates] ADD  CONSTRAINT [DF_BriefDebriefQuestionTemplates_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionTypes] ADD  CONSTRAINT [DF_BriefDebriefQuestionTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefTemplate] ADD  CONSTRAINT [DF_BriefDebriefTemplate_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefTemplateHeader] ADD  CONSTRAINT [DF_BriefDebriefTemplateHeader_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[BriefDebriefTemplateHeaderLocalized] ADD  CONSTRAINT [DF_BriefDebriefTemplateHeaderLocalized_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CasedHoleMechanicalTypes] ADD  CONSTRAINT [DF_CasedHoleMechanicalTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CasingDimensions] ADD  CONSTRAINT [DF_CasingDimensions_casingDimensionID]  DEFAULT (newid()) FOR [casingDimensionID]
GO
ALTER TABLE [dbo].[CasingDimensions] ADD  CONSTRAINT [DF_SurfaceCasingType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CasingDimensions] ADD  CONSTRAINT [DF_CasingDimensions_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[CasingDimensions] ADD  CONSTRAINT [DF_CasingDimensions_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[CasingType] ADD  CONSTRAINT [DF_CasingType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Cell] ADD  CONSTRAINT [DF_Cell_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CellEmployees] ADD  CONSTRAINT [DF_CellEmployees_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CellLog] ADD  CONSTRAINT [DF_CellLog_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CellServiceSet] ADD  CONSTRAINT [DF_CellServiceSet_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CellServiceSet] ADD  CONSTRAINT [DF_CellServiceSet_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[CellServiceSet] ADD  CONSTRAINT [DF_CellServiceSet_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[CellServiceSetService] ADD  CONSTRAINT [DF_CellServiceSetService_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CellServiceSetService] ADD  CONSTRAINT [DF_CellServiceSetService_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[CellServiceSetService] ADD  CONSTRAINT [DF_CellServiceSetService_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_Modified]  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_oneViewCompanyID]  DEFAULT (newid()) FOR [oneViewCompanyID]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_isWireline]  DEFAULT ((0)) FOR [isWireline]
GO
ALTER TABLE [dbo].[CompanyAddress] ADD  CONSTRAINT [DF_CompanyAddress_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CompanyAddress] ADD  CONSTRAINT [DF_CompanyAddress_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[CompanyAddress] ADD  CONSTRAINT [DF_CompanyAddress_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[CompanyAddress] ADD  CONSTRAINT [DF_CompanyAddress_companyAddressID]  DEFAULT (newid()) FOR [companyAddressID]
GO
ALTER TABLE [dbo].[CompanyEDIFields] ADD  CONSTRAINT [DF_CompanyEDIFields_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CompanyGeneralInstructions] ADD  CONSTRAINT [DF_Table_1_customerInstructionID]  DEFAULT (newid()) FOR [companyGeneralInstructionID]
GO
ALTER TABLE [dbo].[CompanyGeneralInstructions] ADD  CONSTRAINT [DF_CompanyGeneralInstructions_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CompanyGeneralInstructions] ADD  CONSTRAINT [DF_CompanyGeneralInstructions_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[CompanyGeneralInstructions] ADD  CONSTRAINT [DF_CompanyGeneralInstructions_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[CompanyPricebook] ADD  CONSTRAINT [DF_CompanyPricebook_CustomerPricebookId]  DEFAULT (newid()) FOR [CompanyPricebookId]
GO
ALTER TABLE [dbo].[CompanyPricebook] ADD  CONSTRAINT [DF_CompanyPricebook_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CompanyRegion] ADD  CONSTRAINT [DF_CompanyRegion_Modified]  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[CompanyRegion] ADD  CONSTRAINT [DF_CompanyRegion_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CompanyRegion] ADD  CONSTRAINT [DF_CompanyRegion_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[CompanyRegion] ADD  CONSTRAINT [DF_CompanyRegion_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[CompanyRegion] ADD  CONSTRAINT [DF_CompanyRegion_oneViewCompanyRegionID]  DEFAULT (newid()) FOR [oneViewCompanyRegionID]
GO
ALTER TABLE [dbo].[CompanyStatus] ADD  CONSTRAINT [DF_CompanyStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ContactInfo] ADD  CONSTRAINT [DF_ContactInfo_contactInfoID]  DEFAULT (newid()) FOR [contactInfoID]
GO
ALTER TABLE [dbo].[ContactInfo] ADD  CONSTRAINT [DF_ContactInfo_contactData]  DEFAULT (newid()) FOR [contactData]
GO
ALTER TABLE [dbo].[ContactInfo] ADD  CONSTRAINT [DF_ContactInfo_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ContactInfo] ADD  CONSTRAINT [DF_ContactInfo_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[ContactInfo] ADD  CONSTRAINT [DF_ContactInfo_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[ContactSubTypes] ADD  CONSTRAINT [DF_ContactSubTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ContactSubTypes] ADD  CONSTRAINT [DF_ContactSubTypes_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[ContactSubTypes] ADD  CONSTRAINT [DF_ContactSubTypes_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[ContactTypes] ADD  CONSTRAINT [DF_ContactTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ContactTypes] ADD  CONSTRAINT [DF_ContactTypes_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[ContactTypes] ADD  CONSTRAINT [DF_ContactTypes_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[ContactTypesContactSubTypes] ADD  CONSTRAINT [DF_ContactTypesContactSubTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ContactTypesContactSubTypes] ADD  CONSTRAINT [DF_ContactTypesContactSubTypes_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[ContactTypesContactSubTypes] ADD  CONSTRAINT [DF_ContactTypesContactSubTypes_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[ConveyanceSubType] ADD  CONSTRAINT [DF_ConveyanceSubType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ConveyanceType] ADD  CONSTRAINT [DF_ConveyanceType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[county_parish] ADD  CONSTRAINT [DF_county_parish_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Currency] ADD  CONSTRAINT [DF_Currency_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[CurrencyRate] ADD  CONSTRAINT [DF_CurrencyRate_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[DeliveryTickets] ADD  CONSTRAINT [DF_DeliveryTickets_DeliveryTicketID]  DEFAULT (newid()) FOR [DeliveryTicketID]
GO
ALTER TABLE [dbo].[DeliveryTicketSOALog] ADD  CONSTRAINT [DF_GWIS_DeliveryTicketSOALog_soaDTMessageID]  DEFAULT (newid()) FOR [deliveryTicketSOALogID]
GO
ALTER TABLE [dbo].[DeliveryTicketSOALog] ADD  CONSTRAINT [DF_DeliveryTicketSOALog_DeliveryTicketSOALogTypeID]  DEFAULT ((1)) FOR [DeliveryTicketSOALogTypeID]
GO
ALTER TABLE [dbo].[DeliveryTicketSOALog] ADD  CONSTRAINT [DF_DeliveryTicketSOALog_logDate]  DEFAULT (getutcdate()) FOR [logDate]
GO
ALTER TABLE [dbo].[District] ADD  CONSTRAINT [DF_District_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[DrillingFluidType] ADD  CONSTRAINT [DF_DrillingFluidType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EconnectEmployeeData] ADD  CONSTRAINT [DF_EconnectEmployeeData_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EconnectEmployeeData] ADD  CONSTRAINT [DF_EconnectEmployeeData_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EconnectEmployeeData] ADD  CONSTRAINT [DF_EconnectEmployeeData_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_modified]  DEFAULT (getdate()) FOR [modified]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EmployeeGroups] ADD  CONSTRAINT [DF_EmployeeGroups_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Equipment] ADD  CONSTRAINT [DF_Equipment_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Equipment] ADD  CONSTRAINT [DF_Equipment_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[Equipment] ADD  CONSTRAINT [DF_Equipment_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] ADD  CONSTRAINT [DF_EquipmentAddtionalInformation_EquipmentOwnershipID]  DEFAULT ((-1)) FOR [equipmentOwnershipID]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] ADD  CONSTRAINT [DF_EquipmentAdditionalInformation_dateAcquired]  DEFAULT (getdate()) FOR [dateAcquired]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] ADD  CONSTRAINT [DF_EquipmentAdditionalInformation_depreciationStartDate]  DEFAULT (getdate()) FOR [depreciationStartDate]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] ADD  CONSTRAINT [DF_EquipmentAdditionalInformation_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] ADD  CONSTRAINT [DF_EquipmentAdditionalInformation_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] ADD  CONSTRAINT [DF_EquipmentAdditionalInformation_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentCategorization] ADD  CONSTRAINT [DF_EquipmentCategorization_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentCategorization] ADD  CONSTRAINT [DF_EquipmentCategorization_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentCategorization] ADD  CONSTRAINT [DF_EquipmentCategorization_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentClass] ADD  CONSTRAINT [DF_EquipmentClass_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentClass] ADD  CONSTRAINT [DF_EquipmentClass_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentClass] ADD  CONSTRAINT [DF_EquipmentClass_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentDivision] ADD  CONSTRAINT [DF_EquipmentDivision_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentDivision] ADD  CONSTRAINT [DF_EquipmentDivision_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentDivision] ADD  CONSTRAINT [DF_EquipmentDivision_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentHistory] ADD  CONSTRAINT [DF_EquipmentHistory_dateOfChange]  DEFAULT (getutcdate()) FOR [dateOfChange]
GO
ALTER TABLE [dbo].[EquipmentHistory] ADD  CONSTRAINT [DF_EquipmentHistory_changedBy]  DEFAULT ((-1)) FOR [changedBy]
GO
ALTER TABLE [dbo].[EquipmentModificationInformation] ADD  CONSTRAINT [DF_Table_1_activeMod]  DEFAULT ((1)) FOR [activeModification]
GO
ALTER TABLE [dbo].[EquipmentModificationInformation] ADD  CONSTRAINT [DF_EquipmentModificationInformation_requiredModificationTypeID]  DEFAULT ((0)) FOR [requiredModificationTypeID]
GO
ALTER TABLE [dbo].[EquipmentModificationInformation] ADD  CONSTRAINT [DF_EquipmentModificationInformation_assumedDone]  DEFAULT ((0)) FOR [assumedDone]
GO
ALTER TABLE [dbo].[EquipmentModificationInformation] ADD  CONSTRAINT [DF_EquipmentModificationInformation_versionChange]  DEFAULT ((0)) FOR [versionChange]
GO
ALTER TABLE [dbo].[EquipmentModificationInformation] ADD  CONSTRAINT [DF_EquipmentModificationInformation_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentModificationInformationHistory] ADD  CONSTRAINT [DF_EquipmentModificationInformationHistory_creationDate]  DEFAULT (getutcdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[EquipmentOwnership] ADD  CONSTRAINT [DF_EquipmentOwnership_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentOwnership] ADD  CONSTRAINT [DF_EquipmentOwnership_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentOwnership] ADD  CONSTRAINT [DF_EquipmentOwnership_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenance] ADD  CONSTRAINT [DF_EquipmentPendingMaintenance_isCertification]  DEFAULT ((0)) FOR [isCertification]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceRule] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceRule_maxDays]  DEFAULT ((0)) FOR [maxDays]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceRule] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceRule_maxRuns]  DEFAULT ((0)) FOR [maxRuns]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceRule] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceRule_ruleDate]  DEFAULT (getutcdate()) FOR [ruleDate]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceRule] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceRule_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceRule] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceRule_obsolete]  DEFAULT ((0)) FOR [obsolete]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceType] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceType_emailNotification]  DEFAULT ((0)) FOR [emailNotification]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceType] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceType_repairRequest]  DEFAULT ((0)) FOR [repairRequest]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceType] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceType_daySetting]  DEFAULT ((1)) FOR [daySetting]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceType] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceType_runSetting]  DEFAULT ((0)) FOR [runSetting]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceType] ADD  CONSTRAINT [DF_EquipmentPendingMaintenanceType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentProduct] ADD  CONSTRAINT [DF_EquipmentProduct_EquipmentProductGroupID]  DEFAULT ((-1)) FOR [equipmentProductGroupID]
GO
ALTER TABLE [dbo].[EquipmentProduct] ADD  CONSTRAINT [DF_EquipmentProduct_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentProduct] ADD  CONSTRAINT [DF_EquipmentProduct_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentProduct] ADD  CONSTRAINT [DF_EquipmentProduct_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentProductGroup] ADD  CONSTRAINT [DF_EquipmentProductGroup_xmlFileName]  DEFAULT (N'Not Set') FOR [xmlFileName]
GO
ALTER TABLE [dbo].[EquipmentProductGroup] ADD  CONSTRAINT [DF_EquipmentProductGroup_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentProductGroup] ADD  CONSTRAINT [DF_EquipmentProductGroup_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentProductGroup] ADD  CONSTRAINT [DF_EquipmentProductGroup_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentStatus] ADD  CONSTRAINT [DF_EquipmentStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentStatus] ADD  CONSTRAINT [DF_EquipmentStatus_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentStatus] ADD  CONSTRAINT [DF_EquipmentStatus_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_EquipmentDivisionID]  DEFAULT ((-1)) FOR [equipmentDivisionID]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_EquipmentCategorizationID]  DEFAULT ((-1)) FOR [equipmentCategorizationID]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_EquipmentToolPanelCodeVersionStatusID]  DEFAULT ((-1)) FOR [equipmentToolPanelCodeVersionStatusID]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_EquipmentProductID]  DEFAULT ((-1)) FOR [equipmentProductID]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_EquipmentClassID]  DEFAULT ((-1)) FOR [equipmentClassID]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersion_useToolDescription]  DEFAULT ((0)) FOR [useToolDescription]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersionStatus] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersionStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersionStatus] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersionStatus_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersionStatus] ADD  CONSTRAINT [DF_EquipmentToolPanelCodeVersionStatus_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[ExchangeRate] ADD  CONSTRAINT [DF_ExchangeRate_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureClassification] ADD  CONSTRAINT [DF_FailureClassification_failureClassificationID]  DEFAULT (newid()) FOR [failureClassificationID]
GO
ALTER TABLE [dbo].[FailureClassification] ADD  CONSTRAINT [DF_FailureClassification_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureClassification] ADD  CONSTRAINT [DF_FailureClassification_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FailureClassification] ADD  CONSTRAINT [DF_FailureClassification_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FailureEventValue] ADD  CONSTRAINT [DF_FailureEventValue_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureEventValue] ADD  CONSTRAINT [DF_FailureEventValue_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FailureEventValue] ADD  CONSTRAINT [DF_FailureEventValue_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FailureLabel] ADD  CONSTRAINT [DF_FailureLabel_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureLossCategory] ADD  CONSTRAINT [DF_FailureLossCategory_failureLossCategoryID]  DEFAULT (newid()) FOR [failureLossCategoryID]
GO
ALTER TABLE [dbo].[FailureLossCategory] ADD  CONSTRAINT [DF_FailureLossCategory_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureLossCategory] ADD  CONSTRAINT [DF_FailureLossCategory_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FailureLossCategory] ADD  CONSTRAINT [DF_FailureLossCategory_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Failures] ADD  CONSTRAINT [DF_Failures_failureID]  DEFAULT (newid()) FOR [failureID]
GO
ALTER TABLE [dbo].[Failures] ADD  CONSTRAINT [DF_Failures_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Failures] ADD  CONSTRAINT [DF_Failures_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[Failures] ADD  CONSTRAINT [DF_Failures_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FailureText] ADD  CONSTRAINT [DF_FailureText_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureTool] ADD  CONSTRAINT [DF_FailureTool_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureTool] ADD  CONSTRAINT [DF_FailureTool_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FailureTool] ADD  CONSTRAINT [DF_FailureTool_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FailureToolV2] ADD  CONSTRAINT [DF_FailureToolV2_failureToolID]  DEFAULT (newid()) FOR [failureToolID]
GO
ALTER TABLE [dbo].[FailureToolV2] ADD  CONSTRAINT [DF_Table_1_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureToolV2] ADD  CONSTRAINT [DF_Table_1_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FailureToolV2] ADD  CONSTRAINT [DF_Table_1_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FailureTree] ADD  CONSTRAINT [DF_FailureTree_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureValue] ADD  CONSTRAINT [DF_FailureValue_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FailureValue] ADD  CONSTRAINT [DF_FailureValue_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FailureValue] ADD  CONSTRAINT [DF_FailureValue_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FECellAssets] ADD  CONSTRAINT [DF_FECellAssets_feCellAssetID]  DEFAULT (newid()) FOR [feCellAssetID]
GO
ALTER TABLE [dbo].[FECellAssets] ADD  CONSTRAINT [DF_FECellAssets_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FECellAssets] ADD  CONSTRAINT [DF_FECellAssets_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FECellAssets] ADD  CONSTRAINT [DF_FECellAssets_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FECellCompanies] ADD  CONSTRAINT [DF_FECellCompanies_feCellCompanyID]  DEFAULT (newid()) FOR [feCellCompanyID]
GO
ALTER TABLE [dbo].[FECellCompanies] ADD  CONSTRAINT [DF_FECellCompanies_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FECellCompanies] ADD  CONSTRAINT [DF_FECellCompanies_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FECellCompanies] ADD  CONSTRAINT [DF_FECellCompanies_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FECellCrew] ADD  CONSTRAINT [DF_FECellCrew_feCellCrewID]  DEFAULT (newid()) FOR [feCellCrewID]
GO
ALTER TABLE [dbo].[FECellCrew] ADD  CONSTRAINT [DF_FECellCrew_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FECellCrew] ADD  CONSTRAINT [DF_FECellCrew_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FECellCrew] ADD  CONSTRAINT [DF_FECellCrew_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FECellRole] ADD  CONSTRAINT [DF_FECellRole_feCellRoleTypeID]  DEFAULT ((3)) FOR [feCellRoleTypeID]
GO
ALTER TABLE [dbo].[FECellRole] ADD  CONSTRAINT [DF_FECellRole_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FECellRole] ADD  CONSTRAINT [DF_FECellRole_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FECellRole] ADD  CONSTRAINT [DF_FECellRole_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FECellRoleType] ADD  CONSTRAINT [DF_FECellRoleType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FECells] ADD  CONSTRAINT [DF_FECells_feCellID]  DEFAULT (newid()) FOR [feCellID]
GO
ALTER TABLE [dbo].[FECells] ADD  CONSTRAINT [DF_FECells_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FECells] ADD  CONSTRAINT [DF_FECells_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FECells] ADD  CONSTRAINT [DF_FECells_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FECellServiceSets] ADD  CONSTRAINT [DF_FECellServiceSets_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FECellServiceSets] ADD  CONSTRAINT [DF_FECellServiceSets_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FECellServiceSets] ADD  CONSTRAINT [DF_FECellServiceSets_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FECellServiceSetServices] ADD  CONSTRAINT [DF_FECellServiceSetServices_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[FECellServiceSetServices] ADD  CONSTRAINT [DF_FECellServiceSetServices_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[FECellServiceSetServices] ADD  CONSTRAINT [DF_FECellServiceSetServices_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[FileDownload] ADD  CONSTRAINT [DF_FileDownload_Obsolete]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[FinancialSystem] ADD  CONSTRAINT [DF_FinancialSystem_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GeoScienceStatus] ADD  CONSTRAINT [DF_GeoScienceStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation] ADD  CONSTRAINT [DF_GWIS_AssetAddtionalInformation_GWIS_AssetOwnershipID]  DEFAULT ((-1)) FOR [GWIS_AssetOwnershipID]
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation] ADD  CONSTRAINT [DF_GWIS_AssetAdditionalInformation_dateAcquired]  DEFAULT (getdate()) FOR [dateAcquired]
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation] ADD  CONSTRAINT [DF_GWIS_AssetAdditionalInformation_depreciationStartDate]  DEFAULT (getdate()) FOR [depreciationStartDate]
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation] ADD  CONSTRAINT [DF_GWIS_AssetAdditionalInformation_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation] ADD  CONSTRAINT [DF_GWIS_AssetAdditionalInformation_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation] ADD  CONSTRAINT [DF_GWIS_AssetAdditionalInformation_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetCategorization] ADD  CONSTRAINT [DF_GWIS_AssetCategorization_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetCategorization] ADD  CONSTRAINT [DF_GWIS_AssetCategorization_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetCategorization] ADD  CONSTRAINT [DF_GWIS_AssetCategorization_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetClass] ADD  CONSTRAINT [DF_GWIS_AssetClass_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetClass] ADD  CONSTRAINT [DF_GWIS_AssetClass_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetClass] ADD  CONSTRAINT [DF_GWIS_AssetClass_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetDivision] ADD  CONSTRAINT [DF_GWIS_AssetDivision_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetDivision] ADD  CONSTRAINT [DF_GWIS_AssetDivision_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetDivision] ADD  CONSTRAINT [DF_GWIS_AssetDivision_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetOwnership] ADD  CONSTRAINT [DF_GWIS_AssetOwnership_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetOwnership] ADD  CONSTRAINT [DF_GWIS_AssetOwnership_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetOwnership] ADD  CONSTRAINT [DF_GWIS_AssetOwnership_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetProduct] ADD  CONSTRAINT [DF_GWIS_AssetProduct_GWIS_AssetProductGroupID]  DEFAULT ((-1)) FOR [GWIS_AssetProductGroupID]
GO
ALTER TABLE [dbo].[GWIS_AssetProduct] ADD  CONSTRAINT [DF_GWIS_AssetProduct_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetProduct] ADD  CONSTRAINT [DF_GWIS_AssetProduct_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetProduct] ADD  CONSTRAINT [DF_GWIS_AssetProduct_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetProductGroup] ADD  CONSTRAINT [DF_GWIS_AssetProductGroup_xmlFileName]  DEFAULT (N'Not Set') FOR [xmlFileName]
GO
ALTER TABLE [dbo].[GWIS_AssetProductGroup] ADD  CONSTRAINT [DF_GWIS_AssetProductGroup_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetProductGroup] ADD  CONSTRAINT [DF_GWIS_AssetProductGroup_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetProductGroup] ADD  CONSTRAINT [DF_GWIS_AssetProductGroup_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_Assets] ADD  CONSTRAINT [DF_GWIS_Assets_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_Assets] ADD  CONSTRAINT [DF_GWIS_Assets_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_Assets] ADD  CONSTRAINT [DF_GWIS_Assets_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetStatus] ADD  CONSTRAINT [DF_GWIS_AssetStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetStatus] ADD  CONSTRAINT [DF_GWIS_AssetStatus_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetStatus] ADD  CONSTRAINT [DF_GWIS_AssetStatus_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersion_GWIS_AssetDivisionID]  DEFAULT ((-1)) FOR [GWIS_AssetDivisionID]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersion_GWIS_AssetCategorizationID]  DEFAULT ((-1)) FOR [GWIS_AssetCategorizationID]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersion_GWIS_AssetToolPanelCodeVersionStatusID]  DEFAULT ((-1)) FOR [GWIS_AssetToolPanelCodeVersionStatusID]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersion_GWIS_AssetProductID]  DEFAULT ((-1)) FOR [GWIS_AssetProductID]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersion_GWIS_AssetClassID]  DEFAULT ((-1)) FOR [GWIS_AssetClassID]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersion_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersion_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersion_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersionStatus] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersionStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersionStatus] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersionStatus_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersionStatus] ADD  CONSTRAINT [DF_GWIS_AssetToolPanelCodeVersionStatus_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[GWIS_Location] ADD  CONSTRAINT [DF_GWIS_Location_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributeMatrix] ADD  CONSTRAINT [DF_GWIS_LocationAttributeMatrix_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes] ADD  CONSTRAINT [DF_GWIS_LocationAttributes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributeValue] ADD  CONSTRAINT [DF_GWIS_LocationAttributeValue_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributeValue] ADD  CONSTRAINT [DF_GWIS_LocationAttributeValue_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[GWIS_LocationRelationType] ADD  CONSTRAINT [DF_GWIS_LocationRelationType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JDEEnabled] ADD  CONSTRAINT [DF_JDEEnabled_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Table_1_jobID]  DEFAULT (newid()) FOR [jobID]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Table_1_date_submitted]  DEFAULT (getutcdate()) FOR [dateSubmitted]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_dateUploaded]  DEFAULT (NULL) FOR [dateUploaded]
GO
ALTER TABLE [dbo].[JobActualServices] ADD  CONSTRAINT [DF_JobActualServices_jobActualServiceID]  DEFAULT (newid()) FOR [jobActualServiceID]
GO
ALTER TABLE [dbo].[JobActualServices] ADD  CONSTRAINT [DF_JobActualServices_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobActualServices] ADD  CONSTRAINT [DF_JobActualServices_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobActualServices] ADD  CONSTRAINT [DF_JobActualServices_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobAdditionalCharges] ADD  CONSTRAINT [DF_JobAdditionalCharges_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobAdditionalCharges] ADD  CONSTRAINT [DF_JobAdditionalCharges_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobAdditionalCharges] ADD  CONSTRAINT [DF_JobAdditionalCharges_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobAssets] ADD  CONSTRAINT [DF_JobAssets_jobAssetID]  DEFAULT (newid()) FOR [jobAssetID]
GO
ALTER TABLE [dbo].[JobAssets] ADD  CONSTRAINT [DF_JobAssets_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobAssets] ADD  CONSTRAINT [DF_JobAssets_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobAssets] ADD  CONSTRAINT [DF_JobAssets_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonus] ADD  CONSTRAINT [DF_JobBonus_jobBonusID]  DEFAULT (newid()) FOR [jobBonusID]
GO
ALTER TABLE [dbo].[JobBonus] ADD  CONSTRAINT [DF_JobBonus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonus] ADD  CONSTRAINT [DF_JobBonus_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonus] ADD  CONSTRAINT [DF_JobBonus_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusData] ADD  CONSTRAINT [DF_JobBonusData_jobBonusDataID]  DEFAULT (newid()) FOR [jobBonusDataID]
GO
ALTER TABLE [dbo].[JobBonusData] ADD  CONSTRAINT [DF_JobBonusData_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusData] ADD  CONSTRAINT [DF_JobBonusData_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusData] ADD  CONSTRAINT [DF_JobBonusData_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusData] ADD  CONSTRAINT [DF_JobBonusData_recommendedBonusPercentage]  DEFAULT ((0)) FOR [recommendedBonusPercentage]
GO
ALTER TABLE [dbo].[JobBonusDeclineReason] ADD  CONSTRAINT [DF_JobBonusDeclineReason_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusExceptionData] ADD  CONSTRAINT [DF_JobBonusExceptionData_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusExceptionData] ADD  CONSTRAINT [DF_JobBonusExceptionData_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusExceptionData] ADD  CONSTRAINT [DF_JobBonusExceptionData_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusExceptionLog] ADD  CONSTRAINT [DF_JobBonusExceptionLog_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusExceptionLog] ADD  CONSTRAINT [DF_JobBonusExceptionLog_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusExceptionLog] ADD  CONSTRAINT [DF_JobBonusExceptionLog_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusFlatRateData] ADD  CONSTRAINT [DF_JobBonusFlatRateData_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusFlatRateData] ADD  CONSTRAINT [DF_JobBonusFlatRateData_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusFlatRateData] ADD  CONSTRAINT [DF_JobBonusFlatRateData_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusFlatRateLog] ADD  CONSTRAINT [DF_JobBonusFlatRateLog_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusFlatRateLog] ADD  CONSTRAINT [DF_JobBonusFlatRateLog_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusFlatRateLog] ADD  CONSTRAINT [DF_JobBonusFlatRateLog_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusHistory] ADD  CONSTRAINT [DF_JobBonusHistory_JobBonusHistoryID]  DEFAULT (newid()) FOR [jobBonusHistoryID]
GO
ALTER TABLE [dbo].[JobBonusHistory] ADD  CONSTRAINT [DF_JobBonusHistory_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusHistory] ADD  CONSTRAINT [DF_JobBonusHistory_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusHistory] ADD  CONSTRAINT [DF_JobBonusHistory_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusPersonnelData] ADD  CONSTRAINT [DF_JobBonusPersonnelData_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusPersonnelData] ADD  CONSTRAINT [DF_JobBonusPersonnelData_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusPersonnelData] ADD  CONSTRAINT [DF_JobBonusPersonnelData_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusProcessed] ADD  CONSTRAINT [DF_JobBonusProcessed_jobBonusProcessedID]  DEFAULT (newid()) FOR [jobBonusProcessedID]
GO
ALTER TABLE [dbo].[JobBonusProcessed] ADD  CONSTRAINT [DF_JobBonusProcessed_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusProcessed] ADD  CONSTRAINT [DF_JobBonusProcessed_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusProcessed] ADD  CONSTRAINT [DF_JobBonusProcessed_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusProcessedCurrencyRate] ADD  CONSTRAINT [DF_JobBonusProcessedCurrencyRate_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusStatus] ADD  CONSTRAINT [DF_JobBonusStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusStatusLog] ADD  CONSTRAINT [DF_JobBonusStatusLog_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobBonusStatusLog] ADD  CONSTRAINT [DF_JobBonusStatusLog_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobBonusStatusLog] ADD  CONSTRAINT [DF_JobBonusStatusLog_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobBonusType] ADD  CONSTRAINT [DF_JobBonusType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobCancelledReasons] ADD  CONSTRAINT [DF_JobCancelledReasons_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobCharges] ADD  CONSTRAINT [DF_JobCharges_jobChargeID]  DEFAULT (newid()) FOR [jobChargeID]
GO
ALTER TABLE [dbo].[JobCharges] ADD  CONSTRAINT [DF_JobCharges_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobCharges] ADD  CONSTRAINT [DF_JobCharges_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobCharges] ADD  CONSTRAINT [DF_JobCharges_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobChargesLog] ADD  CONSTRAINT [DF_JobChargesLog_jobChargesLog]  DEFAULT (newid()) FOR [jobChargesLog]
GO
ALTER TABLE [dbo].[JobChargesLog] ADD  CONSTRAINT [DF_JobChargesLog_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobChargesLog] ADD  CONSTRAINT [DF_JobChargesLog_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobChargesLog] ADD  CONSTRAINT [DF_JobChargesLog_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobCompanyEDIFieldData] ADD  CONSTRAINT [DF_JobCompanyEDIFieldID_jobCompanyEDIFieldID]  DEFAULT (newid()) FOR [jobCompanyEDIFieldDataID]
GO
ALTER TABLE [dbo].[JobCompanyEDIFieldData] ADD  CONSTRAINT [DF_JobCompanyEDIFieldID_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobCompanyEDIFieldData] ADD  CONSTRAINT [DF_JobCompanyEDIFieldID_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobCompanyEDIFieldData] ADD  CONSTRAINT [DF_JobCompanyEDIFieldID_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobContacts] ADD  CONSTRAINT [DF_JobContacts_jobContactID]  DEFAULT (newid()) FOR [jobContactID]
GO
ALTER TABLE [dbo].[JobContacts] ADD  CONSTRAINT [DF_JobContacts_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobContacts] ADD  CONSTRAINT [DF_JobContacts_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobContacts] ADD  CONSTRAINT [DF_JobContacts_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobCrew] ADD  CONSTRAINT [DF_JobCrew_jobCrewID]  DEFAULT (newid()) FOR [jobCrewID]
GO
ALTER TABLE [dbo].[JobCrew] ADD  CONSTRAINT [DF_JobCrew_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobCrew] ADD  CONSTRAINT [DF_JobCrew_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobCrew] ADD  CONSTRAINT [DF_JobCrew_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobCustomerCounts] ADD  CONSTRAINT [DF_JobCustomerCounts_customerCountsID]  DEFAULT (newid()) FOR [customerCountsID]
GO
ALTER TABLE [dbo].[JobCustomerCounts] ADD  CONSTRAINT [DF_JobCustomerCounts_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobCustomerCounts] ADD  CONSTRAINT [DF_JobCustomerCounts_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobCustomerCounts] ADD  CONSTRAINT [DF_JobCustomerCounts_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobInvoice] ADD  CONSTRAINT [DF_JobInvoice_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[JobInvoice] ADD  CONSTRAINT [DF_JobInvoice_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobInvoice] ADD  CONSTRAINT [DF_JobInvoice_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobInvoice] ADD  CONSTRAINT [DF_JobInvoice_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobInvoice] ADD  CONSTRAINT [DF_JobInvoice_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[JobInvoice] ADD  CONSTRAINT [DF_JobInvoice_rate]  DEFAULT ((277)) FOR [rate]
GO
ALTER TABLE [dbo].[JobInvoice] ADD  CONSTRAINT [DF_JobInvoice_hoursInDay]  DEFAULT ((12)) FOR [hoursInDay]
GO
ALTER TABLE [dbo].[JobInvoice] ADD  CONSTRAINT [DF_JobInvoice_daysInWeek]  DEFAULT ((7)) FOR [daysInWeek]
GO
ALTER TABLE [dbo].[JobInvoiceAdjustment] ADD  CONSTRAINT [DF_JobInvoiceAdjustment_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobInvoiceAdjustment] ADD  CONSTRAINT [DF_JobInvoiceAdjustment_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobInvoiceAdjustment] ADD  CONSTRAINT [DF_JobInvoiceAdjustment_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobInvoiceAdjustmentType] ADD  CONSTRAINT [DF_JobInvoiceAdjustmentType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobInvoiceAdjustmentType] ADD  CONSTRAINT [DF_JobInvoiceAdjustmentType_insertId]  DEFAULT ((0)) FOR [insertId]
GO
ALTER TABLE [dbo].[JobInvoiceAdjustmentType] ADD  CONSTRAINT [DF_JobInvoiceAdjustmentType_updateId]  DEFAULT ((0)) FOR [updateId]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_itemQty]  DEFAULT ((1)) FOR [itemQty]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_itemPrice]  DEFAULT ((0)) FOR [itemPrice]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_itemActualPrice]  DEFAULT ((0)) FOR [itemActualPrice]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_itemDiscount]  DEFAULT ((0)) FOR [itemDiscount]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_itemSurcharge]  DEFAULT ((0)) FOR [itemSurcharge]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_itemTotal]  DEFAULT ((0)) FOR [itemTotal]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_shown]  DEFAULT ((0)) FOR [shown]
GO
ALTER TABLE [dbo].[JobInvoiceItem] ADD  CONSTRAINT [DF_JobInvoiceItem_generated]  DEFAULT ((0)) FOR [generated]
GO
ALTER TABLE [dbo].[JobInvoiceType] ADD  CONSTRAINT [DF_JobInvoiceType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobInvoiceType] ADD  CONSTRAINT [DF_JobInvoiceType_updateId]  DEFAULT ((0)) FOR [updateId]
GO
ALTER TABLE [dbo].[JobInvoiceType] ADD  CONSTRAINT [DF_JobInvoiceType_insertId]  DEFAULT ((0)) FOR [insertId]
GO
ALTER TABLE [dbo].[JobKOCDetails] ADD  CONSTRAINT [DF_JobKOCDetails_jobKOCID]  DEFAULT (newid()) FOR [jobKOCID]
GO
ALTER TABLE [dbo].[JobKOCDetails] ADD  CONSTRAINT [DF_JobKOCDetails_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobKOCDetails] ADD  CONSTRAINT [DF_JobKOCDetails_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobKOCDetails] ADD  CONSTRAINT [DF_JobKOCDetails_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobLock] ADD  CONSTRAINT [DF_JobLock_Created]  DEFAULT (getutcdate()) FOR [Created]
GO
ALTER TABLE [dbo].[JobLock] ADD  CONSTRAINT [DF_JobLock_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobLock] ADD  CONSTRAINT [DF_JobLock_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobLock] ADD  CONSTRAINT [DF_JobLock_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobNote] ADD  CONSTRAINT [DF_JobNote_jobNoteId]  DEFAULT (newid()) FOR [jobNoteId]
GO
ALTER TABLE [dbo].[JobOperationAuxData] ADD  CONSTRAINT [DF_JobOperationAuxData_jobOperationAuxDataID]  DEFAULT (newid()) FOR [jobOperationAuxDataID]
GO
ALTER TABLE [dbo].[JobOperationAuxData] ADD  CONSTRAINT [DF_JobOperationAuxData_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobOperationAuxData] ADD  CONSTRAINT [DF_JobOperationAuxData_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperationAuxData] ADD  CONSTRAINT [DF_JobOperationAuxData_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobOperationEventAuxData] ADD  CONSTRAINT [DF_JobOperationEventAuxData_auxillaryDataID]  DEFAULT (newid()) FOR [auxillaryDataID]
GO
ALTER TABLE [dbo].[JobOperationEventAuxData] ADD  CONSTRAINT [DF_JobOperationEventAuxData_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobOperationEventAuxData] ADD  CONSTRAINT [DF_JobOperationEventAuxData_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperationEventAuxData] ADD  CONSTRAINT [DF_JobOperationEventAuxData_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobOperationEventIntervalCharge] ADD  CONSTRAINT [DF_JobOperationEventIntervalCharge_ChargeType]  DEFAULT ((0)) FOR [ChargeType]
GO
ALTER TABLE [dbo].[JobOperationEventIntervalCharge] ADD  CONSTRAINT [DF_JobOperationEventIntervalCharge_ItemQty]  DEFAULT ((1)) FOR [ItemQty]
GO
ALTER TABLE [dbo].[JobOperationEventIntervalCharge] ADD  CONSTRAINT [DF_JobOperationEventIntervalCharge_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobOperationEventIntervalCharge] ADD  CONSTRAINT [DF_JobOperationEventIntervalCharge_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperationEventIntervalCharge] ADD  CONSTRAINT [DF_JobOperationEventIntervalCharge_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobOperationEventIntervals] ADD  CONSTRAINT [DF_JobOperationEventIntervals_jobOperationEventIntervalID]  DEFAULT (newid()) FOR [jobOperationEventIntervalID]
GO
ALTER TABLE [dbo].[JobOperationEventIntervals] ADD  CONSTRAINT [DF_JobOperationEventIntervals_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobOperationEventIntervals] ADD  CONSTRAINT [DF_JobOperationEventIntervals_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperationEventIntervals] ADD  CONSTRAINT [DF_JobOperationEventIntervals_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobOperationEvents] ADD  CONSTRAINT [DF_JobOperationEvents_jobOperationEventID]  DEFAULT (newid()) FOR [jobOperationEventID]
GO
ALTER TABLE [dbo].[JobOperationEvents] ADD  CONSTRAINT [DF_JobOperationEvents_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobOperationEvents] ADD  CONSTRAINT [DF_JobOperationEvents_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperationEvents] ADD  CONSTRAINT [DF_JobOperationEvents_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobOperations] ADD  CONSTRAINT [DF_JobOperations_jobOperationID]  DEFAULT (newid()) FOR [jobOperationID]
GO
ALTER TABLE [dbo].[JobOperations] ADD  CONSTRAINT [DF_JobOperations_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobOperations] ADD  CONSTRAINT [DF_JobOperations_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperations] ADD  CONSTRAINT [DF_JobOperations_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobOperationsCharge] ADD  CONSTRAINT [DF_JobOperationsCharge_ItemQty]  DEFAULT ((1)) FOR [ItemQty]
GO
ALTER TABLE [dbo].[JobOperationsCharge] ADD  CONSTRAINT [DF_JobOperationsCharge_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobOperationsCharge] ADD  CONSTRAINT [DF_JobOperationsCharge_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperationsCharge] ADD  CONSTRAINT [DF_JobOperationsCharge_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobOperationTools] ADD  CONSTRAINT [DF_JobOperationTools_jobOperationToolID]  DEFAULT (newid()) FOR [jobOperationToolID]
GO
ALTER TABLE [dbo].[JobOperationTools] ADD  CONSTRAINT [DF_JobOperationTools_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobOperationTools] ADD  CONSTRAINT [DF_JobOperationTools_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperationTools] ADD  CONSTRAINT [DF_JobOperationTools_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobOperationTypes] ADD  CONSTRAINT [DF_JobOperationTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobOperationTypes] ADD  CONSTRAINT [DF_JobOperationTypes_sortOrder]  DEFAULT ((1)) FOR [sortOrder]
GO
ALTER TABLE [dbo].[JobPrintConfiguration] ADD  CONSTRAINT [DF_JobPrintConfiguration_jobPrintConfigurationID]  DEFAULT (newid()) FOR [jobPrintConfigurationID]
GO
ALTER TABLE [dbo].[JobPrintConfiguration] ADD  CONSTRAINT [DF_JobPrintConfiguration_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobPrintConfiguration] ADD  CONSTRAINT [DF_JobPrintConfiguration_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobPrintConfiguration] ADD  CONSTRAINT [DF_JobPrintConfiguration_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobPrintConfigurationSections] ADD  CONSTRAINT [DF_JobPrintConfigurationSections_jobPrintConfigurationSectionID]  DEFAULT (newid()) FOR [jobPrintConfigurationSectionID]
GO
ALTER TABLE [dbo].[JobPrintConfigurationSections] ADD  CONSTRAINT [DF_JobPrintConfigurationSections_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobPrintConfigurationSections] ADD  CONSTRAINT [DF_JobPrintConfigurationSections_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobPrintConfigurationSections] ADD  CONSTRAINT [DF_JobPrintConfigurationSections_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobPrintSections] ADD  CONSTRAINT [DF_JobPrintSections_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobPrintSections] ADD  CONSTRAINT [DF_JobPrintSections_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobPrintSections] ADD  CONSTRAINT [DF_JobPrintSections_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobReview] ADD  CONSTRAINT [DF_JobReview_jobReviewID]  DEFAULT (newid()) FOR [jobReviewID]
GO
ALTER TABLE [dbo].[JobReview] ADD  CONSTRAINT [DF_JobReview_Step]  DEFAULT ((1)) FOR [Step]
GO
ALTER TABLE [dbo].[JobSchedulingLog] ADD  CONSTRAINT [DF_JobSchedulingLog_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobSchedulingLog] ADD  CONSTRAINT [DF_JobSchedulingLog_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobSchedulingLog] ADD  CONSTRAINT [DF_JobSchedulingLog_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobSelectedServiceAssureConveyanceDetails] ADD  CONSTRAINT [DF_JobSelectedServiceAssureConveyance_jobSelectedServiceAssureConveyanceDetails]  DEFAULT (newid()) FOR [jobSelectedServiceAssureConveyanceDetailID]
GO
ALTER TABLE [dbo].[JobSelectedServiceAssureConveyanceDetails] ADD  CONSTRAINT [DF_JobSelectedServiceAssureConveyance_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobSelectedServiceAssureConveyanceDetails] ADD  CONSTRAINT [DF_JobSelectedServiceAssureConveyance_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobSelectedServiceAssureConveyanceDetails] ADD  CONSTRAINT [DF_JobSelectedServiceAssureConveyance_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobSelectedServiceCasedHoleMechanicalDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServiceCasedHoleMechanicalDispatchDetails_jobSelectedServiceCasedHoleMechanicalDispatchDetailsID]  DEFAULT (newid()) FOR [jobSelectedServiceCasedHoleMechanicalDispatchDetailsID]
GO
ALTER TABLE [dbo].[JobSelectedServiceCasedHoleMechanicalDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServiceCasedHoleMechanicalDispatchDetails_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobSelectedServiceCasedHoleMechanicalDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServiceCasedHoleMechanicalDispatchDetails_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobSelectedServiceCasedHoleMechanicalDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServiceCasedHoleMechanicalDispatchDetails_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobSelectedServiceDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServiceDispatchDetails_jobSelectedServiceDispatchDetailID]  DEFAULT (newid()) FOR [jobSelectedServiceDispatchDetailID]
GO
ALTER TABLE [dbo].[JobSelectedServiceDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServiceDispatchDetails_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobSelectedServiceDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServiceDispatchDetails_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobSelectedServiceDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServiceDispatchDetails_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobSelectedServicePerforatingDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServicePerforatingDispatchDetails_jobSelectedServicePerforatingDispatchDetailsID]  DEFAULT (newid()) FOR [jobSelectedServicePerforatingDispatchDetailsID]
GO
ALTER TABLE [dbo].[JobSelectedServicePerforatingDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServicePerforatingDispatchDetails_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobSelectedServicePerforatingDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServicePerforatingDispatchDetails_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobSelectedServicePerforatingDispatchDetails] ADD  CONSTRAINT [DF_JobSelectedServicePerforatingDispatchDetails_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobSelectedServicePipeRecoveryDetails] ADD  CONSTRAINT [DF_JobSelectedServicePipeRecovery_jobSelectedServicePipeRecoveryDetails]  DEFAULT (newid()) FOR [jobSelectedServicePipeRecoveryDetailID]
GO
ALTER TABLE [dbo].[JobSelectedServicePipeRecoveryDetails] ADD  CONSTRAINT [DF_JobSelectedServicePipeRecovery_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobSelectedServicePipeRecoveryDetails] ADD  CONSTRAINT [DF_JobSelectedServicePipeRecovery_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobSelectedServicePipeRecoveryDetails] ADD  CONSTRAINT [DF_JobSelectedServicePipeRecovery_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobSelectedServices] ADD  CONSTRAINT [DF_JobSelectedServices_jobSelectedServiceID]  DEFAULT (newid()) FOR [jobSelectedServiceID]
GO
ALTER TABLE [dbo].[JobSelectedServices] ADD  CONSTRAINT [DF_JobSelectedServices_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobSelectedServices] ADD  CONSTRAINT [DF_JobSelectedServices_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobSelectedServices] ADD  CONSTRAINT [DF_JobSelectedServices_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobStatus] ADD  CONSTRAINT [DF_JobStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobStatusLog] ADD  CONSTRAINT [DF_JobStatusLog_jobStatusLogID]  DEFAULT (newid()) FOR [jobStatusLogID]
GO
ALTER TABLE [dbo].[JobStatusLog] ADD  CONSTRAINT [DF_JobStatusLog_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobStatusLog] ADD  CONSTRAINT [DF_JobStatusLog_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobStatusLog] ADD  CONSTRAINT [DF_JobStatusLog_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobSuperUsers] ADD  CONSTRAINT [DF_JobSuperUsers_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobTicketJobOperationCategory] ADD  CONSTRAINT [DF_JobTicketJobOperationCategory_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobWellBoreholeProfile] ADD  CONSTRAINT [DF_JobWellBoreholeProfile_jobWellBoreholeProfileID]  DEFAULT (newid()) FOR [jobWellBoreholeProfileID]
GO
ALTER TABLE [dbo].[JobWellBoreholeProfile] ADD  CONSTRAINT [DF_JobWellBoreholeProfile_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobWellBoreholeProfile] ADD  CONSTRAINT [DF_JobWellBoreholeProfile_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobWellBoreholeProfile] ADD  CONSTRAINT [DF_JobWellBoreholeProfile_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile] ADD  CONSTRAINT [DF_JobWellCasingTubingProfile_jobWellCasingTubingProfileID]  DEFAULT (newid()) FOR [jobWellCasingTubingProfileID]
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile] ADD  CONSTRAINT [DF_JobWellCasingTubingProfile_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile] ADD  CONSTRAINT [DF_JobWellCasingTubingProfile_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile] ADD  CONSTRAINT [DF_JobWellCasingTubingProfile_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobWells] ADD  CONSTRAINT [DF_JobWells_jobWellID]  DEFAULT (newid()) FOR [jobWellID]
GO
ALTER TABLE [dbo].[JobWells] ADD  CONSTRAINT [DF_JobWells_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[JobWells] ADD  CONSTRAINT [DF_JobWells_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[JobWells] ADD  CONSTRAINT [DF_JobWells_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Location_Attribute_Types] ADD  CONSTRAINT [DF_Location_Attribute_Types_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Location_Attribute_Values] ADD  CONSTRAINT [DF_Location_Attribute_Values_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Location_Attributes] ADD  CONSTRAINT [DF_Location_Attributes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] ADD  CONSTRAINT [DF_MaintenanceRequestCR_BusinessUnitId]  DEFAULT ((-1)) FOR [BusinessUnitId]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] ADD  CONSTRAINT [DF_MaintenanceRequestCR_BranchPlantId]  DEFAULT ((-1)) FOR [BranchPlantId]
GO
ALTER TABLE [dbo].[MeasurementSystems] ADD  CONSTRAINT [DF_MeasurementSystems_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[MeasurementTypeDetail] ADD  CONSTRAINT [DF_MeasurementTypeDetail_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[MeasurementTypes] ADD  CONSTRAINT [DF_MeasurementTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[OneViewGWISSyncQueries] ADD  CONSTRAINT [DF_OneViewGWISSync_OneViewGWISSyncID]  DEFAULT (newid()) FOR [OneViewGWISSyncID]
GO
ALTER TABLE [dbo].[OneViewGWISSyncQueries] ADD  CONSTRAINT [DF_OneViewGWISSyncQueries_processReturn]  DEFAULT ((0)) FOR [processReturn]
GO
ALTER TABLE [dbo].[OneViewGWISSyncQueries] ADD  CONSTRAINT [DF_OneViewGWISSyncQueries_execOrder]  DEFAULT ((0)) FOR [execOrder]
GO
ALTER TABLE [dbo].[OperationLetter] ADD  CONSTRAINT [DF_OperationLetter_VersionChange]  DEFAULT ((0)) FOR [VersionChange]
GO
ALTER TABLE [dbo].[OperationLetterStatus] ADD  CONSTRAINT [DF_OperationLetterStatus_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[OperationLetterTool] ADD  CONSTRAINT [DF_OperationLetterTool_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[OperationLetterType] ADD  CONSTRAINT [DF_OperationLetterType_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[OVTOPSSync] ADD  CONSTRAINT [DF_OVTOPSSync_lastdbts]  DEFAULT (@@dbts) FOR [lastdbts]
GO
ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_Person_personID]  DEFAULT (newid()) FOR [personID]
GO
ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[PeopleAddresses] ADD  CONSTRAINT [DF_PeopleAddresses_peopleAddressID]  DEFAULT (newid()) FOR [peopleAddressID]
GO
ALTER TABLE [dbo].[PeopleAddresses] ADD  CONSTRAINT [DF_PeopleAddresses_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[PeopleAddresses] ADD  CONSTRAINT [DF_PeopleAddresses_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[PeopleAddresses] ADD  CONSTRAINT [DF_PeopleAddresses_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[PeopleCompanies] ADD  CONSTRAINT [DF_PeopleCompanies_personCompanyID]  DEFAULT (newid()) FOR [personCompanyID]
GO
ALTER TABLE [dbo].[PeopleCompanies] ADD  CONSTRAINT [DF_PeopleCompanies_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[PeopleCompanies] ADD  CONSTRAINT [DF_PeopleCompanies_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[PeopleCompanies] ADD  CONSTRAINT [DF_PeopleCompanies_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Pricebook] ADD  CONSTRAINT [DF_Pricebook_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Pricebook] ADD  CONSTRAINT [DF_Pricebook_jdePricebookCode]  DEFAULT ('ONEVIEW') FOR [jdePricebookCode]
GO
ALTER TABLE [dbo].[PricebookData] ADD  CONSTRAINT [DF_PricebookData_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[PriceBookStatus] ADD  CONSTRAINT [DF_PriceBookStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[PricebookTree] ADD  CONSTRAINT [DF_PricebookTree_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[PricingStyle] ADD  CONSTRAINT [DF_PricingStyle_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Quote] ADD  CONSTRAINT [DF_Quote_quoteID]  DEFAULT (newid()) FOR [quoteID]
GO
ALTER TABLE [dbo].[Quote] ADD  CONSTRAINT [DF_Quote_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Quote] ADD  CONSTRAINT [DF_Quote_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[Quote] ADD  CONSTRAINT [DF_Quote_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Region] ADD  CONSTRAINT [DF_Region_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[RentalChargeTypes] ADD  CONSTRAINT [DF_RentalChargeTypes_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[RentalChargeTypes] ADD  CONSTRAINT [DF_RentalChargeTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[RentalChargeTypes] ADD  CONSTRAINT [DF_RentalChargeTypes_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[RigType] ADD  CONSTRAINT [DF_RigType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[SeismicWellTypes] ADD  CONSTRAINT [DF_SeismicWellTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Sequences] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[Service] ADD  CONSTRAINT [DF_Service_inserted_1]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ServiceDetails] ADD  CONSTRAINT [DF_ServiceDetails_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ServiceGroup] ADD  CONSTRAINT [DF_ServiceGroup_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ServiceGroupToolType] ADD  CONSTRAINT [DF_ServiceGroupToolType_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[ServiceGroupToolType] ADD  CONSTRAINT [DF_ServiceGroupToolType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ServiceTool] ADD  CONSTRAINT [DF_ServiceTool_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[ServiceType] ADD  CONSTRAINT [DF_ServiceType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[SSISErrorLog] ADD  CONSTRAINT [DF_SSISErrorLog_created]  DEFAULT (getutcdate()) FOR [created]
GO
ALTER TABLE [dbo].[tmpJobBonusAdjustment] ADD  CONSTRAINT [DF_tmpJobBonusAdjustment_jobBonusAdjustmentID]  DEFAULT (newid()) FOR [jobBonusAdjustmentID]
GO
ALTER TABLE [dbo].[tmpJobBonusAdjustment] ADD  CONSTRAINT [DF_tmpJobBonusAdjustment_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[tmpJobBonusAdjustment] ADD  CONSTRAINT [DF_tmpJobBonusAdjustment_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[tmpJobBonusAdjustment] ADD  CONSTRAINT [DF_tmpJobBonusAdjustment_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[tmpJobBonusHistory] ADD  CONSTRAINT [DF_tmpJobBonusHistory_JobBonusHistoryID]  DEFAULT (newid()) FOR [jobBonusHistoryID]
GO
ALTER TABLE [dbo].[tmpJobBonusHistory] ADD  CONSTRAINT [DF_tmpJobBonusHistory_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[tmpJobBonusHistory] ADD  CONSTRAINT [DF_tmpJobBonusHistory_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[tmpJobBonusHistory] ADD  CONSTRAINT [DF_tmpJobBonusHistory_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[TMPSOADTPipelineMessageProcessing] ADD  CONSTRAINT [DF_TMPSOADTPipelineMessageProcessing_DateAdded]  DEFAULT (getutcdate()) FOR [DateAdded]
GO
ALTER TABLE [dbo].[TMPSOADTPipelineMessages] ADD  CONSTRAINT [DF_TMPSOADTPipelineMessages_DateInserted]  DEFAULT (getutcdate()) FOR [DateInserted]
GO
ALTER TABLE [dbo].[toolclass] ADD  CONSTRAINT [DF_toolclass_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[toolcodetype] ADD  CONSTRAINT [DF_toolcodetype_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[toolpanelcodeversion] ADD  CONSTRAINT [DF_toolpanelcodeversion_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[toolpanelcodeversion] ADD  CONSTRAINT [DF_toolpanelcodeversion_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[toolpanelcodeversion] ADD  CONSTRAINT [DF_toolpanelcodeversion_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[toolpaneltype] ADD  CONSTRAINT [DF_toolpaneltype_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UnitBuildInformation] ADD  CONSTRAINT [DF_UnitBuildInformation_expansion]  DEFAULT ((1)) FOR [expansion]
GO
ALTER TABLE [dbo].[UnitBuildInformation] ADD  CONSTRAINT [DF_UnitBuildInformation_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UnitHistory] ADD  CONSTRAINT [DF_UnitHistory_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[UnitHistory] ADD  CONSTRAINT [DF_UnitHistory_dateOfChange]  DEFAULT (getutcdate()) FOR [dateOfChange]
GO
ALTER TABLE [dbo].[UnitHistory] ADD  CONSTRAINT [DF_UnitHistory_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UnitLicense] ADD  CONSTRAINT [DF_UnitLicense_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UnitRackType] ADD  CONSTRAINT [DF_UnitRackType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[units] ADD  CONSTRAINT [DF_units_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UnitStatus] ADD  CONSTRAINT [DF_UnitStatus_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UnitType] ADD  CONSTRAINT [DF_UnitType_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UnitWireline] ADD  CONSTRAINT [DF_UnitWireline_reportDate]  DEFAULT (getutcdate()) FOR [reportDate]
GO
ALTER TABLE [dbo].[UnitWireline] ADD  CONSTRAINT [DF_UnitWireline_newInstall]  DEFAULT ((0)) FOR [newInstall]
GO
ALTER TABLE [dbo].[UnitWireline] ADD  CONSTRAINT [DF_UnitWireline_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UOM] ADD  CONSTRAINT [DF_UOM_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UserPreferences] ADD  CONSTRAINT [DF_UserPreferences_userPreferencesID]  DEFAULT (newid()) FOR [userPreferencesID]
GO
ALTER TABLE [dbo].[UserPreferences] ADD  CONSTRAINT [DF_UserPreferences_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UserPreferences] ADD  CONSTRAINT [DF_UserPreferences_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[UserPreferences] ADD  CONSTRAINT [DF_UserPreferences_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[UserPreferenceStorage] ADD  CONSTRAINT [DF_UserPreferenceStorage_inserted_1]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UserPreferenceStorage] ADD  CONSTRAINT [DF_UserPreferenceStorage_updateId_1]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[UserPreferenceStorage] ADD  CONSTRAINT [DF_UserPreferenceStorage_insertId_1]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[UserPreferenceTypes] ADD  CONSTRAINT [DF_UserPreferenceTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[UserPreferenceTypes] ADD  CONSTRAINT [DF_UserPreferenceTypes_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[UserPreferenceTypes] ADD  CONSTRAINT [DF_UserPreferenceTypes_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Well] ADD  CONSTRAINT [DF_Well_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[Well] ADD  CONSTRAINT [DF_Well_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [updateId]
GO
ALTER TABLE [dbo].[Well] ADD  CONSTRAINT [DF_Well_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [insertId]
GO
ALTER TABLE [dbo].[Well] ADD  CONSTRAINT [DF_Well_wellID]  DEFAULT (newid()) FOR [wellID]
GO
ALTER TABLE [dbo].[WellLocationType] ADD  CONSTRAINT [DF_WellLocation_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[WellProfileTypes] ADD  CONSTRAINT [DF_WellProfileTypes_inserted]  DEFAULT (@@dbts+(1)) FOR [inserted]
GO
ALTER TABLE [dbo].[wpts_countries] ADD  CONSTRAINT [DF_wpts_countries_lastmodifiedat]  DEFAULT (getdate()) FOR [lastmodifiedat]
GO
ALTER TABLE [dbo].[wpts_countries] ADD  CONSTRAINT [DF_wpts_countries_lastmodifiedby]  DEFAULT ('oneview') FOR [lastmodifiedby]
GO
ALTER TABLE [dbo].[wpts_countyparish] ADD  CONSTRAINT [DF_wpts_countyparish_lastmodifiedat]  DEFAULT (getdate()) FOR [lastmodifiedat]
GO
ALTER TABLE [dbo].[wpts_countyparish] ADD  CONSTRAINT [DF_wpts_countyparish_lastmodifiedby]  DEFAULT ('oneview') FOR [lastmodifiedby]
GO
ALTER TABLE [dbo].[WPTS_JobPostings] ADD  CONSTRAINT [DF_WPTS_JobPostings_maxLastUpdated]  DEFAULT (@@dbts+(1)) FOR [maxLastUpdated]
GO
ALTER TABLE [dbo].[wpts_regions] ADD  CONSTRAINT [DF_wpts_regions_lastupdatedby]  DEFAULT ('oneview') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[wpts_regions] ADD  CONSTRAINT [DF_wpts_regions_lastupdatedat]  DEFAULT (getdate()) FOR [lastupdatedat]
GO
ALTER TABLE [dbo].[wpts_stateprov] ADD  CONSTRAINT [DF_wpts_stateprov_lastmodifiedat]  DEFAULT (getdate()) FOR [lastmodifiedat]
GO
ALTER TABLE [dbo].[wpts_stateprov] ADD  CONSTRAINT [DF_wpts_stateprov_lastmodifiedby]  DEFAULT ('oneview') FOR [lastmodifiedby]
GO
ALTER TABLE [dbo].[wpts_subregions] ADD  CONSTRAINT [DF_wpts_subregions_lastmodifiedat]  DEFAULT (getdate()) FOR [lastmodifiedat]
GO
ALTER TABLE [dbo].[wpts_subregions] ADD  CONSTRAINT [DF_wpts_subregions_lastmodifiedby]  DEFAULT ('oneview') FOR [lastmodifiedby]
GO
ALTER TABLE [dbo].[Area]  WITH CHECK ADD  CONSTRAINT [FK_Area_Region] FOREIGN KEY([region_id])
REFERENCES [dbo].[Region] ([id])
GO
ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [FK_Area_Region]
GO
ALTER TABLE [dbo].[AssetServiceGroupExceptions]  WITH CHECK ADD  CONSTRAINT [FK_AssetServiceGroupExceptions_assets] FOREIGN KEY([assetID])
REFERENCES [dbo].[assets] ([assetID])
GO
ALTER TABLE [dbo].[AssetServiceGroupExceptions] CHECK CONSTRAINT [FK_AssetServiceGroupExceptions_assets]
GO
ALTER TABLE [dbo].[AssetServiceGroupExceptions]  WITH CHECK ADD  CONSTRAINT [FK_AssetServiceGroupExceptions_ServiceGroup] FOREIGN KEY([serviceGroupID])
REFERENCES [dbo].[ServiceGroup] ([id])
GO
ALTER TABLE [dbo].[AssetServiceGroupExceptions] CHECK CONSTRAINT [FK_AssetServiceGroupExceptions_ServiceGroup]
GO
ALTER TABLE [dbo].[BriefDebriefCategoriesLocalized]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefCategoriesLocalized_BriefDebriefCategories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[BriefDebriefCategories] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefCategoriesLocalized] CHECK CONSTRAINT [FK_BriefDebriefCategoriesLocalized_BriefDebriefCategories]
GO
ALTER TABLE [dbo].[BriefDebriefQuestions]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestions_BriefDebriefCategories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[BriefDebriefCategories] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestions] CHECK CONSTRAINT [FK_BriefDebriefQuestions_BriefDebriefCategories]
GO
ALTER TABLE [dbo].[BriefDebriefQuestions]  WITH NOCHECK ADD  CONSTRAINT [FK_BriefDebriefQuestions_BriefDebriefFields] FOREIGN KEY([FieldId])
REFERENCES [dbo].[BriefDebriefFields] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestions] CHECK CONSTRAINT [FK_BriefDebriefQuestions_BriefDebriefFields]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionsAnswers_BriefDebriefQuestions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[BriefDebriefQuestions] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers] CHECK CONSTRAINT [FK_BriefDebriefQuestionsAnswers_BriefDebriefQuestions]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionsAnswers_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers] CHECK CONSTRAINT [FK_BriefDebriefQuestionsAnswers_Employee]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionsAnswers_Job] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([jobID])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswers] CHECK CONSTRAINT [FK_BriefDebriefQuestionsAnswers_Job]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswersLog]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionsAnswersLog_BriefDebriefQuestionsAnswers] FOREIGN KEY([AnswerId])
REFERENCES [dbo].[BriefDebriefQuestionsAnswers] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswersLog] CHECK CONSTRAINT [FK_BriefDebriefQuestionsAnswersLog_BriefDebriefQuestionsAnswers]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswersLog]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionsAnswersLog_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsAnswersLog] CHECK CONSTRAINT [FK_BriefDebriefQuestionsAnswersLog_Employee]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsLocalized]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionsLocalized_BriefDebriefQuestions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[BriefDebriefQuestions] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsLocalized] CHECK CONSTRAINT [FK_BriefDebriefQuestionsLocalized_BriefDebriefQuestions]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsTypeValues]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionsTypeValues_BriefDebriefQuestions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[BriefDebriefQuestions] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsTypeValues] CHECK CONSTRAINT [FK_BriefDebriefQuestionsTypeValues_BriefDebriefQuestions]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsTypeValues]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionsTypeValues_BriefDebriefQuestionTypes] FOREIGN KEY([TypeId])
REFERENCES [dbo].[BriefDebriefQuestionTypes] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionsTypeValues] CHECK CONSTRAINT [FK_BriefDebriefQuestionsTypeValues_BriefDebriefQuestionTypes]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionTemplates]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionTemplates_BriefDebriefQuestions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[BriefDebriefQuestions] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionTemplates] CHECK CONSTRAINT [FK_BriefDebriefQuestionTemplates_BriefDebriefQuestions]
GO
ALTER TABLE [dbo].[BriefDebriefQuestionTemplates]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefQuestionTemplates_BriefDebriefTemplate] FOREIGN KEY([TemplateId])
REFERENCES [dbo].[BriefDebriefTemplate] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefQuestionTemplates] CHECK CONSTRAINT [FK_BriefDebriefQuestionTemplates_BriefDebriefTemplate]
GO
ALTER TABLE [dbo].[BriefDebriefTemplate]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefTemplate_BriefDebriefTemplate_Parent] FOREIGN KEY([Parent])
REFERENCES [dbo].[BriefDebriefTemplate] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefTemplate] CHECK CONSTRAINT [FK_BriefDebriefTemplate_BriefDebriefTemplate_Parent]
GO
ALTER TABLE [dbo].[BriefDebriefTemplate]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefTemplate_GWIS_LocationAttributes] FOREIGN KEY([Gwis_LocationAttributeId])
REFERENCES [dbo].[GWIS_LocationAttributes] ([GWIS_LocationAttributeID])
GO
ALTER TABLE [dbo].[BriefDebriefTemplate] CHECK CONSTRAINT [FK_BriefDebriefTemplate_GWIS_LocationAttributes]
GO
ALTER TABLE [dbo].[BriefDebriefTemplateHeader]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefTemplateHeader_BriefDebriefHeaders] FOREIGN KEY([BriefDebriefHeaderId])
REFERENCES [dbo].[BriefDebriefHeaders] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefTemplateHeader] CHECK CONSTRAINT [FK_BriefDebriefTemplateHeader_BriefDebriefHeaders]
GO
ALTER TABLE [dbo].[BriefDebriefTemplateHeader]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefTemplateHeader_BriefDebriefTemplate] FOREIGN KEY([BriefDebriefTemplateId])
REFERENCES [dbo].[BriefDebriefTemplate] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefTemplateHeader] CHECK CONSTRAINT [FK_BriefDebriefTemplateHeader_BriefDebriefTemplate]
GO
ALTER TABLE [dbo].[BriefDebriefTemplateHeaderLocalized]  WITH CHECK ADD  CONSTRAINT [FK_BriefDebriefTemplateHeaderLocalized_BriefDebriefTemplate] FOREIGN KEY([TemplateId])
REFERENCES [dbo].[BriefDebriefTemplate] ([Id])
GO
ALTER TABLE [dbo].[BriefDebriefTemplateHeaderLocalized] CHECK CONSTRAINT [FK_BriefDebriefTemplateHeaderLocalized_BriefDebriefTemplate]
GO
ALTER TABLE [dbo].[Cell]  WITH NOCHECK ADD  CONSTRAINT [FK_Cell_Asset] FOREIGN KEY([UnitAssetId])
REFERENCES [dbo].[assets] ([assetID])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [FK_Cell_Asset]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD  CONSTRAINT [fk_cell_costCenterBranchPlantId] FOREIGN KEY([CostCenterBranchPlantId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [fk_cell_costCenterBranchPlantId]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD  CONSTRAINT [fk_cell_costCenterDistrictId] FOREIGN KEY([CostCenterDistrictId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [fk_cell_costCenterDistrictId]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD  CONSTRAINT [fk_cell_costCenterID] FOREIGN KEY([CostCenterID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [fk_cell_costCenterID]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD  CONSTRAINT [fk_cell_districtmanagerid] FOREIGN KEY([DistrictManagerId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [fk_cell_districtmanagerid]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD  CONSTRAINT [fk_cell_ownerid] FOREIGN KEY([OwnerID])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [fk_cell_ownerid]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD  CONSTRAINT [fk_cell_revenueCenterBranchPlantId] FOREIGN KEY([RevenueCenterBranchPlantId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [fk_cell_revenueCenterBranchPlantId]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD  CONSTRAINT [fk_cell_revenueCenterDistrictId] FOREIGN KEY([RevenueCenterDistrictId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [fk_cell_revenueCenterDistrictId]
GO
ALTER TABLE [dbo].[Cell]  WITH CHECK ADD  CONSTRAINT [fk_cell_revenueCenterID] FOREIGN KEY([RevenueCenterID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Cell] CHECK CONSTRAINT [fk_cell_revenueCenterID]
GO
ALTER TABLE [dbo].[CellEmployees]  WITH CHECK ADD  CONSTRAINT [fk_cellEmployees_cellid] FOREIGN KEY([CellID])
REFERENCES [dbo].[Cell] ([CellID])
GO
ALTER TABLE [dbo].[CellEmployees] CHECK CONSTRAINT [fk_cellEmployees_cellid]
GO
ALTER TABLE [dbo].[CellEmployees]  WITH CHECK ADD  CONSTRAINT [fk_cellEmployees_employeeid] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[CellEmployees] CHECK CONSTRAINT [fk_cellEmployees_employeeid]
GO
ALTER TABLE [dbo].[CellLog]  WITH CHECK ADD  CONSTRAINT [fk_celllog_cellid] FOREIGN KEY([CellID])
REFERENCES [dbo].[Cell] ([CellID])
GO
ALTER TABLE [dbo].[CellLog] CHECK CONSTRAINT [fk_celllog_cellid]
GO
ALTER TABLE [dbo].[CellLog]  WITH CHECK ADD  CONSTRAINT [fk_celllog_modifiedById] FOREIGN KEY([ModifiedById])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[CellLog] CHECK CONSTRAINT [fk_celllog_modifiedById]
GO
ALTER TABLE [dbo].[CellServiceSet]  WITH CHECK ADD  CONSTRAINT [FK_CellServiceSet_Cell] FOREIGN KEY([cellID])
REFERENCES [dbo].[Cell] ([CellID])
GO
ALTER TABLE [dbo].[CellServiceSet] CHECK CONSTRAINT [FK_CellServiceSet_Cell]
GO
ALTER TABLE [dbo].[CellServiceSetService]  WITH CHECK ADD  CONSTRAINT [FK_CellServiceSetService_CellServiceSet] FOREIGN KEY([cellServiceSetID])
REFERENCES [dbo].[CellServiceSet] ([cellServiceSetID])
GO
ALTER TABLE [dbo].[CellServiceSetService] CHECK CONSTRAINT [FK_CellServiceSetService_CellServiceSet]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_CompanyStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[CompanyStatus] ([ID])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_CompanyStatus]
GO
ALTER TABLE [dbo].[CompanyAddress]  WITH CHECK ADD  CONSTRAINT [FK_CompanyAddress_Address] FOREIGN KEY([oneViewAddressID])
REFERENCES [dbo].[Address] ([oneViewAddressID])
GO
ALTER TABLE [dbo].[CompanyAddress] CHECK CONSTRAINT [FK_CompanyAddress_Address]
GO
ALTER TABLE [dbo].[CompanyAddress]  WITH CHECK ADD  CONSTRAINT [FK_CompanyAddress_Company] FOREIGN KEY([oneViewCompanyID])
REFERENCES [dbo].[Company] ([oneViewCompanyID])
GO
ALTER TABLE [dbo].[CompanyAddress] CHECK CONSTRAINT [FK_CompanyAddress_Company]
GO
ALTER TABLE [dbo].[CompanyPricebook]  WITH CHECK ADD  CONSTRAINT [FK_CompanyPricebook_CompanyAddress] FOREIGN KEY([CompanyAddressId])
REFERENCES [dbo].[CompanyAddress] ([companyAddressID])
GO
ALTER TABLE [dbo].[CompanyPricebook] CHECK CONSTRAINT [FK_CompanyPricebook_CompanyAddress]
GO
ALTER TABLE [dbo].[CompanyPricebook]  WITH CHECK ADD  CONSTRAINT [FK_CompanyPricebook_Pricebook] FOREIGN KEY([PricebookId])
REFERENCES [dbo].[Pricebook] ([id])
GO
ALTER TABLE [dbo].[CompanyPricebook] CHECK CONSTRAINT [FK_CompanyPricebook_Pricebook]
GO
ALTER TABLE [dbo].[CompanyRegion]  WITH CHECK ADD  CONSTRAINT [FK_CompanyOperationalRegionCompany] FOREIGN KEY([oneViewCompanyID])
REFERENCES [dbo].[Company] ([oneViewCompanyID])
GO
ALTER TABLE [dbo].[CompanyRegion] CHECK CONSTRAINT [FK_CompanyOperationalRegionCompany]
GO
ALTER TABLE [dbo].[CompanyRegion]  WITH CHECK ADD  CONSTRAINT [FK_CompanyOperationalRegionRegion] FOREIGN KEY([region])
REFERENCES [dbo].[Region] ([id])
GO
ALTER TABLE [dbo].[CompanyRegion] CHECK CONSTRAINT [FK_CompanyOperationalRegionRegion]
GO
ALTER TABLE [dbo].[ContactInfo]  WITH CHECK ADD  CONSTRAINT [FK_ContactInfo_ContactTypesContactSubTypes] FOREIGN KEY([contactTypeContactSubTypeID])
REFERENCES [dbo].[ContactTypesContactSubTypes] ([contactTypeContactSubTypeID])
GO
ALTER TABLE [dbo].[ContactInfo] CHECK CONSTRAINT [FK_ContactInfo_ContactTypesContactSubTypes]
GO
ALTER TABLE [dbo].[ContactInfo]  WITH CHECK ADD  CONSTRAINT [FK_ContactInfo_People] FOREIGN KEY([personID])
REFERENCES [dbo].[People] ([personID])
GO
ALTER TABLE [dbo].[ContactInfo] CHECK CONSTRAINT [FK_ContactInfo_People]
GO
ALTER TABLE [dbo].[ContactTypesContactSubTypes]  WITH CHECK ADD  CONSTRAINT [FK_ContactTypesContactSubTypes_ContactSubTypes] FOREIGN KEY([contactSubTypeID])
REFERENCES [dbo].[ContactSubTypes] ([contactSubTypeID])
GO
ALTER TABLE [dbo].[ContactTypesContactSubTypes] CHECK CONSTRAINT [FK_ContactTypesContactSubTypes_ContactSubTypes]
GO
ALTER TABLE [dbo].[ContactTypesContactSubTypes]  WITH CHECK ADD  CONSTRAINT [FK_ContactTypesContactSubTypes_ContactTypes] FOREIGN KEY([contactTypeID])
REFERENCES [dbo].[ContactTypes] ([contactTypeID])
GO
ALTER TABLE [dbo].[ContactTypesContactSubTypes] CHECK CONSTRAINT [FK_ContactTypesContactSubTypes_ContactTypes]
GO
ALTER TABLE [dbo].[ConveyanceSubType]  WITH CHECK ADD  CONSTRAINT [FK_ConveyanceSubType_ConveyanceType] FOREIGN KEY([conveyanceTypeID])
REFERENCES [dbo].[ConveyanceType] ([conveyanceTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ConveyanceSubType] CHECK CONSTRAINT [FK_ConveyanceSubType_ConveyanceType]
GO
ALTER TABLE [dbo].[CurrencyRate]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyRate_Currency] FOREIGN KEY([currencyID])
REFERENCES [dbo].[Currency] ([currencyID])
GO
ALTER TABLE [dbo].[CurrencyRate] CHECK CONSTRAINT [FK_CurrencyRate_Currency]
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_Area] FOREIGN KEY([area])
REFERENCES [dbo].[Area] ([id])
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_Area]
GO
ALTER TABLE [dbo].[EconnectEmployeeData]  WITH NOCHECK ADD  CONSTRAINT [FK_EconnectEmployeeData_Employee] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employee] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[EconnectEmployeeData] NOCHECK CONSTRAINT [FK_EconnectEmployeeData_Employee]
GO
ALTER TABLE [dbo].[EconnectEmployeeData]  WITH NOCHECK ADD  CONSTRAINT [FK_EconnectEmployeeData_Employee1] FOREIGN KEY([managerEmployeeID])
REFERENCES [dbo].[Employee] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[EconnectEmployeeData] NOCHECK CONSTRAINT [FK_EconnectEmployeeData_Employee1]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK__Employee__manage__2BBF5DDB] FOREIGN KEY([managerid])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK__Employee__manage__2BBF5DDB]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [fk_equipment_cellid] FOREIGN KEY([CellID])
REFERENCES [dbo].[Cell] ([CellID])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [fk_equipment_cellid]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_EquipmentStatus] FOREIGN KEY([equipmentStatusID])
REFERENCES [dbo].[EquipmentStatus] ([equipmentStatusID])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_EquipmentStatus]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipments_EquipmentToolPanelCodeVersion] FOREIGN KEY([equipmentToolPanelCodeVersionID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipments_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[Equipment]  WITH NOCHECK ADD  CONSTRAINT [FK_Equipments_GWIS_Location_BranchPlant] FOREIGN KEY([BranchPlantID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Equipment] NOCHECK CONSTRAINT [FK_Equipments_GWIS_Location_BranchPlant]
GO
ALTER TABLE [dbo].[Equipment]  WITH NOCHECK ADD  CONSTRAINT [FK_Equipments_GWIS_Location_BusinessUnit] FOREIGN KEY([BusinessUnitID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Equipment] NOCHECK CONSTRAINT [FK_Equipments_GWIS_Location_BusinessUnit]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation]  WITH CHECK ADD  CONSTRAINT [fk_EquipmentAdditionalInformation_currencyid] FOREIGN KEY([currencyID])
REFERENCES [dbo].[Currency] ([currencyID])
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] CHECK CONSTRAINT [fk_EquipmentAdditionalInformation_currencyid]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_EquipmentAddtionalInformation_Equipment] FOREIGN KEY([equipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] NOCHECK CONSTRAINT [FK_EquipmentAddtionalInformation_Equipment]
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentAddtionalInformation_EquipmentOwnership] FOREIGN KEY([equipmentOwnershipID])
REFERENCES [dbo].[EquipmentOwnership] ([equipmentOwnershipID])
GO
ALTER TABLE [dbo].[EquipmentAdditionalInformation] CHECK CONSTRAINT [FK_EquipmentAddtionalInformation_EquipmentOwnership]
GO
ALTER TABLE [dbo].[EquipmentHistory]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentHistory_Equipment] FOREIGN KEY([equipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[EquipmentHistory] CHECK CONSTRAINT [FK_EquipmentHistory_Equipment]
GO
ALTER TABLE [dbo].[EquipmentModificationInformation]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentModificationInformation_EquipmentToolPanelCodeVersion] FOREIGN KEY([equipmentToolPanelCodeVersionID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[EquipmentModificationInformation] CHECK CONSTRAINT [FK_EquipmentModificationInformation_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[EquipmentModificationInformationHistory]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentModificationInformationHistory_EquipmentModificationInformation] FOREIGN KEY([EquipmentModificationInformationID])
REFERENCES [dbo].[EquipmentModificationInformation] ([equipmentModificationInformationID])
GO
ALTER TABLE [dbo].[EquipmentModificationInformationHistory] CHECK CONSTRAINT [FK_EquipmentModificationInformationHistory_EquipmentModificationInformation]
GO
ALTER TABLE [dbo].[EquipmentModificationRecords]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentModificationRecords_Equipment] FOREIGN KEY([equipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[EquipmentModificationRecords] CHECK CONSTRAINT [FK_EquipmentModificationRecords_Equipment]
GO
ALTER TABLE [dbo].[EquipmentModificationRecords]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentModificationRecords_EquipmentModificationInformation] FOREIGN KEY([equipmentModificationInformationID])
REFERENCES [dbo].[EquipmentModificationInformation] ([equipmentModificationInformationID])
GO
ALTER TABLE [dbo].[EquipmentModificationRecords] CHECK CONSTRAINT [FK_EquipmentModificationRecords_EquipmentModificationInformation]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenance]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentPendingMaintenance_EquipmentPendingMaintenanceRule] FOREIGN KEY([pendingMaintenanceRuleID])
REFERENCES [dbo].[EquipmentPendingMaintenanceRule] ([equipmentPendingMaintenanceRuleID])
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenance] CHECK CONSTRAINT [FK_EquipmentPendingMaintenance_EquipmentPendingMaintenanceRule]
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceRule]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentPendingMaintenanceRule_EquipmentPendingMaintenanceType] FOREIGN KEY([equipmentPendingMaintenanceTypeID])
REFERENCES [dbo].[EquipmentPendingMaintenanceType] ([equipmentPendingMaintenanceTypeID])
GO
ALTER TABLE [dbo].[EquipmentPendingMaintenanceRule] CHECK CONSTRAINT [FK_EquipmentPendingMaintenanceRule_EquipmentPendingMaintenanceType]
GO
ALTER TABLE [dbo].[EquipmentProduct]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentProduct_EquipmentProductGroup] FOREIGN KEY([equipmentProductGroupID])
REFERENCES [dbo].[EquipmentProductGroup] ([equipmentProductGroupID])
GO
ALTER TABLE [dbo].[EquipmentProduct] CHECK CONSTRAINT [FK_EquipmentProduct_EquipmentProductGroup]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentCategorization] FOREIGN KEY([equipmentCategorizationID])
REFERENCES [dbo].[EquipmentCategorization] ([equipmentCategorizationID])
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] CHECK CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentCategorization]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentClass] FOREIGN KEY([equipmentClassID])
REFERENCES [dbo].[EquipmentClass] ([equipmentClassID])
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] CHECK CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentClass]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentCodeType] FOREIGN KEY([toolCodeID])
REFERENCES [dbo].[EquipmentCodeType] ([equipmentCodeTypeID])
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] CHECK CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentCodeType]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentDivision] FOREIGN KEY([equipmentDivisionID])
REFERENCES [dbo].[EquipmentDivision] ([equipmentDivisionID])
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] CHECK CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentDivision]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentProduct] FOREIGN KEY([equipmentProductID])
REFERENCES [dbo].[EquipmentProduct] ([equipmentProductID])
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] CHECK CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentProduct]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentToolPanelCodeVersionStatus] FOREIGN KEY([equipmentToolPanelCodeVersionStatusID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersionStatus] ([equipmentToolPanelCodeVersionStatusID])
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] CHECK CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentToolPanelCodeVersionStatus]
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentToolPanelType] FOREIGN KEY([toolPanelID])
REFERENCES [dbo].[EquipmentPanelType] ([equipmentPanelTypeID])
GO
ALTER TABLE [dbo].[EquipmentToolPanelCodeVersion] CHECK CONSTRAINT [FK_EquipmentToolPanelCodeVersion_EquipmentToolPanelType]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH CHECK ADD  CONSTRAINT [FK_FailureClassification_FailureCategory] FOREIGN KEY([failureCategoryID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [FK_FailureClassification_FailureCategory]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH CHECK ADD  CONSTRAINT [FK_FailureClassification_FailureItem] FOREIGN KEY([failureItemID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [FK_FailureClassification_FailureItem]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH CHECK ADD  CONSTRAINT [FK_FailureClassification_FailureLossCategory] FOREIGN KEY([failureLossCategoryID])
REFERENCES [dbo].[FailureLossCategory] ([failureLossCategoryID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [FK_FailureClassification_FailureLossCategory]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH CHECK ADD  CONSTRAINT [FK_FailureClassification_FailureMechanism] FOREIGN KEY([failureMechanismID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [FK_FailureClassification_FailureMechanism]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH CHECK ADD  CONSTRAINT [FK_FailureClassification_FailureMechCategory] FOREIGN KEY([failureMechCategoryID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [FK_FailureClassification_FailureMechCategory]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH NOCHECK ADD  CONSTRAINT [LabelForFailureCategory] FOREIGN KEY([failureCategoryID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [LabelForFailureCategory]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH NOCHECK ADD  CONSTRAINT [LabelForFailureItem] FOREIGN KEY([failureItemID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [LabelForFailureItem]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH NOCHECK ADD  CONSTRAINT [LabelForFailureMechanism] FOREIGN KEY([failureMechanismID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [LabelForFailureMechanism]
GO
ALTER TABLE [dbo].[FailureClassification]  WITH NOCHECK ADD  CONSTRAINT [LabelForFailureMechanismCategory] FOREIGN KEY([failureMechCategoryID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureClassification] CHECK CONSTRAINT [LabelForFailureMechanismCategory]
GO
ALTER TABLE [dbo].[FailureEventValue]  WITH CHECK ADD  CONSTRAINT [FK_FailureEventValue_FailureLossCategory] FOREIGN KEY([failureLossCategoryID])
REFERENCES [dbo].[FailureLossCategory] ([failureLossCategoryID])
GO
ALTER TABLE [dbo].[FailureEventValue] CHECK CONSTRAINT [FK_FailureEventValue_FailureLossCategory]
GO
ALTER TABLE [dbo].[FailureEventValue]  WITH CHECK ADD  CONSTRAINT [FK_FailureEventValue_Failures] FOREIGN KEY([failureID])
REFERENCES [dbo].[Failures] ([failureID])
GO
ALTER TABLE [dbo].[FailureEventValue] CHECK CONSTRAINT [FK_FailureEventValue_Failures]
GO
ALTER TABLE [dbo].[FailureEventValue]  WITH CHECK ADD  CONSTRAINT [FK_FailureEventValue_FailureText] FOREIGN KEY([failureTextID])
REFERENCES [dbo].[FailureText] ([failureTextID])
GO
ALTER TABLE [dbo].[FailureEventValue] CHECK CONSTRAINT [FK_FailureEventValue_FailureText]
GO
ALTER TABLE [dbo].[FailureLossCategory]  WITH CHECK ADD  CONSTRAINT [FK_FailureLossCategory_Failure] FOREIGN KEY([failureID])
REFERENCES [dbo].[Failures] ([failureID])
GO
ALTER TABLE [dbo].[FailureLossCategory] CHECK CONSTRAINT [FK_FailureLossCategory_Failure]
GO
ALTER TABLE [dbo].[FailureLossCategory]  WITH CHECK ADD  CONSTRAINT [FK_FailureLossCategory_Label_Category] FOREIGN KEY([lossCategoryID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureLossCategory] CHECK CONSTRAINT [FK_FailureLossCategory_Label_Category]
GO
ALTER TABLE [dbo].[FailureLossCategory]  WITH CHECK ADD  CONSTRAINT [FK_FailureLossCategory_Label_Consequence] FOREIGN KEY([consequencesID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureLossCategory] CHECK CONSTRAINT [FK_FailureLossCategory_Label_Consequence]
GO
ALTER TABLE [dbo].[FailureLossCategory]  WITH CHECK ADD  CONSTRAINT [FK_FailureLossCategory_Label_Event] FOREIGN KEY([eventID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureLossCategory] CHECK CONSTRAINT [FK_FailureLossCategory_Label_Event]
GO
ALTER TABLE [dbo].[FailureLossCategory]  WITH CHECK ADD  CONSTRAINT [FK_FailureLossCategory_Label_Likelihood] FOREIGN KEY([likelihoodID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureLossCategory] CHECK CONSTRAINT [FK_FailureLossCategory_Label_Likelihood]
GO
ALTER TABLE [dbo].[Failures]  WITH NOCHECK ADD  CONSTRAINT [FK_Failures_Employee] FOREIGN KEY([enteredByID])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Failures] CHECK CONSTRAINT [FK_Failures_Employee]
GO
ALTER TABLE [dbo].[Failures]  WITH CHECK ADD  CONSTRAINT [FK_Failures_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
GO
ALTER TABLE [dbo].[Failures] CHECK CONSTRAINT [FK_Failures_Job]
GO
ALTER TABLE [dbo].[FailureTool]  WITH CHECK ADD  CONSTRAINT [FK_FailureTool_FailureLossCategory] FOREIGN KEY([failureLossCategoryID])
REFERENCES [dbo].[FailureLossCategory] ([failureLossCategoryID])
GO
ALTER TABLE [dbo].[FailureTool] CHECK CONSTRAINT [FK_FailureTool_FailureLossCategory]
GO
ALTER TABLE [dbo].[FailureToolV2]  WITH CHECK ADD  CONSTRAINT [FK_FailureToolV2_FailureLossCategory] FOREIGN KEY([failureLossCategoryID])
REFERENCES [dbo].[FailureLossCategory] ([failureLossCategoryID])
GO
ALTER TABLE [dbo].[FailureToolV2] CHECK CONSTRAINT [FK_FailureToolV2_FailureLossCategory]
GO
ALTER TABLE [dbo].[FailureTree]  WITH CHECK ADD  CONSTRAINT [FK_FailureTree_FailureLabel] FOREIGN KEY([failureLabelID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureTree] CHECK CONSTRAINT [FK_FailureTree_FailureLabel]
GO
ALTER TABLE [dbo].[FailureTree]  WITH CHECK ADD  CONSTRAINT [FK_FailureTree_Parent] FOREIGN KEY([parentID])
REFERENCES [dbo].[FailureLabel] ([failureLabelID])
GO
ALTER TABLE [dbo].[FailureTree] CHECK CONSTRAINT [FK_FailureTree_Parent]
GO
ALTER TABLE [dbo].[FailureValue]  WITH CHECK ADD  CONSTRAINT [FK_FailureValue_Failure] FOREIGN KEY([failureID])
REFERENCES [dbo].[Failures] ([failureID])
GO
ALTER TABLE [dbo].[FailureValue] CHECK CONSTRAINT [FK_FailureValue_Failure]
GO
ALTER TABLE [dbo].[FailureValue]  WITH CHECK ADD  CONSTRAINT [FK_FailureValue_FailureLossCategory] FOREIGN KEY([failureLossCategoryID])
REFERENCES [dbo].[FailureLossCategory] ([failureLossCategoryID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FailureValue] CHECK CONSTRAINT [FK_FailureValue_FailureLossCategory]
GO
ALTER TABLE [dbo].[FailureValue]  WITH CHECK ADD  CONSTRAINT [FK_FailureValue_FailureText] FOREIGN KEY([failureTextID])
REFERENCES [dbo].[FailureText] ([failureTextID])
GO
ALTER TABLE [dbo].[FailureValue] CHECK CONSTRAINT [FK_FailureValue_FailureText]
GO
ALTER TABLE [dbo].[FECellAssets]  WITH CHECK ADD  CONSTRAINT [FK_FECellEquipment_FECell] FOREIGN KEY([feCellID])
REFERENCES [dbo].[FECells] ([feCellID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FECellAssets] CHECK CONSTRAINT [FK_FECellEquipment_FECell]
GO
ALTER TABLE [dbo].[FECellCompanies]  WITH CHECK ADD  CONSTRAINT [FK_FECellCompanies_FECell] FOREIGN KEY([feCellID])
REFERENCES [dbo].[FECells] ([feCellID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FECellCompanies] CHECK CONSTRAINT [FK_FECellCompanies_FECell]
GO
ALTER TABLE [dbo].[FECellCrew]  WITH CHECK ADD  CONSTRAINT [FK_FECellCrew_FECell] FOREIGN KEY([feCellID])
REFERENCES [dbo].[FECells] ([feCellID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FECellCrew] CHECK CONSTRAINT [FK_FECellCrew_FECell]
GO
ALTER TABLE [dbo].[FECellCrew]  WITH CHECK ADD  CONSTRAINT [FK_FECellCrew_FECellRoles] FOREIGN KEY([feCellRoleID])
REFERENCES [dbo].[FECellRole] ([feCellRoleID])
GO
ALTER TABLE [dbo].[FECellCrew] CHECK CONSTRAINT [FK_FECellCrew_FECellRoles]
GO
ALTER TABLE [dbo].[FECellRole]  WITH CHECK ADD  CONSTRAINT [FK_FECellRole_FECellRoleType] FOREIGN KEY([feCellRoleTypeID])
REFERENCES [dbo].[FECellRoleType] ([feCellRoleTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FECellRole] CHECK CONSTRAINT [FK_FECellRole_FECellRoleType]
GO
ALTER TABLE [dbo].[FECellServiceSets]  WITH CHECK ADD  CONSTRAINT [FK_FECellServiceSets_FECells] FOREIGN KEY([feCellID])
REFERENCES [dbo].[FECells] ([feCellID])
GO
ALTER TABLE [dbo].[FECellServiceSets] CHECK CONSTRAINT [FK_FECellServiceSets_FECells]
GO
ALTER TABLE [dbo].[FECellServiceSetServices]  WITH CHECK ADD  CONSTRAINT [FK_FECellServiceSetServices_FECellServiceSets] FOREIGN KEY([feCellServiceSetID])
REFERENCES [dbo].[FECellServiceSets] ([feCellServiceSetID])
GO
ALTER TABLE [dbo].[FECellServiceSetServices] CHECK CONSTRAINT [FK_FECellServiceSetServices_FECellServiceSets]
GO
ALTER TABLE [dbo].[FileDownloadLog]  WITH NOCHECK ADD FOREIGN KEY([FileDownloadID])
REFERENCES [dbo].[FileDownload] ([Id])
GO
ALTER TABLE [dbo].[FileDownloadLog]  WITH NOCHECK ADD FOREIGN KEY([ModifiedById])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_AssetAddtionalInformation_GWIS_AssetOwnership] FOREIGN KEY([GWIS_AssetOwnershipID])
REFERENCES [dbo].[GWIS_AssetOwnership] ([GWIS_AssetOwnershipID])
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation] CHECK CONSTRAINT [FK_GWIS_AssetAddtionalInformation_GWIS_AssetOwnership]
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_GWIS_AssetAddtionalInformation_GWIS_Assets] FOREIGN KEY([GWIS_AssetID])
REFERENCES [dbo].[GWIS_Assets] ([GWIS_AssetID])
GO
ALTER TABLE [dbo].[GWIS_AssetAdditionalInformation] NOCHECK CONSTRAINT [FK_GWIS_AssetAddtionalInformation_GWIS_Assets]
GO
ALTER TABLE [dbo].[GWIS_AssetProduct]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_AssetProduct_GWIS_AssetProductGroup] FOREIGN KEY([GWIS_AssetProductGroupID])
REFERENCES [dbo].[GWIS_AssetProductGroup] ([GWIS_AssetProductGroupID])
GO
ALTER TABLE [dbo].[GWIS_AssetProduct] CHECK CONSTRAINT [FK_GWIS_AssetProduct_GWIS_AssetProductGroup]
GO
ALTER TABLE [dbo].[GWIS_Assets]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_Assets_GWIS_AssetStatus] FOREIGN KEY([GWIS_AssetStatusID])
REFERENCES [dbo].[GWIS_AssetStatus] ([GWIS_AssetStatusID])
GO
ALTER TABLE [dbo].[GWIS_Assets] CHECK CONSTRAINT [FK_GWIS_Assets_GWIS_AssetStatus]
GO
ALTER TABLE [dbo].[GWIS_Assets]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_Assets_GWIS_AssetToolPanelCodeVersion] FOREIGN KEY([GWIS_AssetToolPanelCodeVersionID])
REFERENCES [dbo].[GWIS_AssetToolPanelCodeVersion] ([GWIS_AssetToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[GWIS_Assets] CHECK CONSTRAINT [FK_GWIS_Assets_GWIS_AssetToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[GWIS_Assets]  WITH NOCHECK ADD  CONSTRAINT [FK_GWIS_Assets_GWIS_Location_BranchPlant] FOREIGN KEY([branchPlantID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[GWIS_Assets] NOCHECK CONSTRAINT [FK_GWIS_Assets_GWIS_Location_BranchPlant]
GO
ALTER TABLE [dbo].[GWIS_Assets]  WITH NOCHECK ADD  CONSTRAINT [FK_GWIS_Assets_GWIS_Location_BusinessUnit] FOREIGN KEY([businessUnitID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[GWIS_Assets] NOCHECK CONSTRAINT [FK_GWIS_Assets_GWIS_Location_BusinessUnit]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetCategorization] FOREIGN KEY([GWIS_AssetCategorizationID])
REFERENCES [dbo].[GWIS_AssetCategorization] ([GWIS_AssetCategorizationID])
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] CHECK CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetCategorization]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetClass] FOREIGN KEY([GWIS_AssetClassID])
REFERENCES [dbo].[GWIS_AssetClass] ([GWIS_AssetClassID])
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] CHECK CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetClass]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetDivision] FOREIGN KEY([GWIS_AssetDivisionID])
REFERENCES [dbo].[GWIS_AssetDivision] ([GWIS_AssetDivisionID])
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] CHECK CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetDivision]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetProduct] FOREIGN KEY([GWIS_AssetProductID])
REFERENCES [dbo].[GWIS_AssetProduct] ([GWIS_AssetProductID])
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] CHECK CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetProduct]
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetToolPanelCodeVersionStatus] FOREIGN KEY([GWIS_AssetToolPanelCodeVersionStatusID])
REFERENCES [dbo].[GWIS_AssetToolPanelCodeVersionStatus] ([GWIS_AssetToolPanelCodeVersionStatusID])
GO
ALTER TABLE [dbo].[GWIS_AssetToolPanelCodeVersion] CHECK CONSTRAINT [FK_GWIS_AssetToolPanelCodeVersion_GWIS_AssetToolPanelCodeVersionStatus]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributeMatrix]  WITH CHECK ADD  CONSTRAINT [FK_GWIS_LocationAttributeMatrix_GWIS_LocationAttributeValue] FOREIGN KEY([GWIS_LocationAttributeValueID])
REFERENCES [dbo].[GWIS_LocationAttributeValue] ([GWIS_LocationAttributeValueID])
GO
ALTER TABLE [dbo].[GWIS_LocationAttributeMatrix] CHECK CONSTRAINT [FK_GWIS_LocationAttributeMatrix_GWIS_LocationAttributeValue]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributeMatrix]  WITH CHECK ADD  CONSTRAINT [FK_LocationAttributeMatrix_LocationAttributeID] FOREIGN KEY([GWIS_LocationAttributeID])
REFERENCES [dbo].[GWIS_LocationAttributes] ([GWIS_LocationAttributeID])
GO
ALTER TABLE [dbo].[GWIS_LocationAttributeMatrix] CHECK CONSTRAINT [FK_LocationAttributeMatrix_LocationAttributeID]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes]  WITH CHECK ADD  CONSTRAINT [FK_LocationAttributes_LocationAttributeValue] FOREIGN KEY([GWIS_LocationAttributeValueID])
REFERENCES [dbo].[GWIS_LocationAttributeValue] ([GWIS_LocationAttributeValueID])
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes] CHECK CONSTRAINT [FK_LocationAttributes_LocationAttributeValue]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes]  WITH CHECK ADD  CONSTRAINT [FK_LocationAttributes_LocationID] FOREIGN KEY([GWIS_LocationID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes] CHECK CONSTRAINT [FK_LocationAttributes_LocationID]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes]  WITH CHECK ADD  CONSTRAINT [FK_LocationAttributes_LocationRelationType] FOREIGN KEY([GWIS_LocationRelationTypeID])
REFERENCES [dbo].[GWIS_LocationRelationType] ([GWIS_LocationRelationTypeID])
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes] CHECK CONSTRAINT [FK_LocationAttributes_LocationRelationType]
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes]  WITH CHECK ADD  CONSTRAINT [FK_LocationAttributes_parentLocation] FOREIGN KEY([ParentGWIS_LocationID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[GWIS_LocationAttributes] CHECK CONSTRAINT [FK_LocationAttributes_parentLocation]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD FOREIGN KEY([JobMarketSegmentTypeId])
REFERENCES [dbo].[JobMarketSegmentType] ([jobMarketSegmentTypeID])
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_AcquisitionSoftware] FOREIGN KEY([acquisitionSoftwareId])
REFERENCES [dbo].[AcquisitionSoftware] ([acquisitionSoftwareId])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_AcquisitionSoftware]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_AcquisitionSystem] FOREIGN KEY([acquisitionSystemId])
REFERENCES [dbo].[AcquisitionSystem] ([acquisitionSystemId])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_AcquisitionSystem]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_CurrencyRate] FOREIGN KEY([currencyRateID])
REFERENCES [dbo].[CurrencyRate] ([currencyRateID])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_CurrencyRate]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_JobCancelledReasons] FOREIGN KEY([jobCancelledReasonID])
REFERENCES [dbo].[JobCancelledReasons] ([jobCancelledReasonID])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_JobCancelledReasons]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_JobStatus] FOREIGN KEY([jobStatusID])
REFERENCES [dbo].[JobStatus] ([jobStatusID])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_JobStatus]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_RentalChargeTypes] FOREIGN KEY([rentalChargeTypeID])
REFERENCES [dbo].[RentalChargeTypes] ([rentalChargeTypeID])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_RentalChargeTypes]
GO
ALTER TABLE [dbo].[JobActualServices]  WITH CHECK ADD  CONSTRAINT [FK_JobActualServices_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobActualServices] CHECK CONSTRAINT [FK_JobActualServices_Job]
GO
ALTER TABLE [dbo].[JobActualServices]  WITH NOCHECK ADD  CONSTRAINT [FK_JobActualServices_JobOperationTools] FOREIGN KEY([jobOperationToolID])
REFERENCES [dbo].[JobOperationTools] ([jobOperationToolID])
GO
ALTER TABLE [dbo].[JobActualServices] NOCHECK CONSTRAINT [FK_JobActualServices_JobOperationTools]
GO
ALTER TABLE [dbo].[JobAdditionalCharges]  WITH CHECK ADD  CONSTRAINT [FK_JobAdditionalCharges_Job] FOREIGN KEY([jobId])
REFERENCES [dbo].[Job] ([jobID])
GO
ALTER TABLE [dbo].[JobAdditionalCharges] CHECK CONSTRAINT [FK_JobAdditionalCharges_Job]
GO
ALTER TABLE [dbo].[JobAssets]  WITH CHECK ADD  CONSTRAINT [FK_JobAssets_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobAssets] CHECK CONSTRAINT [FK_JobAssets_Job]
GO
ALTER TABLE [dbo].[JobAudit]  WITH CHECK ADD FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
GO
ALTER TABLE [dbo].[JobBonus]  WITH CHECK ADD  CONSTRAINT [FK_JobBonus_JobBonusStatus] FOREIGN KEY([jobBonusStatusID])
REFERENCES [dbo].[JobBonusStatus] ([jobBonusStatusID])
GO
ALTER TABLE [dbo].[JobBonus] CHECK CONSTRAINT [FK_JobBonus_JobBonusStatus]
GO
ALTER TABLE [dbo].[JobBonus]  WITH CHECK ADD  CONSTRAINT [FK_JobBonus_JobBonusType] FOREIGN KEY([jobBonusTypeID])
REFERENCES [dbo].[JobBonusType] ([jobBonusTypeID])
GO
ALTER TABLE [dbo].[JobBonus] CHECK CONSTRAINT [FK_JobBonus_JobBonusType]
GO
ALTER TABLE [dbo].[JobBonus]  WITH CHECK ADD  CONSTRAINT [FK_JobBonus_JobCrew] FOREIGN KEY([jobCrewID])
REFERENCES [dbo].[JobCrew] ([jobCrewID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobBonus] CHECK CONSTRAINT [FK_JobBonus_JobCrew]
GO
ALTER TABLE [dbo].[JobBonusData]  WITH CHECK ADD  CONSTRAINT [FK_JobBonusData_JobActualServices] FOREIGN KEY([jobActualServiceID])
REFERENCES [dbo].[JobActualServices] ([jobActualServiceID])
GO
ALTER TABLE [dbo].[JobBonusData] CHECK CONSTRAINT [FK_JobBonusData_JobActualServices]
GO
ALTER TABLE [dbo].[JobBonusData]  WITH CHECK ADD  CONSTRAINT [FK_JobBonusData_JobBonus] FOREIGN KEY([jobBonusID])
REFERENCES [dbo].[JobBonus] ([jobBonusID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobBonusData] CHECK CONSTRAINT [FK_JobBonusData_JobBonus]
GO
ALTER TABLE [dbo].[JobBonusExceptionData]  WITH NOCHECK ADD  CONSTRAINT [FK_JobBonusExceptionData_JobBonus] FOREIGN KEY([jobBonusID])
REFERENCES [dbo].[JobBonus] ([jobBonusID])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[JobBonusExceptionData] NOCHECK CONSTRAINT [FK_JobBonusExceptionData_JobBonus]
GO
ALTER TABLE [dbo].[JobBonusExceptionLog]  WITH CHECK ADD  CONSTRAINT [FK_JobBonusExceptionLog_JobBonusExceptionData] FOREIGN KEY([jobBonusExceptionDataID])
REFERENCES [dbo].[JobBonusExceptionData] ([jobBonusExceptionDataID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobBonusExceptionLog] CHECK CONSTRAINT [FK_JobBonusExceptionLog_JobBonusExceptionData]
GO
ALTER TABLE [dbo].[JobBonusFlatRateData]  WITH NOCHECK ADD  CONSTRAINT [FK_JobBonusFlatRateData_JobBonus] FOREIGN KEY([jobBonusID])
REFERENCES [dbo].[JobBonus] ([jobBonusID])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[JobBonusFlatRateData] NOCHECK CONSTRAINT [FK_JobBonusFlatRateData_JobBonus]
GO
ALTER TABLE [dbo].[JobBonusFlatRateLog]  WITH CHECK ADD  CONSTRAINT [FK_JobBonusFlatRateLog_JobBonusFlatRateData] FOREIGN KEY([jobBonusFlatRateDataID])
REFERENCES [dbo].[JobBonusFlatRateData] ([jobBonusFlatRateDataID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobBonusFlatRateLog] CHECK CONSTRAINT [FK_JobBonusFlatRateLog_JobBonusFlatRateData]
GO
ALTER TABLE [dbo].[JobBonusJobPositionDefaultPercentages]  WITH CHECK ADD  CONSTRAINT [FK_JobBonusJobPositionDefaultPercentages_EconnectCountryCodes] FOREIGN KEY([countryCode])
REFERENCES [dbo].[EconnectCountryCodes] ([countryCode])
GO
ALTER TABLE [dbo].[JobBonusJobPositionDefaultPercentages] CHECK CONSTRAINT [FK_JobBonusJobPositionDefaultPercentages_EconnectCountryCodes]
GO
ALTER TABLE [dbo].[JobBonusJobPositionDefaultPercentages]  WITH CHECK ADD  CONSTRAINT [FK_JobBonusJobPositionDefaultPercentages_EconnectJobCodes] FOREIGN KEY([econnectJobCode])
REFERENCES [dbo].[EconnectJobCodes] ([econnectJobCode])
GO
ALTER TABLE [dbo].[JobBonusJobPositionDefaultPercentages] CHECK CONSTRAINT [FK_JobBonusJobPositionDefaultPercentages_EconnectJobCodes]
GO
ALTER TABLE [dbo].[JobBonusPersonnelData]  WITH CHECK ADD  CONSTRAINT [FK_JobBonusPersonnelData_JobBonusType] FOREIGN KEY([jobBonusTypeID])
REFERENCES [dbo].[JobBonusType] ([jobBonusTypeID])
GO
ALTER TABLE [dbo].[JobBonusPersonnelData] CHECK CONSTRAINT [FK_JobBonusPersonnelData_JobBonusType]
GO
ALTER TABLE [dbo].[JobBonusStatusLog]  WITH CHECK ADD  CONSTRAINT [FK_JobBonusStatusLog_JobBonus] FOREIGN KEY([jobBonusID])
REFERENCES [dbo].[JobBonus] ([jobBonusID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobBonusStatusLog] CHECK CONSTRAINT [FK_JobBonusStatusLog_JobBonus]
GO
ALTER TABLE [dbo].[JobCharges]  WITH CHECK ADD  CONSTRAINT [FK_JobCharges_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobCharges] CHECK CONSTRAINT [FK_JobCharges_Job]
GO
ALTER TABLE [dbo].[JobCharges]  WITH CHECK ADD  CONSTRAINT [FK_JobCharges_JobActualServices] FOREIGN KEY([jobActualServiceID])
REFERENCES [dbo].[JobActualServices] ([jobActualServiceID])
GO
ALTER TABLE [dbo].[JobCharges] CHECK CONSTRAINT [FK_JobCharges_JobActualServices]
GO
ALTER TABLE [dbo].[JobCharges]  WITH CHECK ADD  CONSTRAINT [FK_JobCharges_JobOperations] FOREIGN KEY([jobOperationID])
REFERENCES [dbo].[JobOperations] ([jobOperationID])
GO
ALTER TABLE [dbo].[JobCharges] CHECK CONSTRAINT [FK_JobCharges_JobOperations]
GO
ALTER TABLE [dbo].[JobCharges]  WITH CHECK ADD  CONSTRAINT [FK_JobCharges_PricingStyle] FOREIGN KEY([pricingStyleID])
REFERENCES [dbo].[PricingStyle] ([id])
GO
ALTER TABLE [dbo].[JobCharges] CHECK CONSTRAINT [FK_JobCharges_PricingStyle]
GO
ALTER TABLE [dbo].[JobCharges]  WITH CHECK ADD  CONSTRAINT [FK_JobCharges_ServiceDetails] FOREIGN KEY([serviceDetailID])
REFERENCES [dbo].[ServiceDetails] ([id])
GO
ALTER TABLE [dbo].[JobCharges] CHECK CONSTRAINT [FK_JobCharges_ServiceDetails]
GO
ALTER TABLE [dbo].[JobCompanyEDIFieldData]  WITH CHECK ADD  CONSTRAINT [FK_JobCompanyEDIFieldID_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobCompanyEDIFieldData] CHECK CONSTRAINT [FK_JobCompanyEDIFieldID_Job]
GO
ALTER TABLE [dbo].[JobContacts]  WITH CHECK ADD  CONSTRAINT [FK_JobContacts_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobContacts] CHECK CONSTRAINT [FK_JobContacts_Job]
GO
ALTER TABLE [dbo].[JobContacts]  WITH CHECK ADD  CONSTRAINT [FK_JobContacts_People] FOREIGN KEY([personID])
REFERENCES [dbo].[People] ([personID])
GO
ALTER TABLE [dbo].[JobContacts] CHECK CONSTRAINT [FK_JobContacts_People]
GO
ALTER TABLE [dbo].[JobCrew]  WITH CHECK ADD  CONSTRAINT [FK_JobCrew_FECellRole] FOREIGN KEY([feCellRoleID])
REFERENCES [dbo].[FECellRole] ([feCellRoleID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobCrew] CHECK CONSTRAINT [FK_JobCrew_FECellRole]
GO
ALTER TABLE [dbo].[JobCrew]  WITH CHECK ADD  CONSTRAINT [FK_JobCrew_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobCrew] CHECK CONSTRAINT [FK_JobCrew_Job]
GO
ALTER TABLE [dbo].[JobCustomerCounts]  WITH CHECK ADD  CONSTRAINT [FK_JobCustomerCounts_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobCustomerCounts] CHECK CONSTRAINT [FK_JobCustomerCounts_Job]
GO
ALTER TABLE [dbo].[JobInvoice]  WITH CHECK ADD  CONSTRAINT [FK_JobInvoice_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobInvoice] CHECK CONSTRAINT [FK_JobInvoice_Job]
GO
ALTER TABLE [dbo].[JobInvoice]  WITH CHECK ADD  CONSTRAINT [FK_JobInvoice_JobInvoice] FOREIGN KEY([type])
REFERENCES [dbo].[JobInvoiceType] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobInvoice] CHECK CONSTRAINT [FK_JobInvoice_JobInvoice]
GO
ALTER TABLE [dbo].[JobInvoiceAdjustment]  WITH CHECK ADD  CONSTRAINT [FK_JobInvoiceAdjustment_JobInvoice] FOREIGN KEY([invoiceId])
REFERENCES [dbo].[JobInvoice] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobInvoiceAdjustment] CHECK CONSTRAINT [FK_JobInvoiceAdjustment_JobInvoice]
GO
ALTER TABLE [dbo].[JobInvoiceAdjustment]  WITH CHECK ADD  CONSTRAINT [FK_JobInvoiceAdjustment_JobInvoiceAdjustmentType] FOREIGN KEY([adjustmentType])
REFERENCES [dbo].[JobInvoiceAdjustmentType] ([id])
GO
ALTER TABLE [dbo].[JobInvoiceAdjustment] CHECK CONSTRAINT [FK_JobInvoiceAdjustment_JobInvoiceAdjustmentType]
GO
ALTER TABLE [dbo].[JobInvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_JobInvoiceItem_JobInvoice] FOREIGN KEY([invoiceId])
REFERENCES [dbo].[JobInvoice] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobInvoiceItem] CHECK CONSTRAINT [FK_JobInvoiceItem_JobInvoice]
GO
ALTER TABLE [dbo].[JobKOCDetails]  WITH CHECK ADD  CONSTRAINT [FK_JobKOCDetails_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
GO
ALTER TABLE [dbo].[JobKOCDetails] CHECK CONSTRAINT [FK_JobKOCDetails_Job]
GO
ALTER TABLE [dbo].[JobLock]  WITH CHECK ADD  CONSTRAINT [FK_JobLock_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[JobLock] CHECK CONSTRAINT [FK_JobLock_EmployeeId]
GO
ALTER TABLE [dbo].[JobLock]  WITH CHECK ADD  CONSTRAINT [FK_JobLock_JobId] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([jobID])
GO
ALTER TABLE [dbo].[JobLock] CHECK CONSTRAINT [FK_JobLock_JobId]
GO
ALTER TABLE [dbo].[JobNote]  WITH CHECK ADD  CONSTRAINT [FK_JobNote_Employee] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employee] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobNote] CHECK CONSTRAINT [FK_JobNote_Employee]
GO
ALTER TABLE [dbo].[JobNote]  WITH CHECK ADD  CONSTRAINT [FK_JobNote_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobNote] CHECK CONSTRAINT [FK_JobNote_Job]
GO
ALTER TABLE [dbo].[JobOperationAuxData]  WITH CHECK ADD  CONSTRAINT [FK_JobOperationAuxData_JobOperations] FOREIGN KEY([jobOperationID])
REFERENCES [dbo].[JobOperations] ([jobOperationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobOperationAuxData] CHECK CONSTRAINT [FK_JobOperationAuxData_JobOperations]
GO
ALTER TABLE [dbo].[JobOperationBranchPlantEditors]  WITH CHECK ADD FOREIGN KEY([BranchPlantId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[JobOperationEventAuxData]  WITH CHECK ADD  CONSTRAINT [FK_JobOperationEventAuxData_JobOperationEvents] FOREIGN KEY([jobOperationEventID])
REFERENCES [dbo].[JobOperationEvents] ([jobOperationEventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobOperationEventAuxData] CHECK CONSTRAINT [FK_JobOperationEventAuxData_JobOperationEvents]
GO
ALTER TABLE [dbo].[JobOperationEventIntervalCharge]  WITH CHECK ADD  CONSTRAINT [FK_JobOperationEventCharge_JobOperationEventIntervals] FOREIGN KEY([EventIntervalId])
REFERENCES [dbo].[JobOperationEventIntervals] ([jobOperationEventIntervalID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobOperationEventIntervalCharge] CHECK CONSTRAINT [FK_JobOperationEventCharge_JobOperationEventIntervals]
GO
ALTER TABLE [dbo].[JobOperationEventIntervals]  WITH NOCHECK ADD  CONSTRAINT [FK_JobOperationEventIntervals_JobOperationEvents] FOREIGN KEY([jobOperationEventID])
REFERENCES [dbo].[JobOperationEvents] ([jobOperationEventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobOperationEventIntervals] NOCHECK CONSTRAINT [FK_JobOperationEventIntervals_JobOperationEvents]
GO
ALTER TABLE [dbo].[JobOperationEventIntervals]  WITH NOCHECK ADD  CONSTRAINT [FK_JobOperationEventIntervals_JobSelectedServicePerforatingDispatchDetails] FOREIGN KEY([jobSelectedServicePerforatingDispatchDetailsID])
REFERENCES [dbo].[JobSelectedServicePerforatingDispatchDetails] ([jobSelectedServicePerforatingDispatchDetailsID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobOperationEventIntervals] NOCHECK CONSTRAINT [FK_JobOperationEventIntervals_JobSelectedServicePerforatingDispatchDetails]
GO
ALTER TABLE [dbo].[JobOperationEvents]  WITH CHECK ADD  CONSTRAINT [FK_JobOperationEvents_JobOperations] FOREIGN KEY([jobOperationID])
REFERENCES [dbo].[JobOperations] ([jobOperationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobOperationEvents] CHECK CONSTRAINT [FK_JobOperationEvents_JobOperations]
GO
ALTER TABLE [dbo].[JobOperations]  WITH CHECK ADD  CONSTRAINT [FK_JobOperations_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobOperations] CHECK CONSTRAINT [FK_JobOperations_Job]
GO
ALTER TABLE [dbo].[JobOperations]  WITH CHECK ADD  CONSTRAINT [FK_JobOperations_JobOperationTypes] FOREIGN KEY([jobOperationTypeID])
REFERENCES [dbo].[JobOperationTypes] ([jobOperationTypeID])
GO
ALTER TABLE [dbo].[JobOperations] CHECK CONSTRAINT [FK_JobOperations_JobOperationTypes]
GO
ALTER TABLE [dbo].[JobOperationsCharge]  WITH CHECK ADD  CONSTRAINT [FK_JobOperationsCharge_JobOperations] FOREIGN KEY([JobOperationId])
REFERENCES [dbo].[JobOperations] ([jobOperationID])
GO
ALTER TABLE [dbo].[JobOperationsCharge] CHECK CONSTRAINT [FK_JobOperationsCharge_JobOperations]
GO
ALTER TABLE [dbo].[JobOperationTools]  WITH CHECK ADD  CONSTRAINT [FK_JobOperationTools_JobOperations] FOREIGN KEY([jobOperationID])
REFERENCES [dbo].[JobOperations] ([jobOperationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobOperationTools] CHECK CONSTRAINT [FK_JobOperationTools_JobOperations]
GO
ALTER TABLE [dbo].[JobOperationTypes]  WITH CHECK ADD  CONSTRAINT [FK_JobOperationTypes_JobTicketJobOperationCategory] FOREIGN KEY([jobTicketJobOperationCategoryID])
REFERENCES [dbo].[JobTicketJobOperationCategory] ([jobTicketJobOperationCategoryID])
GO
ALTER TABLE [dbo].[JobOperationTypes] CHECK CONSTRAINT [FK_JobOperationTypes_JobTicketJobOperationCategory]
GO
ALTER TABLE [dbo].[JobPrintConfigurationSections]  WITH CHECK ADD  CONSTRAINT [FK_JobPrintConfigurationSections_JobPrintConfiguration] FOREIGN KEY([jobPrintConfigurationID])
REFERENCES [dbo].[JobPrintConfiguration] ([jobPrintConfigurationID])
GO
ALTER TABLE [dbo].[JobPrintConfigurationSections] CHECK CONSTRAINT [FK_JobPrintConfigurationSections_JobPrintConfiguration]
GO
ALTER TABLE [dbo].[JobPrintConfigurationSections]  WITH CHECK ADD  CONSTRAINT [FK_JobPrintConfigurationSections_JobPrintSections] FOREIGN KEY([jobPrintSectionID])
REFERENCES [dbo].[JobPrintSections] ([jobPrintSectionID])
GO
ALTER TABLE [dbo].[JobPrintConfigurationSections] CHECK CONSTRAINT [FK_JobPrintConfigurationSections_JobPrintSections]
GO
ALTER TABLE [dbo].[JobReview]  WITH CHECK ADD  CONSTRAINT [FK_JobReview_Employee] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[JobReview] CHECK CONSTRAINT [FK_JobReview_Employee]
GO
ALTER TABLE [dbo].[JobReview]  WITH CHECK ADD  CONSTRAINT [FK_JobReview_FECellRole] FOREIGN KEY([feCellRoleID])
REFERENCES [dbo].[FECellRole] ([feCellRoleID])
GO
ALTER TABLE [dbo].[JobReview] CHECK CONSTRAINT [FK_JobReview_FECellRole]
GO
ALTER TABLE [dbo].[JobReview]  WITH CHECK ADD  CONSTRAINT [FK_JobReview_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
GO
ALTER TABLE [dbo].[JobReview] CHECK CONSTRAINT [FK_JobReview_Job]
GO
ALTER TABLE [dbo].[JobRoles]  WITH CHECK ADD  CONSTRAINT [FK_JobRoles_FECellRole] FOREIGN KEY([FeCellRoleId])
REFERENCES [dbo].[FECellRole] ([feCellRoleID])
GO
ALTER TABLE [dbo].[JobRoles] CHECK CONSTRAINT [FK_JobRoles_FECellRole]
GO
ALTER TABLE [dbo].[JobRoles]  WITH CHECK ADD  CONSTRAINT [FK_JobRoles_GWIS_LocationAttributes] FOREIGN KEY([Gwis_LocationAttributeId])
REFERENCES [dbo].[GWIS_LocationAttributes] ([GWIS_LocationAttributeID])
GO
ALTER TABLE [dbo].[JobRoles] CHECK CONSTRAINT [FK_JobRoles_GWIS_LocationAttributes]
GO
ALTER TABLE [dbo].[JobSchedulingLog]  WITH CHECK ADD  CONSTRAINT [FK_JobSchedulingLog_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobSchedulingLog] CHECK CONSTRAINT [FK_JobSchedulingLog_Job]
GO
ALTER TABLE [dbo].[JobSelectedServiceAssureConveyanceDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_JobSelectedServiceAssureConveyance_JobSelectedServiceDispatchDetails] FOREIGN KEY([jobSelectedServiceDispatchDetailID])
REFERENCES [dbo].[JobSelectedServiceDispatchDetails] ([jobSelectedServiceDispatchDetailID])
GO
ALTER TABLE [dbo].[JobSelectedServiceAssureConveyanceDetails] CHECK CONSTRAINT [FK_JobSelectedServiceAssureConveyance_JobSelectedServiceDispatchDetails]
GO
ALTER TABLE [dbo].[JobSelectedServiceDispatchDetails]  WITH CHECK ADD  CONSTRAINT [FK_JobSelectedServiceDispatchDetails_JobSelectedServices] FOREIGN KEY([jobSelectedServiceID])
REFERENCES [dbo].[JobSelectedServices] ([jobSelectedServiceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobSelectedServiceDispatchDetails] CHECK CONSTRAINT [FK_JobSelectedServiceDispatchDetails_JobSelectedServices]
GO
ALTER TABLE [dbo].[JobSelectedServices]  WITH CHECK ADD  CONSTRAINT [FK_JobSelectedServices_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobSelectedServices] CHECK CONSTRAINT [FK_JobSelectedServices_Job]
GO
ALTER TABLE [dbo].[JobSnapshot]  WITH CHECK ADD  CONSTRAINT [FK_JobNSnapshot_Employee] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[JobSnapshot] CHECK CONSTRAINT [FK_JobNSnapshot_Employee]
GO
ALTER TABLE [dbo].[JobSnapshot]  WITH CHECK ADD  CONSTRAINT [FK_JobSnapshot_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
GO
ALTER TABLE [dbo].[JobSnapshot] CHECK CONSTRAINT [FK_JobSnapshot_Job]
GO
ALTER TABLE [dbo].[JobStatusLog]  WITH CHECK ADD  CONSTRAINT [FK_JobStatusLog_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobStatusLog] CHECK CONSTRAINT [FK_JobStatusLog_Job]
GO
ALTER TABLE [dbo].[JobSuperUsers]  WITH CHECK ADD  CONSTRAINT [FK_JobSuperUsers_Employee] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[JobSuperUsers] CHECK CONSTRAINT [FK_JobSuperUsers_Employee]
GO
ALTER TABLE [dbo].[JobWellBoreholeProfile]  WITH CHECK ADD  CONSTRAINT [FK_JobWellBoreholeProfile_BitSize] FOREIGN KEY([bitSizeID])
REFERENCES [dbo].[BitSizes] ([bitSizeID])
GO
ALTER TABLE [dbo].[JobWellBoreholeProfile] CHECK CONSTRAINT [FK_JobWellBoreholeProfile_BitSize]
GO
ALTER TABLE [dbo].[JobWellBoreholeProfile]  WITH CHECK ADD  CONSTRAINT [FK_JobWellBoreholeProfile_JobWells] FOREIGN KEY([jobWellID])
REFERENCES [dbo].[JobWells] ([jobWellID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobWellBoreholeProfile] CHECK CONSTRAINT [FK_JobWellBoreholeProfile_JobWells]
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile]  WITH CHECK ADD  CONSTRAINT [FK_JobWellCasingTubingProfile_CasingDimensions] FOREIGN KEY([casingDimensionID])
REFERENCES [dbo].[CasingDimensions] ([casingDimensionID])
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile] CHECK CONSTRAINT [FK_JobWellCasingTubingProfile_CasingDimensions]
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile]  WITH CHECK ADD  CONSTRAINT [FK_JobWellCasingTubingProfile_CasingType] FOREIGN KEY([casingTypeID])
REFERENCES [dbo].[CasingType] ([casingTypeID])
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile] CHECK CONSTRAINT [FK_JobWellCasingTubingProfile_CasingType]
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile]  WITH CHECK ADD  CONSTRAINT [FK_JobWellCasingTubingProfile_JobWellCasingTubingProfile] FOREIGN KEY([jobWellID])
REFERENCES [dbo].[JobWells] ([jobWellID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobWellCasingTubingProfile] CHECK CONSTRAINT [FK_JobWellCasingTubingProfile_JobWellCasingTubingProfile]
GO
ALTER TABLE [dbo].[JobWells]  WITH CHECK ADD  CONSTRAINT [FK_JobWells_AcquisitionType] FOREIGN KEY([acquisitionTypeID])
REFERENCES [dbo].[AcquisitionType] ([acquisitionTypeID])
GO
ALTER TABLE [dbo].[JobWells] CHECK CONSTRAINT [FK_JobWells_AcquisitionType]
GO
ALTER TABLE [dbo].[JobWells]  WITH CHECK ADD  CONSTRAINT [FK_JobWells_ConveyanceSubType] FOREIGN KEY([conveyanceSubTypeID])
REFERENCES [dbo].[ConveyanceSubType] ([conveyanceSubTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobWells] CHECK CONSTRAINT [FK_JobWells_ConveyanceSubType]
GO
ALTER TABLE [dbo].[JobWells]  WITH CHECK ADD  CONSTRAINT [FK_JobWells_ConveyanceType] FOREIGN KEY([conveyanceTypeID])
REFERENCES [dbo].[ConveyanceType] ([conveyanceTypeID])
GO
ALTER TABLE [dbo].[JobWells] CHECK CONSTRAINT [FK_JobWells_ConveyanceType]
GO
ALTER TABLE [dbo].[JobWells]  WITH CHECK ADD  CONSTRAINT [FK_JobWells_DrillingFluidType] FOREIGN KEY([drillingFluidTypeID])
REFERENCES [dbo].[DrillingFluidType] ([drillingFluidTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobWells] CHECK CONSTRAINT [FK_JobWells_DrillingFluidType]
GO
ALTER TABLE [dbo].[JobWells]  WITH NOCHECK ADD  CONSTRAINT [FK_JobWells_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobWells] NOCHECK CONSTRAINT [FK_JobWells_Job]
GO
ALTER TABLE [dbo].[JobWells]  WITH CHECK ADD  CONSTRAINT [FK_JobWells_RigType] FOREIGN KEY([rigTypeID])
REFERENCES [dbo].[RigType] ([rigTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobWells] CHECK CONSTRAINT [FK_JobWells_RigType]
GO
ALTER TABLE [dbo].[JobWells]  WITH CHECK ADD  CONSTRAINT [FK_JobWells_WellLocationType] FOREIGN KEY([wellLocationTypeID])
REFERENCES [dbo].[WellLocationType] ([wellLocationTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobWells] CHECK CONSTRAINT [FK_JobWells_WellLocationType]
GO
ALTER TABLE [dbo].[Location_Attribute_Values]  WITH CHECK ADD  CONSTRAINT [FK_Location_Values_Type] FOREIGN KEY([type])
REFERENCES [dbo].[Location_Attribute_Types] ([id])
GO
ALTER TABLE [dbo].[Location_Attribute_Values] CHECK CONSTRAINT [FK_Location_Values_Type]
GO
ALTER TABLE [dbo].[Location_Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Location_Attributes_Location_Attribute_Values] FOREIGN KEY([value_id])
REFERENCES [dbo].[Location_Attribute_Values] ([id])
GO
ALTER TABLE [dbo].[Location_Attributes] CHECK CONSTRAINT [FK_Location_Attributes_Location_Attribute_Values]
GO
ALTER TABLE [dbo].[Location_Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Location_Attributes_Location1] FOREIGN KEY([location_id])
REFERENCES [dbo].[Location] ([id])
GO
ALTER TABLE [dbo].[Location_Attributes] CHECK CONSTRAINT [FK_Location_Attributes_Location1]
GO
ALTER TABLE [dbo].[LocationLog]  WITH CHECK ADD  CONSTRAINT [fk_LocationLog_GWIS_LocationAttributeID] FOREIGN KEY([GWIS_LocationAttributeID])
REFERENCES [dbo].[GWIS_LocationAttributes] ([GWIS_LocationAttributeID])
GO
ALTER TABLE [dbo].[LocationLog] CHECK CONSTRAINT [fk_LocationLog_GWIS_LocationAttributeID]
GO
ALTER TABLE [dbo].[LocationLog]  WITH CHECK ADD  CONSTRAINT [fk_LocationLog_modifiedBy] FOREIGN KEY([modifiedBy])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[LocationLog] CHECK CONSTRAINT [fk_LocationLog_modifiedBy]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCR_CurrencyRateId] FOREIGN KEY([CurrencyRateId])
REFERENCES [dbo].[CurrencyRate] ([currencyRateID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [FK_MaintenanceRequestCR_CurrencyRateId]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [fk_MaintenanceRequestCR_employee] FOREIGN KEY([Requester])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [fk_MaintenanceRequestCR_employee]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [fk_MaintenanceRequestCR_employee2] FOREIGN KEY([DistrictManager])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [fk_MaintenanceRequestCR_employee2]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [fk_MaintenanceRequestCR_employee3] FOREIGN KEY([Approver])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [fk_MaintenanceRequestCR_employee3]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCR_EmployeeTechnologist] FOREIGN KEY([Technologist])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [FK_MaintenanceRequestCR_EmployeeTechnologist]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [fk_MaintenanceRequestCR_EquipmentID] FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [fk_MaintenanceRequestCR_EquipmentID]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCR_GWIS_BranchPlant] FOREIGN KEY([BranchPlantId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [FK_MaintenanceRequestCR_GWIS_BranchPlant]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCR_GWIS_BusinessUnit] FOREIGN KEY([BusinessUnitId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [FK_MaintenanceRequestCR_GWIS_BusinessUnit]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH NOCHECK ADD  CONSTRAINT [FK_MaintenanceRequestCR_MaintenanceRequestCRVendors] FOREIGN KEY([Vendor])
REFERENCES [dbo].[MaintenanceRequestCRVendors] ([Id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [FK_MaintenanceRequestCR_MaintenanceRequestCRVendors]
GO
ALTER TABLE [dbo].[MaintenanceRequestCR]  WITH CHECK ADD  CONSTRAINT [fk_MaintenanceRequestCR_MRStatus] FOREIGN KEY([MRStatus])
REFERENCES [dbo].[MaintenanceRequestCR_Status] ([ID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCR] CHECK CONSTRAINT [fk_MaintenanceRequestCR_MRStatus]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRComments]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRComments_Employee] FOREIGN KEY([InsertById])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRComments] CHECK CONSTRAINT [FK_MaintenanceRequestCRComments_Employee]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRComments]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRComments_MaintenanceRequestCR] FOREIGN KEY([MrId])
REFERENCES [dbo].[MaintenanceRequestCR] ([ID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRComments] CHECK CONSTRAINT [FK_MaintenanceRequestCRComments_MaintenanceRequestCR]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRCommentsLog]  WITH NOCHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRCommentsLog_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRCommentsLog] CHECK CONSTRAINT [FK_MaintenanceRequestCRCommentsLog_Employee]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRCommentsLog]  WITH NOCHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRCommentsLog_MaintenanceRequestCRComments] FOREIGN KEY([CommentId])
REFERENCES [dbo].[MaintenanceRequestCRComments] ([Id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRCommentsLog] CHECK CONSTRAINT [FK_MaintenanceRequestCRCommentsLog_MaintenanceRequestCRComments]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRFile]  WITH NOCHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRFile_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRFile] CHECK CONSTRAINT [FK_MaintenanceRequestCRFile_Employee]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRFile]  WITH NOCHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRFile_MaintenanceRequestCR] FOREIGN KEY([MrId])
REFERENCES [dbo].[MaintenanceRequestCR] ([ID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRFile] CHECK CONSTRAINT [FK_MaintenanceRequestCRFile_MaintenanceRequestCR]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRStatusLog]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRStatusLog_MaintenanceRequestCR] FOREIGN KEY([MrID])
REFERENCES [dbo].[MaintenanceRequestCR] ([ID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRStatusLog] CHECK CONSTRAINT [FK_MaintenanceRequestCRStatusLog_MaintenanceRequestCR]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRStatusLog]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRStatusLog_NewMaintenanceRequestCR_Status] FOREIGN KEY([NewStatusId])
REFERENCES [dbo].[MaintenanceRequestCR_Status] ([ID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRStatusLog] CHECK CONSTRAINT [FK_MaintenanceRequestCRStatusLog_NewMaintenanceRequestCR_Status]
GO
ALTER TABLE [dbo].[MaintenanceRequestCRStatusLog]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceRequestCRStatusLog_OldMaintenanceRequestCR_Status] FOREIGN KEY([OldStatusId])
REFERENCES [dbo].[MaintenanceRequestCR_Status] ([ID])
GO
ALTER TABLE [dbo].[MaintenanceRequestCRStatusLog] CHECK CONSTRAINT [FK_MaintenanceRequestCRStatusLog_OldMaintenanceRequestCR_Status]
GO
ALTER TABLE [dbo].[MeasurementTypeDetail]  WITH CHECK ADD  CONSTRAINT [FK_MeasurementTypeDetail_MeasurementSystems] FOREIGN KEY([measurementSystemID])
REFERENCES [dbo].[MeasurementSystems] ([measurementSystemID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MeasurementTypeDetail] CHECK CONSTRAINT [FK_MeasurementTypeDetail_MeasurementSystems]
GO
ALTER TABLE [dbo].[MeasurementTypeDetail]  WITH CHECK ADD  CONSTRAINT [FK_MeasurementTypeDetail_MeasurementTypes] FOREIGN KEY([measurementTypeID])
REFERENCES [dbo].[MeasurementTypes] ([measurementTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MeasurementTypeDetail] CHECK CONSTRAINT [FK_MeasurementTypeDetail_MeasurementTypes]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD FOREIGN KEY([attributeValueId])
REFERENCES [dbo].[GWIS_LocationAttributeValue] ([GWIS_LocationAttributeValueID])
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD FOREIGN KEY([gwis_locationattributeid])
REFERENCES [dbo].[GWIS_LocationAttributes] ([GWIS_LocationAttributeID])
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location] FOREIGN KEY([gwis_locationid])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location_Area] FOREIGN KEY([areaId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location_Area]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location_BranchPlant] FOREIGN KEY([branchplantId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location_BranchPlant]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location_BusinessUnit] FOREIGN KEY([businessunitId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location_BusinessUnit]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location_Country] FOREIGN KEY([countryId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location_Country]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location_District] FOREIGN KEY([districtId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location_District]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location_Parent] FOREIGN KEY([parentId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location_Parent]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location_Region] FOREIGN KEY([regionId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location_Region]
GO
ALTER TABLE [dbo].[OperationalLocation]  WITH CHECK ADD  CONSTRAINT [FK_OperationalLocation_Location_SubRegion] FOREIGN KEY([subregionId])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationalLocation] CHECK CONSTRAINT [FK_OperationalLocation_Location_SubRegion]
GO
ALTER TABLE [dbo].[OperationLetter]  WITH NOCHECK ADD FOREIGN KEY([OperationLetterStatusId])
REFERENCES [dbo].[OperationLetterStatus] ([OperationLetterStatusId])
GO
ALTER TABLE [dbo].[OperationLetter]  WITH NOCHECK ADD FOREIGN KEY([OperationLetterTypeId])
REFERENCES [dbo].[OperationLetterType] ([OperationLetterTypeId])
GO
ALTER TABLE [dbo].[OperationLetter]  WITH NOCHECK ADD FOREIGN KEY([Region])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[OperationLetterTool]  WITH NOCHECK ADD FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[OperationLetterTool]  WITH NOCHECK ADD FOREIGN KEY([OperationLetterId])
REFERENCES [dbo].[OperationLetter] ([OperationLetterId])
GO
ALTER TABLE [dbo].[OperationLetterTool]  WITH NOCHECK ADD FOREIGN KEY([ToolPanelCodeVersionId])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[OpsLetterNotification]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[EquipmentProduct] ([equipmentProductID])
GO
ALTER TABLE [dbo].[PeopleAddresses]  WITH CHECK ADD  CONSTRAINT [FK_PeopleAddresses_People] FOREIGN KEY([personID])
REFERENCES [dbo].[People] ([personID])
GO
ALTER TABLE [dbo].[PeopleAddresses] CHECK CONSTRAINT [FK_PeopleAddresses_People]
GO
ALTER TABLE [dbo].[PeopleCompanies]  WITH CHECK ADD  CONSTRAINT [FK_PeopleCompanies_People] FOREIGN KEY([personID])
REFERENCES [dbo].[People] ([personID])
GO
ALTER TABLE [dbo].[PeopleCompanies] CHECK CONSTRAINT [FK_PeopleCompanies_People]
GO
ALTER TABLE [dbo].[Pricebook]  WITH CHECK ADD  CONSTRAINT [FK_Pricebook_GWIS_LocationAttributes] FOREIGN KEY([GWIS_LocationAttributeID])
REFERENCES [dbo].[GWIS_LocationAttributes] ([GWIS_LocationAttributeID])
GO
ALTER TABLE [dbo].[Pricebook] CHECK CONSTRAINT [FK_Pricebook_GWIS_LocationAttributes]
GO
ALTER TABLE [dbo].[Pricebook]  WITH CHECK ADD  CONSTRAINT [FK_Pricebook_PricebookStatus] FOREIGN KEY([statusid])
REFERENCES [dbo].[PriceBookStatus] ([priceBookStatusId])
GO
ALTER TABLE [dbo].[Pricebook] CHECK CONSTRAINT [FK_Pricebook_PricebookStatus]
GO
ALTER TABLE [dbo].[Pricebook]  WITH CHECK ADD  CONSTRAINT [FK_Pricebook_PricebookTree] FOREIGN KEY([book_level])
REFERENCES [dbo].[PricebookTree] ([id])
GO
ALTER TABLE [dbo].[Pricebook] CHECK CONSTRAINT [FK_Pricebook_PricebookTree]
GO
ALTER TABLE [dbo].[PricebookData]  WITH CHECK ADD  CONSTRAINT [FK_PricebookData_Pricebook1] FOREIGN KEY([Pricebook_id])
REFERENCES [dbo].[Pricebook] ([id])
GO
ALTER TABLE [dbo].[PricebookData] CHECK CONSTRAINT [FK_PricebookData_Pricebook1]
GO
ALTER TABLE [dbo].[PricebookData]  WITH CHECK ADD  CONSTRAINT [FK_PricebookData_ServiceDetails] FOREIGN KEY([ServiceDetails_id])
REFERENCES [dbo].[ServiceDetails] ([id])
GO
ALTER TABLE [dbo].[PricebookData] CHECK CONSTRAINT [FK_PricebookData_ServiceDetails]
GO
ALTER TABLE [dbo].[PricebookDataLog]  WITH CHECK ADD  CONSTRAINT [FK_PricebookDataLog_modifiedBy] FOREIGN KEY([modifiedById])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[PricebookDataLog] CHECK CONSTRAINT [FK_PricebookDataLog_modifiedBy]
GO
ALTER TABLE [dbo].[PricebookDataLog]  WITH CHECK ADD  CONSTRAINT [FK_PricebookDataLog_Pricebook] FOREIGN KEY([pricebookId])
REFERENCES [dbo].[Pricebook] ([id])
GO
ALTER TABLE [dbo].[PricebookDataLog] CHECK CONSTRAINT [FK_PricebookDataLog_Pricebook]
GO
ALTER TABLE [dbo].[PricebookDataLog]  WITH CHECK ADD  CONSTRAINT [FK_PricebookDataLog_PricebookData] FOREIGN KEY([pricebookDataId])
REFERENCES [dbo].[PricebookData] ([id])
GO
ALTER TABLE [dbo].[PricebookDataLog] CHECK CONSTRAINT [FK_PricebookDataLog_PricebookData]
GO
ALTER TABLE [dbo].[PricebookDataLog]  WITH CHECK ADD  CONSTRAINT [FK_PricebookDataLog_PricingStyle] FOREIGN KEY([pricingStyleId])
REFERENCES [dbo].[PricingStyle] ([id])
GO
ALTER TABLE [dbo].[PricebookDataLog] CHECK CONSTRAINT [FK_PricebookDataLog_PricingStyle]
GO
ALTER TABLE [dbo].[PricebookDataLog]  WITH CHECK ADD  CONSTRAINT [FK_PricebookDataLog_ServiceGroup] FOREIGN KEY([serviceGroupId])
REFERENCES [dbo].[ServiceGroup] ([id])
GO
ALTER TABLE [dbo].[PricebookDataLog] CHECK CONSTRAINT [FK_PricebookDataLog_ServiceGroup]
GO
ALTER TABLE [dbo].[PricebookDataLog]  WITH CHECK ADD  CONSTRAINT [FK_PricebookDataLog_ServiceType] FOREIGN KEY([serviceTypeId])
REFERENCES [dbo].[ServiceType] ([id])
GO
ALTER TABLE [dbo].[PricebookDataLog] CHECK CONSTRAINT [FK_PricebookDataLog_ServiceType]
GO
ALTER TABLE [dbo].[PriceBookEmployee]  WITH CHECK ADD  CONSTRAINT [FK_PriceBookEmployee_Employee] FOREIGN KEY([employeeID])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[PriceBookEmployee] CHECK CONSTRAINT [FK_PriceBookEmployee_Employee]
GO
ALTER TABLE [dbo].[PriceBookEmployee]  WITH CHECK ADD  CONSTRAINT [FK_PriceBookEmployee_Pricebook] FOREIGN KEY([priceBookID])
REFERENCES [dbo].[Pricebook] ([id])
GO
ALTER TABLE [dbo].[PriceBookEmployee] CHECK CONSTRAINT [FK_PriceBookEmployee_Pricebook]
GO
ALTER TABLE [dbo].[PriceBookEmployee]  WITH CHECK ADD  CONSTRAINT [FK_PriceBookEmployee_PriceBookEmployeeRole] FOREIGN KEY([priceBookEmployeeRoleID])
REFERENCES [dbo].[PriceBookEmployeeRole] ([priceBookEmployeeRoleID])
GO
ALTER TABLE [dbo].[PriceBookEmployee] CHECK CONSTRAINT [FK_PriceBookEmployee_PriceBookEmployeeRole]
GO
ALTER TABLE [dbo].[PricebookSectionPdfOptions]  WITH CHECK ADD  CONSTRAINT [FK__Pricebook__Price__36B1ED9A] FOREIGN KEY([PricebookId])
REFERENCES [dbo].[Pricebook] ([id])
GO
ALTER TABLE [dbo].[PricebookSectionPdfOptions] CHECK CONSTRAINT [FK__Pricebook__Price__36B1ED9A]
GO
ALTER TABLE [dbo].[PricebookSectionPdfOptions]  WITH CHECK ADD FOREIGN KEY([ServiceTypeId])
REFERENCES [dbo].[ServiceType] ([id])
GO
ALTER TABLE [dbo].[PricebookTree]  WITH CHECK ADD  CONSTRAINT [FK_PricebookTree_FinancialSystem] FOREIGN KEY([system])
REFERENCES [dbo].[FinancialSystem] ([id])
GO
ALTER TABLE [dbo].[PricebookTree] CHECK CONSTRAINT [FK_PricebookTree_FinancialSystem]
GO
ALTER TABLE [dbo].[PricingStyle]  WITH CHECK ADD  CONSTRAINT [FK_PricingStyle_UOM] FOREIGN KEY([uom])
REFERENCES [dbo].[UOM] ([id])
GO
ALTER TABLE [dbo].[PricingStyle] CHECK CONSTRAINT [FK_PricingStyle_UOM]
GO
ALTER TABLE [dbo].[Quote]  WITH CHECK ADD  CONSTRAINT [FK_Quote_Job] FOREIGN KEY([jobID])
REFERENCES [dbo].[Job] ([jobID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Quote] CHECK CONSTRAINT [FK_Quote_Job]
GO
ALTER TABLE [dbo].[RigType]  WITH CHECK ADD  CONSTRAINT [FK_RigType_WellLocationType] FOREIGN KEY([wellLocationTypeID])
REFERENCES [dbo].[WellLocationType] ([wellLocationTypeID])
GO
ALTER TABLE [dbo].[RigType] CHECK CONSTRAINT [FK_RigType_WellLocationType]
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [FK_Service_ServiceGroup] FOREIGN KEY([service_group])
REFERENCES [dbo].[ServiceGroup] ([id])
GO
ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [FK_Service_ServiceGroup]
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [FK_Service_ServiceType] FOREIGN KEY([service_type])
REFERENCES [dbo].[ServiceType] ([id])
GO
ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [FK_Service_ServiceType]
GO
ALTER TABLE [dbo].[ServiceDetails]  WITH CHECK ADD  CONSTRAINT [FK_ServiceDetails_Service] FOREIGN KEY([service_id])
REFERENCES [dbo].[Service] ([id])
GO
ALTER TABLE [dbo].[ServiceDetails] CHECK CONSTRAINT [FK_ServiceDetails_Service]
GO
ALTER TABLE [dbo].[ServiceGroup]  WITH CHECK ADD  CONSTRAINT [FK_ServiceGroup_ServiceType] FOREIGN KEY([service_type])
REFERENCES [dbo].[ServiceType] ([id])
GO
ALTER TABLE [dbo].[ServiceGroup] CHECK CONSTRAINT [FK_ServiceGroup_ServiceType]
GO
ALTER TABLE [dbo].[ServiceGroupToolType]  WITH CHECK ADD  CONSTRAINT [FK_ServiceGroupToolType_ServiceGroup] FOREIGN KEY([servicegroupid])
REFERENCES [dbo].[ServiceGroup] ([id])
GO
ALTER TABLE [dbo].[ServiceGroupToolType] CHECK CONSTRAINT [FK_ServiceGroupToolType_ServiceGroup]
GO
ALTER TABLE [dbo].[ServiceTool]  WITH CHECK ADD  CONSTRAINT [FK_ServiceTool_Service] FOREIGN KEY([service_id])
REFERENCES [dbo].[Service] ([id])
GO
ALTER TABLE [dbo].[ServiceTool] CHECK CONSTRAINT [FK_ServiceTool_Service]
GO
ALTER TABLE [dbo].[ServiceType]  WITH CHECK ADD  CONSTRAINT [FK_ServiceType_FinancialSystem] FOREIGN KEY([system])
REFERENCES [dbo].[FinancialSystem] ([id])
GO
ALTER TABLE [dbo].[ServiceType] CHECK CONSTRAINT [FK_ServiceType_FinancialSystem]
GO
ALTER TABLE [dbo].[Support]  WITH CHECK ADD  CONSTRAINT [FK_Support_SupportStatus] FOREIGN KEY([supportStatusID])
REFERENCES [dbo].[SupportStatus] ([supportStatusID])
GO
ALTER TABLE [dbo].[Support] CHECK CONSTRAINT [FK_Support_SupportStatus]
GO
ALTER TABLE [dbo].[Support]  WITH CHECK ADD  CONSTRAINT [FK_Support_SupportType] FOREIGN KEY([supportTypeID])
REFERENCES [dbo].[SupportType] ([supportTypeID])
GO
ALTER TABLE [dbo].[Support] CHECK CONSTRAINT [FK_Support_SupportType]
GO
ALTER TABLE [dbo].[SupportSchedule]  WITH NOCHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[TMPSOADTPipelineMessages]  WITH NOCHECK ADD  CONSTRAINT [FK_TMPSOADTPipelineMessages_SOADTPipelineMessageProcessing] FOREIGN KEY([SOADTPipelineMessageProcessingID])
REFERENCES [dbo].[TMPSOADTPipelineMessageProcessing] ([SOADTPipelineMessageProcessingID])
GO
ALTER TABLE [dbo].[TMPSOADTPipelineMessages] NOCHECK CONSTRAINT [FK_TMPSOADTPipelineMessages_SOADTPipelineMessageProcessing]
GO
ALTER TABLE [dbo].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_Equipment] FOREIGN KEY([equipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[Unit] CHECK CONSTRAINT [FK_Unit_Equipment]
GO
ALTER TABLE [dbo].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_GWIS_Location_BranchPlant] FOREIGN KEY([branchPlantLocationID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Unit] CHECK CONSTRAINT [FK_Unit_GWIS_Location_BranchPlant]
GO
ALTER TABLE [dbo].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_GWIS_Location_BusinessUnit] FOREIGN KEY([businessUnitLocationID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[Unit] CHECK CONSTRAINT [FK_Unit_GWIS_Location_BusinessUnit]
GO
ALTER TABLE [dbo].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_UnitStatus] FOREIGN KEY([unitStatusID])
REFERENCES [dbo].[UnitStatus] ([unitStatusID])
GO
ALTER TABLE [dbo].[Unit] CHECK CONSTRAINT [FK_Unit_UnitStatus]
GO
ALTER TABLE [dbo].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_UnitType] FOREIGN KEY([unitTypeID])
REFERENCES [dbo].[UnitType] ([unitTypeID])
GO
ALTER TABLE [dbo].[Unit] CHECK CONSTRAINT [FK_Unit_UnitType]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_ChasisVendorID_UnitBuildInformation] FOREIGN KEY([chassisVendorID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_ChasisVendorID_UnitBuildInformation]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_ChassisTPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([chassisEquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_ChassisTPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_destinationCountryLocationID_GWIS_Location1] FOREIGN KEY([destinationCountry])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_destinationCountryLocationID_GWIS_Location1]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_Drum1TPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([drum1EquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_Drum1TPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_drum1WL1Measurement_MeasurementTypeDetail] FOREIGN KEY([drum1Wireline1MarkingMeasuremenTypeDetailID])
REFERENCES [dbo].[MeasurementTypeDetail] ([measurementTypeDetailID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_drum1WL1Measurement_MeasurementTypeDetail]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_Drum1WL1TPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([drum1Wireline1EquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_Drum1WL1TPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_drum1WL2Measurement_MeasurementTypeDetail] FOREIGN KEY([drum1Wireline2MarkingMeasuremenTypeDetailID])
REFERENCES [dbo].[MeasurementTypeDetail] ([measurementTypeDetailID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_drum1WL2Measurement_MeasurementTypeDetail]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_drum1WL2TPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([drum1Wireline2EquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_drum1WL2TPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_drum2TPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([drum2EquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_drum2TPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_drum2WL1Measurement_MeasurementTypeDetail] FOREIGN KEY([drum2Wireline1MarkingMeasuremenTypeDetailID])
REFERENCES [dbo].[MeasurementTypeDetail] ([measurementTypeDetailID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_drum2WL1Measurement_MeasurementTypeDetail]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_drum2WL1TPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([drum2Wireline1EquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_drum2WL1TPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_drum2WL2Measurement_MeasurementTypeDetail] FOREIGN KEY([drum2Wireline2MarkingMeasuremenTypeDetailID])
REFERENCES [dbo].[MeasurementTypeDetail] ([measurementTypeDetailID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_drum2WL2Measurement_MeasurementTypeDetail]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_drum2WL2TPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([drum2Wireline2EquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_drum2WL2TPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_generatorTPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([generatorEquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_generatorTPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_GWIS_Location] FOREIGN KEY([builderID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_GWIS_Location]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_measureHeadTPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([measureHeadEquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_measureHeadTPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_powerConverterTPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([powerConverterEquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_powerConverterTPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_shootingPanelTPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([shootingPanelEquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_shootingPanelTPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_Skid_EquipmentToolPanelCodeVersion] FOREIGN KEY([skidEquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_Skid_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_system1TPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([system1EquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_system1TPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_system2TPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([system2EquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_system2TPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_Unit] FOREIGN KEY([unitID])
REFERENCES [dbo].[Unit] ([unitID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_Unit]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_UnitRackType] FOREIGN KEY([unitRackTypeID])
REFERENCES [dbo].[UnitRackType] ([unitRackTypeID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_UnitRackType]
GO
ALTER TABLE [dbo].[UnitBuildInformation]  WITH CHECK ADD  CONSTRAINT [FK_UnitBuildInformation_VanTPCV_EquipmentToolPanelCodeVersion] FOREIGN KEY([vanEquipmentTPCVID])
REFERENCES [dbo].[EquipmentToolPanelCodeVersion] ([equipmentToolPanelCodeVersionID])
GO
ALTER TABLE [dbo].[UnitBuildInformation] CHECK CONSTRAINT [FK_UnitBuildInformation_VanTPCV_EquipmentToolPanelCodeVersion]
GO
ALTER TABLE [dbo].[UnitHistory]  WITH CHECK ADD  CONSTRAINT [FK_UnitHistory_Employee] FOREIGN KEY([changedBy])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[UnitHistory] CHECK CONSTRAINT [FK_UnitHistory_Employee]
GO
ALTER TABLE [dbo].[UnitHistory]  WITH CHECK ADD  CONSTRAINT [FK_UnitHistory_Unit] FOREIGN KEY([unitID])
REFERENCES [dbo].[Unit] ([unitID])
GO
ALTER TABLE [dbo].[UnitHistory] CHECK CONSTRAINT [FK_UnitHistory_Unit]
GO
ALTER TABLE [dbo].[UnitLicense]  WITH CHECK ADD  CONSTRAINT [FK_UnitLicense_GWIS_Location] FOREIGN KEY([licensingLocationID])
REFERENCES [dbo].[GWIS_Location] ([GWIS_LocationID])
GO
ALTER TABLE [dbo].[UnitLicense] CHECK CONSTRAINT [FK_UnitLicense_GWIS_Location]
GO
ALTER TABLE [dbo].[UnitLicense]  WITH CHECK ADD  CONSTRAINT [FK_UnitLicense_Unit] FOREIGN KEY([unitID])
REFERENCES [dbo].[Unit] ([unitID])
GO
ALTER TABLE [dbo].[UnitLicense] CHECK CONSTRAINT [FK_UnitLicense_Unit]
GO
ALTER TABLE [dbo].[UnitWireline]  WITH CHECK ADD  CONSTRAINT [FK_UnitWireline_Employee] FOREIGN KEY([modifiedBy])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[UnitWireline] CHECK CONSTRAINT [FK_UnitWireline_Employee]
GO
ALTER TABLE [dbo].[UnitWireline]  WITH CHECK ADD  CONSTRAINT [FK_UnitWireline_Equipment] FOREIGN KEY([wirelineEquipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[UnitWireline] CHECK CONSTRAINT [FK_UnitWireline_Equipment]
GO
ALTER TABLE [dbo].[UnitWireline]  WITH CHECK ADD  CONSTRAINT [FK_UnitWireline_Unit] FOREIGN KEY([unitID])
REFERENCES [dbo].[Unit] ([unitID])
GO
ALTER TABLE [dbo].[UnitWireline] CHECK CONSTRAINT [FK_UnitWireline_Unit]
GO
ALTER TABLE [dbo].[UserPreferences]  WITH CHECK ADD  CONSTRAINT [FK_UserPreferences_UserPreferenceTypes] FOREIGN KEY([userPreferenceTypeID])
REFERENCES [dbo].[UserPreferenceTypes] ([userPreferenceTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserPreferences] CHECK CONSTRAINT [FK_UserPreferences_UserPreferenceTypes]
GO
ALTER TABLE [dbo].[UserRoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_UserRoleMapping_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[UserRoleMapping] CHECK CONSTRAINT [FK_UserRoleMapping_Employee]
GO
ALTER TABLE [dbo].[UserRoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[role_Master] ([RoleId])
GO
ALTER TABLE [dbo].[UserRoleMapping] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
/****** Object:  StoredProcedure [dbo].[ApplyJobActualCurrency]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ApplyJobActualCurrency]
    @jobId uniqueidentifier
AS
	DECLARE @currencyRateId int
	DECLARE @actualCurrencyRate numeric(18,9)
	DECLARE @currencyId int

	SELECT @currencyRateId=j.currencyRateId, 
		   @actualCurrencyRate=j.actualCurrencyRate
	FROM Job j WHERE JobId=@jobId

	IF @currencyRateId  IS NULL 
	BEGIN
		
		SELECT TOP 1 
			@currencyRateId=r.currencyRateId,
			@actualCurrencyRate=r.rate
		FROM Job j 
		JOIN PriceBook pb ON j.financialSystemPricebookID = pb.id
		JOIN CurrencyRate pr ON pb.currencyRateId = pr.currencyRateId
		JOIN Currency c ON c.currencyid=pr.currencyid
		JOIN CurrencyRate r ON c.currencyId = r.currencyId
		WHERE JobId=@jobId AND dbo.fn_last_of_month(r.effectiveDate) = dbo.fn_last_of_month(DATEADD(day, -1, j.scheduledStartDateTime))
		ORDER BY r.effectiveDate DESC
		
		IF @currencyRateId IS NOT NULL AND @actualCurrencyRate > 0
		BEGIN
			UPDATE Job SET 
				actualCurrencyRate=@actualCurrencyRate,
				currencyRateId=@currencyRateId
				WHERE JobId=@jobId

			UPDATE JobCharges SET
				itemPrice = --itemPrice / @actualCurrencyRate,
							CASE 
									WHEN parentJobChargeID IS NULL THEN itemPrice / @actualCurrencyRate
									ELSE itemPrice
							 END,
				total = total / @actualCurrencyRate
			WHERE jobID=@jobId and (deleted IS NULL OR deleted=0)
		END

	END

GO
/****** Object:  StoredProcedure [dbo].[ExceptionJobBonusProcessForPayroll]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ExceptionJobBonusProcessForPayroll] 
	@LastUpdatedUTC DateTime,
	@AreaManager nvarchar(max),
	@Country nvarchar(255)
AS
BEGIN

	SELECT        hrmsEmployeeID, EmployeeName, EmployeeId, EmployeeEmail, ROUND(SUM(nativeBonusException), 2) AS BonusTotal
	FROM            (SELECT DISTINCT 
                                                    e2.hrmsEmployeeID, e2.displayname AS EmployeeName, e2.id as EmployeeId, e2.email as EmployeeEmail, j.scheduledStartDateTime, j.serviceOrder, jb.jobBonusID, jbfrd.nativeBonusException
                          FROM            FECellRole AS fecr INNER JOIN
                                                    Employee AS e2 INNER JOIN
                                                    Job AS j INNER JOIN
                                                    JobCrew AS JobCrew_1 ON j.jobID = JobCrew_1.jobID ON e2.id = JobCrew_1.employeeID INNER JOIN
                                                    JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID ON fecr.feCellRoleID = JobCrew_1.feCellRoleID INNER JOIN
                                                    JobCrew AS jc2 ON j.jobID = jc2.jobID INNER JOIN
                                                    EconnectEmployeeData ON e2.hrmsEmployeeID = EconnectEmployeeData.emplid INNER JOIN
                                                    JobBonusExceptionData AS jbfrd ON jb.jobBonusID = jbfrd.jobBonusID
                          WHERE        (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) 
                                                    AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (EconnectEmployeeData.w_country = @Country) AND (JobCrew_1.feCellRoleID = 9) AND 
                                                    (jb.jobBonusTypeID = 4) AND (jb.dateApproved <= @LastUpdatedUTC) AND (jbfrd.deleted IS NULL) OR
                                                    (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) 
                                                    AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (EconnectEmployeeData.w_country = @Country) AND (jb.jobBonusTypeID = 4) AND 
                                                    (jb.dateApproved <= @LastUpdatedUTC) AND (jbfrd.deleted IS NULL) AND (fecr.feCellRoleTypeID = 5)) AS SubTable
	WHERE        (nativeBonusException > 0)
	GROUP BY EmployeeName, EmployeeId, EmployeeEmail, hrmsEmployeeID

END
GO
/****** Object:  StoredProcedure [dbo].[ExecuteExceptionJobBonusProcessForPayroll]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ExecuteExceptionJobBonusProcessForPayroll] 
	@LastUpdatedDateTime DateTime,
	@AreaManager nvarchar(max),
	@Country nvarchar(255),
	@Processor nvarchar(255),
	@CurrencyCode nvarchar(255)
AS
BEGIN
	DECLARE @jobBonusIds As TABLE(jobBonusID uniqueidentifier)

	INSERT INTO @jobBonusIds(jobBonusID)
	SELECT DISTINCT jb.jobBonusID
	FROM            FECellRole AS fecr INNER JOIN
							 Employee AS e2 INNER JOIN
							 Job AS j INNER JOIN
							 JobCrew AS JobCrew_1 ON j.jobID = JobCrew_1.jobID ON e2.id = JobCrew_1.employeeID INNER JOIN
							 JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID ON fecr.feCellRoleID = JobCrew_1.feCellRoleID INNER JOIN
							 JobCrew AS jc2 ON j.jobID = jc2.jobID INNER JOIN
							 EconnectEmployeeData ON e2.hrmsEmployeeID = EconnectEmployeeData.emplid INNER JOIN
							 JobBonusExceptionData AS jbfrd ON jb.jobBonusID = jbfrd.jobBonusID
	WHERE        (EconnectEmployeeData.w_country = @Country) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) 
							 AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (JobCrew_1.feCellRoleID = 9) AND (jb.jobBonusTypeID = 4) AND 
							 (jb.dateApproved <= @LastUpdatedDateTime) AND (jbfrd.deleted IS NULL) OR
							 (EconnectEmployeeData.w_country = @Country) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) 
							 AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (jb.jobBonusTypeID = 4) AND 
							 (jb.dateApproved <= @LastUpdatedDateTime) AND (jbfrd.deleted IS NULL) AND (fecr.feCellRoleTypeID = 5)

	DECLARE @jobBonusIdStr nvarchar(max)
	SELECT @jobBonusIdStr = STUFF((
        select ','+ convert(nvarchar(max),jobBonusID)
        from @jobBonusIds
        FOR XML PATH('')
        )
        ,1,1,'')

	EXEC sp_ProcessJobBonusExceptions @BonusID=@jobBonusIdStr,  @ManagerWFTID=@Processor, @Country=@Country, @CurrencyCode=@CurrencyCode

	SELECT        SUM(ROUND(actualBonusTotal, 2)) AS BonusTotal, fullname AS EmployeeName, hrmsEmployeeID
	FROM            JobBonusHistory
	WHERE        (jobBonusProcessedID IN
								 (SELECT        TOP (1) jobBonusProcessedID
								   FROM            JobBonusProcessed
								   WHERE        (country IN (@Country)) AND (processedBy = @Processor)
								   ORDER BY dateProcessed DESC))
	GROUP BY fullname, hrmsEmployeeID

END
GO
/****** Object:  StoredProcedure [dbo].[ExecuteFlatRateJobBonusProcessForPayroll]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ExecuteFlatRateJobBonusProcessForPayroll] 
	@LastUpdatedDateTime DateTime,
	@AreaManager nvarchar(max),
	@Country nvarchar(255),
	@Processor nvarchar(255),
	@CurrencyCode nvarchar(255)
AS
BEGIN
	DECLARE @jobBonusIds As TABLE(jobBonusID uniqueidentifier)

	INSERT INTO @jobBonusIds(jobBonusID)
	SELECT DISTINCT jb.jobBonusID
	FROM            FECellRole AS fecr INNER JOIN
							 Employee AS e2 INNER JOIN
							 Job AS j INNER JOIN
							 JobCrew AS JobCrew_1 ON j.jobID = JobCrew_1.jobID ON e2.id = JobCrew_1.employeeID INNER JOIN
							 JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID ON fecr.feCellRoleID = JobCrew_1.feCellRoleID INNER JOIN
							 JobCrew AS jc2 ON j.jobID = jc2.jobID INNER JOIN
							 EconnectEmployeeData ON e2.hrmsEmployeeID = EconnectEmployeeData.emplid INNER JOIN
							 JobBonusFlatRateData AS jbfrd ON jb.jobBonusID = jbfrd.jobBonusID
	WHERE        (EconnectEmployeeData.w_country = @Country) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) 
							 AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (JobCrew_1.feCellRoleID = 9) AND (jb.jobBonusTypeID = 4) AND 
							 (jb.dateApproved <= @LastUpdatedDateTime) AND (jbfrd.deleted IS NULL) OR
							 (EconnectEmployeeData.w_country = @Country) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) 
							 AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (jb.jobBonusTypeID = 4) AND 
							 (jb.dateApproved <= @LastUpdatedDateTime) AND (jbfrd.deleted IS NULL) AND (fecr.feCellRoleTypeID = 5)

	DECLARE @jobBonusIdStr nvarchar(max)
	SELECT @jobBonusIdStr = STUFF((
        select ','+ convert(nvarchar(max),jobBonusID)
        from @jobBonusIds
        FOR XML PATH('')
        )
        ,1,1,'')

	EXEC sp_ProcessFlatRateJobBonus @BonusID=@jobBonusIdStr,  @ManagerWFTID=@Processor, @Country=@Country, @CurrencyCode=@CurrencyCode

	SELECT        SUM(ROUND(actualBonusTotal, 2)) AS BonusTotal, fullname AS EmployeeName, hrmsEmployeeID
	FROM            JobBonusHistory
	WHERE        (jobBonusProcessedID IN
								 (SELECT        TOP (1) jobBonusProcessedID
								   FROM            JobBonusProcessed
								   WHERE        (country IN (@Country)) AND (processedBy = @Processor)
								   ORDER BY dateProcessed DESC))
	GROUP BY fullname, hrmsEmployeeID

END
GO
/****** Object:  StoredProcedure [dbo].[ExecuteJobBonusProcessForPayroll]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ExecuteJobBonusProcessForPayroll] 
	@LastInvoiceUTC DateTime,
	@AreaManager nvarchar(max),
	@Country nvarchar(255),
	@Processor nvarchar(255),
	@CurrencyCode nvarchar(255)
AS
BEGIN
	DECLARE @jobBonusIds As TABLE(jobBonusID uniqueidentifier)

	INSERT INTO @jobBonusIds(jobBonusID)
	SELECT DISTINCT        jb.jobBonusID
	FROM            Employee AS e2 LEFT OUTER JOIN
							 EconnectEmployeeData ON e2.hrmsEmployeeID = EconnectEmployeeData.emplid RIGHT OUTER JOIN
							 JobCrew AS JobCrew_1 ON e2.id = JobCrew_1.employeeID FULL OUTER JOIN
							 JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID JOIN
							 JobBonusData jbd ON (jb.jobBonusID = jbd.jobBonusID AND jbd.nativeJDEServiceOrderTicketTotal IS NOT NULL) FULL OUTER JOIN
							 Job AS j RIGHT OUTER JOIN
							 JobCrew AS jc2 ON j.jobID = jc2.jobID ON JobCrew_1.jobID = j.jobID FULL OUTER JOIN
							 FECellRole AS fecr ON JobCrew_1.feCellRoleID = fecr.feCellRoleID
	WHERE        (j.invoiceDateTime <= @LastInvoiceUTC) AND (EconnectEmployeeData.w_country = @Country) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) AND 
							 (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (EconnectEmployeeData.w_country = @Country) AND
							 ((JobCrew_1.feCellRoleID = 9) OR  (fecr.feCellRoleTypeID = 5))

	DECLARE @jobBonusIdStr nvarchar(max)
	SELECT @jobBonusIdStr = STUFF((
        select ','+ convert(nvarchar(max),jobBonusID)
        from @jobBonusIds
        FOR XML PATH('')
        )
        ,1,1,'')

	EXEC sp_ProcessJobBonus @BonusID=@jobBonusIdStr,  @ManagerWFTID=@Processor, @Country=@Country, @CurrencyCode=@CurrencyCode

	SELECT SUM(ROUND(actualBonusTotal, 2)) AS BonusTotal, fullname AS EmployeeName, hrmsEmployeeID
	FROM JobBonusHistory
	WHERE  (jobBonusProcessedID IN
								 (SELECT        TOP (1) jobBonusProcessedID
								   FROM            JobBonusProcessed
								   WHERE        (country IN (@Country)) AND (processedBy = @Processor)
								   ORDER BY dateProcessed DESC))
	GROUP BY fullname, hrmsEmployeeID

END
GO
/****** Object:  StoredProcedure [dbo].[FlatRateJobBonusProcessForPayroll]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FlatRateJobBonusProcessForPayroll] 
	@LastUpdatedUTC DateTime,
	@AreaManager nvarchar(max),
	@Country nvarchar(255)
AS
BEGIN

	SELECT        hrmsEmployeeID, EmployeeName, EmployeeId, EmployeeEmail, ROUND(SUM(nativeBonusFlatRate), 2) AS BonusTotal
	FROM            (SELECT DISTINCT 
                                                    e2.hrmsEmployeeID, e2.displayname AS EmployeeName, e2.id as EmployeeId, e2.email as EmployeeEmail, j.scheduledStartDateTime, j.serviceOrder, jb.jobBonusID, jbfrd.nativeBonusFlatRate
                          FROM            FECellRole AS fecr INNER JOIN
                                                    Employee AS e2 INNER JOIN
                                                    Job AS j INNER JOIN
                                                    JobCrew AS JobCrew_1 ON j.jobID = JobCrew_1.jobID ON e2.id = JobCrew_1.employeeID INNER JOIN
                                                    JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID ON fecr.feCellRoleID = JobCrew_1.feCellRoleID INNER JOIN
                                                    JobCrew AS jc2 ON j.jobID = jc2.jobID INNER JOIN
                                                    EconnectEmployeeData ON e2.hrmsEmployeeID = EconnectEmployeeData.emplid INNER JOIN
                                                    JobBonusFlatRateData AS jbfrd ON jb.jobBonusID = jbfrd.jobBonusID
                          WHERE        (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) 
                                                    AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (EconnectEmployeeData.w_country = @Country) AND (JobCrew_1.feCellRoleID = 9) AND 
                                                    (jb.jobBonusTypeID = 4) AND (jb.dateApproved <= @LastUpdatedUTC) AND (jbfrd.deleted IS NULL) OR
                                                    (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND (j.deleted IS NULL) AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) 
                                                    AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND (EconnectEmployeeData.w_country = @Country) AND (jb.jobBonusTypeID = 4) AND 
                                                    (jb.dateApproved <= @LastUpdatedUTC) AND (jbfrd.deleted IS NULL) AND (fecr.feCellRoleTypeID = 5)) AS SubTable
	WHERE        (nativeBonusFlatRate > 0)
	GROUP BY EmployeeName, EmployeeId, EmployeeEmail, hrmsEmployeeID

END
GO
/****** Object:  StoredProcedure [dbo].[GetOperationalCountryTreeList]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetOperationalCountryTreeList]
AS
 BEGIN	
	;
	WITH CTE AS(
		SELECT gwis_locationattributeid, gwis_locationid, CAST(name as nvarchar(max)) as name, parent, lvl as [level] FROM dbo.vOperationalCountryTree WHERE parent IS NULL
		UNION ALL
		SELECT t.gwis_locationattributeid, t.gwis_locationid, CAST(c.name + '/' + t.name as nvarchar(max)) as name, t.parent, t.lvl as [level] FROM dbo.vOperationalCountryTree t
		INNER JOIN CTE c ON c.gwis_locationid=t.parent AND c.[level] = t.lvl-1
	)
	SELECT * FROM CTE ORDER BY name
END

GO
/****** Object:  StoredProcedure [dbo].[GetParentLocation]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetParentLocation]
    @locationId int,
	@locationLevel int,
	@parentLevel int
AS
	
	;WITH cte AS (
		SELECT [gwis_locationattributeid] ,[gwis_locationid],[name],[parent],[lvl]	FROM [dbo].[vOperationalBranchPlantTree]
			WHERE gwis_locationid = @locationId AND lvl=@locationLevel
		UNION ALL
		SELECT l.[gwis_locationattributeid] , l.[gwis_locationid], l.[name], l.[parent], l.[lvl] FROM [dbo].[vOperationalBranchPlantTree] l
			INNER JOIN cte c ON c.parent = l.gwis_locationid AND l.lvl = c.lvl-1
	)
	select GWIS_LocationAttributeId, GWIS_LocationId, Name from cte where lvl=@parentLevel
GO
/****** Object:  StoredProcedure [dbo].[GetSequence]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSequence]
    @name  nvarchar(300),
    @value bigint output
AS
    UPDATE Sequences
    SET @value = Sequence = Sequence + 1
    WHERE Name = @name;

	SELECT @value
GO
/****** Object:  StoredProcedure [dbo].[InsertCompanyAddress]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--TASK 399

CREATE PROCEDURE [dbo].[InsertCompanyAddress]
	@companyId int,
	@addressId int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO CompanyAddress(CompanyID, AddressID) VALUES(@companyId, @addressId)
END

GO
/****** Object:  StoredProcedure [dbo].[JobBonusProcessForPayroll]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[JobBonusProcessForPayroll] 
	@LastInvoiceUTC DateTime,
	@AreaManager nvarchar(max),
	@Country nvarchar(255)
AS
BEGIN

	SELECT        HrmsEmployeeID, EmployeeName, EmployeeId, EmployeeEmail, ROUND(SUM(nativeJDEBonusTotal), 2) AS BonusTotal
	FROM            (SELECT DISTINCT 
                                                    e2.hrmsEmployeeID, e2.displayname AS EmployeeName, e2.id as EmployeeId, e2.email as EmployeeEmail, jbd.nativeJDEServiceOrderTicketTotal, j.scheduledStartDateTime, jbd.nativeBonusTotal, 
                                                    ROUND(jbd.nativeJDEBonusTotal, 2) AS nativeJDEBonusTotal, j.serviceOrder, jb.jobBonusID
                          FROM            FECellRole AS fecr INNER JOIN
                                                    Employee AS e2 INNER JOIN
                                                    Job AS j INNER JOIN
                                                    JobCrew AS JobCrew_1 ON j.jobID = JobCrew_1.jobID ON e2.id = JobCrew_1.employeeID INNER JOIN
                                                    JobBonus AS jb INNER JOIN
                                                    JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID AND jbd.nativeJDEServiceOrderTicketTotal IS NOT NULL ON 
                                                    JobCrew_1.jobCrewID = jb.jobCrewID ON fecr.feCellRoleID = JobCrew_1.feCellRoleID INNER JOIN
                                                    JobCrew AS jc2 ON j.jobID = jc2.jobID INNER JOIN
                                                    EconnectEmployeeData ON e2.hrmsEmployeeID = EconnectEmployeeData.emplid
                          WHERE        (j.invoiceDateTime <= @LastInvoiceUTC) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND 
                                                    (j.deleted IS NULL) AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND 
                                                    (EconnectEmployeeData.w_country = @Country) AND (JobCrew_1.feCellRoleID = 9) OR
                                                    (j.invoiceDateTime <= @LastInvoiceUTC) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND 
                                                    (j.deleted IS NULL) AND (jc2.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManager))) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND 
                                                    (EconnectEmployeeData.w_country = @Country) AND (fecr.feCellRoleTypeID = 5)) AS SubTable
	WHERE        (nativeJDEBonusTotal > 0)
	GROUP BY EmployeeName, EmployeeId, EmployeeEmail, hrmsEmployeeID

END
GO
/****** Object:  StoredProcedure [dbo].[MassCopyJobProcedure]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<McKeehan, Trevor>
-- Create date: <May 8th 2013>
-- Description:	This script is designed to make copies from a single job.
--2 arguments:
	--@jobid: the jobid of the job to copy
	--@user: user name that will be pre-pended to the serviceorder of the job.
-- =============================================
CREATE PROCEDURE [dbo].[MassCopyJobProcedure]
	-- Add the parameters for the stored procedure here
	@jobid uniqueidentifier,
	@user nvarchar(50)
AS
BEGIN

--begin transaction;
--temp tables to hold a copy of the real data
CREATE TABLE #TEMPJOB([jobID] [uniqueidentifier] NOT NULL, [dateSubmitted] [datetime] NOT NULL, [financialSystemTypeID] [int] NOT NULL, [financialSystemID] [nvarchar](50) NOT NULL, [financialSystemPriceBookGroupID] [int] NOT NULL, [financialSystemPriceBookID] [int] NOT NULL, [serviceOrder] [nvarchar](50) NULL, [scheduledStartDateTime] [datetime] NOT NULL, [actualStartDateTime] [datetime] NOT NULL, [geographicDistrictID] [int] NOT NULL, [endDateTime] [datetime] NOT NULL, [operatingDistrictID] [int] NOT NULL, [comments] [nvarchar](4000) NULL, [specialInstructions] [nvarchar](4000) NULL, [jobStatusID] [tinyint] NOT NULL, [deleted] [bit] NULL, [jobTypeID] [int] NOT NULL, [oneViewCompanyID] [uniqueidentifier] NOT NULL, [oneViewAddressID] [uniqueidentifier] NOT NULL, [createdByEmployeeID] [int] NULL, [geoScienceStatusID] [int] NULL, [topsServiceOrderID] [int] NULL, [poNumber] [nvarchar](50) NULL, [quoteNumber] [nvarchar](50) NULL, [customerRepresentative] [nvarchar](100) NULL, [topsDistrictID] [int] NULL, [approvingManagerID] [int] NULL, [drivingInformation] [nvarchar](4000) NULL, [geographicLocationID] [int] NULL, [operationalLocationID] [int] NULL, [revenueCenterID] [int] NULL, [jdeDeliveryTicketID] [int] NULL, [jdeDeliveryTicketCurrencyID] [int] NULL, [jobCancelledReasonID] [int] NULL, [jobCancelledReasonComment] [nvarchar](1000) NULL, [jobCancelledReasonJobID] [uniqueidentifier] NULL, [rentalChargeTypeID] [int] NULL, [rentalCompanyName] [nvarchar](150) NULL, [rentalPhoneNumber] [nvarchar](50) NULL, [rentalContactName] [nvarchar](100) NULL, [rentalItems] [nvarchar](4000) NULL, [approxTimeSelectionID] [int] NULL, [quoteID] [uniqueidentifier] NULL, [oneviewToJDEJobID] [int] NULL)
CREATE TABLE #TEMPJOBCONTACTS([jobContactID] [uniqueidentifier] NOT NULL,[personID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBCREW([jobCrewID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [employeeID] [int] NOT NULL, [feCellRoleID] [int] NOT NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBASSETS([jobAssetID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [assetID] [int] NOT NULL, [deleted] [bit] NULL,)
CREATE TABLE #TEMPJOBWELL([jobWellID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NULL, [rigName] [nvarchar](200) NULL, [rigTypeID] [int] NULL, [drillingFluidTypeID] [int] NULL, [bottomHolePressure] [float] NULL, [bottomHoleTemperature] [float] NULL, [comments] [nvarchar](4000) NULL, [maxDeviation] [float] NULL, [maxDogLeg] [float] NULL, [wellLocationTypeID] [int] NULL, [oneViewWellID] [uniqueidentifier] NOT NULL, [conveyanceTypeID] [int] NULL, [acquisitionTypeID] [int] NULL, [conveyanceSubTypeID] [int] NULL, [totalDepth] [float] NULL, [tightHole] [bit] NULL, [deleted] [bit] NULL, [seismicWellTypeID] [int] NULL, [kellyBushing] [float] NULL, [groundLevel] [float] NULL, [hasH2S] [bit] NULL, [h2sLevel] [float] NULL, [hasCO2] [bit] NULL, [co2Level] [float] NULL, [shutInPressure] [float] NULL, [flowingPressure] [float] NULL, [hasWirelineControlValve] [bit] NULL, [surfacePressure] [float] NULL, [minimumID] [float] NULL, [wellHeadSize] [nvarchar](50) NULL, [wellHead] [nvarchar](100) NULL, [isLubricatorRequired] [bit] NULL, [isGreaseInjectorRequired] [bit] NULL, [lubricatorType] [nvarchar](100) NULL, [greaseInjectorType] [nvarchar](100) NULL, [mudDensity] [nvarchar](50) NULL, [mudViscosity] [nvarchar](50) NULL, [casingShoe] [decimal](18, 9) NULL,)
CREATE TABLE #TEMPJOBWELLCASINGTUBINGPROFILE([jobWellCasingTubingProfileID] [uniqueidentifier] NOT NULL, [jobWellID] [uniqueidentifier] NOT NULL, [casingDimensionID] [uniqueidentifier] NOT NULL, [casingTypeID] [int] NOT NULL, [startDepth] [float] NOT NULL, [endDepth] [float] NOT NULL, [deleted] [bit] NULL, [casingShoe] [decimal](18, 9) NULL,)
CREATE TABLE #TEMPJOBWELLBOREHOLEPROFILE([jobWellBoreholeProfileID] [uniqueidentifier] NOT NULL, [jobWellID] [uniqueidentifier] NOT NULL, [bitSizeID] [uniqueidentifier] NOT NULL, [startDepth] [float] NOT NULL, [endDepth] [float] NOT NULL, [deleted] [bit] NULL,)
CREATE TABLE #TEMPJOBSELECTEDSERVICE([jobSelectedServiceID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [serviceGroupID] [int] NOT NULL, [servicePerformed] [bit] NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL([jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL, [jobSelectedServiceID] [uniqueidentifier] NOT NULL, [comments] [nvarchar](4000) NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL([jobSelectedServicePerforatingDispatchDetailsID] [uniqueidentifier] NOT NULL, [ballisticGunTypeID] [int] NULL, [isSelectFire] [bit] NULL, [ballisticDetonatorTypeID] [int] NULL, [ballisticGunSizeID] [int] NULL, [ballisticIgniterID] [int] NULL, [ballisticInitiatorTypeID] [int] NULL, [ballisticManufacturerID] [int] NULL, [ballisticPhasingID] [int] NULL, [ballisticTypeOfChargeID] [int] NULL, [gramWeight] [float] NULL, [orientedGun] [bit] NULL, [deleted] [bit] NULL, [jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL, [ballisticSPFID] [int] NULL)
CREATE TABLE #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL([jobSelectedServicePipeRecoveryDetailID] [uniqueidentifier] NOT NULL, [jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL, [connectionType] [nvarchar](255) NULL, [size] [float] NULL, [weight] [float] NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL([jobSelectedServiceAssureConveyanceDetailID] [uniqueidentifier] NOT NULL, [jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL, [drillPipeODGrade] [nvarchar](50) NULL, [drillPipeThreadPattern] [nvarchar](50) NULL, [drillPipeSize] [decimal](18, 9) NULL, [drillPipeWeight] [decimal](18, 9) NULL, [drillPipeTube] [decimal](18, 9) NULL, [drillPipeJoint] [decimal](18, 9) NULL, [drillPipeCapacity] [decimal](18, 9) NULL, [drillPipeNumberOfJoints] [int] NULL, [drillPipeAverageJointLength] [decimal](18, 9) NULL, [drillPipeTotalLength] [decimal](18, 9) NULL, [drillPipeCrossOverProvidedBy] [nvarchar](50) NULL, [hwDrillPipeODGrade] [nvarchar](50) NULL, [hwDrillPipeThreadPattern] [nvarchar](50) NULL, [hwDrillPipeSize] [decimal](18, 9) NULL, [hwDrillPipeWeight] [decimal](18, 9) NULL, [hwDrillPipeTube] [decimal](18, 9) NULL, [hwDrillPipeJoint] [decimal](18, 9) NULL, [hwDrillPipeCapacity] [decimal](18, 9) NULL, [hwDrillPipeNumberOfJoints] [int] NULL, [hwDrillPipeAverageJointLength] [decimal](18, 9) NULL, [hwDrillPipeTotalLength] [decimal](18, 9) NULL, [hwDrillPipeScreenProvidedBy] [nvarchar](50) NULL, [pumpEfficiency] [decimal](18, 9) NULL, [pumpMinStrokeRate] [int] NULL, [pumpMaxStrokeRate] [int] NULL, [pumpOutput] [decimal](18, 9) NULL, [pumpStrokeLength] [decimal](18, 9) NULL, [pumpLinerSize] [decimal](18, 9) NULL, [pumpOtherLinerSize] [decimal](18, 9) NULL, [pumpMaxSafeCirculatingPressure] [decimal](18, 9) NULL, [pumpCirculatingStrokeRate] [int] NULL, [pumpCirculatingPressure] [decimal](18, 9) NULL, [pumpMessengerWith] [nvarchar](50) NULL, [pumpRigPump] [bit] NULL, [pumpTruck] [bit] NULL, [pumpCrippleRig] [bit] NULL, [pumpDivertFluidFromRig] [bit] NULL, [mudSystemFrictionReducerUsed] [bit] NULL, [mudSystemFrictionReducerDetail] [nvarchar](50) NULL, [depthSystemUsed] [bit] NULL, [depthSystemDetail] [nvarchar](50) NULL, [driftingMethodDropCirculatingDrift] [bit] NULL, [driftingMethodWhileStrappingIn] [bit] NULL, [driftingMethodSignOff] [bit] NULL, [driftingProvidedBy] [nvarchar](50) NULL, [loaderAvailableToUnloadDrillPipe] [bit] NULL, [internalDrillPipeCoating] [bit] NULL, [internalDrillPipeCoatingInspectionDate] [datetime] NULL, [otherComponentJars] [bit] NULL, [otherComponentCollars] [bit] NULL, [otherComponentScreens] [bit] NULL, [otherComponentCorrosionRings] [bit] NULL, [edrSystem] [nvarchar](50) NULL, [mudSystem] [nvarchar](50) NULL, [lostCirculatingRate] [nvarchar](50) NULL, [lcmContent] [nvarchar](50) NULL, [estimatedTripInTime] [nvarchar](50) NULL, [layingDownDrillPipe] [nvarchar](50) NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBOPERATION([jobOperationID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [jobOperationTypeID] [int] NOT NULL, [jobOperationStartTime] [datetime] NOT NULL, [jobOperationEndTime] [datetime] NOT NULL, [jobOperationComments] [ntext] NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBACTUALSERVICE([jobActualServiceID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [jobOperationToolID] [uniqueidentifier] NOT NULL, [serviceGroupID] [int] NOT NULL, [timesRendered] [int] NOT NULL, [renderedByEmployee2] [int] NULL, [renderedByEmployee] [int] NULL, [deleted] [bit] NULL, [performed] [bit] NULL)
CREATE TABLE #TEMPJOBOPERATIONEVENT([jobOperationEventID] [uniqueidentifier] NOT NULL, [jobOperationID] [uniqueidentifier] NOT NULL, [jobOperationEventOrder] [int] NOT NULL, [jobOperationEventComments] [ntext] NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBOPERATIONTOOL([jobOperationToolID] [uniqueidentifier] NOT NULL, [jobOperationID] [uniqueidentifier] NOT NULL, [assetID] [int] NOT NULL, [toolStringPosition] [int] NOT NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBOPERATIONAUXDATA([jobOperationAuxDataID] [uniqueidentifier] NOT NULL, [jobOperationID] [uniqueidentifier] NOT NULL, [qtyRequested] [int] NULL, [qtyAttempted] [int] NULL, [qtySuccessful] [int] NULL, [pressureAttempted] [float] NULL, [tightTests] [int] NULL, [noSeal] [int] NULL, [successfulTests] [int] NULL, [odometerStart] [float] NULL, [odometerEnd] [float] NULL, [startHours] [float] NULL, [endHours] [float] NULL, [temperature] [float] NULL, [deleted] [bit] NULL, [pressureTestsAttempted] [int] NULL, [distanceTraveled] [float] NULL, [engineHours] [float] NULL)
--CREATE TABLE #TEMPJOBOPERATIONEVENTAUXDATA([auxillaryDataID] [uniqueidentifier] NOT NULL, [jobOperationEventID] [uniqueidentifier] NOT NULL)
CREATE TABLE #TEMPJOBOPERATIONEVENTINTERVAL([jobOperationEventIntervalID] [uniqueidentifier] NOT NULL, [jobOperationEventID] [uniqueidentifier] NULL, [eventIntervalStartDepth] [float] NOT NULL, [eventIntervalStopDepth] [float] NULL, [eventIntervalOrder] [int] NOT NULL, [deleted] [bit] NULL, [jobSelectedServicePerforatingDispatchDetailsID] [uniqueidentifier] NULL)
--create failure tables at a later time
CREATE TABLE #TEMPJOBCHARGES([jobChargeID] [uniqueidentifier] NOT NULL,	[jobActualServiceID] [uniqueidentifier] NULL,	[pricingStyleID] [int] NULL,	[serviceDetailID] [int] NULL,	[itemQuantity] [decimal](18, 9) NULL,	[isPercentage] [bit] NULL,	[deleted] [bit] NULL,	[jobOperationID] [uniqueidentifier] NULL,	[jobID] [uniqueidentifier] NOT NULL,	[itemPrice] [decimal](18, 9) NULL,	[parentJobChargeID] [uniqueidentifier] NULL,	[discount] [decimal](18, 9) NULL,	[total] [decimal](18, 9) NULL,	[comments] [nvarchar](4000) NULL,	[adjustedItemQuantity] [decimal](18, 9) NULL,	[adjustedItemPrice] [decimal](18, 9) NULL,	[adjustedDiscount] [decimal](18, 9) NULL,	[adjustedTotal] [decimal](18, 9) NULL)
CREATE TABLE #TEMPJOBCUSTOMERCOUNTS([customerCountsID] [uniqueidentifier] NOT NULL,	[jobID] [uniqueidentifier] NOT NULL,	[PersonnelRating] [int] NULL,	[EquipmentRating] [int] NULL,	[CommunicationRating] [int] NULL,	[HSSERating] [int] NULL,	[OverallRating] [int] NULL,	[CompanyComments] [ntext] NULL,	[DeclinedSurvey] [bit] NULL)
CREATE TABLE #TEMPJOBBONUS([jobBonusID] [uniqueidentifier] NOT NULL,	[jobBonusTypeID] [int] NOT NULL,	[jobBonusStatusID] [int] NULL,	[jobCrewID] [uniqueidentifier] NOT NULL,	[deleted] [bit] NULL,	[IsApproved] [bit] NULL,	[dateApproved] [datetime] NULL)
CREATE TABLE #TEMPJOBBONUSDATA([jobBonusDataID] [uniqueidentifier] NOT NULL,	[jobBonusID] [uniqueidentifier] NOT NULL,	[jobActualServiceID] [uniqueidentifier] NULL,	[bonusPercentage] [decimal](18, 9) NULL,	[bonusTotal] [decimal](18, 9) NULL,	[deleted] [bit] NULL,	[bonusNumberOfDays] [decimal](18, 9) NULL,	[bonusDayRate] [decimal](18, 9) NULL,	[serviceOrTicketTotal] [decimal](18, 9) NULL,	[splitPercentage] [decimal](18, 9) NULL,	[failurePercentage] [decimal](18, 9) NULL)

--CREATE TABLE temptbl_masscopy(name nvarchar(50) NOT NULL, processed bit NOT NULL)--CREATE TABLE temptbl_lookup(lookupid uniqueidentifier NOT NULL, typeid int NOT NULL)
--CREATE TABLE temptbl_newfk(fkid uniqueidentifier NOT NULL, fkname nvarchar(50) NOT NULL) 

SET NOCOUNT ON;

	DECLARE @pos        int,
            @nextpos    int,
            @valuelen   int,
		    @username nvarchar(50),
			@newjobid uniqueidentifier,
			@tempguid uniqueidentifier,
			@newtempguid uniqueidentifier,
			@date DATETIME

	--table variables to keep track of the oldids, their related newly generatedids, also servea as the loop variables.
	DECLARE	@jobwellids TABLE(jobwellid uniqueidentifier, newjobwellid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobcrewids TABLE(jobcrewid uniqueidentifier, newjobcrewid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobselectedserviceids TABLE(jobselectedserviceid uniqueidentifier, newjobselectedserviceid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobselectedservicedispatchdetailids TABLE(jobselectedservicedispatchdetailsid uniqueidentifier NULL, newjobselectedservicedispatchdetailsid uniqueidentifier, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @joboperationids TABLE(joboperationid uniqueidentifier, newjoboperationid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobactualserviceids TABLE(jobactualserviceid uniqueidentifier, newjobactualserviceid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @joboperationeventids TABLE(joboperationeventid uniqueidentifier, newjoboperationeventid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobbonusids TABLE(jobbonusid uniqueidentifier, newjobbonusid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	--DECLARE @joboperationeventintervals TABLE(joboperationeventintervalid uniqueidentifier, newjoboperationeventintervalid uniqueidentifier, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @joboperationtools TABLE(joboperationtoolid uniqueidentifier, newjoboperationtoolid uniqueidentifier, updateprocessed bit NULL, insertprocessed bit NULL)


		--inserts statements into temp tables from original tables
		insert into #TEMPJOB(jobID,dateSubmitted,financialSystemTypeID,financialSystemID,financialSystemPriceBookGroupID,financialSystemPriceBookID,serviceOrder,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted,jobTypeID,oneViewCompanyID,oneViewAddressID,createdByEmployeeID,geoScienceStatusID,topsServiceOrderID,poNumber,quoteNumber,customerRepresentative,topsDistrictID,approvingManagerID,drivingInformation,operationalLocationID,geographicLocationID,jobCancelledReasonID,jobCancelledReasonComment,jobCancelledReasonJobID,rentalChargeTypeID,rentalCompanyName,rentalPhoneNumber,rentalContactName,rentalItems,quoteID) 
			(select jobID,dateSubmitted,financialSystemTypeID,financialSystemID,financialsystempricebookgroupid,financialSystemPriceBookID,serviceOrder,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted,jobTypeID,oneViewCompanyID,oneViewAddressID,createdByEmployeeID,geoScienceStatusID,topsServiceOrderID,poNumber,quoteNumber,customerRepresentative,topsDistrictID,approvingManagerID,drivingInformation,operationalLocationID,geographicLocationID,jobCancelledReasonID,jobCancelledReasonComment,jobCancelledReasonJobID,rentalChargeTypeID,rentalCompanyName,rentalPhoneNumber,rentalContactName,rentalItems,quoteID from job where jobID = @jobid)
		insert into #TEMPJOBCONTACTS(jobcontactID,personID,jobID) 
			(select jobcontactID,personID,jobID from jobcontacts where jobID = @jobid)
		insert into #TEMPJOBCREW(jobcrewID,jobID,employeeID,feCellRoleID)
			(select jobcrewID,jobID,employeeID,feCellRoleID from jobcrew where jobID = @jobid)
		insert into #TEMPJOBASSETS(jobassetID,jobid,assetID) 
			(select jobassetID,jobid,assetID from jobassets where jobid = @jobid)
		insert into #TEMPJOBWELL(jobwellID,jobID,rigName,rigTypeID,drillingFluidTypeID,bottomHolePressure,bottomHoleTemperature,comments,maxDeviation,maxDogLeg,wellLocationTypeID,oneViewWellID,conveyanceTypeID,acquisitionTypeID,conveyanceSubTypeID,totalDepth,tightHole,deleted,seismicWellTypeID,kellyBushing,groundLevel,hasH2S,h2sLevel,hasCO2,co2Level,shutInPressure,flowingPressure,hasWirelineControlValve,surfacePressure,minimumID,wellHead,isLubricatorRequired,isGreaseInjectorRequired,lubricatorType,greaseInjectorType,mudDensity,mudViscosity,casingShoe) 
			(select jobwellID,jobID,rigName,rigTypeID,drillingFluidTypeID,bottomHolePressure,bottomHoleTemperature,comments,maxDeviation,maxDogLeg,wellLocationTypeID,oneViewWellID,conveyanceTypeID,acquisitionTypeID,conveyanceSubTypeID,totalDepth,tightHole,deleted,seismicWellTypeID,kellyBushing,groundLevel,hasH2S,h2sLevel,hasCO2,co2Level,shutInPressure,flowingPressure,hasWirelineControlValve,surfacePressure,minimumID,wellHead,isLubricatorRequired,isGreaseInjectorRequired,lubricatorType,greaseInjectorType,mudDensity,mudViscosity,casingShoe from jobwells where jobid = @jobid)
		insert into #TEMPJOBWELLCASINGTUBINGPROFILE(jobwellcasingtubingprofileID,jobWellID,casingDimensionID,casingTypeID,startDepth,endDepth) 
			(select jobwellcasingtubingprofileID,jobWellID,casingDimensionID,casingTypeID,startDepth,endDepth from jobwellcasingtubingprofile where jobwellid in (select jobwellid from #TEMPJOBWELL))
		insert into #TEMPJOBWELLBOREHOLEPROFILE(jobwellboreholeprofileID,jobWellID,bitSizeID,startDepth,endDepth) 
			(select jobwellboreholeprofileID,jobWellID,bitSizeID,startDepth,endDepth from jobwellboreholeprofile where jobwellid in (select jobwellid from #TEMPJOBWELL))
		insert into #TEMPJOBSELECTEDSERVICE(jobselectedserviceID,jobID,serviceGroupID,servicePerformed)
			(select jobselectedserviceID,jobID,serviceGroupID,servicePerformed from jobselectedservices where jobid = @jobid)
		insert into #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL(jobselectedservicedispatchdetailID,jobSelectedServiceID,deleted,comments)
			(select jobselectedservicedispatchdetailID,jobSelectedServiceID,deleted,comments from jobselectedservicedispatchdetails where jobselectedserviceid in (select jobselectedserviceid from #TEMPJOBSELECTEDSERVICE))
		insert into #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL(jobselectedserviceperforatingdispatchdetailsID,ballisticGunTypeID,isSelectFire,ballisticDetonatorTypeID,ballisticGunSizeID,ballisticIgniterID,ballisticInitiatorTypeID,ballisticManufacturerID,ballisticPhasingID,ballisticTypeOfChargeID,gramWeight,orientedGun,deleted,jobSelectedServiceDispatchDetailID,ballisticSPFID)
			(select jobselectedserviceperforatingdispatchdetailsID,ballisticGunTypeID,isSelectFire,ballisticDetonatorTypeID,ballisticGunSizeID,ballisticIgniterID,ballisticInitiatorTypeID,ballisticManufacturerID,ballisticPhasingID,ballisticTypeOfChargeID,gramWeight,orientedGun,deleted,jobSelectedServiceDispatchDetailID,ballisticSPFID from JobSelectedServicePerforatingDispatchDetails where jobselectedservicedispatchdetailID in (select jobselectedservicedispatchdetailID from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL))
		insert into #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL(jobselectedservicepiperecoverydetailID,jobSelectedServiceDispatchDetailID,connectionType,size,weight)
			(select jobselectedservicepiperecoverydetailID,jobSelectedServiceDispatchDetailID,connectionType,size,weight from JobSelectedServicePipeRecoveryDetails where jobselectedservicedispatchdetailID in (select jobselectedservicedispatchdetailID from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL))
		insert into #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL(jobselectedserviceassureconveyancedetailID,jobSelectedServiceDispatchDetailID,drillPipeODGrade,drillPipeThreadPattern,drillPipeSize,drillPipeWeight,drillPipeTube,drillPipeJoint,drillPipeCapacity,drillPipeNumberOfJoints,drillPipeAverageJointLength,drillPipeTotalLength,drillPipeCrossOverProvidedBy,hwDrillPipeODGrade,hwDrillPipeThreadPattern,hwDrillPipeSize,hwDrillPipeWeight,hwDrillPipeTube,hwDrillPipeJoint,hwDrillPipeCapacity,hwDrillPipeNumberOfJoints,hwDrillPipeAverageJointLength,hwDrillPipeTotalLength,hwDrillPipeScreenProvidedBy,pumpEfficiency,pumpMinStrokeRate,pumpMaxStrokeRate,pumpOutput,pumpStrokeLength,pumpLinerSize,pumpOtherLinerSize,pumpMaxSafeCirculatingPressure,pumpCirculatingStrokeRate,pumpCirculatingPressure,pumpMessengerWith,pumpRigPump,pumpTruck,pumpCrippleRig,pumpDivertFluidFromRig,mudSystemFrictionReducerUsed,mudSystemFrictionReducerDetail,depthSystemUsed,depthSystemDetail,driftingMethodDropCirculatingDrift,driftingMethodWhileStrappingIn,driftingMethodSignOff,driftingProvidedBy,loaderAvailableToUnloadDrillPipe,internalDrillPipeCoating,internalDrillPipeCoatingInspectionDate,otherComponentJars,otherComponentCollars,otherComponentScreens,otherComponentCorrosionRings,edrSystem,mudSystem,lostCirculatingRate,lcmContent,estimatedTripInTime,layingDownDrillPipe,deleted)
			(select jobselectedserviceassureconveyancedetailID,jobSelectedServiceDispatchDetailID,drillPipeODGrade,drillPipeThreadPattern,drillPipeSize,drillPipeWeight,drillPipeTube,drillPipeJoint,drillPipeCapacity,drillPipeNumberOfJoints,drillPipeAverageJointLength,drillPipeTotalLength,drillPipeCrossOverProvidedBy,hwDrillPipeODGrade,hwDrillPipeThreadPattern,hwDrillPipeSize,hwDrillPipeWeight,hwDrillPipeTube,hwDrillPipeJoint,hwDrillPipeCapacity,hwDrillPipeNumberOfJoints,hwDrillPipeAverageJointLength,hwDrillPipeTotalLength,hwDrillPipeScreenProvidedBy,pumpEfficiency,pumpMinStrokeRate,pumpMaxStrokeRate,pumpOutput,pumpStrokeLength,pumpLinerSize,pumpOtherLinerSize,pumpMaxSafeCirculatingPressure,pumpCirculatingStrokeRate,pumpCirculatingPressure,pumpMessengerWith,pumpRigPump,pumpTruck,pumpCrippleRig,pumpDivertFluidFromRig,mudSystemFrictionReducerUsed,mudSystemFrictionReducerDetail,depthSystemUsed,depthSystemDetail,driftingMethodDropCirculatingDrift,driftingMethodWhileStrappingIn,driftingMethodSignOff,driftingProvidedBy,loaderAvailableToUnloadDrillPipe,internalDrillPipeCoating,internalDrillPipeCoatingInspectionDate,otherComponentJars,otherComponentCollars,otherComponentScreens,otherComponentCorrosionRings,edrSystem,mudSystem,lostCirculatingRate,lcmContent,estimatedTripInTime,layingDownDrillPipe,deleted from JobSelectedServiceAssureConveyanceDetails where jobselectedservicedispatchdetailID in (select jobselectedservicedispatchdetailID from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL))
		insert into #TEMPJOBOPERATION(joboperationid,jobID,jobOperationTypeID,jobOperationStartTime,jobOperationEndTime,jobOperationComments)
			(select joboperationid,jobID,jobOperationTypeID,jobOperationStartTime,jobOperationEndTime,jobOperationComments from joboperations where jobid = @jobid)
		insert into #TEMPJOBACTUALSERVICE(jobactualserviceid,jobID,jobOperationToolID,serviceGroupID,timesRendered,renderedByEmployee2,renderedByEmployee,deleted,performed)
			(select jobactualserviceid,jobID,jobOperationToolID,serviceGroupID,timesRendered,renderedByEmployee2,renderedByEmployee,deleted,performed from jobactualservices where jobid = @jobid)
		insert into #TEMPJOBOPERATIONEVENT(joboperationeventid,jobOperationID,jobOperationEventOrder,jobOperationEventComments)
			(select joboperationeventid,jobOperationID,jobOperationEventOrder,jobOperationEventComments from joboperationevents where joboperationid in (select joboperationid from #TEMPJOBOPERATION))
		insert into #TEMPJOBOPERATIONTOOL(joboperationtoolid,jobOperationID,assetID,toolStringPosition)
			(select joboperationtoolid,jobOperationID,assetID,toolStringPosition from joboperationtools where joboperationid in (select joboperationid from #TEMPJOBOPERATION))
		insert into #TEMPJOBOPERATIONAUXDATA(joboperationauxdataid,jobOperationID,qtyRequested,qtyAttempted,qtySuccessful,pressureAttempted,tightTests,noSeal,successfulTests,odometerStart,odometerEnd,startHours,endHours,temperature,deleted,pressureTestsAttempted,distanceTraveled,engineHours)
			(select joboperationauxdataid,jobOperationID,qtyRequested,qtyAttempted,qtySuccessful,pressureAttempted,tightTests,noSeal,successfulTests,odometerStart,odometerEnd,startHours,endHours,temperature,deleted,pressureTestsAttempted,distanceTraveled,engineHours from joboperationauxdata where joboperationid in (select joboperationid from #TEMPJOBOPERATION))
		insert into #TEMPJOBOPERATIONEVENTINTERVAL(joboperationeventintervalid,jobOperationEventID,eventIntervalStartDepth,eventIntervalStopDepth,eventIntervalOrder,deleted,jobSelectedServicePerforatingDispatchDetailsID)
			(select joboperationeventintervalid,jobOperationEventID,eventIntervalStartDepth,eventIntervalStopDepth,eventIntervalOrder,deleted,jobSelectedServicePerforatingDispatchDetailsID from joboperationeventintervals where joboperationeventid in (select joboperationeventid from #TEMPJOBOPERATIONEVENT))
--insert failures later
		insert into #TEMPJOBCHARGES(jobchargeid,jobActualServiceID,pricingStyleID,serviceDetailID,itemQuantity,isPercentage,deleted,jobOperationID,jobID,itemPrice,parentJobChargeID,discount,total,comments)
			(select jobchargeid,jobActualServiceID,pricingStyleID,serviceDetailID,itemQuantity,isPercentage,deleted,jobOperationID,jobID,itemPrice,parentJobChargeID,discount,total,comments from jobcharges where jobid = @jobid)
		insert into #TEMPJOBCUSTOMERCOUNTS(customercountsid,jobID,PersonnelRating,EquipmentRating,CommunicationRating,HSSERating,OverallRating,CompanyComments,DeclinedSurvey)
			(select customercountsid,jobID,PersonnelRating,EquipmentRating,CommunicationRating,HSSERating,OverallRating,CompanyComments,DeclinedSurvey from jobcustomercounts where jobid = @jobid)
		insert into #TEMPJOBBONUS(jobbonusid,jobBonusTypeID,jobBonusStatusID,jobCrewID,deleted,IsApproved,dateApproved)
			(select jobbonusid,jobBonusTypeID,jobBonusStatusID,jobCrewID,deleted,IsApproved,dateApproved from jobbonus where jobcrewid in (select jobcrewid from #TEMPJOBCREW))
		insert into #TEMPJOBBONUSDATA(jobbonusdataid,jobBonusID,jobActualServiceID,bonusPercentage,bonusTotal,deleted,bonusNumberOfDays,bonusDayRate,serviceOrTicketTotal,splitPercentage,failurePercentage)
			(select jobbonusdataid,jobBonusID,jobActualServiceID,bonusPercentage,bonusTotal,deleted,bonusNumberOfDays,bonusDayRate,serviceOrTicketTotal,splitPercentage,failurePercentage from jobbonusdata where jobbonusid in (select jobbonusid from #TEMPJOBBONUS))


		--updates for the temp tables creation of new foreign keys, updates to any and all old foreign keys.


			--updates to jobid
				SET @date = GETDATE()
				SET @newjobid = newid()
				update #TEMPJOB set jobid = @newjobid
				update #TEMPJOBCONTACTS set jobid = @newjobid
				update #TEMPJOBCREW set jobid = @newjobid
				update #TEMPJOBASSETS set jobid = @newjobid
				update #TEMPJOBWELL set jobid = @newjobid
				update #TEMPJOBSELECTEDSERVICE set jobid = @newjobid
				update #TEMPJOBOPERATION set jobid = @newjobid
				update #TEMPJOBACTUALSERVICE set jobid = @newjobid
				update #TEMPJOBCHARGES set jobid = @newjobid
				update #TEMPJOBCUSTOMERCOUNTS set jobid = @newjobid

			--updates to jobwellids

				insert into @jobwellids(jobwellid) (select jobwellID from #TEMPJOBWELL)

				While (select Count(*) from @jobwellids where updateprocessed is null)  > 0
				Begin
					Select Top 1 @tempguid = jobwellid from @jobwellids where updateprocessed is null

						SET @newtempguid = newid()

						update @jobwellids set newjobwellid = @newtempguid where jobwellid = @tempguid
						update #TEMPJOBWELLCASINGTUBINGPROFILE set jobwellid = @newtempguid where jobwellid = @tempguid
						update #TEMPJOBWELLBOREHOLEPROFILE set jobwellid = @newtempguid where jobwellid = @tempguid
						update #TEMPJOBWELL set jobwellid = @newtempguid where jobwellid = @tempguid

					update @jobwellids set updateprocessed = 1 where jobwellid = @tempguid
				End

			--updates to jobcrewids

				insert into @jobcrewids(jobcrewid) (select jobcrewid from #TEMPJOBCREW)

				while (select count(*) from @jobcrewids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobcrewid from @jobcrewids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobcrewids set newjobcrewid = @newtempguid where jobcrewid = @tempguid
						update #TEMPJOBBONUS set jobcrewid = @newtempguid where jobcrewid = @tempguid
						update #TEMPJOBCREW set jobcrewid = @newtempguid where jobcrewid = @tempguid

					update @jobcrewids set updateprocessed = 1 where jobcrewid = @tempguid
				End

			--updates to jobselectedserviceids

				insert into @jobselectedserviceids(jobselectedserviceid) (select jobselectedserviceid from #TEMPJOBSELECTEDSERVICE)

				while (select count(*) from @jobselectedserviceids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobselectedserviceid from @jobselectedserviceids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobselectedserviceids set newjobselectedserviceid = @newtempguid where jobselectedserviceid = @tempguid
						update #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL set jobselectedserviceid = @newtempguid where jobselectedserviceid = @tempguid
						update #TEMPJOBSELECTEDSERVICE set jobselectedserviceid = @newtempguid where jobselectedserviceid = @tempguid

					update @jobselectedserviceids set updateprocessed = 1 where jobselectedserviceid = @tempguid
				End

			--updates to jobselectedservicedispatchdetailids

				insert into @jobselectedservicedispatchdetailids(jobselectedservicedispatchdetailsid) (select jobselectedservicedispatchdetailid from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL)

				while (select count(*) from @jobselectedservicedispatchdetailids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobselectedservicedispatchdetailsid from @jobselectedservicedispatchdetailids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobselectedservicedispatchdetailids set newjobselectedservicedispatchdetailsid = @newtempguid where jobselectedservicedispatchdetailsid = @tempguid
						update #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL set jobselectedservicedispatchdetailid = @newtempguid where jobselectedservicedispatchdetailid = @tempguid
						update #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL set jobselectedservicedispatchdetailid = @newtempguid where jobselectedservicedispatchdetailid = @tempguid
						update #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL set jobselectedservicedispatchdetailid = @newtempguid where jobselectedservicedispatchdetailid = @tempguid
						update #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL set jobselectedservicedispatchdetailid = @newtempguid where jobselectedservicedispatchdetailid = @tempguid

					update @jobselectedservicedispatchdetailids set updateprocessed = 1 where jobselectedservicedispatchdetailsid = @tempguid
				End

			--updates to joboperationids

				insert into @joboperationids(joboperationid) (select joboperationid from #TEMPJOBOPERATION)

				while (select count(*) from @joboperationids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = joboperationid from @joboperationids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @joboperationids set newjoboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBOPERATIONTOOL set joboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBOPERATIONEVENT set joboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBOPERATIONAUXDATA set joboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBCHARGES set joboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBOPERATION set joboperationid = @newtempguid where joboperationid = @tempguid

					update @joboperationids set updateprocessed = 1 where joboperationid = @tempguid
				End

			--updates to joboperationeventids

				insert into @joboperationeventids(joboperationeventid) (select joboperationeventid from #TEMPJOBOPERATIONEVENT)

				while (select count(*) from @joboperationeventids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = joboperationeventid from @joboperationeventids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @joboperationeventids set newjoboperationeventid = @newtempguid where joboperationeventid = @tempguid
						update #TEMPJOBOPERATIONEVENTINTERVAL set joboperationeventid = @newtempguid where joboperationeventid = @tempguid
						update #TEMPJOBOPERATIONEVENT set joboperationeventid = @newtempguid where joboperationeventid = @tempguid

					update @joboperationeventids set updateprocessed = 1 where joboperationeventid = @tempguid
				End

			--updates to jobactualserviceids

				insert into @jobactualserviceids(jobactualserviceid) (select jobactualserviceid from #TEMPJOBACTUALSERVICE)

				while (select count(*) from @jobactualserviceids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobactualserviceid from @jobactualserviceids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobactualserviceids set newjobactualserviceid = @newtempguid where jobactualserviceid = @tempguid
						update #TEMPJOBBONUSDATA set jobactualserviceid = @newtempguid where jobactualserviceid = @tempguid
						update #TEMPJOBCHARGES set jobactualserviceid = @newtempguid where jobactualserviceid = @tempguid
						update #TEMPJOBACTUALSERVICE set jobactualserviceid = @newtempguid where jobactualserviceid = @tempguid

					update @jobactualserviceids set updateprocessed = 1 where jobactualserviceid = @tempguid
				End

			--updates to jobbonusids

				insert into @jobbonusids(jobbonusid) (select jobbonusid from #TEMPJOBBONUS)

				while (select count(*) from @jobbonusids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobbonusid from @jobbonusids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobbonusids set newjobbonusid = @newtempguid where jobbonusid = @tempguid
						update #TEMPJOBBONUSDATA set jobbonusid = @newtempguid where jobbonusid = @tempguid
						update #TEMPJOBBONUS set jobbonusid = @newtempguid where jobbonusid = @tempguid

					update @jobbonusids set updateprocessed = 1 where jobbonusid = @tempguid
				End

			--updates to @joboperationeventintervalids

			--	insert into @joboperationeventintervals(joboperationeventintervalid) (select joboperationeventintervalid from #TEMPJOBOPERATIONEVENTINTERVAL)

			--	while (select count(*) from @joboperationeventintervals where updateprocessed is null) > 0
			--	Begin
			--		Select top 1 @tempguid = joboperationeventintervalid from @joboperationeventintervals where updateprocessed is null
						
			--			SET @newtempguid = newid()

			--			update @joboperationeventintervals set newjoboperationeventintervalid = @newtempguid where joboperationeventintervalid = @tempguid-						update #TEMPJOBBONUSDATA set joboperationeventintervalid = @newtempguid where joboperationeventintervalid = @tempguid
			--			update #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL set joboperationeventintervalid = @newtempguid where joboperationeventintervalid = @tempguid
			--			update #TEMPJOBOPERATIONEVENTINTERVAL set joboperationeventintervalid = @newtempguid where joboperationeventintervalid = @tempguid

			--		update @joboperationeventintervals set updateprocessed = 1 where joboperationeventintervalid = @tempguid
			--	End

			--updates to @joboperationtoolids

				insert into @joboperationtools(joboperationtoolid) (select joboperationtoolid from #TEMPJOBOPERATIONTOOL)

				while (select count(*) from @joboperationtools where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = joboperationtoolid from @joboperationtools where updateprocessed is null
						
						SET @newtempguid = newid()

						update @joboperationtools set newjoboperationtoolid = @newtempguid where joboperationtoolid = @tempguid
						update #TEMPJOBACTUALSERVICE set joboperationtoolid = @newtempguid where joboperationtoolid = @tempguid
						update #TEMPJOBOPERATIONTOOL set joboperationtoolid = @newtempguid where joboperationtoolid = @tempguid

					update @joboperationtools set updateprocessed = 1 where joboperationtoolid = @tempguid
				End
			

		--insert temp tables into real tables, straightforward insert, all work done in the updates section.

		insert into job(jobID,dateSubmitted,financialSystemTypeID,financialSystemID,financialsystempricebookgroupid,financialSystemPriceBookID,serviceOrder,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted,jobTypeID,oneViewCompanyID,oneViewAddressID,createdByEmployeeID,geoScienceStatusID,topsServiceOrderID,poNumber,quoteNumber,customerRepresentative,topsDistrictID,approvingManagerID,drivingInformation,operationalLocationID,geographicLocationID,jobCancelledReasonID,jobCancelledReasonComment,jobCancelledReasonJobID,rentalChargeTypeID,rentalCompanyName,rentalPhoneNumber,rentalContactName,rentalItems,quoteID) 
			(select jobID,dateSubmitted,financialSystemTypeID,financialSystemID,financialsystempricebookgroupid,financialSystemPriceBookID,@user,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted,jobTypeID,oneViewCompanyID,oneViewAddressID,createdByEmployeeID,geoScienceStatusID,topsServiceOrderID,poNumber,quoteNumber,customerRepresentative,topsDistrictID,approvingManagerID,drivingInformation,operationalLocationID,geographicLocationID,jobCancelledReasonID,jobCancelledReasonComment,jobCancelledReasonJobID,rentalChargeTypeID,rentalCompanyName,rentalPhoneNumber,rentalContactName,rentalItems,quoteID  from #TEMPJOB)
		insert into jobcontacts(jobcontactID,personID,jobID) 
			(select newid(),personID,jobID from #TEMPJOBCONTACTS)
		insert into jobcrew(jobcrewID,jobID,employeeID,feCellRoleID ) 
			(select jobcrewID,jobID,employeeID,feCellRoleID  from #TEMPJOBCREW)
		insert into jobassets(jobassetID,jobid,assetID ) 
			(select newid(),jobid,assetID from #TEMPJOBASSETS)
		insert into jobwells(jobwellID,jobID,rigName,rigTypeID,drillingFluidTypeID,bottomHolePressure,bottomHoleTemperature,comments,maxDeviation,maxDogLeg,wellLocationTypeID,oneViewWellID,conveyanceTypeID,acquisitionTypeID,conveyanceSubTypeID,totalDepth,tightHole,deleted,seismicWellTypeID,kellyBushing,groundLevel,hasH2S,h2sLevel,hasCO2,co2Level,shutInPressure,flowingPressure,hasWirelineControlValve,surfacePressure,minimumID,wellHead,isLubricatorRequired,isGreaseInjectorRequired,lubricatorType,greaseInjectorType,mudDensity,mudViscosity,casingShoe ) 
			(select jobwellID,jobID,rigName,rigTypeID,drillingFluidTypeID,bottomHolePressure,bottomHoleTemperature,comments,maxDeviation,maxDogLeg,wellLocationTypeID,oneViewWellID,conveyanceTypeID,acquisitionTypeID,conveyanceSubTypeID,totalDepth,tightHole,deleted,seismicWellTypeID,kellyBushing,groundLevel,hasH2S,h2sLevel,hasCO2,co2Level,shutInPressure,flowingPressure,hasWirelineControlValve,surfacePressure,minimumID,wellHead,isLubricatorRequired,isGreaseInjectorRequired,lubricatorType,greaseInjectorType,mudDensity,mudViscosity,casingShoe from #TEMPJOBWELL)
		insert into jobwellcasingtubingprofile(jobwellcasingtubingprofileID,jobWellID,casingDimensionID,casingTypeID,startDepth,endDepth )
			(select newid(),jobWellID,casingDimensionID,casingTypeID,startDepth,endDepth from #TEMPJOBWELLCASINGTUBINGPROFILE)
		insert into jobwellboreholeprofile(jobwellboreholeprofileID,jobWellID,bitSizeID,startDepth,endDepth ) 
			(select newid(),jobWellID,bitSizeID,startDepth,endDepth from #TEMPJOBWELLBOREHOLEPROFILE)
		insert into jobselectedservices(jobselectedserviceID,jobID,serviceGroupID,servicePerformed ) 
			(select jobselectedserviceID,jobID,serviceGroupID,servicePerformed from #TEMPJOBSELECTEDSERVICE)
		insert into jobselectedservicedispatchdetails(jobselectedservicedispatchdetailID,jobSelectedServiceID,deleted,comments) 
			(select jobselectedservicedispatchdetailID,jobSelectedServiceID,deleted,comments from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL )
		insert into jobselectedserviceperforatingdispatchdetails(jobselectedserviceperforatingdispatchdetailsID,ballisticGunTypeID,isSelectFire,ballisticDetonatorTypeID,ballisticGunSizeID,ballisticIgniterID,ballisticInitiatorTypeID,ballisticManufacturerID,ballisticPhasingID,ballisticTypeOfChargeID,gramWeight,orientedGun,deleted,jobSelectedServiceDispatchDetailID,ballisticSPFID ) 
			(select newid(),ballisticGunTypeID,isSelectFire,ballisticDetonatorTypeID,ballisticGunSizeID,ballisticIgniterID,ballisticInitiatorTypeID,ballisticManufacturerID,ballisticPhasingID,ballisticTypeOfChargeID,gramWeight,orientedGun,deleted,jobSelectedServiceDispatchDetailID,ballisticSPFID from #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL)
		insert into jobselectedservicepiperecoverydetails(jobselectedservicepiperecoverydetailID,jobSelectedServiceDispatchDetailID,connectionType,size,weight )	
			(select newid(),jobSelectedServiceDispatchDetailID,connectionType,size,weight from #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL)
		insert into jobselectedserviceassureconveyancedetails(jobselectedserviceassureconveyancedetailID,jobSelectedServiceDispatchDetailID,drillPipeODGrade,drillPipeThreadPattern,drillPipeSize,drillPipeWeight,drillPipeTube,drillPipeJoint,drillPipeCapacity,drillPipeNumberOfJoints,drillPipeAverageJointLength,drillPipeTotalLength,drillPipeCrossOverProvidedBy,hwDrillPipeODGrade,hwDrillPipeThreadPattern,hwDrillPipeSize,hwDrillPipeWeight,hwDrillPipeTube,hwDrillPipeJoint,hwDrillPipeCapacity,hwDrillPipeNumberOfJoints,hwDrillPipeAverageJointLength,hwDrillPipeTotalLength,hwDrillPipeScreenProvidedBy,pumpEfficiency,pumpMinStrokeRate,pumpMaxStrokeRate,pumpOutput,pumpStrokeLength,pumpLinerSize,pumpOtherLinerSize,pumpMaxSafeCirculatingPressure,pumpCirculatingStrokeRate,pumpCirculatingPressure,pumpMessengerWith,pumpRigPump,pumpTruck,pumpCrippleRig,pumpDivertFluidFromRig,mudSystemFrictionReducerUsed,mudSystemFrictionReducerDetail,depthSystemUsed,depthSystemDetail,driftingMethodDropCirculatingDrift,driftingMethodWhileStrappingIn,driftingMethodSignOff,driftingProvidedBy,loaderAvailableToUnloadDrillPipe,internalDrillPipeCoating,internalDrillPipeCoatingInspectionDate,otherComponentJars,otherComponentCollars,otherComponentScreens,otherComponentCorrosionRings,edrSystem,mudSystem,lostCirculatingRate,lcmContent,estimatedTripInTime,layingDownDrillPipe,deleted ) 
			(select newid(),jobSelectedServiceDispatchDetailID,drillPipeODGrade,drillPipeThreadPattern,drillPipeSize,drillPipeWeight,drillPipeTube,drillPipeJoint,drillPipeCapacity,drillPipeNumberOfJoints,drillPipeAverageJointLength,drillPipeTotalLength,drillPipeCrossOverProvidedBy,hwDrillPipeODGrade,hwDrillPipeThreadPattern,hwDrillPipeSize,hwDrillPipeWeight,hwDrillPipeTube,hwDrillPipeJoint,hwDrillPipeCapacity,hwDrillPipeNumberOfJoints,hwDrillPipeAverageJointLength,hwDrillPipeTotalLength,hwDrillPipeScreenProvidedBy,pumpEfficiency,pumpMinStrokeRate,pumpMaxStrokeRate,pumpOutput,pumpStrokeLength,pumpLinerSize,pumpOtherLinerSize,pumpMaxSafeCirculatingPressure,pumpCirculatingStrokeRate,pumpCirculatingPressure,pumpMessengerWith,pumpRigPump,pumpTruck,pumpCrippleRig,pumpDivertFluidFromRig,mudSystemFrictionReducerUsed,mudSystemFrictionReducerDetail,depthSystemUsed,depthSystemDetail,driftingMethodDropCirculatingDrift,driftingMethodWhileStrappingIn,driftingMethodSignOff,driftingProvidedBy,loaderAvailableToUnloadDrillPipe,internalDrillPipeCoating,internalDrillPipeCoatingInspectionDate,otherComponentJars,otherComponentCollars,otherComponentScreens,otherComponentCorrosionRings,edrSystem,mudSystem,lostCirculatingRate,lcmContent,estimatedTripInTime,layingDownDrillPipe,deleted from #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL)
		insert into joboperations(joboperationid,jobID,jobOperationTypeID,jobOperationStartTime,jobOperationEndTime,jobOperationComments ) 
			(select joboperationid,jobID,jobOperationTypeID,jobOperationStartTime,jobOperationEndTime,jobOperationComments from #TEMPJOBOPERATION)
		insert into joboperationtools(joboperationtoolid,jobOperationID,assetID,toolStringPosition ) 
			(select joboperationtoolid,jobOperationID,assetID,toolStringPosition from #TEMPJOBOPERATIONTOOL)
		insert into jobactualservices(jobactualserviceid,jobID,jobOperationToolID,serviceGroupID,timesRendered,renderedByEmployee2,renderedByEmployee,deleted,performed ) 
			(select jobactualserviceid,jobID,jobOperationToolID,serviceGroupID,timesRendered,renderedByEmployee2,renderedByEmployee,deleted,performed from #TEMPJOBACTUALSERVICE)
		insert into joboperationevents(joboperationeventid,jobOperationID,jobOperationEventOrder,jobOperationEventComments ) 
			(select joboperationeventid,jobOperationID,jobOperationEventOrder,jobOperationEventComments from #TEMPJOBOPERATIONEVENT)
		insert into joboperationauxdata(joboperationauxdataid,jobOperationID,qtyRequested,qtyAttempted,qtySuccessful,pressureAttempted,tightTests,noSeal,successfulTests,odometerStart,odometerEnd,startHours,endHours,temperature,deleted,pressureTestsAttempted,distanceTraveled,engineHours ) 
			(select newid(),jobOperationID,qtyRequested,qtyAttempted,qtySuccessful,pressureAttempted,tightTests,noSeal,successfulTests,odometerStart,odometerEnd,startHours,endHours,temperature,deleted,pressureTestsAttempted,distanceTraveled,engineHours from #TEMPJOBOPERATIONAUXDATA)
		insert into joboperationeventintervals(joboperationeventintervalid,jobOperationEventID,eventIntervalStartDepth,eventIntervalStopDepth,eventIntervalOrder,deleted,jobSelectedServicePerforatingDispatchDetailsID ) 
			(select newid(),jobOperationEventID,eventIntervalStartDepth,eventIntervalStopDepth,eventIntervalOrder,deleted,jobSelectedServicePerforatingDispatchDetailsID from #TEMPJOBOPERATIONEVENTINTERVAL)
		insert into jobcharges(jobchargeid,jobActualServiceID,pricingStyleID,serviceDetailID,itemQuantity,isPercentage,deleted,jobOperationID,jobID,itemPrice,parentJobChargeID,discount,total,comments ) 
			(select newid(),jobActualServiceID,pricingStyleID,serviceDetailID,itemQuantity,isPercentage,deleted,jobOperationID,jobID,itemPrice,parentJobChargeID,discount,total,comments from #TEMPJOBCHARGES)
		insert into jobcustomercounts(customercountsid,jobID,PersonnelRating,EquipmentRating,CommunicationRating,HSSERating,OverallRating,CompanyComments,DeclinedSurvey ) 
			(select newid(),jobID,PersonnelRating,EquipmentRating,CommunicationRating,HSSERating,OverallRating,CompanyComments,DeclinedSurvey from #TEMPJOBCUSTOMERCOUNTS)
		insert into jobbonus(jobbonusid,jobBonusTypeID,jobBonusStatusID,jobCrewID,deleted,IsApproved,dateApproved ) 
			(select jobbonusid,jobBonusTypeID,jobBonusStatusID,jobCrewID,deleted,IsApproved,dateApproved from #TEMPJOBBONUS)
		insert into jobbonusdata(jobbonusdataid,jobBonusID,jobActualServiceID,bonusPercentage,bonusTotal,deleted,bonusNumberOfDays,bonusDayRate,serviceOrTicketTotal,splitPercentage,failurePercentage ) 
			(select newid(),jobBonusID,jobActualServiceID,bonusPercentage,bonusTotal,deleted,bonusNumberOfDays,bonusDayRate,serviceOrTicketTotal,splitPercentage,failurePercentage from #TEMPJOBBONUSDATA)

		--drop all temp tables before exiting
		DROP TABLE #TEMPJOB
		DROP TABLE #TEMPJOBCONTACTS
		DROP TABLE #TEMPJOBCREW
		DROP TABLE #TEMPJOBASSETS
		DROP TABLE #TEMPJOBWELL
		DROP TABLE #TEMPJOBWELLCASINGTUBINGPROFILE
		DROP TABLE #TEMPJOBWELLBOREHOLEPROFILE
		DROP TABLE #TEMPJOBSELECTEDSERVICE
		DROP TABLE #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL
		DROP TABLE #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL
		DROP TABLE #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL
		DROP TABLE #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL
		DROP TABLE #TEMPJOBOPERATION
		DROP TABLE #TEMPJOBACTUALSERVICE
		DROP TABLE #TEMPJOBOPERATIONEVENT
		DROP TABLE #TEMPJOBOPERATIONTOOL
		DROP TABLE #TEMPJOBOPERATIONAUXDATA
		DROP TABLE #TEMPJOBOPERATIONEVENTINTERVAL
		DROP TABLE #TEMPJOBCHARGES
		DROP TABLE #TEMPJOBCUSTOMERCOUNTS
		DROP TABLE #TEMPJOBBONUS
		DROP TABLE #TEMPJOBBONUSDATA


		--commit transaction;
END
GO
/****** Object:  StoredProcedure [dbo].[MassCopyJobProcedure_JobOperationTools]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<McKeehan, Trevor>
-- Create date: <May 8th 2013>
-- Description:	This script is designed to make copies from a single job.
--2 arguments:
	--@jobid: the jobid of the job to copy
	--@user: user name that will be pre-pended to the serviceorder of the job.
-- =============================================

CREATE PROCEDURE [dbo].[MassCopyJobProcedure_JobOperationTools]
	-- Add the parameters for the stored procedure here
	@jobid uniqueidentifier,
	@user nvarchar(50)
AS
BEGIN

--begin transaction;
--temp tables to hold a copy of the real data
CREATE TABLE #TEMPJOB([jobID] [uniqueidentifier] NOT NULL, [dateSubmitted] [datetime] NOT NULL, [financialSystemTypeID] [int] NOT NULL, [financialSystemID] [nvarchar](50) NOT NULL, [financialSystemPriceBookGroupID] [int] NOT NULL, [financialSystemPriceBookID] [int] NOT NULL, [serviceOrder] [nvarchar](50) NULL, [scheduledStartDateTime] [datetime] NOT NULL, [actualStartDateTime] [datetime] NOT NULL, [geographicDistrictID] [int] NOT NULL, [endDateTime] [datetime] NOT NULL, [operatingDistrictID] [int] NOT NULL, [comments] [nvarchar](4000) NULL, [specialInstructions] [nvarchar](4000) NULL, [jobStatusID] [tinyint] NOT NULL, [deleted] [bit] NULL, [jobTypeID] [int] NOT NULL, [oneViewCompanyID] [uniqueidentifier] NOT NULL, [oneViewAddressID] [uniqueidentifier] NOT NULL, [createdByEmployeeID] [int] NULL, [geoScienceStatusID] [int] NULL, [topsServiceOrderID] [int] NULL, [poNumber] [nvarchar](50) NULL, [quoteNumber] [nvarchar](50) NULL, [customerRepresentative] [nvarchar](100) NULL, [topsDistrictID] [int] NULL, [approvingManagerID] [int] NULL, [drivingInformation] [nvarchar](4000) NULL, [geographicLocationID] [int] NULL, [operationalLocationID] [int] NULL, [revenueCenterID] [int] NULL, [jdeDeliveryTicketID] [int] NULL, [jdeDeliveryTicketCurrencyID] [int] NULL, [jobCancelledReasonID] [int] NULL, [jobCancelledReasonComment] [nvarchar](1000) NULL, [jobCancelledReasonJobID] [uniqueidentifier] NULL, [rentalChargeTypeID] [int] NULL, [rentalCompanyName] [nvarchar](150) NULL, [rentalPhoneNumber] [nvarchar](50) NULL, [rentalContactName] [nvarchar](100) NULL, [rentalItems] [nvarchar](4000) NULL, [approxTimeSelectionID] [int] NULL, [quoteID] [uniqueidentifier] NULL, [oneviewToJDEJobID] [int] NULL)
CREATE TABLE #TEMPJOBCONTACTS([jobContactID] [uniqueidentifier] NOT NULL,[personID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBCREW([jobCrewID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [employeeID] [int] NOT NULL, [feCellRoleID] [int] NOT NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBASSETS([jobAssetID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [assetID] [int] NOT NULL, [deleted] [bit] NULL,)
CREATE TABLE #TEMPJOBWELL([jobWellID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NULL, [rigName] [nvarchar](200) NULL, [rigTypeID] [int] NULL, [drillingFluidTypeID] [int] NULL, [bottomHolePressure] [float] NULL, [bottomHoleTemperature] [float] NULL, [comments] [nvarchar](4000) NULL, [maxDeviation] [float] NULL, [maxDogLeg] [float] NULL, [wellLocationTypeID] [int] NULL, [oneViewWellID] [uniqueidentifier] NOT NULL, [conveyanceTypeID] [int] NULL, [acquisitionTypeID] [int] NULL, [conveyanceSubTypeID] [int] NULL, [totalDepth] [float] NULL, [tightHole] [bit] NULL, [deleted] [bit] NULL, [seismicWellTypeID] [int] NULL, [kellyBushing] [float] NULL, [groundLevel] [float] NULL, [hasH2S] [bit] NULL, [h2sLevel] [float] NULL, [hasCO2] [bit] NULL, [co2Level] [float] NULL, [shutInPressure] [float] NULL, [flowingPressure] [float] NULL, [hasWirelineControlValve] [bit] NULL, [surfacePressure] [float] NULL, [minimumID] [float] NULL, [wellHeadSize] [nvarchar](50) NULL, [wellHead] [nvarchar](100) NULL, [isLubricatorRequired] [bit] NULL, [isGreaseInjectorRequired] [bit] NULL, [lubricatorType] [nvarchar](100) NULL, [greaseInjectorType] [nvarchar](100) NULL, [mudDensity] [nvarchar](50) NULL, [mudViscosity] [nvarchar](50) NULL, [casingShoe] [decimal](18, 9) NULL,)
CREATE TABLE #TEMPJOBWELLCASINGTUBINGPROFILE([jobWellCasingTubingProfileID] [uniqueidentifier] NOT NULL, [jobWellID] [uniqueidentifier] NOT NULL, [casingDimensionID] [uniqueidentifier] NOT NULL, [casingTypeID] [int] NOT NULL, [startDepth] [float] NOT NULL, [endDepth] [float] NOT NULL, [deleted] [bit] NULL, [casingShoe] [decimal](18, 9) NULL,)
CREATE TABLE #TEMPJOBWELLBOREHOLEPROFILE([jobWellBoreholeProfileID] [uniqueidentifier] NOT NULL, [jobWellID] [uniqueidentifier] NOT NULL, [bitSizeID] [uniqueidentifier] NOT NULL, [startDepth] [float] NOT NULL, [endDepth] [float] NOT NULL, [deleted] [bit] NULL,)
CREATE TABLE #TEMPJOBSELECTEDSERVICE([jobSelectedServiceID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [serviceGroupID] [int] NOT NULL, [servicePerformed] [bit] NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL([jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL, [jobSelectedServiceID] [uniqueidentifier] NOT NULL, [comments] [nvarchar](4000) NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL([jobSelectedServicePerforatingDispatchDetailsID] [uniqueidentifier] NOT NULL, [ballisticGunTypeID] [int] NULL, [isSelectFire] [bit] NULL, [ballisticDetonatorTypeID] [int] NULL, [ballisticGunSizeID] [int] NULL, [ballisticIgniterID] [int] NULL, [ballisticInitiatorTypeID] [int] NULL, [ballisticManufacturerID] [int] NULL, [ballisticPhasingID] [int] NULL, [ballisticTypeOfChargeID] [int] NULL, [gramWeight] [float] NULL, [orientedGun] [bit] NULL, [deleted] [bit] NULL, [jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL, [ballisticSPFID] [int] NULL)
CREATE TABLE #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL([jobSelectedServicePipeRecoveryDetailID] [uniqueidentifier] NOT NULL, [jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL, [connectionType] [nvarchar](255) NULL, [size] [float] NULL, [weight] [float] NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL([jobSelectedServiceAssureConveyanceDetailID] [uniqueidentifier] NOT NULL, [jobSelectedServiceDispatchDetailID] [uniqueidentifier] NOT NULL, [drillPipeODGrade] [nvarchar](50) NULL, [drillPipeThreadPattern] [nvarchar](50) NULL, [drillPipeSize] [decimal](18, 9) NULL, [drillPipeWeight] [decimal](18, 9) NULL, [drillPipeTube] [decimal](18, 9) NULL, [drillPipeJoint] [decimal](18, 9) NULL, [drillPipeCapacity] [decimal](18, 9) NULL, [drillPipeNumberOfJoints] [int] NULL, [drillPipeAverageJointLength] [decimal](18, 9) NULL, [drillPipeTotalLength] [decimal](18, 9) NULL, [drillPipeCrossOverProvidedBy] [nvarchar](50) NULL, [hwDrillPipeODGrade] [nvarchar](50) NULL, [hwDrillPipeThreadPattern] [nvarchar](50) NULL, [hwDrillPipeSize] [decimal](18, 9) NULL, [hwDrillPipeWeight] [decimal](18, 9) NULL, [hwDrillPipeTube] [decimal](18, 9) NULL, [hwDrillPipeJoint] [decimal](18, 9) NULL, [hwDrillPipeCapacity] [decimal](18, 9) NULL, [hwDrillPipeNumberOfJoints] [int] NULL, [hwDrillPipeAverageJointLength] [decimal](18, 9) NULL, [hwDrillPipeTotalLength] [decimal](18, 9) NULL, [hwDrillPipeScreenProvidedBy] [nvarchar](50) NULL, [pumpEfficiency] [decimal](18, 9) NULL, [pumpMinStrokeRate] [int] NULL, [pumpMaxStrokeRate] [int] NULL, [pumpOutput] [decimal](18, 9) NULL, [pumpStrokeLength] [decimal](18, 9) NULL, [pumpLinerSize] [decimal](18, 9) NULL, [pumpOtherLinerSize] [decimal](18, 9) NULL, [pumpMaxSafeCirculatingPressure] [decimal](18, 9) NULL, [pumpCirculatingStrokeRate] [int] NULL, [pumpCirculatingPressure] [decimal](18, 9) NULL, [pumpMessengerWith] [nvarchar](50) NULL, [pumpRigPump] [bit] NULL, [pumpTruck] [bit] NULL, [pumpCrippleRig] [bit] NULL, [pumpDivertFluidFromRig] [bit] NULL, [mudSystemFrictionReducerUsed] [bit] NULL, [mudSystemFrictionReducerDetail] [nvarchar](50) NULL, [depthSystemUsed] [bit] NULL, [depthSystemDetail] [nvarchar](50) NULL, [driftingMethodDropCirculatingDrift] [bit] NULL, [driftingMethodWhileStrappingIn] [bit] NULL, [driftingMethodSignOff] [bit] NULL, [driftingProvidedBy] [nvarchar](50) NULL, [loaderAvailableToUnloadDrillPipe] [bit] NULL, [internalDrillPipeCoating] [bit] NULL, [internalDrillPipeCoatingInspectionDate] [datetime] NULL, [otherComponentJars] [bit] NULL, [otherComponentCollars] [bit] NULL, [otherComponentScreens] [bit] NULL, [otherComponentCorrosionRings] [bit] NULL, [edrSystem] [nvarchar](50) NULL, [mudSystem] [nvarchar](50) NULL, [lostCirculatingRate] [nvarchar](50) NULL, [lcmContent] [nvarchar](50) NULL, [estimatedTripInTime] [nvarchar](50) NULL, [layingDownDrillPipe] [nvarchar](50) NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBOPERATION([jobOperationID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [jobOperationTypeID] [int] NOT NULL, [jobOperationStartTime] [datetime] NOT NULL, [jobOperationEndTime] [datetime] NOT NULL, [jobOperationComments] [ntext] NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBACTUALSERVICE([jobActualServiceID] [uniqueidentifier] NOT NULL, [jobID] [uniqueidentifier] NOT NULL, [jobOperationToolID] [uniqueidentifier] NOT NULL, [serviceGroupID] [int] NOT NULL, [timesRendered] [int] NOT NULL, [renderedByEmployee2] [int] NULL, [renderedByEmployee] [int] NULL, [deleted] [bit] NULL, [performed] [bit] NULL)
CREATE TABLE #TEMPJOBOPERATIONEVENT([jobOperationEventID] [uniqueidentifier] NOT NULL, [jobOperationID] [uniqueidentifier] NOT NULL, [jobOperationEventOrder] [int] NOT NULL, [jobOperationEventComments] [ntext] NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBOPERATIONTOOL([jobOperationToolID] [uniqueidentifier] NOT NULL, [jobOperationID] [uniqueidentifier] NOT NULL, [assetID] [int] NOT NULL, [toolStringPosition] [int] NOT NULL, [deleted] [bit] NULL)
CREATE TABLE #TEMPJOBOPERATIONAUXDATA([jobOperationAuxDataID] [uniqueidentifier] NOT NULL, [jobOperationID] [uniqueidentifier] NOT NULL, [qtyRequested] [int] NULL, [qtyAttempted] [int] NULL, [qtySuccessful] [int] NULL, [pressureAttempted] [float] NULL, [tightTests] [int] NULL, [noSeal] [int] NULL, [successfulTests] [int] NULL, [odometerStart] [float] NULL, [odometerEnd] [float] NULL, [startHours] [float] NULL, [endHours] [float] NULL, [temperature] [float] NULL, [deleted] [bit] NULL, [pressureTestsAttempted] [int] NULL, [distanceTraveled] [float] NULL, [engineHours] [float] NULL)
--CREATE TABLE #TEMPJOBOPERATIONEVENTAUXDATA([auxillaryDataID] [uniqueidentifier] NOT NULL, [jobOperationEventID] [uniqueidentifier] NOT NULL)
CREATE TABLE #TEMPJOBOPERATIONEVENTINTERVAL([jobOperationEventIntervalID] [uniqueidentifier] NOT NULL, [jobOperationEventID] [uniqueidentifier] NULL, [eventIntervalStartDepth] [float] NOT NULL, [eventIntervalStopDepth] [float] NULL, [eventIntervalOrder] [int] NOT NULL, [deleted] [bit] NULL, [jobSelectedServicePerforatingDispatchDetailsID] [uniqueidentifier] NULL)
--create failure tables at a later time
CREATE TABLE #TEMPJOBCHARGES([jobChargeID] [uniqueidentifier] NOT NULL,	[jobActualServiceID] [uniqueidentifier] NULL,	[pricingStyleID] [int] NULL,	[serviceDetailID] [int] NULL,	[itemQuantity] [decimal](18, 9) NULL,	[isPercentage] [bit] NULL,	[deleted] [bit] NULL,	[jobOperationID] [uniqueidentifier] NULL,	[jobID] [uniqueidentifier] NOT NULL,	[itemPrice] [decimal](18, 9) NULL,	[parentJobChargeID] [uniqueidentifier] NULL,	[discount] [decimal](18, 9) NULL,	[total] [decimal](18, 9) NULL,	[comments] [nvarchar](4000) NULL,	[adjustedItemQuantity] [decimal](18, 9) NULL,	[adjustedItemPrice] [decimal](18, 9) NULL,	[adjustedDiscount] [decimal](18, 9) NULL,	[adjustedTotal] [decimal](18, 9) NULL)
CREATE TABLE #TEMPJOBCUSTOMERCOUNTS([customerCountsID] [uniqueidentifier] NOT NULL,	[jobID] [uniqueidentifier] NOT NULL,	[PersonnelRating] [int] NULL,	[EquipmentRating] [int] NULL,	[CommunicationRating] [int] NULL,	[HSSERating] [int] NULL,	[OverallRating] [int] NULL,	[CompanyComments] [ntext] NULL,	[DeclinedSurvey] [bit] NULL)
CREATE TABLE #TEMPJOBBONUS([jobBonusID] [uniqueidentifier] NOT NULL,	[jobBonusTypeID] [int] NOT NULL,	[jobBonusStatusID] [int] NULL,	[jobCrewID] [uniqueidentifier] NOT NULL,	[deleted] [bit] NULL,	[IsApproved] [bit] NULL,	[dateApproved] [datetime] NULL)
CREATE TABLE #TEMPJOBBONUSDATA([jobBonusDataID] [uniqueidentifier] NOT NULL,	[jobBonusID] [uniqueidentifier] NOT NULL,	[jobActualServiceID] [uniqueidentifier] NULL,	[bonusPercentage] [decimal](18, 9) NULL,	[bonusTotal] [decimal](18, 9) NULL,	[deleted] [bit] NULL,	[bonusNumberOfDays] [decimal](18, 9) NULL,	[bonusDayRate] [decimal](18, 9) NULL,	[serviceOrTicketTotal] [decimal](18, 9) NULL,	[splitPercentage] [decimal](18, 9) NULL,	[failurePercentage] [decimal](18, 9) NULL)

--CREATE TABLE temptbl_masscopy(name nvarchar(50) NOT NULL, processed bit NOT NULL)--CREATE TABLE temptbl_lookup(lookupid uniqueidentifier NOT NULL, typeid int NOT NULL)
--CREATE TABLE temptbl_newfk(fkid uniqueidentifier NOT NULL, fkname nvarchar(50) NOT NULL) 

SET NOCOUNT ON;

	DECLARE @pos        int,
            @nextpos    int,
            @valuelen   int,
		    @username nvarchar(50),
			@newjobid uniqueidentifier,
			@tempguid uniqueidentifier,
			@newtempguid uniqueidentifier,
			@date DATETIME

	--table variables to keep track of the oldids, their related newly generatedids, also servea as the loop variables.
	DECLARE	@jobwellids TABLE(jobwellid uniqueidentifier, newjobwellid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobcrewids TABLE(jobcrewid uniqueidentifier, newjobcrewid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobselectedserviceids TABLE(jobselectedserviceid uniqueidentifier, newjobselectedserviceid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobselectedservicedispatchdetailids TABLE(jobselectedservicedispatchdetailsid uniqueidentifier NULL, newjobselectedservicedispatchdetailsid uniqueidentifier, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @joboperationids TABLE(joboperationid uniqueidentifier, newjoboperationid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobactualserviceids TABLE(jobactualserviceid uniqueidentifier, newjobactualserviceid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @joboperationeventids TABLE(joboperationeventid uniqueidentifier, newjoboperationeventid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @jobbonusids TABLE(jobbonusid uniqueidentifier, newjobbonusid uniqueidentifier NULL, updateprocessed bit NULL, insertprocessed bit NULL)
	--DECLARE @joboperationeventintervals TABLE(joboperationeventintervalid uniqueidentifier, newjoboperationeventintervalid uniqueidentifier, updateprocessed bit NULL, insertprocessed bit NULL)
	DECLARE @joboperationtools TABLE(joboperationtoolid uniqueidentifier, newjoboperationtoolid uniqueidentifier, updateprocessed bit NULL, insertprocessed bit NULL)


		--inserts statements into temp tables from original tables
		insert into #TEMPJOB(jobID,dateSubmitted,financialSystemTypeID,financialSystemID,financialSystemPriceBookGroupID,financialSystemPriceBookID,serviceOrder,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted,jobTypeID,oneViewCompanyID,oneViewAddressID,createdByEmployeeID,geoScienceStatusID,topsServiceOrderID,poNumber,quoteNumber,customerRepresentative,topsDistrictID,approvingManagerID,drivingInformation,operationalLocationID,geographicLocationID,jobCancelledReasonID,jobCancelledReasonComment,jobCancelledReasonJobID,rentalChargeTypeID,rentalCompanyName,rentalPhoneNumber,rentalContactName,rentalItems,quoteID) 
			(select jobID,dateSubmitted,financialSystemTypeID,financialSystemID,financialsystempricebookgroupid,financialSystemPriceBookID,serviceOrder,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted,jobTypeID,oneViewCompanyID,oneViewAddressID,createdByEmployeeID,geoScienceStatusID,topsServiceOrderID,poNumber,quoteNumber,customerRepresentative,topsDistrictID,approvingManagerID,drivingInformation,operationalLocationID,geographicLocationID,jobCancelledReasonID,jobCancelledReasonComment,jobCancelledReasonJobID,rentalChargeTypeID,rentalCompanyName,rentalPhoneNumber,rentalContactName,rentalItems,quoteID from job where jobID = @jobid)
		insert into #TEMPJOBCONTACTS(jobcontactID,personID,jobID) 
			(select jobcontactID,personID,jobID from jobcontacts where jobID = @jobid)
		insert into #TEMPJOBCREW(jobcrewID,jobID,employeeID,feCellRoleID)
			(select jobcrewID,jobID,employeeID,feCellRoleID from jobcrew where jobID = @jobid)
		insert into #TEMPJOBASSETS(jobassetID,jobid,assetID) 
			(select jobassetID,jobid,assetID from jobassets where jobid = @jobid)
		insert into #TEMPJOBWELL(jobwellID,jobID,rigName,rigTypeID,drillingFluidTypeID,bottomHolePressure,bottomHoleTemperature,comments,maxDeviation,maxDogLeg,wellLocationTypeID,oneViewWellID,conveyanceTypeID,acquisitionTypeID,conveyanceSubTypeID,totalDepth,tightHole,deleted,seismicWellTypeID,kellyBushing,groundLevel,hasH2S,h2sLevel,hasCO2,co2Level,shutInPressure,flowingPressure,hasWirelineControlValve,surfacePressure,minimumID,wellHead,isLubricatorRequired,isGreaseInjectorRequired,lubricatorType,greaseInjectorType,mudDensity,mudViscosity,casingShoe) 
			(select jobwellID,jobID,rigName,rigTypeID,drillingFluidTypeID,bottomHolePressure,bottomHoleTemperature,comments,maxDeviation,maxDogLeg,wellLocationTypeID,oneViewWellID,conveyanceTypeID,acquisitionTypeID,conveyanceSubTypeID,totalDepth,tightHole,deleted,seismicWellTypeID,kellyBushing,groundLevel,hasH2S,h2sLevel,hasCO2,co2Level,shutInPressure,flowingPressure,hasWirelineControlValve,surfacePressure,minimumID,wellHead,isLubricatorRequired,isGreaseInjectorRequired,lubricatorType,greaseInjectorType,mudDensity,mudViscosity,casingShoe from jobwells where jobid = @jobid)
		insert into #TEMPJOBWELLCASINGTUBINGPROFILE(jobwellcasingtubingprofileID,jobWellID,casingDimensionID,casingTypeID,startDepth,endDepth) 
			(select jobwellcasingtubingprofileID,jobWellID,casingDimensionID,casingTypeID,startDepth,endDepth from jobwellcasingtubingprofile where jobwellid in (select jobwellid from #TEMPJOBWELL))
		insert into #TEMPJOBWELLBOREHOLEPROFILE(jobwellboreholeprofileID,jobWellID,bitSizeID,startDepth,endDepth) 
			(select jobwellboreholeprofileID,jobWellID,bitSizeID,startDepth,endDepth from jobwellboreholeprofile where jobwellid in (select jobwellid from #TEMPJOBWELL))
		insert into #TEMPJOBSELECTEDSERVICE(jobselectedserviceID,jobID,serviceGroupID,servicePerformed)
			(select jobselectedserviceID,jobID,serviceGroupID,servicePerformed from jobselectedservices where jobid = @jobid)
		insert into #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL(jobselectedservicedispatchdetailID,jobSelectedServiceID,deleted,comments)
			(select jobselectedservicedispatchdetailID,jobSelectedServiceID,deleted,comments from jobselectedservicedispatchdetails where jobselectedserviceid in (select jobselectedserviceid from #TEMPJOBSELECTEDSERVICE))
		insert into #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL(jobselectedserviceperforatingdispatchdetailsID,ballisticGunTypeID,isSelectFire,ballisticDetonatorTypeID,ballisticGunSizeID,ballisticIgniterID,ballisticInitiatorTypeID,ballisticManufacturerID,ballisticPhasingID,ballisticTypeOfChargeID,gramWeight,orientedGun,deleted,jobSelectedServiceDispatchDetailID,ballisticSPFID)
			(select jobselectedserviceperforatingdispatchdetailsID,ballisticGunTypeID,isSelectFire,ballisticDetonatorTypeID,ballisticGunSizeID,ballisticIgniterID,ballisticInitiatorTypeID,ballisticManufacturerID,ballisticPhasingID,ballisticTypeOfChargeID,gramWeight,orientedGun,deleted,jobSelectedServiceDispatchDetailID,ballisticSPFID from JobSelectedServicePerforatingDispatchDetails where jobselectedservicedispatchdetailID in (select jobselectedservicedispatchdetailID from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL))
		insert into #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL(jobselectedservicepiperecoverydetailID,jobSelectedServiceDispatchDetailID,connectionType,size,weight)
			(select jobselectedservicepiperecoverydetailID,jobSelectedServiceDispatchDetailID,connectionType,size,weight from JobSelectedServicePipeRecoveryDetails where jobselectedservicedispatchdetailID in (select jobselectedservicedispatchdetailID from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL))
		insert into #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL(jobselectedserviceassureconveyancedetailID,jobSelectedServiceDispatchDetailID,drillPipeODGrade,drillPipeThreadPattern,drillPipeSize,drillPipeWeight,drillPipeTube,drillPipeJoint,drillPipeCapacity,drillPipeNumberOfJoints,drillPipeAverageJointLength,drillPipeTotalLength,drillPipeCrossOverProvidedBy,hwDrillPipeODGrade,hwDrillPipeThreadPattern,hwDrillPipeSize,hwDrillPipeWeight,hwDrillPipeTube,hwDrillPipeJoint,hwDrillPipeCapacity,hwDrillPipeNumberOfJoints,hwDrillPipeAverageJointLength,hwDrillPipeTotalLength,hwDrillPipeScreenProvidedBy,pumpEfficiency,pumpMinStrokeRate,pumpMaxStrokeRate,pumpOutput,pumpStrokeLength,pumpLinerSize,pumpOtherLinerSize,pumpMaxSafeCirculatingPressure,pumpCirculatingStrokeRate,pumpCirculatingPressure,pumpMessengerWith,pumpRigPump,pumpTruck,pumpCrippleRig,pumpDivertFluidFromRig,mudSystemFrictionReducerUsed,mudSystemFrictionReducerDetail,depthSystemUsed,depthSystemDetail,driftingMethodDropCirculatingDrift,driftingMethodWhileStrappingIn,driftingMethodSignOff,driftingProvidedBy,loaderAvailableToUnloadDrillPipe,internalDrillPipeCoating,internalDrillPipeCoatingInspectionDate,otherComponentJars,otherComponentCollars,otherComponentScreens,otherComponentCorrosionRings,edrSystem,mudSystem,lostCirculatingRate,lcmContent,estimatedTripInTime,layingDownDrillPipe,deleted)
			(select jobselectedserviceassureconveyancedetailID,jobSelectedServiceDispatchDetailID,drillPipeODGrade,drillPipeThreadPattern,drillPipeSize,drillPipeWeight,drillPipeTube,drillPipeJoint,drillPipeCapacity,drillPipeNumberOfJoints,drillPipeAverageJointLength,drillPipeTotalLength,drillPipeCrossOverProvidedBy,hwDrillPipeODGrade,hwDrillPipeThreadPattern,hwDrillPipeSize,hwDrillPipeWeight,hwDrillPipeTube,hwDrillPipeJoint,hwDrillPipeCapacity,hwDrillPipeNumberOfJoints,hwDrillPipeAverageJointLength,hwDrillPipeTotalLength,hwDrillPipeScreenProvidedBy,pumpEfficiency,pumpMinStrokeRate,pumpMaxStrokeRate,pumpOutput,pumpStrokeLength,pumpLinerSize,pumpOtherLinerSize,pumpMaxSafeCirculatingPressure,pumpCirculatingStrokeRate,pumpCirculatingPressure,pumpMessengerWith,pumpRigPump,pumpTruck,pumpCrippleRig,pumpDivertFluidFromRig,mudSystemFrictionReducerUsed,mudSystemFrictionReducerDetail,depthSystemUsed,depthSystemDetail,driftingMethodDropCirculatingDrift,driftingMethodWhileStrappingIn,driftingMethodSignOff,driftingProvidedBy,loaderAvailableToUnloadDrillPipe,internalDrillPipeCoating,internalDrillPipeCoatingInspectionDate,otherComponentJars,otherComponentCollars,otherComponentScreens,otherComponentCorrosionRings,edrSystem,mudSystem,lostCirculatingRate,lcmContent,estimatedTripInTime,layingDownDrillPipe,deleted from JobSelectedServiceAssureConveyanceDetails where jobselectedservicedispatchdetailID in (select jobselectedservicedispatchdetailID from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL))
		insert into #TEMPJOBOPERATION(joboperationid,jobID,jobOperationTypeID,jobOperationStartTime,jobOperationEndTime,jobOperationComments)
			(select joboperationid,jobID,jobOperationTypeID,jobOperationStartTime,jobOperationEndTime,jobOperationComments from joboperations where jobid = @jobid)
		insert into #TEMPJOBACTUALSERVICE(jobactualserviceid,jobID,jobOperationToolID,serviceGroupID,timesRendered,renderedByEmployee2,renderedByEmployee,deleted,performed)
			(select jobactualserviceid,jobID,jobOperationToolID,serviceGroupID,timesRendered,renderedByEmployee2,renderedByEmployee,deleted,performed from jobactualservices where jobid = @jobid)
		insert into #TEMPJOBOPERATIONEVENT(joboperationeventid,jobOperationID,jobOperationEventOrder,jobOperationEventComments)
			(select joboperationeventid,jobOperationID,jobOperationEventOrder,jobOperationEventComments from joboperationevents where joboperationid in (select joboperationid from #TEMPJOBOPERATION))
		insert into #TEMPJOBOPERATIONTOOL(joboperationtoolid,jobOperationID,assetID,toolStringPosition)
			(select joboperationtoolid,jobOperationID,assetID,toolStringPosition from joboperationtools where joboperationid in (select joboperationid from #TEMPJOBOPERATION))
		insert into #TEMPJOBOPERATIONAUXDATA(joboperationauxdataid,jobOperationID,qtyRequested,qtyAttempted,qtySuccessful,pressureAttempted,tightTests,noSeal,successfulTests,odometerStart,odometerEnd,startHours,endHours,temperature,deleted,pressureTestsAttempted,distanceTraveled,engineHours)
			(select joboperationauxdataid,jobOperationID,qtyRequested,qtyAttempted,qtySuccessful,pressureAttempted,tightTests,noSeal,successfulTests,odometerStart,odometerEnd,startHours,endHours,temperature,deleted,pressureTestsAttempted,distanceTraveled,engineHours from joboperationauxdata where joboperationid in (select joboperationid from #TEMPJOBOPERATION))
		insert into #TEMPJOBOPERATIONEVENTINTERVAL(joboperationeventintervalid,jobOperationEventID,eventIntervalStartDepth,eventIntervalStopDepth,eventIntervalOrder,deleted,jobSelectedServicePerforatingDispatchDetailsID)
			(select joboperationeventintervalid,jobOperationEventID,eventIntervalStartDepth,eventIntervalStopDepth,eventIntervalOrder,deleted,jobSelectedServicePerforatingDispatchDetailsID from joboperationeventintervals where joboperationeventid in (select joboperationeventid from #TEMPJOBOPERATIONEVENT))
--insert failures later
		insert into #TEMPJOBCHARGES(jobchargeid,jobActualServiceID,pricingStyleID,serviceDetailID,itemQuantity,isPercentage,deleted,jobOperationID,jobID,itemPrice,parentJobChargeID,discount,total,comments)
			(select jobchargeid,jobActualServiceID,pricingStyleID,serviceDetailID,itemQuantity,isPercentage,deleted,jobOperationID,jobID,itemPrice,parentJobChargeID,discount,total,comments from jobcharges where jobid = @jobid)
		insert into #TEMPJOBCUSTOMERCOUNTS(customercountsid,jobID,PersonnelRating,EquipmentRating,CommunicationRating,HSSERating,OverallRating,CompanyComments,DeclinedSurvey)
			(select customercountsid,jobID,PersonnelRating,EquipmentRating,CommunicationRating,HSSERating,OverallRating,CompanyComments,DeclinedSurvey from jobcustomercounts where jobid = @jobid)
		insert into #TEMPJOBBONUS(jobbonusid,jobBonusTypeID,jobBonusStatusID,jobCrewID,deleted,IsApproved,dateApproved)
			(select jobbonusid,jobBonusTypeID,jobBonusStatusID,jobCrewID,deleted,IsApproved,dateApproved from jobbonus where jobcrewid in (select jobcrewid from #TEMPJOBCREW))
		insert into #TEMPJOBBONUSDATA(jobbonusdataid,jobBonusID,jobActualServiceID,bonusPercentage,bonusTotal,deleted,bonusNumberOfDays,bonusDayRate,serviceOrTicketTotal,splitPercentage,failurePercentage)
			(select jobbonusdataid,jobBonusID,jobActualServiceID,bonusPercentage,bonusTotal,deleted,bonusNumberOfDays,bonusDayRate,serviceOrTicketTotal,splitPercentage,failurePercentage from jobbonusdata where jobbonusid in (select jobbonusid from #TEMPJOBBONUS))


		--updates for the temp tables creation of new foreign keys, updates to any and all old foreign keys.


			--updates to jobid
				SET @date = GETDATE()
				SET @newjobid = newid()
				update #TEMPJOB set jobid = @newjobid
				update #TEMPJOBCONTACTS set jobid = @newjobid
				update #TEMPJOBCREW set jobid = @newjobid
				update #TEMPJOBASSETS set jobid = @newjobid
				update #TEMPJOBWELL set jobid = @newjobid
				update #TEMPJOBSELECTEDSERVICE set jobid = @newjobid
				update #TEMPJOBOPERATION set jobid = @newjobid
				update #TEMPJOBACTUALSERVICE set jobid = @newjobid
				update #TEMPJOBCHARGES set jobid = @newjobid
				update #TEMPJOBCUSTOMERCOUNTS set jobid = @newjobid

			--updates to jobwellids

				insert into @jobwellids(jobwellid) (select jobwellID from #TEMPJOBWELL)

				While (select Count(*) from @jobwellids where updateprocessed is null)  > 0
				Begin
					Select Top 1 @tempguid = jobwellid from @jobwellids where updateprocessed is null

						SET @newtempguid = newid()

						update @jobwellids set newjobwellid = @newtempguid where jobwellid = @tempguid
						update #TEMPJOBWELLCASINGTUBINGPROFILE set jobwellid = @newtempguid where jobwellid = @tempguid
						update #TEMPJOBWELLBOREHOLEPROFILE set jobwellid = @newtempguid where jobwellid = @tempguid
						update #TEMPJOBWELL set jobwellid = @newtempguid where jobwellid = @tempguid

					update @jobwellids set updateprocessed = 1 where jobwellid = @tempguid
				End

			--updates to jobcrewids

				insert into @jobcrewids(jobcrewid) (select jobcrewid from #TEMPJOBCREW)

				while (select count(*) from @jobcrewids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobcrewid from @jobcrewids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobcrewids set newjobcrewid = @newtempguid where jobcrewid = @tempguid
						update #TEMPJOBBONUS set jobcrewid = @newtempguid where jobcrewid = @tempguid
						update #TEMPJOBCREW set jobcrewid = @newtempguid where jobcrewid = @tempguid

					update @jobcrewids set updateprocessed = 1 where jobcrewid = @tempguid
				End

			--updates to jobselectedserviceids

				insert into @jobselectedserviceids(jobselectedserviceid) (select jobselectedserviceid from #TEMPJOBSELECTEDSERVICE)

				while (select count(*) from @jobselectedserviceids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobselectedserviceid from @jobselectedserviceids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobselectedserviceids set newjobselectedserviceid = @newtempguid where jobselectedserviceid = @tempguid
						update #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL set jobselectedserviceid = @newtempguid where jobselectedserviceid = @tempguid
						update #TEMPJOBSELECTEDSERVICE set jobselectedserviceid = @newtempguid where jobselectedserviceid = @tempguid

					update @jobselectedserviceids set updateprocessed = 1 where jobselectedserviceid = @tempguid
				End

			--updates to jobselectedservicedispatchdetailids

				insert into @jobselectedservicedispatchdetailids(jobselectedservicedispatchdetailsid) (select jobselectedservicedispatchdetailid from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL)

				while (select count(*) from @jobselectedservicedispatchdetailids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobselectedservicedispatchdetailsid from @jobselectedservicedispatchdetailids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobselectedservicedispatchdetailids set newjobselectedservicedispatchdetailsid = @newtempguid where jobselectedservicedispatchdetailsid = @tempguid
						update #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL set jobselectedservicedispatchdetailid = @newtempguid where jobselectedservicedispatchdetailid = @tempguid
						update #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL set jobselectedservicedispatchdetailid = @newtempguid where jobselectedservicedispatchdetailid = @tempguid
						update #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL set jobselectedservicedispatchdetailid = @newtempguid where jobselectedservicedispatchdetailid = @tempguid
						update #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL set jobselectedservicedispatchdetailid = @newtempguid where jobselectedservicedispatchdetailid = @tempguid

					update @jobselectedservicedispatchdetailids set updateprocessed = 1 where jobselectedservicedispatchdetailsid = @tempguid
				End

			--updates to joboperationids

				insert into @joboperationids(joboperationid) (select joboperationid from #TEMPJOBOPERATION)

				while (select count(*) from @joboperationids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = joboperationid from @joboperationids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @joboperationids set newjoboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBOPERATIONTOOL set joboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBOPERATIONEVENT set joboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBOPERATIONAUXDATA set joboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBCHARGES set joboperationid = @newtempguid where joboperationid = @tempguid
						update #TEMPJOBOPERATION set joboperationid = @newtempguid where joboperationid = @tempguid

					update @joboperationids set updateprocessed = 1 where joboperationid = @tempguid
				End

			--updates to joboperationeventids

				insert into @joboperationeventids(joboperationeventid) (select joboperationeventid from #TEMPJOBOPERATIONEVENT)

				while (select count(*) from @joboperationeventids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = joboperationeventid from @joboperationeventids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @joboperationeventids set newjoboperationeventid = @newtempguid where joboperationeventid = @tempguid
						update #TEMPJOBOPERATIONEVENTINTERVAL set joboperationeventid = @newtempguid where joboperationeventid = @tempguid
						update #TEMPJOBOPERATIONEVENT set joboperationeventid = @newtempguid where joboperationeventid = @tempguid

					update @joboperationeventids set updateprocessed = 1 where joboperationeventid = @tempguid
				End

			--updates to jobactualserviceids

				insert into @jobactualserviceids(jobactualserviceid) (select jobactualserviceid from #TEMPJOBACTUALSERVICE)

				while (select count(*) from @jobactualserviceids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobactualserviceid from @jobactualserviceids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobactualserviceids set newjobactualserviceid = @newtempguid where jobactualserviceid = @tempguid
						update #TEMPJOBBONUSDATA set jobactualserviceid = @newtempguid where jobactualserviceid = @tempguid
						update #TEMPJOBCHARGES set jobactualserviceid = @newtempguid where jobactualserviceid = @tempguid
						update #TEMPJOBACTUALSERVICE set jobactualserviceid = @newtempguid where jobactualserviceid = @tempguid

					update @jobactualserviceids set updateprocessed = 1 where jobactualserviceid = @tempguid
				End

			--updates to jobbonusids

				insert into @jobbonusids(jobbonusid) (select jobbonusid from #TEMPJOBBONUS)

				while (select count(*) from @jobbonusids where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = jobbonusid from @jobbonusids where updateprocessed is null
						
						SET @newtempguid = newid()

						update @jobbonusids set newjobbonusid = @newtempguid where jobbonusid = @tempguid
						update #TEMPJOBBONUSDATA set jobbonusid = @newtempguid where jobbonusid = @tempguid
						update #TEMPJOBBONUS set jobbonusid = @newtempguid where jobbonusid = @tempguid

					update @jobbonusids set updateprocessed = 1 where jobbonusid = @tempguid
				End

			--updates to @joboperationeventintervalids

			--	insert into @joboperationeventintervals(joboperationeventintervalid) (select joboperationeventintervalid from #TEMPJOBOPERATIONEVENTINTERVAL)

			--	while (select count(*) from @joboperationeventintervals where updateprocessed is null) > 0
			--	Begin
			--		Select top 1 @tempguid = joboperationeventintervalid from @joboperationeventintervals where updateprocessed is null
						
			--			SET @newtempguid = newid()

			--			update @joboperationeventintervals set newjoboperationeventintervalid = @newtempguid where joboperationeventintervalid = @tempguid-						update #TEMPJOBBONUSDATA set joboperationeventintervalid = @newtempguid where joboperationeventintervalid = @tempguid
			--			update #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL set joboperationeventintervalid = @newtempguid where joboperationeventintervalid = @tempguid
			--			update #TEMPJOBOPERATIONEVENTINTERVAL set joboperationeventintervalid = @newtempguid where joboperationeventintervalid = @tempguid

			--		update @joboperationeventintervals set updateprocessed = 1 where joboperationeventintervalid = @tempguid
			--	End

			--updates to @joboperationtoolids

				insert into @joboperationtools(joboperationtoolid) (select joboperationtoolid from #TEMPJOBOPERATIONTOOL)

				while (select count(*) from @joboperationtools where updateprocessed is null) > 0
				Begin
					Select top 1 @tempguid = joboperationtoolid from @joboperationtools where updateprocessed is null
						
						SET @newtempguid = newid()

						update @joboperationtools set newjoboperationtoolid = @newtempguid where joboperationtoolid = @tempguid
						update #TEMPJOBACTUALSERVICE set joboperationtoolid = @newtempguid where joboperationtoolid = @tempguid
						update #TEMPJOBOPERATIONTOOL set joboperationtoolid = @newtempguid where joboperationtoolid = @tempguid

					update @joboperationtools set updateprocessed = 1 where joboperationtoolid = @tempguid
				End
			

		--insert temp tables into real tables, straightforward insert, all work done in the updates section.

		insert into oneviewtest.dbo.job(jobID,dateSubmitted,financialSystemTypeID,financialSystemID,financialsystempricebookgroupid,financialSystemPriceBookID,serviceOrder,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted,jobTypeID,oneViewCompanyID,oneViewAddressID,createdByEmployeeID,geoScienceStatusID,topsServiceOrderID,poNumber,quoteNumber,customerRepresentative,topsDistrictID,approvingManagerID,drivingInformation,operationalLocationID,geographicLocationID,jobCancelledReasonID,jobCancelledReasonComment,jobCancelledReasonJobID,rentalChargeTypeID,rentalCompanyName,rentalPhoneNumber,rentalContactName,rentalItems,quoteID) 
			(select jobID,dateSubmitted,financialSystemTypeID,financialSystemID,financialsystempricebookgroupid,financialSystemPriceBookID,@user,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted,jobTypeID,oneViewCompanyID,oneViewAddressID,createdByEmployeeID,geoScienceStatusID,topsServiceOrderID,poNumber,quoteNumber,customerRepresentative,topsDistrictID,approvingManagerID,drivingInformation,operationalLocationID,geographicLocationID,jobCancelledReasonID,jobCancelledReasonComment,jobCancelledReasonJobID,rentalChargeTypeID,rentalCompanyName,rentalPhoneNumber,rentalContactName,rentalItems,quoteID  from #TEMPJOB)
		insert into jobcontacts(jobcontactID,personID,jobID) 
			(select newid(),personID,jobID from #TEMPJOBCONTACTS)
		insert into jobcrew(jobcrewID,jobID,employeeID,feCellRoleID ) 
			(select jobcrewID,jobID,employeeID,feCellRoleID  from #TEMPJOBCREW)
		insert into jobassets(jobassetID,jobid,assetID ) 
			(select newid(),jobid,assetID from #TEMPJOBASSETS)
		insert into jobwells(jobwellID,jobID,rigName,rigTypeID,drillingFluidTypeID,bottomHolePressure,bottomHoleTemperature,comments,maxDeviation,maxDogLeg,wellLocationTypeID,oneViewWellID,conveyanceTypeID,acquisitionTypeID,conveyanceSubTypeID,totalDepth,tightHole,deleted,seismicWellTypeID,kellyBushing,groundLevel,hasH2S,h2sLevel,hasCO2,co2Level,shutInPressure,flowingPressure,hasWirelineControlValve,surfacePressure,minimumID,wellHead,isLubricatorRequired,isGreaseInjectorRequired,lubricatorType,greaseInjectorType,mudDensity,mudViscosity,casingShoe ) 
			(select jobwellID,jobID,rigName,rigTypeID,drillingFluidTypeID,bottomHolePressure,bottomHoleTemperature,comments,maxDeviation,maxDogLeg,wellLocationTypeID,oneViewWellID,conveyanceTypeID,acquisitionTypeID,conveyanceSubTypeID,totalDepth,tightHole,deleted,seismicWellTypeID,kellyBushing,groundLevel,hasH2S,h2sLevel,hasCO2,co2Level,shutInPressure,flowingPressure,hasWirelineControlValve,surfacePressure,minimumID,wellHead,isLubricatorRequired,isGreaseInjectorRequired,lubricatorType,greaseInjectorType,mudDensity,mudViscosity,casingShoe from #TEMPJOBWELL)
		insert into jobwellcasingtubingprofile(jobwellcasingtubingprofileID,jobWellID,casingDimensionID,casingTypeID,startDepth,endDepth )
			(select newid(),jobWellID,casingDimensionID,casingTypeID,startDepth,endDepth from #TEMPJOBWELLCASINGTUBINGPROFILE)
		insert into jobwellboreholeprofile(jobwellboreholeprofileID,jobWellID,bitSizeID,startDepth,endDepth ) 
			(select newid(),jobWellID,bitSizeID,startDepth,endDepth from #TEMPJOBWELLBOREHOLEPROFILE)
		insert into jobselectedservices(jobselectedserviceID,jobID,serviceGroupID,servicePerformed ) 
			(select jobselectedserviceID,jobID,serviceGroupID,servicePerformed from #TEMPJOBSELECTEDSERVICE)
		insert into jobselectedservicedispatchdetails(jobselectedservicedispatchdetailID,jobSelectedServiceID,deleted,comments) 
			(select jobselectedservicedispatchdetailID,jobSelectedServiceID,deleted,comments from #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL )
		insert into jobselectedserviceperforatingdispatchdetails(jobselectedserviceperforatingdispatchdetailsID,ballisticGunTypeID,isSelectFire,ballisticDetonatorTypeID,ballisticGunSizeID,ballisticIgniterID,ballisticInitiatorTypeID,ballisticManufacturerID,ballisticPhasingID,ballisticTypeOfChargeID,gramWeight,orientedGun,deleted,jobSelectedServiceDispatchDetailID,ballisticSPFID ) 
			(select newid(),ballisticGunTypeID,isSelectFire,ballisticDetonatorTypeID,ballisticGunSizeID,ballisticIgniterID,ballisticInitiatorTypeID,ballisticManufacturerID,ballisticPhasingID,ballisticTypeOfChargeID,gramWeight,orientedGun,deleted,jobSelectedServiceDispatchDetailID,ballisticSPFID from #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL)
		insert into jobselectedservicepiperecoverydetails(jobselectedservicepiperecoverydetailID,jobSelectedServiceDispatchDetailID,connectionType,size,weight )	
			(select newid(),jobSelectedServiceDispatchDetailID,connectionType,size,weight from #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL)
		insert into jobselectedserviceassureconveyancedetails(jobselectedserviceassureconveyancedetailID,jobSelectedServiceDispatchDetailID,drillPipeODGrade,drillPipeThreadPattern,drillPipeSize,drillPipeWeight,drillPipeTube,drillPipeJoint,drillPipeCapacity,drillPipeNumberOfJoints,drillPipeAverageJointLength,drillPipeTotalLength,drillPipeCrossOverProvidedBy,hwDrillPipeODGrade,hwDrillPipeThreadPattern,hwDrillPipeSize,hwDrillPipeWeight,hwDrillPipeTube,hwDrillPipeJoint,hwDrillPipeCapacity,hwDrillPipeNumberOfJoints,hwDrillPipeAverageJointLength,hwDrillPipeTotalLength,hwDrillPipeScreenProvidedBy,pumpEfficiency,pumpMinStrokeRate,pumpMaxStrokeRate,pumpOutput,pumpStrokeLength,pumpLinerSize,pumpOtherLinerSize,pumpMaxSafeCirculatingPressure,pumpCirculatingStrokeRate,pumpCirculatingPressure,pumpMessengerWith,pumpRigPump,pumpTruck,pumpCrippleRig,pumpDivertFluidFromRig,mudSystemFrictionReducerUsed,mudSystemFrictionReducerDetail,depthSystemUsed,depthSystemDetail,driftingMethodDropCirculatingDrift,driftingMethodWhileStrappingIn,driftingMethodSignOff,driftingProvidedBy,loaderAvailableToUnloadDrillPipe,internalDrillPipeCoating,internalDrillPipeCoatingInspectionDate,otherComponentJars,otherComponentCollars,otherComponentScreens,otherComponentCorrosionRings,edrSystem,mudSystem,lostCirculatingRate,lcmContent,estimatedTripInTime,layingDownDrillPipe,deleted ) 
			(select newid(),jobSelectedServiceDispatchDetailID,drillPipeODGrade,drillPipeThreadPattern,drillPipeSize,drillPipeWeight,drillPipeTube,drillPipeJoint,drillPipeCapacity,drillPipeNumberOfJoints,drillPipeAverageJointLength,drillPipeTotalLength,drillPipeCrossOverProvidedBy,hwDrillPipeODGrade,hwDrillPipeThreadPattern,hwDrillPipeSize,hwDrillPipeWeight,hwDrillPipeTube,hwDrillPipeJoint,hwDrillPipeCapacity,hwDrillPipeNumberOfJoints,hwDrillPipeAverageJointLength,hwDrillPipeTotalLength,hwDrillPipeScreenProvidedBy,pumpEfficiency,pumpMinStrokeRate,pumpMaxStrokeRate,pumpOutput,pumpStrokeLength,pumpLinerSize,pumpOtherLinerSize,pumpMaxSafeCirculatingPressure,pumpCirculatingStrokeRate,pumpCirculatingPressure,pumpMessengerWith,pumpRigPump,pumpTruck,pumpCrippleRig,pumpDivertFluidFromRig,mudSystemFrictionReducerUsed,mudSystemFrictionReducerDetail,depthSystemUsed,depthSystemDetail,driftingMethodDropCirculatingDrift,driftingMethodWhileStrappingIn,driftingMethodSignOff,driftingProvidedBy,loaderAvailableToUnloadDrillPipe,internalDrillPipeCoating,internalDrillPipeCoatingInspectionDate,otherComponentJars,otherComponentCollars,otherComponentScreens,otherComponentCorrosionRings,edrSystem,mudSystem,lostCirculatingRate,lcmContent,estimatedTripInTime,layingDownDrillPipe,deleted from #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL)
		insert into joboperations(joboperationid,jobID,jobOperationTypeID,jobOperationStartTime,jobOperationEndTime,jobOperationComments ) 
			(select joboperationid,jobID,jobOperationTypeID,jobOperationStartTime,jobOperationEndTime,jobOperationComments from #TEMPJOBOPERATION)
		insert into joboperationtools(joboperationtoolid,jobOperationID,assetID,toolStringPosition ) 
			(select joboperationtoolid,jobOperationID,assetID,toolStringPosition from #TEMPJOBOPERATIONTOOL)
		insert into jobactualservices(jobactualserviceid,jobID,jobOperationToolID,serviceGroupID,timesRendered,renderedByEmployee2,renderedByEmployee,deleted,performed ) 
			(select jobactualserviceid,jobID,jobOperationToolID,serviceGroupID,timesRendered,renderedByEmployee2,renderedByEmployee,deleted,performed from #TEMPJOBACTUALSERVICE)
		insert into joboperationevents(joboperationeventid,jobOperationID,jobOperationEventOrder,jobOperationEventComments ) 
			(select joboperationeventid,jobOperationID,jobOperationEventOrder,jobOperationEventComments from #TEMPJOBOPERATIONEVENT)
		insert into joboperationauxdata(joboperationauxdataid,jobOperationID,qtyRequested,qtyAttempted,qtySuccessful,pressureAttempted,tightTests,noSeal,successfulTests,odometerStart,odometerEnd,startHours,endHours,temperature,deleted,pressureTestsAttempted,distanceTraveled,engineHours ) 
			(select newid(),jobOperationID,qtyRequested,qtyAttempted,qtySuccessful,pressureAttempted,tightTests,noSeal,successfulTests,odometerStart,odometerEnd,startHours,endHours,temperature,deleted,pressureTestsAttempted,distanceTraveled,engineHours from #TEMPJOBOPERATIONAUXDATA)
		insert into joboperationeventintervals(joboperationeventintervalid,jobOperationEventID,eventIntervalStartDepth,eventIntervalStopDepth,eventIntervalOrder,deleted,jobSelectedServicePerforatingDispatchDetailsID ) 
			(select newid(),jobOperationEventID,eventIntervalStartDepth,eventIntervalStopDepth,eventIntervalOrder,deleted,jobSelectedServicePerforatingDispatchDetailsID from #TEMPJOBOPERATIONEVENTINTERVAL)
		insert into jobcharges(jobchargeid,jobActualServiceID,pricingStyleID,serviceDetailID,itemQuantity,isPercentage,deleted,jobOperationID,jobID,itemPrice,parentJobChargeID,discount,total,comments ) 
			(select newid(),jobActualServiceID,pricingStyleID,serviceDetailID,itemQuantity,isPercentage,deleted,jobOperationID,jobID,itemPrice,parentJobChargeID,discount,total,comments from #TEMPJOBCHARGES)
		insert into jobcustomercounts(customercountsid,jobID,PersonnelRating,EquipmentRating,CommunicationRating,HSSERating,OverallRating,CompanyComments,DeclinedSurvey ) 
			(select newid(),jobID,PersonnelRating,EquipmentRating,CommunicationRating,HSSERating,OverallRating,CompanyComments,DeclinedSurvey from #TEMPJOBCUSTOMERCOUNTS)
		insert into jobbonus(jobbonusid,jobBonusTypeID,jobBonusStatusID,jobCrewID,deleted,IsApproved,dateApproved ) 
			(select jobbonusid,jobBonusTypeID,jobBonusStatusID,jobCrewID,deleted,IsApproved,dateApproved from #TEMPJOBBONUS)
		insert into jobbonusdata(jobbonusdataid,jobBonusID,jobActualServiceID,bonusPercentage,bonusTotal,deleted,bonusNumberOfDays,bonusDayRate,serviceOrTicketTotal,splitPercentage,failurePercentage ) 
			(select newid(),jobBonusID,jobActualServiceID,bonusPercentage,bonusTotal,deleted,bonusNumberOfDays,bonusDayRate,serviceOrTicketTotal,splitPercentage,failurePercentage from #TEMPJOBBONUSDATA)

		--drop all temp tables before exiting
		DROP TABLE #TEMPJOB
		DROP TABLE #TEMPJOBCONTACTS
		DROP TABLE #TEMPJOBCREW
		DROP TABLE #TEMPJOBASSETS
		DROP TABLE #TEMPJOBWELL
		DROP TABLE #TEMPJOBWELLCASINGTUBINGPROFILE
		DROP TABLE #TEMPJOBWELLBOREHOLEPROFILE
		DROP TABLE #TEMPJOBSELECTEDSERVICE
		DROP TABLE #TEMPJOBSELECTEDSERVICEDISPATCHDETAIL
		DROP TABLE #TEMPJOBSELECTEDSERVICEPERFORATINGDISPATCHDETAIL
		DROP TABLE #TEMPJOBSELECTEDSERVICEPIPERECOVERYDISPATCHDETAIL
		DROP TABLE #TEMPJOBSELECTEDSERVICEASSURECONVEYANCEDISPATCHDETAIL
		DROP TABLE #TEMPJOBOPERATION
		DROP TABLE #TEMPJOBACTUALSERVICE
		DROP TABLE #TEMPJOBOPERATIONEVENT
		DROP TABLE #TEMPJOBOPERATIONTOOL
		DROP TABLE #TEMPJOBOPERATIONAUXDATA
		DROP TABLE #TEMPJOBOPERATIONEVENTINTERVAL
		DROP TABLE #TEMPJOBCHARGES
		DROP TABLE #TEMPJOBCUSTOMERCOUNTS
		DROP TABLE #TEMPJOBBONUS
		DROP TABLE #TEMPJOBBONUSDATA


		--commit transaction;
END
GO
/****** Object:  StoredProcedure [dbo].[NotifyJobReviewers]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NotifyJobReviewers]
    @jobId uniqueidentifier
AS
	DECLARE @minStep int
	SELECT @minStep=MIN(Step) FROM JobReview where accepted IS NULL AND (deleted IS NULL OR deleted=0) AND jobID=@jobID;

	DECLARE @rigName nvarchar(max)
	

	INSERT INTO OneViewNotification(WftId, Description, Category, Created, Url, IsRead)
		SELECT e.wftid, 'Job ' + j.serviceOrder + ' ' + COALESCE(c.Name, '') + ' - ' + COALESCE(w.name, '') + ' Ready For Review', 'Job Review', GETUTCDATE(), '/Jobs/Job/Dispatch/' + convert(nvarchar(50), @jobId), 0 
		FROM JobReview r 
			INNER JOIN Job j ON j.JobId = r.jobID
			LEFT JOIN Company c on c.oneViewCompanyID = j.oneViewCompanyID
			LEFT JOIN JobWells jw on jw.jobid = j.jobid and jw.isPrimary=1
			LEFT JOIN Well w on w.wellID=jw.oneViewWellID
			INNER JOIN JobCrew jc ON jc.jobID = j.jobID AND jc.employeeID = r.employeeID
			INNER JOIN Employee e ON e.id = jc.employeeID
			WHERE r.accepted IS NULL AND 
				r.Step = @minStep AND (jc.deleted IS NULL OR jc.deleted = 0) AND r.JobID = @jobId
GO
/****** Object:  StoredProcedure [dbo].[oneview_jobs_by_region]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Doug
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[oneview_jobs_by_region] 
	-- Add the parameters for the stored procedure here
	@regionID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @regionID >= 1 and @regionID != 8
	begin
		select r.name, count(jobID) as job_count
		from dbo.Job j
		join gwis.dbo.District d on j.operatingDistrictID = d.id
		join gwis.dbo.Area a on d.area = a.id
		join gwis.dbo.Region r on a.region_id = r.id
		where r.id = @regionID
		group by r.name		
	end
	else
		select r.name, count(jobID) as job_count
		from dbo.Job j
		join gwis.dbo.District d on j.operatingDistrictID = d.id
		join gwis.dbo.Area a on d.area = a.id
		join gwis.dbo.Region r on a.region_id = r.id
		--where r.id = @regionID
		group by r.name	
	
	--select * from gwis.dbo.Region
	
    -- Insert statements for procedure here
	
END

GO
/****** Object:  StoredProcedure [dbo].[OpenJobForReKey]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Doug Gabehart
-- Create date: 9/29/2014
-- Description:	Open a job for rekeying
-- If clearDTNumber = 1, clear the financialsystemid field
-- If @newPriceBookID <> null, mark the existing charges as deleted and change the price book
-- =============================================
CREATE PROCEDURE [dbo].[OpenJobForReKey] 
	-- Add the parameters for the stored procedure here
	@jobID uniqueidentifier, 
	@clearDTNumber bit = 0,
	--@isOldPriceBook bit = 0,
	@newPriceBookID	int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @jobID is not null
	begin
		DECLARE @jobstatusid int
		select @jobstatusid = jobstatusid from job where jobid = @jobID
		insert into jobstatuslog(wftid, modified, jobid, oldjobstatusid, newjobstatusid) values ('Rekey', GETUTCDATE() , @jobid, @jobstatusid, 5)

		update job set invoicedatetime = null, jobstatusid = 5, dateUploaded=GETUTCDATE() where jobID = @jobID

		-- Heindy: May 28, 2015: Clear current approvals for a given job (set deleted flags)
		update jobreview set deleted = 1 where jobid = @jobID

		-- Heindy: May 28, 2015: Log change in audit table
		INSERT INTO JobAudit(jobID, username, remoteHost, date, comment) VALUES(@jobID, SUSER_NAME(), host_name(), GETUTCDATE(), 'Rekey')

		-- If clearDTNumber = 1, clear the financialsystemid field
		if @clearDTNumber = 1
		begin
			update job set financialsystemid = null where jobID = @jobID;
			update TMPSOADTPipelineMessageProcessing SET processed = 1 WHERE jobID = @jobID;
		end
		-- If isOldPriceBook = 1, mark the existing charges as deleted
		--if @isOldPriceBook = 1
		if @newPriceBookID is not null
		begin							
			--Mark old charges as deleted since they are from the old price book
			update jobcharges set adjusteditemquantity=null,adjusteditemprice=null,adjustedtotal=null,jdelinenumber =null,adjustednativeitemprice=null,adjustednativetotal=null,  deleted = 1
			where jobid = @jobID
			update job set financialsystempricebookid = @newPriceBookID where jobid = @jobID
		end
		else
		begin
			update jobcharges set adjusteditemquantity=null,adjusteditemprice=null,adjustedtotal=null,jdelinenumber =null,adjustednativeitemprice=null,adjustednativetotal=null
			where jobid = @jobID
		end

		--Set Job Bonus Status to "Pending"
		UPDATE JobBonus
		SET jobBonusStatusID = 1, dateApproved = NULL
		FROM Job j
		INNER JOIN JobCrew jc ON j.jobID = jc.jobID
		INNER JOIN JobBonus jb ON jc.jobCrewID = jb.jobCrewID
		WHERE j.jobID = @jobID AND j.invoiceDateTime IS NULL AND j.jobStatusID != 1 AND jb.jobBonusStatusID != 4 AND (jb.jobBonusTypeID NOT IN (3, 4))
		
		--Update Job Bonus Status Log to "Pending"
		INSERT INTO JobBonusStatusLog(jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, bonusTotal, jobBonusDeclineReasonID)
		SELECT NEWID(), wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, bonusTotal, jobBonusDeclineReasonID
		FROM
		(SELECT DISTINCT 
					 'ReKey' AS wftid, GETUTCDATE() AS modified, jb.jobBonusID, jb.jobBonusStatusID AS oldJobBonusStatusID, 1 as newJobBonusStatusID,
					CASE WHEN jbd.jdeBonusTotal IS NULL 
					 THEN jbd.bonusTotal ELSE jbd.jdeBonusTotal END AS bonusTotal, jb.jobBonusDeclineReasonID
		FROM            dbo.JobBonusData AS jbd INNER JOIN
							 dbo.JobBonus AS jb ON jbd.jobBonusID = jb.jobBonusID AND (jbd.deleted IS NULL OR jbd.deleted = 0) AND (jb.deleted IS NULL OR jb.deleted = 0) AND jb.jobBonusStatusID > 0 INNER JOIN
							 dbo.JobCrew AS jcrew ON jb.jobCrewID = jcrew.jobCrewID AND (jcrew.deleted IS NULL OR jcrew.deleted = 0)
							 INNER JOIN job j ON jcrew.jobID = j.jobid
		WHERE j.jobid = @jobID AND j.invoiceDateTime IS NULL AND j.jobStatusID != 1 AND jb.jobBonusStatusID != 4 AND (jb.jobBonusTypeID NOT IN (3, 4))) SubTable
		
	end

END

GO
/****** Object:  StoredProcedure [dbo].[PayrollPersonnelCanFlatRateJBL]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PayrollPersonnelCanFlatRateJBL] 
	@Manager nvarchar(max), 
	@LastUpdatedDateTime DateTime,
	@Employee nvarchar(max),
	@AreaManagerID nvarchar(max),
	@BonusStatus nvarchar(max)
AS
BEGIN

SELECT        jobID, date_submitted, scheduledStartDateTime, Customer, field_ticket_number, ROUND(ISNULL(SUM(nativeBonusFlatRate), 0), 2) AS BonusTotal, EmployeeName, EmployeeEmail, EmployeeId,
                         BonusStatusName, hasFailure, ISNULL(ISNULL(nativeFlatRateBonusableTicketTotal, BonusableTicketTotal), 0) AS BonusableTicketTotal, label
FROM            (SELECT DISTINCT 
                                                    j.jobID, j.dateSubmitted AS date_submitted, j.scheduledStartDateTime, c.Name AS Customer, j.serviceOrder AS field_ticket_number, 
                                                    jbfrd.nativeBonusFlatRate, e2.displayname AS EmployeeName, e2.email AS EmployeeEmail, e2.id AS EmployeeId, jbfrd.nativeFlatRateBonusableTicketTotal, 
                                                    jbs.jobBonusStatusName AS BonusStatusName, 
													CASE WHEN Failures.failureID IS NOT NULL THEN (CASE WHEN Failures.deleted IS NOT NULL THEN 0 ELSE 1 END) ELSE 0 END AS hasFailure,
													jbt.label,
                                                        (SELECT        SUM(ISNULL(JobCharges_1.adjustedNativeTotal, ISNULL(JobCharges_1.nativeTotal, 0))) AS jcTicketTotal
                                                          FROM            JobCharges AS JobCharges_1 INNER JOIN
                                                                                    ServiceDetails AS sd ON JobCharges_1.serviceDetailID = sd.id AND sd.isBonusable = 1
                                                          WHERE        (JobCharges_1.jobID = j.jobID) AND (JobCharges_1.deleted IS NULL OR
                                                                                    JobCharges_1.deleted = 0)) AS BonusableTicketTotal
                          FROM            Company AS c RIGHT OUTER JOIN
                                                    Failures RIGHT OUTER JOIN
                                                    FECellRole AS fecr RIGHT OUTER JOIN
                                                    JobCrew AS JobCrew_1 INNER JOIN
                                                    JobCrew AS JC INNER JOIN
                                                    Job AS j ON JC.jobID = j.jobID INNER JOIN
                                                    JobCrew AS JC3 ON j.jobID = JC3.jobID ON JobCrew_1.jobID = j.jobID INNER JOIN
                                                    Employee AS e2 ON JobCrew_1.employeeID = e2.id INNER JOIN
                                                    JobBonusStatus AS jbs INNER JOIN
                                                    JobBonus AS jb ON jbs.jobBonusStatusID = jb.jobBonusStatusID ON JobCrew_1.jobCrewID = jb.jobCrewID ON 
                                                    fecr.feCellRoleID = JobCrew_1.feCellRoleID ON Failures.jobID = j.jobID ON c.oneViewCompanyID = j.oneViewCompanyID INNER JOIN
                                                    JobBonusType AS jbt ON jb.jobBonusTypeID = jbt.jobBonusTypeID LEFT OUTER JOIN
                                                    JobBonusFlatRateData AS jbfrd ON jb.jobBonusID = jbfrd.jobBonusID AND (jbfrd.deleted IS NULL OR
                                                    jbfrd.deleted = 0) LEFT OUTER JOIN
                                                    JobBonusFlatRateLog AS jbfrl ON jbfrd.jobBonusFlatRateDataID = jbfrl.jobBonusFlatRateDataID
                          WHERE        (jb.dateApproved <= @LastUpdatedDateTime) AND (jb.jobBonusID IS NOT NULL) AND (e2.id IN (SELECT number FROM iter_intlist_to_tbl(@Employee))) AND (jb.deleted IS NULL) AND 
                                                    (j.deleted IS NULL) AND (fecr.feCellRoleTypeID = 5) AND (JC.feCellRoleID = 9) AND (JC3.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManagerID))) AND (JC3.feCellRoleID = 11) 
                                                    AND (JC3.deleted IS NULL) AND (JobCrew_1.deleted IS NULL) AND (JC.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND 
                                                    (JC.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@Manager))) AND (jbs.deleted IS NULL) AND (jb.jobBonusTypeID = 4) OR
                                                    (jb.dateApproved <= @LastUpdatedDateTime) AND (jb.jobBonusID IS NOT NULL) AND (e2.id IN (SELECT number FROM iter_intlist_to_tbl(@Employee))) AND (jb.deleted IS NULL) AND 
                                                    (j.deleted IS NULL) AND (JC.feCellRoleID = 9) AND (JC3.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManagerID))) AND (JC3.feCellRoleID = 11) AND (JC3.deleted IS NULL) AND 
                                                    (JobCrew_1.deleted IS NULL) AND (JC.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JC.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@Manager))) AND (jbs.deleted IS NULL) 
                                                    AND (jb.jobBonusTypeID = 4) AND (JobCrew_1.feCellRoleID = 9)) AS SubTable
GROUP BY jobID, date_submitted, scheduledStartDateTime, Customer, field_ticket_number, EmployeeName, EmployeeEmail, EmployeeId, BonusStatusName, hasFailure, label, 
                         nativeFlatRateBonusableTicketTotal, BonusableTicketTotal

END
GO
/****** Object:  StoredProcedure [dbo].[PayrollPersonnelCanJBH]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PayrollPersonnelCanJBH] 
	@From DateTime,
	@To DateTime,
	@Country nvarchar(max)
AS
BEGIN

	SELECT SUM(ROUND(jbh.actualBonusTotal, 2)) AS actualBonusTotal, jbh.jobBonusProcessedID, jbh.dateProcessed, e.displayname as fullname, e.email as employeeemail, e.id as employeeid, jbh.currencyCode, jbh.country
	FROM            JobBonusHistory AS jbh INNER JOIN
							 JobBonusProcessed AS jbp ON jbh.jobBonusProcessedID = jbp.jobBonusProcessedID INNER JOIN
							 Employee AS e ON jbp.processedBy = e.wftid
	WHERE        (jbh.dateProcessed BETWEEN @From AND DATEADD(DAY, DATEDIFF(DAY, '19000101', @To), '23:59:59')) AND (jbh.country = @Country)
	GROUP BY jbh.jobBonusProcessedID, jbh.dateProcessed, e.displayname, e.email, e.id, jbh.currencyCode, jbh.country
	ORDER BY jbh.dateProcessed DESC

END

GO
/****** Object:  StoredProcedure [dbo].[PayrollPersonnelCanJBL]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PayrollPersonnelCanJBL] 
	@Manager nvarchar(max), 
	@LastInvoiceDateTime DateTime,
	@Employee nvarchar(max),
	@AreaManagerID nvarchar(max),
	@BonusStatus nvarchar(max)
AS
BEGIN

	SELECT jobID, date_submitted, scheduledStartDateTime, Customer, field_ticket_number, ROUND(ISNULL(SUM(nativeJDEBonusTotal), 0), 2) AS BonusTotal, 
	EmployeeName, EmployeeEmail, EmployeeId,
							 BonusStatusName, hasFailure, jobBonusDeclineReason, ISNULL(ISNULL(TicketTotal, 0), 0) AS TicketTotal, ISNULL(ISNULL(BonusableTicketTotal, 0), 0) AS BonusableTicketTotal, jobBonusTypeID, label
	FROM            (SELECT DISTINCT 
														j.jobID, j.dateSubmitted AS date_submitted, j.scheduledStartDateTime, c.Name AS Customer, j.serviceOrder AS field_ticket_number, 
														jbd.nativeJDEServiceOrderTicketTotal, jbd.nativeBonusTotal, jbd.nativeJDEBonusTotal, 
														e2.displayname AS EmployeeName, 
														e2.email as EmployeeEmail, e2.id as EmployeeId, jbs.jobBonusStatusName AS BonusStatusName, 
														CASE WHEN Failures.failureID IS NOT NULL THEN (CASE WHEN Failures.deleted IS NOT NULL THEN 0 ELSE 1 END) 
														ELSE 0 END AS hasFailure, JobBonusDeclineReason.jobBonusDeclineReason, jbd.nativeServiceOrTicketTotal,
															(SELECT        SUM(JobCharges.adjustedNativeTotal) AS jcTicketTotal
															  FROM            JobCharges
															  WHERE        (jobID = j.jobID) AND (deleted IS NULL OR
																						deleted = 0)) AS TicketTotal,
														(SELECT        SUM(JobCharges.adjustedNativeTotal) AS jcTicketTotal
															  FROM            JobCharges INNER JOIN
																			ServiceDetails sd ON JobCharges.serviceDetailID = sd.id AND sd.isBonusable = 1
															  WHERE        (jobID = j.jobID) AND (JobCharges.deleted IS NULL OR
																						JobCharges.deleted = 0)) AS BonusableTicketTotal, jb.jobBonusTypeID, jbt.label
							  FROM            Company AS c RIGHT OUTER JOIN
														Failures RIGHT OUTER JOIN
														FECellRole AS fecr RIGHT OUTER JOIN
														JobCrew AS JobCrew_1 INNER JOIN
														JobCrew AS JC INNER JOIN
														Job AS j ON JC.jobID = j.jobID INNER JOIN
														JobCrew AS JC3 ON j.jobID = JC3.jobID ON JobCrew_1.jobID = j.jobID INNER JOIN
														Employee AS e2 ON JobCrew_1.employeeID = e2.id INNER JOIN
														JobBonusStatus AS jbs INNER JOIN
														JobBonus AS jb ON jbs.jobBonusStatusID = jb.jobBonusStatusID INNER JOIN
														JobBonusData AS jbd ON (jb.jobBonusID = jbd.jobBonusID AND jbd.nativeJDEServiceOrderTicketTotal IS NOT NULL) ON JobCrew_1.jobCrewID = jb.jobCrewID LEFT OUTER JOIN
														JobBonusDeclineReason ON jb.jobBonusDeclineReasonID = JobBonusDeclineReason.jobBonusDeclineReasonID ON 
														fecr.feCellRoleID = JobCrew_1.feCellRoleID ON Failures.jobID = j.jobID ON c.oneViewCompanyID = j.oneViewCompanyID INNER JOIN
														JobBonusType AS jbt ON jb.jobBonusTypeID = jbt.jobBonusTypeID 
							  WHERE        (j.invoiceDateTime <= @LastInvoiceDateTime) AND (jb.jobBonusID IS NOT NULL) AND (e2.id IN (SELECT number FROM iter_intlist_to_tbl(@Employee))) AND (jb.deleted IS NULL) AND (j.deleted IS NULL) AND (fecr.feCellRoleTypeID = 5) AND 
														(JC.feCellRoleID = 9) AND (JC3.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManagerID))) AND (JC3.feCellRoleID = 11) AND (jbd.deleted IS NULL) AND (JC3.deleted IS NULL) AND
														 (JobCrew_1.deleted IS NULL) AND (JC.deleted IS NULL) AND (jb.jobBonusStatusID IN (SELECT number FROM iter_intlist_to_tbl(@BonusStatus))) AND (JC.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@Manager))) AND 
														(jbs.deleted IS NULL) OR
														(j.invoiceDateTime <= @LastInvoiceDateTime) AND (jb.jobBonusID IS NOT NULL) AND (e2.id IN (SELECT number FROM iter_intlist_to_tbl(@Employee))) AND (jb.deleted IS NULL) AND (j.deleted IS NULL) AND (JC.feCellRoleID = 9) AND 
														(JC3.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@AreaManagerID))) AND (JC3.feCellRoleID = 11) AND (jbd.deleted IS NULL) AND (JC3.deleted IS NULL) AND 
														(JobCrew_1.deleted IS NULL) AND (JC.deleted IS NULL) AND (jb.jobBonusStatusID IN (SELECT number FROM iter_intlist_to_tbl(@BonusStatus))) AND (JC.employeeID IN (SELECT number FROM iter_intlist_to_tbl(@Manager))) AND 
														(jbs.deleted IS NULL) AND 
														(JobCrew_1.feCellRoleID = 9)
							  GROUP BY j.jobID, j.dateSubmitted, j.scheduledStartDateTime, c.Name, j.serviceOrder, e2.displayname, e2.email, e2.id, jbs.jobBonusStatusName, 
														JobBonusDeclineReason.jobBonusDeclineReason, CASE WHEN Failures.failureID IS NOT NULL THEN (CASE WHEN Failures.deleted IS NOT NULL 
														THEN 0 ELSE 1 END) ELSE 0 END, jbd.nativeJDEServiceOrderTicketTotal, jbd.nativeBonusTotal, jbd.nativeJDEBonusTotal, jbd.nativeServiceOrTicketTotal, 
														jb.jobBonusTypeID, jbt.label) AS SubTable
	WHERE nativeJDEBonusTotal > 0
	GROUP BY jobID, date_submitted, scheduledStartDateTime, Customer, field_ticket_number, EmployeeName, EmployeeEmail, EmployeeId, BonusStatusName, hasFailure, jobBonusDeclineReason, 
							 TicketTotal, jobBonusTypeID, label, BonusableTicketTotal

END

GO
/****** Object:  StoredProcedure [dbo].[RefreshJobReviewers]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RefreshJobReviewers]
    @jobId uniqueidentifier
AS
	DECLARE @statusId tinyint
	DECLARE @jobLocation int
	DECLARE @fieldTicketNumber nvarchar(50)
	DECLARE @areaApproverId int
	SELECT @areaApproverId = feCellRoleId FROM FeCellRole WHERE Role='_AreaApprovingManager'

	SELECT @jobLocation=operationalLocationID, @fieldTicketNumber=serviceOrder, @statusId=jobStatusID FROM Job WHERE JobID=@jobId

	UPDATE jc 
		SET jc.deleted = 1
		FROM JobCrew jc
		JOIN Employee e ON e.id = jc.employeeID
		JOIN DefaultAreaApprovers daa ON daa.employeeWftId = e.wftid
		JOIN OperationalLocation l ON l.countryId = daa.countryId AND l.gwis_locationid = @jobLocation
		WHERE (jc.deleted IS NULL OR jc.deleted = 0) AND jc.jobID = @jobId AND jc.feCellRoleID <> @areaApproverId

	INSERT INTO JobCrew(jobID, employeeID, feCellRoleID)
	SELECT @jobId, e.id, @areaApproverId FROM DefaultAreaApprovers daa
		JOIN OperationalLocation l ON l.countryId = daa.countryId AND l.gwis_locationid = @jobLocation
		JOIN Employee e ON e.wftid = daa.employeeWftId
	WHERE NOT EXISTS(SELECT jobCrewID FROM JobCrew jc 
						WHERE jc.jobID = @jobId 
						AND jc.employeeID = e.id 
						AND (deleted IS NULL OR deleted = 0)
						AND jc.feCellRoleID = @areaApproverId)

	IF @statusId = 5 OR @statusId = 9 --Completed On Site
	BEGIN
		
		DECLARE @roles TABLE(feCellRoleId int, locationAttrId int, lvl int, roleType int, step int, stepName nvarchar(100))
		
		DECLARE @hasEngineer int
		SET @hasEngineer = 0

		DECLARE @approverId int
		DECLARE @engineerId int
		SELECT @approverId = feCellRoleId FROM FeCellRole WHERE Role='_Approver'
		SELECT @engineerId = feCellRoleId FROM FeCellRole WHERE Role='_Engineer'

		SELECT @hasEngineer = COUNT(*) FROM JobCrew jc
			INNER JOIN FeCellRole cell ON cell.feCellRoleId=jc.feCellRoleId
			WHERE jc.jobID=@jobId AND cell.Role = '_Engineer' AND (jc.deleted is null or jc.deleted = 0)

		;WITH cte AS (
			SELECT [gwis_locationattributeid] ,[gwis_locationid],[name],[parent],[lvl]	FROM [dbo].[vOperationalBranchPlantTree]
				WHERE gwis_locationid = @jobLocation AND lvl=5
			UNION ALL
			SELECT l.[gwis_locationattributeid] , l.[gwis_locationid], l.[name], l.[parent], l.[lvl] FROM [dbo].[vOperationalBranchPlantTree] l
				INNER JOIN cte c ON c.parent = l.gwis_locationid AND l.lvl = c.lvl-1
		)
		INSERT INTO @roles
			SELECT r.FeCellRoleId, r.Gwis_LocationAttributeId, c.lvl, cell.feCellRoleTypeID, n.number, n.stepName FROM cte c
				INNER JOIN JobRoles r ON r.Gwis_LocationAttributeId = c.Gwis_LocationAttributeId
				INNER JOIN FeCellRole cell ON cell.FeCellRoleID=r.FeCellRoleId
				INNER JOIN JobCrew jc ON jc.jobID = @jobId AND 
					(jc.feCellRoleID = r.feCellRoleId OR (@hasEngineer = 0 AND jc.feCellRoleID = @approverId AND r.feCellRoleId=@engineerId))
					AND (jc.deleted is null or jc.deleted = 0)
				CROSS APPLY(
					SELECT 
						CONVERT(int, LEFT(Value, COALESCE(NULLIF(CHARINDEX(':', Value), 0) - 1, LEN(Value)))) as number,
						CASE 
							WHEN CHARINDEX(':', Value) > 0 THEN SUBSTRING(Value, CHARINDEX(':', Value) + 1, LEN(Value) - CHARINDEX(':', Value))
							ELSE ''
						END as stepName
					FROM fnSplit(r.StepNumbers, ',')
				) n
				WHERE (r.deleted IS NULL OR r.deleted = 0) AND r.StepNumbers IS NOT NULL

		INSERT INTO JobReview(jobID, employeeID, feCellRoleID, step, stepname)
		SELECT DISTINCT @jobId, e.id, r.feCellRoleID, r.step, r.stepName FROM @roles r 
			INNER JOIN JobCrew jc ON jc.jobID = @jobId AND 
				(jc.feCellRoleID = r.feCellRoleId OR (@hasEngineer = 0 AND jc.feCellRoleID = @approverId AND r.feCellRoleId=@engineerId))
				AND (jc.deleted is null or jc.deleted = 0)
			INNER JOIN Employee e ON e.id = jc.employeeID
			WHERE r.lvl IN (SELECT MAX(lvl) FROM @roles) AND (jc.deleted IS NULL OR jc.deleted = 0) 
			AND NOT EXISTS(SELECT employeeID FROM JobReview WHERE jobID=@jobId 
				AND (deleted IS NULL OR deleted=0) 
				AND (employeeID=jc.employeeID OR (accepted IS NOT NULL AND feCellRoleID=r.feCellRoleId))
				AND step=r.step)

		--Notify
		EXEC NotifyJobReviewers @jobId=@jobId

	END

GO
/****** Object:  StoredProcedure [dbo].[RepushCustomersAndJobsToTOPS]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RepushCustomersAndJobsToTOPS]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


select Top 100 jobid 
into #tempJobUpdate 
from tmpRepushCustomerAndJobToTOPS
where processed is null


update [gwis].[dbo].[company] set modified = GETDATE()
where id in 
	(select distinct(id) from company c
		join job j on c.oneviewcompanyid = j.oneviewcompanyid
		where j.jobid in 
			(select jobid from #tempJobUpdate)
	)


WAITFOR Delay '00:30'

--cursor to call sp_touchjobandrelated
declare @jobid uniqueidentifier;

declare _jobupdate cursor for
select jobid from #tempJobUpdate

open _jobupdate

fetch next from _jobupdate
into @jobid

while @@FETCH_STATUS = 0
Begin

	exec sp_touchjobandrelated @jobid

	fetch next from _jobupdate into @jobid
End
Close _jobupdate
deallocate _jobupdate


update tmpRepushCustomerAndJobToTOPS set processed = 1 
where jobid in (select * from #tempJobUpdate)

drop table #tempJobUpdate

END
GO
/****** Object:  StoredProcedure [dbo].[services_by_region]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Doug
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[services_by_region] 
	-- Add the parameters for the stored procedure here
	@regionID int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @regionID >= 1 and @regionID != 8
	begin
		select r.name as region,s.name as service, count(jots.jobOperationToolServiceID) as job_count
		from dbo.Job j
		join joboperations jo on j.jobID = jo.jobID
		join joboperationtools jot on jo.jobOperationID = jot.jobOperationID
		join joboperationtoolservices jots on jot.jobOperationToolID = jots.jobOperationToolID
		join dbo.services s on jots.serviceID = s.id
		join gwis.dbo.District d on j.operatingDistrictID = d.id
		join gwis.dbo.Area a on d.area = a.id
		join gwis.dbo.Region r on a.region_id = r.id
		where r.id = @regionID
		group by r.name,s.name	
	end
	else
		select r.name as region,s.name as service, count(jots.jobOperationToolServiceID) as job_count
		from dbo.Job j
		join joboperations jo on j.jobID = jo.jobID
		join joboperationtools jot on jo.jobOperationID = jot.jobOperationID
		join joboperationtoolservices jots on jot.jobOperationToolID = jots.jobOperationToolID
		join dbo.services s on jots.serviceID = s.id
		join gwis.dbo.District d on j.operatingDistrictID = d.id
		join gwis.dbo.Area a on d.area = a.id
		join gwis.dbo.Region r on a.region_id = r.id		
		group by r.name,s.name
END

GO
/****** Object:  StoredProcedure [dbo].[SOAStatisticsDaily]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SOAStatisticsDaily] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @endOfToday datetime
declare @beginningOfToday datetime
declare @messageCount int
declare @associationCount int
declare @jobsReconciledCount int

select @beginningOfToday = DATEdiff(dd,0,GETUTCDATE())
select @endOfToday = dateadd(ss,59,dateadd(mi,59,DATEAdd(hh,23,@beginningOfToday)))
select @messageCount=count(*) from TMPSOADTPipelineMessages where DateofTransaction between @beginningOfToday and @endOfToday
select @associationCount = count(*) from TMPSOADTPipelineMessageProcessing where DATEADDed between @beginningOfToday and @endOfToday
select @jobsReconciledCount = count(*) from TMPSOADTPipelineMessageProcessing where dateProcessed BETWEEN @beginningOfToday and @endOfToday

select (select 'Number of messages processed between ' + convert(NVARCHAR(100),@beginningOfToday,120) + ' and ' + convert(NVARCHAR(100),@endOfToday,120)+ ': ' + cast(@messageCount as nvarchar(100))) 
+ char(10) + (select 'Number of DT -> Job associations made between ' + convert(NVARCHAR(100),@beginningOfToday,120) + ' and ' + convert(NVARCHAR(100),@endOfToday,120)+ ': ' + cast(@associationCount as nvarchar(100)))
+ char(10) + (select 'Number of Jobs reconciled between ' + convert(NVARCHAR(100),@beginningOfToday,120) + ' and ' + convert(NVARCHAR(100),@endOfToday,120)+ ': ' + cast(@jobsReconciledCount as nvarchar(100)))
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ApproveBonus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 02/27/2013
-- Description:	Update Bonus Approval
-- =============================================
CREATE PROCEDURE [dbo].[sp_ApproveBonus]
	
	@BonusID uniqueidentifier

AS
BEGIN
	UPDATE [dbo].[JobBonus] SET [IsApproved] = 1, [dateApproved] = GETUTCDATE()	WHERE [jobBonusID] = @BonusID 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeclineJobBonusApproval]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 08/09/2013
-- Description:	Decline Job Bonus Approval
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeclineJobBonusApproval]
	
	@BonusID text, @ManagerID Int, @jobBonusStatusID Int, @DeclinedReasonID Int

AS
BEGIN

	DECLARE @ManagerWFTID Char(10)
	SET @ManagerWFTID = (SELECT wftid FROM Employee WHERE id = @ManagerID)
	
	INSERT INTO JobBonusStatusLog (jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, bonusTotal, jobBonusDeclineReasonID)
       SELECT        NEWID(), @ManagerWFTID, getutcdate(), jb.jobBonusID, jb.jobBonusStatusID, @jobBonusStatusID, SUM(CASE WHEN jbd.jdeServiceOrTicketTotal IS NULL THEN jbd.bonusTotal ELSE jbd.jdeBonusTotal END) AS bonusTotal, @DeclinedReasonID
		FROM            JobBonus AS jb LEFT OUTER JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID
		WHERE (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, jb.jobBonusStatusID
	
	IF @jobBonusStatusID = 6  --Declined
	BEGIN
	UPDATE [dbo].[JobBonus] SET [IsApproved] = NULL, [approvedBy] = NULL, [dateApproved] = NULL, [jobBonusStatusID] = 6, [jobBonusDeclineReasonID] = @DeclinedReasonID WHERE [jobBonusProcessedID] IS NULL AND [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,','))
	END

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ExportStagingAssetDataToAssets]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [dbo].[sp_ExportStagingAssetDataToAssets]      
   AS    
BEGIN
   SET NOCOUNT ON;
   MERGE assets AS Target
   USING 
   (
   SELECT
   SFA.SerialNum,
   SFA.AssetNumber, 
   SFA.AssetDescription, 
   SFA.ToolCode, 
   SFA.ToolPanel, 
   SFA.Version
   FROM
   StagingFixedAssets AS SFA
   ) AS Source 
   ON Source.AssetNumber = Target.jdeitemno  
  WHEN MATCHED 
  THEN UPDATE 
   SET
   Target.serialnumber= Source.SerialNum,
   Target.toolcodetypeid= Source.ToolCode,
   Target.toolpaneltypeid = Source.ToolPanel,
   Target.version= Source.Version,
   Target.description=Source.AssetDescription
   WHEN NOT MATCHED
   THEN  
   INSERT (assetID, toolpaneltypeid, toolcodetypeid, version, serialnumber, stationid, description, toolstatusid, sapid, superiorsapid, 
   jdeitemno, licence, inserted, updated, updateId, insertId, toolpanelcodeversionid)
   VALUES (((SELECT MAX(assetID) from assets ) + 1), Source.ToolPanel, Source.ToolCode, Source.Version, '42344-3456', NULL, Source.AssetDescription, NULL,
   NULL, NULL, Source.AssetNumber, NULL, 0x, NULL,'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', NULL);
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Find_Exchange_Rate]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		McKeehan, Trevor
-- Create date: March 26th 2013
-- Description:	This stored procedure was created to be used by
--				the SSIS package that imports JDE values from the 
--				SOA feed into OneView. Simple but hard to implement
--				logic is required to select the correct exchangeRate.
--				This sp returns the currencyRateID found with the 
--				Specificed Currency in the specified date range.
-- =============================================
CREATE PROCEDURE [dbo].[sp_Find_Exchange_Rate]
	@CurrID int,
	@SpecifiedDate DateTime

AS
BEGIN

declare @currRateID int
set @currRateID = 0

	set @currRateID = (SELECT [currencyRateID] FROM CurrencyRate where [currencyID] = @CurrID and ([effectiveDate] < @SpecifiedDate and DATEADD(month, 1, [effectivedate]) >= @SpecifiedDate))
	
	return @currRateID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_past_sync_anchor]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Doug Gabehart
-- Create date: 12/20/2013
-- Description:	Get the minimum sync anchor x number of months in the past
-- =============================================
CREATE PROCEDURE [dbo].[sp_get_past_sync_anchor] 
	-- Add the parameters for the stored procedure here
	@numMonthsInPast int = -6
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select min(updated) as sync_anchor from job where datesubmitted between dateadd(mm, -@numMonthsInPast, getdate()) and getdate()	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_past_sync_anchor_v2]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Doug Gabehart
-- Create date: 12/20/2013
-- Description:	Get the minimum sync anchor x number of months in the past
-- =============================================
CREATE PROCEDURE [dbo].[sp_get_past_sync_anchor_v2] 
	-- Add the parameters for the stored procedure here
	@numMonthsInPast int = -6
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select min(inserted) as sync_anchor from job where datesubmitted between dateadd(dd, -21, getdate()) and getdate()	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Sales_And_Marketing_Tier_Data]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Get_Sales_And_Marketing_Tier_Data] 
	@From AS DateTime, @To AS DateTime, @BusinessUnit AS Char(4000), @JobStatus AS Char(255)
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT DISTINCT scheduledStartDateTime, revenueCenterID, CompanyName, SalesEngineer, serviceOrder, financialSystemID, LEFT(LTRIM(RTRIM(GroupNames)), LEN(LTRIM(RTRIM(GroupNames))) - 1) as GroupNames,
CASE
WHEN GroupNames LIKE '%CAT%' THEN 1
WHEN GroupNames LIKE '%CRE%' THEN 1
WHEN GroupNames LIKE '%NMRT-E%' THEN 1
WHEN GroupNames LIKE '%NMRT-F%' THEN 1
WHEN GroupNames LIKE '%RAT%' THEN 1
WHEN GroupNames LIKE '%RSCT%' THEN 1
WHEN GroupNames LIKE '%SAT%' THEN 1
WHEN GroupNames LIKE '%URS%' THEN 1
WHEN GroupNames LIKE '%VSP%' THEN 1
WHEN GroupNames LIKE '%CWS%' AND GroupNames LIKE '%CMI-2.4%' THEN 1
WHEN GroupNames LIKE '%CDO%' AND GroupNames LIKE '%CMI-2.4%' THEN 1
WHEN GroupNames LIKE '%CWS%' AND GroupNames LIKE '%CMI-4.1%' THEN 1
WHEN GroupNames LIKE '%CDO%' AND GroupNames LIKE '%CMI-4.1%' THEN 1
WHEN GroupNames LIKE '%CWS%' AND GroupNames LIKE '%COI%' THEN 1
WHEN GroupNames LIKE '%CDO%' AND GroupNames LIKE '%COI%' THEN 1
WHEN GroupNames LIKE '%CWS%' AND GroupNames LIKE '%MFT%' THEN 1
WHEN GroupNames LIKE '%CDO%' AND GroupNames LIKE '%MFT%' THEN 1
WHEN GroupNames LIKE '%CWS%' AND GroupNames LIKE '%MSD%' THEN 1
WHEN GroupNames LIKE '%CDO%' AND GroupNames LIKE '%MSD%' THEN 1
WHEN GroupNames LIKE '%HFM%' THEN 1
WHEN GroupNames LIKE '%CIT%' THEN 1
ELSE 2 END AS TierLevel
FROM
(SELECT DISTINCT j2.scheduledStartDateTime, j2.serviceOrder, j2.financialSystemID, j2.revenueCenterID, c.Name AS CompanyName, e.fullname AS SalesEngineer,
(SELECT sg.name + ', '
FROM            dbo.Job j INNER JOIN
                         dbo.JobActualServices jas ON j.jobID = jas.jobID INNER JOIN
                         dbo.ServiceGroup sg ON jas.serviceGroupID = sg.id
WHERE       (j.scheduledStartDateTime BETWEEN @From AND DATEADD(DAY, DATEDIFF(DAY, '19000101', @To), '23:59:59')) AND
                         (j.revenueCenterID IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@BusinessUnit,','))) AND (j.jobstatusid IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@JobStatus,','))) AND (j.deleted IS NULL) AND (sg.name = 'CAT'
                         OR sg.name = 'CRE'
                         OR sg.name = 'NMRT-E'
                         OR sg.name = 'NMRT-F'
                         OR sg.name = 'RAT'
                         OR sg.name = 'RSCT'
                         OR sg.name = 'SAT'
                         OR sg.name = 'URS'
						 OR sg.name = 'VSP'
						 OR sg.name = 'CDO'
						 OR sg.name = 'CIT'
						 OR sg.name = 'CMI-2.4'
						 OR sg.name = 'CMI-4.1'
						 OR sg.name = 'COI'
						 OR sg.name = 'CWS'
						 OR sg.name = 'FID'
						 OR sg.name = 'FIS'
						 OR sg.name = 'FM'
						 OR sg.name = 'GHT'
						 OR sg.name = 'HFM'
						 OR sg.name = 'MFT'
						 OR sg.name = 'MSC'
						 OR sg.name = 'MSD'
						 OR sg.name = 'PCF'
						 OR sg.name = 'PDF'
						 OR sg.name = 'PFD'
						 OR sg.name = 'PFF'
						 OR sg.name = 'PFI'
						 OR sg.name = 'PGRA'
						 OR sg.name = 'PIF'
						 OR sg.name = 'PND'
						 OR sg.name = 'PWH') AND j.serviceorder = j2.serviceorder
						 GROUP BY sg.name
FOR XML PATH('')) AS GroupNames
FROM            dbo.Job j2 INNER JOIN
                         dbo.JobActualServices jas2 ON j2.jobID = jas2.jobID INNER JOIN
                         dbo.ServiceGroup sg2 ON jas2.serviceGroupID = sg2.id LEFT OUTER JOIN
						 dbo.Company c ON j2.oneViewCompanyID = c.oneViewCompanyID LEFT OUTER JOIN
						 dbo.JobCrew jc ON j2.jobID = jc.jobID LEFT OUTER JOIN
						 dbo.Employee e ON jc.employeeID = e.id
WHERE      (j2.scheduledStartDateTime BETWEEN @From AND DATEADD(DAY, DATEDIFF(DAY, '19000101', @To), '23:59:59')) AND
                         (j2.revenueCenterID IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@BusinessUnit,','))) AND (j2.jobstatusid IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@JobStatus,','))) AND (j2.deleted IS NULL) AND (sg2.name = 'CAT'
                         OR sg2.name = 'CRE'
                         OR sg2.name = 'NMRT-E'
                         OR sg2.name = 'NMRT-F'
                         OR sg2.name = 'RAT'
                         OR sg2.name = 'RSCT'
                         OR sg2.name = 'SAT'
                         OR sg2.name = 'URS'
						 OR sg2.name = 'VSP'
						 OR sg2.name = 'CDO'
						 OR sg2.name = 'CIT'
						 OR sg2.name = 'CMI-2.4'
						 OR sg2.name = 'CMI-4.1'
						 OR sg2.name = 'COI'
						 OR sg2.name = 'CWS'
						 OR sg2.name = 'FID'
						 OR sg2.name = 'FIS'
						 OR sg2.name = 'FM'
						 OR sg2.name = 'GHT'
						 OR sg2.name = 'HFM'
						 OR sg2.name = 'MFT'
						 OR sg2.name = 'MSC'
						 OR sg2.name = 'MSD'
						 OR sg2.name = 'PCF'
						 OR sg2.name = 'PDF'
						 OR sg2.name = 'PFD'
						 OR sg2.name = 'PFF'
						 OR sg2.name = 'PFI'
						 OR sg2.name = 'PGRA'
						 OR sg2.name = 'PIF'
						 OR sg2.name = 'PND'
						 OR sg2.name = 'PWH')
						 AND (jc.deleted IS NULL)
						 AND (jc.feCellRoleID = 2)
						 ) AS TempTable

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_US_Sales_Commission_Data]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Get_US_Sales_Commission_Data] 
	@From AS DateTime, @To AS DateTime, @BusinessUnit AS Char(4000), @JobStatus AS Char(255)
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT DISTINCT jobID, serviceOrder AS [Service Order], financialSystemID as [Financial System ID], scheduledStartDateTime AS [Scheduled Date], jobOperationStartTime AS [Job End Date], invoiceDateTime AS [Invoiced Date], Conveyance, BranchPlant AS [Branch Plant], ISNULL(rigName, 'Not Defined') AS [Well Name], CompanyName AS [Customer Name], Engineers AS [Engineer(s)], LEFT(LTRIM(RTRIM(SalesEngineers)), LEN(LTRIM(RTRIM(SalesEngineers))) - 1) AS [Sales Team], label AS [Job Status], LEFT(LTRIM(RTRIM(Services)), LEN(LTRIM(RTRIM(Services))) - 1) as Services, TicketTotal
FROM
(SELECT j2.jobID, j2.scheduledStartDateTime, jo.jobOperationStartTime, j2.serviceOrder, j2.financialSystemID, c.Name AS CompanyName, j2.invoiceDateTime, ct.type AS Conveyance, glam.value AS BranchPlant,
(SELECT ServiceName + '(' + ServiceCount + ')' + Char(10)
FROM	
(SELECT sg.name AS ServiceName, LTRIM(RTRIM(CAST(COUNT(sg.name) AS Char(2)))) AS ServiceCount
FROM            dbo.Job j INNER JOIN
						dbo.JobOperations jo ON j.jobID = jo.jobID AND jo.deleted IS NULL INNER JOIN
						dbo.JobOperationTools jot ON jo.jobOperationID = jot.jobOperationID AND jot.deleted IS NULL INNER JOIN
                         dbo.JobActualServices jas ON jot.jobOperationToolID = jas.jobOperationToolID AND jas.deleted IS NULL INNER JOIN
                         dbo.ServiceGroup sg ON jas.serviceGroupID = sg.id AND sg.deleted IS NULL
WHERE       ((@BusinessUnit IS NULL) OR (j.revenueCenterID IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@BusinessUnit,',')))) AND (j.jobstatusid IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@JobStatus,','))) AND (j.deleted IS NULL) AND j.serviceorder = j2.serviceorder
						 GROUP BY sg.name
						 ) AS SubTable
						 GROUP BY ServiceName, ServiceCount
FOR XML PATH('')) AS Services,
(SELECT e.fullname + Char(10)
FROM            dbo.Job j INNER JOIN
                         dbo.JobCrew jc ON j2.jobID = jc.jobID INNER JOIN
						 dbo.Employee e ON jc.employeeID = e.id
WHERE       ((@BusinessUnit IS NULL) OR (j.revenueCenterID IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@BusinessUnit,',')))) AND (j.jobstatusid IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@JobStatus,','))) AND (j.deleted IS NULL) AND (jc.feCellRoleID = 2) AND (jc.deleted IS NULL) AND j.serviceorder = j2.serviceorder
						 GROUP BY e.fullname
FOR XML PATH('')) AS SalesEngineers, 
(SELECT e.fullname + Char(10)
FROM            dbo.Job j INNER JOIN
                         dbo.JobCrew jc ON j2.jobID = jc.jobID INNER JOIN
						 dbo.Employee e ON jc.employeeID = e.id INNER JOIN
						 dbo.FECellRole fecr ON jc.feCellRoleID = fecr.feCellRoleID
WHERE       ((@BusinessUnit IS NULL) OR (j.revenueCenterID IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@BusinessUnit,',')))) AND (j.jobstatusid IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@JobStatus,','))) AND (j.deleted IS NULL) AND (fecr.feCellRoleTypeID = 5) AND (jc.deleted IS NULL) AND j.serviceorder = j2.serviceorder
						 GROUP BY e.fullname
FOR XML PATH('')) AS Engineers, 
(SELECT SUM(CASE WHEN j3.jobStatusID != 1 THEN JobCharges.nativeTotal ELSE JobCharges.adjustedNativeTotal END) FROM JobCharges INNER JOIN Job j3 ON JobCharges.jobID = j3.jobID WHERE j2.jobID = j3.jobID AND (JobCharges.deleted IS NULL OR JobCharges.deleted = 0)) AS TicketTotal, jw.rigName, js.label
FROM            dbo.Job j2 LEFT OUTER JOIN
                         dbo.JobActualServices jas2 ON j2.jobID = jas2.jobID AND (jas2.deleted IS NULL OR jas2.deleted = 0) INNER JOIN
						 dbo.JobOperations jo ON j2.jobID = jo.jobID AND jo.jobOperationTypeID = 15 AND (jo.deleted IS NULL OR jo.deleted = 0) LEFT OUTER JOIN
                         dbo.ServiceGroup sg2 ON jas2.serviceGroupID = sg2.id AND (sg2.deleted IS NULL OR sg2.deleted = 0) LEFT OUTER JOIN
						 dbo.Company c ON j2.oneViewCompanyID = c.oneViewCompanyID LEFT OUTER JOIN
						 dbo.JobCrew jc ON j2.jobID = jc.jobID AND (jc.feCellRoleID = 2) AND (jc.deleted IS NULL OR jc.deleted = 0) LEFT OUTER JOIN
						 dbo.Employee e ON jc.employeeID = e.id LEFT OUTER JOIN
						 dbo.JobWells jw ON j2.jobID = jw.jobID AND (jw.deleted IS NULL OR jw.deleted = 0) LEFT OUTER JOIN
						 dbo.ConveyanceType ct ON jw.conveyanceTypeID = ct.conveyanceTypeID AND (ct.deleted IS NULL OR ct.deleted = 0) LEFT OUTER JOIN
						 dbo.JobStatus js ON j2.jobStatusID = js.jobStatusID LEFT OUTER JOIN
						 GWIS_LocationAttributes gla ON j2.operationalLocationID = gla.GWIS_LocationID  AND gla.GWIS_LocationRelationTypeID = 1 LEFT OUTER JOIN
						GWIS_LocationAttributeMatrix glam ON gla.GWIS_LocationAttributeID = glam.GWIS_LocationAttributeID AND glam.GWIS_LocationAttributeValueID = 97
WHERE      (jo.jobOperationStartTime BETWEEN @From AND DATEADD(DAY, DATEDIFF(DAY, '19000101', @To), '23:59:59')) AND
                         ((@BusinessUnit IS NULL) OR (j2.revenueCenterID IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@BusinessUnit,',')))) AND (j2.jobstatusid IN (SELECT CAST(Value AS int) FROM dbo.FnSplit(@JobStatus,','))) AND (j2.deleted IS NULL)
GROUP BY j2.jobID, j2.scheduledStartDateTime, jo.jobOperationStartTime, j2.serviceOrder, j2.financialSystemID, c.Name, j2.invoiceDateTime, glam.value, j2.jobID, jw.rigName, ct.type, js.label
						 ) AS TempTable

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ImportMyAdvisorFixedAssetData]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ImportMyAdvisorFixedAssetData]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_ImportMyAdvisorFixedAssetData_Old]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ImportMyAdvisorFixedAssetData_Old]        
   AS  
BEGIN  
   BEGIN TRY  
 SET NOCOUNT ON;  
     
 -- truncate stage table  
 TRUNCATE table StagingFixedAssets;  
   
 INSERT INTO StagingFixedAssets   
 (
	FixedAssetId, SerialNum, InventoryItemNum, AssetNumber, BranchPlant, EquipmentStatus,   
	RNItemNum, AssetDescription, LastStatusChangeDate, CurrencyCode, Revision, CatCode16,   
  ToolPanel, ToolCode, DateAdded, BusinessUnit, ThirdItemNumber, AssetLifeRemaining, Version, [TopLevelFixedAssetId]  
 )  
 SELECT DISTINCT  
  FixedAssetId,        
  SUBSTRING(SerialNum,0, 20),        
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
  ISNULL(CASE WHEN CHARINDEX(ToolPanel + '_' + ToolCode+'_', ThirdItemNumber) = 1 
				THEN REPLACE(ThirdItemNumber, ToolPanel + '_' + ToolCode+'_', '') 
				ELSE ThirdItemNumber 
			END,
		SUBSTRING([Version],0,20)) [Version],
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
 --New entries started from 44153  
  
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
   a.toolstatusid = CASE WHEN stg.EquipmentStatus in('PT','IN','WK','AV','MB','SB') THEN '1' ELSE '2'  END  
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
  CASE WHEN stg.EquipmentStatus in('PT','IN','WK','AV','MB','SB') THEN '1' ELSE '2'  END,  
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
GO
/****** Object:  StoredProcedure [dbo].[sp_JobBonusTransactionsToFile]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 7/22/2014
-- Description:	This procedure creates a new Job Bonus Transaction file in .xls format based on transactions since the last export to file.  The file is located at \\sdcsqlftwre\JobBonus\...
-- =============================================
CREATE PROCEDURE [dbo].[sp_JobBonusTransactionsToFile]
	
AS
BEGIN
	DECLARE @FileName AS Char(50)
	DECLARE @LastDate AS DateTime
	DECLARE @SQLQuery varchar(8000)
	DECLARE @BCPQuery varchar(8000)
	DECLARE @Result AS Int

	SET @LastDate = (SELECT TOP 1 fileDate FROM JobBonusTransactionFileLog ORDER BY fileDate DESC)

	-- Need to update "[oneview]" at Go Live.
	SET @SQLQuery = 'SELECT ''Modified'', ''ModifiedByWFTID'', ''ModifiedBy'', ''JobDate'', ''ServiceOrder'', ''EmployeeWFTID'', ''Employee'', ''OldStatus'', ''NewStatus'', ''BonusTotal'', ''DeclineReason'' UNION ALL SELECT CONVERT(varchar, JobBonusStatusLog.modified, 120) AS Modified, LTRIM(RTRIM(CAST(JobBonusStatusLog.wftid AS Char(20)))) AS ModifiedByWFTID, CASE WHEN JobBonusStatusLog.wftid = ''JDE'' THEN ''JDE'' ELSE Employee.fullname END AS [Modified By], CONVERT(varchar, Job.scheduledStartDateTime, 120) AS [Job Date], LTRIM(RTRIM(CAST(Job.serviceOrder AS Char(30)))) AS ServiceOrder, LTRIM(RTRIM(CAST(Employee_1.wftid AS Char(20)))) AS EmployeeWFTID, Employee_1.fullname AS Employee, JobBonusStatus.jobBonusStatusName AS [Old Status], JobBonusStatus_1.jobBonusStatusName AS [New Status], LTRIM(RTRIM(CAST(ISNULL(SUM(JobBonusStatusLog.bonusTotal), 0) AS Char(20)))) AS [Bonus Total], JobBonusDeclineReason.jobBonusDeclineReason AS [Decline Reason] FROM [oneview].dbo.Job INNER JOIN [oneview].dbo.JobCrew INNER JOIN [oneview].dbo.JobBonus INNER JOIN [oneview].dbo.JobBonusStatus AS JobBonusStatus_1 INNER JOIN [oneview].dbo.JobBonusStatus INNER JOIN [oneviewtest].dbo.JobBonusStatusLog  ON JobBonusStatus.jobBonusStatusID = JobBonusStatusLog.oldJobBonusStatusID ON JobBonusStatus_1.jobBonusStatusID = JobBonusStatusLog.newJobBonusStatusID ON JobBonus.jobBonusID = JobBonusStatusLog.jobBonusID ON JobCrew.jobCrewID = JobBonus.jobCrewID LEFT JOIN [oneview].dbo.Employee ON JobBonusStatusLog.wftid = Employee.wftid INNER JOIN [oneview].dbo.Employee AS Employee_1 ON JobCrew.employeeID = Employee_1.id ON Job.jobID = JobCrew.jobID LEFT OUTER JOIN [oneview].dbo.JobBonusDeclineReason ON JobBonusStatusLog.jobBonusDeclineReasonID = JobBonusDeclineReason.jobBonusDeclineReasonID AND JobBonusDeclineReason.deleted IS NULL WHERE (JobCrew.deleted IS NULL) AND (Job.deleted IS NULL) AND (JobBonus.deleted IS NULL) AND (JobBonusStatusLog.modified >= ''' + LTRIM(RTRIM(CAST(@LastDate AS Char(20)))) + ''') GROUP BY JobBonusStatusLog.modified, JobBonusStatusLog.wftid, Employee.fullname, Job.scheduledStartDateTime, Job.jobID, JobCrew.employeeID, Employee_1.wftid, Employee_1.fullname, JobBonusStatus.jobBonusStatusName, JobBonusStatus_1.jobBonusStatusName, JobBonusDeclineReason.jobBonusDeclineReason, Job.serviceOrder, Employee_1.modified'

	SET @FileName = 'Transactions_' + REPLACE(CONVERT(varchar, GETUTCDATE(),111),'/','') + REPLACE(CONVERT(varchar, GETUTCDATE(),108),':','') + '.xls'
	SET @BCPQuery = 'bcp "' + @SQLQuery + '" queryout \\sdcsqlftwre\JobBonus\' + @FileName + ' -c -T'
	EXEC @Result = MASTER..xp_cmdshell @BCPQuery

	IF (@Result = 0)
	BEGIN
		INSERT INTO JobBonusTransactionFileLog (fileDate)
		VALUES (GETUTCDATE())
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ProcessFlatRateJobBonus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 08/09/2013
-- Description:	Update Job Bonus Approval
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProcessFlatRateJobBonus]
	
	@BonusID text,  @ManagerWFTID Char(10), @Country Char(50), @CurrencyCode Char(50)

AS
BEGIN

	DECLARE @jobBonusProcessedID AS uniqueidentifier
	DECLARE @dateProcessed AS DateTime

	SET @jobBonusProcessedID = NEWID()
	SET @dateProcessed = GETUTCDATE()
		
	INSERT INTO [dbo].[JobBonusProcessed]
           ([jobBonusProcessedID]
           ,[dateProcessed]
           ,[processedBy]
		   ,[country]
		   ,[currencyCode])
     VALUES
           (@jobBonusProcessedID
           ,@dateProcessed
           , @ManagerWFTID
		   , @Country
		   , @CurrencyCode)

	INSERT INTO JobBonusHistory (jobBonusHistoryID, jobBonusID, hrmsEmployeeID, fullname, serviceOrder, jobid, jobBonusProcessedID, processedBy, dateProcessed, actualBonusTotal, country, currencyCode)
		SELECT DISTINCT NEWID(), jb.jobBonusID, e2.hrmsEmployeeID, e2.displayname as fullname, j.serviceOrder, j.jobid, @jobBonusProcessedID AS jobBonusProcessedID, @ManagerWFTID AS processedBy, @dateProcessed AS dateProcessed, ROUND(ISNULL(jbfrd.nativeBonusFlatRate, 0), 2) AS actualBonusTotal, @Country AS country, @CurrencyCode AS currencyCode
		FROM Employee AS e2
			RIGHT OUTER JOIN JobCrew AS JobCrew_1 ON e2.id = JobCrew_1.employeeID
			FULL OUTER JOIN JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID
			INNER JOIN JobBonusFlatRateData AS jbfrd ON jb.jobBonusID = jbfrd.jobBonusID
			FULL OUTER JOIN Job AS j ON JobCrew_1.jobID = j.jobID
		WHERE (jb.deleted IS NULL OR jb.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND (j.deleted IS NULL OR j.deleted = 0) AND (jbfrd.deleted IS NULL OR jbfrd.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND 
								(jbfrd.nativeBonusFlatRate > 0)
								--AND (jb.jobBonusID IN (SELECT jobBonusID FROM JobBonus WHERE jobBonusStatusID = 3))
								AND (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, e2.hrmsEmployeeID, e2.displayname, jbfrd.nativeBonusFlatRate, j.scheduledStartDateTime, j.serviceOrder, j.jobid
		   	
	INSERT INTO JobBonusStatusLog (jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, nativeBonusTotal)
       SELECT        NEWID(), @ManagerWFTID, getutcdate(), jb.jobBonusID, jb.jobBonusStatusID, 4, SUM(jbfrd.nativeBonusFlatRate) AS bonusTotal
		FROM            JobBonus AS jb LEFT OUTER JOIN JobBonusFlatRateData AS jbfrd ON jb.jobBonusID = jbfrd.jobBonusID
		WHERE (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, jb.jobBonusStatusID

	UPDATE [dbo].[JobBonus] SET [jobBonusStatusID] = 4, [jobBonusProcessedID] = @jobBonusProcessedID WHERE [jobBonusProcessedID] IS NULL AND [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,','))

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ProcessJobBonus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 08/09/2013
-- Description:	Update Job Bonus Approval
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProcessJobBonus]
	
	@BonusID text,  @ManagerWFTID Char(10), @Country Char(50), @CurrencyCode Char(50)

AS
BEGIN

	DECLARE @jobBonusProcessedID AS uniqueidentifier
	DECLARE @dateProcessed AS DateTime

	SET @jobBonusProcessedID = NEWID()
	SET @dateProcessed = GETUTCDATE()
		
	INSERT INTO [dbo].[JobBonusProcessed]
           ([jobBonusProcessedID]
           ,[dateProcessed]
           ,[processedBy]
		   ,[country]
		   ,[currencyCode])
     VALUES
           (@jobBonusProcessedID
           ,@dateProcessed
           , @ManagerWFTID
		   , @Country
		   , @CurrencyCode)

	INSERT INTO JobBonusHistory (jobBonusHistoryID, jobBonusID, hrmsEmployeeID, fullname, serviceOrder, jobid, jobBonusProcessedID, processedBy, dateProcessed, actualBonusTotal, country, currencyCode)
		SELECT DISTINCT NEWID(), jb.jobBonusID, e2.hrmsEmployeeID, e2.displayname as fullname, j.serviceOrder, j.jobid, @jobBonusProcessedID AS jobBonusProcessedID, @ManagerWFTID AS processedBy, @dateProcessed AS dateProcessed, ROUND(ISNULL(jbd.nativeJDEBonusTotal, 0), 2) AS actualBonusTotal, @Country AS country, @CurrencyCode AS currencyCode
		FROM Employee AS e2
			RIGHT OUTER JOIN JobCrew AS JobCrew_1 ON e2.id = JobCrew_1.employeeID
			FULL OUTER JOIN JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID
			INNER JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID AND jbd.nativeJDEServiceOrderTicketTotal IS NOT NULL
			FULL OUTER JOIN Job AS j ON JobCrew_1.jobID = j.jobID
		WHERE (jb.deleted IS NULL OR jb.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND (j.deleted IS NULL OR j.deleted = 0) AND (jbd.deleted IS NULL OR jbd.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND 
								(jbd.deleted IS NULL OR jbd.deleted = 0) AND (jbd.nativeJDEBonusTotal > 0)
								AND (jb.jobBonusID IN (SELECT jobBonusID FROM JobBonus WHERE jobBonusStatusID = 3))
								AND (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, e2.hrmsEmployeeID, e2.displayname, jbd.nativeJDEBonusTotal, j.scheduledStartDateTime, j.serviceOrder, j.jobid
		   	
	INSERT INTO JobBonusStatusLog (jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, nativeBonusTotal)
       SELECT        NEWID(), @ManagerWFTID, getutcdate(), jb.jobBonusID, jb.jobBonusStatusID, 4, SUM(jbd.nativeJDEBonusTotal) AS bonusTotal
		FROM            JobBonus AS jb LEFT OUTER JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID
		WHERE (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, jb.jobBonusStatusID

	UPDATE [dbo].[JobBonus] SET [jobBonusStatusID] = 4, [jobBonusProcessedID] = @jobBonusProcessedID WHERE [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')) --AND [jobBonusProcessedID] IS NULL

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ProcessJobBonus_Special]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 08/09/2013
-- Description:	Update Job Bonus for Special Occassions
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProcessJobBonus_Special]
	
	@ManagerWFTID Char(10), @Country Char(50), @CurrencyCode Char(50)

AS
BEGIN

	DECLARE @jobBonusProcessedID AS uniqueidentifier
	DECLARE @dateProcessed AS DateTime

	SET @jobBonusProcessedID = NEWID()
	SET @dateProcessed = GETUTCDATE()
		
	INSERT INTO [dbo].[JobBonusProcessed]
           ([jobBonusProcessedID]
           ,[dateProcessed]
           ,[processedBy]
		   ,[country]
		   ,[currencyCode])
     VALUES
           (@jobBonusProcessedID
           ,@dateProcessed
           , @ManagerWFTID
		   , @Country
		   , @CurrencyCode)

	INSERT INTO JobBonusHistory (jobBonusHistoryID, jobBonusID, hrmsEmployeeID, fullname, serviceOrder, jobid, jobBonusProcessedID, processedBy, dateProcessed, actualBonusTotal, country, currencyCode)
	SELECT        NEWID(), jbp.jobBonusID, jbp.hrmsEmployeeID, jbp.fullname, jbp.serviceOrder, j.jobID, @jobBonusProcessedID AS jobBonusProcessedID, @ManagerWFTID AS processedBy, GETUTCDATE() AS dateProcessed, jbp.actualBonusTotal, @Country AS country, @CurrencyCode AS currencyCode
	FROM            JobBonusProcess_Special AS jbp INNER JOIN
                    Job AS j ON jbp.serviceOrder = j.serviceOrder
	ORDER BY sortOrder
					   	
	INSERT INTO JobBonusStatusLog (jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, bonusTotal)
       SELECT        NEWID(), @ManagerWFTID, getutcdate(), jbp.jobBonusID, jb.jobBonusStatusID, 4, jbp.actualBonusTotal AS bonusTotal
		FROM            JobBonusProcess_Special AS jbp INNER JOIN
                    JobBonus AS jb ON jbp.jobBonusID = jb.jobBonusID
	ORDER BY sortOrder

	UPDATE [dbo].[JobBonus] SET [jobBonusStatusID] = 4, [jobBonusProcessedID] = @jobBonusProcessedID WHERE [jobBonusID] IN (SELECT DISTINCT jbp.jobBonusID FROM JobBonusProcess_Special AS jbp)

	UPDATE [dbo].[JobBonusProcess_Special] SET [deleted] = 1

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ProcessJobBonus_TEST]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 08/09/2013
-- Description:	Update Job Bonus Approval
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProcessJobBonus_TEST]
	
	@BonusID text,  @ManagerWFTID Char(10), @Country Char(50), @CurrencyCode Char(50)

AS
BEGIN

	DECLARE @jobBonusProcessedID AS uniqueidentifier
	DECLARE @dateProcessed AS DateTime

	SET @jobBonusProcessedID = NEWID()
	SET @dateProcessed = GETUTCDATE()
		
	INSERT INTO [dbo].[JobBonusProcessed]
           ([jobBonusProcessedID]
           ,[dateProcessed]
           ,[processedBy]
		   ,[country]
		   ,[currencyCode])
     VALUES
           (@jobBonusProcessedID
           ,@dateProcessed
           , @ManagerWFTID
		   , @Country
		   , @CurrencyCode)

	UPDATE [dbo].[JobBonus] SET [jobBonusStatusID] = 4, [jobBonusProcessedID] = @jobBonusProcessedID WHERE [jobBonusProcessedID] IS NULL AND [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,','))
	
	INSERT INTO JobBonusHistory (jobBonusHistoryID, jobBonusID, hrmsEmployeeID, fullname, serviceOrder, jobid, jobBonusProcessedID, processedBy, dateProcessed, actualBonusTotal, country, currencyCode)
		SELECT DISTINCT NEWID(), jb.jobBonusID, e2.hrmsEmployeeID, e2.fullname, j.serviceOrder, j.jobid, @jobBonusProcessedID AS jobBonusProcessedID, @ManagerWFTID AS processedBy, @dateProcessed AS dateProcessed, ROUND(ISNULL(jbd.nativeJDEBonusTotal, 0), 2) AS actualBonusTotal, @Country AS country, @CurrencyCode AS currencyCode
		FROM Employee AS e2
			RIGHT OUTER JOIN JobCrew AS JobCrew_1 ON e2.id = JobCrew_1.employeeID
			FULL OUTER JOIN JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID
			INNER JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID AND jbd.jdeServiceOrTicketTotal IS NOT NULL
			FULL OUTER JOIN Job AS j ON JobCrew_1.jobID = j.jobID
		WHERE (jb.deleted IS NULL OR jb.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND (j.deleted IS NULL OR j.deleted = 0) AND (jbd.deleted IS NULL OR jbd.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND 
								(jbd.deleted IS NULL OR jbd.deleted = 0) AND (jbd.jdeBonusTotal > 0)
								AND (jb.jobBonusID IN (SELECT jobBonusID FROM JobBonus WHERE jobBonusStatusID = 4))
								AND (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, e2.hrmsEmployeeID, e2.fullname, jbd.nativeJDEBonusTotal, j.scheduledStartDateTime, j.serviceOrder, j.jobid
		   	
	--INSERT INTO JobBonusStatusLog (jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, bonusTotal)
 --      SELECT        NEWID(), @ManagerWFTID, getutcdate(), jb.jobBonusID, jb.jobBonusStatusID, 4, SUM(jbd.nativeJDEBonusTotal) AS bonusTotal
	--	FROM            JobBonus AS jb LEFT OUTER JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID
	--	WHERE (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
	--	GROUP BY jb.jobBonusID, jb.jobBonusStatusID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ProcessJobBonusExceptions]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 04/30/2015
-- Description:	Process Job Bonus Exceptions
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProcessJobBonusExceptions]
	
	@BonusID text,  @ManagerWFTID Char(10), @Country Char(50), @CurrencyCode Char(50)

AS
BEGIN

	DECLARE @jobBonusProcessedID AS uniqueidentifier
	DECLARE @dateProcessed AS DateTime

	SET @jobBonusProcessedID = NEWID()
	SET @dateProcessed = GETUTCDATE()
		
	INSERT INTO [dbo].[JobBonusProcessed]
           ([jobBonusProcessedID]
           ,[dateProcessed]
           ,[processedBy]
		   ,[country]
		   ,[currencyCode])
     VALUES
           (@jobBonusProcessedID
           ,@dateProcessed
           , @ManagerWFTID
		   , @Country
		   , @CurrencyCode)

	INSERT INTO JobBonusHistory (jobBonusHistoryID, jobBonusID, hrmsEmployeeID, fullname, serviceOrder, jobid, jobBonusProcessedID, processedBy, dateProcessed, actualBonusTotal, country, currencyCode)
		SELECT DISTINCT NEWID(), jb.jobBonusID, e2.hrmsEmployeeID, e2.displayname as fullname, j.serviceOrder, j.jobid, @jobBonusProcessedID AS jobBonusProcessedID, @ManagerWFTID AS processedBy, @dateProcessed AS dateProcessed, ROUND(ISNULL(jbed.nativeBonusException, 0), 2) AS actualBonusTotal, @Country AS country, @CurrencyCode AS currencyCode
		FROM Employee AS e2
			RIGHT OUTER JOIN JobCrew AS JobCrew_1 ON e2.id = JobCrew_1.employeeID
			FULL OUTER JOIN JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID
			INNER JOIN JobBonusExceptionData AS jbed ON jb.jobBonusID = jbed.jobBonusID
			FULL OUTER JOIN Job AS j ON JobCrew_1.jobID = j.jobID
		WHERE (jb.deleted IS NULL OR jb.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND (j.deleted IS NULL OR j.deleted = 0) AND (jbed.deleted IS NULL OR jbed.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0)								--AND (jb.jobBonusID IN (SELECT jobBonusID FROM JobBonus WHERE jobBonusStatusID = 3))
								AND (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, e2.hrmsEmployeeID, e2.displayname, jbed.nativeBonusException, j.scheduledStartDateTime, j.serviceOrder, j.jobid
		   	
	INSERT INTO JobBonusStatusLog (jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, nativeBonusTotal)
       SELECT        NEWID(), @ManagerWFTID, getutcdate(), jb.jobBonusID, jb.jobBonusStatusID, 4, SUM(jbed.nativeBonusException) AS bonusTotal
		FROM            JobBonus AS jb LEFT OUTER JOIN JobBonusExceptionData AS jbed ON jb.jobBonusID = jbed.jobBonusID
		WHERE (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, jb.jobBonusStatusID

	UPDATE [dbo].[JobBonus] SET [jobBonusStatusID] = 4, [jobBonusProcessedID] = @jobBonusProcessedID WHERE [jobBonusProcessedID] IS NULL AND [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,','))

END
GO
/****** Object:  StoredProcedure [dbo].[sp_PuntJobOffline]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Justin Overton
-- Create date: 5/28/2015
-- Description:	Punts a job back into offline mode
-- =============================================
CREATE PROCEDURE [dbo].[sp_PuntJobOffline] 
	@jobId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @jobStatusId tinyint

	SET @jobStatusId = 2

	EXECUTE [dbo].[sp_SetJobStatus] @jobId, @jobStatusId
	
	UPDATE JobReview SET deleted=1 WHERE JobID=@jobId;
	Update job set dateUploaded = getutcdate() where jobid =  @jobId;
	INSERT INTO JobAudit(jobID, username, remoteHost, date, comment)
		VALUES(@jobId, SUSER_NAME(), host_name(), GETUTCDATE(), 'sp_PuntJobOffline')	   
END

GO
/****** Object:  StoredProcedure [dbo].[sp_select_job_incr_updates_inserts]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Doug
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_select_job_incr_updates_inserts]
	-- Add the parameters for the stored procedure here
	@sync_last_received_anchor binary(8), 
	@sync_new_received_anchor timestamp,
	@sync_client_id uniqueidentifier,
	@get_updates bit,
	@districts nvarchar(max)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @t_districts table
    (
		id int primary key
    )
    insert into @t_districts select * from int_list_to_tbl(@districts);
    --select * from @t_districts
    --select @sync_client_id
    select @sync_last_received_anchor
    --drop table #t_jobs
    --select top 1 * into #t_jobs from Job
    --select * from #t_jobs
    --delete from #t_jobs
    
    --select * from Job j join @t_districts td on j.operatingDistrictID = td.id
    
	if @get_updates = 1
		select * from Job j join @t_districts td on j.operatingDistrictID = td.id
		where updated > @sync_last_received_anchor
						and updated <= @sync_new_received_anchor
						and updateId <> @sync_client_id
						and not (inserted > @sync_last_received_anchor
						and insertId <> @sync_client_id)		
	else
		select * from Job j join @t_districts td on j.operatingDistrictID = td.id
		where inserted > @sync_last_received_anchor                    
                    and inserted <= @sync_new_received_anchor
                    and insertId <> @sync_client_id
                    
	--select jobID,dateSubmitted,financialSystemTypeID,financialSystemID,serviceOrder,
	--customerID,scheduledStartDateTime,actualStartDateTime,geographicDistrictID,
	--endDateTime,operatingDistrictID,comments,specialInstructions,jobStatusID,deleted
	--from #t_jobs
	
	--drop table #t_jobs
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetJobStatus]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SetJobStatus] 
	-- Add the parameters for the stored procedure here
	@jobId uniqueidentifier,
	@jobStatusId tinyint	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @currentJobStatusId tinyint
	
	select @currentJobStatusId = jobStatusID from job where jobid = @jobId

	--select * from job where serviceorder like '6770-11%'

	--select * from jobstatus

	update job set jobstatusid = @jobStatusId,dateUploaded=getutcdate() where jobid = @jobId

	insert into jobstatuslog(wftid,modified,jobid,oldjobstatusid,newjobstatusid) values('oneview',getutcdate(),@jobId,@currentJobStatusId,@jobStatusId)
    
END
GO
/****** Object:  StoredProcedure [dbo].[sp_touchjobandrelated]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_touchjobandrelated] 
	@p_JobIDValue uniqueidentifier 
AS
BEGIN 
	update Job set inserted=inserted where jobid = @p_JobIDValue
	update JobActualServices  set inserted=inserted where jobid = @p_JobIDValue
	update JobOperations set inserted=inserted where jobid = @p_JobIDValue
	update JobWells set inserted=inserted where jobid = @p_JobIDValue
	update JobInvoice set inserted=inserted where jobid = @p_JobIDValue
	update JobAdditionalCharges set inserted=inserted where jobid = @p_JobIDValue
	update JobCrew set inserted=inserted where jobid = @p_JobIDValue
	update JobAssets set inserted=inserted where jobid = @p_JobIDValue
	update JobSelectedServices set inserted=inserted where jobid = @p_JobIDValue
	update JobCustomerCounts set inserted=inserted where jobid = @p_JobIDValue
	update Failures set inserted=inserted where jobid = @p_JobIDValue
	update JobCharges set inserted=inserted where jobid = @p_JobIDValue
	update FailureLossCategory set inserted = inserted where failureid in (select failureid from failures where  jobid = @p_JobIDValue)
	update FailureValue  set inserted = inserted where failureid in (select failureid from failures where  jobid = @p_JobIDValue)
	update FailureEventValue set inserted = inserted where failureid in (select failureid from failures where  jobid = @p_JobIDValue)
	update JobOperationAuxData set inserted = inserted where joboperationid in (select joboperationid from joboperations where  jobid = @p_JobIDValue)
	update JobOperationTools set inserted = inserted where joboperationid in (select joboperationid from joboperations where  jobid = @p_JobIDValue)
	update JobOperationEvents set inserted = inserted where joboperationid in (select joboperationid from joboperations where  jobid = @p_JobIDValue)
	update Well set inserted = inserted where wellID in (select oneViewWellID from JobWells where  jobid = @p_JobIDValue)
	update JobWellBoreholeProfile set inserted = inserted where jobWellID in (select jobWellID from JobWells where  jobid = @p_JobIDValue)
	update JobWellCasingTubingProfile set inserted = inserted where jobWellID in (select jobWellID from JobWells where  jobid = @p_JobIDValue)
	update FailureClassification set inserted = inserted where failurelosscategoryid in (select failurelosscategoryid from failurelosscategory where failureid in (select failureid from failures where  jobid = @p_JobIDValue))
	update FailureValue set inserted = inserted where failurelosscategoryid in (select failurelosscategoryid from failurelosscategory where failureid in (select failureid from failures where  jobid = @p_JobIDValue))
	update FailureTool set inserted = inserted where failurelosscategoryid in (select failurelosscategoryid from failurelosscategory where failureid in (select failureid from failures where  jobid = @p_JobIDValue))
	update FailureToolV2 set inserted = inserted where failurelosscategoryid in (select failurelosscategoryid from failurelosscategory where failureid in (select failureid from failures where  jobid = @p_JobIDValue))
	update FailureEventValue set inserted = inserted where failurelosscategoryid in (select failurelosscategoryid from failurelosscategory where failureid in (select failureid from failures where  jobid = @p_JobIDValue))
	update JobOperationEventIntervals set inserted = inserted where jobOperationEventID in (select jobOperationEventID from JobOperationEvents where joboperationid in (select joboperationid from joboperations where  jobid = @p_JobIDValue))

END
GO
/****** Object:  StoredProcedure [dbo].[sp_touchJobsFromJobStatusLogRange]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_touchJobsFromJobStatusLogRange] 
	@p_startDate datetime,
    @p_endDate datetime

AS
BEGIN
declare @jobid uniqueidentifier

declare curTouch CURSOR STATIC FOR
select distinct jobID from JobStatusLog where modified between @p_startDate and @p_endDate

open curTouch
fetch next from curTouch into @jobid
while @@fetch_status = 0
BEGIN
    print 'Touching Job: '+cast(@jobid as character varying(50))
	exec sp_touchjobandrelated @jobid

	fetch next from curTouch into @jobid
END
close curTouch
deallocate curTouch
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateJobBonusApproval]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darin Witten
-- Create date: 08/09/2013
-- Description:	Update Job Bonus Approval
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateJobBonusApproval]
	
	@BonusID text, @ManagerID Int, @jobBonusStatusID Int

AS
BEGIN

	DECLARE @ManagerWFTID Char(10)
	SET @ManagerWFTID = (SELECT wftid FROM Employee WHERE id = @ManagerID)
	
	INSERT INTO JobBonusStatusLog (jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, bonusTotal)
       SELECT        NEWID(), @ManagerWFTID, getutcdate(), jb.jobBonusID, jb.jobBonusStatusID, @jobBonusStatusID, SUM(CASE WHEN jbd.jdeServiceOrTicketTotal IS NULL THEN jbd.bonusTotal ELSE jbd.jdeBonusTotal END) AS bonusTotal
		FROM            JobBonus AS jb LEFT OUTER JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID
		WHERE (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, jb.jobBonusStatusID

	IF @jobBonusStatusID = 1  --Pending
	BEGIN
	UPDATE [dbo].[JobBonus] SET [IsApproved] = NULL, [approvedBy] = NULL, [dateApproved] = NULL, [jobBonusStatusID] = 1 WHERE [jobBonusProcessedID] IS NULL AND [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,','))
	END
	
	IF @jobBonusStatusID = 2  --Approved
	BEGIN
	UPDATE [dbo].[JobBonus] SET [IsApproved] = 1, [approvedBy] = @ManagerID, [dateApproved] = GETUTCDATE(), [jobBonusStatusID] = 2 WHERE [jobBonusProcessedID] IS NULL AND [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,','))
	END

	IF @jobBonusStatusID = 3  --Accepted
	BEGIN
	UPDATE [dbo].[JobBonus] SET [jobBonusStatusID] = 3 WHERE [jobBonusProcessedID] IS NULL AND [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,','))
	END

	-- #4 is Processed

	-- #5 is Partial

	-- #6 is Declined	

	--IF @jobBonusStatusID = 7  --On Hold
	--BEGIN
	--UPDATE [dbo].[JobBonus] SET [IsApproved] = NULL, [approvedBy] = NULL, [dateApproved] = NULL, [jobBonusStatusID] = 7 WHERE [jobBonusProcessedID] IS NULL AND [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,','))
	--END

END
GO
/****** Object:  StoredProcedure [dbo].[spForceWPTSJobUpdate]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spForceWPTSJobUpdate]
	-- Add the parameters for the stored procedure here
	@jobid uniqueidentifier, 
	@clearWPTSId bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--Resubmit the job and get a new WPTS ID
--ONLY use this if the current WPTS id for a job is invalid    
if @clearWPTSId = 1
begin
	--Clear WPTSId from job
	update job set job.wptsid = null where jobid = @jobid
	----Clear WPTSId and MaxLastUpdated from last job posting record
	--update wpts_jobpostings set maxlastupdated = null,wptsid = null

	--from wpts_lastjobposting, wpts_jobpostings
	--where wpts_lastjobposting.jobid = @jobid and wpts_jobpostings.jobid = wpts_lastjobposting.jobid
	--and wpts_jobpostings.wptsid = wpts_lastjobposting.wptsid
	--and wpts_jobpostings.wptsPosted = wpts_lastjobposting.wptsPosted
	--and wpts_jobpostings.maxLastUpdated = wpts_lastjobposting.maxLastUpdated
	--Clear MaxLastUpdated from all postings to force the repush and get a new WPTS ID
	update wpts_jobpostings set maxlastupdated = null--,wptsid = null
	from wpts_lastjobposting, wpts_jobpostings
	where wpts_lastjobposting.jobid = @jobid and wpts_jobpostings.jobid = wpts_lastjobposting.jobid
	--and wpts_jobpostings.wptsid = wpts_lastjobposting.wptsid
	--and wpts_jobpostings.wptsPosted = wpts_lastjobposting.wptsPosted	
end
else
update jobwells set inserted = inserted where jobid = @jobid and (jobwells.deleted is null or jobwells.deleted = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateOperationLocationTable]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spUpdateOperationLocationTable]
as
begin
SET NOCOUNT ON;
TRUNCATE TABLE OperationalLocation;


WITH CTE AS(
	SELECT 
		gwis_locationattributeid,
		gwis_locationid,
		name,
		parent,
		lvl,
		type,
		attrVal,
		attributeValueId,
		isCostCenter,
		isRevenueCenter,
		description,
		CASE type WHEN 'Region' THEN gwis_locationid ELSE NULL END as region,
		CASE type WHEN 'SubRegion' THEN gwis_locationid ELSE NULL END as subregion,
		CASE type WHEN 'Country' THEN gwis_locationid ELSE NULL END as country,
		CASE type WHEN 'Area' THEN gwis_locationid ELSE NULL END as area,
		CASE type WHEN 'District' THEN gwis_locationid ELSE NULL END as district,
		CASE type WHEN 'BranchPlant' THEN gwis_locationid ELSE NULL END as branchplant,
		CASE type WHEN 'BusinessUnit' THEN gwis_locationid ELSE NULL END as businessunit
	 FROM dbo.vOperationalLocation WHERE parent IS NULL
	UNION ALL
	SELECT 
		t.gwis_locationattributeid,
		t.gwis_locationid,
		t.name,
		t.parent,
		t.lvl,
		t.type,
		t.attrVal,
		t.attributeValueId,
		t.isCostCenter,
		t.isRevenueCenter,
		t.description,
		CASE t.type WHEN 'Region' THEN t.gwis_locationid ELSE c.region END as region,
		CASE t.type WHEN 'SubRegion' THEN t.gwis_locationid ELSE c.subregion END as subregion,
		CASE t.type WHEN 'Country' THEN t.gwis_locationid ELSE c.country END as country,
		CASE t.type WHEN 'Area' THEN t.gwis_locationid ELSE c.area END as area,
		CASE t.type WHEN 'District' THEN t.gwis_locationid ELSE c.district END as district,
		CASE t.type WHEN 'BranchPlant' THEN t.gwis_locationid ELSE c.branchplant END as branchplant,
		CASE t.type WHEN 'BusinessUnit' THEN t.gwis_locationid ELSE c.businessunit END as businessunit
	FROM dbo.vOperationalLocation t
	INNER JOIN CTE c ON c.gwis_locationid=t.parent AND c.[lvl] = t.lvl-1
)
INSERT INTO OperationalLocation(
	gwis_locationattributeid,
	gwis_locationid,
	name,
	parentId,
	lvl,
	type,
	attrVal,
	attributeValueId,
	isCostCenter,
	isRevenueCenter,
	description,
	regionId,
	subregionId,
	countryId,
	areaId,
	districtId,
	branchplantId,
	businessunitId
)
SELECT 
	gwis_locationattributeid,
	gwis_locationid,
	name,
	parent,
	lvl,
	type,
	attrVal,
	attributeValueId,
	isCostCenter,
	isRevenueCenter,
	description,
	region,
	subregion,
	country,
	area,
	district,
	branchplant,
	businessunit
	FROM CTE
	end	
GO
/****** Object:  StoredProcedure [dbo].[spUpsertJobCharges]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUpsertJobCharges]
	-- Add the parameters for the stored procedure here
	@DTZ59OPU decimal(18,9),
	@DTZ59AEI decimal(18,9),
	@adjustedNativeItemPrice decimal(18,9),
	@adjustedTotal decimal(18,9),
	@adjustedItemPrice decimal(18,9),
	@DTLINID int,
	@jobChargeId uniqueidentifier,
	@serviceDetailId int,
	@jobId uniqueidentifier,
	@Insert int,
	@Update int
AS
BEGIN
select top 1 '' as nothing from Job;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @Update = 1
	update jobcharges set adjustedItemQuantity=@DTZ59OPU
	,adjustedNativeTotal = @DTZ59AEI
	,adjustedNativeItemPrice = @adjustedNativeItemPrice
	,adjustedTotal = @adjustedTotal
	,adjustedItemPrice = @adjustedItemPrice
	,jdelinenumber=@DTLINID,
	sortorder=@DTLINID
	where jobchargeid = @jobChargeId
else if @Insert =1
    insert into jobcharges(serviceDetailID,adjustedItemQuantity,adjustedItemPrice,adjustedTotal,adjustedNativeItemPrice,adjustedNativeTotal,jobid,jdelinenumber,sortorder)
	values(@serviceDetailId,@DTZ59OPU,@adjustedItemPrice,@adjustedTotal,@adjustedNativeItemPrice,@DTZ59AEI,@jobId,@DTLINID,@DTLINID);
END

GO
/****** Object:  StoredProcedure [dbo].[tops_station_for_oneview]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[tops_station_for_oneview] 
	-- Add the parameters for the stored procedure here
	@ovdistrict_id int,
	@ovjob_type_id int,
	@topsDistrictID int = NULL
AS
BEGIN
	IF @topsDistrictID is null  OR @topsDistrictID = 0
	BEGIN
		select top 1 district_id,tops_id FROM (SELECT loc.district_id,loc.tops_id,TRANSLATE_TOPSDistrict.preference
		FROM Location loc left join Location_Attributes loca on loc.id=loca.location_id
                             left join Location_Attribute_Values locav on loca.value_id=locav.id and locav.[type]=1
                             left join TRANSLATE_TOPSDistrict on loc.tops_id=TRANSLATE_TOPSDistrict.topsDistrictID
		WHERE  loc.district_id= @ovdistrict_id and locav.id=  @ovjob_type_id
		union 
		SELECT loc.district_id,loc.tops_id,TRANSLATE_TOPSDistrict.preference
		FROM Location loc left join Location_Attributes loca on loc.id=loca.location_id
                             left join Location_Attribute_Values locav on loca.value_id=locav.id and locav.[type]=1
                             left join TRANSLATE_TOPSDistrict on loc.tops_id=TRANSLATE_TOPSDistrict.topsDistrictID
		WHERE  loc.district_id= @ovdistrict_id and locav.id is null) a
		order by (Case When preference Is Null Then 9999 Else preference End) 
	END
	ELSE
	BEGIN
		SELECT @ovdistrict_id as district_id,@topsDistrictID as tops_id
	END                 
END
GO
/****** Object:  StoredProcedure [dbo].[updtdusp_WPTSJobSelection]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create  procedure [dbo].[updtdusp_WPTSJobSelection]
  AS
        BEGIN
         UPDATE [dbo].[usp_WPTSJobSelection]
         SET personnelrating=27499
where jobid='E821EED4-370A-4532-891A-B306CD647D65'
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetNewBatchAnchor]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetNewBatchAnchor] (
	@sync_last_received_anchor timestamp, 
	@sync_batch_size bigint,
	@sync_max_received_anchor timestamp out,
	@sync_new_received_anchor timestamp out,            
	@sync_batch_count int output,
	@sync_table_name nvarchar(max))            
AS            
	declare @sql nvarchar(max) 
	declare @t_result table
    (
		timestampcol binary(8)
    )   
       -- Set a default batch size if a valid one is not passed in.
    IF  @sync_batch_size IS NULL OR @sync_batch_size <= 0
		SET @sync_batch_size = 1000    
	if @sync_batch_count is null
		set @sync_batch_count = 0
-- Before selecting the first batch of changes,
-- set the maximum anchor value for this synchronization session.
-- After the first time that this procedure is called, 
-- Synchronization Services passes a value for @sync_max_received_anchor
-- to the procedure. Batches of changes are synchronized until this 
-- value is reached.
--print 'Max Anchor' + master.sys.fn_varbintohexstr(@sync_max_received_anchor)   
   IF isnull(@sync_max_received_anchor,0) <= 0
   BEGIN       
     --SELECT  @sync_max_received_anchor = MIN_ACTIVE_ROWVERSION() - 1
     set @sql = 'select max(timestampcol) from (select max(inserted) as timestampcol from ' + @sync_table_name + ' union select max(updated) from ' + @sync_table_name + ') as foo'

	 insert into @t_result exec(@sql)
	 SELECT  @sync_max_received_anchor = max(timestampcol) from @t_result
   END
-- If this is the first synchronization session for a database,
-- get the lowest timestamp value from the tables. By default,
-- Synchronization Services uses a value of 0 for @sync_last_received_anchor
-- on the first synchronization. If you do not set @sync_last_received_anchor,
-- this can cause empty batches to be downloaded until the lowest
-- timestamp value is reached.
	IF isnull(@sync_last_received_anchor,0) <= 0
	BEGIN            
		delete from @t_result
		set @sql = 'select min(timestampcol) from (select min(inserted) as timestampcol from ' + @sync_table_name + ' union select min(updated) from ' + @sync_table_name + ') as foo'

		insert into @t_result exec(@sql)
	
		SELECT @sync_last_received_anchor = min(timestampcol) from @t_result--MIN(TimestampCol) FROM (exec(@sql))
	END
		
   IF @sync_last_received_anchor IS NOT NULL
   BEGIN	
--Determine @sync_new_received_anchor
	SET @sync_new_received_anchor = @sync_last_received_anchor + @sync_batch_size
	IF (@sync_new_received_anchor > @sync_max_received_anchor)
		SET @sync_new_received_anchor = @sync_max_received_anchor
	
   --print 'Sync Batch Count Before Processing: ' + cast(@sync_batch_count as nvarchar(max))
   if @sync_batch_count = 0
	SET @sync_batch_count = ((@sync_max_received_anchor / @sync_batch_size) - (@sync_new_received_anchor /  @sync_batch_size)) + 1
	
	declare @result_count int
	set @result_count = 0

	declare @t_count table
	(
		result bigint
	)
	--print 'New Anchor' + master.sys.fn_varbintohexstr(@sync_new_received_anchor)
	while @result_count = 0 and @sync_new_received_anchor <= @sync_max_received_anchor
	begin
		delete from @t_count
		set @sql = 'select count(*) from ' + @sync_table_name +	
  					' where (updated >= ' + master.sys.fn_varbintohexstr(@sync_new_received_anchor) +
					' and updated <= ' + master.sys.fn_varbintohexstr(@sync_new_received_anchor + @sync_batch_size) +
					')' +
					' or ' + 
					' (inserted >= ' + master.sys.fn_varbintohexstr(@sync_new_received_anchor) +
					' and inserted <= ' + master.sys.fn_varbintohexstr(@sync_new_received_anchor + @sync_batch_size) +
					')'
		insert into @t_count exec(@sql)
		set @result_count = (select min(result) from @t_count)
		if @result_count = 0
		begin
			set @sync_new_received_anchor = @sync_new_received_anchor + @sync_batch_size
			set @sync_batch_count = @sync_batch_count -1
			--print 'New Sync Anchor: ' + master.sys.fn_varbintohexstr(@sync_new_received_anchor)
		end
		--print 'SQL: ' + @sql				
		--print 'Result Count: ' + cast(@result_count as nvarchar)
		
		
	end
		
   --print 'Sync Batch Count: ' + cast(@sync_batch_count as nvarchar(max))
   --print 'Last Received' + master.sys.fn_varbintohexstr(@sync_last_received_anchor)
   --print 'Max Received' + master.sys.fn_varbintohexstr(@sync_max_received_anchor)
   --print 'New Anchor' + master.sys.fn_varbintohexstr(@sync_new_received_anchor)
   --print @sync_batch_size
   --print @sync_batch_count
   end
       
GO
/****** Object:  StoredProcedure [dbo].[usp_GetNewBatchAnchor_v2]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetNewBatchAnchor_v2] (
	@sync_last_received_anchor timestamp, 
	@sync_batch_size bigint,
	@sync_max_received_anchor timestamp out,
	@sync_new_received_anchor timestamp out,            
	@sync_batch_count int output,
	@sync_table_name nvarchar(max))            
AS            
	declare @sql nvarchar(max) 
	declare @t_result table
    (
		timestampcol binary(8)
    )   
       -- Set a default batch size if a valid one is not passed in.
    IF  @sync_batch_size IS NULL OR @sync_batch_size <= 0
		SET @sync_batch_size = 1000    
	if @sync_batch_count is null
		set @sync_batch_count = 0
-- Before selecting the first batch of changes,
-- set the maximum anchor value for this synchronization session.
-- After the first time that this procedure is called, 
-- Synchronization Services passes a value for @sync_max_received_anchor
-- to the procedure. Batches of changes are synchronized until this 
-- value is reached.
--print 'Max Anchor' + master.sys.fn_varbintohexstr(@sync_max_received_anchor)   
   IF @sync_max_received_anchor is null
   BEGIN       
     --SELECT  @sync_max_received_anchor = MIN_ACTIVE_ROWVERSION() - 1
     set @sql = 'select max(timestampcol) from (select max(inserted) as timestampcol from ' + @sync_table_name + ' union select max(updated) from ' + @sync_table_name + ') as foo'

	 insert into @t_result exec(@sql)
	 SELECT  @sync_max_received_anchor = max(timestampcol) from @t_result
	 if @sync_max_received_anchor is null
	 begin
		set @sync_max_received_anchor = MIN_ACTIVE_ROWVERSION()-1
	 end
   END
-- If this is the first synchronization session for a database,
-- get the lowest timestamp value from the tables. By default,
-- Synchronization Services uses a value of 0 for @sync_last_received_anchor
-- on the first synchronization. If you do not set @sync_last_received_anchor,
-- this can cause empty batches to be downloaded until the lowest
-- timestamp value is reached.
	--IF isnull(@sync_last_received_anchor,0) <= 0
	IF @sync_last_received_anchor is null or @sync_last_received_anchor <= 0x0
	BEGIN            
		delete from @t_result
		set @sql = 'select min(timestampcol) from (select min(inserted) as timestampcol from ' + @sync_table_name + ' union select min(updated) from ' + @sync_table_name + ') as foo'

		insert into @t_result exec(@sql)
	
		SELECT @sync_last_received_anchor = min(timestampcol) from @t_result--MIN(TimestampCol) FROM (exec(@sql))
		if @sync_last_received_anchor is null
		begin
			set @sync_last_received_anchor = 0x0
		end
	END
		
   IF @sync_last_received_anchor IS NOT NULL
   BEGIN	
--Determine @sync_new_received_anchor
	--SET @sync_new_received_anchor = @sync_last_received_anchor + @sync_batch_size
	--IF (@sync_new_received_anchor > @sync_max_received_anchor)
	--	SET @sync_new_received_anchor = @sync_max_received_anchor
	
	declare @new_anchor table
	(
		anchor binary(8)
	)
	--set @sync_new_received_anchor = select min(
	
	set @sql = 'select min(timestampcol) from (select min(inserted) as timestampcol from ' + @sync_table_name + ' where inserted > ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) + ' union select min(updated) from ' + @sync_table_name + ' where updated > ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) + ') as foo'

	insert into @new_anchor exec(@sql)
	declare @t_anchor binary(8)
	--set @sync_new_received_anchor = (select min(anchor) from @new_anchor) + @sync_batch_size
	--set @sync_last_received_anchor = @sync_new_received_anchor - @sync_batch_size - 1
	set @sync_last_received_anchor = (select min(anchor) from @new_anchor)-- - 1
	if @sync_last_received_anchor is null
	begin
		set @sync_last_received_anchor = @sync_max_received_anchor
	end
	set @sync_new_received_anchor = @sync_last_received_anchor + @sync_batch_size
	
   --print 'Sync Batch Count Before Processing: ' + cast(@sync_batch_count as nvarchar(max))
   if @sync_batch_count = 0
	SET @sync_batch_count = ((@sync_max_received_anchor / @sync_batch_size) - (@sync_new_received_anchor /  @sync_batch_size)) + 1
	
	if @sync_new_received_anchor >= @sync_max_received_anchor
	begin
		--IF @sync_batch_count <= 0
			set @sync_batch_count = 1
		
		set @sync_new_received_anchor = @sync_max_received_anchor
	end
	
   end
       

GO
/****** Object:  StoredProcedure [dbo].[usp_GetNewBatchAnchor_v3]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_GetNewBatchAnchor_v3] (
	@sync_last_received_anchor timestamp, 
	@sync_batch_size bigint,
	@sync_max_received_anchor timestamp out,
	@sync_new_received_anchor timestamp out,            
	@sync_batch_count int output,
	@sync_table_name nvarchar(max))            
AS            
	declare @sql nvarchar(max) 
	declare @t_result table
    (
		timestampcol binary(8)
    )   
       -- Set a default batch size if a valid one is not passed in.
    IF  @sync_batch_size IS NULL OR @sync_batch_size <= 0
		SET @sync_batch_size = 1000    
	if @sync_batch_count is null
		set @sync_batch_count = 0
-- Before selecting the first batch of changes,
-- set the maximum anchor value for this synchronization session.
-- After the first time that this procedure is called, 
-- Synchronization Services passes a value for @sync_max_received_anchor
-- to the procedure. Batches of changes are synchronized until this 
-- value is reached.
--print 'Max Anchor' + master.sys.fn_varbintohexstr(@sync_max_received_anchor)   
   IF @sync_max_received_anchor is null
   BEGIN       
     --SELECT  @sync_max_received_anchor = MIN_ACTIVE_ROWVERSION() - 1
     set @sql = 'select max(timestampcol) from (select max(inserted) as timestampcol from ' + @sync_table_name + ' union select max(updated) from ' + @sync_table_name + ') as foo'

	 insert into @t_result exec(@sql)
	 SELECT  @sync_max_received_anchor = max(timestampcol) from @t_result
	 if @sync_max_received_anchor is null
	 begin
		set @sync_max_received_anchor = MIN_ACTIVE_ROWVERSION()-1
	 end
   END
-- If this is the first synchronization session for a database,
-- get the lowest timestamp value from the tables. By default,
-- Synchronization Services uses a value of 0 for @sync_last_received_anchor
-- on the first synchronization. If you do not set @sync_last_received_anchor,
-- this can cause empty batches to be downloaded until the lowest
-- timestamp value is reached.
	--IF isnull(@sync_last_received_anchor,0) <= 0
	IF @sync_last_received_anchor is null or @sync_last_received_anchor <= 0
	BEGIN            
		delete from @t_result
		set @sql = 'select min(timestampcol) from (select min(inserted) as timestampcol from ' + @sync_table_name + ' union select min(updated) from ' + @sync_table_name + ') as foo'

		insert into @t_result exec(@sql)
	
		SELECT @sync_last_received_anchor = min(timestampcol) from @t_result--MIN(TimestampCol) FROM (exec(@sql))
		if @sync_last_received_anchor is null
		begin
			set @sync_last_received_anchor = 0x0
		end
	END
		
   IF @sync_last_received_anchor IS NOT NULL
   BEGIN	
--Determine @sync_new_received_anchor
	--SET @sync_new_received_anchor = @sync_last_received_anchor + @sync_batch_size
	--IF (@sync_new_received_anchor > @sync_max_received_anchor)
	--	SET @sync_new_received_anchor = @sync_max_received_anchor
	
	declare @new_anchor table
	(
		anchor binary(8)
	)
	--set @sync_new_received_anchor = select min(
	
	set @sql = 'select min(timestampcol) from (select min(inserted) as timestampcol from ' + @sync_table_name + ' where inserted > ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) + ' union select min(updated) from ' + @sync_table_name + ' where updated > ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) + ') as foo'

	insert into @new_anchor exec(@sql)
	declare @t_anchor binary(8)
	--set @sync_new_received_anchor = (select min(anchor) from @new_anchor) + @sync_batch_size
	--set @sync_last_received_anchor = @sync_new_received_anchor - @sync_batch_size - 1
	set @sync_last_received_anchor = (select min(anchor) from @new_anchor)-- - 1
	if @sync_last_received_anchor is null
	begin
		set @sync_last_received_anchor = @sync_max_received_anchor
	end
	set @sync_new_received_anchor = @sync_last_received_anchor + @sync_batch_size
	
   --print 'Sync Batch Count Before Processing: ' + cast(@sync_batch_count as nvarchar(max))
   if @sync_batch_count = 0
	SET @sync_batch_count = ((@sync_max_received_anchor / @sync_batch_size) - (@sync_new_received_anchor /  @sync_batch_size)) + 1
	
	if @sync_new_received_anchor >= @sync_max_received_anchor
	begin
		--IF @sync_batch_count <= 0
			set @sync_batch_count = 1
		
		set @sync_new_received_anchor = @sync_max_received_anchor
	end
	
   end
       

GO
/****** Object:  StoredProcedure [dbo].[usp_GetNewBatchAnchor_v5]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_GetNewBatchAnchor_v5] (
	@sync_last_received_anchor timestamp, 
	@sync_batch_size bigint,
	@sync_max_received_anchor timestamp out,
	@sync_new_received_anchor timestamp out,            
	@sync_batch_count int output,
	@sync_table_name nvarchar(max))            
AS            
	declare @sql nvarchar(max) 
	declare @t_result table
    (
		timestampcol binary(8)
    )   
       -- Set a default batch size if a valid one is not passed in.
    IF  @sync_batch_size IS NULL OR @sync_batch_size <= 0
		SET @sync_batch_size = 1000    
	if @sync_batch_count is null
		set @sync_batch_count = 0
-- Before selecting the first batch of changes,
-- set the maximum anchor value for this synchronization session.
-- After the first time that this procedure is called, 
-- Synchronization Services passes a value for @sync_max_received_anchor
-- to the procedure. Batches of changes are synchronized until this 
-- value is reached.
--print 'Max Anchor' + master.sys.fn_varbintohexstr(@sync_max_received_anchor)   
   IF @sync_max_received_anchor is null
   BEGIN       
     --SELECT  @sync_max_received_anchor = MIN_ACTIVE_ROWVERSION() - 1
     set @sql = 'select max(timestampcol) from (select max(inserted) as timestampcol from ' + @sync_table_name + ' union select max(updated) from ' + @sync_table_name + ') as foo'

	 insert into @t_result exec(@sql)
	 SELECT  @sync_max_received_anchor = max(timestampcol) from @t_result
	 if @sync_max_received_anchor is null
	 begin
		set @sync_max_received_anchor = MIN_ACTIVE_ROWVERSION()-1
		--set @sync_max_received_anchor = MIN_ACTIVE_ROWVERSION()
	 end
   END
-- If this is the first synchronization session for a database,
-- get the lowest timestamp value from the tables. By default,
-- Synchronization Services uses a value of 0 for @sync_last_received_anchor
-- on the first synchronization. If you do not set @sync_last_received_anchor,
-- this can cause empty batches to be downloaded until the lowest
-- timestamp value is reached.
	--IF isnull(@sync_last_received_anchor,0) <= 0
	IF @sync_last_received_anchor is null or @sync_last_received_anchor <= 0x0
	BEGIN            
		delete from @t_result
		set @sql = 'select min(timestampcol) from (select min(inserted) as timestampcol from ' + @sync_table_name + ' union select min(updated) from ' + @sync_table_name + ') as foo'

		insert into @t_result exec(@sql)
	
		SELECT @sync_last_received_anchor = min(timestampcol) from @t_result--MIN(TimestampCol) FROM (exec(@sql))
		if @sync_last_received_anchor is null
		begin
			set @sync_last_received_anchor = 0x0
		end
	END
		
   IF @sync_last_received_anchor IS NOT NULL
   BEGIN	
--Determine @sync_new_received_anchor
	--SET @sync_new_received_anchor = @sync_last_received_anchor + @sync_batch_size
	--IF (@sync_new_received_anchor > @sync_max_received_anchor)
	--	SET @sync_new_received_anchor = @sync_max_received_anchor
	
	declare @new_anchor table
	(
		anchor binary(8)
	)
	--set @sync_new_received_anchor = select min(
	
	--set @sql = 'select min(timestampcol) from (select top 100000 min(inserted) as timestampcol from ' + @sync_table_name + ' where inserted > ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) + ' order by inserted union select top 100000 min(updated) from ' + @sync_table_name + ' where updated > ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) + ' order by updated ) as foo'
	set @sql = 'select min(timestampcol) 
from 
(
	select max(inserted) as timestampcol 
	from 
	(
	select top ' + cast(@sync_batch_size as nvarchar(max)) + ' inserted
	from ' + @sync_table_name + ' 
	where inserted > ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) +
	' order by inserted	
	) as ins
	union 
	select max(updated) 
	from 
	(
	select top ' + cast(@sync_batch_size as nvarchar(max)) + ' updated
	from ' + @sync_table_name + ' 
	where updated > ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) +
	--' and inserted <= ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor) + 
	' order by updated
	) as upd
) as foo'
	--print @sql
	insert into @new_anchor exec(@sql)
	declare @t_anchor binary(8)
	--set @sync_new_received_anchor = (select min(anchor) from @new_anchor) + @sync_batch_size
	--set @sync_last_received_anchor = @sync_new_received_anchor - @sync_batch_size - 1
	set @sync_last_received_anchor = (select min(anchor) from @new_anchor)-- - 1
	if @sync_last_received_anchor is null
	begin
		set @sync_last_received_anchor = @sync_max_received_anchor
	end
	set @sync_new_received_anchor = @sync_last_received_anchor-- + @sync_batch_size
	
   --print 'Sync Batch Count Before Processing: ' + cast(@sync_batch_count as nvarchar(max))
   if @sync_batch_count = 0
	SET @sync_batch_count = ((@sync_max_received_anchor / @sync_batch_size) - (@sync_new_received_anchor /  @sync_batch_size)) + 1
	
	if @sync_new_received_anchor >= @sync_max_received_anchor
	begin
		--IF @sync_batch_count <= 0
			set @sync_batch_count = 1
		
		set @sync_new_received_anchor = @sync_max_received_anchor
	end
	
   end
       

	  -- select count(*) from well where inserted > @sync_last_received_anchor                    
   --                 and inserted <= @sync_new_received_anchor
		 --select count(*) from well where ((updated > @sync_last_received_anchor
   --                         and updated <= @sync_new_received_anchor
   --                         )
   --                         or (updated > @sync_last_received_anchor
   --                         and updated <= @sync_new_received_anchor
   --                         ))
   --                         and not (inserted > @sync_last_received_anchor
   --                         )
                    
   
   --print 'Sync Batch Count: ' + cast(@sync_batch_count as nvarchar(max))
   --print 'Last Received ' + master.sys.fn_varbintohexstr(@sync_last_received_anchor)
   --print 'Max Received ' + master.sys.fn_varbintohexstr(@sync_max_received_anchor)
   --print 'New Anchor ' + master.sys.fn_varbintohexstr(@sync_new_received_anchor)
   --print @sync_batch_size
   --print @sync_batch_count
       


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateJobWithHistoricalWPTSID]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Don Hayward
-- Create date: 2014-04-10
-- Description:	Stored Procedure to update wptsID in Job Table form historical data
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateJobWithHistoricalWPTSID] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @updated binary(8)
	declare @maxlastUpdated binary(8)
	declare @wptsposted datetime
	declare @jobId uniqueidentifier
	declare @wptsid int

	declare pastJob_cursor CURSOR STATIC FOR
	   select distinct top 100 wpts.jobid,wpts.wptsid, wpts.maxlastupdated ,wpts.wptsposted from wpts_lastJobPosting wpts inner join job on wpts.jobid=job.jobid where (job.wptsid is null or job.wptsid != wpts.wptsid) and wpts.wptsid is not null order by wpts.maxlastupdated,wpts.wptsposted desc;

	OPEN pastJob_cursor
	FETCH NEXT FROM pastJob_cursor into @jobId, @wptsid, @maxlastUpdated,@wptsposted
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    IF (@wptsid is not null)
		BEGIN
		    BEGIN TRY
				BEGIN TRANSACTION
					update job set wptsid=@wptsid where jobid=@jobid and (wptsid is null or wptsid != @wptsid)
					select @updated=updated from job where jobid=@jobid
					update wpts_jobPostings set maxlastupdated = @updated where jobid=@jobid and maxlastupdated=@maxlastupdated and wptsid=@wptsid
					print @jobid
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				-- Whoops, there was an error
				IF @@TRANCOUNT > 0
					ROLLBACK

				-- Raise an error with the details of the exception
				DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
				SELECT	@ErrMsg = ERROR_MESSAGE(),
						@ErrSeverity = ERROR_SEVERITY()

				RAISERROR(@ErrMsg, @ErrSeverity, 1)
			END CATCH
		END
	FETCH NEXT FROM pastJob_cursor into @jobId, @wptsid, @maxlastUpdated, @wptsposted
	END
	CLOSE pastJob_cursor;
	DEALLOCATE pastJob_cursor;

END

GO
/****** Object:  StoredProcedure [dbo].[usp_WPTSJobSelection]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_WPTSJobSelection]
as 
select top 1000 j.jobid,
	COALESCE(nullif(financialSystemID,''),(   CASE when (j.serviceorder is null ) then '0' else ltrim(rtrim(j.serviceorder)) end+ '-' +
            CASE when (j.financialsystemid is null ) then '0' else ltrim(rtrim(j.financialsystemid)) end + '-' +
            CASE when (j.quotenumber is null ) then '0' else ltrim(rtrim(j.quotenumber)) end )) as JobNumber,
	cast(ltrim(rtrim(convert(nvarchar(25),j.actualStartDateTime,120))) as datetime) as jobStartDate, 
                cast(ltrim(rtrim(convert(nvarchar(25),j.endDateTime,120))) as datetime) as JobEndDate,
	ltrim(rtrim(c.name)) as Customer
	,substring(w.name + ' ('+w.location+')',0,75) as wellNameAndLocation,
	'n/a' DrillingContractor,
	case when (jw.rigname is null) then 'N/A' when (jw.rigname != '') then 'N/A' else substring(jw.rigname,0,50) end as Rig,
	'30' as ProductLine,
	'91' as WellClassification,
	case when jw.welllocationtypeid=1 then '2444' when jw.welllocationtypeid=2 then '2446' else '2448' end as WellLocation,
	case when jw.totaldepth is null then 0 else dbo.metersToFt(jw.totaldepth) end  as WellDepth,
	case when jw.rigtypeid is not null then ltrim(rtrim(cast(rigtype.wpts_rigtypeid as nvarchar(10)))) else '76' end as RigType,
	case when jw.hash2s=1 then 'True' else 'False' end as H2SPresent,
	case when jw.hasco2=1 then 'True' else 'False' end as CO2Present
	,case jcc.personnelrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as personnelrating,
    case jcc.equipmentrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as equipmentrating,
    case jcc.communicationrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as communicationrating,
	case jcc.hsserating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as hsserating,
	case jcc.overallrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as overallrating,
	cast(jcc.companycomments as nvarchar(max)) companycomments,
	case jcc.declinedsurvey WHEN 1 THEN 'True' ELSE 'False' END as declinedsurvey,
	'http://oneview/Jobs/Job/Details/'+ltrim(rtrim(lower(j.jobid))) url,
	j.operatingDistrictID,
	j.JobTypeID,
	j.topsDistrictID,
	wkh.operating_time,
	wkh.lost_time,
	wkh.total_time,
	j.updated as jobupdated,
	jw.updated as jobwellsupdated,
	c.updated as companyupdated,
	jcc.updated as jobcustomercountsupdated,
	wkh.updated as operatingtimeupdated,
	wkh.updated as losttimeupdated,
	wkh.updated as totaltimeupdated
	,maxupdated.updated as maxLastUpdated
	,coalesce(case when wjp2.wptsid=0 then null else wjp2.wptsid end ,j.wptsid) as wptsid,
	j.actualStartDateTime
	--,ltrim(rtrim(cast(hr.id as nvarchar(10)))) as WPTSRegion,
	--ltrim(rtrim(cast(hsr.subregionid as nvarchar(10))))  as WPTSSubRegion,
	--ltrim(rtrim(cast(hc.countryid as nvarchar(10))))  as WPTSCountry,
	,null as WPTSRegion,
	null as WPTSSubRegion,
	null as WPTSCountry,
	
	coalesce(
			(select top 1 locationid 
			from [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations hl
			join
			--where propertyid =
			(select top 1 mpl.LEASE_NUM 
			from [USDCWPTSSQLPD01].DISJobHistory.mdm.MDMPhysicalLocation mpl 
			where ol.attrval = mpl.BRANCH_PLANT_NUMBER COLLATE Latin1_General_CI_AI
			order by branch_plant_number, PRIMARY_USE_FLG desc, ACTV_FLG desc
			) tmpdata on hl.PropertyID = tmpdata.LEASE_NUM			 
			)
			,(select top 1 WFTLocationId from [USDCWPTSSQLPD01].[jdejobs].[dbo].BranchPlantWFTLocation where ol.attrVal = BranchPlantId)
		) as WPTSLocation 
		--,wjp.maxLastUpdated
--,j.jobID,j.scheduledStartDateTime,j.serviceOrder,j.financialSystemID, wjp.maxLastUpdated as associatedRecordMaxLastUpdated
from job j
join OperationalLocation ol WITH (NOLOCK) on j.operationalLocationID = ol.gwis_locationid and lvl=5         
JOIN
(
	select jobid, max(updated) as updated
	from
	(
		select jobid,updated from job
		union
		select jobid,c.updated from Company c
		join job j on c.oneViewCompanyID = j.oneViewCompanyID
		UNION
		select jobid,updated from JobCustomerCounts jc
		UNION
		select jobid,updated from JobWells
		union 
		select jobid,updated from WPTS_KPI_Hours		
	)updateddata
	group by updateddata.jobID
) maxupdated on j.jobID = maxupdated.jobID
join WPTS_KPI_Hours wkh on wkh.JobID = j.jobID
left JOIN
(
	select jobid, max(maxLastUpdated) as maxLastUpdated
	from WPTS_JobPostings wj
	group by wj.jobID
) wjp on wjp.jobID = j.jobID
left join WPTS_JobPostings wjp2 on wjp.jobID = wjp2.jobID and wjp.maxLastUpdated = wjp2.maxLastUpdated
left join company c on j.oneViewCompanyID = c.oneViewCompanyID
join jobwells jw on j.jobID = jw.jobID
JOIN
(
SELECT [jobID]      
      ,max([updated]) as updated      
	  ,max(case when isPrimary is null then -1 else isPrimary end) as maxIsPrimary
  FROM [oneviewtest].[dbo].[JobWells] jw
  where (jw.deleted is null or jw.deleted =0)
  group by [jobID]
) pw on jw.jobID=pw.jobID and jw.updated = pw.updated
join Well w on jw.oneViewWellID = w.wellID
left join Translate_rigtype rigtype WITH (NOLOCK)on (jw.rigtypeid=rigtype.oneview_rigtypeid )
left join JobCustomerCounts jcc on jcc.jobID = j.jobID
--join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations wl on wl.locationid = coalesce(
--			(select top 1 locationid 
--			from [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations hl
--			join
--			--where propertyid =
--			(select top 1 mpl.LEASE_NUM 
--			from [USDCWPTSSQLPD01].DISJobHistory.mdm.MDMPhysicalLocation mpl 
--			where ol.attrval = mpl.BRANCH_PLANT_NUMBER COLLATE Latin1_General_CI_AI
--			order by branch_plant_number, PRIMARY_USE_FLG desc, ACTV_FLG desc
--			) tmpdata on hl.PropertyID = tmpdata.LEASE_NUM			 
--			)
--			,(select top 1 WFTLocationId from [USDCWPTSSQLPD01].[jdejobs].[dbo].BranchPlantWFTLocation where ol.attrVal = BranchPlantId)
--		)
--left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrregions hr on hr.id = wl.regionid
--		left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrsubregions hsr on hsr.subregionid = wl.subregionid
--		left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrcountries hc on hc.countryid = wl.wptscountryid
where (j.deleted is null or j.deleted = 0) and j.actualStartDateTime >= '2023-01-01 00:00:00' and  
j.jobstatusid in (5,9,10,11,12,13,1,16) AND (wkh.operating_time > 0 )
and (wjp.maxLastUpdated is null or maxupdated.updated> wjp.maxLastUpdated-- or j.updated > wjp.maxLastUpdated
)


order by  j.actualStartDateTime
GO
/****** Object:  StoredProcedure [dbo].[usp_WPTSJobSelection_6_20_2018]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_WPTSJobSelection_6_20_2018]
as 
select distinct top 1000 job.jobid,
	COALESCE(nullif(financialSystemID,''),(   CASE when (job.serviceorder is null ) then '0' else ltrim(rtrim(job.serviceorder)) end+ '-' +
            CASE when (job.financialsystemid is null ) then '0' else ltrim(rtrim(job.financialsystemid)) end + '-' +
            CASE when (job.quotenumber is null ) then '0' else ltrim(rtrim(job.quotenumber)) end )) as JobNumber,
	cast(ltrim(rtrim(convert(nvarchar(25),job.actualStartDateTime,120))) as datetime) as jobStartDate, 
                cast(ltrim(rtrim(convert(nvarchar(25),job.endDateTime,120))) as datetime) as JobEndDate,
	ltrim(rtrim(company.name)) as Customer,
	substring(Well.name + ' ('+well.location+')',0,75) as wellNameAndLocation,
	'n/a' DrillingContractor,
	case when (jobwells.rigname is null) then 'N/A' when (jobwells.rigname != '') then 'N/A' else substring(jobwells.rigname,0,50) end as Rig,
	'30' as ProductLine,
	'91' as WellClassification,
	case when jobwells.welllocationtypeid=1 then '2444' when jobwells.welllocationtypeid=2 then '2446' else '2448' end as WellLocation,
	case when jobwells.totaldepth is null then 0 else dbo.metersToFt(jobwells.totaldepth) end  as WellDepth,
	case when jobwells.rigtypeid is not null then ltrim(rtrim(cast(rigtype.wpts_rigtypeid as nvarchar(10)))) else '76' end as RigType,
	case when jobwells.hash2s=1 then 'True' else 'False' end as H2SPresent,
	case when jobwells.hasco2=1 then 'True' else 'False' end as CO2Present,
	case jobcustomercounts.personnelrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as personnelrating,
                case jobcustomercounts.equipmentrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as equipmentrating,
                case jobcustomercounts.communicationrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as communicationrating,
	case jobcustomercounts.hsserating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as hsserating,
	case jobcustomercounts.overallrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as overallrating,
	cast(jobcustomercounts.companycomments as nvarchar(max)) companycomments,
	case jobcustomercounts.declinedsurvey WHEN 1 THEN 'True' ELSE 'False' END as declinedsurvey,
	'http://oneview/Jobs/Job/Details/'+ltrim(rtrim(lower(job.jobid))) url,
	job.operatingDistrictID,
	job.JobTypeID,
	job.topsDistrictID,
	kpihours.operating_time,
	kpihours.lost_time,
	kpihours.total_time,
	job.updated as jobupdated,
	jobwells.updated as jobwellsupdated,
	company.updated as companyupdated,
	jobcustomercounts.updated as jobcustomercountsupdated,
	kpihours.updated as operatingtimeupdated,
	kpihours.updated as losttimeupdated,
	kpihours.updated as totaltimeupdated,
	case  WHEN ((job.updated > jobwells.updated) and (job.updated > company.updated) and (job.updated > ( case WHEN jobcustomercounts.updated is null then 0x000000000000 else jobcustomercounts.updated end )) and (job.updated > ( case WHEN kpihours.updated is null	then 0x000000000000 else kpihours.updated end )) and (job.updated > ( case WHEN kpihours.updated is null	then 0x000000000000 else kpihours.updated end ) )) THEN job.updated
	      WHEN ((jobwells.updated >	company.updated) and (jobwells.updated > ( case WHEN jobcustomercounts.updated is null then 0x000000000000 else jobcustomercounts.updated end )) and (jobwells.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) and (jobwells.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) ) THEN jobwells.updated
		  WHEN ((company.updated > ( case WHEN jobcustomercounts.updated is null then 0x000000000000 else jobcustomercounts.updated end)) and (company.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) and (company.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) ) THEN company.updated
		  WHEN ((jobcustomercounts.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) and (jobcustomercounts.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) ) THEN jobcustomercounts.updated
		 ELSE kpihours.updated 
	end as maxlastupdated,
                --job.wptsid,
				coalesce(case when WPTS_lastJobPosting.wptsid=0 then null else WPTS_lastJobPosting.wptsid end ,job.wptsid) as wptsid,
				job.actualStartDateTime ,
				ltrim(rtrim(cast(hr.id as nvarchar(10)))) as WPTSRegion,
	ltrim(rtrim(cast(hsr.subregionid as nvarchar(10))))  as WPTSSubRegion,
	ltrim(rtrim(cast(hc.countryid as nvarchar(10))))  as WPTSCountry,
	--ltrim(rtrim(cast(wpts_locations.id as nvarchar(10))))  as WPTSLocation
	coalesce(
			(select top 1 locationid 
			from [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations hl
			join
			--where propertyid =
			(select top 1 mpl.LEASE_NUM 
			from [USDCWPTSSQLPD01].DISJobHistory.mdm.MDMPhysicalLocation mpl 
			where ol.attrval = mpl.BRANCH_PLANT_NUMBER COLLATE Latin1_General_CI_AI
			order by branch_plant_number, PRIMARY_USE_FLG desc, ACTV_FLG desc
			) tmpdata on hl.PropertyID = tmpdata.LEASE_NUM			 
			)
			,(select top 1 WFTLocationId from [USDCWPTSSQLPD01].[jdejobs].[dbo].BranchPlantWFTLocation where ol.attrVal = BranchPlantId)
		) as WPTSLocation
   from job WITH (NOLOCK) 
   inner join jobwells WITH (NOLOCK) on (job.jobid=jobwells.jobid and (jobwells.deleted is null or jobwells.deleted = 0)) 
            inner join (
					select jobwellid from jobwells  inner join
								(select jobid from jobwells where isPrimary=1 and (deleted is null or deleted = 0) group by jobid having count(jobwellid)=1 ) a on jobwells.jobid=a.jobid
					 where  jobwells.isPrimary=1 and (jobwells.deleted is null or jobwells.deleted = 0)
					union 
					select jobwellid from jobwells inner join 
								(select jobid from jobwells where isPrimary is null and (deleted is null or deleted = 0)  and jobid not in (select jobid from jobwells where isPrimary=1 and (deleted is null or deleted = 0) ) group by jobid having count(jobwellid)=1 ) b on jobwells.jobid=b.jobid
					 where  jobwells.isPrimary is null and (jobwells.deleted is null or jobwells.deleted = 0)
			) as limitjobwells on (jobwells.jobwellid=limitjobwells.jobwellid)		     
            inner join well WITH (NOLOCK) on (jobwells.oneviewwellid=well.wellid )
            inner join company WITH (NOLOCK) on (job.oneviewcompanyid = company.oneviewcompanyid )
			join OperationalLocation ol WITH (NOLOCK) on job.operationalLocationID = ol.gwis_locationid and lvl=5         
			--inner join gwis_locationattributes bu on (job.revenueCenterID = bu.gwis_locationid and bu.gwis_locationrelationtypeid=1 )
			--inner join gwis_locationattributevalue on ( bu.gwis_locationattributevalueid=gwis_locationattributevalue.gwis_locationattributevalueid and gwis_locationattributevalue.category='ProductLine')
			--inner join gwis_locationattributematrix wptsLocationID on (bu.gwis_locationattributeid=wptsLocationID.gwis_locationattributeid and wptsLocationID.gwis_locationattributevalueid=35)
			 --inner join wpts_locations wpts_locations on cast(wptsLocationID.value as integer)=wpts_locations.id
			 join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations wl on wl.locationid = coalesce(
			(select top 1 locationid 
			from [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations hl
			join
			--where propertyid =
			(select top 1 mpl.LEASE_NUM 
			from [USDCWPTSSQLPD01].DISJobHistory.mdm.MDMPhysicalLocation mpl 
			where ol.attrval = mpl.BRANCH_PLANT_NUMBER COLLATE Latin1_General_CI_AI
			order by branch_plant_number, PRIMARY_USE_FLG desc, ACTV_FLG desc
			) tmpdata on hl.PropertyID = tmpdata.LEASE_NUM			 
			)
			,(select top 1 WFTLocationId from [USDCWPTSSQLPD01].[jdejobs].[dbo].BranchPlantWFTLocation where ol.attrVal = BranchPlantId)
		)
		left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrregions hr on hr.id = wl.regionid
		left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrsubregions hsr on hsr.subregionid = wl.subregionid
		left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrcountries hc on hc.countryid = wl.wptscountryid

				--left join wpts_regions wpts_regions on wpts_locations.wpts_regionid=wpts_regions.id
				--left join wpts_subregions wpts_subregions on wpts_locations.wpts_subregionid=wpts_subregions.id
				--left join wpts_countries wpts_countries on wpts_locations.wpts_countryid=wpts_countries.id
				--left join wpts_areas wpts_areas on wpts_locations.wpts_areaid=wpts_areas.id
				--left join wpts_stateprov wpts_stateprov on wpts_locations.wpts_stateprovid=wpts_stateprov.id
			 left join jobcustomercounts WITH (NOLOCK) on (job.jobid=jobcustomercounts.jobid )
             left join Translate_rigtype rigtype WITH (NOLOCK)on (jobwells.rigtypeid=rigtype.oneview_rigtypeid )
			 left join WPTS_KPI_Hours kpihours WITH (NOLOCK)on job.jobid=kpihours.jobid
			 left join WPTS_lastJobPosting WITH (NOLOCK)on job.jobid=WPTS_lastJobPosting.jobid  
			 

WHERE  (job.deleted is null or job.deleted != 1) and       job.jobstatusid in (5,9,10,11,12,13,1,16) AND (kpihours.operating_time is not null and kpihours.operating_time > 0 )
	  and (    job.updated > WPTS_lastJobPosting.maxlastupdated
	        OR jobwells.updated > WPTS_lastJobPosting.maxlastupdated
			OR company.updated > WPTS_lastJobPosting.maxlastupdated
			OR jobcustomercounts.updated > WPTS_lastJobPosting.maxlastupdated
			OR kpihours.updated > WPTS_lastJobPosting.maxlastupdated
			OR WPTS_lastJobPosting.maxlastupdated is NULL)
and job.actualStartDateTime >= '2014-01-01 00:00:00'
order by  job.actualStartDateTime
--select distinct top 1000 job.jobid,
--	COALESCE(nullif(financialSystemID,''),(   CASE when (job.serviceorder is null ) then '0' else ltrim(rtrim(job.serviceorder)) end+ '-' +
--            CASE when (job.financialsystemid is null ) then '0' else ltrim(rtrim(job.financialsystemid)) end + '-' +
--            CASE when (job.quotenumber is null ) then '0' else ltrim(rtrim(job.quotenumber)) end )) as JobNumber,
--	cast(ltrim(rtrim(convert(nvarchar(25),job.actualStartDateTime,120))) as datetime) as jobStartDate, 
--                cast(ltrim(rtrim(convert(nvarchar(25),job.endDateTime,120))) as datetime) as JobEndDate,
--	ltrim(rtrim(company.name)) as Customer,
--	substring(Well.name + ' ('+well.location+')',0,75) as wellNameAndLocation,
--	'n/a' DrillingContractor,
--	case when (jobwells.rigname is null) then 'N/A' when (jobwells.rigname != '') then 'N/A' else substring(jobwells.rigname,0,50) end as Rig,
--	'30' as ProductLine,
--	'91' as WellClassification,
--	case when jobwells.welllocationtypeid=1 then '2444' when jobwells.welllocationtypeid=2 then '2446' else '2448' end as WellLocation,
--	case when jobwells.totaldepth is null then 0 else dbo.metersToFt(jobwells.totaldepth) end  as WellDepth,
--	case when jobwells.rigtypeid is not null then ltrim(rtrim(cast(rigtype.wpts_rigtypeid as nvarchar(10)))) else '76' end as RigType,
--	case when jobwells.hash2s=1 then 'True' else 'False' end as H2SPresent,
--	case when jobwells.hasco2=1 then 'True' else 'False' end as CO2Present,
--	case jobcustomercounts.personnelrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as personnelrating,
--                case jobcustomercounts.equipmentrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as equipmentrating,
--                case jobcustomercounts.communicationrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as communicationrating,
--	case jobcustomercounts.hsserating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as hsserating,
--	case jobcustomercounts.overallrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as overallrating,
--	cast(jobcustomercounts.companycomments as nvarchar(max)) companycomments,
--	case jobcustomercounts.declinedsurvey WHEN 1 THEN 'True' ELSE 'False' END as declinedsurvey,
--	'http://oneview/Jobs/Job/Details/'+ltrim(rtrim(lower(job.jobid))) url,
--	job.operatingDistrictID,
--	job.JobTypeID,
--	job.topsDistrictID,
--	kpihours.operating_time,
--	kpihours.lost_time,
--	kpihours.total_time,
--	job.updated as jobupdated,
--	jobwells.updated as jobwellsupdated,
--	company.updated as companyupdated,
--	jobcustomercounts.updated as jobcustomercountsupdated,
--	kpihours.updated as operatingtimeupdated,
--	kpihours.updated as losttimeupdated,
--	kpihours.updated as totaltimeupdated,
--	case  WHEN ((job.updated > jobwells.updated) and (job.updated > company.updated) and (job.updated > ( case WHEN jobcustomercounts.updated is null then 0x000000000000 else jobcustomercounts.updated end )) and (job.updated > ( case WHEN kpihours.updated is null	then 0x000000000000 else kpihours.updated end )) and (job.updated > ( case WHEN kpihours.updated is null	then 0x000000000000 else kpihours.updated end ) )) THEN job.updated
--	      WHEN ((jobwells.updated >	company.updated) and (jobwells.updated > ( case WHEN jobcustomercounts.updated is null then 0x000000000000 else jobcustomercounts.updated end )) and (jobwells.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) and (jobwells.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) ) THEN jobwells.updated
--		  WHEN ((company.updated > ( case WHEN jobcustomercounts.updated is null then 0x000000000000 else jobcustomercounts.updated end)) and (company.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) and (company.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) ) THEN company.updated
--		  WHEN ((jobcustomercounts.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) and (jobcustomercounts.updated > (case WHEN kpihours.updated is null then 0x000000000000 else kpihours.updated end)) ) THEN jobcustomercounts.updated
--		 ELSE kpihours.updated 
--	end as maxlastupdated,
--                --job.wptsid,
--				coalesce(case when WPTS_lastJobPosting.wptsid=0 then null else WPTS_lastJobPosting.wptsid end ,job.wptsid) as wptsid,
--				job.actualStartDateTime ,
--				ltrim(rtrim(cast(wpts_regions.id as nvarchar(10)))) as WPTSRegion,
--	ltrim(rtrim(cast(wpts_subregions.id as nvarchar(10))))  as WPTSSubRegion,
--	ltrim(rtrim(cast(wpts_countries.id as nvarchar(10))))  as WPTSCountry,
--	ltrim(rtrim(cast(wpts_locations.id as nvarchar(10))))  as WPTSLocation
--   from job inner join jobwells on (job.jobid=jobwells.jobid and (jobwells.deleted is null or jobwells.deleted != 1)) 
--            inner join (
--					select jobwellid from jobwells  inner join
--								(select jobid from jobwells where isPrimary=1 and (deleted is null or deleted = 0) group by jobid having count(jobwellid)=1 ) a on jobwells.jobid=a.jobid
--					 where  jobwells.isPrimary=1 and (jobwells.deleted is null or jobwells.deleted = 0)
--					union 
--					select jobwellid from jobwells inner join 
--								(select jobid from jobwells where isPrimary is null and (deleted is null or deleted = 0)  and jobid not in (select jobid from jobwells where isPrimary=1 and (deleted is null or deleted = 0) ) group by jobid having count(jobwellid)=1 ) b on jobwells.jobid=b.jobid
--					 where  jobwells.isPrimary is null and (jobwells.deleted is null or jobwells.deleted = 0)
--			) as limitjobwells on (jobwells.jobwellid=limitjobwells.jobwellid)		     
--            inner join well on (jobwells.oneviewwellid=well.wellid )
--            inner join company on (job.oneviewcompanyid = company.oneviewcompanyid )
--			inner join gwis_locationattributes bu on (job.revenueCenterID = bu.gwis_locationid and bu.gwis_locationrelationtypeid=1 )
--			inner join gwis_locationattributevalue on ( bu.gwis_locationattributevalueid=gwis_locationattributevalue.gwis_locationattributevalueid and gwis_locationattributevalue.category='ProductLine')
--			inner join gwis_locationattributematrix wptsLocationID on (bu.gwis_locationattributeid=wptsLocationID.gwis_locationattributeid and wptsLocationID.gwis_locationattributevalueid=35)
--			 inner join wpts_locations wpts_locations on cast(wptsLocationID.value as integer)=wpts_locations.id
--				left join wpts_regions wpts_regions on wpts_locations.wpts_regionid=wpts_regions.id
--				left join wpts_subregions wpts_subregions on wpts_locations.wpts_subregionid=wpts_subregions.id
--				left join wpts_countries wpts_countries on wpts_locations.wpts_countryid=wpts_countries.id
--				left join wpts_areas wpts_areas on wpts_locations.wpts_areaid=wpts_areas.id
--				left join wpts_stateprov wpts_stateprov on wpts_locations.wpts_stateprovid=wpts_stateprov.id
--			 left join jobcustomercounts on (job.jobid=jobcustomercounts.jobid )
--             left join Translate_rigtype rigtype on (jobwells.rigtypeid=rigtype.oneview_rigtypeid )
--			 left join WPTS_KPI_Hours kpihours on job.jobid=kpihours.jobid
--			 left join WPTS_lastJobPosting on job.jobid=WPTS_lastJobPosting.jobid           

--WHERE  (job.deleted is null or job.deleted != 1) and       job.jobstatusid in (5,9,10,11,12,13,1,16) AND (kpihours.operating_time is not null and kpihours.operating_time > 0 )
--	  and (    job.updated > WPTS_lastJobPosting.maxlastupdated
--	        OR jobwells.updated > WPTS_lastJobPosting.maxlastupdated
--			OR company.updated > WPTS_lastJobPosting.maxlastupdated
--			OR jobcustomercounts.updated > WPTS_lastJobPosting.maxlastupdated
--			OR kpihours.updated > WPTS_lastJobPosting.maxlastupdated
--			OR WPTS_lastJobPosting.maxlastupdated is NULL)
--and job.actualStartDateTime >= '2014-01-01 00:00:00'
--order by  job.actualStartDateTime


GO
/****** Object:  StoredProcedure [dbo].[usp_WPTSJobSelectionManually]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[usp_WPTSJobSelection]    Script Date: 8/25/2021 8:48:21 AM ******/


create PROCEDURE [dbo].[usp_WPTSJobSelectionManually]
@jobId uniqueidentifier
as 
select top 1000 j.jobid,
	COALESCE(nullif(financialSystemID,''),(   CASE when (j.serviceorder is null ) then '0' else ltrim(rtrim(j.serviceorder)) end+ '-' +
            CASE when (j.financialsystemid is null ) then '0' else ltrim(rtrim(j.financialsystemid)) end + '-' +
            CASE when (j.quotenumber is null ) then '0' else ltrim(rtrim(j.quotenumber)) end )) as JobNumber,
	cast(ltrim(rtrim(convert(nvarchar(25),j.actualStartDateTime,120))) as datetime) as jobStartDate, 
                cast(ltrim(rtrim(convert(nvarchar(25),j.endDateTime,120))) as datetime) as JobEndDate,
	ltrim(rtrim(c.name)) as Customer
	,substring(w.name + ' ('+w.location+')',0,75) as wellNameAndLocation,
	'n/a' DrillingContractor,
	case when (jw.rigname is null) then 'N/A' when (jw.rigname != '') then 'N/A' else substring(jw.rigname,0,50) end as Rig,
	'30' as ProductLine,
	'91' as WellClassification,
	case when jw.welllocationtypeid=1 then '2444' when jw.welllocationtypeid=2 then '2446' else '2448' end as WellLocation,
	case when jw.totaldepth is null then 0 else dbo.metersToFt(jw.totaldepth) end  as WellDepth,
	case when jw.rigtypeid is not null then ltrim(rtrim(cast(rigtype.wpts_rigtypeid as nvarchar(10)))) else '76' end as RigType,
	case when jw.hash2s=1 then 'True' else 'False' end as H2SPresent,
	case when jw.hasco2=1 then 'True' else 'False' end as CO2Present
	,case jcc.personnelrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as personnelrating,
    case jcc.equipmentrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as equipmentrating,
    case jcc.communicationrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as communicationrating,
	case jcc.hsserating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as hsserating,
	case jcc.overallrating WHEN 1 THEN '27494' WHEN 2 THEN '27495' WHEN 3 THEN  '27496' WHEN 4 THEN  '27497' WHEN 5 THEN '27498' WHEN 6 THEN '27499' END as overallrating,
	cast(jcc.companycomments as nvarchar(max)) companycomments,
	case jcc.declinedsurvey WHEN 1 THEN 'True' ELSE 'False' END as declinedsurvey,
	'http://oneview/Jobs/Job/Details/'+ltrim(rtrim(lower(j.jobid))) url,
	j.operatingDistrictID,
	j.JobTypeID,
	j.topsDistrictID,
	wkh.operating_time,
	wkh.lost_time,
	wkh.total_time,
	j.updated as jobupdated,
	jw.updated as jobwellsupdated,
	c.updated as companyupdated,
	jcc.updated as jobcustomercountsupdated,
	wkh.updated as operatingtimeupdated,
	wkh.updated as losttimeupdated,
	wkh.updated as totaltimeupdated
	,maxupdated.updated as maxLastUpdated
	,coalesce(case when wjp2.wptsid=0 then null else wjp2.wptsid end ,j.wptsid) as wptsid,
	j.actualStartDateTime
	--,ltrim(rtrim(cast(hr.id as nvarchar(10)))) as WPTSRegion,
	--ltrim(rtrim(cast(hsr.subregionid as nvarchar(10))))  as WPTSSubRegion,
	--ltrim(rtrim(cast(hc.countryid as nvarchar(10))))  as WPTSCountry,
	,null as WPTSRegion,
	null as WPTSSubRegion,
	null as WPTSCountry,
	
	coalesce(
			(select top 1 locationid 
			from [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations hl
			join
			--where propertyid =
			(select top 1 mpl.LEASE_NUM 
			from [USDCWPTSSQLPD01].DISJobHistory.mdm.MDMPhysicalLocation mpl 
			where ol.attrval = mpl.BRANCH_PLANT_NUMBER COLLATE Latin1_General_CI_AI
			order by branch_plant_number, PRIMARY_USE_FLG desc, ACTV_FLG desc
			) tmpdata on hl.PropertyID = tmpdata.LEASE_NUM			 
			)
			,(select top 1 WFTLocationId from [USDCWPTSSQLPD01].[jdejobs].[dbo].BranchPlantWFTLocation where ol.attrVal = BranchPlantId)
		) as WPTSLocation 
		--,wjp.maxLastUpdated
--,j.jobID,j.scheduledStartDateTime,j.serviceOrder,j.financialSystemID, wjp.maxLastUpdated as associatedRecordMaxLastUpdated
from job j
join OperationalLocation ol WITH (NOLOCK) on j.operationalLocationID = ol.gwis_locationid and lvl=5         
JOIN
(
	select jobid, max(updated) as updated
	from
	(
		select jobid,updated from job
		union
		select jobid,c.updated from Company c
		join job j on c.oneViewCompanyID = j.oneViewCompanyID
		UNION
		select jobid,updated from JobCustomerCounts jc
		UNION
		select jobid,updated from JobWells
		union 
		select jobid,updated from WPTS_KPI_Hours		
	)updateddata
	group by updateddata.jobID
) maxupdated on j.jobID = maxupdated.jobID
join WPTS_KPI_Hours wkh on wkh.JobID = j.jobID
left JOIN
(
	select jobid, max(maxLastUpdated) as maxLastUpdated
	from WPTS_JobPostings wj
	group by wj.jobID
) wjp on wjp.jobID = j.jobID
left join WPTS_JobPostings wjp2 on wjp.jobID = wjp2.jobID and wjp.maxLastUpdated = wjp2.maxLastUpdated
left join company c on j.oneViewCompanyID = c.oneViewCompanyID
join jobwells jw on j.jobID = jw.jobID
JOIN
(
SELECT [jobID]      
      ,max([updated]) as updated      
	  ,max(case when isPrimary is null then -1 else isPrimary end) as maxIsPrimary
  FROM [oneview].[dbo].[JobWells] jw
  where (jw.deleted is null or jw.deleted =0)
  group by [jobID]
) pw on jw.jobID=pw.jobID and jw.updated = pw.updated
join Well w on jw.oneViewWellID = w.wellID
left join Translate_rigtype rigtype WITH (NOLOCK)on (jw.rigtypeid=rigtype.oneview_rigtypeid )
left join JobCustomerCounts jcc on jcc.jobID = j.jobID
--join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations wl on wl.locationid = coalesce(
--			(select top 1 locationid 
--			from [USDCWPTSSQLPD01].disjobhistory.dbo.hdrwftlocations hl
--			join
--			--where propertyid =
--			(select top 1 mpl.LEASE_NUM 
--			from [USDCWPTSSQLPD01].DISJobHistory.mdm.MDMPhysicalLocation mpl 
--			where ol.attrval = mpl.BRANCH_PLANT_NUMBER COLLATE Latin1_General_CI_AI
--			order by branch_plant_number, PRIMARY_USE_FLG desc, ACTV_FLG desc
--			) tmpdata on hl.PropertyID = tmpdata.LEASE_NUM			 
--			)
--			,(select top 1 WFTLocationId from [USDCWPTSSQLPD01].[jdejobs].[dbo].BranchPlantWFTLocation where ol.attrVal = BranchPlantId)
--		)
--left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrregions hr on hr.id = wl.regionid
--		left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrsubregions hsr on hsr.subregionid = wl.subregionid
--		left join [USDCWPTSSQLPD01].disjobhistory.dbo.hdrcountries hc on hc.countryid = wl.wptscountryid
where (j.deleted is null or j.deleted = 0) and j.actualStartDateTime >= '2014-01-01 00:00:00' and  
j.jobstatusid in (5,9,10,11,12,13,1,16) AND (wkh.operating_time > 0 )
and (wjp.maxLastUpdated is null or maxupdated.updated> wjp.maxLastUpdated-- or j.updated > wjp.maxLastUpdated
)
and j.jobID=@jobId
order by  j.actualStartDateTime



GO
/****** Object:  StoredProcedure [utils].[GenerateIndexesScript]    Script Date: 3/19/2024 11:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Adapted from http://www.sqlservercentral.com/Forums/Topic401784-562-2.aspx (by Jonathan AC Roberts. )

Modifications 10/06/2010 By R.Doering - http://sqlsolace.blogspot.com

	1) Changed Schema of routine to Utils
	2) Changed Name from INFGenerateIndexesScript to GenerateIndexesScript
	3) Added Schemas to script
	4) Reformatted for clarity

--  Usage: EXEC utils.GenerateIndexesScript 1, 0, 0
*/ 
CREATE PROCEDURE [utils].[GenerateIndexesScript]
(
    @IncludeFileGroup  bit = 1,
    @IncludeDrop       bit = 1,
    @IncludeFillFactor bit = 1
)
AS

BEGIN
    -- Get all existing indexes, but NOT the primary keys
    DECLARE Indexes_cursor CURSOR
        FOR SELECT 
					SC.Name			AS	SchemaName
					, SO.Name			AS	TableName
                    , SI.Object_Id     AS	TableId
					, SI.[Name]         AS	IndexName
					, SI.Index_ID       AS	IndexId
					, FG.[Name]       AS FileGroupName
					, CASE WHEN SI.Fill_Factor = 0 THEN 100 ELSE SI.Fill_Factor END  Fill_Factor
              FROM sys.indexes SI
              LEFT JOIN sys.filegroups FG
                     ON SI.data_space_id = FG.data_space_id
              INNER JOIN sys.objects SO
					ON SI.object_id = SO.object_id
			  INNER JOIN sys.schemas SC
					ON SC.schema_id = SO.schema_id
             WHERE ObjectProperty(SI.Object_Id, 'IsUserTable') = 1
               AND SI.[Name] IS NOT NULL
               AND SI.is_primary_key = 0
               AND SI.is_unique_constraint = 0
               AND IndexProperty(SI.Object_Id, SI.[Name], 'IsStatistics') = 0
             ORDER BY Object_name(SI.Object_Id), SI.Index_ID

    DECLARE @SchemaName		sysname
    DECLARE @TableName			sysname
    DECLARE @TableId					int
    DECLARE @IndexName				sysname
    DECLARE @FileGroupName	sysname
    DECLARE @IndexId					int
    DECLARE @FillFactor				int

    DECLARE @NewLine nvarchar(4000)     SET @NewLine = CHAR(13) + CHAR(10)
    DECLARE @Tab			nvarchar(4000)     SET @Tab = Space(4)

    -- Loop through all indexes
    OPEN Indexes_cursor

    FETCH NEXT
     FROM Indexes_cursor
     INTO @SchemaName, @TableName, @TableId, @IndexName, @IndexId, @FileGroupName, @FillFactor

    WHILE (@@Fetch_Status = 0)
        BEGIN

            DECLARE @sIndexDesc	nvarchar(4000)
            DECLARE @sCreateSql	nvarchar(4000)
            DECLARE @sDropSql		nvarchar(4000)

            SET @sIndexDesc = '-- Index ' + @IndexName + ' on table ' + @TableName
            SET @sDropSql = 'IF EXISTS(SELECT 1' + @NewLine
                          + '            FROM sysindexes si' + @NewLine
                          + '            INNER JOIN sysobjects so' + @NewLine
                          + '                   ON so.id = si.id' + @NewLine
                          + '           WHERE si.[Name] = N''' + @IndexName + ''' -- Index Name' + @NewLine
                          + '             AND so.[Name] = N''' + @TableName + ''')  -- Table Name' + @NewLine
                          + 'BEGIN' + @NewLine
                          + '    DROP INDEX [' + @IndexName + '] ON [' + @SchemaName + '].[' + @TableName + ']' + @NewLine
                          + 'END' + @NewLine

            SET @sCreateSql = 'CREATE '

            -- Check if the index is unique
            IF (IndexProperty(@TableId, @IndexName, 'IsUnique') = 1)
                BEGIN
                    SET @sCreateSql = @sCreateSql + 'UNIQUE '
                END
            --END IF
            -- Check if the index is clustered
            IF (IndexProperty(@TableId, @IndexName, 'IsClustered') = 1)
                BEGIN
                    SET @sCreateSql = @sCreateSql + 'CLUSTERED '
                END
            --END IF

            SET @sCreateSql = @sCreateSql + 'INDEX [' + @IndexName + '] ON [' + @SchemaName + '].[' + @TableName + ']' + @NewLine + '(' + @NewLine

            -- Get all columns of the index
            DECLARE IndexColumns_cursor CURSOR
                FOR SELECT SC.[Name],
                           IC.[is_included_column],
                           IC.is_descending_key
                      FROM sys.index_columns IC
                     INNER JOIN sys.columns SC
                             ON IC.Object_Id = SC.Object_Id
                            AND IC.Column_ID = SC.Column_ID
                     WHERE IC.Object_Id = @TableId
                       AND Index_ID = @IndexId
                     ORDER BY IC.key_ordinal

            DECLARE @IxColumn			sysname
            DECLARE @IxIncl					bit
            DECLARE @Desc					bit
            DECLARE @IxIsIncl					bit     SET @IxIsIncl = 0
            DECLARE @IxFirstColumn		bit     SET @IxFirstColumn = 1

            -- Loop through all columns of the index and append them to the CREATE statement
            OPEN IndexColumns_cursor
            FETCH NEXT
             FROM IndexColumns_cursor
             INTO @IxColumn, @IxIncl, @Desc

            WHILE (@@Fetch_Status = 0)
                BEGIN
                    IF (@IxFirstColumn = 1)
                        BEGIN
                            SET @IxFirstColumn = 0
                        END
                    ELSE
                        BEGIN
                            --check to see if it's an included column
                            IF (@IxIsIncl = 0) AND (@IxIncl = 1)
                                BEGIN
                                    SET @IxIsIncl = 1
                                    SET @sCreateSql = @sCreateSql + @NewLine + ')' + @NewLine + 'INCLUDE' + @NewLine + '(' + @NewLine
                                END
                            ELSE
                                BEGIN
                                    SET @sCreateSql = @sCreateSql + ',' + @NewLine
                                END
                            --END IF
                        END
                    --END IF

                    SET @sCreateSql = @sCreateSql + @Tab + '[' + @IxColumn + ']'
                    -- check if ASC or DESC
                    IF @IxIsIncl = 0
                        BEGIN
                            IF @Desc = 1
                                BEGIN
                                    SET @sCreateSql = @sCreateSql + ' DESC'
                                END
                            ELSE
                                BEGIN
                                    SET @sCreateSql = @sCreateSql + ' ASC'
                                END
                            --END IF
                        END
                    --END IF
                    FETCH NEXT
                     FROM IndexColumns_cursor
                     INTO @IxColumn, @IxIncl, @Desc
                END
            --END WHILE
            CLOSE IndexColumns_cursor
            DEALLOCATE IndexColumns_cursor

            SET @sCreateSql = @sCreateSql + @NewLine + ') '

            IF @IncludeFillFactor = 1
                BEGIN
                    SET @sCreateSql = @sCreateSql + @NewLine + 'WITH (FillFactor = ' + Cast(@FillFactor as varchar(13)) + ')' + @NewLine
                END
            --END IF

            IF @IncludeFileGroup = 1
                BEGIN
                    SET @sCreateSql = @sCreateSql + 'ON ['+ @FileGroupName + ']' + @NewLine
                END
            ELSE
                BEGIN
                    SET @sCreateSql = @sCreateSql + @NewLine
                END
            --END IF

            PRINT '-- **********************************************************************'
            PRINT @sIndexDesc
            PRINT '-- **********************************************************************'

            IF @IncludeDrop = 1
                BEGIN
                    PRINT @sDropSql
                    PRINT 'GO'
                END
            --END IF

            PRINT @sCreateSql
            PRINT 'GO' + @NewLine  + @NewLine

            FETCH NEXT
             FROM Indexes_cursor
             INTO @SchemaName, @TableName, @TableId, @IndexName, @IndexId, @FileGroupName, @FillFactor
        END
    --END WHILE
    CLOSE Indexes_cursor
    DEALLOCATE Indexes_cursor
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Amount of foreign Currency equivilant to $1.00 USD' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'COLUMN',@level2name=N'rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This comes from the Asset_Number field in the JDE export' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Equipment', @level2type=N'COLUMN',@level2name=N'EquipmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'An ID from the GWIS_Location table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Equipment', @level2type=N'COLUMN',@level2name=N'BranchPlantID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'An ID from the GWIS_Location table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Equipment', @level2type=N'COLUMN',@level2name=N'BusinessUnitID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This is set if the asset was imported from another system' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Equipment', @level2type=N'COLUMN',@level2name=N'legacyPartNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Based on data in Equipment_Status as imported into EquipmentStatus' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Equipment', @level2type=N'COLUMN',@level2name=N'equipmentStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Generated when a status change occurs in TOPS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Equipment', @level2type=N'COLUMN',@level2name=N'assetPendingStatusChangeInJDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Generated when the transfer is completed in TOPS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Equipment', @level2type=N'COLUMN',@level2name=N'assetPendingTransferInJDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Set when version change is initiated in TOPS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Equipment', @level2type=N'COLUMN',@level2name=N'assetPendingVersionChangeInJDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID to a record in Currency' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EquipmentAdditionalInformation', @level2type=N'COLUMN',@level2name=N'currencyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Originally from the Cost field' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EquipmentAdditionalInformation', @level2type=N'COLUMN',@level2name=N'grossBookValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Created from values in Ownership column from jde import' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EquipmentAdditionalInformation', @level2type=N'COLUMN',@level2name=N'equipmentOwnershipID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From the New_or_used column in import...assuming that this is either Yes or No.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EquipmentAdditionalInformation', @level2type=N'COLUMN',@level2name=N'newOrUsed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Imported from TOPS Product' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EquipmentProduct', @level2type=N'COLUMN',@level2name=N'equipmentProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From the Asset_Description1 column' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EquipmentToolPanelCodeVersion', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Imported from TOPS toolpanelcodeversionstatus' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EquipmentToolPanelCodeVersionStatus', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID to a record in Currency' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_AssetAdditionalInformation', @level2type=N'COLUMN',@level2name=N'currencyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Originally from the Cost field' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_AssetAdditionalInformation', @level2type=N'COLUMN',@level2name=N'grossBookValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Created from values in Ownership column from jde import' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_AssetAdditionalInformation', @level2type=N'COLUMN',@level2name=N'GWIS_AssetOwnershipID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From the New_or_used column in import...assuming that this is either Yes or No.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_AssetAdditionalInformation', @level2type=N'COLUMN',@level2name=N'newOrUsed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Imported from TOPS Product' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_AssetProduct', @level2type=N'COLUMN',@level2name=N'GWIS_AssetProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This comes from the Asset_Number field in the JDE export' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_Assets', @level2type=N'COLUMN',@level2name=N'GWIS_AssetID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'An ID from the GWIS_Location table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_Assets', @level2type=N'COLUMN',@level2name=N'branchPlantID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'An ID from the GWIS_Location table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_Assets', @level2type=N'COLUMN',@level2name=N'businessUnitID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This is set if the asset was imported from another system' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_Assets', @level2type=N'COLUMN',@level2name=N'legacyPartNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Based on data in Equipment_Status as imported into GWIS_AssetStatus' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_Assets', @level2type=N'COLUMN',@level2name=N'GWIS_AssetStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Generated when a status change occurs in TOPS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_Assets', @level2type=N'COLUMN',@level2name=N'assetPendingStatusChangeInJDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Generated when the transfer is completed in TOPS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_Assets', @level2type=N'COLUMN',@level2name=N'assetPendingTransferInJDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Set when version change is initiated in TOPS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_Assets', @level2type=N'COLUMN',@level2name=N'assetPendingVersionChangeInJDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From the Asset_Description1 column' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_AssetToolPanelCodeVersion', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Imported from TOPS toolpanelcodeversionstatus' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GWIS_AssetToolPanelCodeVersionStatus', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Three digit country code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'JobBonusJobPositionDefaultPercentages', @level2type=N'COLUMN',@level2name=N'countryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From GWIS_Location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'JobPrintConfiguration', @level2type=N'COLUMN',@level2name=N'operationalRegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From GWIS_Location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'JobPrintConfiguration', @level2type=N'COLUMN',@level2name=N'operationalAreaID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From GWIS_Location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'JobPrintConfiguration', @level2type=N'COLUMN',@level2name=N'operationalDistrictID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'JobPrintSections', @level2type=N'COLUMN',@level2name=N'jobPrintSectionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This field is obsolete' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'JobWells', @level2type=N'COLUMN',@level2name=N'jobWellID'
GO
