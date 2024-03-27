select i.customer, i.[Receipt Number], i.[Invoice Number] , i.[Payment Amount]
from 
(
	select [Receipt Number], 
			ISNULL(a.MAIN_NO, LTRIM(RTRIM(STR(Customer, 100, 0)))) [parent customer],
			LTRIM(RTRIM(STR(Customer, 100, 0))) customer, 
			LTRIM(RTRIM(STR([Invoice Number] , 100, 0))) [Invoice Number],
			SUM(j.[Payment Amount])[Payment Amount]
	from jdedata j
	LEFT JOIN ARConsolidator a on LTRIM(RTRIM(STR(j.Customer, 100, 0))) = a.AFFILIATE_NO
	where [Invoice Number] > 0
	group by [Receipt Number], 
			ISNULL(a.MAIN_NO, LTRIM(RTRIM(STR(Customer, 100, 0)))),
			LTRIM(RTRIM(STR(Customer, 100, 0))), 
			LTRIM(RTRIM(STR([Invoice Number] , 100, 0)))
) i
left join (
			select CustNo, 
					(CASE WHEN CHARINDEX('-', INVNO) > 0 THEN SUBSTRING(INVNO, 0, CHARINDEX('-', INVNO)) ELSE INVNO END) [INVNO] 
			FROM GetPaidInvoices
) g 
	on  (i.[parent customer] = g.CUSTNO or i.Customer = g.CUSTNO) and i.[Invoice Number] = g.INVNO
where g.CUSTNO is null



select distinct [Receipt Number], 
			ISNULL(a.MAIN_NO, LTRIM(RTRIM(STR(Customer, 100, 0)))) [parent customer],
			LTRIM(RTRIM(STR(Customer, 100, 0))) customer, 
			LTRIM(RTRIM(STR([Invoice Number] , 100, 0))) [Invoice Number] 
	from jdedata j
	LEFT JOIN ARConsolidator a on LTRIM(RTRIM(STR(j.Customer, 100, 0))) = a.AFFILIATE_NO
	where [Invoice Number] > 0 and j.Customer = 2944679 and [Invoice Number] = '96139'

select CustNo, 
	(CASE WHEN CHARINDEX('-', INVNO) > 0 THEN SUBSTRING(INVNO, 0, CHARINDEX('-', INVNO)) ELSE INVNO END) [INVNO] 
FROM GetPaidInvoices
WHERE CUSTNO ='2944679' and INVNO like '%96139%'