
SELECT 1 AS TAG
       ,NULL AS PARENT
	   ,reg.[RegionDesc] AS [Region!1!Region]
	   ,reg.[Region] AS [Region!1!RegionCode]
	   ,reg.[RegionId] AS [Region!1!RegionId]
	   ,NULL AS  [Country!2!Country]
	   ,NULL AS  [Country!2!CountryCode]
	   ,NULL AS  [Country!2!CountryId]
	   ,NULL AS  [BranchPlant!3!BranchPlant]
	   ,NULL AS  [BranchPlant!3!BranchPlantId]
	   ,NULL AS  [BranchPlant!3!BranchPlantName]
	   ,NULL AS  [BranchPlant!3!RelBaseCode]
	   FROM [Regions] AS reg

	   UNION ALL

SELECT 2 AS TAG
       ,1 AS PARENT
	   ,reg.[RegionDesc] AS [Region!1!Region]
	   ,reg.[Region] AS [Region!1!RegionCode]
	   ,reg.[RegionId] AS [Region!1!RegionId]
	   ,ctry.[CountryDesc] AS  [Country!2!Country]
	   ,ctry.[Country] AS  [Country!2!CountryCode]
	   ,ctry.[CountryId] AS  [Country!2!CountryId]
	   ,NULL AS  [BranchPlant!3!BranchPlant]
	   ,NULL AS  [BranchPlant!3!BranchPlantId]
	   ,NULL AS  [BranchPlant!3!BranchPlantName]
	   ,NULL AS  [BranchPlant!3!RelBaseCode]
	   FROM [Countries] AS ctry, [Regions] AS reg
	   WHERE ctry.[RegionCode] = reg.[Region]

	   UNION ALL

SELECT 3 AS TAG
       ,2 AS PARENT
	   ,reg.[RegionDesc] AS [Region!1!Region]
	   ,reg.[Region] AS [Region!1!RegionCode]
	   ,reg.[RegionId] AS [Region!1!RegionId]
	   ,ctry.CountryDesc AS  [Country!2!Country]
	   ,ctry.Country AS  [Country!2!CountryCode]
	   ,ctry.CountryId AS  [Country!2!CountryId]
	   ,plant.[BranchPlant] AS  [BranchPlant!3!BranchPlant]
	   ,plant.[BranchPlantId] AS  [BranchPlant!3!BranchPlantId]
	   ,plant.[MCDL01] AS  [BranchPlant!3!BranchPlantName]
	   ,plant.[RelBaseCode] AS  [BranchPlant!3!RelBaseCode]
	   FROM [Countries] AS ctry, [Regions] AS reg, [BranchPlants] AS plant
	   WHERE ctry.[RegionCode] = reg.[Region]
	   AND plant.[Country] = ctry.[Country]
	   
	   ORDER BY [Region!1!RegionCode], [Country!2!CountryCode], [BranchPlant!3!BranchPlant]

FOR XML EXPLICIT, ROOT ('Locations')