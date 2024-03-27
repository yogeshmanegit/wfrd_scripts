--Supervisor/ Day of week/ Shift/ Work Center/ Material Spec/ Material Size/ Type Connection/ Supplement Info

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblSupervisor.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblSupervisor.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Supervisor',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Supervisorin',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Supervisora',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Superviseuse',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Supervisora',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Руководитель',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblSupervisor.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblSupervisor.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Select Supervisor',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Supervisor auswählen',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Seleccionar Supervisora',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Sélectionnez le superviseur',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Selecione Supervisor',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Выберите супервизора',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblDayofweek.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblDayofweek.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Day of week',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Wochentag',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Día de la semana',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Jour de la semaine',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Dia da semana',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','День недели',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblDayofweek.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblDayofweek.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Select Day of week',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Wählen Sie den Wochentag',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Seleccione el día de la semana',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Sélectionnez le jour de la semaine',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Selecione o dia da semana',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Выберите день недели',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblShift.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblShift.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Shift',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Verschiebung',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Cambiar',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Changement',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Mudança',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Сдвиг',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblShift.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblShift.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Select Shift',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Verschiebung',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Cambiar',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Changement',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Mudança',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Сдвиг',GETDATE())

GO


declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblWorkCenter.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblWorkCenter.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Work Center',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Arbeitszentrum',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Centro de trabajo',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Centre de travail',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Centro de Trabalho',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Рабочий центр',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblWorkCenter.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblWorkCenter.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Enter Work Center',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Arbeitsplatz eingeben',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Entrar en el centro de trabajo',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Entrer dans le poste de travail',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Entrar no Centro de Trabalho',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Войти в рабочий центр',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblMaterialSpec.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblMaterialSpec.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Material Spec',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Materialspezifikation',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Especificaciones del material',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Spécifications matérielles',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Especificação de Material',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Материал Спец.',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblMaterialSpec.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblMaterialSpec.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Enter Material Spec',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Materialspezifikation eingeben',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Ingrese la especificación del material',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Entrer les spécifications du matériau',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Insira as especificações do material',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Введите спецификацию материала',GETDATE())

GO


declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblMaterialSize.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblMaterialSize.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Material Size',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Materialgröße',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Tamaño del material',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Taille du matériau',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Tamanho do Material',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Размер материала',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblMaterialSize.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblMaterialSize.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Enter Material Size',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Materialgröße eingeben',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Ingrese el tamaño del material',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Entrer la taille du matériau',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Insira o tamanho do material',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Введите размер материала',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblTypeConnection.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblTypeConnection.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Type Connection',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Typ Verbindung',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Tipo de conexión',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Type de connexion',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Tipo de conexão',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Тип подключения',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblTypeConnection.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblTypeConnection.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Enter Type Connection',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Typ Verbindung eingeben',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Ingrese el tipo de conexión',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Entrez le type de connexion',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Digite o tipo de conexão',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Введите тип подключения',GETDATE())

GO


declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblSupplementInfo.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblSupplementInfo.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Supplement Info',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Ergänzungsinfo',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Información del suplemento',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Informations sur le supplément',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Suplemento Informação',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Дополнительная информация',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblSupplementInfo.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblSupplementInfo.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Select Supplement Info',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Ergänzungsinfo auswählen',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Seleccionar información complementaria',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Sélectionnez les informations sur le supplément',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Selecione as informações do suplemento',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Выберите дополнительную информацию',GETDATE())

GO



declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblClient.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblClient.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Lookup Customer',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Kunden suchen',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Cliente de búsqueda',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Rechercher un client',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Consultar Cliente',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Поиск клиента',GETDATE())

GO


declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr1%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblClient.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblClient.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Select Customer',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Kunde auswählen',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Seleccionar cliente',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Sélectionnez le client',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Selecione o cliente',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Выберите клиента',GETDATE())

GO

--Defect code discription

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr2%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblDefectDiscription.Text')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblDefectDiscription.Text'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Defect Discription',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Falsche Beschreibung',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Descripción del defecto',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Description du défaut',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Descrição do Defeito',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Описание дефекта',GETDATE())

GO

declare @pid as int
declare @cid as int
select @pid=pid from pageTable where PageName like '%ncr2%'
 
 insert into ControlTable (pid,ControlName) values(@pid,'lblDefectDiscription.ToolTip')
 select @cid=cid,@pid=pid from ControlTable where ControlName ='lblDefectDiscription.ToolTip'
 
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'en','Select defect discription',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'de-DE','Falsche Beschreibung',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'es','Seleccione la descripción del defecto',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'fr','Sélectionnez la description du défaut',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'pt','Selecione a descrição do defeito',GETDATE())
 insert into translationtable (pid,cid,CultureCode,TranslationValue,TranslationCreationDate) values(@pid,@cid,'ru','Выберите описание дефекта',GETDATE())

GO