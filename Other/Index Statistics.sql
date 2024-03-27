
SELECT   OBJECT_NAME(S.[OBJECT_ID]) AS [OBJECT NAME], 
         I.[NAME] AS [INDEX NAME], 
         USER_SEEKS, 
         USER_SCANS, 
         USER_LOOKUPS, 
         USER_UPDATES 
FROM     SYS.DM_DB_INDEX_USAGE_STATS AS S 
         INNER JOIN SYS.INDEXES AS I 
           ON I.[OBJECT_ID] = S.[OBJECT_ID] 
              AND I.INDEX_ID = S.INDEX_ID 
WHERE    OBJECTPROPERTY(S.[OBJECT_ID],'IsUserTable') = 1 

SELECT tn.[name] AS [Table name], ix.[name] AS [Index name],
SUM(sz.[used_page_count]) * 8 AS [Index size (KB)]
FROM sys.dm_db_partition_stats AS sz
INNER JOIN sys.indexes AS ix ON sz.[object_id] = ix.[object_id] 
AND sz.[index_id] = ix.[index_id]
INNER JOIN sys.tables tn ON tn.OBJECT_ID = ix.object_id
GROUP BY tn.[name], ix.[name]
ORDER BY tn.[name]