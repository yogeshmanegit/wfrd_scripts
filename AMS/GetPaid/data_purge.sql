set Quoted_identifier on


------------- Delete GPPAYABLE_UPLOAD_Details Record
DECLARE @details_id int
select @details_id = MAX(detail_id) from gpcomp1.GPPAYABLE_UPLOAD_DETAIL (NOLOCK) Where CREATED_ON < DATEADD(year, -1, getdate());

SET ROWCOUNT 1000;
DECLARE @i int;
SELECT @i = 1;
    
WHILE @i > 0
BEGIN
    Delete from gpcomp1.GPPAYABLE_UPLOAD_DETAIL Where DETAIL_ID <= @details_id
    SELECT @i = @@rowcount;
END

------- Delete GPPAYABLE_UPLOAD records

DECLARE @upload_id int
select @upload_id = MAX(upload_id) from gpcomp1.GPPAYABLE_UPLOAD (NOLOCK) Where CREATED_ON < DATEADD(year, -1, getdate());
print @upload_id

SELECT @i = 1;
    
WHILE @i > 0
BEGIN
    Delete from gpcomp1.GPPAYABLE_UPLOAD Where upload_id <= @upload_id
    SELECT @i = @@rowcount;
END

GO