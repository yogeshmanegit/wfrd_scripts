--Supervisor/ Day of week/ Shift/ Work Center/ Material Spec/ Material Size/ Type Connection/ Supplement Info


INSERT INTO CodeKey(Template,Name,Description,ListTable,DataValueField,DataTextField,OrderByString,UserChoiceValue,AllowEdit,Active,UniversalId ) 
VALUES ('ncr1','Day of Week','Day of Week','CodeValue','ID','Name','Sort, Name',0,1,1,NEWID());
GO
Declare @Codekey int
Set @CodeKey = NULL
SET @CodeKey = (Select ID from CodeKey where Template='ncr1'and Name = 'Day of Week')

INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Monday',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Tuesday',2,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Wednesday',3,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Thursday',4,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Friday',5,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Saturday',6,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Sunday',7,1);
GO


INSERT INTO CodeKey(Template,Name,Description,ListTable,DataValueField,DataTextField,OrderByString,UserChoiceValue,AllowEdit,Active,UniversalId ) 
VALUES ('ncr1','Shift Number','Shift Number','CodeValue','ID','Name','Sort, Name',0,1,1,NEWID());
GO
Declare @Codekey int
Set @CodeKey = NULL
SET @CodeKey = (Select ID from CodeKey where Template='ncr1'and Name = 'Shift Number')

INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'1',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'2',2,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'3',3,1);
GO


INSERT INTO CodeKey(Template,Name,Description,ListTable,DataValueField,DataTextField,OrderByString,UserChoiceValue,AllowEdit,Active,UniversalId ) 
VALUES ('ncr1','Supplement Info','Supplement I nfo','CodeValue','ID','Name','Sort, Name',0,1,1,NEWID());
GO
Declare @Codekey int
Set @CodeKey = NULL
SET @CodeKey = (Select ID from CodeKey where Template='ncr1'and Name = 'Supplement Info')

INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Weatherford',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Client',2,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Other',3,1);
GO


ALTER TABLE gpi1
ADD SupervisorID int null,
DayWeek varchar(15) null,
ShiftNumber int null,
WorkCenter varchar(50) null,
MaterialSpec varchar(50) null,
MaterialSize varchar(50) null,
TypeConnection varchar(50) null,
SupplementInfo varchar(15) null,
SupplementInfoClientID int null
GO
 

Declare @O int
SET @O=(Select max(O) from dbFields where T='ncr1')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Supervisor',NULL,NULL,'int',NULL,NULL,NULL,'select Supervisor','SupervisorID','int',NULL,NULL,NULL,
1133,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

Declare @O int
Declare @Codekey int
Set @CodeKey = NULL
SET @CodeKey = (Select ID from CodeKey where Template='ncr1'and Name = 'Day of Week')
SET @O=(Select max(O) from dbFields where T='ncr1')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Day of Week',NULL,NULL,'varchar',NULL,NULL,NULL,'select Day of Week','DayWeek','varchar',15,NULL,NULL,
@CodeKey,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

Declare @O int
Declare @Codekey int
Set @CodeKey = NULL
SET @CodeKey = (Select ID from CodeKey where Template='ncr1'and Name = 'Shift Number')
SET @O=(Select max(O) from dbFields where T='ncr1')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Shift',NULL,NULL,'int',NULL,NULL,NULL,'select Shift','ShiftNumber','int',NULL,NULL,NULL,
@CodeKey,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

Declare @O int
SET @O=(Select max(O) from dbFields where T='ncr1')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Work Center',NULL,NULL,'varchar',NULL,NULL,NULL,'Enter Work Center','WorkCenter','varchar',50,NULL,NULL,
NULL,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

Declare @O int
SET @O=(Select max(O) from dbFields where T='ncr1')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Material Spec',NULL,NULL,'varchar',NULL,NULL,NULL,'Enter Material Spec','MaterialSpec','varchar',50,NULL,NULL,
NULL,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

Declare @O int
SET @O=(Select max(O) from dbFields where T='ncr1')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Material Size',NULL,NULL,'varchar',NULL,NULL,NULL,'Enter Material Size','MaterialSize','varchar',50,NULL,NULL,
NULL,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

Declare @O int
SET @O=(Select max(O) from dbFields where T='ncr1')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Type Connection',NULL,NULL,'varchar',NULL,NULL,NULL,'Enter Type Connection','TypeConnection','varchar',50,NULL,NULL,
NULL,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

Declare @O int
SET @O=(Select max(O) from dbFields where T='ncr1')
Declare @Codekey int
Set @CodeKey = NULL
SET @CodeKey = (Select ID from CodeKey where Template='ncr1'and Name = 'Supplement Info')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Supplement Info',NULL,NULL,'varchar',NULL,NULL,NULL,'Select Supplement Info','SupplementInfo','varchar',15,NULL,NULL,
@CodeKey,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

Declare @O int
SET @O=(Select max(O) from dbFields where T='ncr1')

 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr1','General Information',NULL,'Supplement Info Client',NULL,NULL,'int',NULL,NULL,NULL,'select Supplement Info Client','SupplementInfoClientID','int',NULL,NULL,NULL,
1517,0,NULL,1,NULL,0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO

-- Defect code description


INSERT INTO CodeKey(Template,Name,Description,ListTable,DataValueField,DataTextField,OrderByString,UserChoiceValue,AllowEdit,Active,UniversalId ) 
VALUES ('ncr2','Mfg Defect Description','Mfg Defect Description','CodeValue','ID','Name','Sort, Name',0,1,1,NEWID());
GO

Declare @Codekey int
Set @CodeKey = NULL
SET @CodeKey = (Select ID from CodeKey where Template='ncr2'and Name = 'Mfg Defect Description')

INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code A-Porosity',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code B-Dimensional',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code C-Hardness',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code D-No Drift',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code E-Lack/ Incomplete of fusion',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code F-Lack/ Incomplete of penetration',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code G-Weld overlap',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code H-Failed assembly/ Pressure test',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code I-Under/ Over pour',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code J-Broken components',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code K-Rust/ Corrosion/ Pitting',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code L-Part identification (Marking/ Stamping/ Stencil)',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code M-Surface finish',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code N-Voids',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code O-Product traceability',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code P-Mechanical damage (Bent/ Dented)',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code Q-Plama cut incorrect',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code R-Cracks/ Fracture',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code S-Thread damage',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code T-Splatter',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code U-Process contamination',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code V-Melted/ Burned/ Overheated',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code W-Deformed rod',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code X-Ears',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code Y-Sliver',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code Z-Forge fault',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code AA-Rod didn''t shear',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code AB-Square unfilled',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code AC-Rear bead unfilled',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code AD-Rear bead overwork',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code AE-Cold shoulder',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code AF-Incomplete case ',1,1);
INSERT INTO CodeValue (Code_Key,Sub_Key,Name,Sort,Active) VALUES (@CodeKey,NULL,'Code AG-Change in mechanical/ impact properties',1,1);

GO

ALTER TABLE ncr2DefectList
ADD DefectDiscription int null
GO

Declare @O int
Declare @Codekey int
Set @CodeKey = NULL
SET @CodeKey = (Select ID from CodeKey where Template='ncr2'and Name = 'Mfg Defect Description')
SET @O=(Select max(O) from dbFields where T='ncr2')
 insert into dbFields (O,T,S,R,fieldName,UOM,addlUOM,dataType,decimals,fieldDisplay,exampleData,description,dbFieldName,dbDataType,dbLength,combUOMs,UOM_Category_ID
,Code_Key,Multiples_Allowed,Notes,Active,BrokenOutToSubTable,StartNewRowWhenGenHTML,ValidateAsDateTime,ValidateAs24HrTime,ValidateAsDuration,UseRadioButtonList
,UseCheckbox,AutoNumberField,HasOtherField,NumOfRows,ClearFieldWhenCopiedFromExistingRun,UniversalId,Required,dbDateTimeDisplay)
values(	@O+1,'ncr2','Defects',NULL,'Mfg Defect Description',NULL,NULL,'int',NULL,NULL,NULL,'select Mfg Defect Description','DefectDiscription','int',NULL,NULL,NULL,
@CodeKey,0,NULL,1,'ncr2DefectList',0,0,0,0,0,0,0,0,0,0,NEWID(),0,NULL)
GO


