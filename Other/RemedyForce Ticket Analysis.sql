select 
	ApplicationName
	, Year(OpenedDate) [Year]
	, DATENAME(month, OpenedDate) [Month]
	, COUNT(*) [TotalTickets]
from remedytickets
GROUP BY ApplicationName
	, Year(OpenedDate)
	, Month(OpenedDate)
	, DATENAME(month, OpenedDate)
	, priority 
	, impact
	
ORDER BY ApplicationName
	, Year(OpenedDate)
	, Month(OpenedDate)
	
	
--select 
--	ApplicationName
--	, Year(OpenedDate) [Year] 
--	, DATENAME(month, OpenedDate) [Month]
--	, priority 
--	, impact
--	, COUNT(*) [TotalTickets]
--from remedytickets
--GROUP BY ApplicationName
--	, Year(OpenedDate)
--	, DATENAME(month, OpenedDate)
--	, priority 
--	, impact
--ORDER BY ApplicationName
--	, Year(OpenedDate)
--	, DATENAME(month, OpenedDate)
--	, priority 
--	, impact
	