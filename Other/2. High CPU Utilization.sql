select 
 j.name as 'JobName',
s.step_id as 'Step',
s.step_name as 'StepName',
msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime',
((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) 
         as 'RunDurationMinutes'
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobsteps s 
 ON j.job_id = s.job_id
INNER JOIN msdb.dbo.sysjobhistory h 
 ON s.job_id = h.job_id 
 AND s.step_id = h.step_id 
 AND h.step_id <> 0
where j.enabled = 1 
and j.name = 'Advisor - Asset ETL Job'
order by RunDateTime desc


--See SQL Server CPU utilization for past 256 minutes
DECLARE @ts_now bigint = (SELECT cpu_ticks/(cpu_ticks/ms_ticks) FROM sys.dm_os_sys_info WITH (NOLOCK)); 

SELECT TOP(256) SQLProcessUtilization AS [SQL Server Process CPU Utilization], 
               SystemIdle AS [System Idle Process], 
               100 - SystemIdle - SQLProcessUtilization AS [Other Process CPU Utilization], 
               DATEADD(ms, -1 * (@ts_now - [timestamp]), GETDATE()) AS [Event Time] 
FROM ( 
                 SELECT record.value('(./Record/@id)[1]', 'int') AS record_id, 
                                             record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int') 
                                             AS [SystemIdle], 
                                             record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 
                                             'int') 
                                             AS [SQLProcessUtilization], [timestamp] 
                 FROM ( 
                                             SELECT [timestamp], CONVERT(xml, record) AS [record] 
                                             FROM sys.dm_os_ring_buffers WITH (NOLOCK)
                                             WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR' 
                                             AND record LIKE N'%<SystemHealth>%') AS x 
                 ) AS y 
ORDER BY record_id DESC OPTION (RECOMPILE); 
