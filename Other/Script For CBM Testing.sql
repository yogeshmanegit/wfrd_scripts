
SELECT * FROM CBMRunAssetMappings 

exec [usp_CBM_MonitorCalculatedMeterReadings] 'TH15144'


SELECT *
FROM CBMCalculatedMeterReadings 
ORDER BY 2, 3