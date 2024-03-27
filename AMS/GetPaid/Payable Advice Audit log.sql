select top 10 * 
from [gpcomp1].[GPPAYABLE_UPLOAD] u (NOLOCK)
where u.custno = '3477034' order by u.created_on desc

select * from [gpcomp1].[GPPAYABLE_UPLOAD_DETAIL] (NOLOCK) where UPLOAD_ID = 190747 and INVNO = '19047455'

select @@SERVERNAME