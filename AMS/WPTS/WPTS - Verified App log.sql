select * from 
(	select UploadXML.value('(/NewDataSet/Table1[field/text()="UserName"]/value/text())[1]','varchar(max)') [UserName], 
		   UploadDate
from Upload_Log_Verification ) v
--join userAuth a on v.UserName = a.username
order by UploadDate 