SET NOCOUNT ON

BEGIN TRAN

-- By default set all records as inactive
UPDATE OrgDataLevel1 SET Active = 0 
UPDATE OrgDataLevel2 SET Active = 0 
UPDATE OrgDataLevel3 SET Active = 0 
UPDATE OrgDataLevel4 SET Active = 0 

DECLARE 
	@GROUPPL			NVARCHAR(510),
	@GROUP_CODE			NVARCHAR(510),
	@SEGMENTPL			NVARCHAR(510),
	@SEGMENT_CODE		NVARCHAR(510),
	@PRODUCT_LINE		NVARCHAR(510),
	@PROD_LINE_CODE		NVARCHAR(510),
	@PRODUCT_SERVICE	NVARCHAR(510),
	@BASE_CODE			NVARCHAR(510)


DECLARE db_cursor CURSOR FOR 
	SELECT GROUPPL, GROUP_CODE, SEGMENTPL, SEGMENT_CODE, PRODUCT_LINE, PROD_LINE_CODE, PRODUCT_SERVICE, BASE_CODE
	FROM NewMDMPLData
	ORDER BY BASE_CODE
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @GROUPPL, @GROUP_CODE, @SEGMENTPL, @SEGMENT_CODE, @PRODUCT_LINE, @PROD_LINE_CODE, @PRODUCT_SERVICE, @BASE_CODE

WHILE @@FETCH_STATUS = 0  
BEGIN  
      
	  -- Have to reset to null to avoid issues
	  DECLARE @Level1Id int = NULL,  @Level1Code varchar(100)  = NULL, @Level1Name varchar(100) = NULL,
			  @Level2Id int = NULL,  @Level2Code varchar(100)  = NULL, @Level2Name varchar(100) = NULL,
			  @Level3Id int = NULL,  @Level3Code varchar(100)  = NULL, @Level3Name varchar(100) = NULL,
			  @Level4Id int = NULL,  @Level4Code varchar(100)  = NULL, @Level4Name varchar(100) = NULL

	  SELECT @Level1Id = Level1Id from OrgDataLevel1 WHERE MDMLevel1Code = @GROUP_CODE			 ORDER BY Level1Id DESC
	  SELECT @Level2Id = Level2Id from OrgDataLevel2 WHERE MDMLevel2Code = @SEGMENT_CODE		 ORDER BY Level2Id DESC
	  SELECT @Level3Id = Level3Id from OrgDataLevel3 WHERE MDMLevel3Code = @PROD_LINE_CODE		 ORDER BY Level3Id DESC
	  SELECT @Level4Id = Level4ID from OrgDataLevel4 WHERE MDMLevel4Code = @BASE_CODE			 ORDER BY Level4Id DESC


	  IF @Level1Id IS NULL
		BEGIN
			--insert level1 code is missing
			
			INSERT INTO OrgDataLevel1 (MDMLevel1Code, Level1Name, Active) VALUES (@GROUP_CODE, @GROUPPL, 1)
			SET @Level1Id = SCOPE_IDENTITY()
		END
	  ELSE
		BEGIN
		
			UPDATE OrgDataLevel1 SET Level1Name = @GROUPPL, Active = 1 WHERE Level1ID = @Level1Id
		END

	  IF @Level2Id IS NULL
		BEGIN

			INSERT INTO OrgDataLevel2 (MDMLevel2Code, Level2Name, Level1ID, MDMLevel1Code, Active) VALUES (@SEGMENT_CODE, @SEGMENTPL, @Level1Id, @GROUP_CODE, 1)
			SET @Level2Id = SCOPE_IDENTITY()
		END
	  ELSE
		BEGIN

			UPDATE OrgDataLevel2 SET Level2Name = @SEGMENTPL, Level1ID = @Level1Id, MDMLevel1Code = @SEGMENT_CODE, Active = 1 WHERE Level2Id = @Level2Id
		END

	  IF @Level3Id IS NULL
		BEGIN
			
			INSERT INTO OrgDataLevel3 (MDMLevel3Code, Level3Name, Level2ID, MDMLevel2Code, Active) VALUES (@PROD_LINE_CODE, @PRODUCT_LINE, @Level2Id, @SEGMENT_CODE, 1)
			SET @Level3Id = SCOPE_IDENTITY()
		END
	  ELSE
		BEGIN

			UPDATE OrgDataLevel3 SET Level3Name = @PRODUCT_LINE, Level2ID = @Level2Id, MDMLevel2Code = @PROD_LINE_CODE, Active = 1 WHERE Level3Id = @Level3Id
		END


	  IF @Level4Id IS NULL
		BEGIN

			INSERT INTO OrgDataLevel4 (MDMLevel4Code, Level4Name, Level3ID, MDMLevel3Code, Active) VALUES (@BASE_CODE, @PRODUCT_SERVICE, @Level3Id, @PROD_LINE_CODE, 1)
			SET @Level4Id = SCOPE_IDENTITY()
		END
	  ELSE
		BEGIN
			
			UPDATE OrgDataLevel4 SET Level4Name = @PRODUCT_SERVICE, Level3ID = @Level3Id, MDMLevel3Code = @PROD_LINE_CODE, Active = 1 WHERE Level4Id = @Level4Id

		END

      FETCH NEXT FROM db_cursor INTO @GROUPPL, @GROUP_CODE, @SEGMENTPL, @SEGMENT_CODE, @PRODUCT_LINE, @PROD_LINE_CODE, @PRODUCT_SERVICE, @BASE_CODE
END 

CLOSE db_cursor  
DEALLOCATE db_cursor 


SELECT 
	l1.Level1ID, l1.Level1Name, l1.MDMLevel1Code, n.GROUP_CODE,
	l2.Level2ID, l2.MDMLevel2Code, l2.Level2Name, n.SEGMENT_CODE,
	l3.Level3ID, l3.MDMLevel3Code,  n.PROD_LINE_CODE, l3.Level3Name,
	l4.Level4ID, l4.MDMLevel4Code, n.BASE_CODE, l4.Level4Name,
CASE WHEN l3.MDMLevel3Code != n.PROD_LINE_CODE OR l2.MDMLevel2Code != n.SEGMENT_CODE OR l1.MDMLevel1Code != n.GROUP_CODE THEN 1 ELSE 0 END
FROM OrgDataLevel1 l1
JOIN OrgDataLevel2 l2 on l2.Level1ID = l1.Level1ID
JOIN OrgDataLevel3 l3 on l3.Level2ID = l2.Level2ID
JOIN OrgDataLevel4 l4 on l4.Level3ID = l3.Level3ID and l4.active = 1
left join NewMDMPLData n on n.BASE_CODE = l4.MDMLevel4Code
ORDER BY MDMLevel4Code

COMMIT TRAN

-- DAR
