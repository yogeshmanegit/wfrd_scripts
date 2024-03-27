SELECT * 
FROM 
(select co.CUSTNO, co.CONTACT_ID, co.TITLE, co.FIRSTNAME, co.LASTNAME, co.ADDRESS1, co.ADDRESS2, co.ADDRESS3, co.CITY, co.STATE, co.ZIP,
CASE WHEN c.MAIN_CONTACT_ID = co.CONTACT_ID THEN 1 ELSE 0 END [Main],
CASE WHEN c.CONTACT_ID = co.CONTACT_ID THEN 1 ELSE 0 END [Active],
TEAM,
portfolio.COLLCODE [portfolio],
portfolio.COLLNAME [portfolio name]
FROM gpcomp1.GPCUST c (NOLOCK)
join gpcomp1.GPCOLL portfolio (NOLOCK) on c.TERR = portfolio.COLLCODE
left join gpcomp1.GPCONT co (NOLOCK) on c.custno = co.custno
WHERE c.INACTIVE ='N' and portfolio.TEAM = 'USA'
) c
WHERE (Main = 1 OR Active = 1)

-- take all active customers
-- Main & Active
-- For US only