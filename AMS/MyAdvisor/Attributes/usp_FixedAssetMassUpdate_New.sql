CREATE PROCEDURE [dbo].[usp_FixedAssetMassUpdate_New]
(
	@attributeId      VARCHAR(50),
	@attributeValueId VARCHAR(50),
	@wftUserName      VARCHAR(50),
	@fixedAssetIds    VARCHAR(max)
)
AS
  BEGIN
		DECLARE @userid INT
		DECLARE @updateAuditTypeId INT
		DECLARE @upsertDate DATE = GETDATE()
		DECLARE @auditid uniqueidentifier = NEWID()
		DECLARE @auditActionId int 

		--get audit type id for modify
		SELECT @updateAuditTypeId = audittypeid
		FROM   audittypes
		WHERE  auditdesc = 'Modify Appliction Attribute'
	  
		--fetch user id from users table based on wft user name
		SELECT @userid = userId from Users where WFTUserName = @wftUserName

		--update ApplicationAttributes if attribute is already present
		UPDATE ApplicationAttributes
		SET AttributeValueid = @attributeValueId,
			ApplicationType = 2,
			lastUpdatedBy = @wftUserName,
			lastUpdatedOn = @upsertDate
		WHERE  ApplicationId IN(SELECT entry FROM   dbo.Listtotable(@fixedAssetids))
			and Attributeid = @attributeId
			and AttributeValueid != @attributeValueId

		--insert records for not previously added
		INSERT INTO applicationattributes
					(Attributeid,
					AttributeValueid,
					ApplicationId,
					ApplicationType,
					lastupdatedby,
					lastupdatedon)
		SELECT @attributeId,
				@attributeValueId,
				f.[entry],
				2,
				@wftUserName,
				@upsertDate
		FROM   dbo.Listtotable(@fixedAssetids) f
		LEFT JOIN ApplicationAttributes a on f.entry = a.[ApplicationId] and a.ApplicationType = 2 -- fixedasset
				and a.Attributeid = @attributeId
		WHERE  a.ApplicationId is null

		INSERT INTO AuditActions
					(AuditTypeId,
					UserId,
					AuditId,
					AuditTable,
					ActionDesc,
					ActionDate)
		VALUES(@updateAuditTypeId,
				@userid,
				@auditid,
				'Application Attribute',
				'Fixedasset Attribute Mass Update',
				@upsertDate)
		
		
		SET @auditActionId = SCOPE_IDENTITY()

		INSERT INTO AuditApplicationAttributes
		(
			AuditActionId,
			Attributeid,
			AttributeValueid,
			ApplicationId,
			ApplicationType,
			lastUpdatedBy,
			lastUpdatedOn,
			Id)
		SELECT @auditActionId,
			@attributeId,
			@attributeValueId,
			f.entry,
			2,
			@WFTUserName,
			Getdate(),
			a.Id
		FROM   dbo.Listtotable(@fixedAssetids) f
		JOIN ApplicationAttributes a on f.entry = a.ApplicationId

	END 
