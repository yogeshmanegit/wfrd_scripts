use aesops

--Service & Repair reopened. After answering remaining steps, you should be able to close AIRT

DECLARE @assetTrackRepairId uniqueidentifier = 'fcb3d6e2-206f-42e7-913b-aacc00f3b26a'

SELECT top 1 cs.Seq, s.* FROM PFTWOSeq s 
JOIN PFTConfigSeq cs on s.PFTConfigSeqId = cs.PFTConfigSeqId WHERE PFTWOId = (SELECT SRPFTWOID from AssetRepairTrack 
		where AssetRepairTrackId = @assetTrackRepairId)
order by DateAdded desc

SELECT top 1 * FROM PFTConfigSeq WHERE PFTConfigId = (SELECT PFTConfigId from PFTWO 
		where AssetRepairTrackId = @assetTrackRepairId and PFTType = 1)
order by Seq desc


BEGIN TRAN

UPDATE PW
SET Active = 1, CurPFTWOSeqId = pcs.PFTConfigSeqId
FROM PFTWO pw
JOIN PFTConfigSeq pcs ON pcs.PFTConfigId = pw.PFTConfigId
WHERE pw.AssetRepairTrackId = @assetTrackRepairId and pw.PFTType = 1
AND pcs.Seq = ((SELECT top 1 pcsi.seq 
			FROM PFTWO pwi
			JOIN PFTWOSeq pwsi on pwi.PFTWOId = pwsi.PFTWOId
			JOIN PFTConfigSeq pcsi ON pcsi.PFTConfigSeqId = pwsi.PFTConfigSeqId
			WHERE pwi.AssetRepairTrackId= @assetTrackRepairId and pwi.PFTType = 1
			ORDER BY pwsi.DateAdded DESC) + 1)

ROLLBACK TRAN