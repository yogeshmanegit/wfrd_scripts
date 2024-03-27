SELECT 			
	j.serviceOrder,
	j.jobID,
	volbp.name as BranchPlantName,		
	vold.name as DistrictName, 		
	vola.name as AreaName,		
	volc.name as CountryName, 		
	volsr.name as SubRegionName, 		
	volr.name as RegionName
FROM dbo.Job j		
JOIN OperationalLocation l on l.gwis_locationid = j.operationalLocationID 				
LEFT join vOperationalTree volbp on j.operationalLocationID = volbp.GWIS_LocationID and volbp.lvl=5			
LEFT join vOperationalTree vold on volbp.parent = vold.gwis_locationid and vold.lvl=4			
LEFT join vOperationalTree vola on vold.parent = vola.gwis_locationid and vola.lvl=3			
LEFT join vOperationalTree volc on vola.parent = volc.gwis_locationid and volc.lvl=2			
LEFT join vOperationalTree volsr on volc.parent = volsr.gwis_locationid and volsr.lvl=1			
LEFT join vOperationalTree volr on volsr.parent = volr.gwis_locationid and volr.lvl=0			
where serviceOrder ='7110-332294585'
ORDER BY volr.name, volsr.name, vola.name, vold.name