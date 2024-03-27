SELECT LTRIM(RTRIM([Asset_Number]))
		  ,LTRIM(RTRIM([Fixed_Asset_Company]))
		  ,LTRIM(RTRIM([Fixed_Asset_Branch_Plant]))
		  ,LTRIM(RTRIM([Asset_description1]))
		  ,LTRIM(RTRIM([Asset_description2]))  -- old serial number
		  ,LTRIM(RTRIM([Asset_description3]))  -- techid and other stuff
		  ,LTRIM(RTRIM([Parent_Number]))
		  ,LTRIM(RTRIM([Manufacturers_Serial_Number]))
		  ,LTRIM(RTRIM([Business_Unit]))
		  ,case LTRIM(RTRIM([Item_No])) when '.' then null else LTRIM(RTRIM([Item_No])) end
		  ,case LTRIM(RTRIM([Serial_No])) when '.' then null else LTRIM(RTRIM([Serial_No])) end
		  ,[Current_Item_Qty]
		  ,LTRIM(RTRIM([Currency_code]))
		  , [Cost] * ISNULL(c.ConversionFactor, 1) [Cost]
		  ,[Accum_depreciation]
		  ,[Net_Book_Value] * ISNULL(c.ConversionFactor, 1) 
		  ,LTRIM(RTRIM([Product_line_code]))
		  ,LTRIM(RTRIM([Unit_number]))
		  ,[Inventory_part_number]
		  ,ISNULL(LTRIM(RTRIM([Inventory_Item_Branch_Plant])) , LTRIM(RTRIM([Fixed_Asset_Branch_Plant])))
		  ,LTRIM(RTRIM([Inventory_Item_Ownership_Code]))
		  ,LTRIM(RTRIM([Lot_Grade]))  -- Revision
		  ,LTRIM(RTRIM([Legacy_part_number]))  -- legacy serial number (SAP)
		  ,LTRIM(RTRIM([AFE_Number]))
		  ,LTRIM(RTRIM([State]))
		  ,LTRIM(RTRIM([Contract_Account]))
		  ,LTRIM(RTRIM([Ownership]))
		  ,[Date_acquired]
		  ,[Life_Months]
		  ,[Start_Depreciation_Date]
		  ,[New_or_used]
		  ,LTRIM(RTRIM([Manufacturer]))
		  ,LTRIM(RTRIM([Model_Year]))
		  ,LTRIM(RTRIM([Third_item_number]))
		  ,[Date_Disposed]
		  ,LTRIM(RTRIM([Equipment_Status]))
		  ,[Fiscal_Year]
		  ,LTRIM(RTRIM([Ledger_Type]))
		  ,LTRIM(RTRIM([Cat_Code_16]))
		  ,LTRIM(RTRIM(acq_code)) [AcqCode]
		  ,LTRIM(RTRIM(Major_Accounting_Class)) [MajorAccountingClass]
		  ,LTRIM(RTRIM(Journaling_Flag)) [JournalingFlag]
		  ,LTRIM(RTRIM(Application_Code)) [ApplicationCode]
	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[Asset] a
	LEFT Join AesOps.dbo.CurrencyConversionFactors c on LTRIM(RTRIM([Currency_code])) = c.CurrShortName
	WHERE MONTH(c.EffectiveStartDate) = 8 and YEAR(c.EffectiveStartDate) = 2016 
	AND
	LTRIM(RTRIM(Item_No)) IN ('1847315',
'1847317',
'1016498',
'1016499',
'1016500',
'1016501',
'1016502',
'1016503',
'1016504',
'1274134',
'1274136',
'1274138',
'1017091',
'1367541',
'1367547',
'1380097',
'1577909',
'1577910',
'1826916',
'1827126',
'1827664',
'1827666',
'1827674',
'1827684',
'1827694',
'1827751',
'1827754',
'1827760',
'1827762',
'1827764',
'1827766',
'1841014',
'1845733',
'1861308',
'1975423',
'2068896',
'2068901',
'2068907',
'2086309',
'2105495',
'2165913',
'2218504',
'2437885')

OR
	LTRIM(RTRIM([Parent_Number]))
	IN (SELECT LTRIM(RTRIM([Asset_Number]))
	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[Asset] Asset
	WHERE 
	LTRIM(RTRIM(Item_No)) IN ('1847315',
'1847317',
'1016498',
'1016499',
'1016500',
'1016501',
'1016502',
'1016503',
'1016504',
'1274134',
'1274136',
'1274138',
'1017091',
'1367541',
'1367547',
'1380097',
'1577909',
'1577910',
'1826916',
'1827126',
'1827664',
'1827666',
'1827674',
'1827684',
'1827694',
'1827751',
'1827754',
'1827760',
'1827762',
'1827764',
'1827766',
'1841014',
'1845733',
'1861308',
'1975423',
'2068896',
'2068901',
'2068907',
'2086309',
'2105495',
'2165913',
'2218504',
'2437885'))