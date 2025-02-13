select jb.* 
from Job j
join JobCrew jc on j.jobID = jc.jobID
join JobBonus jb on jc.jobCrewID = jb.jobCrewID
--join JobBonusData jbd on jb.jobBonusID = jbd.jobBonusID
where serviceOrder ='3886-417655576' --'6533-425622464' 
and ISNULL(jc.deleted,0) = 0 
	and ISNULL(jb.deleted,0) = 0

select * from JobBonusStatus

--UPDATE JobBonus
--SET jobBonusStatusID = 3
--WHERE jobBonusID IN (
--'3C0FD987-F376-4F5A-AB40-8DAFB4859BA6',
--'FB98B0F8-4DB4-48B0-8864-F067DA8BD34E',
--'5F20619B-DB18-4618-B393-4F46023081E5',
--'D0DE91AF-916F-4FED-85D7-ABFCCC24E883'
--)