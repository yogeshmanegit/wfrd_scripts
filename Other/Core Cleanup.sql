ALTER TABLE COREFiles
ALTER COLUMN InputXML XML NULL
GO

-- =============================================
-- Author:		Yogesh Mane
-- Create date: 05/01/2019
-- Description:	 Update core files to reduce space used
-- =============================================
CREATE PROCEDURE [dbo].[usp_Cleanup_CoreFiles]
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @TotalRecords BIGINT
		
	-- Step 1: for failed request where request is older than 2 months then update InputXML, BaseXML to null
	SELECT @TotalRecords = COUNT(*) 
	FROM Corefiles (NOLOCK)
	WHERE CreatedOn < DATEADD(MONTH, - 2, CAST(GETDATE() AS DATE)) AND ISNULL(Status,0) = 0 
	AND (InputXML IS NOT NULL OR BaseXML IS NOT NULL)

	WHILE (@TotalRecords > 0)
	BEGIN

		UPDATE TOP (100) c
		SET InputXML = NULL, BaseXML = NULL
		FROM Corefiles (NOLOCK) C
		WHERE CreatedOn < DATEADD(MONTH, - 2, CAST(GETDATE() AS DATE)) AND ISNULL(Status,0) = 0 
		AND (InputXML IS NOT NULL OR BaseXML IS NOT NULL)
		
		SET @TotalRecords = @TotalRecords - 100	

	END

	
	--Reset counter
	SET @TotalRecords = 0

	-- Step 2: for failed request where request is less than 2 month old then update basexml to null
	SELECT @TotalRecords = COUNT(*) 
	FROM Corefiles (NOLOCK)
	WHERE CreatedOn BETWEEN DATEADD(MONTH, - 1, CAST(GETDATE() AS DATE)) AND DATEADD(MONTH, - 2, CAST(GETDATE() AS DATE)) 
		AND ISNULL(Status,0) = 0 AND BaseXML IS NOT NULL

	WHILE (@TotalRecords > 0)
	BEGIN

		UPDATE TOP (100) c
		SET InputXML = NULL, BaseXML = NULL
		FROM Corefiles (NOLOCK) c
		WHERE CreatedOn > DATEADD(MONTH, - 2, CAST(GETDATE() AS DATE)) AND ISNULL(Status,0) = 0 AND BaseXML IS NOT NULL
		
		SET @TotalRecords = @TotalRecords - 100	

	END

	
	--Reset counter
	SET @TotalRecords = 0

	
	-- Step 3: for sucess request where request is older than 2 month then update basexml to null
	SELECT @TotalRecords = COUNT(*)
	FROM Corefiles (NOLOCK)
	WHERE CreatedOn < DATEADD(MONTH, - 2, CAST(GETDATE() AS DATE)) AND ISNULL(Status,0) = 1 AND BaseXML IS NOT NULL

	WHILE (@TotalRecords > 0)
	BEGIN

		UPDATE TOP (100) c
		SET InputXML = NULL, BaseXML = NULL
		FROM Corefiles (NOLOCK) C
		WHERE CreatedOn < DATEADD(MONTH, - 2, CAST(GETDATE() AS DATE)) AND ISNULL(Status,0) = 1 AND BaseXML IS NOT NULL
		
		SET @TotalRecords = @TotalRecords - 100	

	END
	
END