USE OpsFileMgr;

--="Insert into FileManagementMetadata select '" &A2&"','"&B2&"','"&C2&"','"&D2&"','"&E2&"','"&F2&"','"&G2&"','"&H2&"','"&I2&"','"&J2&"','"&K2&"','"&L2&"','"&M2&"',null"

DECLARE @Files TABLE (ServiceOrder nvarchar(50), FileName nvarchar(500))
INSERT INTO @Files SELECT '17613-310050109', 'CHECK LIST CERO TOLERANCIA POZO LY-089.pdf'

BEGIN
	SELECT * 
	INTO #tempFileManagementMetadata
	FROM FileManagementMetadata WHERE 1 = 2
	

	BEGIN TRY

		BEGIN TRAN

			DECLARE @JobId uniqueidentifier, @ServiceOrder nvarchar(50), @FileName nvarchar(500), @FileId VARCHAR(255)

			-- Declare cursor to loop over each file to be deleted
			DECLARE db_cursor1 CURSOR FOR 
				SELECT ServiceOrder, FileName FROM @Files

			OPEN db_cursor1
			FETCH NEXT FROM db_cursor1 INTO @ServiceOrder, @FileName

			WHILE @@FETCH_STATUS = 0   
			BEGIN   

				--get job id from job table based on service order number provided
				SELECT @JobId = jobID FROM oneview..Job WHERE serviceOrder = @ServiceOrder and ISNULL(deleted,0) = 0

				--delete file record based on job id and file name

				DELETE FROM FileManagementMetadata 
				OUTPUT DELETED.* INTO #tempFileManagementMetadata
				WHERE Id like 'OneView/Jobs/%/' + CONVERT(varchar(36), @JobId) + '/Internal/' + @FileName 

				IF(@@ROWCOUNT != 1)
				BEGIN
				
					DECLARE @ErrorMessage NVARCHAR(100) = 'Error deleting file for Service Order : ' + @ServiceOrder + ', File Name :' + @FileName
					RAISERROR (@ErrorMessage, 16, 1);
					
				END
			FETCH NEXT FROM db_cursor1 INTO @ServiceOrder, @FileName
			END

			CLOSE db_cursor1   
			DEALLOCATE db_cursor1

		
		COMMIT TRAN
		
		SELECT * FROM #tempFileManagementMetadata

	END TRY
	BEGIN CATCH
		
		ROLLBACK TRAN

			DECLARE @ErrMsg AS NVARCHAR(4000) = '',
							@ErrSeverity AS INT = 0,
							@ErrState AS INT = 0;

			-- Server/ Database errors
			SELECT @ErrMsg = ERROR_MESSAGE(), 
					@ErrSeverity = ERROR_SEVERITY(), 
					@ErrState = ERROR_STATE();

			RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);

	END CATCH

	DROP TABLE #tempFileManagementMetadata
END