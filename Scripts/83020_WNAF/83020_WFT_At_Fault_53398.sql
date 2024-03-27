
declare @PId int 
declare @CId int


select @PId=PId from pageTable where PageName = 'IncidentTracking/templates/Resolution/rev1.aspx'

insert into ControlTable
select @PId,'lblWFTNotAtFault.Text'

insert into ControlTable
select @PId,'lblWFTNotAtFault.ToolTip'

select @CId=CId from ControlTable where ControlName = 'lblWFTNotAtFault.Text' and PId=@PId

--select top 2 * from translationtable where PId=@PId and CId=@Cid

insert into translationtable 
select @PId,@CId,'en', N'Was Weatherford at Fault?',null,null,null,null

insert into translationtable 
select @PId,@CId,'ru', N'Виновата ли компания Weatherford?',null,null,null,null

insert into translationtable 
select @PId,@CId,'fr', N'Weatherford était-il en défaut?',null,null,null,null

insert into translationtable 
select @PId,@CId,'es', N'¿Fue Weatherford quien tuvo la culpa',null,null,null,null

insert into translationtable 
select @PId,@CId,'pt', N'Weatherford estava em falta?',null,null,null,null

select @CId=CId from ControlTable where ControlName = 'lblWFTNotAtFault.ToolTip' and PId=@PId

insert into translationtable 
select @PId,@CId,'en', N'Was Weatherford at Fault?',null,null,null,null

insert into translationtable 
select @PId,@CId,'ru', N'Виновата ли компания Weatherford?',null,null,null,null

insert into translationtable 
select @PId,@CId,'fr', N'Weatherford était-il en défaut?',null,null,null,null

insert into translationtable 
select @PId,@CId,'es', N'¿Fue Weatherford quien tuvo la culpa',null,null,null,null

insert into translationtable 
select @PId,@CId,'pt', N'Weatherford estava em falta?',null,null,null,null
