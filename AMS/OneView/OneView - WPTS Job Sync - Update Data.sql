SET NOCOUNT ON;  
  
DECLARE @jobId uniqueidentifier, @lost_time decimal(18,2), @operating_time decimal(18,2), @total_time decimal(18,2);  
  
DECLARE job_cursor CURSOR FOR   
select j.jobID 
from Job j
LEFT JOIN WPTS_KPI_Hours w on j.jobID = w.JobID
WHERE w.operating_time is null and j.dateUploaded >='2021-08-01'
AND j.JobID = '0DB9AFE6-6550-4A1F-AD1F-2AD83158680A'
order by j.dateUploaded 
  
OPEN job_cursor  
  
FETCH NEXT FROM job_cursor INTO @jobid
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    
	PRINT @jobId
  
	SELECT @total_time = SUM(DATEDIFF(mi, jo.jobOperationStartTime, jo.jobOperationEndTime) / 60.0) -- AS total_time
	FROM            dbo.JobOperations AS jo INNER JOIN
							dbo.JobOperationTypes AS jot ON jo.jobOperationTypeID = jot.jobOperationTypeID LEFT OUTER JOIN
							dbo.Job ON jo.jobID = dbo.Job.jobID
	WHERE        (jo.deleted IS NULL OR
							jo.deleted = 0) AND (jot.jobOperationTypeID <> N'15') AND (jot.jobOperationTypeID <> N'21') AND (jot.jobOperationTypeID <> N'22') AND
							jo.jobID = @jobId
	--                         (dbo.Job.scheduledStartDateTime >= ?)
	GROUP BY jo.jobID

	-----Operating time
	SELECT  @operating_time = SUM(DATEDIFF(mi, jo.jobOperationStartTime, jo.jobOperationEndTime) / 60.0) -- AS operating_time
	FROM            dbo.JobOperations AS jo INNER JOIN
							dbo.JobOperationTypes AS jot ON jo.jobOperationTypeID = jot.jobOperationTypeID LEFT OUTER JOIN
							dbo.Job ON jo.jobID = dbo.Job.jobID
	WHERE        (jo.deleted IS NULL OR
							jo.deleted = 0) AND (jot.operationType IN ('_RigUP', '_RIH', '_LoggingRun', '_MechanicalRun', '_PerforatingRun', '_SettingToolRun', '_CoringRun',
							'_FormationTestingRun', '_Bridging', '_Fishing', '_POOH', '_RigDown', '_ShallowGasPerforatingRun', '_RigCirculation', '_OperationalCrewAndEquipment',
							'_DeploymentRun')) 
			AND jo.jobID = @jobId
							--AND (dbo.Job.scheduledStartDateTime >= ?)
	GROUP BY jo.jobID

	select @lost_time = lostrigtime from Failures where jobID = @jobId

	UPDATE WPTS_KPI_Hours SET lost_time =@lost_time, operating_time = @operating_time, total_time =@total_time where JobID = @jobId

	SELECT @lost_time = null, @operating_time = null, @total_time = null
	
    -- Get the next job.  
    FETCH NEXT FROM job_cursor INTO @jobid
END   
CLOSE job_cursor;  
DEALLOCATE job_cursor;


select * from WPTS_KPI_Hours where JobID = '0DB9AFE6-6550-4A1F-AD1F-2AD83158680A'
select wptsId, * from Job where jobID = '0DB9AFE6-6550-4A1F-AD1F-2AD83158680A'

--select tt.jobid,sum(coalesce(cfd.lostrigtime, lt.lost_time)) as lost_time,ot.operating_time , tt.total_time
--from oneview_job_total_time tt 
--left join oneview_job_operating_time ot on tt.jobID=ot.jobid
--left join oneview_job_lost_time lt on tt.jobID=lt.jobid
--left join combined_failure_data cfd on tt.jobid = cfd.oneview_jobid
--group by tt.jobid,ot.operating_time,tt.total_time
