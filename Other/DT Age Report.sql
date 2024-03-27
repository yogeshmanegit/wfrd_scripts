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
SELECT top 10 * FROM (SELECT DISTINCT d.DispatchNumber, AssetNumber, SerialNum, dii.ItemNum, dii.RNItemNum, di.DateShipped, null [DateShippedNext], 
	NULL [DateReturned]
      from DispatchInstanceItems dii (NOLOCK)	
      inner join DispatchInstances di (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId	
      inner join Dispatches d (NOLOCK) on d.DispatchId = di.DispatchId	
      left join ItemNums i (NOLOCK) on i.ItemNum = dii.ItemNum       	
      left join BranchPlants b (NOLOCK) on b.BranchPlant = d.BranchPlant	
      where di.ShipType = 'DT-SEQ-ADD' AND di.DateShipped >= '1-1-2017' and ISNULL(dii.ErrorMessage,'') = ''
		--AND dii.SerialNum='54043' and dii.ItemNum='1118045'	
		AND b.IsNonLiveLocation = 1 and b.BranchPlant IN ('91170', '169980','126188') --and SerialNum ='16917'
) A
order by DispatchNumber, SerialNum, DateShipped ASC

	
UPDATE t	
SET t.DateShippedNext = di.DateShipped	
FROM @TempDT t	
inner join Dispatches d (NOLOCK) on t.DispatchNumber = d.DispatchNumber	
inner join DispatchInstances di (NOLOCK) on d.DispatchId = di.DispatchId 	
inner join DispatchInstanceItems dii (NOLOCK) on di.dispatchinstanceid = dii.DispatchInstanceId AND t.SerialNum = dii.SerialNum AND t.ItemNum = dii.ItemNum and ISNULL(dii.ErrorMessage,'') = ''
--JOIN @TempDT t1 on t.DispatchNumber = t1.DispatchNumber and t.SerialNum = t1.SerialNum and t.ItemNum = t1.ItemNum and ISNULL(dii.ErrorMessage,'') = ''
WHERE di.DateShipped > t.DateShipped
	

UPDATE t	
SET t.DateReturned = CONVERT(datetime, CONVERT(varchar(11),dii.DateReturned, 109) + SUBSTRING(CONVERT(varchar(MAX), dii.DateReturned,109),12, 100), 109)
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
(select TOP 1 ARTNumber from AssetRepairTrack a WHERE AssetNumber = xx.AssetNumber AND a.DateAdded between DateShipped and DateReturned) [AIRT #], 
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
ORDER BY Id
--WHERE xx.SerialNum='54043' and xx.ItemNum='1118045'	