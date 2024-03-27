USE AesOps;


select m.*, h.* 
from SOAWorkOrderRequest r
JOIN SOAWorkOrderResponseHeader h on r.RequestId = h.RequestId
LEFT JOIN SOAWorkOrderResponseMessages m ON m.ResponseHeaderId = h.ResponseHeaderId
JOIN WorkOrders w on w.WorkOrderNum = r.WorkOrderNum
JOIN PFTWO p on p.WorkOrderId = w.WorkOrderId
JOIN AssetRepairTrack a on a.SRPFTWOId = p.PFTWOId
WHERE A.ARTNumber = '3039219217-ART'