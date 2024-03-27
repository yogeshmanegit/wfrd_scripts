select cont.custno,cont.contact_type,cust.contact_id from gpcomp1.gpcont cont
join gpcomp1.gpcust cust
on cont.custno=cust.custno
where cont.CONTACT_TYPE=1 and cust.CONTACT_ID is null

-- Update contact_id in GPCUST for Collection contacts if Contact_id is null for type 1 contacts:

update a
set a.contact_id = x.maxId
from gpcomp1.gpcust a
join 
(select custno, max(contact_id) as maxId from gpcomp1.gpcont  group by custno) x on a.custno=x.custno
where a.contact_id is null

--Find out if Contact type is Credit and does not have CRD_Contact_id setup in GPCUST

select cont.custno,cont.contact_type,cust.contact_id from gpcomp1.gpcont cont
join gpcomp1.gpcust cust
on cont.custno=cust.custno
where cont.CONTACT_TYPE=2 and cust.CRD_CONTACT_ID is null

-- Update contact_id in GPCUST for Credit contacts if crd_Contact_id is null for type 2 contacts:

update a
set a. crd_contact_id = x.maxId
from gpcomp1.gpcust a
join 
(select custno, max(contact_id) as maxId from gpcomp1.gpcont where contact_type=2  group by custno) x on a.custno=x.custno
where a. crd_contact_id is null

--Once data is fixed, update all collections and credit contacts to both type 3

update gpcomp1.GPCONT set CONTACT_TYPE=3 where CONTACT_TYPE in (1,2)

