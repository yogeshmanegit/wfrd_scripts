select p.PFTWOId, SUM(CASE WHEN s.PFTResult ='' then 1 else 0 end) [Result]
from PFTWO p
join PFTWOSeq s on p.PFTWOId = s.PFTWOId
where p.Active = 1 and YEAR(p.DateAdded) = 2025
	--and p.PFTWOId in (
	--'332BFCAC-A5A6-49A2-A576-00009A7F82EA',
	--'D2E32499-3D4A-42CE-8FDE-0001E890F4A4',
	--'A0E52558-E30F-4844-9378-F5D506626F13'
	--)
group by p.PFTWOId
having SUM(CASE WHEN s.PFTResult ='' then 1 else 0 end) = 0
order by 1