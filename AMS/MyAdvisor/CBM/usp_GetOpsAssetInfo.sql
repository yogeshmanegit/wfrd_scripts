USE [AesOps]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetOpsAssetInfo]    Script Date: 6/6/2023 8:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_GetOpsAssetInfo]    
 @xmlData AS XML,  
 @ViewName varchar(50) = NULL  
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
DECLARE @FixedAssetId UNIQUEIDENTIFIER    
--DECLARE @AssetNumber varchar(10)     
    
SELECT @FixedAssetId = T.c.value('(FixedAssetId/text())[1]', 'uniqueidentifier')    
FROM @xmlData.nodes('/Filters') T(c);    
    
--select @AssetNumber = AssetNumber from FixedAssets (NOLOCK)    
--where FixedAssetId = @FixedAssetId     
   
IF (ISNULL(@ViewName,'AssetInfo') = 'AssetInfo')  
BEGIN   
 --- Asset Info Panel ---    
 SELECT  fa.FixedAssetId, fa.SerialNum, fa.LegacySerialNumber, fa.InventoryItemNum, fa.RNItemNum,    
   pfa.SerialNum AS ParentSerialNum,pfa.InventoryItemNum As ParentInventoryItemNum, pfa.RNItemNum AS ParentRNItemNum, pfa.AssetNumber AS ParentAssetNumber,        
   fa.AssetDescription as FixedAssetDescription,    
   i.DescShort as AssetDescription,    
   ri.DescShort as RNAssetDescription,    
   i.DescLong as InventoryDescLong,    
   fa.BranchPlant, fa.Ownership, fa.AssetNumber,    
   fa.ManufacturersSerialNumber,    
   fa.EquipmentStatus, fa.LastStatusChangeDate,    
   fa.PhysicalLocation, fa.CatCode16, fa.Cost, fa.NetBookValue,     
   fa.AccumDepreciation, fa.CurrencyCode, fa.ContractAccount, fa.DateAcquired, fa.LifeMonths,     
   fa.StartDepreciation_Date, fa.NewUsed, fa.Manufacturer, fa.ModelYear, fa.DateDisposed,     
   fa.FiscalYear,fa.LedgerType    
   , CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN    
    (SELECT TOP 1 SendingLocation from PartTransferDtl (NOLOCK) ptd     
  WHERE ptd.FixedAssetId=fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')    
  ORDER BY ptd.DateofTransaction DESC) ELSE NULL    
    END AS SourceBranchPlant    
   , CASE WHEN fa.EquipmentStatus IN ('PT', 'IT') THEN    
    (SELECT TOP 1 ReceivingLocation from PartTransferDtl (NOLOCK) ptd     
  WHERE ptd.FixedAssetId=fa.FixedAssetId AND fa.EquipmentStatus IN ('PT', 'IT')    
  ORDER BY ptd.DateofTransaction DESC) ELSE NULL    
    END AS DestBranchPlant    
   , (SELECT TOP 1 ReceivingLocation FROM PartTransferDtl ptd WITH(NOLOCK)    
  LEFT OUTER JOIN BranchPlants(NOLOCK) ibp ON ibp.BranchPlant = ptd.ReceivingLocation    
  WHERE ptd.FixedAssetId = fa.FixedAssetId AND ibp.IsOperationsBillableLocation = 1     
  ORDER BY ptd.DateofTransaction DESC  
    ) AS LastBillableBranchPlant,    
   ISNULL(ri.ToolPanel, i.ToolPanel) as ToolPanel,     
   ISNULL(ri.ToolCode, i.ToolCode) as ToolCode,     
   ISNULL(ri.ItemNum3, i.ItemNum3) as ItemNum3,     
   ISNULL(ri.PartClassification, i.PartClassification) as PartClassification,    
   i.Size, i.DescShort, i.DescLong, i.Critical, i.ToolPerJob, fa.ThirdItemNumber,    
   fa.FirmwareVersion,    
   fa.MasterFirmwareItemNum,    
   fa.MasterFirmwareRevision,    
   fa.LastComments,    
      
   inbp.HTSUS, inbp.ECCN,    
      
   bp.Country, bp.Region,     
      
   ps.Status AS StatusDesc,    
      
   j.JobNumber, bp.CompanyName as BranchPlantName, j.JobId    
    
 FROM dbo.FixedAssets (NOLOCK) fa    
 LEFT JOIN dbo.ItemNums (NOLOCK) i ON i.ItemNum = fa.InventoryItemNum    
 LEFT JOIN dbo.ItemNums (NOLOCK) ri ON ri.ItemNum = fa.RNItemNum    
 LEFT JOIN dbo.ItemNumBranchPlants (NOLOCK) inbp ON inbp.BranchPlant = fa.BranchPlant AND inbp.ItemNum = fa.InventoryItemNum    
 LEFT JOIN dbo.BranchPlants (NOLOCK) bp ON bp.BranchPlant = fa.BranchPlant    
 LEFT JOIN dbo.PartStatus (NOLOCK) ps ON ps.Code = fa.EquipmentStatus    
 LEFT JOIN dbo.DispatchInstanceItems (NOLOCK) dii ON dii.SerialNum = fa.SerialNum    
 LEFT JOIN dbo.DispatchInstances (NOLOCK) di ON di.DispatchInstanceId = dii.DispatchInstanceId    
 LEFT JOIN dbo.Dispatches (NOLOCK) d ON d.DispatchId = di.DispatchId    
 LEFT JOIN dbo.Jobs (NOLOCK) j ON j.JobId = d.JobId    
 LEFT OUTER JOIN dbo.FixedAssets (NOLOCK) pfa ON pfa.FixedAssetId = fa.ParentFixedAssetId    
 WHERE fa.FixedAssetId=@FixedAssetId    
  
END  
  
--- Event View Grid ---    
IF (ISNULL(@ViewName,'EventView') = 'EventView')  
BEGIN   
  
DECLARE @jobOrDTData TABLE (KeyId uniqueidentifier NOT NULL, JobId uniqueidentifier NOT NULL, JobPFTNum varchar(100) NOT NULL,  
StartDate datetime NULL, PFTType varchar(100) NULL, OperHrs float NULL, CircHrs float NULL,  
DrillHrs float NULL, IncidentNumber varchar (50) NULL, IncidentId uniqueidentifier NULL,  
FieldSummary varchar (5000) NULL, FailureCodes nvarchar(4000) NULL, IsMatch int NULL,  
RecordType varchar (50) NULL, CustomerName varchar (100) NULL, BranchPlant varchar (30) NULL,  
BranchPlantCompanyName varchar (100) NULL, Well varchar (200) NULL, RunNumber varchar (50) NULL,  
MdStart float NULL, MdStartUOM varchar (30) NULL, MdEnd float NULL,  
MdEndUOM varchar (30) NULL, SerialNum varchar (50) NULL, CompDesc varchar (100) NULL)  
  
INSERT INTO @jobOrDTData  
SELECT  NEWID() [KeyId], 
   j.JobId, JobNumber AS JobPFTNum, r.StartDate, 'Job' AS PFTType  
 , OperHrs, CircHrs, DrillHrs, IncidentNumber, i.IncidentId, FieldSummary  
 , STUFF((SELECT ', ' + (fcc.FailureCategoryCode + sfc.FailureSubCategoryCode + fc.FailureCode)  
    FROM Incidents i2  
    INNER JOIN ToolStringComponentInfo tsci WITH (NOLOCK) ON tsci.IncidentID = i2.IncidentID  
    INNER JOIN FailureCodes fc WITH (NOLOCK) ON fc.FailureCodeId = tsci.CompFailureCodeID  
    INNER JOIN FailureCategories fcc WITH (NOLOCK) ON fcc.FailureCategoryId = fc.FailureCategoryId  
    INNER JOIN FailureSubCategories sfc WITH (NOLOCK) ON sfc.FailureSubCategoryId = fc.FailureSubCategoryId  
    WHERE i2.IncidentID = i.IncidentID  
    FOR XML PATH('')), 1, 1, '')   
 AS FailureCodes  
 ,(SELECT COUNT(1) FROM ToolStringComponentInfo WITH (NOLOCK)  
   WHERE CompFailureCodeID IS NOT NULL  
   AND IncidentID = i.IncidentID   
   AND ToolStringComponentInfo.FixedAssetID = tsci.FixedAssetID)   
 AS IsMatch  
 , 'J' As RecordType, c.CustomerName, b.BranchPlant, b.CompanyName AS BranchPlantCompanyName  
 , Well, RunNumber, MdStart, MdStartUOM,   
 MdEnd, MdEndUOM, p.SerialNum, itemNum.DescShort AS CompDesc  
FROM ToolStringComponentInfo tsci WITH (NOLOCK)  
INNER JOIN FixedAssets p WITH (NOLOCK) ON p.FixedAssetId = tsci.FixedAssetID  
INNER JOIN Runs r WITH (NOLOCK) ON r.RunID = tsci.RunID AND r.IsDeleted = 0  
INNER JOIN Wells w WITH (NOLOCK) ON w.WellID = r.WellID AND w.IsDeleted = 0  
INNER JOIN Jobs j WITH (NOLOCK) ON j.JobId = w.JobID and j.IsDeleted = 0  
LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = j.BranchPlant  
LEFT JOIN Customers C WITH (NOLOCK) ON C.CustomerId= j.CustomerId  
LEFT JOIN Incidents i WITH (NOLOCK) ON i.RunID = r.RunID  
LEFT JOIN ItemNums itemNum WITH (NOLOCK) ON itemNum.ItemNum = p.InventoryItemNum  
WHERE p.FixedAssetID = @FixedAssetId and r.StartDate is not null  
  
IF NOT EXISTS (SELECT TOP 1 JobId FROM @jobOrDTData)  
BEGIN  
-------- IF job data is not available then display DT data -------------------------   

	-- new select statement  by vivek bhati--
	INSERT INTO @jobOrDTData  
	SELECT  NEWID() [KeyId], d.DispatchId AS JobId,  CAST(d.DispatchNumber As varchar(100)) AS JobPFTNum, di.DateShipped AS StartDate,
		'Delivery Ticket' AS PFTType, NULL, NULL, NULL, null, null, null, null, null, 'D' as RecordType,  
		null, b.BranchPlant, b.CompanyName AS BranchPlantCompanyName, null, null, null, null, null, null, dii.SerialNum, itemNum.DescShort AS CompDesc    
	FROM	Dispatches d WITH (NOLOCK)
	JOIN	DispatchInstances di WITH (NOLOCK)		ON di.DispatchId = d.Dispatchid and di.ShipType = 'DT-SEQ-ADD'
	JOIN	DispatchInstanceItems dii WITH (NOLOCK)	ON dii.DispatchInstanceId = di.DispatchInstanceId AND ISNULL(dii.ErrorMessage, '') = ''
	JOIN	FixedAssets f WITH (NOLOCK)				ON f.SerialNum = dii.SerialNum and f.RNItemNum = dii.ItemNum
	LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = d.BranchPlant 
	LEFT JOIN ItemNums itemNum WITH (NOLOCK) ON itemNum.ItemNum = f.InventoryItemNum  
	WHERE	f.fixedassetid = @FixedAssetId
END		
  
SELECT * FROM @jobOrDTData  
UNION
select NEWID() [KeyId],ts.ToolStringId as jobid,SerialNumber AS JobPFTNum,tsf.DateAdded as StartDate ,'Build Sheet' AS PFTType,
NULL, NULL, NULL, null, null, null, null, null, TS.[Type] as RecordType, 
null, b.BranchPlant, b.CompanyName AS BranchPlantCompanyName, null, null, null, null, null, null, f.SerialNum, itemNum.DescShort AS CompDesc 
from ToolStrings ts 
join ToolStringFixedAssets tsf on ts.ToolStringId =tsf.ToolStringID
join FixedAssets f on tsf.FixedAssetID=f.FixedAssetId
LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = f.BranchPlant 
LEFT JOIN ItemNums itemNum WITH (NOLOCK) ON itemNum.ItemNum = f.InventoryItemNum  
where 
f.FixedAssetId=@FixedAssetId
UNION    
SELECT NEWID() [KeyId],    
 AssetRepairTrackId as JobId, ARTNumber as JobPFTNum, DateAdded As StartDate, OptionLabel AS PFTType    
 , (SELECT  SUM(ISNULL(r.OperHrs, 0))    
  FROM ToolStringComponentInfo tsci (NOLOCK)    
  INNER JOIN Runs r (NOLOCK) ON R.RunID = tsci.RunID AND R.IsDeleted = 0    
  WHERE tsci.FixedAssetId = a.FixedAssetId AND r.OperHrs IS NOT NULL AND r.EndDate <= a.DateAdded    
   AND r.EndDate >= ISNULL((SELECT MAX(pft2.DateAdded) FROM AssetRepairTrack pft2 (NOLOCK)     
         WHERE pft2.FixedAssetId = a.FixedAssetId AND pft2.DateAdded < a.DateAdded AND pft2.SRPFTWOId IS NOT NULL), '1-1-2001')    
    AND r.IsDeleted = 0    
 ) as OperHoursSinceRepair    
 , ( SELECT     
    SUM(ISNULL(r.CircHrs, 0))    
  FROM ToolStringComponentInfo tsci (NOLOCK)    
  INNER JOIN Runs r (NOLOCK) ON R.RunID = tsci.RunID AND R.IsDeleted = 0    
  WHERE tsci.FixedAssetId = a.FixedAssetId AND r.OperHrs IS NOT NULL AND r.EndDate <= a.DateAdded    
   AND r.EndDate >= ISNULL((SELECT MAX(pft2.DateAdded) FROM AssetRepairTrack pft2 (NOLOCK)     
         WHERE pft2.FixedAssetId = a.FixedAssetId AND pft2.DateAdded < a.DateAdded AND pft2.SRPFTWOId IS NOT NULL), '1-1-2001')    
    AND r.IsDeleted = 0    
 ) as CircHoursSinceRepair    
 , ( SELECT     
   SUM(ISNULL(r.DrillHrs, 0))    
  FROM ToolStringComponentInfo tsci (NOLOCK)    
  INNER JOIN Runs r (NOLOCK) ON R.RunID = tsci.RunID AND R.IsDeleted = 0    
  WHERE tsci.FixedAssetId = a.FixedAssetId AND r.OperHrs IS NOT NULL AND r.EndDate <= a.DateAdded    
   AND r.EndDate >= ISNULL((SELECT MAX(pft2.DateAdded) FROM AssetRepairTrack pft2 (NOLOCK)     
         WHERE pft2.FixedAssetId = a.FixedAssetId AND pft2.DateAdded < a.DateAdded AND pft2.SRPFTWOId IS NOT NULL), '1-1-2001')    
    AND r.IsDeleted = 0    
 ) AS DrillHoursSinceRepair    
 , null, null, null, null, null, 'P' as RecordType,    
 null, null, null, null, null, null, null, null, null, null, null    
FROM AssetRepairTrack a (NOLOCK)    
left join SelectOptions sl (NOLOCK) on sl.SelectName = 'PFTConfigType' and 
sl.OptionValue = (CASE WHEN a.SRPFTWOId IS NOT NULL THEN '1' ELSE '2' END)  -- added by vivek bhati
WHERE a.FixedAssetID = @FixedAssetId    
order by StartDate desc    
    
END    

--- Jobs Grid ---    
IF (ISNULL(@ViewName,'JobView') = 'JobView')  
BEGIN   
SELECT     
  j.JobId, CustomerName, JobNumber, b.BranchPlant, b.CompanyName AS BranchPlantCompanyName, Well,     
  RunNumber, r.StartDate, r.EndDate,    
  MdStart, MdStartUOM, MdEnd, MdEndUOM, p.SerialNum,    
  itemNum.DescShort AS CompDesc, OperHrs, CircHrs, DrillHrs,    
  IncidentNumber, i.IncidentId    
FROM ToolStringComponentInfo tsci WITH (NOLOCK)    
INNER JOIN FixedAssets p WITH (NOLOCK) ON p.FixedAssetId = tsci.FixedAssetID    
INNER JOIN Runs r WITH (NOLOCK) ON r.RunID = tsci.RunID AND r.IsDeleted = 0    
INNER JOIN Wells w WITH (NOLOCK) ON w.WellID = r.WellID AND w.IsDeleted = 0    
INNER JOIN Jobs j WITH (NOLOCK) ON j.JobId = w.JobID and j.IsDeleted = 0    
LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = j.BranchPlant    
LEFT JOIN Customers C WITH (NOLOCK) ON C.CustomerId= j.CustomerId    
LEFT JOIN Incidents i WITH (NOLOCK) ON i.RunID = r.RunID    
LEFT JOIN ItemNums itemNum WITH (NOLOCK) ON itemNum.ItemNum = p.InventoryItemNum    
WHERE p.FixedAssetID = @FixedAssetId    
END  
  
--- PFTs Grid ---    
IF (ISNULL(@ViewName,'PFTView') = 'PFTView')  
BEGIN   
  
SELECT     
  p.PFTWOId, p.WO_NO, p.BranchPlant, p.SerialNum, p.ItemNum, pc.ProcessName, so.OptionLabel AS PFTType,    
  p.DateAdded    
  , (SELECT TOP 1 DateAdded     
     FROM  dbo.PFTWOSeq (NOLOCK) a    
     WHERE a.PFTWOId = p.PFTWOId AND a.UserName IS NOT NULL    
     ORDER BY DateAdded DESC) AS LastDateAdded    
  , '1' AS OperHoursSinceRepair, '1' AS DrillHoursSinceRepair, '1' AS CircHoursSinceRepair    
  , b.CompanyName AS BranchPlantCompanyName    
FROM dbo.PFTWO (NOLOCK) p    
LEFT JOIN dbo.PFTConfig (NOLOCK) pc ON pc.PFTConfigId = p.PFTConfigId    
LEFT JOIN dbo.SelectOptions (NOLOCK) so ON so.SelectName = 'PFTConfigType' AND so.OptionValue = p.PFTType    
LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = p.BranchPlant    
WHERE p.FixedAssetId = @FixedAssetId    
ORDER BY p.DateAdded DESC    
    
END  
  
--- Tool Mods Grid ---    
  
IF (ISNULL(@ViewName,'ToolMod') = 'ToolMod')  
BEGIN   
  
 SELECT tm.ToolModId, tm.ModNum, tm.ModSubject, tm.ModDesc     
 FROM ToolModFixedAssets tmf (NOLOCK)    
 INNER JOIN ToolMods tm (NOLOCK) ON tm.ToolModId = tmf.ToolModId    
 WHERE tmf.FixedAssetId = @FixedAssetId    
  
END   
  
   
-- Work Orders Grid--    
IF (ISNULL(@ViewName,'WorkOrderView') = 'WorkOrderView')  
BEGIN   
 Select w.WorkOrderId, w.WorkOrderNum, w.JDEWorkOrderNum, s.OptionLabel as WorkOrderTypeName, w.BranchPlant,     
   w.SerialNum, w.InventoryItemNum, w.AddedBy, w.DateAdded, w.DateClosed, w.Status    
   , b.CompanyName AS BranchPlantCompanyName    
 from WorkOrders(NOLOCK) w    
 left join SelectOptions s (NOLOCK) on s.OptionValue =  w.WorkOrderType and SelectName = 'WorkOrderType'    
 left join PFTWO p (NOLOCK) on w.WorkOrderId = p.WorkOrderId    
 LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = w.BranchPlant    
 Where w.FixedAssetId = @FixedAssetId    
  
END    
  
  
--- AIRTs Grid ---    
IF (ISNULL(@ViewName,'AIRTView') = 'AIRTView')  
BEGIN   
  
 SELECT      
   a.AssetRepairTrackId, a.ARTNumber, a.FromBranchPlant, a.ItemNum, a.NCRNumber, j.JobNumber, i.IncidentNumber,    
   a.DateAdded, a.DateClosed, a.Status, b.CompanyName AS BranchPlantCompanyName, j.JobId    
 FROM dbo.AssetRepairTrack (NOLOCK) a    
 LEFT JOIN dbo.Jobs (NOLOCK) j ON j.JobId = a.JobId    
 LEFT JOIN dbo.Incidents (NOLOCK) i ON i.IncidentID = a.IncidentId    
 LEFT JOIN BranchPlants b WITH (NOLOCK) ON b.BranchPlant = a.FromBranchPlant    
 WHERE a.FixedAssetId = @FixedAssetId    
 ORDER BY a.DateAdded DESC    
   
END  
  
--- Movements Grid ---    
IF (ISNULL(@ViewName,'Movements') = 'Movements')  
BEGIN   
  
SELECT    
  ptd.PartTransferDtlId    
  , ptd.SendingLocation    
  , bps.CompanyName as SendingLocationName    
  , ptd.ReceivingLocation    
  , bpr.CompanyName as ReceivingLocationName    
  , ptd.JDETransactionId  , ptd.Quantity    
  , ptd.DateofTransaction    
  , ptd.DocumentNumber    
  , ptd.DocumentType    
  , sodt.OptionLabel as DocumentDesc    
  , ptd.InventoryItemNum as ItemNo    
  , ptd.UserCreatedDocument    
  , case when ptd.DocumentType = 'SR' then     
  (select top 1 di.DispatchInstanceId     
  from Dispatches d     
  join DispatchInstances di on di.DispatchId = d.DispatchId    
  join DispatchInstanceItems dii on dii.DispatchInstanceId = di.DispatchInstanceId    
  where d.DispatchNumber = ptd.DocumentNumber    
  and di.ShipType = 'DT-SEQ-ADD'    
  and dii.AssetNumber = ptd.AssetNumber    
  )    
 else null end as DispatchInstanceId    
FROM PartTransferDtl(NOLOCK) ptd    
LEFT JOIN BranchPlants(NOLOCK) bps ON bps.BranchPlant = ptd.SendingLocation    
LEFT JOIN BranchPlants(NOLOCK) bpr ON bpr.BranchPlant = ptd.ReceivingLocation    
LEFT JOIN SelectOptions(NOLOCK) sodt ON sodt.OptionValue = ptd.DocumentType AND sodt.SelectName = 'TransferDocumentType'    
WHERE ptd.FixedAssetId = @FixedAssetId    
--ORDER BY   ptd.DateofTransaction    DESC      
UNION    
select    
  dii.DispatchInstanceItemId as PartTransferDtlId    
  , case dii.QtyShipped when 0 then j.JobNumber else d.BranchPlant end  as SendingLocation    
  , case dii.QtyShipped when 0 then 'Job' else bp.CompanyName end  as SendingLocationName    
  , case dii.QtyShipped when 0 then d.BranchPlant else j.JobNumber end as ReceivingLocation    
  , case dii.QtyShipped when 0 then bp.CompanyName else 'Job' end as ReceivingLocationName    
  , case dii.QtyShipped when 0 then di.ReturnSequenceNum else di.SequenceNum end as JDETransactionId    
  , case dii.QtyShipped when 0 then dii.QtyReturned else dii.QtyShipped end as Quantity    
  , case dii.QtyShipped when 0 then dii.DateReturned else di.DateShipped end as DateofTransaction    
  , Convert(varchar(30), d.DispatchNumber) as DocumentNumber    
  , case dii.QtyShipped when 0 then 'Return' else 'Ship' end as DocumentType    
  , NULL as DocumentTypeDesc    
  , dii.ItemNum as ItemNo    
  , NULL as UserCreatedDocument  
  , di.DispatchInstanceId    
from DispatchInstanceItems(NOLOCK) dii  
INNER JOIN DispatchInstances(NOLOCK) di on di.DispatchInstanceId = dii.DispatchInstanceId    
INNER JOIN Dispatches(NOLOCK) d on d.DispatchId = di.DispatchId    
LEFT JOIN BranchPlants(NOLOCK) bp ON bp.BranchPlant = d.BranchPlant and bp.IsNonLiveLocation = 0  
LEFT JOIN Jobs(NOLOCK) j on j.JobId = d.JobId  
WHERE dii.FixedAssetId = @FixedAssetId  
ORDER BY ptd.DateofTransaction DESC    
  
END  
--- Firmware Grid ---    
  
IF (ISNULL(@ViewName,'FirmwareView') = 'FirmwareView')  
BEGIN   
  
 SELECT  pbf.PFTBoardFirmwareId, pbf.BoardItemNum, pbf.Component, pbf.EndFirmwareItemNum, pbf.EndFirmwareRevision,    
   p.SerialNum, p.ItemNum, p.AssetNumber, i.DescShort    
 FROM dbo.PFTBoardFirmwares (NOLOCK) pbf    
 LEFT JOIN dbo.PFTWO (NOLOCK) p ON p.PFTWOId = pbf.PFTWOId    
 LEFT JOIN dbo.ItemNums (NOLOCK) i ON i.ItemNum = pbf.EndFirmwareItemNum    
 WHERE p.FixedAssetId = @FixedAssetId    
 ORDER BY pbf.DateAdded DESC    
    
END  
  
--- TCNs Grid ---    
IF (ISNULL(@ViewName,'TCNView') = 'TCNView')  
BEGIN   
  
 SELECT cn.CNId, cn.CNNum, cn.ECNNum, cn.CRNum, cn.CNDesc, cn.CNType, cn.DateAdded, cn.CNDateClosed, cn.CNStatus,    
   cnp.DateCompleted, r.RequestType    
 FROM dbo.ChangeNoticeParts (NOLOCK) cnp    
 LEFT JOIN dbo.ChangeNotices (NOLOCK) cn ON cn.CNId = cnp.CNId    
 LEFT JOIN Requests r (NOLOCK) On cn.CRNum = CONVERT(varchar(50), r.RequestId)    
 WHERE cnp.FixedAssetId = @FixedAssetId    
 ORDER BY cn.DateAdded DESC    
    
END  
  
--- Components Grid ---    
IF (ISNULL(@ViewName,'ComponentView') = 'ComponentView')  
BEGIN   
  
 ;WITH RecursiveCTE(Level, FixedAssetId, SerialNum, InventoryItemNum, RNItemNum, Qty, AssetDescription, ParentFixedAssetId, ParentSerialNum, ParentInventoryItemNum)    
 AS    
 (    
  SELECT  0 as Level, fa.FixedAssetId, fa.SerialNum, fa.RNItemNum, fa.InventoryItemNum, fa.CurrentItemQty as Qty, fa.AssetDescription,    
   fa.ParentFixedAssetId, fap.SerialNum as ParentSerialNum, fap.InventoryItemNum as ParentInventoryItemNum    
  FROM FixedAssets fa (NOLOCK)    
  LEFT OUTER JOIN FixedAssets (NOLOCK) fap ON fap.FixedAssetId = fa.ParentFixedAssetId    
  WHERE fa.FixedAssetId = @FixedAssetId    
     
  UNION ALL    
     
  SELECT Level + 1 as Level, pc.FixedAssetId, pc.SerialNum, pc.InventoryItemNum, pc.RNItemNum, pc.CurrentItemQty as Qty, pc.AssetDescription,    
   pc.ParentFixedAssetId, ct.SerialNum as ParentSerialNum, ct.InventoryItemNum as ParentInventoryItemNum    
  FROM FixedAssets pc (NOLOCK)    
  INNER JOIN RecursiveCTE ct ON pc.ParentFixedAssetId = ct.FixedAssetId  AND pc.ParentFixedAssetId <> pc.FixedAssetId    
 )    
 Select cte.Level, cte.FixedAssetId, cte.SerialNum, cte.InventoryItemNum, cte.RNItemNum, cte.Qty, cte.AssetDescription,     
   cte.ParentFixedAssetId, cte.ParentSerialNum, cte.ParentInventoryItemNum, IsNull(ri.IsAsset, IsNull(i.IsAsset, 0)) as IsAsset     
 from RecursiveCTE cte    
 LEFT JOIN dbo.ItemNums (NOLOCK) i ON i.ItemNum = cte.InventoryItemNum    
 LEFT JOIN dbo.ItemNums (NOLOCK) ri ON ri.ItemNum = cte.RNItemNum    
 ORDER BY Level, ParentSerialNum    
  
END  
    
--- Documents Grid ---    
IF (ISNULL(@ViewName,'DocumentView') = 'DocumentView')  
BEGIN   
  
 SELECT dia.DocItemId, di.DocItemTitle, di.DocItemDesc, di.DocItemFileSize, di.DocItemDate, p.WO_NO, p.PFTWOId    
 FROM dbo.DocItemAttach (NOLOCK) dia    
 LEFT JOIN dbo.DocItems (NOLOCK) di ON di.DocItemId = dia.DocItemId    
 LEFT JOIN dbo.PFTWO (NOLOCK) p ON p.PFTWOId = dia.GuidKeyId    
 WHERE di.DocItemType = 1 AND p.FixedAssetId = @FixedAssetId    
 UNION    
 SELECT dia.DocItemId, di.DocItemTitle, di.DocItemDesc, di.DocItemFileSize, di.DocItemDate, NULL, NULL    
 FROM dbo.DocItemAttach (NOLOCK) dia    
 LEFT JOIN dbo.DocItems (NOLOCK) di ON di.DocItemId = dia.DocItemId    
 WHERE di.DocItemType = 1 AND dia.GuidKeyId = @FixedAssetId    
 ORDER BY di.DocItemTitle    
  
    
SELECT distinct p.WO_NO, p.PFTWOId     
FROM dbo.DocItemAttach (NOLOCK) dia      
LEFT JOIN dbo.DocItems (NOLOCK) di ON di.DocItemId = dia.DocItemId      
LEFT JOIN dbo.PFTWO (NOLOCK) p ON p.PFTWOId = dia.GuidKeyId      
WHERE di.DocItemType = 1 AND p.FixedAssetId = @FixedAssetId    
    
END  
    
  
IF (ISNULL(@ViewName, '') ='MaintenanceView')  
 BEGIN  
 DECLARE @AssetrepairTrackId UNIQUEIDENTIFIER ;  
 SET @AssetrepairTrackId = (SELECT top 1 assetRepairTrackId FROM AssetRepairTrack where FixedAssetId = @FixedAssetId order by DateAdded desc);  
   
 SELECT CASE 
	WHEN MeterReadingTypeId = 4 THEN (CASE WHEN LastMeterReadingValue = 1 THEN 1 ELSE 3 END)
	WHEN LastMeterReadingValue >  [TriggerValue] THEN 3   
	WHEN LastMeterReadingValue > ([TriggerValue] * 0.9) THEN 2  
 ELSE 1 END [PMCheckStatus], *   
 FROM  
 (  
  SELECT distinct f.FixedAssetId,   
		'' PMDispositionId,  
		c.CreateJDEWO,   
		pc.PFTConfigID,   
		f.SerialNum,   
		f.InventoryItemNum [ItemNum],   
		inum.DescShort [AssetDescription],   
		c.MeterReadingTypeId,   
		s.OptionLabel [MeterReadingType],   
		dbo.ufn_CBMMonitor_GetTrigger(c.CBMMonitorId, f.BranchPlant, f.FixedAssetId) [TriggerValue],
		pc.ProcessName AS [PFTProcessName] ,
		c.CBMMonitorId,
   -- As per CBM history calculations should be as below --------------------------------------------------  
		COALESCE(
			/*
				1	Operating Hours
				2	Circulating Hours
				3	Temperature Function
				6	Shock Monitor
				7	Vibration Monitor
			*/
			CASE WHEN c.MeterReadingTypeId IN (1,2,3,6,7) THEN r.LastMeterReadingValue

			--One Time Mandatory
			WHEN c.MeterReadingTypeId = 4 THEN 
			(
				-- if 
				CASE WHEN (select top 1 pftWO_OneTime.PFTWOId 
							FROM PFTWO pftWO_OneTime (NOLOCK)
							JOIN PFTConfig pftConfig_OneTime (NOLOCK) on pftWO_OneTime.PFTConfigId = pftConfig_OneTime.PFTConfigId
							WHERE pftWO_OneTime.FixedAssetId = parentFixedAsset.FixedAssetId
									AND pftConfig_OneTime.ObjectNumber = c.ObjectNumber
									AND pftWO_OneTime.PFTType = 3
									AND pftWO_OneTime.ReasonForChange = 'Closed - Passed'
						) IS NULL THEN 0 
					ELSE 1 END
			)
			-- scheduled    
			WHEN c.MeterReadingTypeId = 5 THEN  
					DATEDIFF(dd,  
								COALESCE(r.LastMeterReadingValue   -- Check Last PM PFT Completed    
									,(SELECT MIN(DateofTransaction) FROM PartTransferDtl p (NOLOCK) WHERE Dest = 'IN' AND p.FixedAssetId = f.fixedAssetId) 
									, f.DateAdded), 
					GETDATE())   

			-- AIRT Count
			WHEN c.MeterReadingTypeId = 8 THEN -- AIRT    
					ISNULL(
						(
							SELECT COUNT(*) 
							FROM AssetRepairTrack a
							WHERE a.FixedAssetId = parentFixedAsset.FixedAssetId 
								and a.Status = 'Closed'
								and a.DateAdded > ISNULL((SELECT MAX(pw.DateAdded)
													FROM PFTWO pw (NOLOCK)
													JOIN PftConfig pc (NOLOCK) on pw.PFTConfigId = pc.PFTConfigId and pc.ObjectNumber = c.ObjectNumber
													WHERE pw.FixedAssetId = parentFixedAsset.FixedAssetId 
														AND PFTType = 3
														AND pw.Active = 0
														AND pw.ReasonForChange = 'Closed - Passed'
													), '1900-01-01')
						),
					0)

			-- Days Since DT Return   
			WHEN c.MeterReadingTypeId IN (10, 11) THEN dbo.ufn_CbmMonitor_GetDTLastMeterReadingValue(f.fixedAssetid, c.CBMMonitorId) 

		END , DefaultMeterReading, 0) AS LastMeterReadingValue


		FROM CBMMonitor c (NOLOCK) 
		JOIN CBMMonitorAssetItemNums pItem (NOLOCK) on c.CBMMonitorId = pItem.CBMMonitorId and pItem.IsParent = 1
		JOIN CBMMonitorAssetItemNums cItem (NOLOCK) on pItem.CBMMonitorId = cItem.CBMMonitorId and cItem.IsParent = 0
		JOIN FixedAssets f (NOLOCK) on f.InventoryItemNum = cItem.ItemNum
		JOIN FixedAssets parentFixedAsset (NOLOCK) ON ISNULL(f.TopLevelFixedAssetId, f.FixedAssetId) = parentFixedAsset.FixedAssetId and pItem.ItemNum = parentFixedAsset.InventoryItemNum
		JOIN PFTConfig pc (NOLOCK) ON c.ObjectNumber = pc.ObjectNumber AND pc.IsObsolete = 0
		LEFT JOIN CBMCalculatedMeterReadings r (NOLOCK) ON f.FixedAssetId = r.FixedAssetId AND c.CBMMonitorId = r.CBMMonitorId
		JOIN ItemNums inum (NOLOCK) ON inum.ItemNum = f.InventoryItemNum 
		JOIN SelectOptions s (NOLOCK) ON s.SelectName = 'CBMMeterTypes' AND c.MeterReadingTypeId = s.OptionValue
		WHERE c.Active = 1
			AND parentFixedAsset.FixedAssetId = @FixedAssetId
 ) A   
 ORDER BY a.SerialNum, a.MeterReadingTypeId  
 
  
 --PM History grid  
 SELECT distinct  
  F.SerialNum,  
  f.InventoryItemNum [ItemNum],  
  F.AssetDescription,  
  S.OptionLabel [MeterReadingType],   
  i.MeterReadingValue,   
  i.TriggerValue,  
  C.ProcessName AS PFTName,   
  CONVERT(varchar(20), pw.DateAdded,101) AS PFTCreationDate  
 FROM AssetRepairTrack A (NOLOCK)  
   JOIN AssetRepairTrack a1 (NOLOCK) ON a1.FixedAssetId = a.FixedAssetId  
   JOIN PFTWO pw (NOLOCK) ON  pw.AssetRepairTrackId = a1.AssetRepairTrackId  
   JOIN PMDispositions p (NOLOCK) ON p.AssetRepairTrackId = a1.AssetRepairTrackId AND p.DispositionOption = 1   
   INNER JOIN PMDispositionItems i (NOLOCK) ON i.AssetRepairTrackId = a1.AssetRepairTrackId and pw.PFTConfigId = i.PFTConfigId  
   INNER JOIN FixedAssets F (NOLOCK) ON i.FixedAssetId = F.FixedAssetId  
   INNER JOIN SelectOptions S (NOLOCK) ON S.SelectName = 'CBMMeterTypes' AND S.OptionValue = i.MeterReadingTypeId  
   INNER JOIN PFTConfig c (NOLOCK) ON c.PFTConfigId = i.PFTConfigId  
 WHERE f.FixedAssetId=@FixedAssetId  
  
 --A.AssetRepairTrackId =  (SELECT top 1 assetRepairTrackId FROM AssetRepairTrack where FixedAssetId = @FixedAssetId order by DateAdded desc) AND i.CreatedOn < a.DateAdded  
   
 --SELECT PD.PMDispositionId,   
 --  PC.PFTConfigId,   
 --  PC.ProcessName [PFTName],   
 --  PC.ProcessDesc [Description],   
 --  ISNULL(DispositionOption, -1) [DispositionOption]  
 --FROM PMDispositions PD (NOLOCK)   
 --  JOIN PFTConfig PC (NOLOCK) ON PD.PFTConfigId = PC.PFTConfigId  
 --WHERE PD.AssetRepairTrackId = (SELECT top 1 assetRepairTrackId FROM AssetRepairTrack where FixedAssetId = @FixedAssetId order by DateAdded desc)  
  
  
 --SELECT PD.PFTConfigId,   
 --  F.SerialNum,   
 --  F.InventoryItemNum [ItemNum],   
 --  F.AssetDescription,   
 --  i.MeterReadingTypeId,   
 --  S.OptionLabel [MeterReadingType],   
 --  CONVERT(DECIMAL(18,2), i.MeterReadingValue)[LastMeterReadingValue],   
 --  CONVERT(DECIMAL(18,2), i.TriggerValue) [TriggerValue]  
 --FROM PMDispositions PD (NOLOCK)  
 --  JOIN PMDispositionItems i (NOLOCK) ON i.AssetRepairTrackId = pd.AssetRepairTrackId and pd.PFTConfigId = i.PFTConfigId  
 --  JOIN FixedAssets F (NOLOCK) ON f.FixedAssetId = i.FixedAssetId  
 --  JOIN SelectOptions S (NOLOCK) ON S.SelectName = 'CBMMeterTypes' AND S.OptionValue = i.MeterReadingTypeId  
 --WHERE f.FixedAssetId = @FixedAssetId  
     
      
  
  
 END  
END
