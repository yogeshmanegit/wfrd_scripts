select * into gpactv_11Aug21 from gpcomp1.GPCONT
select * into gpcust_11Aug21 from gpcomp1.gpactv

update gpcomp1.gpcont set email_undeliverable=null ;

DELETE from gpcomp1.gpactv
WHERE activity_id not IN
(
   SELECT min( ACTIVITY_ID ) as actId
    FROM gpcomp1.GPACTV where EMAILID is not null
    GROUP BY EMAILID,custno having count(*)>1
)

and custno+emailId in (

SELECT CUSTNO+EMAILID
    FROM gpcomp1.GPACTV where EMAILID is not null
    GROUP BY EMAILID,custno having count(*)>1
) and CREATED_BY=-1 ;

