SELECT c.CUSTNO, CONTACT_TYPE 
from gpcomp1.GPCONT c
JOIN gpcomp1.GPCUST cust on c.CONTACT_ID = cust.CONTACT_ID
where CONTACT_TYPE = 2

SELECT c.CUSTNO, CONTACT_TYPE 
from gpcomp1.GPCONT c
JOIN gpcomp1.GPCUST cust on c.CONTACT_ID = cust.CRD_CONTACT_ID
where CONTACT_TYPE = 1

-- In order to display same contact in both credit & collection, it has to be set as contact type = 3
-- and it must be set in both CONTACT_ID & CRD_CONTACT_ID fields
select CONTACT_ID, -- contact id is set when contact type is [1 - collection or 3 - credit & collection both]
--MAIN_CONTACT_ID, 
CRD_CONTACT_ID, -- contact id is set when contact type is [2 - credit or 3 - credit & collection both]
--CRD_MAIN_CONTACT_ID, 
* from gpcomp1.GPCUST where CUSTNO ='GPCMM1321'

select * from gpcomp1.GPCONT where CUSTNO ='GPCMM1321'
select CONTACT_ID, CRD_CONTACT_ID  from gpcomp1.GPCUST where CUSTNO ='GPCMM1321'

UPDATE gpcomp1.GPCONT SET CONTACT_TYPE = 3 where CUSTNO ='GPCMM1321'
UPDATE gpcomp1.GPCUST SET CONTACT_ID = 66998, CRD_CONTACT_ID = 66998 where CUSTNO ='GPCMM1321'