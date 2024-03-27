SET NOCOUNT ON;  
  
DECLARE @custno NVARCHAR(40)
  
DECLARE customer_cursor CURSOR FOR   
select * from (values
  (4129110)
, (4130886)) customer(custno)
  
OPEN customer_cursor  

FETCH NEXT FROM customer_cursor   
INTO @custno
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    
	PRINT 'start customer # ' + @custno
    
	IF EXISTS (select * from gpcomp1.GPCUST where CUSTNO = @custno and CRD_LIMIT > 0)
	BEGIN
		
		DECLARE @NewVersionNo int

		SELECT @NewVersionNo = VERSION + 1 from gpcomp1.GPCUST

		UPDATE GPCOMP1.GPCUSTCRDRVWS set MODIFIED_BY= 15614, MODIFIED_ON= GETDATE(), NCRDRVDT= CONVERT(date, getdate()), RVW_TYPE = 0 
		where CUSTNO= @custno and REVIEW_ID = 0
		
		UPDATE gpcomp1.GPSEQ set SEQ = (select max(log_id+1) from gpcomp1.GPCRDLOGS) where SEQID = 'gpcrdlogs_id'

		INSERT INTO GPCOMP1.GPCRDLOGS (Log_ID, CUSTNO, LOG_TYPE, CRD_STATUS, RVWCOMPLETE, RVWDATE, CRDLIMIT, CREATED_ON, CREATED_BY, MODIFIED_ON, MODIFIED_BY, COMMENTS, NRVDT, BALANCE, RISKGRADE, ACTION_DESC)
		VALUES ((select max(log_id) from gpcomp1.GPCRDLOGS),
			@CUSTNO, 
			1, --Log_Type
			'Approved', --CRD_STATUS
			'N', --RVWCOMPLETE
			CONVERT(DATE, getdate()), --RVWDATE
			0, --CRDLIMIT
			GETDATE(), -- CREATED_ON
			15614, -- CREATED_BY
			GETDATE(), -- MODIFIED_ON
			15614, -- MODIFIED_BY
			'', --COMMENTS
			CONVERT(DATE, getdate()), --NRVDT
			0, --BALANCE
			24, --RISKGRADE
			'Credit Limit' --ACTION_DESC
		)

		UPDATE GPCOMP1.GPCUST SET MODIFIED_BY= 15614, MODIFIED_ON= GETDATE(), CRLIDT= CONVERT(DATE, getdate()), CRD_LIMIT= 0, VERSION= @NewVersionNo 
		WHERE CUSTNO = @custno

	END

	FETCH NEXT FROM customer_cursor INTO @custno
END   
CLOSE customer_cursor;  
DEALLOCATE customer_cursor; 

select c.CUSTNO, c.CRD_LIMIT from (values
  (4129110)
, (4130886)
, (4128611)
, (4129039)
, (4130375)
, (4128438)
, (4128605)
, (4130929)
, (4128518)
, (4129553)
, (4131158)
, (4129614)
) customer(custno) 
join gpcomp1.GPCUST c on c.CUSTNO = CONVERT(nvarchar(40), customer.custno)
