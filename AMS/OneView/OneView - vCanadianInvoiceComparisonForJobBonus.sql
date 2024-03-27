DECLARE @jobId uniqueidentifier 

select jc.*, jb.*
FROM            dbo.CADWirelineInvoiced AS cwi INNER JOIN
                         dbo.Job ON LTRIM(RTRIM(CAST(cwi.[Order Number] AS nvarchar(15)))) = LTRIM(RTRIM(dbo.Job.financialSystemID)) INNER JOIN
                         dbo.JobCrew AS jc ON dbo.Job.jobID = jc.jobID INNER JOIN
                         dbo.JobBonus AS jb ON jc.jobCrewID = jb.jobCrewID AND jb.jobBonusStatusID = 3 AND ISNULL(jb.deleted,0) = 0 
where job.jobID = @jobId

SELECT
   dbo.Job.jobID,
   dbo.Job.serviceOrder,
   dbo.Job.jobStatusID,
   cwi.[Business Unit],
   cwi.[Business Unit Name],
   cwi.[Invoice Number],
   cwi.[Inv Ty],
   cwi.[Order Number],
   cwi.[Or Ty],
   cwi.[Inv Seq],
   cwi.[Inv Date],
   cwi.[Billed From],
   cwi.[Billed To],
   cwi.[Sold To Number],
   cwi.Description,
   cwi.[Ship To Number],
   cwi.Description1,
   cwi.[Address Line 1],
   cwi.[Address Line 2],
   cwi.[Address Line 3],
   cwi.[Address Line 4],
   cwi.[IV Gross Amount],
   cwi.[IV Discount Amount],
   cwi.[IV Surcharge Amount],
   cwi.[IV Tax Amount],
   cwi.[IV Net Amount],
   cwi.[Cur Cod],
   cwi.[Prepared By],
   cwi.[Credit Reason Code],
   cwi.[Reason Code Description],
   cwi.[Salesprsn Code],
   cwi.[Date Inv Seq Started],
   cwi.[Job Type],
   cwi.[Contract Acct No],
   cwi.[Foreign Amount],
   cwi.F33,
   cwi.F34,
   cwi.[Contract Number],
   cwi.[IV Gross Amount] - (
   CASE WHEN cwi.[IV Discount Amount] IS NULL THEN 0 ELSE cwi.[IV Discount Amount] END) AS DiscountedGross, 
   cwi.[IV Net Amount] - (CASE WHEN cwi.[IV Tax Amount] IS NULL THEN 0 ELSE cwi.[IV Tax Amount] END) AS NoTaxNet, 
   jobtotals.AdjustedTotalFromOneView, 
   ROUND(jobtotals.AdjustedTotalFromOneView - (cwi.[IV Gross Amount] - (
   CASE WHEN cwi.[IV Discount Amount] IS NULL THEN 0 ELSE cwi.[IV Discount Amount] END)), 2) AS [Difference from OneView], 
   jobtotals.jobchargecount, jobtotals.jobchargeadjustedtotalcount,
   jobtotals.AdjustedTotalFromOneView, cwi.[IV Gross Amount], cwi.[IV Discount Amount], cwi.[IV Discount Amount],
   jc.jobCrewID
FROM
   dbo.CADWirelineInvoiced AS cwi 
   INNER JOIN dbo.Job ON LTRIM(RTRIM(CAST(cwi.[Order Number] AS nvarchar(15)))) = LTRIM(RTRIM(dbo.Job.financialSystemID)) 
   INNER JOIN dbo.JobCrew AS jc ON dbo.Job.jobID = jc.jobID 
   INNER JOIN dbo.JobBonus AS jb ON jc.jobCrewID = jb.jobCrewID 
      AND jb.jobBonusStatusID = 3 AND jb.deleted IS NULL 
   LEFT OUTER JOIN
      (
         SELECT
            jobID,
            SUM(CASE WHEN jc.adjustedNativeTotal IS NULL THEN 0 ELSE jc.adjustedNativeTotal END) AS AdjustedTotalFromOneView, 
			COUNT(jobChargeID) AS jobchargecount, 
			SUM(CASE WHEN jc.adjustedNativeTotal IS NULL THEN 0 ELSE 1 END) AS jobchargeadjustedtotalcount 
         FROM
            dbo.JobCharges AS jc 
		WHERE (deleted IS NULL) OR (deleted = 0)
         GROUP BY jobID
      )
      AS jobtotals ON dbo.Job.jobID = jobtotals.jobID 
WHERE dbo.Job.jobID = 'C66B6FA5-2E33-4E10-A02B-4B47364B369F'
ORDER BY
cwi.[Order Number], cwi.[Inv Seq], cwi.[Inv Date]


SELECT
            jobID,
            SUM(CASE WHEN jc.adjustedNativeTotal IS NULL THEN 0 ELSE jc.adjustedNativeTotal END) AS AdjustedTotalFromOneView, 
			COUNT(jobChargeID) AS jobchargecount, 
			SUM(CASE WHEN jc.adjustedNativeTotal IS NULL THEN 0 ELSE 1 END) AS jobchargeadjustedtotalcount 
         FROM
            dbo.JobCharges AS jc 
		WHERE ((deleted IS NULL) OR (deleted = 0)) AND jobID = 'C66B6FA5-2E33-4E10-A02B-4B47364B369F'
         GROUP BY jobID

