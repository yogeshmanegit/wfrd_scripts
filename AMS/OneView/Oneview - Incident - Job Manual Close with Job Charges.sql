-- cd /cygdrive/c/cms

use oneview;

--select *
--from [dbo].[TMPSOADTPipelineMessageProcessing] tpmp
--join job j on tpmp.jobid = j.jobid and j.jobid = '4BEFE597-E09B-4137-BD2E-E95D759AB25C'

select serviceOrder, OrderNumber, 'php reconcileJobCharges.php PROD ' + CONVERT(VARCHAR(10),OrderNumber) + ' > "script/'+CONVERT(VARCHAR(10),OrderNumber)+'.sql"'
from (
select OrderNumber, serviceOrder, MAX(billdate) [BillDate]
from job j
join [dbo].[TMPSOADTPipelineMessages] t on j.financialSystemID = CONVERT(varchar(10),OrderNumber)
where --(ordernumber = '15017792' or jobnumber = '15017792') and 
YEAR(scheduledStartDateTime) >= 2022 AND jobStatusID = 10
AND TransactionName = 'DT-INVOICE' and (serialnumber is null or serialnumber = '')
group by OrderNumber, serviceOrder
) A
where BillDate >= '2023-09-01'
--and serviceOrder	='1705-344143829'


select COUNT(*)
from (
select OrderNumber, serviceOrder, MAX(billdate) [BillDate]
from job j
join [dbo].[TMPSOADTPipelineMessages] t on j.financialSystemID = CONVERT(varchar(10),OrderNumber)
where --(ordernumber = '15069984' or jobnumber = '15069984') and 
YEAR(scheduledStartDateTime) >= 2022 AND jobStatusID = 10
AND TransactionName = 'DT-INVOICE' and (serialnumber is null or serialnumber = '')
group by OrderNumber, serviceOrder
) A
where BillDate >= '2023-09-01'