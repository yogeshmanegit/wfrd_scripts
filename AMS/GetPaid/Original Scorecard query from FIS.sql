
SELECT SUM(e.AMOUNT_BASE) AS BASE_AMT --, CAST( E.MODIFIED_ON as DATE) AS MODIFIED_DATE  
FROM   (SELECT CASE WHEN ACTION = 'C' THEN 0 - AMOUNT_BASE ELSE AMOUNT_BASE END AS AMOUNT_BASE,  RECEIPT_ID, CUSTNO, INVNO, MODIFIED_ON,  
CASE WHEN ACTION = 'C' THEN 0 - AMOUNT ELSE AMOUNT END AS AMOUNT  
FROM GPCOMP1.GAEXPORT WHERE (OPERATION = 6))  as  e  
INNER JOIN GPCOMP1.GARECEIPT as  r ON r.RECEIPT_ID = e.RECEIPT_ID  
INNER JOIN GPCOMP1.GPCUST as  cust ON e.CUSTNO = cust.CUSTNO  
CROSS JOIN GPGLOBAL.GPSYST  as  s  
LEFT OUTER JOIN GPGLOBAL.GPCURNCY  as  c ON c.CURRCODE = r.CURRCODE 
AND c.CLIENT_ID = 1  
WHERE (s.SYST_ID = 1 ) 
AND r.RECEIPT_DATE >= '2022-01-01' AND r.RECEIPT_DATE <= '2022-01-31'
AND E.MODIFIED_ON >= '2022-01-01' AND E.MODIFIED_ON <= '2022-01-31'
--AND  ( cust.collector IN (SELECT COLLCODE FROM GPCOMP1.GPCOLL WHERE 
--(TEAM IN ('CAN', 'USA_AGENCY', 'USA', 'USA_LEGAL'))) ) 
--group by E.MODIFIED_ON 
--ORDER BY E.MODIFIED_ON ASC  
