
DECLARE @ARTNumber VARCHAR(25) = '', @NewJDEWorkOrderNum VARCHAR(30) = ''

UPDATE PFTWO SET JDEWorkOrderNum = (SELECT JDEWorkOrderNum FROM PFTWO WHERE PFTType = 1 
										AND AssetRepairTrackId IN (SELECT AssetRepairTrackId FROM AssetRepairTrack WHERE ARTNumber = @ARTNumber))
WHERE AssetRepairTrackId = (SELECT AssetRepairTrackId FROM AssetRepairTrack WHERE ARTNumber = @ARTNumber) AND PFTType = 2 AND JDEWorkOrderNum IS NULL


UPDATE PFTWO SET JDEWorkOrderNum = @NewJDEWorkOrderNum
WHERE AssetRepairTrackId = (SELECT AssetRepairTrackId FROM AssetRepairTrack WHERE ARTNumber = @ARTNumber) AND PFTType = 1

UPDATE WorkOrders SET JDEWorkOrderNum = @NewJDEWorkOrderNum
WHERE WorkOrderId = (SELECT WorkOrderId FROM PFTWO WHERE PFTType = 1 
										AND AssetRepairTrackId IN (SELECT AssetRepairTrackId FROM AssetRepairTrack WHERE ARTNumber = @ARTNumber))