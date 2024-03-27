
--script to take a backup of table before update the data
select * into GPRECL_20220801 from gpcomp1.GPRECL i

--script to fix the data
UPDATE i
SET i.RCOMMENTS = l.rcomments
from gpcomp1.GPRECL i
join (select * from (select ROW_NUMBER() OVER(partition by custno, invno order by custno, invno, modified_on desc) [RowNum],
* from gpcomp1.GPRECLLOG where CREATED_ON >='2022-07-28') A where RowNum = 1) l on i.CUSTNO = l.CUSTNO and i.INVNO = l.INVNO
where i.CREATED_ON >='2022-07-28' and LTRIM(RTRIM(l.RCOMMENTS)) != '' and LTRIM(RTRIM(ISNULL(i.RCOMMENTS,''))) = ''


UPDATE i
SET i.FLEXFIELD15 = CASE WHEN LTRIM(RTRIM(ISNULL(i.FLEXFIELD15,''))) != '' THEN i.FLEXFIELD15 ELSE l.FLEXFIELD15 END,
i.PROMISED = CASE WHEN i.FLEXFIELD15 IS NOT NULL THEN i.PROMISED ELSE l.PROMISED END
from gpcomp1.GPRECL i
join (select * from (select ROW_NUMBER() OVER(partition by custno, invno order by custno, invno, modified_on desc) [RowNum],
* from gpcomp1.GPRECLLOG where CREATED_ON >='2022-07-28') A where RowNum = 1) l on i.CUSTNO = l.CUSTNO and i.INVNO = l.INVNO
where i.CREATED_ON >='2022-07-28' 