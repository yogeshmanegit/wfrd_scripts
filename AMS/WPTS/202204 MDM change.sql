SELECT * FROM NewMDMPLdata
select * from CurrentMdmData

select c.MDMLevel4Code, n.BASE_CODE, c.MDMLevel3Code, n.PROD_LINE_CODE, c.MDMLevel2Code, n.SEGMENT_CODE, c.MDMLevel1Code, n.GROUP_CODE 
from dbo.CurrentMdmData c 
left join NewMDMPLData n on c.MDMLevel4Code = n.BASE_CODE
where n.BASE_CODE is not null


select * 
from dbo.CurrentMdmData c 
left join NewMDMPLData n on c.MDMLevel4Code = n.BASE_CODE
where n.BASE_CODE is null


select DISTINCT MDMLevel4Code from CurrentMdmData

--DROP TABLE dbo.CurrentMdmData;

--SELECT l1.Level1ID, l1.Level1Name, l1.MDMLevel1Code, 
--l2.Level2ID, l2.MDMLevel2Code, l2.Level2Name, 
--l3.Level3ID, l3.MDMLevel3Code, l3.Level3Name, 
--l4.Level4ID, l4.MDMLevel4Code, l4.Level4Name
--into dbo.CurrentMdmData
--FROM OrgDataLevel1 l1
--JOIN OrgDataLevel2 l2 on l2.Level1ID = l1.Level1ID
--JOIN OrgDataLevel3 l3 on l3.Level2ID = l2.Level2ID
--JOIN OrgDataLevel4 l4 on l4.Level3ID = l3.Level3ID
--WHERE l4.Active = 1

select DISTINCT c.MDMLevel2Code, n.SEGMENT_CODE, c.MDMLevel1Code, n.GROUP_CODE
from dbo.CurrentMdmData c 
left join NewMDMPLData n on c.MDMLevel4Code = n.BASE_CODE
where n.BASE_CODE is not null
and MDMLevel2Code != SEGMENT_CODE
order by 1, 2


select distinct GROUPPL, GROUP_ABBR, GROUP_CODE from NewMDMPLData order by GROUPPL

select l1.*, n.GROUP_CODE from OrgDataLevel1 l1 
left join (select distinct GROUPPL, GROUP_ABBR, GROUP_CODE from NewMDMPLData) n on l1.MDMLevel1Code = n.GROUP_CODE
where Active = 1 
order by group_code, Level1Name

-- Group PL changes
UPDATE OrgDataLevel1 SET MDMLevel1Code = 'DRE', Level1Name ='Drilling & Evaluation' WHERE Level1ID = 20 -- Change MDM code DEI --> DRE
UPDATE OrgDataLevel1 SET Level1Name ='Other and Shared Services' WHERE Level1ID = 21 -- Change label
UPDATE OrgDataLevel1 SET MDMLevel1Code = 'GPL_GLBSSC', Level1Name ='Global Product Shared Services' WHERE Level1ID = 22 -- Change MDM code OV1_GLB_CHRG --> GPL_GLBSSC
UPDATE OrgDataLevel1 SET MDMLevel1Code = 'PRI', Level1Name ='Production & Intervention' WHERE Level1ID = 23 -- Change MDM code PROD --> PRI
UPDATE OrgDataLevel1 SET MDMLevel1Code = 'WCC', Level1Name ='Well Construction & Completions' WHERE Level1ID = 16 -- Change MDM code WCN_EXCL_RIGS --> WCC

--Segment PL changes
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DRE' WHERE Level1ID = 20 -- Change MDM code DEI --> DRE
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'GPL_GLBSSC' WHERE Level1ID = 22 -- Change MDM code DEI --> DRE
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'PRI' WHERE Level1ID = 23 -- Change MDM code PROD --> PRI
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'WCC' WHERE Level1ID = 16 -- Change MDM code WCN_EXCL_RIGS --> WCC
UPDATE OrgDataLevel2 SET Level2Name ='WCC Shared Services', MDMLevel2Code ='GPL_WCC_SSC', MDMLevel1Code = 'WCC', Level1ID = 16 where Level2ID = 82

-- SEGMEMENT Moved from SHSVC --> OTHER
UPDATE OrgDataLevel2 SET Level1ID = 21, MdmLevel1Code = 'OTHER'  WHERE Level2ID = 1
UPDATE OrgDataLevel2 SET Level1ID = 21, MdmLevel1Code = 'OTHER'  WHERE Level2ID = 2
UPDATE OrgDataLevel2 SET Level1ID = 21, MdmLevel1Code = 'OTHER'  WHERE Level2ID = 7
UPDATE OrgDataLevel2 SET Level1ID = 21, MdmLevel1Code = 'OTHER' , Active = 1 WHERE Level2ID = 35
-- SEGMEMENT Moved from CMPD --> PRI
UPDATE OrgDataLevel2 SET Level1ID = 23 , MdmLevel1Code = 'PRI' WHERE Level2ID = 65
UPDATE OrgDataLevel2 SET Level1ID = 23 , MdmLevel1Code = 'PRI' WHERE Level2ID = 76
UPDATE OrgDataLevel2 SET Level1ID = 23 , MdmLevel1Code = 'PRI' WHERE Level2ID = 77
-- SEGMEMENT Moved from CMPD --> WCC
UPDATE OrgDataLevel2 SET Level1ID = 16, MdmLevel1Code = 'WCC' WHERE Level2ID = 66
UPDATE OrgDataLevel2 SET Level1ID = 16, MdmLevel1Code = 'WCC' WHERE Level2ID = 20
UPDATE OrgDataLevel2 SET Level1ID = 16, MdmLevel1Code = 'WCC' WHERE Level2ID = 74
UPDATE OrgDataLevel2 SET Level1ID = 16, MdmLevel1Code = 'WCC' WHERE Level2ID = 53


-- Deactivate COMP Sand Control Solutions, testing, gas lift , Reservoir Monitoring, CMPD Shared Services, Shared Services PROD
UPDATE OrgDataLevel2 SET active = 0 WHERE Level2ID IN (28, 32, 57, 58, 63, 81, 70,  85, 38, 30)

UPDATE OrgDataLevel2 SET MDMLevel2Code ='GPL_DISC', Level2Name = 'Discontinued Product Lines' WHERE Level2ID = 69
update OrgDataLevel2 set MDMLevel2Code ='GPL_ISDT', Level2Name ='Intervention Services & Drilling Tools', Level1ID = 23, MDMLevel1Code ='PRI' where Level2ID = 72


--------------------------------------------------------------
-- PRODUCT_LINE MOVED TO GPL_MPD Managed Pressure Drilling
UPDATE OrgDataLevel3 SET Level2ID = 52 WHERE Level3ID = 129
UPDATE OrgDataLevel3 SET Level2ID = 67, MDMLevel2Code ='GPL_DF' WHERE Level3ID = 3
UPDATE OrgDataLevel3 SET Level2ID = 77, MDMLevel2Code ='GPL_PS' WHERE Level3ID = 222

UPDATE OrgDataLevel3 SET Active = 0 where Level3ID in (186, 279, 298, 299, 101, 241, 309)
UPDATE OrgDataLevel3 SET MDMLevel3Code ='OV3_WCC_SSC', Level3Name ='WCC Shared Services' WHERE Level3ID = 203
Update OrgDataLevel3 SET MDMLevel3Code = 'TTL_WTS', MDMLevel2Code ='GPL_MPD', Level2ID = 52, Level3Name ='Surface Testing Services' where Level3ID = 28

UPDATE OrgDataLevel3 SET MDMLevel2Code = 'GPL_MPD', Level2ID = 52, Level3Name='Surface Testing Services' where Level3ID = 95

IF NOT EXISTS(Select * from OrgDataLevel3 where level3id = 344)
BEGIN 
	SET IDENTITY_INSERT OrgDataLevel3 ON 
	INSERT INTO OrgDataLevel3 (Level3ID, MDMLevel3Code, Level3Name, Level2ID, MDMLevel2Code, Active) VALUES(344, 'TTL_REJ', 'Rejuvenation', 53, 'GPL_WLS', 1)
	SET IDENTITY_INSERT OrgDataLevel3 OFF
END

UPDATE OrgDataLevel3 SET MDMLevel2Code ='GPL_PS', Level2ID = 77 WHERE Level3ID = 200
UPDATE OrgDataLevel3 SET MDMLevel3Code ='TTL_EPF', Level3Name ='Early Production Facilities', MDMLevel2Code ='GPL_DISC', Level2ID = 69 WHERE Level3ID = 231
UPDATE OrgDataLevel3 SET MDMLevel3Code = 'TTL_IDPM', Level3Name='Integrated Drilling - Project Management', Level2ID = 69, MDMLevel2Code ='GPL_DISC' WHERE Level3ID = 234
UPDATE OrgDataLevel3 SET MDMLevel3Code = 'TTL_LABS', Level3Name='Laboratories', Level2ID = 69, MDMLevel2Code ='GPL_DISC' WHERE Level3ID = 318
UPDATE OrgDataLevel3 SET MDMLevel3Code ='TTL_RIGS', Level3Name ='Land Drilling Rigs', Level2ID = 69, MDMLevel2Code ='GPL_DISC' WHERE Level3ID = 332
UPDATE OrgDataLevel3 SET MDMLevel3Code ='TTL_SLOG', Level3Name ='Surface Logging', Level2ID = 69, MDMLevel2Code ='GPL_DISC' WHERE Level3ID = 175

Update OrgDataLevel3 SET MdmLevel2Code ='GPL_ISDT', Level3Name='INTS - Well Abandonment' WHERE Level3ID = 111
Update OrgDataLevel3 SET MdmLevel2Code ='GPL_ISDT' , Level3Name='INTS - Fishing' WHERE Level3ID = 113
Update OrgDataLevel3 SET MdmLevel2Code ='GPL_ISDT', MDMLevel3Code = 'SUB_REE', Level3Name='INTS - Re Entry' WHERE Level3ID = 294
Update OrgDataLevel3 SET MdmLevel2Code ='GPL_ISDT' WHERE Level3ID = 11



-- Level 4
UPDATE OrgDataLevel4 SET MDMLevel3Code ='OV3_WCC_SSC', Level3ID = 203, Level4Name='DNU WCN Shared Service Cost' WHERE Level4ID = 384
UPDATE OrgDataLevel4 SET Level3ID = 203, MDMLevel3Code ='OV3_WCC_SSC' WHERE level4id = 391
UPDATE OrgDataLevel4 SET MDMLevel3Code ='TTL_WTS', Level3ID = 95 where Level4ID IN (235, 239, 616, 702)
UPDATE OrgDataLevel4 SET Level3ID = 344, MDMLevel3Code = 'TTL_REJ' WHERE Level4ID = 552
UPDATE OrgDataLevel4 SET MDMLevel3Code ='TTL_EPF', Level3ID = 231 WHERE Level4ID = 325
UPDATE OrgDataLevel4 SET MDMLevel3Code = 'TTL_IDPM', Level4Name= 'Project Mgmt' WHERE Level4ID = 332
UPDATE OrgDataLevel4 SET MDMLevel3Code = 'TTL_LABS', Level3ID = 318 WHERE Level4ID IN (178, 179, 180, 376, 377, 381, 554, 555, 556, 557, 558, 559, 560, 737)

UPDATE OrgDataLevel4 SET MDMLevel3Code ='TTL_RIGS', Level4Name ='PDI_RIGS' WHERE Level4ID = 324
UPDATE OrgDataLevel4 SET MDMLevel3Code ='TTL_SLOG', Level4Name ='SLS General' WHERE Level4ID = 364

Update OrgDataLevel4 SET MdmLevel3Code ='SUB_REE' WHERE Level4ID = 275
Update OrgDataLevel4 SET MdmLevel3Code ='SUB_REE' WHERE Level4ID = 276
Update OrgDataLevel4 SET MdmLevel3Code ='SUB_REE' WHERE Level4ID = 492
Update OrgDataLevel4 SET MdmLevel3Code ='SUB_REE' WHERE Level4ID = 493
Update OrgDataLevel4 SET MdmLevel3Code ='SUB_REE' WHERE Level4ID = 494
Update OrgDataLevel4 SET MdmLevel3Code ='SUB_REE' WHERE Level4ID = 637
Update OrgDataLevel4 SET MdmLevel3Code ='SUB_REE' WHERE Level4ID = 638
Update OrgDataLevel4 SET MdmLevel3Code ='SUB_REE' WHERE Level4ID = 639