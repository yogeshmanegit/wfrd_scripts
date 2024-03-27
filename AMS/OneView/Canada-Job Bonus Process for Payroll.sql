DECLARE @LastInvoiceUTC nvarchar(20),@Country nvarchar(3)
SET @LastInvoiceUTC = N'6/22/2020 5:00:00 PM' 
SET @Country = N'CAN'


SELECT DISTINCT 
                                                    e2.hrmsEmployeeID, e2.displayname AS EmployeeName, jbd.nativeJDEServiceOrderTicketTotal, j.scheduledStartDateTime, jbd.nativeBonusTotal, 
                                                    ROUND(jbd.nativeJDEBonusTotal, 2) AS nativeJDEBonusTotal, j.serviceOrder, jb.jobBonusID
                          FROM            FECellRole AS fecr INNER JOIN
                                                    Employee AS e2 INNER JOIN
                                                    Job AS j INNER JOIN
                                                    JobCrew AS JobCrew_1 ON j.jobID = JobCrew_1.jobID ON e2.id = JobCrew_1.employeeID INNER JOIN
                                                    JobBonus AS jb INNER JOIN
                                                    JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID AND jbd.nativeJDEServiceOrderTicketTotal IS NOT NULL ON 
                                                    JobCrew_1.jobCrewID = jb.jobCrewID ON fecr.feCellRoleID = JobCrew_1.feCellRoleID INNER JOIN
                                                    JobCrew AS jc2 ON j.jobID = jc2.jobID INNER JOIN
                                                    EconnectEmployeeData ON e2.hrmsEmployeeID = EconnectEmployeeData.emplid
                          WHERE        (j.invoiceDateTime <= @LastInvoiceUTC) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND 
                                                    (j.deleted IS NULL) AND (jc2.employeeID IN (2336,1709,2279,2692,2506,2555,1628,1685,1817,1703,2536,6283)) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND 
                                                    (EconnectEmployeeData.w_country = @Country) AND (JobCrew_1.feCellRoleID = 9) OR
                                                    (j.invoiceDateTime <= @LastInvoiceUTC) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND 
                                                    (j.deleted IS NULL) AND (jc2.employeeID IN (2336,1709,2279,2692,2506,2555,1628,1685,1817,1703,2536,6283)) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND 
                                                    (EconnectEmployeeData.w_country = @Country) AND (fecr.feCellRoleTypeID = 5)


AND e2.displayname = 'Thibodeau, Daniel'


SELECT        hrmsEmployeeID, EmployeeName, ROUND(SUM(nativeJDEBonusTotal), 2) AS BonusTotal
FROM            (SELECT DISTINCT 
                                                    e2.hrmsEmployeeID, e2.displayname AS EmployeeName, jbd.nativeJDEServiceOrderTicketTotal, j.scheduledStartDateTime, jbd.nativeBonusTotal, 
                                                    ROUND(jbd.nativeJDEBonusTotal, 2) AS nativeJDEBonusTotal, j.serviceOrder, jb.jobBonusID
                          FROM            FECellRole AS fecr INNER JOIN
                                                    Employee AS e2 INNER JOIN
                                                    Job AS j INNER JOIN
                                                    JobCrew AS JobCrew_1 ON j.jobID = JobCrew_1.jobID ON e2.id = JobCrew_1.employeeID INNER JOIN
                                                    JobBonus AS jb INNER JOIN
                                                    JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID AND jbd.nativeJDEServiceOrderTicketTotal IS NOT NULL ON 
                                                    JobCrew_1.jobCrewID = jb.jobCrewID ON fecr.feCellRoleID = JobCrew_1.feCellRoleID INNER JOIN
                                                    JobCrew AS jc2 ON j.jobID = jc2.jobID INNER JOIN
                                                    EconnectEmployeeData ON e2.hrmsEmployeeID = EconnectEmployeeData.emplid
                          WHERE        (j.invoiceDateTime <= @LastInvoiceUTC) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND 
                                                    (j.deleted IS NULL) AND (jc2.employeeID IN (2336,1709,2279,2692,2506,2555,1628,1685,1817,1703,2536,6283)) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND 
                                                    (EconnectEmployeeData.w_country = @Country) AND (JobCrew_1.feCellRoleID = 9) OR
                                                    (j.invoiceDateTime <= @LastInvoiceUTC) AND (jb.deleted IS NULL) AND (jb.jobBonusStatusID = 3) AND (JobCrew_1.deleted IS NULL) AND 
                                                    (j.deleted IS NULL) AND (jc2.employeeID IN (2336,1709,2279,2692,2506,2555,1628,1685,1817,1703,2536,6283)) AND (jc2.feCellRoleID = 11) AND (jc2.deleted IS NULL) AND 
                                                    (EconnectEmployeeData.w_country = @Country) AND (fecr.feCellRoleTypeID = 5)) AS SubTable
WHERE        (nativeJDEBonusTotal > 0)
GROUP BY EmployeeName, hrmsEmployeeID

