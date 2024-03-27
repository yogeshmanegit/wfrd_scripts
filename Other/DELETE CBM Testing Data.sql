--SELECT * FROM sys.tables WHERE name like '%histogram%'

--DELETE FROM Histogram
--DELETE FROM HistogramJobInfo
--DELETE FROM HistogramBin
--DELETE FROM HistogramMonitor
--DELETE FROM HistogramToolInfo
--DELETE FROM CBMCalculatedMeterReadings
--DELETE FROM CBMRunAssetMappings
--DELETE FROM PMDispositionItems
--DELETE FROM PMDispositions
--DELETE FROM AuditPMDispositions

SELECT * FROM CBMCalculatedMeterReadings
SELECT * FROM PFTWO WHERE PFTWoId ='F41BE426-537C-4259-BC4D-A732009CC7B5'
UPDATE PFTWO SET DateAdded = '12/1/2015' WHERE PFTWOId='F41BE426-537C-4259-BC4D-A732009CC7B5'

--SELECT * FROM FixedAssets WHERE SerialNum = '68569033' AND InventoryItemNum='1118698'

--SELECT * FROM FixedAssets WHERE SerialNum = '127607510205' AND InventoryItemNum='2194446'


UPDATE FixedAssets 
SET ParentNumber= null, ParentFixedAssetId = Null, TopLevelFixedAssetId = NULL, EquipmentStatus = 'AV'
WHERE FixedAssetId ='87CA6BB6-D5B3-4C85-ADF6-A5E500A2C24A'

UPDATE FixedAssets 
SET ParentNumber= '2710109', ParentFixedAssetId = 'C95B6459-181A-4550-BB53-0AFED9BD252F', TopLevelFixedAssetId ='C95B6459-181A-4550-BB53-0AFED9BD252F', EquipmentStatus = 'IN'
WHERE FixedAssetId ='87CA6BB6-D5B3-4C85-ADF6-A5E500A2C24A'

