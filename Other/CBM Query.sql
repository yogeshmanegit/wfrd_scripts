ALTER PROCEDURE dbo.usp_CBM_MonitorCalculatedMeterReadings
	@JobNumber VARCHAR(50)
AS

	DECLARE @DateNow Datetime, @TopLevelFixedAssetId uniqueidentifier, @AssetRepairTrackId uniqueidentifier

	DECLARE @CBMRunAssetMappings TABLE
	(
		RunId uniqueidentifier,
		FixedAssetId uniqueidentifier,
		ImportDate datetime,
		PFTConfigId uniqueidentifier,
		MeterReadingTypeId int
	)

	-- SELECT AFFECTED FixedAssets
	INSERT INTO @CBMRunAssetMappings
	SELECT DISTINCT R.RunID, FA.FixedAssetId, R.ImportDate, CM.PFTConfigId, CM.MeterReadingTypeId
	FROM	Runs R (NOLOCK) 
		INNER JOIN Wells w (NOLOCK) ON r.WellID = w.WellID
		INNER JOIN Jobs	j (NOLOCK) ON j.JobId = w.JobID
		INNER JOIN ToolStringComponentInfo(NOLOCK) TCI ON TCI.RunID = R.RunID
		INNER JOIN FixedAssets(NOLOCK) FA ON ISNULL(FA.TopLevelFixedAssetId,FA.FixedAssetId) = TCI.FixedAssetId
		INNER JOIN PartDescPFTConfigs(NOLOCK) PDT ON PDT.ItemNum = FA.InventoryItemNum AND PFTType = 3
		INNER JOIN CBMMonitor(NOLOCK) CM ON CM.PFTConfigId = PDT.PFTConfigID AND CM.Active = 1
	WHERE j.JobNumber = @JobNumber


	-- DELETE Existing Records if any with same run id
	DELETE FROM CBMRunAssetMappings WHERE RunId IN (SELECT DISTINCT RunId FROM @CBMRunAssetMappings)

	SET @DateNow = GETDATE()

	-- Insert Run and Fixed Asset
	INSERT INTO CBMRunAssetMappings (RunId, FixedAssetId, ImportDate, CreatedOn)
	SELECT DISTINCT RunId, FixedAssetId, ImportDate, @DateNow  FROM @CBMRunAssetMappings

	-- Recalculate the meter readings
	DECLARE @MeterReadingTypeId int
	DECLARE @FixedAssetId UNIQUEIDENTIFIER
	DECLARE db_cursor1 CURSOR FOR  
	SELECT	DISTINCT FixedAssetId, MeterReadingTypeId FROM @CBMRunAssetMappings
	
	OPEN db_cursor1   
	FETCH NEXT FROM db_cursor1 INTO @FixedAssetId, @MeterReadingTypeId

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
		DECLARE @LastMeterReadingValue DECIMAL(18,2)
		DECLARE @LifeTimeValue DECIMAL(18,2)
  	 
		IF NOT EXISTS (SELECT * FROM dbo.CBMCalculatedMeterReadings (NOLOCK) WHERE FixedAssetId = @FixedAssetId AND MeterReadingTypeId = @MeterReadingTypeId)
		BEGIN
			INSERT INTO dbo.CBMCalculatedMeterReadings  (FixedAssetId, MeterReadingTypeId, LastMeterReadingValue, LifeTimeValue, UpdatedOn)
			SELECT @FixedAssetId, @MeterReadingTypeId, '0', '0', GETDATE()
		END

		IF (@MeterReadingTypeId = 1)
			BEGIN
				EXEC usp_GetActualMeterReading @FixedAssetId, @MeterReadingTypeId, @LastMeterReadingValue OUT, @LifeTimeValue OUT
			END

		ELSE IF (@MeterReadingTypeId = 2)
			BEGIN
				EXEC usp_GetActualMeterReading @FixedAssetId, @MeterReadingTypeId, @LastMeterReadingValue OUT, @LifeTimeValue OUT
			END

			UPDATE	dbo.CBMCalculatedMeterReadings
			SET		LastMeterReadingValue = @LastMeterReadingValue,
					LifeTimeValue = @LifeTimeValue,
					UpdatedOn = GETDATE()
			WHERE	FixedAssetId = @FixedAssetId AND MeterReadingTypeId = @MeterReadingTypeId


		SELECT @TopLevelFixedAssetId = ISNULL(TopLevelFixedAssetId, FixedAssetId) FROM FixedAssets (NOLOCK) WHERE FixedAssetId = @FixedAssetId
		SELECT @AssetRepairTrackId = AssetRepairTrackId FROM AssetRepairTrack (NOLOCK) WHERE FixedAssetId = @TopLevelFixedAssetId AND Status = 'Open'
	
		IF (@AssetRepairTrackId != null)
			BEGIN
				

				INSERT INTO PMDispositionItems (AssetRepairTrackId, FixedAssetId, PFTConfigId, MeterReadingTypeId, TriggerValue, MeterReadingValue, CreatedOn)
				SELECT @AssetRepairTrackId, c.FixedAssetId, c.PFTConfigId, c.MeterReadingTypeId, dbo.GetCBMMonitorTriggerValue(@AssetRepairTrackId, c.PFTConfigId, c.MeterReadingTypeId),
					@LastMeterReadingValue, GETDATE()
				FROM @CBMRunAssetMappings c
				LEFT JOIN PMDispositionItems i ON i.FixedAssetId = c.FixedAssetId AND c.MeterReadingTypeId = i.MeterReadingTypeId
				WHERE C.FixedAssetId = @FixedAssetId AND c.MeterReadingTypeId = @MeterReadingTypeId
					AND dbo.GetCBMMonitorTriggerValue(@AssetRepairTrackId, c.PFTConfigId, c.MeterReadingTypeId) <= @LastMeterReadingValue
					AND i.FixedAssetId IS NULL

				INSERT INTO dbo.PMDispositions (PMDispositionId, AssetRepairTrackId, PFTConfigId, Active, CreatedBy, CreatedOn)
				SELECT	NEWID() [PMDispositionId], i.AssetRepairTrackId,  i.PFTConfigId, 1 [Active], 0 [CreatedBy], GETDATE() [CreatedOn]
				FROM PMDispositionItems i
				LEFT JOIN  PMDispositions p (NOLOCK) ON p.AssetRepairTrackId = i.AssetRepairTrackId AND p.PFTConfigId = i.PFTConfigId
				WHERE p.PMDispositionId IS NULL
				GROUP BY i.AssetRepairTrackId,  i.PFTConfigId

			END


		FETCH NEXT FROM db_cursor1 INTO @FixedAssetId, @MeterReadingTypeId
	END

	CLOSE db_cursor1   
	DEALLOCATE db_cursor1