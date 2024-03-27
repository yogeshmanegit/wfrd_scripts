
USE [AesOps]
GO

ALTER TABLE [dbo].[Jobs] ADD 
[SalesforceId] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WFTUserName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SFCreatedDate] [datetime] NULL,
[SFLastModifiedDate] [datetime] NULL
GO
ALTER TABLE [dbo].[AuditJobs] ADD 
[SalesforceId] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WFTUserName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SFCreatedDate] [datetime] NULL,
[SFLastModifiedDate] [datetime] NULL
GO
CREATE TABLE [dbo].[SOAAuditType]
(
	[Id] [int] IDENTITY (1,1) NOT NULL,
	[AuditTypeId] [int] NOT NULL,
	[AuditDesc] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SOAAuditT__Creat__7D6F4E9D] DEFAULT (getdate())
) ON [PRIMARY]
GO

--==================================================
--CREATED BY : SUYEB MOHAMMAD
--CREATED ON : 11th Feb 2016
--DESCRIPTION: To save audit details for SOA call
--==================================================
ALTER PROC [dbo].[save_SOAAuditInformation]
	@AuditGuid UNIQUEIDENTIFIER = NULL,
	@AuditTypeId INT,
	@RequestXml XML = NULL,
	@ResponseXml XML = NULL, 
	@RequestedBy VARCHAR(20) = NULL,
	@RequestedOn DATETIME,
	@RequestDuration DECIMAL(18,2), 
	@ResponseStatus VARCHAR(50),
	@ResponseCode VARCHAR(50),
	@Exception VARCHAR(MAX) = NULL,
	@Status BIT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
	
		IF (@AuditGuid IS NULL)
			SET @AuditGuid = NEWID()

		INSERT INTO [SOAAuditInformation]([AuditGuid], [AuditTypeId], [RequestXML], [ResponseXML], [RequestedBy], [RequestedOn], [RequestDuration], [ResponseStatus], [ResponseCode], [Exception], [StatusId])
		VALUES		(@AuditGuid, @AuditTypeId,  @RequestXml, @ResponseXml, @RequestedBy, @RequestedOn, @RequestDuration, @ResponseStatus, @ResponseCode, @Exception, @Status)

		SELECT	1
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @ErrorMessage VARCHAR(4000) = ERROR_MESSAGE();
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
		DECLARE @ErrorState INT = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO
ALTER PROCEDURE [dbo].[spAuditRecordsGuid] 
	@AuditTypeId int,
	@UserId int, 
	@ActionDesc varchar(1024),
	@RemoteHost varchar(75),
	@KeyId uniqueidentifier,
	@TableName varchar(255),
	@KeyFieldName varchar(255),
	@AuditTable varchar(255),
	@AuditActionId int = null output
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @sql nvarchar(max)
	
	if @AuditActionId is null
	begin
		insert into AuditActions (AuditTypeId, UserId, ActionDesc, ActionDate, RemoteHost, AuditTable)
		values (@AuditTypeId, @UserId, @ActionDesc, getdate(), @RemoteHost, @AuditTable)

		Set @AuditActionId = @@IDENTITY
	end
	
	if @KeyId is not null
	begin
		SET @sql = N'insert into ' + @AuditTable + N' select ''' + convert(varchar(max), @AuditActionId) + N''', * from ' 
			+ @TableName + N' where ' + @KeyFieldName + N' = ''' + convert(varchar(max), @KeyId) + ''''
		EXEC sp_executesql @sql
	end

	SET NOCOUNT OFF;
	
END
GO
--==============================================================
--CREATED BY  : YOGESH MANE
--CREATED ON  : 25th April 2016
--DESCCRIPTION: To create job header from sales force rest services
--==================================================================
CREATE PROCEDURE [dbo].[usp_CreateJobHeaderBySalesforce]
	@Jobs XML
AS
BEGIN

SET NOCOUNT ON;
	
--VARIABLE DECLARATION	
DECLARE @SFDCJobId VARCHAR(20),
		@BranchPlant VARCHAR(12),
		@CustomerNumber INT,
		@JobNumber VARCHAR(50),
		@StartDate VARCHAR(50),
		@EndDate VARCHAR(50),
		@JobLocation VARCHAR(50),
		@Rig VARCHAR(50),
		@Offshore BIT,
		@Coordinator varchar(100),
		@Longitude FLOAT,
		@Latitude FLOAT,
		@DispatchNumber INT,
		@Runs INT,
		@WFTUserName VARCHAR(20),
		@SFCreateDate VARCHAR(50),
		@SFLastUpdatedOnDate VARCHAR(50)
		
DECLARE @CustomerId UNIQUEIDENTIFIER, @JobId UNIQUEIDENTIFIER, @UserId INT, @Country VARCHAR(25), @Region VARCHAR(25)

-- DECLARE RESULT TABLES
DECLARE @JobHeaderResult Table
(
	SFDCJobId VARCHAR(20),
	JobId UNIQUEIDENTIFIER,
	JobNumber VARCHAR(50)
)

DECLARE @JobHeaderErrors Table
(
	JobNumber VARCHAR(50),
	Error VARCHAR(100)
)


-- STRART VALIDATION AND SAVING PROCESS

DECLARE CUR CURSOR LOCAL FAST_FORWARD FOR
SELECT 
	Child.value('(SFDC_JobId)[1]', 'VARCHAR(20)'),
    Child.value('(BranchPlant)[1]', 'VARCHAR(12)'),
	Child.value('(CustomerNumber)[1]', 'INT'),
	Child.value('(JobNumber)[1]', 'VARCHAR(50)'),
	Child.value('(StartDate)[1]', 'VARCHAR(50)'),
	Child.value('(EndDate)[1]', 'VARCHAR(50)'),
	Child.value('(JobLocation)[1]', 'VARCHAR(50)'),
	Child.value('(Rig)[1]', 'VARCHAR(50)'),
	Child.value('(Offshore)[1]', 'BIT'),
	Child.value('(Coordinator)[1]', 'VARCHAR(100)'),
	Child.value('(Longitude)[1]', 'FLOAT'),
	Child.value('(Latitude)[1]', 'FLOAT'),
	Child.value('(DispatchNumber)[1]', 'INT'),
	Child.value('(Runs)[1]', 'INT'),
	Child.value('(WFTUserName)[1]', 'VARCHAR(20)'),
	Child.value('(createdDate)[1]', 'VARCHAR(50)'),
	Child.value('(lastmodifiedDate)[1]', 'VARCHAR(50)')
FROM
    @jobs.nodes('/ArrayOfJobHeader/JobHeader') AS N(Child)

OPEN CUR
WHILE 1 = 1
BEGIN
    FETCH CUR INTO @SFDCJobId
		,@BranchPlant
		,@CustomerNumber
		,@JobNumber
		,@StartDate
		,@EndDate
		,@JobLocation
		,@Rig
		,@Offshore 
		,@Coordinator
		,@Longitude
		,@Latitude
		,@DispatchNumber
		,@Runs
		,@WFTUserName
		,@SFCreateDate
		,@SFLastUpdatedOnDate
    if @@fetch_status <> 0 break

    -- Get MyAdvisor specific Customer Id and User id
    SELECT @CustomerId = CustomerId FROM Customers WHERE CustomerNumber = @CustomerNumber
    SELECT @UserId = 0

	SET @JobId = NULL


    -- Invalid Customer save error in table
    IF (@CustomerId IS NULL)
    BEGIN
		INSERT INTO @JobHeaderErrors SELECT @JobNumber, 'Customer ['+ CONVERT(varchar(MAX), @CustomerNumber) +'] not found'
    END
    
    -- Invalid branch plant save error in table
    IF NOT EXISTS (SELECT 1 FROM BranchPlants WHERE BranchPlant = @BranchPlant)
    BEGIN
		INSERT INTO @JobHeaderErrors SELECT @JobNumber, 'BranchPlant ['+ @BranchPlant + '] not found'
    END
    ELSE
	BEGIN
		SELECT @Country = Country,
				@Region = Region
		FROM BranchPlants 
		WHERE BranchPlant = @BranchPlant
	END
	-- If Job start date not sent
	IF @StartDate IS NULL
    BEGIN
		INSERT INTO @JobHeaderErrors SELECT @JobNumber, 'Job start date is required'
    END 

	-- If end date not sent
	IF @EndDate IS NULL
	BEGIN
		INSERT INTO @JobHeaderErrors SELECT @JobNumber, 'Job end date is required'
	END 

	-- If dispatch number is already in use
	IF EXISTS (SELECT * FROM Jobs WHERE DispatchNumber = @DispatchNumber AND JobNumber <> @JobNumber AND @DispatchNumber <> 0)
	BEGIN
		INSERT INTO @JobHeaderErrors SELECT @JobNumber, 'Dispatch number [' + CONVERT(VARCHAR(20), @DispatchNumber) + '] already in use.'
	END


    -- IF there are no errors save/update job in db
    IF NOT EXISTS (SELECT 1 FROM @JobHeaderErrors Where JobNumber = @JobNumber)
    BEGIN
	   
    SELECT @JobId = JobId from Jobs where JobNumber = @JobNumber
	
	-- Update record if job already created
		
		IF (@JobId IS NOT NULL)
			BEGIN
				 UPDATE Jobs
				 SET BranchPlant= @BranchPlant,
					CustomerId = @CustomerId,
					StartDate = @StartDate,
					EndDate = @EndDate,
					LocationCounty = @JobLocation,
					Rig = @Rig,
					Offshore = @Offshore,
					Coordinator = @Coordinator,
					Longitude = @Longitude,
					Latitude = @Latitude,
					DispatchNumber = @DispatchNumber,
					Runs = @Runs,
					UpdateUserID = @UserId,
					SalesforceId = @SFDCJobId, 
					WFTUserName = @WFTUserName,
					UpdateDate = GETDATE(),
					Country = @Country,
					Region = @Region,
					SFCreatedDate = @SFCreateDate,
					SFLastModifiedDate = @SFLastUpdatedOnDate
				 WHERE	JobNumber = @JobNumber

				 --call audit sp
				EXEC [dbo].[usp_AuditJobs] 6004, @UserId,'create job header through salesforce','', @JobId

			END
		ELSE 
		-- insert record if job not present
			BEGIN
			
			SET @JobId = NEWID()

				INSERT INTO Jobs
				(JobId
				, SalesforceId
				, BranchPlant
				, Country
				, Region
				, CustomerId
				, JobNumber 
				, StartDate
				, EndDate
				, LocationCounty
				, Rig
				, Offshore
				, Coordinator
				, Longitude
				, Latitude
				, DispatchNumber
				, Runs
				, WFTUserName
				, CreateUserID
				, CreateDate
				, SFCreatedDate
				, SFLastModifiedDate)
				
				SELECT @JobId,
					@SFDCJobId,
					@BranchPlant, 
					@Country,
					@Region,
					@CustomerId, 
					@JobNumber, 
					@StartDate, 
					@EndDate, 
					@JobLocation, 
					@Rig, 
					@Offshore, 
					@Coordinator, 
					@Longitude, 
					@Latitude, 
					@DispatchNumber, 
					@Runs, 
					@WFTUserName,
					@UserId, 
					GETDATE(),
					@SFCreateDate,
					@SFLastUpdatedOnDate
					
					--call audit sp
					EXEC [dbo].[usp_AuditJobs] 6003, @UserId,'update job through salesforce','', @JobId
		END
		INSERT INTO JobQueue(JobId, CreateDate, RequestXml, JobQueueStatusId)
		VALUES(29, GETDATE(), '<ReliabilityWPTSJob><jobNumber>'+@JobNumber+'</jobNumber></ReliabilityWPTSJob>', 1)
    END
		
	INSERT INTO @JobHeaderResult(SFDCJobId, JobId, JobNumber)
	SELECT @SFDCJobId, @JobId, @JobNumber


END
CLOSE CUR
DEALLOCATE CUR

SELECT * FROM @JobHeaderResult

SELECT * FROM @JobHeaderErrors

SET NOCOUNT OFF;
END
GO


INSERT INTO [SOAAuditType] (AuditTypeId, AuditDesc, CreatedOn) SELECT 1, 'Fixed asset parent child audit information', GETDATE()
INSERT INTO [SOAAuditType] (AuditTypeId, AuditDesc, CreatedOn) SELECT 2, 'Job header audit information', GETDATE()
GO
