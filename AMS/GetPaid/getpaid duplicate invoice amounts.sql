SELECT * FROM 
(
select ROW_NUMBER() OVER (PARTITION BY e.custno, receipt_id, invno, action, export_timestamp, OPERATION, amount
							--ORDER BY e.custno, receipt_id, invno, action, export_timestamp, OPERATION, amount ASC
							ORDER BY e.export_timestamp
							) [Row_Num],
e.EXPORT_ID,
cust.COLLECTOR as COLLECTOR, 
coll.COLLNAME as PORTFOLIO_NAME, 
team.DESCRIPTION as TEAM_NAME, 
team.TEAM as TEAM_CODE,
e.custno, 
receipt_id, 
invno, 
action, 
export_timestamp, 
OPERATION, 
amount * (CASE WHEN action ='C' then 1 else - 1 END) [amount],
amount_base * (CASE WHEN action ='C' then 1 else - 1 END) [amount_base]
from gpcomp1.GAEXPORT (NOLOCK) e
left join gpcomp1.GPCUST (nolock) cust on e.CUSTNO = cust.CUSTNO
left join gpcomp1.GPCOLL (NOLOCK) coll on cust.COLLECTOR = coll.COLLCODE
left outer join gpcomp1.GPCOLTM team on team.TEAM = coll.TEAM
where OPERATION = 6 AND EXPORT_TIMESTAMP >='2021-03-01' and AMOUNT != 0
) A
where Row_Num > 1
ORDER BY export_timestamp