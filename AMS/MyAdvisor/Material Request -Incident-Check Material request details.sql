--select * from SOAAuditInformation 
--where AuditTypeId = 10 and convert(nvarchar(max), requestxml) like '%95736271%'
--order by 1 desc

declare @X xml = '<Request>
  <UniqueId>bd4dfb99-cf6a-43e2-b22e-89c7c68eefda</UniqueId>
  <Method>POST</Method>
  <RequestUrl>ws/simple/createPartsList</RequestUrl>
  <Headers>
    <Accept>application/json, application/xml, text/json, text/x-json, text/javascript, text/xml</Accept>
  </Headers>
  <Body>
    <PartsListAddRequest>
      <WorkOrderNo>95736271</WorkOrderNo>
      <MyAdvisorQueueId>d3c6647f-8103-40cc-9093-aaed003c9195</MyAdvisorQueueId>
      <WorkOrderType>WC</WorkOrderType>
      <WorkOrderStatus>E</WorkOrderStatus>
      <PartsList>
        <ComponentItem>2462615</ComponentItem>
        <EstimatedQty>3</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1649450</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1649449</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1118068</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1118034</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1118620</ComponentItem>
        <EstimatedQty>2</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1649450</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>2499250</ComponentItem>
        <EstimatedQty>2</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1583769</ComponentItem>
        <EstimatedQty>2</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1118423</ComponentItem>
        <EstimatedQty>2</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1649449</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>2499328</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>2499729</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
      <PartsList>
        <ComponentItem>1649442</ComponentItem>
        <EstimatedQty>1</EstimatedQty>
        <UnitOfMeasure />
        <BranchPlant>171211</BranchPlant>
        <Location />
        <LotSerialNo />
        <RequestDate>10/21/2019</RequestDate>
        <MaterialStatus />
        <IssueTypeCode>I</IssueTypeCode>
      </PartsList>
    </PartsListAddRequest>
  </Body>
</Request>';

select  
	--w.BranchPlant [WorkOrder_BranchPlant], 
	--i.*,
	x.r.value('(ComponentItem)[1]', 'varchar(500)') as [ComponentItem],
	x.r.value('(EstimatedQty)[1]', 'varchar(500)') as [EstimatedQty],
	x.r.value('(UnitOfMeasure)[1]', 'varchar(500)') as UnitOfMeasure,
	x.r.value('(BranchPlant)[1]', 'varchar(500)') as BranchPlant,
	x.r.value('(Location)[1]', 'varchar(500)') as Location,
	x.r.value('(LotSerialNo)[1]', 'varchar(500)') as LotSerialNo,
	x.r.value('(RequestDate)[1]', 'varchar(500)') as RequestDate,
	x.r.value('(MaterialStatus)[1]', 'varchar(500)') as MaterialStatus,
	x.r.value('(IssueTypeCode)[1]', 'varchar(500)') as IssueTypeCode
from WorkOrders w
JOIN WorkOrderMaterialRequests r ON w.WorkOrderId = r.WorkOrderId
JOIN WorkOrderMaterialRequestItems i on r.WorkOrderMaterialRequestId = i.WorkOrderMaterialRequestId
LEFT JOIN @X.nodes('/Request/Body/PartsListAddRequest/PartsList') as x(r) ON x.r.value('(ComponentItem)[1]', 'varchar(500)') = i.ItemNum
where MaterialRequestNum ='W171211-1732-01' and x.r.value('(ComponentItem)[1]', 'varchar(500)') IS NULL;

select * from AesImport.dbo.ItemBranchAndCostImport where Item_Number ='1563871'