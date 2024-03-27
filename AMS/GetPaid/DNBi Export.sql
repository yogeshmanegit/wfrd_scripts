SELECT 
              CUST.CUSTNO [Account Number],
              CUST.COMPANY [Business Name],
              REPLACE(ISNULL(COND.ADDRESS1,''),',','.') as ADDRESS1, 
			  REPLACE(ISNULL(COND.ADDRESS2,''),',','.') as ADDRESS2, 
              REPLACE(ISNULL(COND.ADDRESS3,''),',','.') as ADDRESS3,
              ISNULL(COND.CITY,'') as CITY,
              ISNULL(COND.STATE,'') as STATE,
              ISNULL(COND.ZIP,'') as [Zip/Postal Code],
              ISNULL(COND.COUNTRY,'') as [Country],
              ISNULL(COND.PHONE,'') [Company phone],
              ISNULL(COND.FAX,'') [Company FAX],
              ISNULL([Current],0) [Current],
              ISNULL([1-15 days past due],0) [1-15 days past due],
              ISNULL([16-30 days past due],0) [16-30 days past due],
              ISNULL([31-45 days past due],0) [31-45 days past due],
              ISNULL([46-60 days past due],0) [46-60 days past due],
              ISNULL([61-90 days past due],0) [61-90 days past due],
              ISNULL([91-120 days past due],0) [91-120 days past due],
              ISNULL([121-150 days past due],0) [121-150 days past due],
              ISNULL([151-365 days past due],0) [151-365 days past due],
              ISNULL([366+ days past due],0) [366+ days past due],
              ISNULL([Total Past Due],0) [Total Past Due],
              ISNULL([Total Oustanding],0) [Total Oustanding]
--                     ,CRD_LIMIT
FROM gpcomp1.GPCUST CUST WITH(NOLOCK)
LEFT OUTER JOIN
(SELECT  PARENT CUSTNO,
              SUM(CASE WHEN DAYS_DELINQUENT <= 0 THEN AMOUNT ELSE 0 END) AS [Current],
        SUM(CASE WHEN DAYS_DELINQUENT BETWEEN 1 AND 15  THEN AMOUNT ELSE 0 END) AS [1-15 days past due],
        SUM(CASE WHEN DAYS_DELINQUENT BETWEEN 16 AND 30  THEN AMOUNT ELSE 0 END) AS [16-30 days past due],
              SUM(CASE WHEN DAYS_DELINQUENT BETWEEN 31 AND 45  THEN AMOUNT ELSE 0 END) AS [31-45 days past due],
        SUM(CASE WHEN DAYS_DELINQUENT BETWEEN 46 AND 60  THEN AMOUNT ELSE 0 END) AS [46-60 days past due],
              SUM(CASE WHEN DAYS_DELINQUENT BETWEEN 61 AND 90  THEN AMOUNT ELSE 0 END) AS [61-90 days past due],
        SUM(CASE WHEN DAYS_DELINQUENT BETWEEN 91 AND 120  THEN AMOUNT ELSE 0 END) AS [91-120 days past due],
              SUM(CASE WHEN DAYS_DELINQUENT BETWEEN 121 AND 150  THEN AMOUNT ELSE 0 END) AS [121-150 days past due],
        SUM(CASE WHEN DAYS_DELINQUENT BETWEEN 151 AND 365  THEN AMOUNT ELSE 0 END) AS [151-365 days past due],
              SUM(CASE WHEN DAYS_DELINQUENT > 365  THEN AMOUNT ELSE 0 END) AS [366+ days past due],
              SUM(CASE WHEN DAYS_DELINQUENT >= 0 THEN AMOUNT ELSE 0 END) [Total Past Due],
              SUM(AMOUNT) [Total Oustanding]
FROM   gpcomp1.TRANSACTIONAGING CUST_AGING WITH(NOLOCK)
GROUP BY CUST_AGING.PARENT

) CUST_AGING
ON CUST.CUSTNO = CUST_AGING.CUSTNO
LEFT join gpcomp1.CUSTOMERCONTACTS COND ON CUST.CONTACT_ID = COND.CONTACT_ID
WHERE 1=1
AND INACTIVE='N'
and Cust.CUSTNO = cust.PARENT

-- Remove dormant customers as per below meaning
--(keep customers if they have transactions or they have credit limit more than $1)
AND (CUST_AGING.CUSTNO IS NOT NULL OR CUST.CRD_LIMIT > 1)

-- Remove WFL - STRATUM team & it's portfolio
AND cust.CUSTNO NOT IN (
                                         select cust.PARENT
                                         from gpcomp1.GPCOLTM team (NOLOCK)
                                         join gpcomp1.GPCOLL portfolio (NOLOCK) ON team.Team = portfolio.team
                                         join gpcomp1.GPCUST cust (NOLOCK) on portfolio.COLLCODE = cust.COLLECTOR
                                         where team.TEAM = 'WFL' AND team.DESCRIPTION = 'STRATUM' and cust.INACTIVE ='N'
                                  )
ORDER BY (CASE WHEN CUST.businessunit_orig = 'JDE' THEN 1 
	WHEN CUST.businessunit_orig ='SAP' THEN 2 WHEN CUST.businessunit_orig ='PARUS' THEN 9 ELSE 3 END), [Business Name]