select YEAR(Opened) [Year], MONTH(Opened) [Month], ISNULL(GroupName,'OTHER') [GROUP Name], COUNT(*)
FROM [dbo].[ServiceNowIncidents] s
LEFT JOIN [dbo].[GroupMembers] g ON s.[Resolved By] = g.GroupMember
WHERE Opened >= '2018-10-01'
GROUP BY YEAR(Opened), MONTH(Opened), GroupName
ORDER BY YEAR(Opened), MONTH(Opened), GroupName