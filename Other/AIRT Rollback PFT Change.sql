-- =============================================  
-- Author:   Yogesh Mane  
-- Create date: 10/25/2016  
-- Description: Get Control Show/Hide or Enable/Disable flags  
-- =============================================  
CREATE PROCEDURE [dbo].[usp_CBM_GetControlDefaults]  
 -- Add the parameters for the stored procedure here  
 @AssetRepairTrackId uniqueidentifier,  
 @UserId int  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
   DECLARE @CanCloseAIRT bit = 0,  
   @CanReopenAIRT bit = 0,  
   @CanUpdateAssetStatus bit = 0,  
   @CanUpdateJobInfo bit = 0,  
   @CanViewDisposition bit = 0,  
   @CanViewPMDisposition bit = 0,  
   @CanViewAIRTDisposition bit = 0,  
   @CanUpdateFailureCode bit = 1,  
   @CanPerformDisposition bit = 0,  
   @CanPerformPMDisposition bit = 0,  
   @CanPerformPMRollback bit = 0,  
   @CanPerformRollback bit = 0,  
   @CanViewSRPFT bit = 0,  
   @CanCreateSRPFT bit = 0,  
   @CanViewWorkOrder bit = 0,  
   @CanViewTCN bit = 0,  
   @CanViewFirmware bit = 0,  
   @IsTIPFTPassed bit = 0,  
   @CanSendApprovalEmail bit=0,  
   @CanAddPMDisposition bit = 1,  
   @CanReActivateTIPFT bit = 0,  
   @CanReActivateSRPFT bit = 0,  
   @CanApproveJDEWorkOrder bit =0  
      
 DECLARE @ApproverLevel int, @ProductLine varchar(50), @LocId VARCHAR(16)  
 DECLARE @FixedAssetId Uniqueidentifier, @TIPFTPassed bit = 0  
  
 SELECT @FixedAssetId = FixedAssetId FROM AssetRepairTrack (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId  
  
 SELECT @LocId = a.FromBranchPlant,   
        @ProductLine = f.ProductLineCode  
       FROM AssetRepairTrack a (NOLOCK)  
       JOIN FixedAssets f (NOLOCK) on a.FixedAssetId = f.FixedAssetId   
       Where AssetRepairTrackId = @AssetRepairTrackId  
  
 -- Approver level  
 SELECT @ApproverLevel = dbo.udf_GetAIRTApproverLevel(@ProductLine, @LocId, @UserId)  
  
 -- TCN Flag  
   
 IF EXISTS(SELECT * FROM vwChangeNoticeParts v (NOLOCK) Where FixedAssetId = @FixedAssetId OR TopLevelFixedAssetId = @FixedAssetId AND NotApplicable = 0)  
 BEGIN  
  SET @CanViewTCN = 1  
 END  
  
 -- If Firmware present   
 IF EXISTS(SELECT ItemNum FROM SensorItemNums (NOLOCK) WHERE ItemNum = (SELECT InventoryItemNum FROM FixedAssets (NOLOCK) Where FixedAssetId = @FixedAssetId))  
  BEGIN  
   SET @CanViewFirmware = 1  
  END  
    ELSE IF EXISTS(SELECT BoardItemNum FROM BoardItemNums (NOLOCK) WHERE BoardItemNum = (SELECT InventoryItemNum FROM FixedAssets (NOLOCK) Where FixedAssetId = @FixedAssetId))  
  BEGIN  
   SET @CanViewFirmware = 1  
  END  
     
  
 -- iF AIRT is open  
 IF EXISTS(SELECT * FROM AssetRepairTrack (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND Status = 'Open')  
 BEGIN  
   
  SELECT @CanUpdateAssetStatus = 1, @CanUpdateJobInfo = 1  
  
  -- If T&I PFT is closed  
  IF EXISTS(SELECT * FROM PFTWO p (NOLOCK) WHERE p.PFTType = 2 AND AssetRepairTrackId = @AssetRepairTrackId AND p.Active = 0)  
   BEGIN  
  
   IF EXISTS(SELECT * FROM PMDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId)  
    BEGIN  
     SELECT @CanViewDisposition = 1, @CanViewPMDisposition = 1  
    END  
  
    -- T & I Passed  
    IF NOT EXISTS (SELECT * FROM PFTWO p (NOLOCK)   
         JOIN PFTWOSeq ps (NOLOCK) on p.PFTWOId = ps.PFTWOId  
         WHERE p.AssetRepairTrackId = @AssetRepairTrackId AND p.PFTType = 2 AND ps.PFTResult = 'F')  
     BEGIN  
      --print 'T & I Passed'  
      SET @TIPFTPassed = 1  
  
      IF EXISTS(SELECT * FROM AssetRepairTrack (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND IsRedTag = 1)  
       BEGIN  
        SET @CanViewDisposition = 1  
       END  
  
      -- T&I passed and PM checks are not present or no PFT needs to be created then AIRT can be closed  
      ELSE  IF NOT EXISTS(SELECT * FROM PMDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND (Active = 1 OR DispositionOption = 1))  
       BEGIN  
        SET @CanCloseAIRT = 1  
       END  
     END  
      
    -- T&I is failed  
    IF(@TIPFTPassed = 0)  
     -- If T&I Failed then show disposition  
     BEGIN  
       
      SELECT @CanViewDisposition = 1  
      --SELECT @CanUpdateFailureCode = 1  
     END  
  
    -- Irrespective of T&I passed/failed check PM disposition complete or not  
    IF (@CanViewPMDisposition = 1)  
     BEGIN  
  
      -- If PM Disposition still not complete  
      IF EXISTS(SELECT * FROM PMDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND Active = 1)  
       BEGIN  
         
        --check if user has permission to perform PM Disposition   
        IF (@ApproverLevel >= 1)  
         BEGIN  
          SET @CanPerformPMDisposition = 1  
         END  
       END  
       -- If PM Disposition still not complete  
      IF NOT  EXISTS(SELECT * FROM ARTDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND Status = 'Approved')  
       BEGIN  
         
        --check if user has permission to perform PM Disposition   
        IF (@ApproverLevel >= 2)  
         BEGIN  
          SET @CanPerformPMRollback = 1  
         END  
       END  
     END  
  
    -- If AIRT Disposition can be viewed or not  
    -- Check disposition tab is visible  
    IF (@CanViewDisposition = 1)  
     BEGIN  
        
      -- Check PM Check Exists but nothing active  
      IF ((@CanViewPMDisposition = 1) AND NOT EXISTS (SELECT * FROM PMDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND Active = 1))  
       BEGIN  
          
        -- If T&I PFT failed or Create PM PFT option selected  
        IF ((@TIPFTPassed = 0) OR EXISTS (SELECT * FROM PMDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND DispositionOption = 1)  
        OR EXISTS(SELECT * FROM AssetRepairTrack (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND IsRedTag = 1))  
         BEGIN  
          SELECT @CanViewAIRTDisposition = 1  
         END  
       END  
      ELSE IF NOT EXISTS(SELECT * FROM PMDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId)  
        BEGIN  
         SELECT @CanViewAIRTDisposition = 1  
        END  
  
     END  
  
  
    IF(@CanViewAIRTDisposition = 1)  
    BEGIN  
       
     -- If Disposition done  
     IF EXISTS(SELECT * FROM ARTDispositions (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND Status = 'Approved')  
      BEGIN  
  
        -- Disposition done but tool needs to undergo repair  
        IF EXISTS(SELECT * FROM ARTDispositions (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND Status = 'Approved' AND Disposition IN (1,2))  
         BEGIN    
          SELECT @CanViewSRPFT = 1  
  
		  IF (@ApproverLevel = 2)  
		  BEGIN  
		   SET @CanPerformRollback = 1  
		  END 

          -- If S&R PFT not created   
          IF NOT EXISTS(SELECT * FROM PFTWO (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND PFTType = 1)  
           BEGIN  
               
            SELECT @CanCreateSRPFT = 1  
  
            -- disposition rollback possible if SRPFT not yet created  
            --IF (@ApproverLevel = 2)  
            --BEGIN  
            -- SET @CanPerformRollback = 1  
            --END

           END  
          -- If S&R PFT is created  
          ELSE  
           BEGIN  
               
            SELECT @CanViewWorkOrder = 1  
  
			
            -- if All PFTs are closed, AIRT can be closed  
            IF NOT EXISTS(SELECT * FROM PFTWO (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND Active = 1)  
             BEGIN    
			 
			 --if all PFTS are CLOSED and want to create new SRPFT
			 --SELECT @CanCreateSRPFT = 1
			 print 's&r'
			 

			 --if S&R PFT is closed but not on last step then allow users to create new S&R PFT
			 -- this is for Rollback PFT bug
			 DECLARE @LatestSRPFTId uniqueidentifier, @PftConfigId uniqueidentifier, @LastPFTWOSequence int, @LastPFTConfigSequence int

			 SELECT TOP 1 @LatestSRPFTId = PFTWOId, @PftConfigId = PFTConfigId FROM PFTWO (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId AND PFTType = 1 order by DateAdded desc
			 SELECT @LastPFTWOSequence = Seq from PFTConfigSeq (NOLOCK) WHERE PFTConfigSeqId = (SELECT top 1 PFTConfigSeqId FROM PFTWOSeq WHERE PFTWOId = @LatestSRPFTId Order By DateAdded desc)
			 SELECT @LastPFTConfigSequence = MAX(Seq) from PFTConfigSeq (NOLOCK) WHERE PFTConfigId = @PftConfigId

			 print @LastPFTWOSequence
			 print @LastPFTConfigSequence

			 IF (@LastPFTWOSequence != @LastPFTConfigSequence)
				 BEGIN
						SELECT @CanCreateSRPFT = 1
				 END
			 ELSE
				BEGIN
						SELECT @CanCloseAIRT = 1
						SELECT @CanPerformRollback = 0  
				END

			 
		     SELECT @CanUpdateFailureCode = 0  

             IF EXISTS(SELECT a.WorkOrderNum FROM AssetRepairTrack a (NOLOCK) INNER JOIN Workorders wo (NOLOCK) on a.WorkOrderNum = wo.WorkOrderNum WHERE  a.AssetRepairTrackId = @AssetRepairTrackId and Lower(wo.Status)='open')               
             BEGIN  
              SELECT @CanReActivateSRPFT = 1  
             END  
             END  
			--ELSE   
			-- BEGIN	
			--		IF (@ApproverLevel = 2)  
			--		BEGIN  
			--		 SET @CanPerformRollback = 1  
			--		END 
			-- END
         END  
         END  
        ELSE  
          
         BEGIN  
          -- If Disposition done with 'Use As Is' or 'Scrap'  
          SELECT @CanCloseAIRT = 1  
          SELECT @CanPerformRollback = 1  
          SELECT @CanUpdateFailureCode = 0  
         END  
      END  
     ELSE  
      -- if disposition yet pending  
      BEGIN  
            
       DECLARE @DispositionStatus VARCHAR(50)  
       SELECT @DispositionStatus = Status FROM ARTDispositions (NOLOCK) Where AssetRepairTrackId = @AssetRepairTrackId  
  
       IF(NOT(@DispositionStatus = 'Approved' OR @DispositionStatus = ''))  
       BEGIN  
        SET @CanSendApprovalEmail = 1  
       END         
  
       IF EXISTS(SELECT * FROM AssetRepairTrack (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId)  
           OR ( @TIPFTPassed=1 AND @CanViewAIRTDisposition=1)  
        BEGIN  
  
         IF(@DispositionStatus IS NULL)  
          BEGIN  
           SET @CanPerformDisposition = 1  
          END  
         ELSE   
          BEGIN  
            IF (@ApproverLevel > 0)  
            BEGIN  
              
              IF(@DispositionStatus = 'Submitted')  
               BEGIN  
                SET @CanPerformDisposition = 1  
               END  
              ELSE  
               BEGIN  
                IF (@ApproverLevel = 2)  
                BEGIN  
                 SET @CanPerformDisposition = 1  
                END  
               END  
            END  
  
          END  
         END             
      END  
    END  
   END  
  
  -- IF S&R PFT is closed  
  IF EXISTS (SELECT * FROM PFTWO p (NOLOCK) WHERE p.PFTType = 1 AND AssetRepairTrackId = @AssetRepairTrackId AND p.Active = 0)  
   BEGIN  
    SET @CanAddPMDisposition = 0  
   END  
  
  IF NOT EXISTS(SELECT * FROM ARTDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId)  
  BEGIN  
   SET @CanReActivateTIPFT = 1  
  END  
  
 END  
  
 -- If AIRT is closed  
 ELSE  
  BEGIN  
   SELECT @CanCloseAIRT = 0,  
   @CanReopenAIRT = 1,  
   @CanUpdateAssetStatus = 0,  
   @CanUpdateJobInfo = 0,  
   @CanViewDisposition = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM ARTDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId),  
   @CanViewPMDisposition = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM PMDispositions (NOLOCK)  WHERE AssetRepairTrackId = @AssetRepairTrackId),  
   @CanViewAIRTDisposition = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM ARTDispositions (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId),  
   @CanUpdateFailureCode = 0,  
   @CanPerformDisposition = 0,  
   @CanViewSRPFT = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM PFTWO (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND PFTType = 1 AND Active IN (0,1)),  
   @CanCreateSRPFT = 0,  
   @CanViewWorkOrder = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM PFTWO (NOLOCK) WHERE AssetRepairTrackId = @AssetRepairTrackId AND PFTType = 1 AND Active IN (0,1)),  
   @CanAddPMDisposition = 0  
  END  
    
  -- Approver level  
 SELECT @CanApproveJDEWorkOrder =   (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM UserRoles (NOLOCK) WHERE userId = @UserId and (RoleId = 506 OR RoleId = 1))  
  
 -- Insert statements for procedure here  
 SELECT  @CanCloseAIRT    [CanCloseAIRT],  
   @CanReopenAIRT    [CanReopenAIRT],  
   @CanUpdateAssetStatus  [CanUpdateAssetStatus],  
   @CanUpdateJobInfo   [CanUpdateJobInfo],  
   @CanViewFirmware   [CanViewFirmware],  
   @CanViewDisposition   [CanViewDisposition],  
   @CanViewPMDisposition  [CanViewPMDisposition],  
   @CanViewAIRTDisposition  [CanViewAIRTDisposition],  
   @CanUpdateFailureCode  [CanUpdateFailureCode],  
   @CanPerformDisposition  [CanPerformDisposition],  
   @CanPerformPMDisposition [CanPerformPMDisposition],  
   @CanPerformPMRollback  [CanPerformPMRollback],  
   @CanPerformRollback   [CanPerformRollback],  
   @CanViewSRPFT    [CanViewSRPFT],  
   @CanCreateSRPFT    [CanCreateSRPFT],  
   @CanViewWorkOrder   [CanViewWorkOrder],  
   @CanViewTCN     [CanViewTCN],  
   @ApproverLevel    [ApproverLevel],  
   @TIPFTPassed    [IsTIPFTPassed],  
   @CanSendApprovalEmail  [CanSendApprovalEmail],  
   @CanAddPMDisposition  [CanAddPMDisposition],  
   @CanReActivateTIPFT   [CanReActivateTIPFT],  
   @CanReActivateSRPFT   [CanReActivateSRPFT],  
   @CanApproveJDEWorkOrder  [CanApproveJDEWorkOrder],  
   CAST((SELECT CASE WHEN COUNT(*) >  0 THEN 1 ELSE 0 END FROM UserRoles (NOLOCK) WHERE (RoleId = 520 OR RoleId = 1) AND UserId = @UserId) AS BIT) AS [CanViewWindchillDoc]  
END



