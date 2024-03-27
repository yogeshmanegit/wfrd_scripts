-- =============================================
-- Author:	Shailesh Patil
-- Create date: 7 Oct 2016
-- Description:	Get Disposition details
-- =============================================
ALTER PROCEDURE [dbo].[usp_GetDispositionDetails] 
	@AssetRepairTrackId uniqueidentifier
AS

BEGIN

	SET NOCOUNT ON;

	--Get failed sequence details

	SELECT 
		A.SeqName,
		A.Comment,
		A.UserName,
		A.DateAdded
	FROM vwPFTWOSeq A
	INNER JOIN AssetRepairTrack B ON B.ITPFTWOId = A.PFTWOId
	WHERE B.AssetRepairTrackId = @AssetRepairTrackId


	--Get Disposition history 

	SELECT 
		Disposition,
		DispositionDesc,
		Status,
		ShipToBranchPlantName,
		ApproverFullName,
		DateAdded,
		DispositionComments
	FROM vwArtDispositions A
	WHERE A.AssetRepairTrackId = @AssetRepairTrackId

	ORDER BY A.DateAdded DESC

 --Failure codes
	SELECT 
		f.FailureCodeId,
		f1.FailureCategoryCode + f2.FailureSubCategoryCode + f.FailureCode [FailureCode],
		f1.FailureCategoryId,
		f2.FailureSubCategoryId,
		F.FailureDesc FailureCodeDesc,
		P.FailureCodeId ProcedureCodeId,
	    P1.FailureCategoryCode + P2.FailureSubCategoryCode + P.FailureCode [ProcedureCode],
		P.FailureDesc ProcedureCodeDesc,
		O.FailureCodeId OutOfSpecCodeId,
		O1.FailureCategoryCode + O2.FailureSubCategoryCode + O.FailureCode [OutOfSpecCode],

		O.FailureDesc OutOfSpecCodeDesc,
		A.ItemNum
	FROM AssetRepairTrack A 
	LEFT JOIN FailureCodes F ON F.FailureCodeId = A.FailureCodeId
	LEFT JOIN FailureCategories F1 ON F1.FailureCategoryId = f.FailureCategoryId
	LEFT JOIN FailureSubCategories F2 ON F2.FailureSubCategoryId = f.FailureSubCategoryId

	LEFT JOIN FailureCodes P ON P.FailureCodeId = A.ProceduralCodeId
	LEFT JOIN FailureCategories P1 ON P1.FailureCategoryId = P.FailureCategoryId
	LEFT JOIN FailureSubCategories P2 ON P2.FailureSubCategoryId = P.FailureSubCategoryId

	LEFT JOIN FailureCodes O ON O.FailureCodeId = A.OutOfSpecCodeId
	LEFT JOIN FailureCategories O1 ON O1.FailureCategoryId = O.FailureCategoryId
	LEFT JOIN FailureSubCategories O2 ON O2.FailureSubCategoryId = O.FailureSubCategoryId
	WHERE A.AssetRepairTrackId=@AssetRepairTrackId

	--Disposition Types (for dropdownlist) 
	SELECT 
		OptionValue,
		OptionLabel 
	FROM SelectOptions 
	WHERE selectname='Disposition'
	ORDER BY SortOrder, OptionValue

	--Branch Plant - for dropdownlist

	SELECT BranchPlant, 
			BranchPlant + ' - ' + CompanyName BranchPlantName
	FROM BranchPlants WHERE IsGlobalRepair = 1

	--Get Dispostion details for last activity
	SELECT top 1 
			DispositionId,
			Disposition,
			DispositionDesc,
			ApproverId,
			ApproverUserName,
			DispositionDate,
			ShipToLocation,
			DispositionComments,
			[Status]
	FROM vwArtDispositions A
	WHERE A.AssetRepairTrackId = @AssetRepairTrackId
	ORDER BY DateAdded DESC


	DECLARE @sLocId varchar(16), @sProductLine varchar(50)

	SELECT @sLocId = a.FromBranchPlant, 
			@sProductLine = f.ProductLineCode
	FROM AssetRepairTrack a (NOLOCK)
	JOIN FixedAssets f (NOLOCK) on a.FixedAssetId = f.FixedAssetId 
	Where AssetRepairTrackId = @AssetRepairTrackId

	-- Get Approval level 1 users
	exec usp_GetARTDispositionApprovers 
			@sApprovalCode=N'AIRT', 
			@iApproverType=5,
			@sLocId= @sLocId,
			@sProductLine= @sProductLine,
			@iAssetRepairTrackId= @AssetRepairTrackId,
			@bIsLevel2Approver=0,
			@bGetInitialLevel2ApproverId=0,
			@bIsGlobalApprover=0,
			@bIncludeGlobal=1

	-- Get Approval Level 2 users
	exec usp_GetARTDispositionApprovers 
			@sApprovalCode=N'AIRT',
			@iApproverType=10,
			@sLocId= @sLocId,
			@sProductLine= @sProductLine,
			@iAssetRepairTrackId= @AssetRepairTrackId,
			@bIsLevel2Approver=0,
			@bGetInitialLevel2ApproverId=0,
			@bIsGlobalApprover=0,
			@bIncludeGlobal=1
END

