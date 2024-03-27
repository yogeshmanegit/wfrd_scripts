SELECT * 
FROM VwBoardFirmwares f
--left join ItemNumRevisions i on f.FirmwareItemNum = i.ItemNum
 Where BoardItemNum = '1580961'


SELECT *
  FROM [ItemNumRevisions]
  where ItemNum = '1649029' Order by DateAdded desc

--  Update ItemNumRevisions
--  SET DateAdded = GETDATE()
--  Where ItemNumRevisionId = '513C2157-C9EC-4694-A7BF-0E905E2058E4'
Update BoardFirmwares
SET IsFieldTest = 1, FieldTestRevision = '0.80'
Where BoardFirmwareId ='71A9051E-FA7B-48A2-B582-A34F00EB5EC8'

SELECT * FROM BoardFirmwares Where BoardItemNum = '1580961'
--Update ItemNumRevisions
--SET Active = 0
--Where ItemNumRevisionId IN(
--SELECT top 4 ItemNumRevisionId FROM ItemNumRevisions Where ItemNum = '1649029' ORDER By DateAdded desc)