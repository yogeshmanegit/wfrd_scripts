--select PartNumber, 
--	ISNULL(CASE WHEN [MinorServiceType] = 'Yes' THEN 1 ELSE 0 END, 0) [Minor],
--	ISNULL(CASE WHEN [MajorServiceType] = 'Yes' THEN 1 ELSE 0 END, 0) [Major]
--FROM LH_FormFieldMapping
--WHERE PartNumber ='00101424'


-- Step 1: Declare the cursor
DECLARE my_cursor CURSOR FOR
SELECT top 1 [Name And Description]
FROM LH_MajorCollections;

-- Step 2: Declare a variable to hold data from the cursor
DECLARE @Name_And_Description varchar(1000);
DECLARE @partNumber varchar(10), @newCollectionObjectNumber int, @newCollectionObjectId int
-- Step 3: Open the cursor
OPEN my_cursor;

-- Step 4: Fetch the first row
FETCH NEXT FROM my_cursor INTO @Name_And_Description;

-- Step 5: Loop through the rows
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Perform operations with @variable_name
    SET @partNumber = SUBSTRING(@Name_And_Description, 0, CHARINDEX(',', @Name_And_Description, 0))

	SET @newCollectionObjectNumber = (Select MAX(ObjectNumber) + 1 FROM PFTObjects)

	-- create collection object for major
	--INSERT INTO PFTObjects (ObjectNumber, Revision, [Type], [Name], [Description], ProductLineId, State, CreatedBy, CreatedOn)
	--VALUES
	--(
	--	@newObjectNumber, 1,7, @Name_And_Description, @Name_And_Description,19,3, 'E220932', '2025-08-05'
	--)

	SELECT @newCollectionObjectId = SCOPE_IDENTITY()

	--INSERT INTO PFTObjectMappings(ParentId, ObjectId, SequenceNumber, CreatedBy, CreatedOn)
	SELECT @newCollectionObjectId, p.ObjectId, ROW_NUMBER() OVER(ORDER BY [Form field object Number]), 'E220932', '2025-08-05'
				FROM LH_FormFieldMapping m
				JOIN PFTObjects p on m.[Form field object Number] = p.ObjectNumber
				where PartNumber = RIGHT('00000000'+ CONVERT(VARCHAR,@partNumber),8)
				and MajorServiceType ='Yes'
    
	
	-- Fetch the next row
    FETCH NEXT FROM my_cursor INTO @Name_And_Description;
END;

-- Step 6: Close and deallocate the cursor
CLOSE my_cursor;
DEALLOCATE my_cursor;
