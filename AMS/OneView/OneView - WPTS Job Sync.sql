
-----oneview_job_total_time -- total time
SELECT        jo.jobID, SUM(DATEDIFF(mi, jo.jobOperationStartTime, jo.jobOperationEndTime) / 60.0) AS total_time
FROM            dbo.JobOperations AS jo INNER JOIN
                         dbo.JobOperationTypes AS jot ON jo.jobOperationTypeID = jot.jobOperationTypeID LEFT OUTER JOIN
                         dbo.Job ON jo.jobID = dbo.Job.jobID
WHERE        (jo.deleted IS NULL OR
                         jo.deleted = 0) AND (jot.jobOperationTypeID <> N'15') AND (jot.jobOperationTypeID <> N'21') AND (jot.jobOperationTypeID <> N'22') AND
                         (dbo.Job.scheduledStartDateTime >= ?)
GROUP BY jo.jobID

-----Operating time
SELECT        jo.jobID, SUM(DATEDIFF(mi, jo.jobOperationStartTime, jo.jobOperationEndTime) / 60.0) AS operating_time
FROM            dbo.JobOperations AS jo INNER JOIN
                         dbo.JobOperationTypes AS jot ON jo.jobOperationTypeID = jot.jobOperationTypeID LEFT OUTER JOIN
                         dbo.Job ON jo.jobID = dbo.Job.jobID
WHERE        (jo.deleted IS NULL OR
                         jo.deleted = 0) AND (jot.operationType IN ('_RigUP', '_RIH', '_LoggingRun', '_MechanicalRun', '_PerforatingRun', '_SettingToolRun', '_CoringRun',
                         '_FormationTestingRun', '_Bridging', '_Fishing', '_POOH', '_RigDown', '_ShallowGasPerforatingRun', '_RigCirculation', '_OperationalCrewAndEquipment',
                         '_DeploymentRun')) AND (dbo.Job.scheduledStartDateTime >= ?)
GROUP BY jo.jobID


--lost time
select lostrigtime from Failures where jobID ='0DB9AFE6-6550-4A1F-AD1F-2AD83158680A'


SELECT        CAST(tj.oneview_guid AS uniqueidentifier) AS jobid, SUM(tf.lostrigtime) AS lost_time
FROM            dbo.tops_failures AS tf INNER JOIN
                         dbo.tops_jobs AS tj ON tf.serviceorderid = tj.serviceorderid
WHERE        (tj.oneview_guid IS NOT NULL AND tj.timesetbyclient >= ?)
GROUP BY CAST(tj.oneview_guid AS uniqueidentifier)


select tt.jobid,sum(coalesce(cfd.lostrigtime, lt.lost_time)) as lost_time,ot.operating_time , tt.total_time
from oneview_job_total_time tt 
left join oneview_job_operating_time ot on tt.jobID=ot.jobid
left join oneview_job_lost_time lt on tt.jobID=lt.jobid
left join combined_failure_data cfd on tt.jobid = cfd.oneview_jobid
group by tt.jobid,ot.operating_time,tt.total_time


--- Package Path In TFS: $/OneView_Reporting/Main-branch/WPTS Warehouse

usp_WPTSJobSelection

--- Check job number in WPTS logs
select uploadxml.value('(/NewDataSet/Table1[field/text()="JobNo"]/value/text())[1]','varchar(max)') [JobNumber], 
* from Upload_Log where 
UploadDate >='2021-01-01'AND 
uploadxml.value('(/NewDataSet/Table1[field/text()="JobNo"]/value/text())[1]','varchar(max)') ='18078-316323117'