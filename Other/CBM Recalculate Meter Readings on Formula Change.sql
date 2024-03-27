DECLARE @FixedAssetId UNIQUEIDENTIFIER, @TopLevelFixedAssetId uniqueidentifier
DECLARE @MeterReadingTypeId int

DECLARE db_cursor1 CURSOR FOR  
	SELECT fixedassetid, MeterReadingTypeId from CBMCalculatedMeterReadings WHERE MeterReadingTypeId = 7	
OPEN db_cursor1   
FETCH NEXT FROM db_cursor1 INTO @FixedAssetId, @MeterReadingTypeId

WHILE @@FETCH_STATUS = 0   
BEGIN

	DECLARE @LastMeterReadingValue DECIMAL(18,2)
	DECLARE @LifeTimeValue DECIMAL(18,2)
  	 
	IF(@MeterReadingTypeId = 7)
	BEGIN
		EXEC [dbo].[usp_CBM_MeterReadings_GetByVibrationHistogram] @FixedAssetId, @LastMeterReadingValue OUT, @LifeTimeValue OUT
	END

	DECLARE @DefaultMeterReading decimal

		SELECT @DefaultMeterReading = (CASE WHEN ISNULL(c.EffectiveDate,GETDATE()) > ISNULL((SELECT MIN(DateOfTransaction) 
																							FROM PartTransferDtl WHERE FixedAssetId = f.fixedAssetId AND Dest ='IN'),f.DateAdded) 
											THEN DefaultMeterReading ELSE 0 END)
		FROM dbo.CBMCalculatedMeterReadings r
		JOIN FixedAssets f ON r.FixedAssetId = f.FixedAssetId 
		JOIN FixedAssets f1 ON f1.FixedAssetId = f.TopLevelFixedAssetId
		JOIN CBMMonitorAssetItemNums p ON p.ItemNum = f.InventoryItemNum and p.IsParent = 0
		JOIN CBMMonitorAssetItemNums a ON a.ItemNum = f1.InventoryItemNum and a.IsParent = 1
		JOIN CBMMonitor c ON c.CBMMonitorId = a.CBMMonitorId and c.CBMMonitorId = p.CBMMonitorId and c.Active = 1
		WHERE f.FixedAssetId = @FixedAssetId and c.MeterReadingTypeId = @MeterReadingTypeId
		

		UPDATE	dbo.CBMCalculatedMeterReadings
			SET		LastMeterReadingValue = ISNULL(@LastMeterReadingValue,0) + ISNULL(@DefaultMeterReading,0),
					LifeTimeValue = ISNULL(@LifeTimeValue,0) + ISNULL(@DefaultMeterReading,0),
					UpdatedOn = GETDATE()
			WHERE	FixedAssetId = @FixedAssetId AND MeterReadingTypeId = @MeterReadingTypeId


		FETCH NEXT FROM db_cursor1 INTO @FixedAssetId, @MeterReadingTypeId
	END

	CLOSE db_cursor1   
	DEALLOCATE db_cursor1