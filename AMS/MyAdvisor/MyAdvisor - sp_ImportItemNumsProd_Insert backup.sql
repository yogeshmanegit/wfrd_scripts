CREATE PROCEDURE [dbo].[sp_ImportItemNumsProd_Insert]
as
BEGIN
	SET NOCOUNT ON

	truncate table AesImport.dbo.[ItemNumImport]
	truncate table AesImport.dbo.[ItemBranchAndCostImport]

	INSERT INTO AesImport.dbo.[ItemNumImport]
	(
		[ItemNum]
		,[ItemNum2]
		,[ItemNum3]
		,[DescShort]
		,[PC3]
		,[PC4]
		,[PC5]
		,[PC6]
		,[PC7]
		,[DescDocNum]
		,[Revision]
		,[DefaultUOM]
		,[DefaultSerialProfile]
		,[PartState]
		,[Active]
		,[LastEdit]
		,PC3Desc
		,PC4Desc
		,PC5Desc
		,PC6Desc
		,PC7Desc
		,StockType
		,IMLNTY
		,[AllowDefaultSerialOverride]
	)
	SELECT 
	  convert(varchar(8), f4101.IMITM)
	  ,ltrim(rtrim(f4101.IMLITM))
	  ,ltrim(rtrim(f4101.IMAITM))
	  ,ltrim(rtrim(f4101.IMDSC1)) + IsNull(ltrim(rtrim(f4101.IMDSC2)), '')
	  ,ltrim(rtrim(f4101.IMSRP3))
	  ,ltrim(rtrim(f4101.IMSRP4))
	  ,ltrim(rtrim(f4101.IMSRP5))
	  ,ltrim(rtrim(f4101.IMSRP6))
	  ,ltrim(rtrim(f4101.IMSRP7))
	  ,ltrim(rtrim(f4101.IMDRAW))
	  ,ltrim(rtrim(f4101.IMRVNO))
	  ,ltrim(rtrim(f4101.IMUOM1))
	  , null
	  --, case ltrim(rtrim((select top 1 ibac.Lot_Process_Type from [USPDSQLSHR01].[DSTOPSPRD].[dbo].[ItemBranchAndCost] ibac where f4101.IMITM = ibac.Item_Number)))
	  --  when '4' then 'S' when '5' then 'S' when '6' then 'S' when '7' then 'S' else 'B' end
	  ,ltrim(rtrim(f4101.IMPTSC))
	  , 1
	  , GETDATE()
	  , ltrim(rtrim(s3.DRDL01)) as PC3Desc
	  , ltrim(rtrim(s4.DRDL01)) as PC4Desc
	  , ltrim(rtrim(s5.DRDL01)) as PC5Desc
	  ,NULL --, s6.DRDL01 as PC6Desc
	  , NULL --, s7.DRDL01 as PC7Desc
	  ,ltrim(rtrim(f4101.IMSTKT))
	  ,ltrim(rtrim(f4101.IMLNTY))
	  , 1 [AllowDefaultSerialOverride]
	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F4101] f4101
	LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] s3 on s3.DRRT ='S3' and ltrim(rtrim(s3.DRKY)) = f4101.IMSRP3
	LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] s4 on s4.DRRT ='S4' and ltrim(rtrim(s4.DRKY)) = f4101.IMSRP4
	LEFT JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F0005] s5 on s5.DRRT ='S5' and ltrim(rtrim(s5.DRKY)) = f4101.IMSRP5


	insert into ItemBranchAndCostImport ---- this will go into SSIS
	(
		[Branch_plant]
	   ,[Item_Number]
	   ,[Second_Item_Number]
	   ,[Third_Item_Number]
	   ,[Make_Buy]
	   ,[Reorder_Point]
	   ,[Maximum_Reorder_Quantity]
	   ,[Minimum_Reorder_Quantity]
	   ,[Safety_Stock]
	   ,[Lot_Status_Code]
	   ,[Lot_Process_Type]
	   ,[GL_Class_Code]
	   ,[Cost_Method]
	   ,[Cost]
	   ,[Date_Added]
	   ,[Date_Changed]
	   ,[Export_Commodity_Control_Number]
	   ,[Harmonized_Tariff_Begin_Digits]
	   ,[Harmonized_Tariff_End_Digits]
	)
	select
		ltrim(rtrim([Branch_plant]))
	   ,convert(varchar(8), [Item_Number])
	   ,ltrim(rtrim([Second_Item_Number]))
	   ,ltrim(rtrim([Third_Item_Number]))
	   ,ltrim(rtrim([Make_Buy]))
	   ,[Reorder_Point]
	   ,[Maximum_Reorder_Quantity]
	   ,[Minimum_Reorder_Quantity]
	   ,[Safety_Stock]
	   ,[Lot_Status_Code]
	   ,[Lot_Process_Type]
	   ,ltrim(rtrim([GL_Class_Code]))
	   ,ltrim(rtrim([Cost_Method]))
	   ,[Cost]
	   ,[Date_Added]
	   ,[Date_Changed]
	   ,ltrim(rtrim([Export_Commodity_Control_Number]))
	   ,ltrim(rtrim([Harmonized_Tariff_Begin_Digits]))
	   ,ltrim(rtrim([Harmonized_Tariff_End_Digits]))
	FROM [USPDSQLSHR01].[DSTOPSPRD].[dbo].[ItemBranchAndCost] ibac
	JOIN [USPDSQLSHR01].[DSTOPSPRD].[dbo].[F4101] f4101 on f4101.IMITM = ibac.Item_Number
	--WHERE
	--  (
	--	f4101.IMSRP3 in ('017','003', '010', '009', '075', '016', '025', '057', '052', '016', '044')
	--	OR f4101.IMSRP4 in ('121', '547', '427', '560')
	--  )
	--  OR f4101.IMITM in ('1307212', '1306941', '1266580')

	

	SET NOCOUNT OFF

END