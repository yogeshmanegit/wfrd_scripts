DECLARE @jobId uniqueidentifier 
select @jobId = jobID from Job WHERE serviceOrder ='2595-277348699'

DECLARE @bookPriceCurrencyRate float

SELECT @bookPriceCurrencyRate = cur.Rate 
from Pricebook pb 
JOIN Job j on j.financialSystemPriceBookID = pb.id
join CurrencyRate cur on pb.currencyRateID = cur.currencyRateID
WHERE j.jobID = @jobId

--select @bookPriceCurrencyRate

select 
jc.jobChargeID [Id]
, js.system_code [PartNumber]
, ISNULL(s.alternateName, s.name) [Name]
, CASE WHEN (SELECT COUNT(*) 
				FROM JobOperations jo 
				JOIN JobOperationTypes jot on jo.jobOperationTypeID= jot.jobOperationTypeID
				WHERE jo.jobOperationID = jc.jobOperationID 
					AND jot.jobTicketJobOperationCategoryID IN (1,2)
			) > 1 THEN 'Service' END [Type]
, jc.nativeItemPrice [ItemPrice]
, CASE WHEN js.id IS NULL THEN js.price * @bookPriceCurrencyRate 
		ELSE COALESCE (adjustedNativeItemPrice, nativeItemPrice, 0) * (CASE WHEN jc.parentJobChargeID iS NULL THEN 1 ELSE 100 END) 
  END AS [BookPrice]
, ISNULL(jc.itemQuantity,0) as [Quantity]
, ISNULL(jc.discount, 0) * 100 [Discount]
, jc.nativeTotal [Total]
, jc.Comments
, jc.jobOperationID [OperationId]
, jc.jobActualServiceID [ActualServiceId]
, jc.parentJobChargeID [ParentChargeId]
, jc.SortOrder
, ps.Name as PricingStyle
, PricingStyleId = js.pricing_style
, jc.serviceDetailID [ServiceDetailId]
, CASE WHEN pb.discountable = 1 AND js.discountable = 1 THEN 1 ELSE 0 END [Is Discountable]
, CASE WHEN js.isBonusable = 1 THEN 1 ELSE 0 END AS [Is Bonusable]
, ROUND((jc.nativeItemPrice * ISNULL(jc.itemQuantity,0)) - (jc.nativeItemPrice * ISNULL(jc.itemQuantity,0) * ISNULL(jc.discount, 0)) , 2) as [InvoicableAmount]
, ROUND(CASE WHEN js.isBonusable = 1 THEN (jc.nativeItemPrice * ISNULL(jc.itemQuantity,0)) 
		- (jc.nativeItemPrice * ISNULL(jc.itemQuantity,0) * ISNULL(jc.discount, 0)) 
		ELSE 0 END, 2) as [BonusableAmount]

from JobCharges jc
JOIN Job j on j.jobID = jc.jobID
JOIN ServiceDetails js on js.id = jc.serviceDetailID
LEFT JOIN Service s ON s.id = js.service_id
LEFT JOIN JobActualServices jas on jc.jobActualServiceID = jas.jobActualServiceID
Join Pricebook pb on j.financialSystemPriceBookID = pb.id
LEFT join PricingStyle ps on ps.id = js.pricing_style
where jc.jobID = @jobId 
--ISNULL(jc.itemQuantity,0) = -1
and ISNULL(jc.deleted,0) != 1
order by jc.SortOrder

select jc.*, jb.*
FROM            dbo.CADWirelineInvoiced AS cwi INNER JOIN
                         dbo.Job ON LTRIM(RTRIM(CAST(cwi.[Order Number] AS nvarchar(15)))) = LTRIM(RTRIM(dbo.Job.financialSystemID)) INNER JOIN
                         dbo.JobCrew AS jc ON dbo.Job.jobID = jc.jobID INNER JOIN
                         dbo.JobBonus AS jb ON jc.jobCrewID = jb.jobCrewID AND jb.jobBonusStatusID = 3 AND jb.deleted IS NULL
where job.jobID = @jobId

--select * from JobCrew jc where jc.jobID = @jobId --and employeeID= '2399' 
--order by employeeID

--select * from JobCharges jc where jc.jobID = @jobId

--UPDATE JobBonus
--SET deleted = 1
--WHERE jobBonusID in (
--'B24B059C-1DE7-4D49-8F8D-9FF3E8FE41AB',
----'059C4904-BB4C-412D-B0BC-9A925EC4916B',
--'372B3097-702E-4BC8-9C9B-C9FD5F568F1E',
--'492C23F9-A0BC-4BF7-A3DB-D55C9131DE99'
--)