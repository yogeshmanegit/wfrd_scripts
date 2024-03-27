Select convert(char(7), g.ReportDate, 126) [Month], 
COUNT(*) [Total],
SUM(CASE WHEN i.Comments  ='RADAR card uploaded.' THEN 0 ELSE 1 END) [Total from Website],
SUM(CASE WHEN i.Comments  ='RADAR card uploaded.' THEN 1 ELSE 0 END) [Total from App],
SUM(CASE WHEN i.Comments  ='RADAR card uploaded.' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) [Percentage],
SUM(CASE WHEN StageInTour IN (1, 5) THEN 1 ELSE 0 END) [Draft Incident],
SUM(CASE WHEN StageInTour = 16 THEN 1 ELSE 0 END) [Pending],
SUM(CASE WHEN StageInTour = 11 THEN 1 ELSE 0 END) [Incident Closed]
from gpi1 g
JOIN IncidentTracking i on g.IncidentID = i.IncidentID
WHERE g.ReportTypeID = 147 and g.ReportDate >='2020-09-01' and ISNULL(IsDeleted,0) = 0 
group by convert(char(7), g.ReportDate, 126) 
order by 1 desc
