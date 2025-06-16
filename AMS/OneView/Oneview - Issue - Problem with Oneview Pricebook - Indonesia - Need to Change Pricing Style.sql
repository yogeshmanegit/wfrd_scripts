DECLARE @conversionRate decimal(18,10)

SELECT @conversionRate = rate FROM CurrencyRate where currencyRateID = (select currencyRateID from Pricebook where id = 696)


select 
	p.name [PriceBookName],
	d.id as PriceBookDataId,
	sdd.id as ServiceDetailId ,
	d.id as PricebookId ,
	d.deleted as IsDeleted,
	sdd.system_id as SystemId,
	sdd.system_code as SystemCode,
	sdd.pricing_style as PricingStyle,
	pss.name as PricingStyleName,
	pss.description as PricingStyleDescription,
	@conversionRate as conversionRate,
	sdd.price * @conversionRate as Price,
	sdd.price * 0.3048 as ConvertedPrice,
	sdd.isBonusable as IsBonusable,
	sdd.discountable as Discountable,
	sdd.thirdPartySystemCode as ThirdPartySystemCode,
	ss.name as Name,
	ss.alternateName as AltName,
	ss.description as Description,
	ss.service_group as ServiceGroup,
	sgg.name as ServiceGroupName,
	sgg.description as ServiceGroupDescription,
	ss.service_type as ServiceType,
	stt.name as ServiceTypeName

FROM PricebookData d 
JOIN Pricebook p on p.id = d.Pricebook_id
JOIN ServiceDetails sdd on d.ServiceDetails_id = sdd.id
JOIN Service ss on sdd.service_id = ss.id
JOIN PricingStyle pss on sdd.pricing_style = pss.id
JOIN ServiceGroup sgg on sgg.id = ss.service_group
JOIN ServiceType stt on stt.id = ss.service_type
where Pricebook_id = 696 and ISNULL(d.deleted,0) = 0
and ss.Service_Type = 26 
ORDER BY ServiceGroupName

--select * from PricingStyle