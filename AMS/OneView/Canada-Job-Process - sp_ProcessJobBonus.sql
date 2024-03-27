-- =============================================
-- Author:		Darin Witten
-- Create date: 08/09/2013
-- Description:	Update Job Bonus Approval
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProcessJobBonus]
	
	@BonusID text,  @ManagerWFTID Char(10), @Country Char(50), @CurrencyCode Char(50)

AS
BEGIN

	DECLARE @jobBonusProcessedID AS uniqueidentifier
	DECLARE @dateProcessed AS DateTime

	SET @jobBonusProcessedID = NEWID()
	SET @dateProcessed = GETUTCDATE()
		
	INSERT INTO [dbo].[JobBonusProcessed]
           ([jobBonusProcessedID]
           ,[dateProcessed]
           ,[processedBy]
		   ,[country]
		   ,[currencyCode])
     VALUES
           (@jobBonusProcessedID
           ,@dateProcessed
           , @ManagerWFTID
		   , @Country
		   , @CurrencyCode)

	INSERT INTO JobBonusHistory (jobBonusHistoryID, jobBonusID, hrmsEmployeeID, fullname, serviceOrder, jobid, jobBonusProcessedID, processedBy, dateProcessed, actualBonusTotal, country, currencyCode)
		SELECT DISTINCT NEWID(), jb.jobBonusID, e2.hrmsEmployeeID, e2.displayname as fullname, j.serviceOrder, j.jobid, @jobBonusProcessedID AS jobBonusProcessedID, @ManagerWFTID AS processedBy, @dateProcessed AS dateProcessed, ROUND(ISNULL(jbd.nativeJDEBonusTo
tal, 0), 2) AS actualBonusTotal, @Country AS country, @CurrencyCode AS currencyCode
		FROM Employee AS e2
			RIGHT OUTER JOIN JobCrew AS JobCrew_1 ON e2.id = JobCrew_1.employeeID
			FULL OUTER JOIN JobBonus AS jb ON JobCrew_1.jobCrewID = jb.jobCrewID
			INNER JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID AND jbd.nativeJDEServiceOrderTicketTotal IS NOT NULL
			FULL OUTER JOIN Job AS j ON JobCrew_1.jobID = j.jobID
		WHERE (jb.deleted IS NULL OR jb.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND (j.deleted IS NULL OR j.deleted = 0) AND (jbd.deleted IS NULL OR jbd.deleted = 0) AND (JobCrew_1.deleted IS NULL OR JobCrew_1.deleted = 0) AND 
								(jbd.deleted IS NULL OR jbd.deleted = 0) AND (jbd.nativeJDEBonusTotal > 0)
								AND (jb.jobBonusID IN (SELECT jobBonusID FROM JobBonus WHERE jobBonusStatusID = 3))
								AND (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, e2.hrmsEmployeeID, e2.displayname, jbd.nativeJDEBonusTotal, j.scheduledStartDateTime, j.serviceOrder, j.jobid
		   	
	INSERT INTO JobBonusStatusLog (jobBonusStatusLogID, wftid, modified, jobBonusID, oldJobBonusStatusID, newJobBonusStatusID, nativeBonusTotal)
       SELECT        NEWID(), @ManagerWFTID, getutcdate(), jb.jobBonusID, jb.jobBonusStatusID, 4, SUM(jbd.nativeJDEBonusTotal) AS bonusTotal
		FROM            JobBonus AS jb LEFT OUTER JOIN JobBonusData AS jbd ON jb.jobBonusID = jbd.jobBonusID
		WHERE (jb.jobBonusID IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')))
		GROUP BY jb.jobBonusID, jb.jobBonusStatusID

	UPDATE [dbo].[JobBonus] SET [jobBonusStatusID] = 4, [jobBonusProcessedID] = @jobBonusProcessedID WHERE [jobBonusID] IN (SELECT CAST(Value AS uniqueidentifier) FROM dbo.FnSplit(@BonusID,',')) --AND [jobBonusProcessedID] IS NULL

END

