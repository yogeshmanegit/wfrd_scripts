DECLARE -- Add the parameters for the stored procedure here
	--@AssetRepairTrackId uniqueidentifier= '465DE5E6-FE5F-4DA8-B1F7-9EC5C8A15FA8'
	@AssetRepairTrackId uniqueidentifier= 'E6444983-9142-4BE1-BE63-17240951DDA0'
                     , @UserId int=0 
BEGIN
SET NOCOUNT ON;

DECLARE @IsNonLiveLocation bit DECLARE @RollBackAccess bit

SET @IsNonLiveLocation=1

SELECT @IsNonLiveLocation = IsNonLiveLocation
FROM AssetRepairTrack a (NOLOCK)
LEFT JOIN BranchPlants b (NOLOCK) ON a.FromBranchPlant = b.BranchPlant
WHERE a.AssetRepairTrackId = @AssetRepairTrackId

SELECT 
	CASE WHEN po.PFTType = 1 THEN 'SR'
		WHEN po.PFTType = 2 THEN 'IT' 
		WHEN po.PFTType = 3 THEN 'PM' 
		WHEN Po.PFTType IS NULL and jw.JDEWorkOrderId IS not null THEN 'JDEAIRT'
	END [Type],

	ITPFTWOId [PFTId],
	ISNULL(po.WO_NO, jw.Description) [Description],
	CASE WHEN PO.PFTWOId IS NOT NULL THEN PO.Active
		ELSE (CASE WHEN w.Status='Open' THEN 1 ELSE 0 END)
	END As Active,
	ISNULL(PO.JDEWorkOrderNum, jw.WorkOrderNumber) as JDEWorkOrderNum,
    ISNULL(PO.BranchPlant, jw.Branch) AS BranchPlant,
    ISNULL(PO.WorkOrderId, w.WorkOrderId) AS WorkOrderId,
	a.AssetRepairTrackId,
	ISNULL(pc.ProcessName, jw.Description) AS [PFTName],
    @IsNonLiveLocation AS [IsNonLiveLocation],
    f.BranchPlant FixedAssetBranchPlant,
	f.ParentFixedAssetId,

	jw.OrderType + '-' + jw.TypeWO AS [OrderType],
	jw.Description,
	jw.EstimatedAmount,
	jw.ActaulMiscCostInUSD AS ActualAmount,
	jw.WorkOrderStatusCode,
    (CASE WHEN jw.DispatchNumber = 0 THEN NULL ELSE jw.DispatchNumber END) DispatchNumber,

	CASE WHEN WorkOrderStatusCode NOT IN ('ET', 'EU', 'EV', 'EW', 'EX', 'EZ') THEN 'true' 
		ELSE 'false' 
	END AS [StatusOfMR],

	CASE WHEN (SELECT COUNT(*)
				FROM WorkOrderMaterialRequests MR
				WHERE MR.WorkOrderId = PO.WorkOrderId
				AND MR.status IN ('Completed', 'Void')) > 0 THEN 'true' 
		ELSE 'false' 
	END AS [StatusOfPRMR],

	(SELECT WorkOrderMaterialRequestId
                          FROM WorkOrderMaterialRequests MR
                          WHERE status IN ('Open', 'Submitted', 'Approved', 'Rejected')
                            AND MR.WorkOrderId = PO.WorkOrderId) [StatusOfMRAction],

	CASE WHEN jw. WorkOrderNumber IS NOT NULL THEN jw.BusinessUnit
		ELSE COALESCE( dbo.[ufn_BusinessUnit_ByDT](a.DispatchNumber, f.BranchPlant, a.SerialNum, a.RNItemNum)
						,f.BusinessUnit, f.BranchPlant)
              END AS [BusinessUnit]

  FROM (
		-- JDE work order associated with PFT WO
		select a.AssetRepairTrackId, po.PFTWOId, jw.JDEWorkOrderId 
			FROM AssetRepairTrack a (NOLOCK)
			JOIN PFTWO (NOLOCK) PO ON a.AssetRepairTrackId = PO.AssetRepairTrackId
			JOIN JDEWorkOrders jw (NOLOCK) ON po.JDEWorkOrderNum = jw.WorkOrderNumber
			where a.AssetRepairTrackId = @AssetRepairTrackId
		UNION 
		-- JDE work orders that are not associated with PFT WO (but associated with AIRT)
		select a.AssetRepairTrackId, po.PFTWOId, jw.JDEWorkOrderId 
			FROM AssetRepairTrack a (NOLOCK)
			JOIN JDEWorkOrders jw (NOLOCK) ON a.AssetRepairTrackId = jw.AssetRepairTrackId
			LEFT JOIN PFTWO (NOLOCK) PO ON a.AssetRepairTrackId = PO.AssetRepairTrackId and po.JDEWorkOrderNum = jw.WorkOrderNumber
			where a.AssetRepairTrackId = @AssetRepairTrackId and po.PFTWOId is null
		) b   
  JOIN AssetRepairTrack a (NOLOCK) ON b.AssetRepairTrackId = a.AssetRepairTrackId
  JOIN FixedAssets f ON f.FixedAssetId = a.FixedAssetId 
  LEFT JOIN PFTWO (NOLOCK) PO ON a.AssetRepairTrackId = PO.AssetRepairTrackId 
	AND b.PFTWOId = po.PFTWOId 
	AND PO.PFTType IN (1,2, 3)
  LEFT JOIN JDEWorkOrders jw (NOLOCK) ON b.JDEWorkOrderId = jw.JDEWorkOrderId
  LEFT JOIN WorkOrders w (NOLOCK) on jw.WorkOrderNumber = w.WorkOrderNum
  LEFT JOIN PFTConfig PC ON PO.PFTConfigId = PC.PFTConfigId
  WHERE a.AssetRepairTrackId = @AssetRepairTrackId
  
  ORDER BY CASE WHEN PFTType = 2 THEN 1 
				WHEN PFTType = 1 THEN 2 
				ELSE PFTType 
			END, PO.DateAdded

	Declare @assetNumber VARCHAR(10)
	SELECT @assetNumber = AssetNumber FROM AssetRepairTrack (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId

	-- Unplanned Section
	SELECT * 
	FROM JDEWorkOrders jw (NOLOCK)
	LEFT JOIN PFTWO p (NOLOCK) on jw.WorkOrderNumber = p.JDEWorkOrderNum and p.JDEWorkOrderNum IS NULL
	WHERE jw.AssetItemNumber = @assetNumber
		AND jw.WorkOrderStatusCode not in('ET','EU','EV','EW','EX','EZ') -- Open work order
		AND (CASE WHEN jw.AssetRepairTrackId IS NOT NULL AND PlannedWOType != '1' THEN 1 
				WHEN jw.AssetRepairTrackId IS NULL AND PlannedWOType = '1' THEN 1 
				WHEN jw.AssetRepairTrackId IS NULL AND PlannedWOType IS NULL THEN 1
			END) = 1
		AND OrderType != 'WM-6'
END


