UPDATE i
SET i.MetaValue = '200-01-01'
FROM ItemNumMetadata i
WHERE MetaName = 'modifyTimestamp' 
and i.ItemNum in (
		SELECT bom.[ParentItem] 
		from (select DISTINCT [ParentItem] from USDCSCDSQLPD001.windchill_data.dbo.BillOfMaterials) bom
		LEFT JOIN (select Distinct ParentItemNum FROM ItemNumConfigs (NOLOCK)) itemconfig on itemconfig.ParentItemNum = CONVERT(varchar(20), bom.[ParentItem])
		WHERE itemconfig.ParentItemNum is null
)

exec [sp_ProcessItemNumConfig_Cursor]


--below query imports BOM structure
--INSERT INTO aesops.dbo.ItemNumConfigs
--	(
--		ItemNum, 
--		ParentItemNum, 
--		OptionText, 
--		LineNum, 
--		Qty, 
--		IsToolString, 
--		IsActive, 
--		IsMandatoryReplacement, 
--		IsRequired, 
--		UserIdAdded, 
--		DateAdded
--	)
--SELECT
--		b.[CompItem], 
--		b.[ParentItem], 
--		LTRIM(RTRIM(b.[FindNumber])), 
--		b.[Sequence], 
--		b.[Qty], 
--		0 [ToolString], 
--		1 [IsActive], 
--		0 [IsMandatoryReplacement],  
--		CASE WHEN (b.[Qty] > 0 
--				  and b.[FindNumber] <> 'OPTIONAL' 
--				  and b.[FindNumber] <> 'AR'
--				  and b.[FindNumber] <> 'REF'
--				  and (b.[FindNumber] like '%1' or b.[FindNumber] = ''))
--			THEN 1 
--			ELSE 0 
--		END [IsRequired], 
--		0 [UserIdAdded]
--		, GETDATE() [DateAdded]
--	FROM USDCSCDSQLPD001.windchill_data.dbo.BillOfMaterials b  WITH (NOLOCK)
--	WHERE ParentItem = '2617169'
