

 ALTER PROCEDURE [dbo].[sp_Updatencr1]         
 @ReportID int,        
 @IncidentType int,        
 @CPARNum nvarchar(50),        
 @ReportDate datetime,        
 @CloseDate datetime,        
 @SalesRef nvarchar(50),        
 @PONumber nvarchar(50),        
 @SONumber nvarchar(50),        
 @RMANumber nvarchar(50),        
 @PartNumber nvarchar(50),        
 @SerialNumber nvarchar(50),        
 @HeatNumber nvarchar(50),        
 @MaterialDescription nvarchar(max),        
 @qtyOrdered nvarchar(50),        
 @qtyInspected nvarchar(50),         
 @qtyRejected nvarchar(50),        
 @CustomerID int,        
 @WFTRegionID int,        
 @CountryID int,        
 @AreaID int,        
 @WFTLocationID int,        
 @DivisionType int,        
 @ManagerResponsible nvarchar(50),        
 @ReportedBy nvarchar(50),        
 @CPARAdmin int,        
 @StageInTour int,      
 @SupplierName nvarchar(200),
 @NCRCausedBy int,
 @SupplierId int,
 @Level2ID int,
 @Level4ID int,
 @DeleteNote nvarchar(max)=null,
 @HeliosCaxiasSupplierID int,
 @HeliosCaxiasSupplierName nvarchar(200),
 @SupervisorID int= null,
@DayWeek varchar(15)= null,
@ShiftNumber int =null,
@WorkCenter varchar(50) =null,
@MaterialSpec varchar(50)= null,
@MaterialSize varchar(50) =null,
@TypeConnection varchar(50)= null,
@SupplementInfo varchar(15) =null,
@SupplementInfoClientID int= null
AS        
BEGIN        
SET NOCOUNT ON        
        
--Try to do an UPDATE first.  If no records affected, then do an INSERT        
        
UPDATE gpi1        
 SET IncidentType = @IncidentType,        
 CPARNum = @CPARNum,        
 ReportDate = @ReportDate,        
 CloseDate = @CloseDate ,        
 SalesRef = @SalesRef,        
 PONumber = @PONumber,        
 SONumber = @SONumber,        
 RMANumber = @RMANumber,        
 PartNumber = @PartNumber,        
 SerialNumber = @SerialNumber,        
 HeatNumber = @HeatNumber,        
 MaterialDescription = @MaterialDescription,        
 qtyOrdered = @qtyOrdered,        
 qtyInspected = @qtyInspected,         
 qtyRejected = @qtyRejected,        
 CustomerID = @CustomerID,        
 WFTRegionID = @WFTRegionID,        
 CountryID = @CountryID,        
 AreaID = @AreaID,        
 WFTLocationID = @WFTLocationID,        
 DivisionType = @DivisionType,        
 ManagerResponsible = @ManagerResponsible,        
 ReportedBy = @ReportedBy,        
 CPARAdmin = @CPARAdmin,        
 StageInTour = @StageInTour,        
 ReportTypeID = 61, -- NCR operationid = 61      
 SupplierName = @SupplierName,
 NCRCausedBy = @NCRCausedBy,
 SupplierId = @SupplierId,
 Level2ID= @Level2ID, 
 Level4ID = @Level4ID,
 ModifiedBy=@ReportedBy,
 ModifiedDate=GETDATE(),
 IsDeleted=0,
 DeleteNote=@DeleteNote,
 HeliosCaxiasSupplierID=@HeliosCaxiasSupplierID,
 HeliosCaxiasSupplierName=@HeliosCaxiasSupplierName,
 SupervisorID=@SupervisorID,
DayWeek=@DayWeek,
ShiftNumber=@ShiftNumber,
WorkCenter=@WorkCenter,
MaterialSpec=@MaterialSpec,
MaterialSize=@MaterialSize,
TypeConnection=@TypeConnection,
SupplementInfo=@SupplementInfo,
SupplementInfoClientID=@SupplementInfoClientID
 WHERE IncidentID = @ReportID        


/* set All MDM levels */
 UPDATE gpi1
SET level3ID = OrgDataLevels.Level3ID , 
    Level2ID = OrgDataLevels.Level2ID , 
    Level1ID = OrgDataLevels.Level1ID
  FROM dbo.gpi1
       INNER JOIN dbo.OrgDataLevels
       ON dbo.gpi1.Level4ID = dbo.OrgDataLevels.Level4ID
  WHERE IncidentID = @ReportID;
       
        
END



