exec sp_executesql N'SELECT 
    [GroupBy1].[A1] AS [C1]
    FROM ( SELECT 
        COUNT(1) AS [A1]
        FROM      (SELECT [Extent1].[serviceOrder] AS [serviceOrder], [Extent1].[scheduledStartDateTime] AS [scheduledStartDateTime], [Extent4].[GWIS_LocationID] AS [GWIS_LocationID1]
            FROM     [dbo].[Job] AS [Extent1]
            INNER JOIN [dbo].[Company] AS [Extent2] ON [Extent1].[oneViewCompanyID] = [Extent2].[oneViewCompanyID]
            INNER JOIN (SELECT 
    [OperationalLocation].[gwis_locationattributeid] AS [gwis_locationattributeid], 
    [OperationalLocation].[gwis_locationid] AS [gwis_locationid], 
    [OperationalLocation].[name] AS [name], 
    [OperationalLocation].[parentId] AS [parentId], 
    [OperationalLocation].[lvl] AS [lvl], 
    [OperationalLocation].[type] AS [type], 
    [OperationalLocation].[attrVal] AS [attrVal], 
    [OperationalLocation].[attributeValueId] AS [attributeValueId], 
    [OperationalLocation].[isCostCenter] AS [isCostCenter], 
    [OperationalLocation].[isRevenueCenter] AS [isRevenueCenter], 
    [OperationalLocation].[description] AS [description], 
    [OperationalLocation].[regionId] AS [regionId], 
    [OperationalLocation].[subregionId] AS [subregionId], 
    [OperationalLocation].[countryId] AS [countryId], 
    [OperationalLocation].[areaId] AS [areaId], 
    [OperationalLocation].[districtId] AS [districtId], 
    [OperationalLocation].[branchplantId] AS [branchplantId], 
    [OperationalLocation].[businessunitId] AS [businessunitId]
    FROM [dbo].[OperationalLocation] AS [OperationalLocation]) AS [Extent3] ON [Extent1].[operationalLocationID] = [Extent3].[gwis_locationid]
            INNER JOIN [dbo].[GWIS_Location] AS [Extent4] ON [Extent1].[geographicLocationID] = [Extent4].[GWIS_LocationID]
            INNER JOIN [dbo].[Location_Attribute_Values] AS [Extent5] ON [Extent1].[jobTypeID] = [Extent5].[id]
            WHERE [Extent1].[deleted] = 0 OR [Extent1].[deleted] IS NULL ) AS [Filter1]
        OUTER APPLY  (SELECT TOP (1) [Extent6].[GWIS_LocationAttributeID] AS [GWIS_LocationAttributeID]
            FROM [dbo].[GWIS_LocationAttributes] AS [Extent6]
            WHERE ([Filter1].[GWIS_LocationID1] = [Extent6].[GWIS_LocationID]) AND (1 = [Extent6].[GWIS_LocationRelationTypeID]) AND ([Extent6].[value] IS NOT NULL) ) AS [Limit1]
        OUTER APPLY  (SELECT TOP (1) [Extent7].[GWIS_LocationAttributeID] AS [GWIS_LocationAttributeID]
            FROM [dbo].[GWIS_LocationAttributes] AS [Extent7]
            WHERE ([Filter1].[GWIS_LocationID1] = [Extent7].[GWIS_LocationID]) AND (1 = [Extent7].[GWIS_LocationRelationTypeID]) AND ([Extent7].[value] IS NOT NULL) ) AS [Limit2]
        OUTER APPLY  (SELECT TOP (1) [Extent8].[GWIS_LocationAttributeID] AS [GWIS_LocationAttributeID]
            FROM [dbo].[GWIS_LocationAttributes] AS [Extent8]
            WHERE ([Filter1].[GWIS_LocationID1] = [Extent8].[GWIS_LocationID]) AND (1 = [Extent8].[GWIS_LocationRelationTypeID]) AND ([Extent8].[value] IS NOT NULL) ) AS [Limit3]
        OUTER APPLY  (SELECT TOP (1) [Extent9].[GWIS_LocationAttributeID] AS [GWIS_LocationAttributeID]
            FROM [dbo].[GWIS_LocationAttributes] AS [Extent9]
            WHERE ([Filter1].[GWIS_LocationID1] = [Extent9].[GWIS_LocationID]) AND (1 = [Extent9].[GWIS_LocationRelationTypeID]) AND ([Extent9].[value] IS NOT NULL) ) AS [Limit4]
        WHERE ( CAST( [Filter1].[scheduledStartDateTime] AS datetime) >= @p__linq__0) AND ( CAST( [Filter1].[scheduledStartDateTime] AS datetime) <= @p__linq__1) AND ([Filter1].[serviceOrder] LIKE @p__linq__2 ESCAPE N''~'')
    )  AS [GroupBy1]',N'@p__linq__0 datetime,@p__linq__1 datetime,@p__linq__2 nvarchar(4000)',@p__linq__0='2018-09-01 05:00:00',@p__linq__1='2021-03-25 05:00:00',@p__linq__2=N'WL-ADB-210106%'