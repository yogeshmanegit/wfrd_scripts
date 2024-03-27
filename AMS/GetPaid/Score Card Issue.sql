select ex.CUSTNO [Customer #], 
		rec.RECEIPT_ID,
		rec.RECEIPT_NUM [Receipt #], 
		rec.CURRCODE [Receipt Currency],
		rec.AMOUNT [Receipt_Amount],
		rec.REMIT_COUNT,
		
		ex.ACTION,
		ex.AMOUNT_BASE [Receipt AMT Base],
		ex.AMOUNT,

		inv.INVNO [Invoice #],
		CONVERT(CHAR(10), inv.INVDATE, 101) [Invoice Date],
		inv.TRANCURR [Invoice Currency],
		inv.AMOUNT [Invoice Amount],

		ex.MODIFIED_ON
from gpcomp1.GARECEIPT rec
join gpcomp1.GAEXPORT ex on rec.RECEIPT_ID = ex.RECEIPT_ID and ex.ACTION = 'C' -- Credit
join gpcomp1.GPRECL inv on ex.INVNO = inv.INVNO and ex.CUSTNO = inv.CUSTNO 
where ex.AMOUNT != ex.AMOUNT_BASE


select * from gpcomp1.GARECEIPT r where r.RECEIPT_ID ='13174056'
select * from gpcomp1.GAEXPORT where RECEIPT_ID ='13174056' and INVNO='291628'
select AMOUNT, BALANCE, INVAMT, TRANBAL, TRANORIG, TRANCURR from gpcomp1.GPRECL where CUSTNO='4303613' and INVNO IN ('291628', '19090574', '19090571')
select AMOUNT, BALANCE, INVAMT, TRANBAL, TRANORIG, TRANCURR from gpcomp1.GPRECLLOG where CUSTNO='4303613' and INVNO IN ('291628', '19090574', '19090571')