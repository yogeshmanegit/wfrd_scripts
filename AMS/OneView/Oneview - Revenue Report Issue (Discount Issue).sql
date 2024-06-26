SELECT 			
	volbp.name as BranchPlantName,		
	vold.name as DistrictName, 		
	vola.name as AreaName,		
	volc.name as CountryName, 		
	volsr.name as SubRegionName, 		
	volr.name as RegionName,		
	YEAR(scheduledStartDateTime) [Year],		
	Month(scheduledStartDateTime) [Month],		
	[ServiceGroupName],		
	COUNT(1) [Job Count],		
	SUM(cast(ROUND(revenue, 2) as money)) revenue		
	--SUM(cast(ROUND([Revenue After Discount Removed], 2) as money)) [Revenue After Discount Removed]		
FROM 			
(			
	SELECT 		
		j.serviceOrder [FT #],	
		j.financialSystemID [DT #],	
		j.scheduledStartDateTime,	
		g.name [ServiceGroupName],	
		j.operationalLocationID,	
		SUM(ISNULL((jc.adjustedItemPrice * jc.adjustedItemQuantity) - (jc.adjustedItemPrice * jc.adjustedItemQuantity * ISNULL(adjustedDiscount,0))	
			, (jc.itemPrice * jc.itemQuantity) - (jc.itemPrice * jc.itemQuantity * ISNULL(discount,0)))) [revenue]
		--SUM(ISNULL(jc.adjustedtotal, jc.total) - (ISNULL(jc.adjustedtotal,jc.total) * ISNULL(discount,0))) [Revenue After Discount Removed]	
	FROM dbo.Job j		
	JOIN dbo.JobActualServices AS jas ON jas.jobID = j.jobID		
	JOIN dbo.JobCharges AS jc ON jas.jobActualServiceID = jc.jobActualServiceID AND (jc.deleted IS NULL OR jc.deleted = 0)		
	JOIN ServiceGroup g on jas.serviceGroupID = g.id		
	JOIN OperationalLocation l on l.gwis_locationid = j.operationalLocationID 		
	where YEAR(j.scheduledStartDateTime) = 2021 AND (jas.performed = 1) AND (jas.deleted IS NULL OR jas.deleted = 0) 		
	--AND  j.serviceOrder ='18546-327748108' 		
	GROUP BY j.serviceOrder, j.financialSystemID, j.scheduledStartDateTime, g.name, j.operationalLocationID		
) j			
LEFT join vOperationalTree volbp on j.operationalLocationID = volbp.GWIS_LocationID and volbp.lvl=5			
LEFT join vOperationalTree vold on volbp.parent = vold.gwis_locationid and vold.lvl=4			
LEFT join vOperationalTree vola on vold.parent = vola.gwis_locationid and vola.lvl=3			
LEFT join vOperationalTree volc on vola.parent = volc.gwis_locationid and volc.lvl=2			
LEFT join vOperationalTree volsr on volc.parent = volsr.gwis_locationid and volsr.lvl=1			
LEFT join vOperationalTree volr on volsr.parent = volr.gwis_locationid and volr.lvl=0			
GROUP BY volbp.name,			
	vold.name,		
	vola.name,		
	volc.name,		
	volsr.name,		
	volr.name,		
	YEAR(scheduledStartDateTime),		
	Month(scheduledStartDateTime),		
	[ServiceGroupName]		
ORDER BY volr.name, volsr.name, vola.name, vold.name, [Year], [Month], ServiceGroupName			
