--CREATE TABLE TempAIRTRecords ( AssetRepairTrackId UNIQUEIDENTIFIER )
--CREATE TABLE TempPFTWORecords ( PFTWOId UNIQUEIDENTIFIER )
--CREATE TABLE TempWorkOrderRecords ( WorkOrderId UNIQUEIDENTIFIER )

--INSERT INTO TempAIRTRecords
--select AssetRepairTrackId
--from AssetRepairTrack a (NOLOCK)
--inner join PFTWO p1 (NOLOCK) on p1.PFTWOId = a.ITPFTWOId
--inner join (
--      select MAX (dateadded) as "dateadded",PFTWOid
--      from PFTWOSeq (NOLOCK)
--      group by PFTWOId) B on b.PFTWOId = p1.PFTWOId
--where 
--p1.Active = '0' --T&I PFT is closed
--and b.dateadded < '2014-8-12' -- Last step on T&I PFT was done before go-live
--and SRPFTWOId is null --no S&R PFT, which means either the T&I passed and AIRT wasn't closed, or is waiting disposition, or person never clicked create S&R PFT/WO.
--and a.Status = 'open' -- airt is still open

--UNION 

--select AssetRepairTrackId
--from AssetRepairTrack (NOLOCK)

--where (ITPFTWOId in (
--      select PFTWOId
--      from PFTWO p (NOLOCK)
--      where Active = '1' and p.dateadded < '2014-8-12' and p.PFTWOId not in (select pftwoid from PFTWOSeq)) 
--or ITPFTWOId in (
--      select p.pftwoid
--      from PFTWO p (NOLOCK)
--      inner join (
--            select MAX (dateadded) as "dateadded",PFTWOid
--            from PFTWOSeq (NOLOCK)
--            group by PFTWOId) a on a.PFTWOId = p.PFTWOId
--      where p.Active = '1' and a.dateadded < '2014-8-12')) or
--      (SRPFTWOId in (
--      select PFTWOId
--      from PFTWO p (NOLOCK)
--      where Active = '1' and p.dateadded < '2014-8-12' and p.PFTWOId not in (select pftwoid from PFTWOSeq)) 
--or ITPFTWOId in (
--      select p.pftwoid
--      from PFTWO p (NOLOCK)
--      inner join (
--            select MAX (dateadded) as "dateadded",PFTWOid
--            from PFTWOSeq (NOLOCK)
--            group by PFTWOId) a on a.PFTWOId = p.PFTWOId
--      where p.Active = '1' and a.dateadded < '2014-8-12'))

--SELECT * FROM TempAIRTRecords

--------------------------------------------------------------------------------------------------------------------

--INSERT INTO TempPFTWORecords
--select PFTWOId
--from PFTWO p (NOLOCK)
--where Active = '1' and p.dateadded < '8-12-2014' and p.PFTWOId not in (select pftwoid from PFTWOSeq)

--UNION 

--select p.pftwoid
--from PFTWO p (NOLOCK)
--inner join (
--      select MAX (dateadded) as "dateadded",PFTWOid
--      from PFTWOSeq (NOLOCK)
--      group by PFTWOId) a on a.PFTWOId = p.PFTWOId
--where p.Active = '1' and a.dateadded < '8-12-2014'



---------------------------------------------------------------------------------------------------------------------

--INSERT INTO TempWorkOrderRecords 
--SELECT w.WorkOrderId
--from WorkOrders w (NOLOCK)
--      INNER JOIN AssetRepairTrack a (NOLOCK) on a.SerialNum = w.SerialNum and a.ItemNum = w.InventoryItemNum
--      INNER Join TempAIRTRecords a1 on a.AssetRepairTrackId = a1.AssetRepairTrackId
--      where w.DateAdded < '8-12-2014' and w.DateClosed is null and a.Status= 'open'

SELECT COUNT(*) [AIRT Count] FROM TempAIRTRecords

SELECT COUNT(*) [PFT Count] FROM TempPFTWORecords

SELECT COUNT(*) [Work Order Count] FROM TempWorkOrderRecords

--Update w
--SET w.Status = 'Closed',
--	w.Dateclosed = GETDATE()
--      from WorkOrders w (NOLOCK)
--      INNER JOIN TempWorkOrderRecords w1 on w.WorkOrderId = w1.WorkOrderId

--Update p
--SET p.Active = '0'
--FROM PFTWO p
--inner join TempPFTWORecords p1 on p1.PFTWOId = p.PFTWOId

--Update A
--SET A.Status = 'Closed'
--FROM AssetRepairTrack a
--inner join TempAIRTRecords a1 on a.AssetRepairTrackId = a1.AssetRepairTrackId
