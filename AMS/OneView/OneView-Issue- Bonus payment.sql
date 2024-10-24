select j.serviceOrder, jc.*
	from Job j
	join JobCrew jc on j.jobID = jc.jobID and (jc.deleted is null or jc.deleted = 0)
	join Employee e on jc.employeeID = e.id
	join JobBonus jb on jc.jobCrewID = jb.jobCrewID and (jb.deleted is null or jb.deleted =0)						
	join jobbonustype jbt on jb.jobBonusTypeID = jbt.jobBonusTypeID and (jbt.deleted is null or jbt.deleted = 0)
	join FECellRole fecr on jc.feCellRoleID = fecr.feCellRoleID
	join JobBonusStatus jbs on jb.jobBonusStatusID = jbs.jobBonusStatusID and (jb.deleted is null or jb.deleted = 0)
	left join JobBonusFlatRateData AS jbfrd ON jb.jobBonusID = jbfrd.jobBonusID AND (jbfrd.deleted IS NULL OR jbfrd.deleted = 0) 						  
	LEFT JOIN JobBonusExceptionData AS jbed ON jb.jobBonusID = jbed.jobBonusID AND (jbed.deleted IS NULL OR jbed.deleted = 0) 
	LEFT JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID and (jbd.deleted is null or jbd.deleted =0)
	LEFT JOIN JobBonusDeclineReason jbdr ON jb.jobBonusDeclineReasonID = jbdr.jobBonusDeclineReasonID AND (jbdr.deleted IS NULL or jbdr.deleted =0)
	LEFT JOIN Failures ON j.jobID = Failures.jobID 
	LEFT JOIN Company AS c ON j.oneViewCompanyID = c.oneViewCompanyID
    WHERE        (jb.jobBonusID IS NOT NULL) AND (j.deleted IS NULL)
	and j.jobID = 'd26c5210-c0fb-4e5d-bd78-98d1d3a4287e' or j.serviceOrder ='21382-408852864'
	order by 1


select top 10 e.*, jb.*, jr.*
from Job j
join JobCrew jc on j.jobID = jc.jobID and (jc.deleted is null or jc.deleted = 0)
join Employee e on jc.employeeID = e.id
join JobBonus jb on jc.jobCrewID = jb.jobCrewID and (jb.deleted is null or jb.deleted =0)
JOIN JobBonusFlatRateData jr on jb.jobBonusID = jr.jobBonusID
where j.serviceOrder ='18936-409996374'
--select * from JobBonusReportDataView where jobID  ='322134BC-93E2-4A9E-898B-1C395CFF33F4'

select * from Employee where Employee.id = 1628

--select * 
--from JobBonusData 
--where jobBonusID in 
--(select jobBonusID from JobBonus where jobCrewID in 
--(select jobcrewid from JobCrew where jobid = '322134BC-93E2-4A9E-898B-1C395CFF33F4') )


--UPDATE JobBonusData SET nativeJDEBonusTotal = nativeBonusTotal
--where jobBonusID IN (
-- '5964DF72-5479-4383-B07D-D468E17ED712'
--,'B441D261-FBBD-4E1C-98AC-79F789052C3E'
--,'DE198FB2-AE3D-4BCC-B185-E305904ECF41'
--,'838DE4B4-A2C4-4B10-A211-9907580530DF')


--UPDATE JobBonus SET jobBonusStatusID = 3
--where jobBonusID IN (
-- '5964DF72-5479-4383-B07D-D468E17ED712'
--,'B441D261-FBBD-4E1C-98AC-79F789052C3E'
--,'DE198FB2-AE3D-4BCC-B185-E305904ECF41'
--,'838DE4B4-A2C4-4B10-A211-9907580530DF')
