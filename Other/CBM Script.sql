
ALTER TABLE [dbo].[PFTWO] ADD 
[AssetRepairTrackId] [uniqueidentifier] NULL
GO
ALTER TABLE [dbo].[PFTWOSeq] ALTER COLUMN [Hours] [decimal] (10,2) NULL
GO
ALTER TABLE [dbo].[AuditPFTWO] ADD 
[AssetRepairTrackId] [uniqueidentifier] NULL
GO
ALTER TABLE [dbo].[JDEWorkOrders] ADD 
[WorkOrderId] [uniqueidentifier] NULL
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
			IF NOT EXISTS(SELECT COUNT(*) 
						FROM PFTWO p (NOLOCK)
						JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
						WHERE p.AssetRepairTrackId = @AssetRepairTrackId AND p.PFTType = 1 AND ps.PFTResult = 'F')
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


			(SELECT CASE WHEN (SELECT COUNT(*)  
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
		a.FromBranchPlant [FromBranchPlant],
		b.CompanyName [FromBranchBranchDesc],
		a.ShipToBranchPlant [ShipToBranchPlant],
		b1.CompanyName [ShipToBranchDesc]
		 
	FROM AssetRepairTrack a (NOLOCK)
	LEFT JOIN FixedAssets f (NOLOCK) ON a.FixedAssetId = f.FixedAssetId
	LEFT JOIN BranchPlants b (NOLOCK) ON b.BranchPlant = a.FromBranchPlant
	LEFT JOIN BranchPlants b1 (NOLOCK) ON b1.BranchPlant = a.ShipToBranchPlant
	
	Where a.AssetRepairTrackId = @AssetRepairTrackId

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
	ORDER BY p.DateAdded DESC
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

--T&I PFT
UPDATE
    P
SET
    P.AssetRepairTrackId = A.AssetRepairTrackId 
FROM
    PFTWO P
    INNER JOIN
    AssetRepairTrack A ON A.ITPFTWOId = P.PFTWOId
    AND P.PFTType=2


--S&R PFT
   UPDATE
    P
SET
    P.AssetRepairTrackId = A.AssetRepairTrackId
FROM
    PFTWO P
    INNER JOIN
    AssetRepairTrack A ON A.SRPFTWOId = P.PFTWOId
    AND P.PFTType=1

GO

INSERT INTO AuditARTDispositions
SELECT (SELECT MAX(DispositionId) FROM AuditARTDispositions) + ROW_NUMBER() OVER(ORDER BY a.dateadded) [AuditActionId], a.* 
FROM ARTDispositions a
LEFT JOIN AuditARTDispositions a1 ON a.DispositionId = a1.DispositionId
WHERE a1.DispositionId is null
order by a.dateadded desc