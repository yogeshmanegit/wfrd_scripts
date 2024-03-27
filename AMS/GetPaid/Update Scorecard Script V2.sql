set Quoted_identifier on

UPDATE e
SET Amount_base = CONVERT(numeric(18,2), ROUND(e.AMOUNT / BASE_RATE ,2))
FROM gpcomp1.GAEXPORT e
INNER JOIN gpcomp1.GARECEIPT (NOLOCK) as r ON r.RECEIPT_ID = e.RECEIPT_ID
INNER JOIN gpcomp1.GPCUST (NOLOCK) as cust ON e.CUSTNO = cust.CUSTNO
CROSS JOIN GPGLOBAL.GPSYST (NOLOCK) as s
LEFT OUTER JOIN GPGLOBAL.GPCURNCY (NOLOCK) as c ON c.CURRCODE = r.CURRCODE AND c.CLIENT_ID = 1
WHERE e.operation = 6 
and e.AMOUNT_BASE = e.AMOUNT AND BASE_RATE != 1 -- skip usd records
AND e.CREATED_ON >= DATEADD(d, -5, getdate()) -- update only last 5 days records
AND e.AMOUNT > 0 -- skip zero dollar amounts