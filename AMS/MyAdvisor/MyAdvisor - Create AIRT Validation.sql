DECLARE @FixedAssetId uniqueidentifier = '9F1F1646-5BB0-4E25-A6D3-DE02BED1EBAA'

--serial number is not empty, 
-- check part #
-- check for equipment status scrap
select SerialNum, InventoryItemNum, EquipmentStatus from FixedAssets where FixedAssetId =@FixedAssetId

--check asset is serialised
SELECT DefaultSerialProfile FROM ItemNums where ItemNum =  (select InventoryItemNum from FixedAssets where FixedAssetId =@FixedAssetId)

-- airt already not open
select * from AssetRepairTrack where Status = 'Open' and FixedAssetId = @FixedAssetId

-- work order is not open
select * from WorkOrders where Status = 'Open' and FixedAssetId = @FixedAssetId

--pft config mapping present for test and inspection (pfttype 1 & 2 both should be present)
select PFTType from PartDescPFTConfigs c 
join PFTConfig pc on c.PFTConfigID = pc.PFTConfigId  and pc.IsObsolete = 0
where ItemNum =  (select InventoryItemNum from FixedAssets where FixedAssetId =@FixedAssetId) 
	and PFTType IN (1,2)

--pft work order not already open
select * from PFTWO where Active = 1 and PFTType IN (0,1,2, 4,5) and FixedAssetId = @FixedAssetId

-- airt allowed to be created with current equipment status (IsDisposed should be 0)
select SerialNum, InventoryItemNum, EquipmentStatus, p.IsDisposed from FixedAssets f 
join partstatus p on f.EquipmentStatus = p.Code 
where FixedAssetId =@FixedAssetId

--ecn restrinction