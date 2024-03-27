
DECLARE @Year int = 2018, @Month int = 6

declare @temptable table (hcYear int, hcMonth int, Level1ID int, Level2ID int, EDCategoryID int, LocationID int, 
T_AvgTrainHrs decimal(10,2), P_AvgTrainHrs decimal(10,2),  T_Vehicles int, P_Vehicles int, T_Miles decimal(10,2), P_Miles decimal(10,2), C_Miles decimal(10,2), 
[T_UpdatedDate] datetime, [P_UpdatedDate] datetime)

INSERT INTO @temptable

SELECT a.hcYear , a.hcMonth , a.Level1ID , a.Level2ID , a.EDCategoryID , a.LocationID, t.AvgTrainHrs, p.AvgTrainHrs, t.Vehicles, p.Vehicles, 
t.Miles [Test_Miles], p.Miles [Prod_Miles],
CASE WHEN  p.[UpdatedDate] IS NULL AND t.[UpdatedDate] IS NULL AND t.Miles = 0 AND p.Miles != 0 THEN 0
	WHEN p.[UpdatedDate] = t.[UpdatedDate] and p.Miles != 0 and t.Miles = 0 THEN t.Miles
	WHEN p.[UpdatedDate] = t.[UpdatedDate] and p.Miles = 0 and t.Miles != 0 THEN t.Miles 
ELSE p.Miles END [CalculatedMiles],
t.[UpdatedDate], p.[UpdatedDate]
FROM 
(
	SELECT e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID FROM ExternalData e WHERE e.hcYear = @Year and e.hcMonth = @Month and Level1ID is not null and Level2ID is not null 
	UNION
	SELECT e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID FROM baseline_externaldata_bkp_01032019 e WHERE e.hcYear = @Year and e.hcMonth = @Month and Level1ID is not null and Level2ID is not null 
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
	FROM baseline_externaldata_bkp_01032019 e WHERE e.hcYear = @Year and e.hcMonth = @Month and Level1ID is not null and Level2ID is not null GROUP BY e.hcYear , e.hcMonth , e.Level1ID , e.Level2ID , e.EDCategoryID , e.LocationID
) t ON p.hcYear = t.hcYear AND p.hcMonth = t.hcMonth and p.Level1ID = t.Level1ID AND p.Level2ID = t.Level2ID and p.EDCategoryID = t.EDCategoryID and p.LocationID = t.LocationID
WHERE (ISNULL(t.AvgTrainHrs,0) != ISNULL(p.AvgTrainHrs,0) OR ISNULL(t.Vehicles,0) != ISNULL(p.Vehicles,0) OR ISNULL(t.Miles,0) != ISNULL(p.Miles,0)) 
	and a.EDCategoryID = 20
order by a.Level1ID , a.Level2ID , a.LocationID, a.EDCategoryID

select t.*, e.UpdatedBy, e.UpdatedDate from @temptable t
join ExternalData e on e.hcYear = t.hcYear AND e.hcMonth = t.hcMonth and e.Level1ID = t.Level1ID AND e.Level2ID = t.Level2ID and e.EDCategoryID = t.EDCategoryID and e.LocationID = t.LocationID
where t.C_Miles != 0
order by UpdatedDate asc

select t.EDCategoryID, sum(t_miles) [T_Miles], sum(p_miles) [p_Miles], sum(c_miles) [c_Miles] 
from @temptable t
group by EDCategoryID
