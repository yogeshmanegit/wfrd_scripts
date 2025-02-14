SELECT DISTINCT
	  f.FixedAssetId,
	  f.SerialNum,
	  f.AssetNumber,
	  f.EquipmentStatus,
	  f.RNItemNum,
	  f.InventoryItemNum,
	  f.ProductLineId,
	  ISNULL(r.DescShort, i.DescShort) [DescShort],
	  ISNULL(r.ToolCode, i.ToolCode) ToolCode,
	  ISNULL(r.ToolPanel, i.ToolPanel) ,
	  bp.BranchPlant AS "CurrentBranchplant",
	  bp.CompanyName,
	  bp.Country,
	  bp.Region

	  /*Last Billable info*/,
	  ISNULL(f.LastBillableBranchPlant, '') AS "LastBillableBranchPlant",
	  ISNULL(f.LastBillableBranchPlantName, '') AS "LastBillableBranchPlantName",
	  ISNULL(f.LastBillableCountry, '') AS "LastBillableCountry",
	  ISNULL(f.LastBillableRegion, '') AS "LastBillableRegion",
	  ISNULL(CONVERT(varchar(10), ptd.[DatetoolTransferedfromOpsBillable], 101), '') AS "DateToolTransferedfromOpsBillable"

	  /*AIRT info*/,
	  ISNULL(b.artnumber, '') AS "LatestAIRT",
	  ISNULL(b.FromBranchPlant, '') AS "BPcreatingAIRT",
	  ISNULL(b.ShipToBranchPlant, '') AS "BPrepairingAIRT",
	  ISNULL(b.CurrentAirtStatus, '') AS "CurrentAIRTStatus",
	  ISNULL(CONVERT(varchar(10), b.DateAdded, 101), '') AS "DateAIRTCreated",
	  ISNULL(CONVERT(varchar(10), b.DateClosed, 101), '') AS "DateAIRTClosed",
	  ISNULL(B.[DispositionofAIRT], '') AS "DispositionofAIRT",
	  ISNULL(B.[AIRTDispositionComments], '') AS "AIRTDispositionComments",
	  ISNULL(CONVERT(varchar(10), b.[AIRTdispositiondate], 101), '') AS "AIRTDispositionDate"


	  /*Aging*/,
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, d.EndDate, GETDATE()), 101), '') AS "Agesincelastrun",
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, b.dateadded, GETDATE()), 101), '') AS "AgesincelastAIRTwasCreated",
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, (SELECT
		MAX(dateadded)
	  FROM pftwoseq psq
	  WHERE psq.PFTWOId = b.ITPFTWOId), GETDATE()), 101), '') AS "AgesincelastTIPFTstep",
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, b.[AIRTdispositiondate], GETDATE()), 101), '') AS "AgesinceAIRTwasDispositioned",
	  ISNULL(CONVERT(varchar(10), DATEDIFF(dd, ptd.[DatetoolTransferedfromOpsBillable], GETDATE()), 101), '') AS "DatesincetoolwaslastinOpsBillableBP",
	  ISNULL(CONVERT(varchar(10), pt1.dateshipped, 101), '') AS "DateshippedtoAIRTshiptolocation",
	  ISNULL(CONVERT(varchar(10), pt2.DateReceived, 101), '') AS "DatereceivedinAIRTshiptolocation",
	  ISNULL(CONVERT(varchar(10), pt3.dateshipped, 101), '') AS "Dateoflastshipmentoftool",
	  ISNULL(CONVERT(varchar(10), pt4.dateReceived, 101), '') AS "Datereceiptoftool",

	  CASE WHEN b.[DispositionofAIRT] = 'Repair in Global' AND pt1.dateshipped IS NULL THEN 'No Shipping information'
		   WHEN b.[DispositionofAIRT] = 'Repair in Global' AND pt2.DateReceived IS NULL THEN 'No Receipt information'
		   ELSE ISNULL(CONVERT(varchar(10), DATEDIFF(dd, pt1.dateshipped, pt2.DateReceived), 101), '')
	  END AS "TransittimefromTesttoRepairlocation"
	  
	  /*reliability selects*/

	  /*Last Job History*/,
	  ISNULL(CONVERT(varchar(10), d.EndDate, 101), '') AS "latestrunenddate",
	  ISNULL(d.JobNumber, '') AS "latestjob",
	  ISNULL(d.RunNumber, '') AS "latestrunnumber"


	  /*Lifetime job data*/,
	  ISNULL(rel1.[TotalCSI], 0) AS "TotalLifetimeCSI",
	  ISNULL(rel1.[TotalTFF], 0) AS "TotalLifetimeTFF",
	  ISNULL(rel1.[TotalOperHrs], 0) AS "TotalLifetimeOperHrs",
	  ISNULL(rel1.[TotalCircHrs], 0) AS "TotalLifetimeCircHrs",
	  ISNULL(CONVERT(decimal(18, 2), rel1.[TotalNPTHrs]), 0) AS "TotalLifetimeNPT",
	  ISNULL(rel1.[MaxTempLifetimeC], '') AS "LifetimeMaxTempC",
	  ISNULL(rel1.[MaxTempLifetimeF], '') AS "LifetimeMaxTempF"



	  /*Since Last AIRT*/,
	  ISNULL(b.[TotalCSISLA], 0) AS "TotalCSISLT",
	  ISNULL(b.[TotalTFFSLA], 0) AS "TotalTFFSLT",
	  ISNULL(b.[OperHrsSLA], 0) AS "OperHrsSLT",
	  ISNULL(b.[CircHrsSLA], 0) AS "CircHrsSLT",
	  ISNULL(CONVERT(decimal(18, 2), b.[NPTHrsSLA]), 0) AS "NPTHrsSLT",
	  ISNULL(b.[MaxTempSLAC], 0) AS "MaxTempSLTC",
	  ISNULL(b.[MaxTempSLAF], 0) AS "MaxTempSLTF"



	  /*Data Flags*/,
	  CASE WHEN b.ARTNumber IS NULL THEN 'No AIRT' ELSE '' END AS AIRTCheck,
	  CASE WHEN d.JobNumber IS NULL THEN 'No Job Info' ELSE '' END AS "JobCheck",
	  CASE WHEN f.LastBillableBranchPlant IS NULL THEN 'No billable info' ELSE '' END AS MovementCheck,

	  (select DATEDIFF(day,MAX(dii.DateAdded),GETDATE()) 
			from dispatchinstanceitems dii 
			left join DispatchInstances di on di.DispatchInstanceId = dii.DispatchInstanceId
			where di.ShipType = 'DT-SEQ-ADD' and dii.AssetNumber = f.AssetNumber) [Age_Since_Issued_To_DT],

	  (select DATEDIFF(day,MAX(dii.DateAdded),GETDATE()) 
			from dispatchinstanceitems dii 
			left join DispatchInstances di on di.DispatchInstanceId = dii.DispatchInstanceId
			where di.ShipType = 'DT-RETURN' and dii.AssetNumber = f.AssetNumber) [Age_Since_Returned_From_DT],

	  GETDATE() [CreatedOn]

	FROM vwFixedAssetsSearch f
	LEFT JOIN PartStatus(NOLOCK) ps ON ps.code = f.EquipmentStatus
	LEFT JOIN BranchPlants(NOLOCK) bp ON bp.BranchPlant = f.BranchPlant
	LEFT JOIN ItemNums(NOLOCK) r ON r.ItemNum = f.RNItemNum
	LEFT JOIN ItemNums(NOLOCK) i ON i.ItemNum = f.InventoryItemNum
	LEFT JOIN FixedAssets(NOLOCK) f1 ON f1.FixedAssetId = f.FixedAssetId
	LEFT JOIN GLCodes(NOLOCK) gc ON gc.GLCode = f1.ProductLineCode 
	LEFT JOIN GLProductLines(NOLOCK) gp ON gp.Id = gc.GLProductLineId
	
	/*Subquery for Latest AIRT with information about that AIRT*/
	
	LEFT JOIN (SELECT
		  ar.ITPFTWOId,
		  artnumber,
		  ar.dateadded,
		  dateclosed,
		  ar.fixedassetid,
		  d.[AIRTDispositionComments],
		  d.[AIRTdispositiondate],
		  d.[DispositionofAIRT],
		  d.ShipToBranchPlant,
		  ar.FromBranchPlant,
		  SUM(rel2.OperHrs) AS "OperHrsSLA",
		  SUM(rel2.circhrs) AS "CircHrsSLA",
		  SUM(rel2.[NPTHrs]) AS "NPTHrsSLA",
		  SUM(rel2.CSI) AS "TotalCSISLA",
		  SUM(rel2.tff) AS "TotalTFFSLA",
		  MAX(rel2.[MaxTempF]) AS "MaxTempSLAF",
		  MAX(rel2.[MaxTempC]) AS "MaxTempSLAC",

		  CASE WHEN ar.DateClosed IS NOT NULL THEN 'AIRT Closed'
			WHEN ar.SRPFTWOId IS NOT NULL THEN 'S&R PFT'
			WHEN ar.SRPFTWOId IS NULL AND d.[AIRTdispositiondate] IS NOT NULL THEN 'Approved disposition'
			WHEN ar.SRPFTWOId IS NULL AND d.[AIRTdispositiondate] IS NULL THEN 'In Inspection'
			ELSE 'unknown status' 
		 END AS [CurrentAirtStatus]

		FROM AssetRepairTrack(NOLOCK) ar

		/*current reliability data*/

		LEFT JOIN (SELECT
		  fixedassetid,
		  r6.OutHoleDate,
		  r6.operhrs,
		  r6.circhrs,
		  CONVERT(decimal(18, 5), ISNULL(tc6.losttime, 0)) AS "NPTHrs",
		  CONVERT(int, tc6.CSI) AS "CSI",
		  CONVERT(int, tc6.TFF) AS "TFF",
		  CONVERT(int, r6.MaxTempF) AS "MaxTempF",
		  CONVERT(int, r6.MaxTempc) AS "MaxTempC"

		FROM relbusinessintelligencedataset r6

		LEFT JOIN ToolStringComponentInfo(NOLOCK) tc6
		  ON tc6.RunID = r6.runid

		GROUP BY FixedAssetID,
				 r6.OutHoleDate,
				 r6.OperHrs,
				 r6.CircHrs,
				 tc6.losttime,
				 TC6.CSI,
				 tc6.TFF,
				 r6.MaxTempC,
				 r6.MaxTempF) rel2
		  ON rel2.FixedAssetID = ar.FixedAssetId
		  AND rel2.OutHoleDate > ar.DateAdded

	/*latest AIRT*/
	INNER JOIN (SELECT
	  MAX(dateadded) AS "dateadded",
	  FixedAssetId

	FROM AssetRepairTrack(NOLOCK)

	GROUP BY FixedAssetId) a
	  ON a.FixedAssetId = ar.FixedAssetId
	  AND ar.DateAdded = a.dateadded


	/*disposition*/


	LEFT JOIN (SELECT
					  a4.AssetRepairTrackid,
					  a4.ARTNumber AS "AIRTNumber",
					  ad4.DispositionComments AS "AIRTDispositionComments",
					  a4.ShipToBranchPlant,
					  a4.FromBranchPlant,

					  ad5.[Disposition Date] AS "AIRTdispositiondate",

					  CASE WHEN ad4.Disposition = '1' THEN 'Repair in District'
						WHEN ad4.Disposition = '4' THEN 'Use as is'
						WHEN ad4.Disposition = '2' THEN 'Repair in Global'
						WHEN ad4.Disposition = '3' THEN 'Scrap'
							ELSE 'unknown disposition' END AS [DispositionofAIRT]

					FROM AssetRepairTrack(NOLOCK) a4
					LEFT JOIN ARTDispositions(NOLOCK) ad4 ON ad4.AssetRepairTrackId = a4.AssetRepairTrackId

					INNER JOIN (SELECT ad.assetrepairtrackid,
									  MAX(ad.dateadded) [Disposition Date]
									  FROM ARTDispositions(NOLOCK) ad  
									  GROUP BY assetrepairtrackid) ad5
									  ON ad5.AssetRepairTrackId = a4.AssetRepairTrackId
									  AND ad4.DateAdded = ad5.[Disposition Date]
	  
					  ) d ON d.AssetRepairTrackId = ar.AssetRepairTrackId
					GROUP BY ar.ITPFTWOId,
							artnumber,
							ar.dateadded,
							dateclosed,
							ar.fixedassetid,
							d.[AIRTDispositionComments],
							d.[AIRTdispositiondate],
							d.[DispositionofAIRT],
							d.ShipToBranchPlant,
							ar.FromBranchPlant,

							CASE WHEN ar.DateClosed IS NOT NULL THEN 'AIRT Closed'
							WHEN ar.SRPFTWOId IS NOT NULL THEN 'S&R PFT' 
							WHEN ar.SRPFTWOId IS NULL AND d.[AIRTdispositiondate] IS NOT NULL THEN 'Approved disposition'
							WHEN ar.SRPFTWOId IS NULL AND d.[AIRTdispositiondate] IS NULL THEN 'In Inspection'
							ELSE 'unknown status' END
		) B ON b.fixedassetid = f.FixedAssetId



	/*Subquery to get Job information*/


	LEFT JOIN (SELECT ts.FixedAssetID,
				  MAX(j.JobNumber) [JobNumber],
				  MAX(r.EndDate) [EndDate],
				  MAX(r.RunNumber) [RunNumber]
				  FROM ToolStringComponentInfo(NOLOCK) ts
				  LEFT JOIN Runs r ON r.runid = ts.runid
				  LEFT JOIN wells w ON w.wellid = r.wellid 
				  LEFT JOIN JobS j ON j.JobId = w.JobID 
				  
				  INNER JOIN (SELECT tc1.fixedassetid,
									MAX(r1.enddate) AS "enddate" 
								  FROM ToolStringComponentInfo(NOLOCK) tc1 
								  LEFT JOIN Runs r1 ON r1.RunID = tc1.runid 
									  GROUP BY FixedAssetID) C ON c.FixedAssetID = ts.FixedAssetID AND c.enddate = r.EndDate
				GROUP BY ts.FixedAssetID) D ON d.FixedAssetID = f.FixedAssetId


	/*********************************************/

	/*** All Part Transfer Dtl data starts here***/

	/*********************************************/

	/*subquery to pull last ops location date*/


	LEFT JOIN (SELECT MAX(dateadded) AS [DatetoolTransferedfromOpsBillable],
					sendinglocation,
					FixedAssetId
				FROM PartTransferDtl(NOLOCK)
				WHERE source = 'pt'
				GROUP BY FixedAssetId,
					SendingLocation) ptd
	  ON ptd.SendingLocation = LastBillableBranchPlant
	  AND ptd.FixedAssetId = f.FixedAssetId



	/*subquery to get date shipped to repair location*/


	LEFT JOIN (SELECT MAX(pd1.dateadded) AS [dateshipped], 
					pd1.fixedassetid, 
					ReceivingLocation
				FROM parttransferdtl(NOLOCK) pd1
				WHERE source = 'pt' AND Dest = 'IT'
				GROUP BY fixedassetid,
					ReceivingLocation) PT1 ON pt1.ReceivingLocation = b.ShipToBranchPlant
	  AND f.FixedAssetId = pt1.FixedAssetId



	/*subquery to get date received in repair location*/


	LEFT JOIN (SELECT MAX(pd2.dateadded) AS [DateReceived], 
					ReceivingLocation,
					pd2.FixedAssetId
				FROM parttransferdtl(NOLOCK) pd2
				WHERE source = 'IT' AND Dest = 'AV'
				GROUP BY ReceivingLocation, fixedassetid

				) PT2 ON pt2.ReceivingLocation = b.ShipToBranchPlant AND f.FixedAssetId = pt2.FixedAssetId

	/*subquery to get date shipped*/

	LEFT JOIN (SELECT MAX(pd3.dateadded) AS [dateshipped],
					pd3.fixedassetid
				FROM parttransferdtl(NOLOCK) pd3
				WHERE Dest = 'av' AND Source = 'IT'
				GROUP BY fixedassetid) PT3 ON f.FixedAssetId = pt3.FixedAssetId

	/*subquery to get date date received*/


	LEFT JOIN (SELECT MAX(pd4.dateadded) AS [dateReceived], 
						pd4.FixedAssetId

				FROM parttransferdtl(NOLOCK) pd4
				WHERE source = 'it' AND Dest = 'av'
				GROUP BY fixedassetid) PT4 ON f.FixedAssetId = pt4.FixedAssetId


	/*subquery to pull sums of LIFETIME operations history of asset*/

	LEFT JOIN (SELECT
	  fixedassetid,
	  SUM(r5.operhrs) AS "TotalOperHrs",
	  SUM(r5.circhrs) AS "TotalCircHrs",
	  SUM(CONVERT(decimal(18, 5), ISNULL(tc5.losttime, 0))) AS "TotalNPTHrs",
	  SUM(CONVERT(int, tc5.CSI)) AS "TotalCSI",
	  SUM(CONVERT(int, tc5.TFF)) AS "TotalTFF",
	  MAX(CONVERT(int, r5.MaxTempF)) AS "MaxTempLifetimeF",
	  MAX(CONVERT(int, r5.MaxTempc)) AS "MaxTempLifetimeC"

	FROM relbusinessintelligencedataset(NOLOCK) r5
	LEFT JOIN ToolStringComponentInfo tc5 ON tc5.RunID = r5.runid

	GROUP BY FixedAssetID) rel1
	 ON rel1.FixedAssetID = f.FixedAssetId


	WHERE f.assetnumber IS NOT NULL
	AND ps.IsDisposed = '0'
	AND f.EquipmentStatus <> '50'
	AND gp.Id = '1'
	AND f.RNItemNum IS NOT NULL
