select 		
	'UPDATE JobCharges SET Total = ' + CONVERT(varchar(100), cast(CalculatedTotal as decimal(10,2))) +', nativeTotal = ' + CONVERT(varchar(100), cast(CalculatedTotal as decimal(10,2))) +' WHERE JobChargeId = ''' + CONVERT(varchar(100), jobChargeID) + ''';' [Script],	
	volbp.name as BranchPlantName,	
	vold.name as DistrictName, 	
	vola.name as AreaName,	
	volc.name as CountryName, 	
	volsr.name as SubRegionName, 	
	volr.name as RegionName,	
	ServiceOrder,	
	[ServiceGroupName],	
	--itemPrice,	
	--nativeItemPrice,	
	Total,	
	CalculatedTotal,	
	nativeTotal,	
	JobChargeId	
FROM 		
(		
	SELECT j.jobID, 	
		j.serviceOrder, 
		j.operationalLocationID, 
		j.scheduledStartDateTime, 
		jc.jobChargeID, 
		g.name [ServiceGroupName],
		(jc.itemPrice * jc.itemQuantity) - (jc.itemPrice * jc.itemQuantity * ISNULL(discount,0)) [CalculatedTotal], 
		jc.total,
		jc.nativeTotal,
		jc.itemPrice,
		jc.nativeItemPrice
	FROM dbo.Job j	
	JOIN dbo.JobActualServices AS jas ON jas.jobID = j.jobID	
	JOIN dbo.JobCharges AS jc ON jas.jobActualServiceID = jc.jobActualServiceID AND (jc.deleted IS NULL OR jc.deleted = 0)	
	JOIN ServiceGroup g on jas.serviceGroupID = g.id	
		
	-- US pricebook changes	
	JOIN Pricebook pb ON j.financialSystemPriceBookID = pb.id	
	join CurrencyRate cur on pb.currencyRateID = cur.currencyRateID	
	JOIN Currency c on cur.currencyID = c.currencyID and c.code ='USD' -- USD only	
		
	WHERE YEAR(j.scheduledStartDateTime) >= 2021 	
		AND (jas.performed = 1) AND (jas.deleted IS NULL OR jas.deleted = 0)
		AND (((jc.itemPrice * jc.itemQuantity) - (jc.itemPrice * jc.itemQuantity * ISNULL(discount,0))) - jc.total) > 1
) j		
LEFT JOIN OperationalLocation l on l.gwis_locationid = j.operationalLocationID 		
LEFT join vOperationalTree volbp on j.operationalLocationID = volbp.GWIS_LocationID and volbp.lvl=5		
LEFT join vOperationalTree vold on volbp.parent = vold.gwis_locationid and vold.lvl=4		
LEFT join vOperationalTree vola on vold.parent = vola.gwis_locationid and vola.lvl=3		
LEFT join vOperationalTree volc on vola.parent = volc.gwis_locationid and volc.lvl=2		
LEFT join vOperationalTree volsr on volc.parent = volsr.gwis_locationid and volsr.lvl=1		
LEFT join vOperationalTree volr on volsr.parent = volr.gwis_locationid and volr.lvl=0		
