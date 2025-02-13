select j.financialSystemID, jbsl.* 
from Job j
join JobCrew jc on j.jobID = jc.jobID
join JobBonus jb on jc.jobCrewID = jb.jobCrewID
join JobBonusData jbd on jbd.jobBonusID = jb.jobBonusID
join JobBonusStatusLog jbsl on jbsl.jobBonusID = jb.jobBonusID
where j.serviceOrder ='6533-419606727' and jbsl.oldJobBonusStatusID = 3
order by modified asc