--SELECT * FROM sys.dm_tran_locks
--  WHERE resource_database_id = DB_ID()
--  AND resource_associated_entity_id = OBJECT_ID(N'dbo.branchplants');
--select * from JobQueue where jobid = 41 and JobQueueStatusId = 1
SELECT sqltext.TEXT,
req.session_id,
req.status,
req.command,
req.cpu_time,
req.total_elapsed_time 
FROM sys.dm_exec_requests req
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext

SELECT  
    OBJECT_NAME(p.[object_id]) BlockedObject
FROM    sys.dm_exec_connections (NOLOCK) AS blocking
    INNER JOIN sys.dm_exec_requests (NOLOCK) blocked
        ON blocking.session_id = blocked.blocking_session_id
    INNER JOIN sys.dm_os_waiting_tasks (NOLOCK) waitstats
        ON waitstats.session_id = blocked.session_id
    INNER JOIN sys.partitions (NOLOCK) p ON SUBSTRING(resource_description, 
        PATINDEX('%associatedObjectId%', resource_description) + 19, 
        LEN(resource_description)) = p.partition_id

SELECT s.text, * FROM sys.dm_exec_requests 
CROSS APPLY sys.dm_exec_sql_text(sql_handle) s
where session_id IN (SELECT blocking_session_id 
FROM sys.dm_exec_requests WHERE DB_NAME(database_id)='aesops' and blocking_session_id <>0)


SELECT
OBJECT_NAME(p.OBJECT_ID) AS TableName,
resource_type, resource_description
FROM
sys.dm_tran_locks l
JOIN sys.partitions p ON l.resource_associated_entity_id = p.hobt_id