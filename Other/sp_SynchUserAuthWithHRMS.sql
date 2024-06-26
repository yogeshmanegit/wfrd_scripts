/****** Object:  StoredProcedure [dbo].[sp_SynchUserAuthWithHRMS]    Script Date: 2/28/2019 9:00:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_SynchUserAuthWithHRMS]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare
	@userNameAuth varchar(50),
	@username varchar(50),
	@firstname varchar(50),
	@lastname varchar(50),
	@EmailId varchar(200),
	@title nvarchar(50),
	@supervisorid int,
	@isOverridden int=null,
	@userid int,
	@IsActive int=null,
	@EMPID nvarchar(50),
	@PhysicalLocation nvarchar(50),
	@CURSOR_username CURSOR;

	SET @CURSOR_username = CURSOR FOR
	SELECT OPRID FROM HRMSStagingUsers (NOLOCK);

	-- Insert statements for procedure here
	BEGIN TRY
	Insert into UserAuth
			(
			username,
			roleID,
			ITSRoleID,
			lastname,
			firstname,
			EmailAddress,
			SupervisorID,
			--calcFirstLastName,
			--calcLastFirstName,
			Active,
			Title,
			EmployeeID,
			Physicallocation
			)
	Select u1.OPRID,
			1 roleID,
			11 ITSRoleID,
			Left(LTRIM(u1.LAST_NAME),1)+Right(LOWER(u1.LAST_NAME), len(u1.LAST_NAME)-1),
			Left(LTRIM(u1.First_NAME),1)+Right(LOWER(u1.First_NAME), len(u1.First_NAME)-1),
			u1.EMAILID, 
			ua.id,
			--u1.First_NAME+', '+u1.LAST_NAME,
			--u1.LAST_NAME+', '+u1.First_NAME,
			1 Active,
			u1.position_title,
			u1.EMPID,
			u1.LOCATION
			 from HRMSStagingUsers (NOLOCK) u1
			left join HRMSStagingUsers(NOLOCK) u2
			on  u1.REPORT_EMPLID=u2.EMPID
			left join userauth (NOLOCK)ua
			on u1.OPRID = ua.username 
			where u1.OPRID in(
							Select OPRID
							from HRMSStagingUsers (NOLOCK)
			--where u1.OPRID=@username;
							EXCEPT
							Select username OPRID from userauth (NOLOCK)
							)
	END TRY
	BEGIN CATCH
	PRINT 'In UserAuth catch block.';  
    THROW;  
	END CATCH
	
			 --where ua.Active=1
	---	Insert in to PLAUTH
	BEGIN TRY
	insert into plAuth
			(
			plID,
			userID,
			Level1ID,
			--Level1Code,
			Level2ID,
			Level2Code
			)
			(select	distinct pl.ID,
			uauth.ID userid,
			ol2.Level1ID,
			--ol2.MDMLevel1Code,
			ol2.Level2ID,
			ol2.MDMLevel2Code
			from userauth(NOLOCK) uauth
			left join HRMSStagingUsers(NOLOCK) hr on uauth.username = hr.OPRID
			left join OrgDataLevel2(NOLOCK) ol2 on hr.W_SEG_DESCR = ol2.Level2Name
			left join BusinessUnits(NOLOCK) bu on bu.MDMLevel2Code = ol2.MDMLevel2Code
			left join productLines(NOLOCK) pl on pl.BusinessUnitID = bu.BusinessUnitID
			except
			select
			plid,
			userid,
			Level1ID,
			--MDMLevel1Code,
			Level2ID,
			Level2Code MDMLevel2Code From PlAuth(NOLOCK))

			update plauth --set Level1ID=ol2.Level1ID,
			set MDMLevel1Code=ol2.MDMLevel1Code
			From plauth(NOLOCK)
			join OrgDataLevel2(NOLOCK) ol2
			on ol2.Level2ID=plAuth.Level2ID
			END TRY

		BEGIN CATCH
		PRINT 'In PLAuth catch block.';  
		THROW; 
		END CATCH
	OPEN @CURSOR_username
	FETCH NEXT
	FROM @CURSOR_username INTO @username
	WHILE @@FETCH_STATUS = 0
	BEGIN
		select @userNameAuth = username,@isOverridden=IsOverridden from userauth(NOLOCK) where username=@username;
	
		if @userNameAuth <> '' and @userNameAuth is not null
	--Update
		BEGIN
		If @isOverridden is null or @isOverridden =0
		BEGIN
		Select
			@firstname=Left(LTRIM(u1.First_NAME),1)+Right(LOWER(u1.First_NAME), len(u1.First_NAME)-1),
			@lastname =Left(LTRIM(u1.LAST_NAME),1)+Right(LOWER(u1.LAST_NAME), len(u1.LAST_NAME)-1),
			@EmailId= u1.EMAILID,
			@supervisorid =ua.id,
			@title = u1.position_title,
			@EMPID = u1.EMPID,
			@PhysicalLocation = u1.LOCATION
		from HRMSStagingUsers(NOLOCK) u1
			left join HRMSStagingUsers(NOLOCK) u2
			on  u1.REPORT_EMPLID=u2.EMPID
			left join userauth(NOLOCK) ua
			on ua.username= u2.OPRID
		where u1.OPRID=@username
		BEGIN TRY
		Update UserAuth
		SET
		lastname=@lastname,
		firstname=@firstname,
		EmailAddress=@EmailId,
		SupervisorID=@supervisorid,
		Title=@title,
		Active=1,
		--calcFirstLastName=@firstname+', '+@lastname,
		--calcLastFirstName=@lastname+', '+@firstname
		LastUpdate=GETDATE(),
		LastUpdateUserID=11704,--select id from userauth where firstname like '%system%'
		EmployeeID=@EMPID,
		Physicallocation=@PhysicalLocation
		Where username=@username;
		--select @userid=id from userauth where username=@username
		--delete from plauth1 where userid=@userid;
		insert into plAuth
			(
			plID,
			userID,
			Level1ID,
			Level1Code,
			Level2ID,
			Level2Code
			)
			
		select	pl.ID,
			uauth.ID,
			ol2.Level1ID,
			ol2.MDMLevel1Code,
			ol2.Level2ID,
			ol2.MDMLevel2Code
			from userauth(NOLOCK) uauth
			left join HRMSStagingUsers(NOLOCK) hr on uauth.username = hr.OPRID
			left join OrgDataLevel2(NOLOCK) ol2 on hr.W_SEG_DESCR = ol2.Level2Name
			left join BusinessUnits(NOLOCK) bu on bu.MDMLevel2Code = ol2.MDMLevel2Code
			left join productLines(NOLOCK) pl on pl.BusinessUnitID = bu.BusinessUnitID
			where uauth.username=@username --and bu.Active=1 and pl.Active=1
			END TRY

		BEGIN CATCH
		select @userNameAuth;
		END CATCH
		END
	END
		FETCH NEXT
		FROM @CURSOR_username INTO @username
	END
	CLOSE @CURSOR_username
	DEALLOCATE @CURSOR_username
	
	--Update UserAuth 
	--SET Active=0
	--Where UserName not in(Select OPRID from HRMSStagingUsers(NOLOCK))
	--and id not in(11704,43683,18648,56306,51562) and IsNull(IsOverridden,0) <>1
END

