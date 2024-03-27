BEGIN TRAN

SET NOCOUNT ON 

DECLARE @tempTable TABLE (ReportId INT)

INSERT INTO @tempTable

select h.ReportID
from HdrProfile h
join UserChoiceKey uk on h.ReportID = uk.ReportID
join UserChoiceValue uv on uk.ID = uv.[Key]
where uk.dbFieldID = 38032 and  h.ReportID IN (select h.ReportID  
from HdrProfile h join OrgDataLevel4 o on h.Level4ID=o.Level4ID where o.Active=1)

UNION

select h.ReportID
from HdrProfile h
join UserChoiceKey uk on h.ReportID=uk.ReportID
join UserChoiceValue uv on uk.ID = uv.[Key]
where uk.dbFieldID = 38031 and  h.ReportID  IN (select h.ReportID  from HdrProfile h 
join OrgDataLevel3 o on h.Level3ID=o.Level3ID where o.Active=1)  

UNION

SELECT h.ReportID
from HdrProfile h
left join OrgDataLevel1 l1 on l1.Level1ID = h.Level1ID AND l1.Active = 1
left join OrgDataLevel2 l2 on l2.Level2ID = h.Level2ID AND l2.Active = 1
left join OrgDataLevel3 l3 on l3.Level3ID = h.Level3ID AND l3.Active = 1
LEFT Join OrgDataLevel4 l4 ON h.Level4ID = l4.Level4ID
WHERE (h.Level1ID IS NOT NULL AND l1.Level1ID is null)
		OR (h.Level2ID IS NOT NULL AND l2.Level2ID is null)
		OR (h.Level3ID IS NOT NULL AND l3.Level3ID is null)
 AND l4.Active = 1

 ORDER By 1 
--Reset Level 4 Id for active Level 4's (auto correct leve1-level3 also)


DECLARE @ReportID as int

DECLARE cur_ReportIds CURSOR FOR SELECT * FROM @tempTable
OPEN cur_ReportIds
FETCH NEXT FROM cur_ReportIds INTO @ReportID
WHILE @@FETCH_STATUS = 0
       Begin

       --print @ReportID

       UPDATE h SET Level4ID  = h.Level4ID from HdrProfile h WHERE ReportID = @ReportID

       FETCH NEXT FROM cur_ReportIds INTO @ReportID

       END

CLOSE cur_ReportIds
DEALLOCATE cur_ReportIds

SET NOCOUNT OFF

ROLLBACK TRAN

