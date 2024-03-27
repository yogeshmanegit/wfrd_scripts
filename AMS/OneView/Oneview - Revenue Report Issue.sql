select 		
	'UPDATE JobCharges SET Total = ' + CONVERT(varchar(100), (nativeItemPrice/CurrencyRate) * itemQuantity) 
		+ ', itemPrice = ' + CONVERT(varchar(100), (nativeItemPrice/CurrencyRate)) 
		+ ', nativeItemPrice = ' + CONVERT(varchar(100), nativeItemPrice)
		+ ', nativeTotal = ' + CONVERT(varchar(100), nativeTotal)
		+ 'WHERE JobChargeId  = '''+ CONVERT(varchar(50), jobChargeID) + ''''
		,
	volbp.name as BranchPlantName,	
	vold.name as DistrictName, 	
	vola.name as AreaName,	
	volc.name as CountryName, 	
	volsr.name as SubRegionName, 	
	volr.name as RegionName,	
	ServiceOrder,	
	[ServiceGroupName],	
	Currency,
	ActualCurrencyRate,
	[CurrencyRate],
	itemQuantity,
	itemPrice,
	nativeItemPrice,	
	[Discount],
	Total,	
	nativeTotal,	
	CalculatedTotal,	
	JobChargeId,
	jobID,
	dateSubmitted
FROM 		
(		
	SELECT j.jobID, 	
		j.serviceOrder, 
		j.operationalLocationID, 
		j.scheduledStartDateTime, 
		jc.jobChargeID, 
		g.name [ServiceGroupName],
		j.actualCurrencyRate,
		cur.rate [CurrencyRate],
		jc.itemQuantity,
		jc.itemPrice,
		jc.nativeItemPrice,
		ISNULL(discount,0) [Discount],
		jc.total,
		jc.nativeTotal,
		(jc.itemPrice * jc.itemQuantity) - (jc.itemPrice * jc.itemQuantity * ISNULL(discount,0)) [CalculatedTotal], 
		c.code [Currency],
		j.dateSubmitted
	FROM dbo.Job j	(NOLOCK)
	JOIN dbo.JobActualServices (NOLOCK) AS jas ON jas.jobID = j.jobID	
	JOIN dbo.JobCharges (NOLOCK) AS jc ON jas.jobActualServiceID = jc.jobActualServiceID AND (jc.deleted IS NULL OR jc.deleted = 0)	
	JOIN ServiceGroup g (NOLOCK) on jas.serviceGroupID = g.id	
		
	-- US pricebook changes	
	JOIN Pricebook pb ON j.financialSystemPriceBookID = pb.id	
	join CurrencyRate cur on pb.currencyRateID = cur.currencyRateID	
	JOIN Currency c on cur.currencyID = c.currencyID --and c.code ='USD' -- USD only	
		
	WHERE YEAR(j.scheduledStartDateTime) >= 2022 	
		AND (jas.performed = 1) AND (jas.deleted IS NULL OR jas.deleted = 0)
		--AND (((jc.itemPrice * jc.itemQuantity) - (jc.itemPrice * jc.itemQuantity * ISNULL(discount,0))) - jc.total) > 1
) j		
LEFT JOIN OperationalLocation l on l.gwis_locationid = j.operationalLocationID 		
LEFT join vOperationalTree (NOLOCK) volbp on j.operationalLocationID = volbp.GWIS_LocationID and volbp.lvl=5		
LEFT join vOperationalTree (NOLOCK) vold on volbp.parent = vold.gwis_locationid and vold.lvl=4		
LEFT join vOperationalTree (NOLOCK) vola on vold.parent = vola.gwis_locationid and vola.lvl=3		
LEFT join vOperationalTree (NOLOCK) volc on vola.parent = volc.gwis_locationid and volc.lvl=2		
LEFT join vOperationalTree (NOLOCK) volsr on volc.parent = volsr.gwis_locationid and volsr.lvl=1		
LEFT join vOperationalTree (NOLOCK) volr on volsr.parent = volr.gwis_locationid and volr.lvl=0		
where 1 = 1
and Currency != 'USD'
--AND Discount != 1
AND total > 100000
order by volc.name