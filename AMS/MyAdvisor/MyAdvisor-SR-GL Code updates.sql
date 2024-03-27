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
b.Group_Abbr !=  g.GroupPLShort OR 
b.GroupPL <>  g.GroupPL OR
b.Segment_ABBR <>  g.SegmentPLShort OR
b.SegmentPL <> g.SegmentPL --OR
b.product_line_code <> g.ProductLineService OR
b.Product_Line <> g.ProductLine OR
b.Src_DESC <> g.Description

select --g.SRC_KEY_CD, c.GLCode, g.SRC_DESC, g.GroupPL, g.Group_Abbr, g.SegmentPL, g.Segment_ABBR, g.product_Line, g.Product_Line_Code, g.DateModified,
'Update GLCodes SET Description =''' + ISNULL(g.SRC_DESC,'') 									  + ''''
+ ', UpdatedOn = ''' + CONVERT(varchar(MAX), g.DateModified, 21)					  + ''''
+ ', GroupPL = ''' + g.GroupPL														  + ''''
+ ', GroupPLShort = ''' + g.Group_Abbr												  + ''''
, ', SegmentPL = ''' + g.SegmentPL													  + ''''
+ ', SegmentPLShort = ''' + g.Segment_Abbr											  + ''''
+ ', ProductLine = ''' + g.Product_Line												  + ''''
+ ', ProductLineService = ''' + REPLACE(LTRIM(RTRIM(g.Product_Line_Code)),' ','')	  + ''''
+ ' WHERE GLCode = ''' + c.GLCode + ''''
from USPDSQLSHR01.[DSTOPSPRD].[dbo].[GLProductLineStructure] g
join GLCodes c on SRC_KEY_CD = c.GLCode

SELECT --g.SRC_KEY_CD, c.GLCode, g.SRC_DESC, g.GroupPL, g.Group_Abbr, g.SegmentPL, g.Segment_ABBR, g.product_Line, g.Product_Line_Code, g.DateModified,
'INSERT INTO GLCodes (GLCode, Description, UpdatedBy, UpdatedOn, GroupPL, GroupPLShort, SegmentPL, SegmentPLShort, ProductLine, ProductLineService) SELECT '
, ''''+ g.SRC_KEY_CD + ''''
+ ',''' + ISNULL(g.SRC_DESC,'') + ''''
+ ',''E220932'''
+ ',''' + CONVERT(varchar(MAX), g.DateModified, 21) + ''''
+ ','''+ g.GroupPL + ''''
+ ','''+ g.Group_Abbr + ''''
+ ','''+ g.SegmentPL + ''''
+ ','''+ g.Segment_Abbr + ''''
+ ','''+ g.Product_Line + ''''
+ ','''+ g.Product_Line_Code + ''''
from USPDSQLSHR01.[DSTOPSPRD].[dbo].[GLProductLineStructure] g
LEFT join GLCodes c on SRC_KEY_CD = c.GLCode
WHERE c.GLCode IS NULL

--UPDATE GLCodes SET ProductLine ='LWD/HEL' where ProductLine ='Logging While Drilling'
--UPDATE GLCodes SET ProductLine ='EM/MWD' where ProductLine ='Measuring While Drilling'
