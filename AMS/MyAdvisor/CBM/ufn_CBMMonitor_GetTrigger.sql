--======================================================
--CREATED BY : Yogesh
--CREATED ON : 25 May 2023
--DESCRIPTION: To get CBM trigger value
--=======================================================
ALTER FUNCTION [dbo].[ufn_CBMMonitor_GetTrigger] (
	@CbmMonitorId int,
	@BranchPlant VARCHAR(75),
	@FixedAssetID uniqueidentifier
)
RETURNS decimal(18, 5)
AS
BEGIN

  DECLARE @MeterReadingTypeId int
	
  SELECT @MeterReadingTypeId = MeterReadingTypeId from CBMMonitor (NOLOCK) where CBMMonitorId = @CbmMonitorId

  IF (@MeterReadingTypeId = 4)
	RETURN 0

  DECLARE @Region VARCHAR(MAX)
  SELECT  @Region = Region FROM BranchPlants (NOLOCK) WHERE BranchPlant = @BranchPlant
  
  DECLARE @RegionTriggerValue decimal(18, 2) = NULL
  DECLARE @BPTriggerValue decimal(18, 2) = NULL
  DECLARE @GlobalTrigger decimal(18, 2) = NULL

  SELECT @GlobalTrigger = GlobalTrigger, @RegionTriggerValue = cc.TriggerValue, @BPTriggerValue = cc1.TriggerValue
  FROM CBMMonitor c (NOLOCK)
  LEFT JOIN CBMMonitorCustoms cc (NOLOCK) ON cc.ObjectNumber = c.ObjectNumber AND cc.MeterReadingTypeId = c.MeterReadingTypeId 
		  AND cc.TriggerType = 'R' AND cc.TriggerName = @Region
  LEFT JOIN CBMMonitorCustoms cc1 (NOLOCK) ON cc1.ObjectNumber = c.ObjectNumber AND cc1.MeterReadingTypeId = c.MeterReadingTypeId 
		  AND cc1.TriggerType = 'B' AND cc1.TriggerName = @BranchPlant
  WHERE c.CBMMonitorId = @CbmMonitorId

  RETURN COALESCE(@BPTriggerValue, @RegionTriggerValue, @GlobalTrigger)

END