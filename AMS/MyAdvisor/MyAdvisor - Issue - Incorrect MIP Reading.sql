select * from FixedAssets where SerialNum ='SDE-065'

SELECT r.Id, r.FixedAssetId, r.LastMeterReadingValue, r.LastPFTWOId, a.PFTWOId, a.DateAdded, 
DATEDIFF(dd, a.dateadded, r.lastmeterreadingvalue),
Format(a.dateadded, 'MMM dd yyyy HH:MMtt'),
a.CBMMonitorid,
ProcessDesc,
ProcessName
--UPDATE r
--SET LastPFTWOId = a.PFTWOId,
--	LastMeterReadingValue = Format(a.dateadded, 'MMM dd yyyy HH:MMtt')
from 
(
	select ROW_NUMBER() OVER(partition by cm.CBMMonitorId, p.fixedassetid order by ps.DateAdded desc) [RowNumber], 
		p.PFTWOId, 
		p.FixedAssetId,
		cm.CBMMonitorId, 
		pc.ProcessDesc,
		pc.ProcessName,
		ps.DateAdded
	from PFTWO p 
	JOIN PFTConfig pc on p.PFTConfigId = pc.PFTConfigId and p.PFTType = 3 and p.ReasonForChange ='Closed - Passed'
	JOIN PFTWOSeq ps on ps.PFTWOId = p.PFTWOId
	JOIN PFTObjects po on po.ObjectId = pc.PFTObjectId
	JOIN CBMMonitor cm on cm.ObjectNumber = po.ObjectNumber and cm.Active = 1 and cm.MeterReadingTypeId = 5
) a
LEFT JOIN CBMCalculatedMeterReadings r on r.CBMMonitorId = a.CBMMonitorId and r.FixedAssetId = a.FixedAssetId
WHERE a.RowNumber = 1 and 
a.FixedAssetId = 'ed1ed1ab-8d61-4911-9119-1c465ae48078'
and DATEDIFF(dd, a.dateadded, r.lastmeterreadingvalue) != 0

UPDATE fa 
		SET 
			fa.AssetLifeRemaining = alr.AssetLifeRemaining
		FROM FixedAssets fa
		JOIN VW_FixedAsset_LifeConsumed alr on fa.FixedAssetId=alr.FixedAssetId
		where fa.FixedAssetId = '4292CCED-A58F-48D0-8858-3B9825D82BB4'


--SELECT max(ps.DateAdded), p.PFTWOId FROM PFTWO p
--join PFTWOSeq ps on p.PFTWOId = ps.PFTWOId
--WHERE FixedAssetid ='4292CCED-A58F-48D0-8858-3B9825D82BB4' and PFTType = 3 and PFTConfigId IN (select PFTConfigid from PFTConfig where ObjectNumber =4711)
--group by p.PFTWOId

--select m.*
--from CBMMonitor m
--join CBMMonitorAssetItemNums parent on m.CBMMonitorId = parent.CBMMonitorId and parent.IsParent = 1 and m.Active = 1
--join CBMMonitorAssetItemNums child on m.CBMMonitorId = child.CBMMonitorId and child.IsParent = 0
--where parent.ItemNum = 1212052 and child.ItemNum = 1212052

--INSERT INTO CBMCalculatedMeterReadings (FixedAssetId, MeterReadingTypeId, LastMeterReadingValue, LifeTimeValue, UpdatedOn, LastPFTWOId, CBMMonitorId)
--VALUES('4292CCED-A58F-48D0-8858-3B9825D82BB4', 5, '2022-11-22 01:08:59.000', null, getdate(), '8491E465-9BAC-4657-9553-AF520058B8D5', 136)