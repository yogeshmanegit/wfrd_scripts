DECLARE @Branchplant int 
SELECT @branchplant = '115295'

select 
'=hyperlink("http://dsmyadvisor/CBM/EditAIRT.aspx?id='+cast(a.assetrepairtrackid as varchar(50))+'","'+a.ARTNumber+'")' [AIRT #], 
isnull(convert(varchar(10),a.dateadded,101),'') [AIRT Open Date], 
a.FromBranchPlant [From Branch], 
a.ShipToBranchPlant [ShipTo Branch], 
f.serialnum, 
f.RNItemNum, 
i.descshort, 
i.toolcode, 
f.branchplant [Asset's Current Branch Plant], 
isnull(j.WorkOrderNumber,'') as [JDE WO #], 
isnull(j.WorkOrderStatusCode, '') as [JDE WO Status], 
isnull(convert(varchar(10),j.dateadded,101),'') [JDE WO Create Date], 
isnull(convert(varchar(10),j.LastUpdatedDate,101),'') [WO Last updated date], 
isnull(j.EstimatedAmount/100,'') [Estimated Total], 
isnull(j.ActaulMiscCostInUSD,'') [Total WO Cost in USD], 
isnull(w.WorkOrderNum,'') [MyAdvisor WO Number], 
isnull(convert(varchar(10),mr1.DateMRCompleted,101),'') [DateFirstMaterialRequestCompleted], 
isnull(convert(varchar(10),pt2.DateReceived,101),'') [Date Received in Branchplant], 
isnull(j.CustomerNumber,'') [Bill to location] 
/*KPIs*/ 
,isnull(convert(varchar(10),Datediff(dd,a.dateadded ,getdate()),101),'')as "Age of AIRT" 
,isnull(convert(varchar(10),Datediff(dd,pt2.DateReceived ,j.DateAdded),101),'')as "Days After Receipt WO was created" 
,isnull(convert(varchar(10),Datediff(dd,j.dateadded ,mr1.DateMRCompleted),101),'')as "Days to complete first MR" 
,isnull(convert(varchar(10),Datediff(dd,j.dateadded ,getdate()),101),'')as "Age of JDE WO" 
,isnull(convert(varchar(10),Datediff(dd,pt2.DateReceived ,getdate()),101),'')as "Age since receipt" 
from assetrepairtrack a 
join fixedassets f on f.FixedAssetId = a.fixedassetid 
join itemnums i on i.ItemNum = f.RNItemNum 
left join pftwo p1 on p1.PFTWOId = a.SRPFTWOId 
left join workorders w on w.WorkOrderId = p1.WorkOrderId 
left join JDEWorkOrders j on j.WorkOrderNumber = w.JDEWorkOrderNum 
left join --Getting Date Completed for First Material Request 
( 
select workorderid, min(datelastedit) [DateMRCompleted] 
from WorkOrderMaterialRequests mr 
where status = 'completed' 
group by workorderid 
) MR1 on mr1.WorkOrderId = w.WorkOrderId 
left join --Getting Date Received in Ship to branch if date is after AIRT create date 
( 
Select MAX(pd2.dateadded) as [DateReceived],ReceivingLocation,pd2.FixedAssetId 
from parttransferdtl pd2 
where source = 'IT' and Dest = 'AV' 
group by ReceivingLocation,fixedassetid 
) PT2 on pt2.ReceivingLocation = a.ShipToBranchPlant and f.FixedAssetId = pt2.FixedAssetId and pt2.DateReceived > a.DateAdded 

Where a.ShipToBranchPlant = @branchplant and a.Status= 'open'
