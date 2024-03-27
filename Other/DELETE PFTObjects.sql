--INSERT INTO PFTConfigSequenceObjects
--(PFTConfigSequenceId, PFTObjectId, DateAdded)
--select configSeq.PFTConfigSeqId, stepChild.ObjectId, GETDATE()

--FROM PFTObjects pft
--JOIN PFTConfig config on config.PFTObjectId = pft.ObjectId

--JOIN PFTObjectMappings pftStepMap on pft.ObjectId = pftStepMap.ParentId
--JOIN PFTConfigSeq configSeq on config.PFTConfigId = configSeq.PFTConfigId and configSeq.Seq = pftStepMap.SequenceNumber

--JOIN PFTObjects step on step.ObjectId = pftStepMap.ObjectId
--JOIN PFTObjectMappings stepChild on step.ObjectId = stepChild.ParentId

----JOIN PFTObjects childs on stepChild.ObjectId = childs.ObjectId


----JOIN PFTConfigSequenceObjects seqObjects on configSeq.PFTConfigSeqId = seqObjects.PFTConfigSequenceId 
----	and seqObjects.PFTObjectId = childs.ObjectId
--where pft.ObjectNumber IN (SELECT OBJECTNUMBER FROM PFTObjects where ProductLineId = 19 and Type = 1 and State = 3) --and seqObjects.DateAdded is null

--order by config.DateAdded, config.PFTObjectId, configSeq.Seq, pftStepMap.SequenceNumber asc


DECLARE @ObjectIds table(ObjectId int)

--INSERT INTO @ObjectIds 
--SELECT po.ObjectId 
--FROM PFTObjects po 
--where ObjectNumber >= 5902 


begin tran

DELETE pd 
from PFTObjectMappings pd
join @ObjectIds o on o.ObjectId = pd.ObjectId

DELETE pd 
from PFTBlobObjects pd
join @ObjectIds o on o.ObjectId = pd.ObjectId


DELETE s 
--select p.PFTObjectId, s.Seq, * 
FROM PFTConfig p 
JOIN PFTConfigSeq s on p.PFTConfigId = s.PFTConfigId
JOIN @ObjectIds o on o.ObjectId = p.PFTObjectId
--order by p.PFTObjectId, s.Seq

DELETE pd 
--select * 
FROM PartDescPFTConfigs pd 
join PFTConfig p on p.PFTConfigId = pd.PFTConfigID 
JOIN @ObjectIds o on o.ObjectId = p.PFTObjectId

DELETE p 
--select * 
FROM PFTConfig p 
JOIN @ObjectIds o on o.ObjectId = p.PFTObjectId

DELETE from PFTObjects where ObjectId in (select objectid from @ObjectIds)

rollback tran