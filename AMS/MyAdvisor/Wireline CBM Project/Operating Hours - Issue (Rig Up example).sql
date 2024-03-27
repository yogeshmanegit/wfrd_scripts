SELECT Job.jobid, jobOperationTypeID, 
	assets.assetID as oneviewassetid
	,assets.jdeitemno as jdeassetnumber
	,assets.serialnumber
	,JobOperationTools.*
FROM Job 
  join JobOperations on JobOperations.jobID = job.jobID
		and ISNULL(JobOperations.deleted,0) = 0
  join JobOperationTools on JobOperationTools.jobOperationID = JobOperations.jobOperationID 
		and ISNULL(JobOperationTools.deleted,0) = 0
  join assets on assets.assetID = JobOperationTools.assetID
  WHERE ISNULL(Job.deleted,0) = 0
  and serviceOrder = 'WL2010090' order by toolStringPosition

select * from JobActualServices where jobID = 'EA5D0C85-E2C7-46D7-8D64-54E99CC63A57' and ISNULL(deleted,0) = 0
select * from JobSelectedServices where jobID = 'EA5D0C85-E2C7-46D7-8D64-54E99CC63A57' and ISNULL(deleted,0) = 0