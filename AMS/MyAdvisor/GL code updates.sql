select 
b.src_key_cd, g.glcode,
b.Group_Abbr, g.GroupPLShort, 
b.GroupPL, g.GroupPL,
b.Segment_ABBR, g.SegmentPLShort, 
b.SegmentPL, g.SegmentPL, 
b.product_line_code, g.ProductLineService,
b.Product_Line, g.ProductLine, 
b.Src_DESC, g.Description
from USPDSQLSHR01.[DSTOPSPRD].[dbo].[GLProductLineStructure] b
join GLCodes g on b.src_key_cd = g.glcode
WHERE 
--b.Group_Abbr !=  g.GroupPLShort OR 
--b.GroupPL <>  g.GroupPL OR
b.Segment_ABBR <>  g.SegmentPLShort OR
b.SegmentPL <> g.SegmentPL --OR
--b.product_line_code <> g.ProductLineService OR
--b.Product_Line <> g.ProductLine OR
--b.Src_DESC <> g.Description

BEGIN TRAN

select * into GLProductLines_09272021 from GLProductLines
select * into GLCodes_09272021 from GLCodes
select * into Users_09272021 from Users
select * into FailureCategories_09272021 from FailureCategories
select * into FailureSubCategories_09272021 from FailureSubCategories
select * into FailureCodes_09272021 from FailureCodes
select * into PFTObjects_09272021 from PFTObjects
select * into GLProductLineBranchPlantMappings_09272021 from GLProductLineBranchPlantMappings

-- Rename 'Intervention Services' --> Intervention Services & Drilling Tools in from GLProductline
UPDATE GLProductLines SET Description ='ISDT - Intervention Services & Drilling Tools', Code ='Intervention Services & Drilling Tools' WHERE ID = 9

-- Move DRT glcodes to 'Intervention Services & Drilling Tools' product line
UPDATE GLCodes SET SegmentPLShort ='ISDT', SegmentPL ='ISDT - Intervention Services & Drilling Tools', GLProductLineId = 9
WHERE SegmentPLShort ='DRT' OR SegmentPLShort ='INTS'

-- Delete 'Drilling Tools' from GLProductline
DELETE FROM GLProductLines WHERE Id = 18

-- Move users of DRT to --> Intervention Services & Drilling Tools
UPDATE Users SET DefaultProductLine = 9 WHERE DefaultProductLine = 18

-- Failure codes
UPDATE FailureCategories SET GLProductLineId = 9 where GLProductLineId = 18
UPDATE FailureSubCategories SET GLProductLineId = 9 where GLProductLineId = 18
UPDATE FailureCodes SET GLProductLineId = 9 where GLProductLineId = 18

-- PftObjects
UPDATE PFTObjects SET ProductLineId = 9 WHERE ProductLineId = 18

-- merge branch plants
select DISTINCT BranchPlant into #temp from GLProductLineBranchPlantMappings where GLProductLineId IN (9, 18)
DELETE from GLProductLineBranchPlantMappings where GLProductLineId IN (9, 18)
INSERT INTO GLProductLineBranchPlantMappings (GLProductLineId, BranchPlant, UpdatedBy, UpdatedOn) SELECT 9, BranchPlant, 'E220932', GETDATE() FROM #temp

UPDATE g
SET GroupPL = b.GroupPL,
	g.SegmentPLShort = b.Segment_ABBR,
	g.SegmentPL = b.SegmentPL,
	g.ProductLineService = b.product_line_code,
	g.ProductLine = b.Product_Line,
	g.Description = b.Src_DESC
from GLCodes g 
join USPDSQLSHR01.[DSTOPSPRD].[dbo].[GLProductLineStructure] b on b.src_key_cd = g.glcode

ROLLBACK TRAN

--UPDATE GLCodes SET ProductLine ='LWD/HEL' where ProductLine ='Logging While Drilling'
--UPDATE GLCodes SET ProductLine ='EM/MWD' where ProductLine ='Measuring While Drilling'
