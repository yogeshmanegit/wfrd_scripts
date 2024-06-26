USE [AesOps]
GO
/****** Object:  StoredProcedure [dbo].[usp_MTBFReport]    Script Date: 10/27/2016 10:51:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yogesh Mane
-- Create date: 4/7/16
-- Description:	MTBF Report
-- =============================================
ALTER PROCEDURE [dbo].[usp_MTBFReport] 
	-- Add the parameters for the stored procedure here
	@GroupType INT = 1,
	@PartTypeId VARCHAR(MAX) = NULL, 
	@ToolCode VARCHAR(MAX) = NULL,
	@Region VARCHAR(MAX) = NULL,
	@District VARCHAR(MAX) = NULL,
	@StartDate DATETIME = NULL,
	@EndDate DATETIME = NULL,
	@ToolStringType VARCHAR(MAX) = NULL,
	@ToolStringSize VARCHAR(MAX) = NULL,
	@Productline VARCHAR(MAX) = NULL,
	@CustomerName VARCHAR(MAX)=NULL
AS

BEGIN

SET @CustomerName = REPLACE(@CustomerName,'*', '%')

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @PartTypeId = REPLACE(@PartTypeId, '*', '%')
	SET @ToolCode = REPLACE(@ToolCode, '*', '%')
	SET @Region = REPLACE(@Region, '*', '%')
	SET @District = REPLACE(@District, '*', '%')
	SET @ToolStringType = REPLACE(@ToolStringType, '*', '%')
	SET @ToolStringSize = REPLACE(@ToolStringSize, '*', '%')

	DECLARE @SQLQUERY VARCHAR(MAX),
			@GroupColumn VARCHAR(MAX),
			@SortColumn VARCHAR(MAX)

	SELECT @SortColumn = CASE WHEN  @GroupType = 1 THEN 'CONVERT(varchar(4), bi.RunYear)'
			WHEN  @GroupType = 2 THEN 'CONVERT(varchar(4), bi.RunYear) + '' '' + bi.Quarter'
			WHEN  @GroupType = 3 THEN 'bi.MonthYear'
			END

	SELECT @GroupColumn = CASE WHEN  @GroupType = 1 THEN 'CONVERT(varchar(4), bi.RunYear)'
			WHEN  @GroupType = 2 THEN 'CONVERT(varchar(4), bi.RunYear) + '' '' + bi.Quarter'
			WHEN  @GroupType = 3 THEN 'bi.MonthYear'
			END

    -- Insert statements for procedure here

	SET @SQLQUERY = 'SELECT 
	' + @SortColumn +' [SortColumn],
	' +  @GroupColumn + ' [GroupColumn],
		ROUND(Sum(OperHrs),2)		AS TotalOperHrs, 
		ROUND(Sum(CircHrs),2)		AS TotalCircHrs,
		ROUND(Sum([tffcount]),2)		AS TotalTFF, 
		ROUND(Sum([csicount]),2)		AS TotalCSI, 
		ROUND(Sum(operhrs) / CASE WHEN Sum([tffcount]) = 0 THEN 1 ELSE Sum(tffcount) END ,2) [MTBTFF_Operhrs], 
		ROUND(Sum(circhrs) / CASE WHEN Sum([tffcount]) = 0 THEN 1 ELSE Sum(tffcount) END ,2) [MTBTFF_Circhrs], 
		ROUND(Sum(operhrs) / CASE WHEN Sum([csicount]) = 0 THEN 1 ELSE Sum([csicount]) END ,2) [MTBCSI_Operhrs], 
		ROUND(Sum(circhrs) / CASE WHEN Sum([csicount]) = 0 THEN 1 ELSE Sum([csicount]) END ,2) [MTBCSI_Circhrs] 
	FROM   RelBusinessIntelligenceDataset bi (NOLOCK)
	INNER JOIN (SELECT runid, 
						Sum(CONVERT(INT, tff)) [TFFCount], 
						CASE WHEN Sum(CONVERT(INT, csi)) > 0 THEN 1 ELSE 0 END [CSICount] 
				FROM   ToolStringComponentInfo tc  (NOLOCK)
				WHERE 1 = 1 
				'
	+ CASE WHEN @PartTypeId IS NULL THEN '' ELSE ' AND (CONVERT(varchar(max),tc.PartTypeID) IN (SELECT ENTRY FROM listtotable('''+ ISNULL(@PartTypeId,'') +''')) OR CONVERT(varchar(max),tc.PartTypeID) LIKE '''+ ISNULL(@PartTypeId,'') + ''')' END
	+ CASE WHEN @ToolCode IS NULL THEN '' ELSE ' AND (tc.ToolCode IN (SELECT ENTRY FROM listtotable('''+ ISNULL(@ToolCode,'') + ''')) OR tc.ToolCode LIKE '''+ ISNULL(@ToolCode,'') + ''')' END

	----------------------------------- ToolString Filters Start 
	+ CASE WHEN @ToolStringType IS NULL AND @ToolStringSize IS NULL AND @Productline IS NULL THEN '' ELSE ' AND tc.ToolStringId IN (SELECT t.ToolStringId FROM ToolStrings t 
		inner join ToolStringComponentInfo tc1 on t.ToolStringId = tc1.ToolStringId
					WHERE 1 = 1 ' END
						
							-- ToolString type filter
	+ CASE WHEN @ToolStringType IS NULL THEN ' ' ELSE ' AND dbo.fnGetToolStringTypeBySerialNumber(t.type, t.serialnumber, tc1.ToolCode) IN ( SELECT ENTRY FROM listtotable('''+ ISNULL(@ToolStringType,'') + ''')) ' END

	-- Tool String Size Filter
	+ CASE WHEN @ToolStringSize IS NULL THEN ' ' ELSE ' AND t.SizeId IN ( SELECT toolsizeid FROM ToolStringSize WHERE (ShortName IN (SELECT ENTRY FROM listtotable('''+ @ToolStringSize + ''')) OR ShortName LIKE '''+ @ToolStringSize + ''') )' END

	-- Product Line Filter
	+ CASE WHEN @Productline IS NULL THEN ' ' ELSE ' AND dbo.fnGetProductlineByToolStringType(t.type) IN ( SELECT ENTRY FROM listtotable('''+ ISNULL(@Productline,'') + ''')) ' END

	+ CASE WHEN @ToolStringType IS NULL AND @ToolStringSize IS NULL AND @Productline IS NULL THEN '' ELSE ' ) ' END

	----------------------------------- ToolString Filters Ends
	+ 'GROUP  BY runid) a ON a.runid = bi.runid 
	WHERE 1 = 1 
	' 
	+ CASE WHEN @Region IS NULL THEN '' ELSE ' AND ( bi.region IN (SELECT ENTRY FROM listtotable(''' + ISNULL(@Region,'')+ ''')) OR bi.region LIKE ''' + ISNULL(@Region,'')+ ''')' END
	+ CASE WHEN @District IS NULL THEN '' ELSE ' AND ( bi.District IN (SELECT ENTRY FROM listtotable(''' + ISNULL(@District,'')+ ''')) OR bi.District LIKE ''' + ISNULL(@District,'')+ ''')' END
	+ CASE WHEN @StartDate IS NULL THEN '' ELSE ' AND bi.EndDate >= CONVERT(DATETIME, ''' + CONVERT(varchar(10), ISNULL(@StartDate, GETDATE()), 103) + ''', 103) ' END
	+ CASE WHEN @EndDate IS NULL THEN '' ELSE ' AND bi.EndDate < CONVERT(DAtetime, ''' + CONVERT(varchar(10), ISNULL(@EndDate, GETDATE()), 103) + ''', 103) ' END

  --Customer line Filter
	+ CASE WHEN @CustomerName IS NULL THEN '' ELSE +' AND ( bi.customername IN (SELECT ENTRY FROM listtotable(''' + ISNULL(@CustomerName,'')+ ''')) OR bi.customername LIKE ''' + ISNULL(@CustomerName,'')+ ''')' END
	+ ' GROUP  BY ' + @GroupColumn + ', ' +  @SortColumn + '

	--HAVING Sum([tffcount]) > 0 OR Sum([csicount]) > 0 '
	
	--print @SQLQUERY
	
	exec (@SQLQUERY)

END



