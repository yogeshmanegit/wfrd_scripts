-- =============================================
-- Author:		Yogesh Mane
-- Create date: 9/28/2016
-- Description:	Get Header information for AIRT Edit screen
-- =============================================
ALTER PROCEDURE [dbo].[usp_GetAIRTHeader] 
	-- Add the parameters for the stored procedure here
	@Id Uniqueidentifier,
	@UserId int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FixedAssetId Uniqueidentifier

	SELECT @FixedAssetId = FixedAssetId FROM AssetRepairTrack (NOLOCK) Where AssetRepairTrackId = @Id

	SELECT 
		-- General Info
		a.AssetRepairTrackId,
		a.ARTNumber, 
		a.Status, 
		a.AddedBy, 
		a.DateAdded [DateCreated], 
		f.FixedAssetId,
		f.SerialNum, 
		f.AssetNumber, 
		f.Revision, 
		f.EquipmentStatus [AssetStatus],  
		f.RNItemNum,
		f.InventoryItemNum,
		a.ItemDesc [ItemDescription],
		a.NCRNumber,
		a.ItemNum,
		j.JobNumber,

		-- Location Info
		a.FromBranchPlant [FromBranchPlant],
		b.CompanyName [FromBranchBranchDesc],
		a.ShipToBranchPlant [ShipToBranchPlant],
		b1.CompanyName [ShipToBranchDesc],
		a.IncidentId,
		a.ITPFTWOId,
		p.Active [ITPFTActive],
		p.PFTConfigId [TIPFTConfigId],
		pc.ProcessName [TIPFTName],
		a.SRPFTWOId,
		t.Active [SRPFTActive],
		pc1.ProcessName [SRPFTName],

		w.WorkOrderId [SRPFT_WorkOrderId],
		w.Status	  [SRPFT_WorkOrderStatus]
		 

	FROM AssetRepairTrack a (NOLOCK)
	LEFT JOIN FixedAssets f (NOLOCK) ON a.FixedAssetId = f.FixedAssetId
	LEFT JOIN BranchPlants b (NOLOCK) ON b.BranchPlant = a.FromBranchPlant
	LEFT JOIN BranchPlants b1 (NOLOCK) ON b1.BranchPlant = a.ShipToBranchPlant
	LEFT JOIN PFTWO p (NOLOCK) on a.ITPFTWOId = p.PFTWOId
	LEFT JOIN PFTConfig pc (NOLOCK) on pc.PFTConfigId = p.PFTConfigId
	LEFT JOIN PFTWO t (NOLOCK) on a.SRPFTWOId = t.PFTWOId
	LEFT JOIN PFTConfig pc1 (NOLOCK) on pc1.PFTConfigId = t.PFTConfigId
	LEFT JOIN Jobs J(NOLOCK) on J.JobId = a.JobId
	LEFT JOIN WorkOrders w (NOLOCK) on w.WorkOrderId = t.WorkOrderId

	Where a.AssetRepairTrackId = @Id

	-- Get Asset History
	
	exec dbo.[usp_GetAssetHistory] @FixedAssetId


	-- Get Score Board

	SELECT (SELECT CASE WHEN (SELECT COUNT(*)  
									FROM AssetRepairTrack a 
									LEFT JOIN PFTWO p (NOLOCK) on a.ITPFTWOId = p.PFTWOId
									LEFT JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
									WHERE a.AssetRepairTrackId = @Id AND ps.PFTResult = 'F') > 0 THEN 4

							WHEN (SELECT COUNT(*)  
								FROM AssetRepairTrack a 
								LEFT JOIN PFTWO p (NOLOCK) on a.ITPFTWOId = p.PFTWOId
								LEFT JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
								WHERE a.AssetRepairTrackId = @Id AND ps.PFTResult != 'F') > 0 THEN 3

							WHEN (SELECT 1  
									FROM AssetRepairTrack a (NOLOCK) 
									WHERE a.AssetRepairTrackId = @Id AND ITPFTWOId IS NOT NULL) > 0 THEN 2

							ELSE 1 END) [TIPFT],

			(SELECT CASE WHEN  Status = 'Approved' THEN 3
										WHEN Status = 'District Approved' THEN 2
										WHEN Status = 'Submitted' THEN 1
									ELSE NULL END
							FROM (SELECT TOP 1 Status
							FROM ARTDispositions a (NOLOCK)
							Where a.AssetRepairTrackId = @Id
							ORDER BY DateAdded desc) A) [Disposition],


			(SELECT CASE WHEN (SELECT COUNT(*)  
									FROM AssetRepairTrack a 
									LEFT JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
									LEFT JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
									WHERE a.AssetRepairTrackId = @Id AND ps.PFTResult = 'F') > 0 THEN 4

							WHEN (SELECT COUNT(*)  
								FROM AssetRepairTrack a 
								LEFT JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
								LEFT JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
								WHERE a.AssetRepairTrackId = @Id AND ps.PFTResult != 'F' and p.Active = 0) > 0 THEN 3

							WHEN (SELECT COUNT(*)  
										FROM AssetRepairTrack a 
										JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
										JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId
										WHERE a.AssetRepairTrackId = @Id AND ps.PFTResult IS NOT NULL) > 0 THEN 2

							WHEN (SELECT 1  
									FROM AssetRepairTrack a (NOLOCK) 
									WHERE a.AssetRepairTrackId = @Id AND SRPFTWOId IS NOT NULL) > 0 THEN 1
							END) [SRPFT],

			(SELECT CASE WHEN w.Status = 'Closed' THEN 3
										WHEN w.JDEWorkOrderNum IS NULL THEN 2
										WHEN w.Status = 'Open' THEN 1
									ELSE NULL END
								FROM AssetRepairTrack a (NOLOCK) 
								JOIN PFTWO p (NOLOCK) on a.SRPFTWOId = p.PFTWOId
								JOIN WorkOrders w (NOLOCK) on w.WorkOrderId = p.WorkOrderId
								WHERE a.AssetRepairTrackId = @Id) [WorkOrder],

			(SELECT CASE WHEN a.IsAssetFromField = 1 AND JobId IS NOT NULL THEN 3
										WHEN a.IsAssetFromField = 1 AND JobId IS NULL THEN 2
										ELSE 1 END
								 FROM AssetRepairTrack a (NOLOCK) WHERE AssetRepairTrackId = @Id) [JobMapping],

			(CASE WHEN (SELECT COUNT(*) 
					FROM VwChangeNoticeParts				 
					WHERE (FixedAssetId = @FixedAssetId OR TopLevelFixedAssetId = @FixedAssetId) 
					AND ( NotApplicable = 1 ))  > 0 THEN 1 
					ELSE 2 END) [TCN]

			
	--- Get Job Info

	SELECT a.JobId,
			a.IsAssetFromField, 
			a.IsRedTag [IsAssociatedWithFieldFailure], 
			a.NeedsCustomerFeedback,
			j.JobNumber,
			j.CustomerId,
			c.CustomerName,
			r.Well [FailedWell],
			r.RunNumber [FailedRunNumber]
	FROM AssetRepairTrack a (NOLOCK)
	LEFT JOIN Jobs J (NOLOCK) ON J.JobId = a.JobId
	LEFT JOIN Customers c (NOLOCK) ON C.CustomerId = J.CustomerId
	LEFT JOIN (SELECT TOP 1 j.JobId, 
					r.Well, 
					r.RunNumber
			FROM RelBusinessIntelligenceDataSet r (NOLOCK)
			Join Jobs J (NOLOCK) on j.JobNumber = r.JobNumber
			JOIN AssetRepairTrack a (NOLOCK) ON a.JobId = j.JobId
			Where a.AssetRepairTrackId = @Id and r.TFF = '1') R ON r.JobId = a.JobId
	WHERE a.AssetRepairTrackId = @Id

END
GO
