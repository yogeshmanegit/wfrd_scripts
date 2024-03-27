SELECT 
r.WorkOrderNum, 
r.AssetItemNumber,
r.Branch,
r.BusinessUnit,
r.Description,
r.OrderType,
r.PriorityWO,
r.RequestedDate,
r.StartDate,
'1050' [Subsidiary],
r.TransactionDate,
r.TypeWO,
r.UserId,
r.LotNumber,
r.CreatedOn,
h.* 
FROM SOAWorkOrderResponseHeader h 
LEFT JOIN SOAWorkOrderRequest r on r.RequestId =h.RequestId
WHERE ResponseCode NOT IN ('OK', 'BadRequest')
ORDER BY r.CreatedOn DESC

SELECT top 90 TransactionDate, 
	SUM(CASE WHEN ResponseCode ='OK' THEN 1 ELSE 0 END) [Success],
	SUM(CASE WHEN ResponseCode NOT IN ('OK', 'BadRequest') THEN 1 ELSE 0 END) [Failure]
FROM SOAWorkOrderResponseHeader h 
LEFT JOIN SOAWorkOrderRequest r on r.RequestId = h.RequestId
GROUP BY TransactionDate
ORDER BY TransactionDate DESC