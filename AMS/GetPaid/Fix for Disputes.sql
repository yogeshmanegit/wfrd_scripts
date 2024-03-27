
--back up script

select b.*
into  dbo.GPPROB_20220801
from 
(
	SELECT * FROM 
	(
		select ROW_NUMBER() OVER(PARTITION BY CUSTNO, INVNO ORDER BY CUSTNO, INVNO, MODIFIED_ON DESC) [RowNum],
		* 
		from GPCOMP1.GPRECLLOG 
		where CREATED_ON >='2022-07-28'
	) A where RowNum = 1
) p 
join gpcomp1.gprecl r on r.CUSTNO = p.CUSTNO and r.INVNO = p.INVNO
JOIN gpcomp1.GPPROB b ON p.LOG_ID = b.CLOSED_INVOICE_TRAN_ID
where p.CREATED_ON >='2022-07-28'

-- Update screen

UPDATE b 
SET OPEN_INVOICE_TRAN_ID = r.TRAN_ID, CLOSED_INVOICE_TRAN_ID = NULL, Status ='D', CLOSEDATE = NULL
from 
(
	SELECT * FROM 
	(
		select ROW_NUMBER() OVER(PARTITION BY CUSTNO, INVNO ORDER BY CUSTNO, INVNO, MODIFIED_ON DESC) [RowNum],
		* 
		from GPCOMP1.GPRECLLOG 
		where CREATED_ON >='2022-07-28'
	) A where RowNum = 1
) p 
join gpcomp1.gprecl r on r.CUSTNO = p.CUSTNO and r.INVNO = p.INVNO
JOIN gpcomp1.GPPROB b ON p.LOG_ID = b.CLOSED_INVOICE_TRAN_ID
where p.CREATED_ON >='2022-07-28'