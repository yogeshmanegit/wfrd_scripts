select * from ServiceGroup where name like '%third%'
select * from ServiceGroupToolType t where t.servicegroupid = 676
select * from AssetServiceGroupExceptions a where a.serviceGroupID = 676
select * from assets where assetID = -10043

select * from ServiceGroup where id IN (733, 734, 735, 736, 737, 738, 739)
select * from ServiceGroupToolType t where t.servicegroupid IN (733, 734, 735, 736, 737, 738, 739)
select * from AssetServiceGroupExceptions a where a.serviceGroupID IN (733, 734, 735, 736, 737, 738, 739)
