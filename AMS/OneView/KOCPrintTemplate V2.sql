use oneviewtest;

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'JobKOCDetails') 
BEGIN
	CREATE TABLE [dbo].[JobKOCDetails](
		[jobKOCID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_JobKOCDetails_jobKOCID]  DEFAULT (newid()),
		[jobID] [uniqueidentifier] NOT NULL,
		[KOCSOFNumber] [nvarchar](50) NOT NULL,
		[contractNumber] [nvarchar](50) NOT NULL,
		[serviceOrder] [varchar](50) NULL,
		[KOCRepresentatives] [nvarchar](100) NOT NULL,
		[briefJobDesc] [nvarchar](500) NULL,
		[deleted] [bit] NULL,
		[inserted] [binary](8) NOT NULL CONSTRAINT [DF_JobKOCDetails_inserted]  DEFAULT (@@dbts+(1)),
		[updated] [timestamp] NULL,
		[updateId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_JobKOCDetails_updateId]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
		[inserId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_JobKOCDetails_insertId]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	 CONSTRAINT [PK_JobKOCDetails] PRIMARY KEY CLUSTERED 
	(
		[jobKOCID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

END
GO

SET ANSI_PADDING OFF
GO

IF NOT EXISTS (SELECT *  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME ='FK_JobKOCDetails_Job')
BEGIN 
	ALTER TABLE [dbo].[JobKOCDetails]  WITH CHECK ADD  CONSTRAINT [FK_JobKOCDetails_Job] FOREIGN KEY([jobID]) REFERENCES [dbo].[Job] ([jobID])
END

GO

IF NOT EXISTS (SELECT * FROM JobPrintConfiguration WHERE jobPrintConfigurationID ='BE89C2D4-6ADC-4D38-B10A-52B1EA3B07D6')
BEGIN
--Insert a new print template in JobPrintConfiguration 
	INSERT into JobPrintConfiguration
	(
		jobPrintConfigurationID, 
		name, 
		fontName, 
		fontSize, 
		updateId, 
		insertId, 
		regionId, 
		gwisLocationRegionID
	)
	VALUES
	(
		'BE89C2D4-6ADC-4D38-B10A-52B1EA3B07D6', 
		'KOCDetails', 
		'Arial', 
		10, 
		'00000000-0000-0000-0000-000000000000', 
		'00000000-0000-0000-0000-000000000000', 
		1, 
		4
	)
END

GO

--Insert a new template for Print template configuration 'KOCDetails' under JobInfo section

IF NOT EXISTS (SELECT * FROM JobPrintConfigurationSections WHERE jobPrintConfigurationSectionID = '57FF826F-71F8-4E71-A609-EBF62DB0D9EE')
BEGIN

	insert into JobPrintConfigurationSections
	(
		jobPrintConfigurationID, 
		jobPrintConfigurationSectionID,
		jobPrintSectionID,	
		updateId,	
		insertId,	
		templateName,	
		precedence
	)
	values
	(
		'BE89C2D4-6ADC-4D38-B10A-52B1EA3B07D6',
		'57FF826F-71F8-4E71-A609-EBF62DB0D9EE',
		5,
		'00000000-0000-0000-0000-000000000000', 
		'00000000-0000-0000-0000-000000000000', 
		'KOC', 
		1
	)
END

GO

--Insert a new template for Print template configuration 'KOCDetails' under Signature section
IF NOT EXISTS (SELECT * FROM JobPrintConfigurationSections WHERE jobPrintConfigurationSectionID = '0ECF5153-4309-44E7-BD2A-39ECCECF5228')
BEGIN
	INSERT INTO JobPrintConfigurationSections
	(
		jobPrintConfigurationID, 
		jobPrintConfigurationSectionID,
		jobPrintSectionID,	
		updateId,	
		insertId,	
		templateName,	
		precedence
	)
	VALUES
	(
		'BE89C2D4-6ADC-4D38-B10A-52B1EA3B07D6',
		'0ECF5153-4309-44E7-BD2A-39ECCECF5228',
		12,
		'00000000-0000-0000-0000-000000000000', 
		'00000000-0000-0000-0000-000000000000', 
		'KOC', 
		1
	)
END
GO



ALTER TABLE ServiceDetails
  ADD SpecialLine nvarchar(250),
      SpecialLineNo nvarchar(250),
	  SpecialToolMnemonic nvarchar(250);


ALTER TABLE PricebookDataLog
  ADD SpecialLine nvarchar(250),
      SpecialLineNo nvarchar(250),
	  SpecialToolMnemonic nvarchar(250);
GO