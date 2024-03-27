
DECLARE @TempDT TABLE(
       DispatchNumber int,
       SerialNum varchar(20),
       ItemNum varchar(30),
       DateShipped DateTime,
          DateShippedNext DateTime,
       DateReturn DateTime
)
	
	
INSERT INTO @TempDT
SELECT DISTINCT d.DispatchNumber, SerialNum, dii.ItemNum, CONVERT(DATETIME, CONVERT(NCHAR(10), di.DateShipped, 103), 103), null, NULL
      from DispatchInstanceItems dii (NOLOCK)
      inner join DispatchInstances di (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId
      inner join Dispatches d (NOLOCK) on d.DispatchId = di.DispatchId
      left join ItemNums i (NOLOCK) on i.ItemNum = dii.ItemNum       
      left join BranchPlants b (NOLOCK) on b.BranchPlant = d.BranchPlant
      where di.ShipType = 'DT-SEQ-ADD' and b.Region = 'cis' and SerialNum is not null
	
UPDATE t	
SET t.DateShippedNext = (SELECT MIN(CONVERT(DATETIME, CONVERT(NCHAR(10), di.DateShipped, 103), 103))
							FROM Dispatches d (NOLOCK)
							inner join DispatchInstances di (NOLOCK) on d.DispatchId = di.DispatchId 
							inner join DispatchInstanceItems dii (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId
							WHERE t.SerialNum = dii.SerialNum AND t.ItemNum = dii.ItemNum AND t.DateShipped < CONVERT(DATETIME, CONVERT(NCHAR(10), di.DateShipped, 103), 103)
							AND di.ShipType = 'DT-SEQ-ADD'
						)

FROM @TempDT t
 	
UPDATE t	
SET t.DateReturn = CONVERT(DATETIME, CONVERT(NCHAR(10), di.DateShipped, 103), 103)
FROM @TempDT t
inner join Dispatches d (NOLOCK) on t.DispatchNumber = d.DispatchNumber
inner join DispatchInstances di (NOLOCK) on d.DispatchId = di.DispatchId 
inner join DispatchInstanceItems dii (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId AND t.SerialNum = dii.SerialNum AND t.ItemNum = dii.ItemNum
WHERE di.ShipType = 'DT-RETURN' AND (di.DateShipped >= t.DateShipped AND (di.DateShipped <= t.DateShippedNext or  (t.DateShippedNext IS NULL and di.DateShipped is not null)) )

/*	
SELECT DispatchNumber, SerialNum, ItemNum, ShipType, DateShipped  
FROM Dispatches d (NOLOCK) 
inner join DispatchInstances di (NOLOCK) on d.DispatchId = di.DispatchId 
inner join DispatchInstanceItems dii (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId
WHERE SerialNum='1153' and ItemNum='1118727'
ORDER BY DateShipped
*/

SELECT xx.DispatchNumber, SerialNum, xx.ItemNum, DateShipped, ISNULL(convert(varchar(50), DateShippedNext,101),'') as [DateShippedNext]
FROM @TempDT xx
left join dispatches d (NOLOCK) on d.dispatchnumber = xx.dispatchnumber
left join ItemNums i (NOLOCK) on i.ItemNum = xx.ItemNum
left join JobS j (NOLOCK) on j.dispatchnumber = d.dispatchnumber
left join Customers c (NOLOCK) on c.CustomerId = j.CustomerId
WHERE DateShippedNext IS NOT NULL AND DateReturn IS NULL



SELECT DispatchNumber, COUNT(ShipType) 
FROM 
(
	SELECT DispatchNumber, ShipType  
	FROM Dispatches d (NOLOCK) 
	inner join DispatchInstances di (NOLOCK) on d.DispatchId = di.DispatchId 
	inner join DispatchInstanceItems dii (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId
	GROUP BY DispatchNumber, ShipType
) A

GROUP BY DispatchNumber
HAVING COUNT(*) > 2