SELECT jas.jobID, jas.jobActualServiceID, jc.jobChargeID, g.name [ServiceGroupName],
	jas.serviceGroupID, jot.assetID, jas.renderedByEmployee, jas.renderedByEmployee2, 
	--jc.itemPrice, jc.itemQuantity, jc.total, 
	--jc.adjustedItemPrice, jc.adjustedItemQuantity, jc.adjustedtotal,
	SUM(jc.itemPrice * jc.itemQuantity) [CalcTotal],
	SUM(ISNULL(jc.total,0)) [Total],
	SUM(ISNULL(jc.adjustedItemPrice * jc.adjustedItemQuantity, 0)) [CalcAdjTotal],
	SUM(ISNULL(jc.adjustedtotal,0)) [AdjTotal],
	SUM(CASE WHEN jc.adjustedtotal IS NULL THEN jc.total ELSE jc.adjustedtotal END) AS revenue, jot.jobOperationID, 
	SUM(CASE WHEN jc.adjustednativetotal IS NULL THEN jc.nativetotal ELSE jc.adjustednativetotal END) AS native_revenue
FROM dbo.JobActualServices AS jas
LEFT OUTER JOIN dbo.JobCharges AS jc ON jas.jobActualServiceID = jc.jobActualServiceID AND (jc.deleted IS NULL OR jc.deleted = 0)
INNER JOIN dbo.JobOperationTools AS jot ON jas.jobOperationToolID = jot.jobOperationToolID AND (jot.deleted IS NULL OR jot.deleted = 0) 
LEFT OUTER JOIN dbo.Job ON jas.jobID = dbo.Job.jobID
JOIN OperationalLocation l on l.gwis_locationid = job.operationalLocationID 
JOIN ServiceGroup g on jas.serviceGroupID = g.id
WHERE 1 = 1 
AND job.serviceOrder IN('18546-327748108', '19377-327297147', '19377-327462004', '18546-326200242')
AND (jas.performed = 1) AND (jas.deleted IS NULL OR jas.deleted = 0) AND (job.scheduledStartDateTime >= 2022) AND g.name ='MSD' 
and jas.jobActualServiceID = 'CF911E44-E3D2-4F0F-9FEC-58F36BB40D6A'
GROUP BY jas.jobID, jas.jobActualServiceID,jc.jobChargeID, jas.serviceGroupID, jot.assetID, jas.renderedByEmployee, jas.renderedByEmployee2, jot.jobOperationID, g.name


SELECT jas.jobID, jas.jobActualServiceID, jas.deleted, jc.jobChargeID, g.name [ServiceGroupName],
	jas.serviceGroupID, jot.assetID, jas.renderedByEmployee, jas.renderedByEmployee2, 
	jc.itemPrice, jc.itemQuantity, jc.total, 
	jc.adjustedItemPrice, jc.adjustedItemQuantity, jc.adjustedtotal,
	jc.discount
FROM dbo.JobActualServices AS jas
LEFT OUTER JOIN dbo.JobCharges AS jc ON jas.jobActualServiceID = jc.jobActualServiceID AND (jc.deleted IS NULL OR jc.deleted = 0)
INNER JOIN dbo.JobOperationTools AS jot ON jas.jobOperationToolID = jot.jobOperationToolID AND (jot.deleted IS NULL OR jot.deleted = 0) 
LEFT OUTER JOIN dbo.Job ON jas.jobID = dbo.Job.jobID
JOIN OperationalLocation l on l.gwis_locationid = job.operationalLocationID 
JOIN ServiceGroup g on jas.serviceGroupID = g.id
WHERE 1 = 1 
--AND job.jobID ='C92A7AE6-E854-4090-9166-10E94BE82AAC'
AND job.serviceOrder IN('18546-327748108', '19377-327297147', '19377-327462004', '18546-326200242')
AND (jas.performed = 1) AND (jas.deleted IS NULL OR jas.deleted = 0) AND (job.scheduledStartDateTime >= 2022) 
AND g.name ='MSD'