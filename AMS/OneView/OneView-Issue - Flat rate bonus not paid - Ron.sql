use oneview;

select * from job where serviceOrder = '21359-402070663'

select e.displayname, jbd.* 
from JobBonusData jbd
join JobBonus jb on jbd.jobBonusID = jb.jobBonusID
join JobCrew jc on jb.jobCrewID = jc.jobCrewID
join Employee e on jc.employeeID = e.id
WHERE jc.jobID ='9634B7B2-E655-4BA7-8437-FEE76E620FCC'


select top 10 * from JobBonusType

select e.displayname, jbd.* 
from JobBonusData jbd
join JobBonus jb on jbd.jobBonusID = jb.jobBonusID
join JobCrew jc on jb.jobCrewID = jc.jobCrewID
join Employee e on jc.employeeID = e.id
WHERE jc.jobID ='2ff8ff8c-bf50-48dc-a0bd-f51760507669'

