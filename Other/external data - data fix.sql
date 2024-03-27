
DECLARE @Year int = 2018, @Month int = 6

declare @temptable table (hcYear int, hcMonth int, Level1ID int, Level2ID int, EDCategoryID int, LocationID int, 
T_AvgTrainHrs decimal(10,2), P_AvgTrainHrs decimal(10,2),  T_Vehicles int, P_Vehicles int, T_Miles decimal(10,2), P_Miles decimal(10,2), 
[T_UpdatedDate] datetime, [P_UpdatedDate] datetime, [state] int, [Reason] varchar(100))

INSERT INTO @temptable
SELECT a.hcYear , a.hcMonth , a.Level1ID , a.Level2ID , a.EDCategoryID , a.LocationID, t.AvgTrainHrs, p.AvgTrainHrs, t.Vehicles, p.Vehicles, t.Miles, p.Miles, 
t.[UpdatedDate], p.[UpdatedDate],

CASE WHEN  t.[UpdatedDate] = p.[UpdatedDate] THEN 'Date matching but numbers are not matching'
	WHEN t.[UpdatedDate] IS NULL AND p.[UpdatedDate] IS NULL THEN 'Date matching but numbers are not matching'
	WHEN t.[UpdatedDate] IS NOT NULL AND p.[UpdatedDate] IS NULL THEN 'System Ovverriden'
	WHEN t.[UpdatedDate] IS NULL AND p.[UpdatedDate] IS NOT NULL THEN 'Last edit is made by user'

	WHEN ISNULL(t.[UpdatedDate], '2001-01-01') < ISNULL(p.[UpdatedDate], GETDATE()) THEN 'Last edit is made by user'
END [Reason]
FROM 
(
	SELECT e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID FROM ExternalData e WHERE e.hcYear = @Year and e.hcMonth = @Month and Level1ID is not null and Level2ID is not null 
	UNION
	SELECT e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID FROM copy_externaldata_bkp_01032019 e WHERE e.hcYear = @Year and e.hcMonth = @Month and Level1ID is not null and Level2ID is not null 
) A
-- Production
left JOIN 
(
	SELECT e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID, SUM(ISNULL(AvgTrainHrs,0)) [AvgTrainHrs], SUM(ISNULL(Vehicles,0)) [Vehicles], SUM(ISNULL(Miles,0)) [Miles], Max(UpdatedDate) [UpdatedDate]
	FROM ExternalData e WHERE e.hcYear = @Year and e.hcMonth = @Month and Level1ID is not null and Level2ID is not null GROUP BY e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID
) P ON p.hcYear = a.hcYear AND p.hcMonth = a.hcMonth and p.Level1ID = a.Level1ID AND p.Level2ID = a.Level2ID and p.EDCategoryID = a.EDCategoryID and p.LocationID = a.LocationID
-- Test
left JOIN 
(
	SELECT e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID, SUM(ISNULL(AvgTrainHrs,0)) [AvgTrainHrs], SUM(ISNULL(Vehicles,0)) [Vehicles], SUM(ISNULL(Miles,0)) [Miles] , Max(UpdatedDate) [UpdatedDate]
	FROM copy_externaldata_bkp_01032019 e WHERE e.hcYear = @Year and e.hcMonth = @Month and Level1ID is not null and Level2ID is not null GROUP BY e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID
) t ON p.hcYear = t.hcYear AND p.hcMonth = t.hcMonth and p.Level1ID = t.Level1ID AND p.Level2ID = t.Level2ID and p.EDCategoryID = t.EDCategoryID and p.LocationID = t.LocationID
WHERE (ISNULL(t.AvgTrainHrs,0) != ISNULL(p.AvgTrainHrs,0) OR ISNULL(t.Vehicles,0) != ISNULL(p.Vehicles,0) OR ISNULL(t.Miles,0) != ISNULL(p.Miles,0))
and a.EDCategoryID = 20
order by a.Level1ID , a.Level2ID , a.LocationID, a.EDCategoryID


--UPDATE c
--SET AvgTrainHrs = T_AvgTrainHrs,
--	Vehicles = T_Vehicles,
--	Miles = T_Miles
--FROM copy_externaldata_bkp_01212019 c
--join @temptable t on c.Level1ID = t.Level1ID and c.Level2ID = t.Level2ID and c.LocationID = t.LocationID and c.EDCategoryID = t.EDCategoryID and c.hcYear = t.hcYear AND c.hcMonth = t.hcMonth 
--where state > 0


