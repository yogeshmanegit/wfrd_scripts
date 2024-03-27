BEGIN TRAN

DECLARE @SNOWIncidentNumber varchar(20) = 'INC0515018'

DECLARE @UserId INT
SELECT @UserId = UserId from Users WHERE Email ='Aleksey.Panchenko@weatherford.com'

DECLARE @ARTs table (AssetRepairTrackId uniqueidentifier)
INSERT INTO @ARTs
SELECT a.AssetRepairTrackId
FROM AssetRepairTrack a 
JOIN (VALUES
('1025220396-ART')
,('1025220372-ART')
) AIRT(A) ON AIRT.A = a.ARTNumber
where a.Status = 'Open'

DECLARE @AssetRepairTrackId uniqueidentifier

DECLARE cursor_airt CURSOR
    FOR  SELECT * from @ARTs
OPEN cursor_airt;

FETCH NEXT FROM cursor_airt INTO @AssetRepairTrackId;
WHILE @@FETCH_STATUS = 0  
    BEGIN

		DECLARE @CanCloseAIRT bit = 0

		------------------------------------------ Test and Inspection stage


		IF EXISTS (SELECT * FROM PFTWO WHERE AssetRepairTrackId = @AssetRepairTrackId AND PFTType = 2 AND Active = 1)
		BEGIN

			-- Skip to Service
			UPDATE PFTWO SET ReasonForChange = 'Closed – Skip to Services', Active = 0 
			WHERE AssetRepairTrackId = @AssetRepairTrackId AND PFTType = 2 AND Active = 1
			
		END

		
		DECLARE @comment varchar(100) = 'Closed as per request ' + @SNOWIncidentNumber
		DECLARE @BranchPlant int
		SELECT @BranchPlant = FromBranchPlant FROM AssetRepairTrack where AssetRepairTrackId = @AssetRepairTrackId

		------------------------------------------ Disposition Stage

		--Preventive disposition
		IF EXISTS (SELECT * FROM PMDispositions WHERE AssetRepairTrackId = @AssetRepairTrackId AND Active = 1)
		BEGIN
			
			UPDATE PMDispositions
			SET DispositionedById = @UserId,
				DispositionOption = 0,
				DispositionedOn = GETDATE(),
				Active = 0
			WHERE AssetRepairTrackId = @AssetRepairTrackId AND (Active = 1 OR DispositionOption = 1)

		END

		-- No Disposition present or not approved
		IF NOT EXISTS(SELECT * FROM ARTDispositions where AssetRepairTrackId = @AssetRepairTrackId AND Status = 'Approved')
		BEGIN

			exec [dbo].[usp_CBM_SubmitDisposition] @AssetRepairTrackId, @UserId, @UserId, 4, 0, @comment, 0

			-- AIRT can be Closed Now
			SET @CanCloseAIRT = 1

		END


		----------------------------------------------- Repair stage ----------------------------------------------------------

		IF(@CanCloseAIRT != 1)
		BEGIN

			-- If No Pft's are created then rollback disposition
			IF NOT EXISTS (SELECT * FROM PFTWO WHERE AssetRepairTrackId = @AssetRepairTrackId)
				BEGIN
					exec [dbo].[usp_CBM_RollbackDisposition] @AssetRepairTrackId, @UserId

					exec [dbo].[usp_CBM_SubmitDisposition] @AssetRepairTrackId, @UserId, @UserId, 4, @BranchPlant, @comment, 0

					SET @CanCloseAIRT = 1
				END

			-- If all PFT's are open and no work done
			ELSE IF ( (SELECT COUNT(*) FROM PFTWO where AssetRepairTrackId = @AssetRepairTrackId AND Active = 1 AND PFTType IN (1,3)) 
						= (SELECT COUNT(*) FROM PFTWO where AssetRepairTrackId = @AssetRepairTrackId AND PFTType IN (1,3))
					)
				BEGIN
				
					exec [dbo].[usp_CBM_RollbackDisposition] @AssetRepairTrackId, @UserId

					exec [dbo].[usp_CBM_SubmitDisposition] @AssetRepairTrackId, @UserId, @UserId, 4, @BranchPlant, @comment, 0

					SET @CanCloseAIRT = 1

				END
				-- If all pft's are open
			ELSE
				BEGIN

					-- Close S&R PFT and Preventive Maintenance
					UPDATE PFTWO 
						SET CurPFTWOSeqId = NULL, ReasonForChange = 'Closed - TRS Testing', Active = 0, UpdatedBy = @UserId
					WHERE AssetRepairTrackId = @AssetRepairTrackId AND PFTType in (1,3) AND Active = 1

					-- Close work order open if any
					UPDATE w 
					SET w.Status = 'Closed',
						w.DateClosed = GETDATE(),
						w.ClosedBy = @UserId
					FROM WorkOrders w JOIN PFTWO p on w.WorkOrderId = p.WorkOrderId 
							WHERE p.AssetRepairTrackId = @AssetRepairTrackId AND w.Status = 'Open'

					SET @CanCloseAIRT = 1

				END
		END

		---------------------------------------- Close AIRT stage

		IF @CanCloseAIRT = 1
		BEGIN
			UPDATE AssetRepairTrack 
			SET Status = 'Closed', 
				DateClosed = GETDATE(), 
				Comments = 'Closed by helpdesk as per ' + @SNOWIncidentNumber 
			WHERE AssetRepairTrackId = @AssetRepairTrackId
		END
		ELSE
			print 'AIRT not closed ' + Convert(varchar(100), @AssetRepairTrackId)

        FETCH NEXT FROM cursor_airt INTO @AssetRepairTrackId;  
    END;

CLOSE cursor_airt;
DEALLOCATE cursor_airt;


commit TRAN