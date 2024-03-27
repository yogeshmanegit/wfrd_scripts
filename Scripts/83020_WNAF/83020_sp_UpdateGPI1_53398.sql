ALTER PROCEDURE [dbo].[sp_UpdateGPI1]     
 @ReportID int,    
 @ReportTypeID int,    
 @ReportDate DateTime,    
 @ReportedBy nvarchar(50),    
 @UsrPhoneNumber nvarchar(50),    
 @EventDate DateTime,    
 @EventTime nvarchar(50),    
 @InvestigationAssigned nvarchar(50),    
 @StageInTour nvarchar(50),    
 @ManagerResponsible nvarchar(50),    
 @Reviewer int,  
 @UserContactingClient  int,
 @IncidentType int,    
 --@AuditCategory int,    
 @TechIssueType int,
 @ManufacturingCategory int,
 @WPSICategory int,    
 @SecurityIncidentCategory int,    
 @PropertySubCategory int,    
 @PersonnelSubCategory int,    
 @ChangeRequestApp int,
 @ShortDescription nvarchar(150),    
 @IncidentDescription ntext,    
 @ShortTerm ntext,    
 --@Circumstances ntext,    
 --@Comments ntext,    
 --@SalesRef nvarchar(50),    
 --@ModelNumber nvarchar(50),    
 --@SerialNumber nvarchar(50),    
 @CustomerID int,    
 @CustomerComplaint bit,    
 @WellName nvarchar(50),    
 @Rig nvarchar(50),    
 --@OtherInvestigation int,    
 --@RelatedFactors int,    
 @WFTRegionID int,    
 @CountryID int,    
 @AreaID int,    
 @WFTLocationID int,    
 @DivisionType int,    
 @ActualConsequence int,    
 @PotentialConsequence int, 
 @LegalFatality bit,
 @LegalThirdParty bit,
 @LegalWellControl bit,
 @LegalClientDamage bit,   
 @LocationOccurred int,     
 @Location nvarchar(250),    
 --@ProbSolvedLocal bit,    
 --@PartNumber nvarchar(50),    
 --@PartDescription nvarchar(300) ,    
 --@NotApprovalBeginDate datetime,
 --@NotApprovalDuration int,
 --@LegalHoldBeginDate datetime,
 --@LegalHoldDuration int,
 --@CustResponseDate DateTime,    
 --@CustResponseDuration int,    
 --@CustClosureDate DateTime,    
 --@CustClosureDuration int,    
 --@InvestBeginDate DateTime,    
 --@InvestDuration int,    
 --@ReviewBeginDate DateTime,    
 --@ReviewDuration int,    
 --@ImpBeginDate DateTime,    
 --@ImpDuration int,    
 --@VerfBeginDate DateTime,    
 --@VerfDuration int,    
 --@IncidentClosedDate DateTime,    
 --@IncidentDuration int,    
 --@TotalDays int,
 @DroppedWeight float= NULL,
 @DroppedDistance float = NULL,
 @Level2ID int,
 @Level4ID int,
 @WPM BIT = NULL,
 @Inventory BIT = NULL,
 @QualityCommonHSEForms INT = NULL,
 @HSECommonHSEForms INT = NULL,
 @SecurityCommonHSEForms INT = NULL,
 @EnvironmentCommonHSEForms INT = NULL,
 @AuditFindingTypes INT = NULL,
 @OperationalIAOnly int=null,
 @DeleteNote VARCHAR(MAX),
 @IsWFTNotAtFault BIT = NULL,
 @Logistics INT = NULL,
 @IsHazMat BIT = NULL,
 @HazMatSubQuestions INT = NULL,
 @HazChemicalName NVARCHAR(50)=NULL,
 @WellboreCleanUpRequired BIT=NULL
AS    
BEGIN    
SET NOCOUNT ON    
    if @ManagerResponsible is null     
    begin    
	set @ManagerResponsible  = (Select SupervisorID from userauth where [id] = @ReportedBy)    
    end     
    
    if @InvestigationAssigned is null    
    begin    
	set @InvestigationAssigned = dbo.fnGetInvestigatorID(@IncidentType,@WFTLocationID,@Level4ID)    
    end    
    
    
    if @Reviewer is null    
    begin    
	set @Reviewer = dbo.fnGetReviewerID(@IncidentType,@WFTLocationID,@Level4ID)    
    end    
    
/*---- HACK---- */     
-- QHSSE wants Comeaux, Krystal  to be assigned as a CPAR admin to    
-- every QHSSE CPAR for the US not for Widgets    
-- 225 = US    
-- 26221 = HSSE    
--@WFTRegionID    
/*    
144 - United States/Gulf Coast = 3682 - Comeaux, Krystal changed to Sanjuana Martinez 03-19-2013 (27907)    
19622 - United States/Midcon = 24550 - Tammy Clemmens    
19623 - United States/West = 26543 - Gregory Howell    
*/    
    

   
    
--gpi1 is a header type page, will always be an UPDATE since the id should be created.
    
UPDATE gpi1    
 set ReportTypeID = @ReportTypeID,    
 ReportDate = @ReportDate,    
 ReportedBy = @ReportedBy,    
 UsrPhoneNumber = @UsrPhoneNumber,    
 EventDate = @EventDate,    
 EventTime = @EventTime,    
 InvestigationAssigned = @InvestigationAssigned,    
 StageInTour = @StageInTour,    
 ManagerResponsible = @ManagerResponsible,    
 Reviewer = @Reviewer, 
UserContactingClient = @UserContactingClient,   
 IncidentType = @IncidentType,    
 --AuditCategory = @AuditCategory,    
 ManufacturingCategory = @ManufacturingCategory,
 WPSICategory = @WPSICategory,    
 TechIssueType = @TechIssueType,    
 SecurityIncidentCategory = @SecurityIncidentCategory ,    
 PropertySubCategory = @PropertySubCategory ,    
 PersonnelSubCategory = @PersonnelSubCategory ,    
 ChangeRequestApp = @ChangeRequestApp, 
 ShortDescription = @ShortDescription,
 IncidentDescription = @IncidentDescription,    
 ShortTerm = @ShortTerm,    
 --Circumstances = @Circumstances,    
 --Comments = @Comments,    
 --SalesRef = @SalesRef,    
 --ModelNumber = @ModelNumber,    
 --SerialNumber = @SerialNumber,    
 CustomerID = @CustomerID,    
 CustomerComplaint = @CustomerComplaint,    
 WellName = @WellName,    
 Rig = @Rig,    
 --OtherInvestigation = @OtherInvestigation,    
 --RelatedFactors = @RelatedFactors,    
 WFTRegionID = @WFTRegionID,    
 CountryID = @CountryID,    
 AreaID = @AreaID,    
 WFTLocationID = @WFTLocationID,    
 DivisionType = @DivisionType,    
 ActualConsequence = @ActualConsequence ,    
 PotentialConsequence= @PotentialConsequence,  
 LegalFatality = @LegalFatality,
 LegalThirdParty = @LegalThirdParty,
 LegalWellControl = @LegalWellControl,
 LegalClientDamage = @LegalClientDamage,
 LocationOccurred = @LocationOccurred,    
 Location = @Location,    
  --ProbSolvedLocal = @ProbSolvedLocal,    
 --PartNumber = @PartNumber,    
 --PartDescription = @PartDescription,    
  /*
 CustResponseDate=@CustResponseDate,    
 CustResponseDuration=@CustResponseDuration,    
 CustClosureDate=@CustClosureDate,    
 CustClosureDuration=@CustClosureDuration,    
 InvestBeginDate = @InvestBeginDate,    
 InvestDuration = @InvestDuration,     
 ReviewBeginDate=@ReviewBeginDate,    
 ReviewDuration=@ReviewDuration,    
 ImpBeginDate=@ImpBeginDate,    
 ImpDuration=@ImpDuration,    
 VerfBeginDate=@VerfBeginDate,    
 VerfDuration=@VerfDuration,    
 IncidentClosedDate=@IncidentClosedDate,    
 IncidentDuration=@IncidentDuration,    
 TotalDays=@TotalDays,
 */
 DroppedWeight = @DroppedWeight,
 DroppedDistance = @DroppedDistance,
 Level2ID= @Level2ID, 
 Level4ID = @Level4ID,
 WPM = @WPM,
 Inventory = @Inventory,
 QualityCommonHSEForms = @QualityCommonHSEForms,
 HSECommonHSEForms = @HSECommonHSEForms,
 SecurityCommonHSEForms = @SecurityCommonHSEForms,
 EnvironmentCommonHSEForms = @EnvironmentCommonHSEForms,
 AuditFindingTypes = @AuditFindingTypes,
 OperationalIAOnly=@OperationalIAOnly,
 --Additional details for Auditing
 ModifiedBy=@ReportedBy,
 ModifiedDate=GETDATE(),
 IsDeleted=0,
 DeleteNote=@DeleteNote,
 --IsWFTNotAtFault=@IsWFTNotAtFault,
 Logistics=@Logistics,
 IsHazMat=@IsHazMat,
 HazMatSubQuestions=@HazMatSubQuestions,
 HazChemicalName=@HazChemicalName,
 WellboreCleanUpRequired=@WellboreCleanUpRequired
WHERE IncidentID = @ReportID    
    
END

