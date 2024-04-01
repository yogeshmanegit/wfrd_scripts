use aesops;

select d.DispatchNumber, 
		dii.FixedAssetId, 
		di.ShipType, 
		di.dateadded, 
		case when shiptype = 'DT-SEQ-ADD' then di.DateShipped else dii.DateReturned  end [DateOfTransaction],
		dii.SerialNum,
		dii.ItemNum
from Dispatches d
join DispatchInstances di on d.DispatchId = di.DispatchId
join DispatchInstanceItems dii on dii.DispatchInstanceId = di.DispatchInstanceId
where 1 = 1 
AND ISNULL(dii.ErrorMessage,'') =''
and SerialNum ='16114283-1' 
order by 5 desc

--UPDATE dii
--SET dii.FixedAssetId = f.FixedAssetId
--from Dispatches d
--join DispatchInstances di on d.DispatchId = di.DispatchId
--join DispatchInstanceItems dii on dii.DispatchInstanceId = di.DispatchInstanceId
--join FixedAssets f on f.AssetNumber = dii.AssetNumber
--where 1 = 1 
--AND ISNULL(dii.ErrorMessage,'') =''
--AND dii.FixedAssetId IS NULL
--AND dii.SerialNum ='BTR491' 