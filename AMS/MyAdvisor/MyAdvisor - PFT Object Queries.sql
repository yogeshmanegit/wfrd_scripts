select * from SelectOptions where SelectName like '%PFTObjectType%' order by SortOrder

--get all steps of pft using pft object id
select steps.* 
from PFTObjects pft
JOIN PFTObjectMappings stepsMapping on pft.ObjectId = stepsMapping.ParentId
join PFTObjects steps on stepsMapping.ObjectId = steps.ObjectId
where pft.ObjectId = 281641

-- get pictures, messages or videos of all steps of pft
select stepChilds.* 
from PFTObjects pft
JOIN PFTObjectMappings stepsMapping on pft.ObjectId = stepsMapping.ParentId
JOIN PFTObjects step on stepsMapping.ObjectId = step.ObjectId
JOIN PFTObjectMappings stepChildsMapping on step.ObjectId = stepChildsMapping.ParentId
JOIN PFTObjects stepChilds on stepChildsMapping.ObjectId = stepChilds.ObjectId
where pft.ObjectId = 281641

