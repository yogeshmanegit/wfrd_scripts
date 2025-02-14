SELECT
	d.DispatchNumber,
	ISNULL(dii.SerialNum, fa.SerialNum) [SerialNum],
	dii.Description, 
	b.BranchPlant + ' - ' + b.CompanyName [BranchPlantName],
	fa.ToolCode,
	fa.EquipmentStatus,
	CASE WHEN a.AssetRepairTrackId IS NOT NULL THEN 'AIRT' END [MaintenanceType],
	jw.WorkOrderNumber [JDEWorkOrderNumber],
	jw.WorkOrderStatus [JDEWorkOrderStatus],

	CONVERT(VARCHAR(50), CASE WHEN a.AssetRepairTrackId IS NOT NULL THEN a.ARTNumber END) [MaintenanceFormNumber],
	CONVERT(VARCHAR(36), CASE WHEN a.AssetRepairTrackId IS NOT NULL THEN a.AssetRepairTrackId END) [MaintenanceFormId],
	CASE WHEN a.AssetRepairTrackId IS NOT NULL THEN
		CASE WHEN a.Status = 'Closed' THEN 'Closed'
			 WHEN sr.PFTWOId IS NOT NULL THEN 'Service & Repair'
			 WHEN ad.Disposition = 'Approved' THEN 'Disposition Complete'
			 WHEN ti.Active = 1	THEN 'Waiting Disposition'
					ELSE 'Test & Inspection'
		END
	END [MaintenanceFormStatus],
	fa.IsAsset
FROM Dispatches d (NOLOCK)
JOIN DispatchInstances di (NOLOCK) on di.DispatchId = d.DispatchId
JOIN DispatchInstanceItems dii (NOLOCK) on dii.DispatchInstanceId = di.DispatchInstanceId
JOIN BranchPlants b (NOLOCK) ON b.BranchPlant = d.BranchPlant
LEFT JOIN vwFixedAssetsSearch fa (NOLOCK) ON fa.AssetNumber = dii.AssetNumber
LEFT JOIN Jobs j (NOLOCK) ON j.DispatchNumber = d.DispatchNumber

------- AIRT Joins
LEFT JOIN AssetRepairTrack a (NOLOCK) ON a.JobId = j.JobId and a.FixedAssetId = fa.FixedAssetId
LEFT JOIN ARTDispositions ad (NOLOCK) ON ad.AssetRepairTrackId = a.AssetRepairTrackId
LEFT JOIN PFTWO ti (NOLOCK) ON ti.PFTWOId = a.ITPFTWOId
LEFT JOIN PFTWO sr (NOLOCK) ON sr.PFTWOId = a.SRPFTWOId
LEFT JOIN JDEWorkOrders jw (NOLOCK) ON jw.WorkOrderNumber = sr.JDEWorkOrderNum


WHERE di.ShipType = 'DT-RETURN' AND d.DispatchNumber ='11074036'
ORDER BY d.DispatchNumber, ISNULL(dii.SerialNum, fa.SerialNum)