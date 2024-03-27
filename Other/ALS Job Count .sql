BEGIN TRAN

INSERT INTO EDI_MDM_Mapping
SELECT a.JobCode, 'GBU_ALS'
FROM 
( VALUES
 ('ALS')
, ('DCB' )
, ('DGI' )
, ('DGP' )
, ('JAF' )
, ('PAB' )
, ('PAC' )
, ('PAD' )
, ('PAE' )
, ('PCC' )
, ('PCH' )
, ('PEA' )
, ('PEC' )
, ('PEE' )
, ('PEF' )
, ('PEG' )
, ('PEL' )
, ('PEM' )
, ('PEZ' )
, ('PJA' )
, ('PKA' )
, ('PKB' )
, ('PMP' )
, ('PNE' )
, ('POC' )
, ('POF' )
, ('POG' )
, ('POI' )
, ('PPC' )
, ('PPD' )
, ('PPF' )
, ('PPG' )
, ('PPP' )
, ('PPS' )
, ('PRA' )
, ('PRB' )
, ('PRC' )
, ('PRD' )
, ('PRE' )
, ('PRF' )
, ('PRI' )
, ('PRJ' )
, ('PRK' )
, ('PRL' )
, ('PRQ' )
, ('PRR' )
) A (JobCode)
left join EDI_MDM_Mapping e on a.JobCode = e.EDI --and MDM ='GBU_ALS'
where e.EDI is null


SELECT Year(JDECreatedDate) [Year], Month(JDECreatedDate) [Month], COUNT(*)
FROM 
(SELECT Distinct a.DeliveryTicketNumber, JDECreatedDate

FROM ETLHeader a
	   left join ETLSequence ets on ets.DeliveryTicketNumber = a.DeliveryTicketNumber
	   LEFT JOIN DisJobHistory.dbo.JobPerfv2 j on j.JobNo = CONVERT(VARCHAR(75),a.DeliveryTicketNumber)

	   JOIN EDI_MDM_MAPPING b ON coalesce(a.ProductLineId,ets.ProductLineId) = b.EDI
	   JOIN DisJobHistory.dbo.OrgDataLevel2 c ON b.MDM= c.MDMLevel2Code
	   WHERE c.MDMLevel2Code = 'GBU_ALS'
	   AND a.IsProcessed = 0 and j.JobNo IS NULL
) A
GROUP BY  Year(JDECreatedDate), Month(JDECreatedDate)
order by 1, 2
ROLLBACK TRAN