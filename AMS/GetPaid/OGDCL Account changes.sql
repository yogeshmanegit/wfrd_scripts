--UPDATE gpcomp1.GPCUST SET INACTIVE = 0 where CUSTNO ='3517308'
--delete from gpcomp1.ARCONSOLIDATOR where MAIN_NO = '2399400' and AFFILIATE_NO ='3517308'

select PARENT, * from gpcomp1.GPCUST where CUSTNO IN( '1779675', '4307770')
select * from gpcomp1.ARCONSOLIDATOR where AFFILIATE_NO IN ('1779675', '4307770')

select * from gpcomp1.GPRECL where CUSTNO ='2006416'

select * from gpcomp1.GPRECLLOG where CUSTNO ='4307770'
select * from gpcomp1.GPRECLLOG where CUSTNO ='1779675'
select * from gpcomp1.GAEXPORT where CUSTNO ='1779675'
select * from gpcomp1.GPPROBLOG where PROBLEM_ID =271918

select * from gpcomp1.GPCONT where CONTACT_ID ='3657'

select * from gpcomp1.GPDISPUTE_ITEM where CUSTNO = '2006416'
select * from gpcomp1.GPPROB where PROBLEM_ID = 286056
select * from gpcomp1.GPPROBLOG where PROBLEM_ID =286056
select top 10 * from gpcomp1.GPPROBNOTES where PROB_ID = 286056