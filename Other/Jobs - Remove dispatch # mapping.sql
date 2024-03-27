

DECLARE @JobNumber VARCHAR(50) = 'MD-13298842'
DECLARE @DispatchNumber int 
DECLARE @JobId uniqueidentifier
DECLARE @MappingCount int

select @DispatchNumber = DispatchNumber from Jobs where JobNumber = @JobNumber and RevenueStatus ='Cancelled'
select @JobId = JobId from Dispatches where DispatchNumber = @DispatchNumber
SELECT @MappingCount = COUNT(*) from Jobs where JobNumber = @JobNumber

IF (@DispatchNumber IS NULL OR @JobId IS NULL OR @MappingCount != 1)
BEGIN
	RAISERROR ('Dispatch # or JobId is null or multiple jobs already mapped to same Dispatch #', 16, 1); 
END
ELSE
BEGIN
	BEGIN TRAN

		--select DispatchNumber, * from Jobs where JobId = @JobId

		--select JobId, * from Dispatches where DispatchNumber = @DispatchNumber

		update Dispatches set JobId = null where DispatchNumber = @DispatchNumber

		update Jobs set DispatchNumber = null where JobId = @JobId

		select DispatchNumber, * from Jobs where JobId = @JobId

		select JobId, * from Dispatches where DispatchNumber = @DispatchNumber

	ROLLBACK TRAN
END