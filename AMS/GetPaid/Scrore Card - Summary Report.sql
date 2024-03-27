SELECT
                GAEXPORT.CUSTNO,
                COMPANY,
                COLLECTOR,
                GAEXPORT.INVNO,
                GAEXPORT.AMOUNT,
                ACTION,
                OPERATION,
                GAEXPORT.RECEIPT_ID,
                DEPOSIT_DATE,
                GAEXPORT.MODIFIED_ON,
				GARECEIPT.CURRCODE [Receipt Curr],
				CASE WHEN GAEXPORT.AMOUNT = AMOUNT_BASE THEN (CASE WHEN ISNULL(TRANCURR, GADEPOSIT.CURRCODE) != 'USD' 
																	THEN 'USD' ELSE ISNULL(TRANCURR, GADEPOSIT.CURRCODE) END) 
														ELSE ISNULL(TRANCURR, GADEPOSIT.CURRCODE) END [Tran Curr],
                BASE_RATE,
				CASE WHEN ACTION = 'D' THEN GAEXPORT.AMOUNT / BASE_RATE ELSE GAEXPORT.AMOUNT / BASE_RATE * - 1 	END AS [8X Report AMT],
				CASE WHEN ACTION = 'C' THEN 0 - AMOUNT_BASE ELSE AMOUNT_BASE END AS [Dashboard Amt]
FROM gpcomp1.GAEXPORT GAEXPORT
LEFT OUTER JOIN gpcomp1.GARECEIPT GARECEIPT ON GAEXPORT.RECEIPT_ID = GARECEIPT.RECEIPT_ID
LEFT OUTER JOIN gpcomp1.GABATCH GABATCH ON GARECEIPT.BATCH_ID = GABATCH.BATCH_ID
LEFT OUTER JOIN gpcomp1.GADEPOSIT GADEPOSIT ON GABATCH.DEPOSIT_ID = GADEPOSIT.DEPOSIT_ID
INNER JOIN gpglobal.GPCURNCY GPCURNCY ON GADEPOSIT.CURRCODE = GPCURNCY.CURRCODE
LEFT OUTER JOIN gpcomp1.GPCUST GPCUST ON GAEXPORT.CUSTNO = GPCUST.CUSTNO
LEFT JOIN (SELECT DISTINCT CustNo, InvNo, TRANCURR from gpcomp1.GPRECL UNION SELECT DISTINCT CustNo, InvNo, TRANCURR from gpcomp1.GPRECLLOG) A on GAEXPORT.CUSTNO = a.CUSTNO AND GAEXPORT.INVNO = a.INVNO
WHERE OPERATION = 6 AND gadeposit.deposit_date  >= CAST('7/22/21' AS DATETIME) 


select 

SUM(CASE WHEN [Receipt Curr] ='USD' AND [Tran Curr] = 'USD'  AND ABS([8x Report Amt] - [Dashboard Amt]) <= 2 THEN 1 ELSE 0 END) [USD Matching Count],
SUM(CASE WHEN [Receipt Curr] ='USD' AND [Tran Curr] = 'USD'  AND ABS([8x Report Amt] - [Dashboard Amt]) <= 2 THEN [Dashboard Amt] ELSE 0 END) [USD Matching Amount],
SUM(CASE WHEN [Receipt Curr] ='USD' AND [Tran Curr] = 'USD'  AND ABS([8x Report Amt] - [Dashboard Amt]) > 2 THEN 1 ELSE 0 END) [USD Not Matching Count],
SUM(CASE WHEN [Receipt Curr] ='USD' AND [Tran Curr] = 'USD'  AND ABS([8x Report Amt] - [Dashboard Amt]) > 2 THEN ([Dashboard Amt]) ELSE 0 END) [USD Not Matching Amount],


SUM(CASE WHEN [Receipt Curr] !='USD' AND [Tran Curr] != 'USD' AND [Receipt Curr] = [Tran Curr] AND ABS([8x Report Amt] - [Dashboard Amt]) <= 2 THEN 1 ELSE 0 END) [Non-USD Matching Count],
SUM(CASE WHEN [Receipt Curr] !='USD' AND [Tran Curr] != 'USD' AND [Receipt Curr] = [Tran Curr] AND ABS([8x Report Amt] - [Dashboard Amt]) <= 2 THEN [Dashboard Amt] ELSE 0 END) [Non-USD Matching Amount],
SUM(CASE WHEN [Receipt Curr] !='USD' AND [Tran Curr] != 'USD' AND [Receipt Curr] = [Tran Curr] AND ABS([8x Report Amt] - [Dashboard Amt]) > 2 THEN 1 ELSE 0 END) [Non-USD Not Matching Count],
SUM(CASE WHEN [Receipt Curr] !='USD' AND [Tran Curr] != 'USD' AND [Receipt Curr] = [Tran Curr] AND ABS([8x Report Amt] - [Dashboard Amt]) > 2 THEN ([Dashboard Amt]) ELSE 0 END) [Non-USD Not Matching Amount],


SUM(CASE WHEN [Receipt Curr] !='USD' AND [Tran Curr] = 'USD' AND ABS([8x Report Amt] - [Dashboard Amt]) <= 2 THEN 1 ELSE 0 END) [USD Invoices and Non USD Receipt Matching Count],
SUM(CASE WHEN [Receipt Curr] !='USD' AND [Tran Curr] = 'USD' AND ABS([8x Report Amt] - [Dashboard Amt]) <= 2 THEN [Dashboard Amt] ELSE 0 END) [USD Invoices and Non USD Receipt Matching Amount],
SUM(CASE WHEN [Receipt Curr] !='USD' AND [Tran Curr] = 'USD' AND ABS([8x Report Amt] - [Dashboard Amt]) > 2 THEN 1 ELSE 0 END) [USD Invoices and Non USD Receipt Matching Count],
SUM(CASE WHEN [Receipt Curr] !='USD' AND [Tran Curr] = 'USD' AND ABS([8x Report Amt] - [Dashboard Amt]) > 2 THEN ([Dashboard Amt]) ELSE 0 END) [USD Invoices and Non USD Receipt Not Matching Amount],

SUM(CASE WHEN [Receipt Curr] ='USD' AND [Tran Curr] != 'USD' AND ABS([8x Report Amt] - [Dashboard Amt]) <= 2 THEN 1 ELSE 0 END) [Non-USD Invoices and USD Receipt Matching Count],
SUM(CASE WHEN [Receipt Curr] ='USD' AND [Tran Curr] != 'USD' AND ABS([8x Report Amt] - [Dashboard Amt]) <= 2 THEN [Dashboard Amt] ELSE 0 END) [Non-USD Invoices and USD Receipt Matching Amount],
SUM(CASE WHEN [Receipt Curr] ='USD' AND [Tran Curr] != 'USD' AND ABS([8x Report Amt] - [Dashboard Amt]) > 2 THEN 1 ELSE 0 END) [Non-USD Invoices and USD Receipt Matching Count],
SUM(CASE WHEN [Receipt Curr] ='USD' AND [Tran Curr] != 'USD' AND ABS([8x Report Amt] - [Dashboard Amt]) > 2 THEN ([Dashboard Amt]) ELSE 0 END) [Non-USD Invoices and USD Receipt Not Matching Amount]

from 

(SELECT
                GAEXPORT.CUSTNO,
                COMPANY,
                COLLECTOR,
                GAEXPORT.INVNO,
                GAEXPORT.AMOUNT,
                ACTION,
                OPERATION,
                GAEXPORT.RECEIPT_ID,
                DEPOSIT_DATE,
                GAEXPORT.MODIFIED_ON,
				GARECEIPT.CURRCODE [Receipt Curr],
    --            GADEPOSIT.CURRCODE [Tran Curr],
				--TRANCURR,
				CASE WHEN GAEXPORT.AMOUNT = AMOUNT_BASE THEN (CASE WHEN ISNULL(TRANCURR, GADEPOSIT.CURRCODE) != 'USD' 
																	THEN 'USD' ELSE ISNULL(TRANCURR, GADEPOSIT.CURRCODE) END) 
														ELSE ISNULL(TRANCURR, GADEPOSIT.CURRCODE) END [Tran Curr],
                BASE_RATE,
				CASE WHEN ACTION = 'D' THEN GAEXPORT.AMOUNT / BASE_RATE ELSE GAEXPORT.AMOUNT / BASE_RATE * - 1 	END AS [8X Report AMT],
				CASE WHEN ACTION = 'C' THEN 0 - AMOUNT_BASE ELSE AMOUNT_BASE END AS [Dashboard Amt]
FROM gpcomp1.GAEXPORT GAEXPORT
LEFT OUTER JOIN gpcomp1.GARECEIPT GARECEIPT ON GAEXPORT.RECEIPT_ID = GARECEIPT.RECEIPT_ID
LEFT OUTER JOIN gpcomp1.GABATCH GABATCH ON GARECEIPT.BATCH_ID = GABATCH.BATCH_ID
LEFT OUTER JOIN gpcomp1.GADEPOSIT GADEPOSIT ON GABATCH.DEPOSIT_ID = GADEPOSIT.DEPOSIT_ID
INNER JOIN gpglobal.GPCURNCY GPCURNCY ON GADEPOSIT.CURRCODE = GPCURNCY.CURRCODE
LEFT OUTER JOIN gpcomp1.GPCUST GPCUST ON GAEXPORT.CUSTNO = GPCUST.CUSTNO
LEFT JOIN (SELECT DISTINCT CustNo, InvNo, TRANCURR from gpcomp1.GPRECL UNION SELECT DISTINCT CustNo, InvNo, TRANCURR from gpcomp1.GPRECLLOG) A on GAEXPORT.CUSTNO = a.CUSTNO AND GAEXPORT.INVNO = a.INVNO
WHERE OPERATION = 6 AND gadeposit.deposit_date  >= CAST('2021-08-01' AS DATETIME) 
) A