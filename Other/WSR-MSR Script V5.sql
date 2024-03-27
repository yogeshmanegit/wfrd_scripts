USE AESSOA;

DECLARE @PeriodStart datetime, @PeriodEnd datetime, @PeriodType varchar(1) = 'W'
DECLARE @P1 varchar(100) = 'P1 - Critical', @P2 varchar(100)  = 'P2 - High', @P3 varchar(100) = 'P3 - Medium', @P4 varchar(100) ='P4 - Low'
DECLARE @ClosedState varchar(100) = 'Closed', @ResolvedState varchar(100) = 'Resolved', @Duplicate VARCHAR(100) = 'Duplicate', 
		@OnHoldState varchar(100) ='On Hold' , @InProgress varchar(100) = 'In Progress'

SELECT @PeriodStart = DATEADD(dd,  0, DATEADD(ww, DATEDIFF(ww, 0, DATEADD(dd, -1, GETDATE())) - 1, 0)),
     @PeriodEnd = DATEADD(dd,  7, DATEADD(ww, DATEDIFF(ww, 0, DATEADD(dd, -1, GETDATE())) - 1, 0))

IF @PeriodType = 'M'
BEGIN
	SELECT @PeriodStart = dateadd(month, datediff(month, 0, getdate())-1, 0),
     @PeriodEnd = dateadd(month, datediff(month, 0, getdate()), 0)
END

select RIGHT('00' + DateName(d,GETDATE()), 2) + '-' + DATENAME(mm, GETDATE()) + '-' + DATENAME(yyyy, GETDATE()) [Report Date],
		RIGHT('00' + DateName(d,@PeriodStart), 2) + ' ' + DATENAME(mm, @PeriodStart) + ' ' + DATENAME(yyyy, @PeriodStart)  + ' To ' 
		+ RIGHT('00' + DateName(d, DATEADD(d,-1, @PeriodEnd)), 2) + ' ' + DATENAME(mm, DATEADD(d,-1, @PeriodEnd)) + ' ' + DATENAME(yyyy, DATEADD(d,-1, @PeriodEnd)) [PeriodEnd]


SELECT 
	SUM(CASE WHEN Opened >= @PeriodStart and Opened <= @PeriodEnd THEN 1 ELSE 0 END) [Total Received],
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd AND [State] IN (@ClosedState , @ResolvedState) THEN 1 ELSE 0 END) [Total Resolved],
	SUM(CASE WHEN [State] in (@OnHoldState, @InProgress) THEN 1 ELSE 0 END) [Total Backlog],


	-- Priority Wise 
	SUM(CASE WHEN Opened >= @PeriodStart and Opened <= @PeriodEnd AND Priority = @P1 THEN 1 ELSE 0 END) [Total Critical Received],
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd AND [State] IN (@ClosedState , @ResolvedState) AND Priority = @P1  THEN 1 ELSE 0 END) [Total Critical Resolved],
	SUM(CASE WHEN [State] in(@OnHoldState, @InProgress) AND Priority = @P1 THEN 1 ELSE 0 END) [Total Critical Backlog],

	SUM(CASE WHEN Opened >= @PeriodStart and Opened <= @PeriodEnd AND Priority = @P2 THEN 1 ELSE 0 END) [Total High Received],
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd AND [State] IN (@ClosedState , @ResolvedState) AND Priority = @P2  THEN 1 ELSE 0 END) [Total High Resolved],
	SUM(CASE WHEN [State]  in(@OnHoldState, @InProgress) AND Priority = @P2 THEN 1 ELSE 0 END) [Total High Backlog],

	SUM(CASE WHEN Opened >= @PeriodStart and Opened <= @PeriodEnd AND Priority = @P3 THEN 1 ELSE 0 END) [Total Medium Received],
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd AND [State] IN (@ClosedState , @ResolvedState) AND Priority = @P3 THEN 1 ELSE 0 END) [Total Medium Resolved],
	SUM(CASE WHEN [State]  in (@OnHoldState, @InProgress) AND Priority = @P3 THEN 1 ELSE 0 END) [Total Medium Backlog],

	SUM(CASE WHEN Opened >= @PeriodStart and Opened <= @PeriodEnd AND Priority = @P4 THEN 1 ELSE 0 END) [Total Low Received],
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd AND [State] IN (@ClosedState , @ResolvedState) AND Priority = @P4 THEN 1 ELSE 0 END) [Total Low Resolved],
	SUM(CASE WHEN [State]  in(@OnHoldState, @InProgress) AND Priority = @P4 THEN 1 ELSE 0 END) [Total Low Backlog]

FROM ServiceNowIncidents 
WHERE [Assignment Group] like '%field%' and [Ticket type] = 'Incident' and Opened <= @PeriodEnd

SELECT * 
FROM (
SELECT 
	CASE WHEN Subcategory  IN ('MYADVISOR', 'ONEVIEW', 'TOPS', 'WISE', 'WPTS', 'WELL TRACKER') THEN Subcategory ELSE Subcategory END [Application],
	SUM(CASE WHEN Opened >= @PeriodStart and Opened <= @PeriodEnd THEN 1 ELSE 0 END) [Total Received],
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd AND [State] IN (@ClosedState , @ResolvedState) THEN 1 ELSE 0 END) [Total Resolved],
	SUM(CASE WHEN [State] IN( @OnHoldState, @InProgress) THEN 1 ELSE 0 END) [Total Backlog]

FROM ServiceNowIncidents 
WHERE [Assignment Group] like '%field%' and [Ticket type] = 'Incident' and Opened <= @PeriodEnd
GROUP BY (CASE WHEN Subcategory  IN ('MYADVISOR', 'ONEVIEW', 'TOPS', 'WISE', 'WPTS', 'WELL TRACKER') THEN Subcategory ELSE Subcategory END)
) A WHERE ([Total Received] + [Total Resolved] + [Total Backlog]) > 0
ORDER BY 1 ASC


SELECT Subcategory, Issue, count(*)
from ServiceNowIncidents 
WHERE Subcategory in ('MyAdvisor', 'WPTS') AND MONTH(Resolved) = MONTH(@PeriodStart) AND YEAR(Resolved) = YEAR(@PeriodStart)
AND [Assignment Group] like '%field%' 
AND [Ticket type] ='Incident'
AND State IN (@ResolvedState, @ClosedState)
GROUP BY Subcategory, Issue
ORDER  BY 1, 2


SELECT 
	YEAR(Opened) [Year],
	Month(Opened) [Month],
	SUBSTRING(datename(month, opened), 1, 3) + '-' + SUBSTRING(CONVERT(varchar(4),YEAR(opened)), 3, 2) [Period],
	COUNT(*) [Total Received]
FROM ServiceNowIncidents 
WHERE [Assignment Group] like '%field%' --and [Ticket type] = 'Incident' 
and Opened <= @PeriodEnd
GROUP BY YEAR(Opened) , Month(Opened), SUBSTRING(datename(month, opened), 1, 3) + '-' + SUBSTRING(CONVERT(varchar(4),YEAR(opened)), 3, 2)
ORDER BY 1, 2

-- Aging

SELECT 
	SUM(CASE WHEN [State] != @OnHoldState THEN 1 ELSE 0 END) [Total InProgress],
	SUM(CASE WHEN [State] = @OnHoldState THEN 1 ELSE 0 END) [Total On-Hold],
	SUM(CASE WHEN DATEDIFF(DD, Opened, GETDATE()) <= 5 THEN 1 ELSE 0 END) [5 Days Old],
	SUM(CASE WHEN DATEDIFF(DD, Opened, GETDATE()) BETWEEN 6 AND 10 THEN 1 ELSE 0 END) [10 Days Old],
	SUM(CASE WHEN DATEDIFF(DD, Opened, GETDATE()) BETWEEN 11 AND 15 THEN 1 ELSE 0 END) [15 Days Old],
	SUM(CASE WHEN DATEDIFF(DD, Opened, GETDATE()) > 15 THEN 1 ELSE 0 END) [More than 15 Days Old]
FROM ServiceNowIncidents 
WHERE [Assignment Group] like '%field%' and [Ticket type] = 'Incident' AND [State] NOT IN (@ResolvedState, @ClosedState, @Duplicate)
and Opened <= @PeriodEnd

-- Aging More than 15 days old
SELECT *
FROM ServiceNowIncidents 
WHERE [Assignment Group] like '%field%' and [Ticket type] = 'Incident' AND [State] NOT IN (@ResolvedState, @ClosedState, @Duplicate)
AND (CASE WHEN DATEDIFF(DD, Opened, GETDATE()) > 15 THEN 1 ELSE 0 END) = 1
and Opened <= @PeriodEnd

------------------------------------------ SERVICE REQUESTS

SELECT 
	SUM(CASE WHEN Opened >= @PeriodStart and Opened <= @PeriodEnd THEN 1 ELSE 0 END) [Total SR Received],
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd AND [State] IN (@ClosedState , @ResolvedState) THEN 1 ELSE 0 END) [Total SR Resolved],
	SUM(CASE WHEN [State] IN( @OnHoldState, @InProgress) THEN 1 ELSE 0 END) [Total SR Backlog]
FROM ServiceNowIncidents 
WHERE [Assignment Group] like '%field%' and [Ticket type] != 'Incident'
and Opened <= @PeriodEnd

SELECT 
	CASE WHEN Subcategory  IN ('MYADVISOR', 'ONEVIEW', 'TOPS', 'WISE', 'WPTS', 'WELL TRACKER') THEN Subcategory ELSE 'OTHER' END [Application],
	SUM(CASE WHEN Opened >= @PeriodStart and Opened <= @PeriodEnd THEN 1 ELSE 0 END) [Total Received],
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd AND [State] IN (@ClosedState , @ResolvedState) THEN 1 ELSE 0 END) [Total Resolved],
	SUM(CASE WHEN [State] IN( @OnHoldState, @InProgress) THEN 1 ELSE 0 END) [Total Backlog]

FROM ServiceNowIncidents 
WHERE [Assignment Group] like '%field%' and [Ticket type] != 'Incident' AND Opened <= @PeriodEnd
GROUP BY (CASE WHEN Subcategory  IN ('MYADVISOR', 'ONEVIEW', 'TOPS', 'WISE', 'WPTS', 'WELL TRACKER') THEN Subcategory ELSE 'OTHER' END)
ORDER BY 1 ASC

SELECT 
[Time Spent Current Week] / 3600.0 [Time Spent Current Week],
[Time Spent This Month] / 3600.0 [Time Spent This Month] 
FROM 
(
SELECT 
	SUM(CASE WHEN Resolved >= @PeriodStart and Resolved <= @PeriodEnd THEN [Time spent working on the incident] ELSE 0 END) [Time Spent Current Week],
	SUM(  [Time spent working on the incident]) [Time Spent This Month]
FROM ServiceNowIncidents 
WHERE [Assignment Group] like '%field%' and [Ticket type] != 'Incident' AND MONTH(Resolved) = MONTH(@PeriodStart) AND YEAR(Resolved) = YEAR(@PeriodStart)
AND State IN (@ResolvedState, @ClosedState)
) A

