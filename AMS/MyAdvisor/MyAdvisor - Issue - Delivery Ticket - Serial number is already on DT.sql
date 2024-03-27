SELECT * FROM 
(select d.DispatchNumber, 
di.ShipType,
di.SequenceNum,
--CASE WHEN ShipType = 'DT-SEQ-ADD' THEN di.DateShipped ELSE dii.DateReturned END [Date],
--Dii.DateAdded,
CASE WHEN ShipType = 'DT-SEQ-ADD' THEN di.DateShipped 
	ELSE DATEADD(Minute, datepart(MINUTE, dii.DateAdded), 
		 DATEADD(HOUR, datepart(hh, dii.DateAdded), 
		 CONVERT(datetime, CONVERT(varchar(10),dii.DateReturned, 103), 103))) END [DateOfTransaction]
from Dispatches d
Join DispatchInstances di on d.DispatchId = di.DispatchId --and d.DispatchNumber = 855
Join DispatchInstanceItems dii on di.DispatchInstanceId = dii.DispatchInstanceId
where SerialNum ='28010' and ISNULL(dii.ErrorMessage, '') = ''
) A order by DateOfTransaction DESC