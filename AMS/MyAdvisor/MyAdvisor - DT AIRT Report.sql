DECLARE @TempDT TABLE (	
	   Id int identity(1,1),
       DispatchNumber int,	
       AssetNumber VARCHAR(15),
       SerialNum varchar(50),	
       ItemNum varchar(30),	
       RNItemNum varchar(30),	
       DateShipped DateTime,	
       DateShippedNext DateTime,	
       DateReturned DateTime	
)	
	
	
INSERT INTO @TempDT	
SELECT * FROM (SELECT DISTINCT d.DispatchNumber, dii.AssetNumber, dii.SerialNum, dii.ItemNum, dii.RNItemNum, di.DateShipped, null [DateShippedNext], 
	NULL [DateReturned]
      from DispatchInstanceItems dii (NOLOCK)	
      inner join DispatchInstances di (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId	
      inner join Dispatches d (NOLOCK) on d.DispatchId = di.DispatchId	
      left join ItemNums i (NOLOCK) on i.ItemNum = dii.ItemNum       	
      left join BranchPlants b (NOLOCK) on b.BranchPlant = d.BranchPlant	
	  join fixedassets f on f.AssetNumber = dii.AssetNumber							-----Ken
	  join glcodes g on g.GLCode = f.ProductLineCode and GLProductLineId = '5'		-----Ken
	  join PartDescPFTConfigs pc on pc.ItemNum = f.InventoryItemNum					-----Ken
	  
      where di.ShipType = 'DT-SEQ-ADD' AND di.DateShipped >= '1-1-2020' and ISNULL(dii.ErrorMessage,'') = ''
	   and f.assetnumber = '1201397'
		--AND dii.SerialNum='54043' and dii.ItemNum='1118045'	
		--AND b.IsNonLiveLocation = 1 and b.BranchPlant IN ('91170', '169980','126188') --and SerialNum ='16917'
) A
order by DispatchNumber, a.SerialNum, DateShipped ASC

	---14311707
UPDATE t	
SET t.DateShippedNext = (SELECT MIN(di.DateShipped)
							FROM DispatchInstanceItems dii (NOLOCK) 
							INNER JOIN DispatchInstances di (NOLOCK) on dii.DispatchInstanceId = di.DispatchInstanceId
						WHERE  dii.AssetNumber = t.AssetNumber 
								AND di.DateShipped > t.DateShipped 
								AND di.ShipType = 'DT-SEQ-ADD' 
								AND ISNULL(dii.ErrorMessage,'') = ''
						)
FROM @TempDT t	

UPDATE t	
SET t.DateReturned = CONVERT(datetime, CONVERT(varchar(11),dii.DateReturned, 109) 
						+ SUBSTRING(CONVERT(varchar(MAX), dii.DateReturned,109),12, 100), 109)
FROM @TempDT t	
inner join Dispatches d (NOLOCK) on t.DispatchNumber = d.DispatchNumber	
inner join DispatchInstances di (NOLOCK) on d.DispatchId = di.DispatchId 	
inner join DispatchInstanceItems dii (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId AND t.SerialNum = dii.SerialNum 
		AND t.ItemNum = dii.ItemNum	
WHERE di.ShipType = 'DT-RETURN' AND (
-- this is to add time from dateadded column to dateshipped column
CONVERT(datetime, CONVERT(varchar(11),di.DateShipped, 109) + SUBSTRING(CONVERT(varchar(MAX), di.DateAdded,109),12, 100), 109)
 >= t.DateShipped AND (CONVERT(datetime, CONVERT(varchar(11),dii.DateReturned, 109) + SUBSTRING(CONVERT(varchar(MAX), dii.DateReturned,109),12, 100), 109) <= t.DateShippedNext 
 or  (t.DateShippedNext IS NULL and dii.DateReturned is not null)) )	
	and ISNULL(dii.ErrorMessage,'') = ''
/*	
SELECT DispatchNumber, SerialNum, ItemNum, ShipType, DateShipped  FROM Dispatches d (NOLOCK) 	
inner join DispatchInstances di (NOLOCK) on d.DispatchId = di.DispatchId 	
inner join DispatchInstanceItems dii (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId	
WHERE SerialNum='1153' and ItemNum='1118727'	
ORDER BY DateShipped	
*/	

SELECT Id [Row_Number], xx.DispatchNumber, 
(select TOP 1 DateAdded from AssetRepairTrack a 
WHERE AssetNumber = xx.AssetNumber AND CONVERT(DATE, a.DateAdded) between ISNULL(Datereturned, DateShipped) and ISNULL(DateShippedNext,GETDATE())) [AIRT #], 
AssetNumber, SerialNum, xx.ItemNum, xx.RNItemNum, DateShipped,	
[DateReturned],	
[DateShippedNext],	
	case 
	when xx.DateShipped IS not null and xx.DateReturned IS null then DATEDIFF(day, ISNULL(DateShipped,GETDATE()), GETDATE())
	else DATEDIFF(day, ISNULL(DateShipped,DateReturned), DateReturned) end [Duration]
,j.jobnumber, c.customername, i.ToolCode, i.ToolPanel, i.DescShort,i.ItemNum3

FROM @TempDT xx	
left join dispatches d  (NOLOCK) on d.dispatchnumber = xx.dispatchnumber	
left join ItemNums i  (NOLOCK) on i.ItemNum = xx.ItemNum	
left join JobS j  (NOLOCK) on j.dispatchnumber = d.dispatchnumber	
left join Customers c  (NOLOCK) on c.CustomerId = j.CustomerId	
--ORDER BY Id
WHERE xx.assetnumber = 1201397