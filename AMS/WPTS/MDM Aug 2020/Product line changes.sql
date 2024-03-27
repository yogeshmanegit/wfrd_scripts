use ofis;

-------------------------------------------- OrgDataLevel 1 Starts --------------------------------------------------------

-- change completion to 'Completion & Production'
UPDATE OrgDataLevel1 SET MDMLevel1Code = 'CMPD', Level1Name = 'Completion & Production' WHERE Level1ID = 4

-- Update Drilling & Evaluation --> Drilling, Evaluation & Intervention
UPDATE OrgDataLevel1 SET MDMLevel1Code = 'DEI', Level1Name = 'Drilling, Evaluation & Intervention' WHERE Level1ID = 20

--UPDATE OrgDataLevel1 SET Active = 0 WHERE Level1ID NOT IN (4, 20, 21, 24, 22)

-------------------------------------------- OrgDataLevel 2 Starts --------------------------------------------------------

UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level2Name ='Completions' WHERE Level2ID = 20
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD' WHERE Level2ID = 28
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD' WHERE Level2ID = 53
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD' WHERE Level2ID = 57
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD' WHERE Level2ID = 58
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level2Name ='CMPD Shared Services' WHERE Level2ID = 63
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD' WHERE Level2ID = 66
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD' WHERE Level2ID = 74

UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' WHERE Level2ID = 10
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' WHERE Level2ID = 17
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' WHERE Level2ID = 30
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' WHERE Level2ID = 34
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' WHERE Level2ID = 52
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' WHERE Level2ID = 60
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI', Level2Name ='DEI Shared Services' WHERE Level2ID = 64
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' WHERE Level2ID = 85

UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level1Id =  4  WHERE Level2ID = 66
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level1Id =  4  WHERE Level2ID = 74
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level1Id =  4  WHERE Level2ID = 20
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level1Id =  4  WHERE Level2ID = 53
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level1Id =  4  WHERE Level2ID = 65
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level1Id =  4  WHERE Level2ID = 76
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level1Id =  4, Level2Name ='Production Automation & Software'  WHERE Level2ID = 77
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'CMPD', Level1Id =  4  WHERE Level2ID = 32

UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' , Level1Id =  20 WHERE Level2ID = 10
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' , Level1Id =  20 WHERE Level2ID = 52
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' , Level1Id =  20 WHERE Level2ID = 34
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' , Level1Id =  20 WHERE Level2ID = 67
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' , Level1Id =  20 WHERE Level2ID = 68
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' , Level1Id =  20 WHERE Level2ID = 72
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' , Level1Id =  20 WHERE Level2ID = 79
UPDATE OrgDataLevel2 SET MDMLevel1Code = 'DEI' , Level1Id =  20 WHERE Level2ID = 39

UPDATE OrgDataLevel2 SET MDMLevel2Code = 'GPL_DEI' WHERE Level2ID = 64
UPDATE OrgDataLevel2 SET MDMLevel2Code ='GPL_RIGS', Level1ID = 21 WHERE Level2Id = 38

--Merge OV2_COMP_SS & OV2_PROD_SS --> GPL_CMPD
UPDATE OrgDataLevel2 SET MDMLevel2Code ='GPL_CMPD' WHERE Level2ID = 63
UPDATE OrgDataLevel2 SET Active = 0 WHERE Level2ID = 81

--Deactivate OV2_WCN_SS	(Shared Services WCN) and move childs --> GPL_DEI (Shared Services DEVA)
 UPDATE OrgDataLevel2 SET Active = 0 WHERE Level2ID = 82

-------------------------------------------- OrgDataLevel 3 Starts --------------------------------------------------------

UPDATE OrgDataLevel3 SET Level3Name = 'ALS Gas Lift' WHERE Level3ID = 264
UPDATE OrgDataLevel3 SET Level3Name = 'Cementation Prod' WHERE Level3ID = 268
UPDATE OrgDataLevel3 SET Level3Name = 'DNU ALS Capillary Injection' WHERE Level3ID = 263
UPDATE OrgDataLevel3 SET Level3Name = 'DRT Drill Pipe & Collars' WHERE Level3ID = 275
UPDATE OrgDataLevel3 SET Level3Name = 'DRT Inspection/Machine Shop/TPS' WHERE Level3ID = 305
UPDATE OrgDataLevel3 SET Level3Name = 'DRT Performance Drilling Tools' WHERE Level3ID = 274
UPDATE OrgDataLevel3 SET Level3Name = 'DRT Pressure Control Equipment' WHERE Level3ID = 288
UPDATE OrgDataLevel3 SET Level3Name = 'DRT Wellhead Systems' WHERE Level3ID = 183
UPDATE OrgDataLevel3 SET Level3Name = 'DS Geoscience Consulting Services' WHERE Level3ID = 315
UPDATE OrgDataLevel3 SET Level3Name = 'DS Software Solutions' WHERE Level3ID = 200
UPDATE OrgDataLevel3 SET Level3Name = 'Logging While Drilling' WHERE Level3ID = 151
UPDATE OrgDataLevel3 SET Level3Name = 'Measuring While Drilling' WHERE Level3ID = 153
UPDATE OrgDataLevel3 SET Level3Name = 'Production Automation' WHERE Level3ID = 251
UPDATE OrgDataLevel3 SET Level3Name = 'Pumping Unit Services' WHERE Level3ID = 337
UPDATE OrgDataLevel3 SET Level3Name = 'Rig System Services (Mechanized)' WHERE Level3ID = 217
UPDATE OrgDataLevel3 SET Level3Name = 'Solid Expandable Systems' WHERE Level3ID = 301
UPDATE OrgDataLevel3 SET Level3Name = 'Tubular Management Services' WHERE Level3ID = 304
UPDATE OrgDataLevel3 SET Level3Name = 'WL Geoscience Consulting Services' WHERE Level3ID = 308


-- Move level 3 to another level 2 from existing
UPDATE OrgDataLevel3 SET MDMLevel2Code = 'GPL_DF', Level2ID = 67  WHERE Level3ID = 277
UPDATE OrgDataLevel3 SET MDMLevel2Code = 'GPL_WLS', Level2ID =  53 WHERE Level3ID = 115
UPDATE OrgDataLevel3 SET MDMLevel2Code = 'GPL_PS', Level2ID =  77 WHERE Level3ID = 251
UPDATE OrgDataLevel3 SET MDMLevel2Code = 'GPL_WLS', Level2ID = 53 WHERE Level3ID = 306

Update OrgDataLevel3 SET Level2ID =69, MDMLevel2Code ='GPL_DVT', Active = 1 where Level3ID = 148 -- Make TTL_LABS active again

Update OrgDataLevel3 SET MDMLevel3Code = 'TTL_SLOG' WHERE Level3ID = 335
Update OrgDataLevel3 SET Active = 0 WHERE Level3ID = 175 -- Make 'OV3_SLOG' inactive
Update OrgDataLevel3 SET MDMLevel2Code = 'GPL_DEI', Level2ID = 64 WHERE Level2ID = 64 -- BC_DEVA, OV3_DSSC

UPDATE OrgDataLevel3 SET MDMLevel2Code ='GPL_RIGS' WHERE Level2Id = 38

UPDATE OrgDataLevel3 SET Level2ID = 63, MDMLevel2Code ='GPL_CMPD' WHERE Level3ID IN (3, 222)

UPDATE OrgDataLevel3 SET MDMLevel3Code ='GPL_DEI', Level2ID = 64 WHERE Level3ID = 203

-------------------------------------------- OrgDataLevel 4 Changes Starts --------------------------------------------------------

--select p.L4Code, l.L4Code, p.L4Name, l.L4Name
--from vw_OrgDataLevelMDM2020 p
--join vw_OrgDataLevel l on p.L4Code = l.L4Code 
--WHERE p.L4Name != l.L4Name

Update OrgDataLevel4 SET Level4Name = 'DNU Capillary Injection ALS Product Line' WHERE Level4ID = 552
Update OrgDataLevel4 SET Level4Name = 'ALS Shared Costs' WHERE Level4ID = 375
Update OrgDataLevel4 SET Level4Name = 'Rotaflex Long Stroke Pumping Unit' WHERE Level4ID = 67
Update OrgDataLevel4 SET Level4Name = 'Refurbished and Used Pumping Unit' WHERE Level4ID = 371
Update OrgDataLevel4 SET Level4Name = 'Sand Control Fluid Solutions' WHERE Level4ID = 464
Update OrgDataLevel4 SET Level4Name = 'CWS Conventional Well Screen Gen' WHERE Level4ID = 150
Update OrgDataLevel4 SET Level4Name = 'Production Optimization Consulting' WHERE Level4ID = 155
Update OrgDataLevel4 SET Level4Name = 'TPS Surface Well Testing Onshore' WHERE Level4ID = 248
Update OrgDataLevel4 SET Level4Name = 'Thru Tubing Fishing' WHERE Level4ID = 192
Update OrgDataLevel4 SET Level4Name = 'FRE Wellbore Cleaning' WHERE Level4ID = 273
Update OrgDataLevel4 SET Level4Name = 'FRE Wellbore Cleaning Filtration' WHERE Level4ID = 387
Update OrgDataLevel4 SET Level4Name = 'FRE Wellbore Cleaning Perf & Wash' WHERE Level4ID = 698
Update OrgDataLevel4 SET Level4Name = 'DEI Software Shared Services' WHERE Level4ID = 398
Update OrgDataLevel4 SET Level4Name = 'Drilling Fluids & DWM Support Services' WHERE Level4ID = 670
Update OrgDataLevel4 SET Level4Name = 'Wholesale' WHERE Level4ID = 668
Update OrgDataLevel4 SET Level4Name = 'Specialty Chemicals' WHERE Level4ID = 96
Update OrgDataLevel4 SET Level4Name = 'DS Shared Service Cost' WHERE Level4ID = 390
Update OrgDataLevel4 SET Level4Name = 'Down Hole Motors' WHERE Level4ID = 223
Update OrgDataLevel4 SET Level4Name = 'Drilling Engineering' WHERE Level4ID = 382
Update OrgDataLevel4 SET Level4Name = 'Real-Time Data Services (RTDS)' WHERE Level4ID = 318
Update OrgDataLevel4 SET Level4Name = 'MPD Shared Service Cost' WHERE Level4ID = 172
Update OrgDataLevel4 SET Level4Name = 'Downhole Deployment Valve' WHERE Level4ID = 242
Update OrgDataLevel4 SET Level4Name = 'Rotating Control Device' WHERE Level4ID = 249
Update OrgDataLevel4 SET Level4Name = 'MPD Continuous Flow' WHERE Level4ID = 250
Update OrgDataLevel4 SET Level4Name = 'Separation System' WHERE Level4ID = 739
Update OrgDataLevel4 SET Level4Name = 'Compression System' WHERE Level4ID = 738
Update OrgDataLevel4 SET Level4Name = 'TRS Mud Pumps' WHERE Level4ID = 39
Update OrgDataLevel4 SET Level4Name = 'TRS Well Service Equipment OCM' WHERE Level4ID = 60
Update OrgDataLevel4 SET Level4Name = 'TRS Equipment Sales' WHERE Level4ID = 379
Update OrgDataLevel4 SET Level4Name = 'TRS Drilling With Casing' WHERE Level4ID = 596
Update OrgDataLevel4 SET Level4Name = 'TRS Tubular Management Services' WHERE Level4ID = 587
Update OrgDataLevel4 SET Level4Name = 'TRS Rig Mechanization' WHERE Level4ID = 216
Update OrgDataLevel4 SET Level4Name = 'WL Shared Service Cost' WHERE Level4ID = 697
Update OrgDataLevel4 SET Level4Name = 'CH Wireline' WHERE Level4ID = 191
Update OrgDataLevel4 SET Level4Name = 'OH Wireline' WHERE Level4ID = 285
Update OrgDataLevel4 SET Level4Name = 'Wireline Geoscience Consulting Services' WHERE Level4ID = 187
Update OrgDataLevel4 SET Level4Name = 'Industrial Screens - Other' WHERE Level4ID = 78
Update OrgDataLevel4 SET Level4Name = 'Product Line - Other' WHERE Level4ID = 295
Update OrgDataLevel4 SET Level4Name = 'PDI_RIGS' WHERE Level4ID = 324


Update OrgDataLevel4 SET MDMLevel3Code ='TTL_LABS', Level3ID = 148 WHERE Level4ID = 178 -- Move PL_COR	(PL Laboratories)

-- enable old deactivated gl codes
Update OrgDataLevel4 SET Active = 1 WHERE Level4ID IN (189, 217, 220, 334, 344, 345, 360, 384, 391, 416, 573, 584, 602, 650)

Update OrgDataLevel4 SET Level4Name ='TRS Bucking Units Sales' WHERE Level4ID = 217
Update OrgDataLevel4 SET Level4Name ='TRS Iron Derrickman Sales' WHERE Level4ID = 220
Update OrgDataLevel4 SET Level4Name ='MPD Software' WHERE Level4ID = 360
Update OrgDataLevel4 SET Level4Name ='TRS Mechanized Equipment Sales' WHERE Level4ID = 584

SET IDENTITY_INSERT OrgDataLevel4 ON;

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_DGC')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (740, 'PL_DGC','DS IES Solutions',315,'TTL_DSC',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_DHG')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (741, 'PL_DHG','DS Other Geoscience Consulting Services',315,'TTL_DSC',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_DHC')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (742, 'PL_DHC','RSS Magnus',170,'TTL_RSS',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_DDA')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (743, 'PL_DDA','DS Other Software',200,'TTL_SFT',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_DLI')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (744, 'PL_DLI','MPD Capital Sales',326,'TTL_CAPS',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_ATT')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (745, 'PL_ATT','TRS Vero',217,'TTL_TRSS',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_PAR')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (746, 'PL_PAR','WL IES Solutions',308,'TTL_WLG',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_DCC')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (747, 'PL_DCC','MPD Engineering Services',319,'OV3_COMP_PKG',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_PMM')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (748, 'PL_PMM','Fluid Extraction',320,'OV3_FLD_EXTR',1, 1, 1)

IF NOT EXISTS (SELECT * FROM OrgDataLevel4 WHERE MDMLevel4Code = 'PL_PSE')
	INSERT INTO OrgDataLevel4 (Level4Id, MdmLevel4Code, Level4Name, Level3Id, MdmLevel3Code, InNewJobList, EnabledInJobList, Active) VALUES (749, 'PL_PSE','Pressure Control Manifold',324,'OV3_PCM',1, 1, 1)

SET IDENTITY_INSERT OrgDataLevel4 OFF;
