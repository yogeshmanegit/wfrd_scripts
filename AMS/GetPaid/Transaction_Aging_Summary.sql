SELECT T1.*,
       CASE T2.total_account_amount
         WHEN 0 THEN 0
         ELSE ( ( T1.amount11 * 100 ) / T2.total_account_amount )
       END AS PERCENTAGE
FROM   (SELECT Isnull(C.custno, '')     AS "KEY1",
               Max(C.company)           AS "KEY_CODE_DESCRIPTION",
               Isnull(C.custno, ' ')    SUB_KEY_CODE,
               Max(C.company)           AS "SUB_KEY_CODE_DESCRIPTION",
               ' '                      SUB_SUB_KEY_CODE,
               ' '                      AS "SUB_SUB_KEY_CODE_DESCRIPTION",
               Max(TCTRL.description)   TRANDESC,
               Max(CP.country_code)     COUNTRY_CODE,
               Max(CP.country_name)     COUNTRY_NAME,
               ' '                      UPARENT_NAME,
               ' '                      PARENT_NAME,
               Max(C.company)           COMPANY,
               Sum(R.amount)            AS TOTAL_AMOUNT,
               Sum(CASE Sign(Datediff(day, R.duedate, Getdate()))
                     WHEN 0 THEN 0
                     WHEN 1 THEN 0
                     ELSE ( CASE Sign(Datediff(day, R.duedate, Getdate())) -
                                 Sign(
                                          Datediff(day, R.duedate, Getdate())
                                          - ( -60 )
                                 )
                              WHEN 0 THEN R.amount
                              ELSE 0
                            END )
                   END)                 AMOUNT1,
               Sum(CASE Sign(Datediff(day, R.duedate, Getdate()) - ( -60 - 1 ))
                        - Sign(
                            Datediff(day, R.duedate, Getdate
                            ()) - ( -30 - 1 )) *
                            Sign(
                                 Datediff(day, R.duedate, Getdate()) -
                                 ( -60 - 1 ))
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 NEG_AMOUNT1,
               Sum(CASE Sign(Datediff(day, R.duedate, Getdate()) - ( -30 - 1 ))
                        - Sign(
                            Datediff(day, R.duedate, Getdate
                            ()) - ( -15 - 1 )) *
                            Sign(
                                 Datediff(day, R.duedate, Getdate()) -
                                 ( -30 - 1 ))
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 NEG_AMOUNT2,
               Sum(CASE Sign(Datediff(day, R.duedate, Getdate()) - ( -15 - 1 ))
                        - Sign(
                            Datediff(day, R.duedate, Getdate
                            ()) - ( -7 - 1 )) * Sign(
                                 Datediff(day, R.duedate,
                        Getdate()) - ( -15 - 1 ))
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 NEG_AMOUNT3,
               Sum(CASE Sign(Datediff(day, R.duedate, Getdate()) - ( -7 - 1 ))
                        - Sign(
                            Datediff(day, R.duedate, Getdate(
                            )) - ( -3 - 1 )) *
                            Sign(
                                 Datediff(day, R.duedate, Getdate()) - ( -7 - 1
                                 ))
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 NEG_AMOUNT4,
               Sum(CASE Sign(Datediff(day, R.duedate, Getdate()))
                     WHEN 0 THEN R.amount
                     ELSE ( CASE Sign(Datediff(day, R.duedate, Getdate()) - ( -3
                                      - 1 ))
                                 - Sign(
                                          Datediff(day, R.duedate,
                                          Getdate())) * Sign(
                                               Datediff(day, R.duedate, Getdate(
                                               )) - (
                                               -3 - 1 )
                                                        )
                              WHEN 1 THEN R.amount
                              WHEN 2 THEN R.amount
                              ELSE 0
                            END )
                   END)                 NEG_AMOUNT5,
               Sum(CASE Sign(Datediff(day, R.duedate, Getdate()))
                     WHEN 0 THEN 0
                     ELSE ( CASE ( Sign(Datediff(day, R.duedate, Getdate()))
                                   - Sign(
                                                 Datediff(day, R.duedate,
                                                 Getdate())
                                                 - 15) )
                              WHEN 1 THEN R.amount
                              WHEN 2 THEN R.amount
                              ELSE 0
                            END )
                   END)                 AMOUNT2,
               Sum(CASE ( Sign(Datediff(day, R.duedate, Getdate()) - 15) - Sign(
                                   Datediff(day, R.duedate, Getdate()) - 30) ) *
                        Sign(
                            Datediff(day, R.duedate, Getdate()) - 15)
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 AMOUNT3,
               Sum(CASE ( Sign(Datediff(day, R.duedate, Getdate()) - 30) - Sign(
                                   Datediff(day, R.duedate, Getdate()) - 45) ) *
                        Sign(
                            Datediff(day, R.duedate, Getdate()) - 30)
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 AMOUNT4,
               Sum(CASE ( Sign(Datediff(day, R.duedate, Getdate()) - 45) - Sign(
                                   Datediff(day, R.duedate, Getdate()) - 60) ) *
                        Sign(
                            Datediff(day, R.duedate, Getdate()) - 45)
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 AMOUNT5,
               Sum(CASE ( Sign(Datediff(day, R.duedate, Getdate()) - 60) - Sign(
                                   Datediff(day, R.duedate, Getdate()) - 90) ) *
                        Sign(
                            Datediff(day, R.duedate, Getdate()) - 60)
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 AMOUNT6,
               Sum(CASE ( Sign(Datediff(day, R.duedate, Getdate()) - 90) - Sign(
                                   Datediff(day, R.duedate, Getdate()) - 120) )
                        * Sign(
                            Datediff(day, R.duedate, Getdate()) - 90)
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 AMOUNT7,
               Sum(CASE ( Sign(Datediff(day, R.duedate, Getdate()) - 120) - Sign
                          (
                                   Datediff(day, R.duedate, Getdate()) - 150) )
                        * Sign(
                            Datediff(day, R.duedate, Getdate()) - 120)
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 AMOUNT8,
               Sum(CASE ( Sign(Datediff(day, R.duedate, Getdate()) - 150) - Sign
                          (
                                   Datediff(day, R.duedate, Getdate()) - 365) )
                        * Sign(
                            Datediff(day, R.duedate, Getdate()) - 150)
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 AMOUNT9,
               Sum(CASE ( Sign(Datediff(day, R.duedate, Getdate()) - 365) - Sign
                          (
                                   Datediff(day, R.duedate, Getdate()) - 9999) )
                        *
                            Sign(Datediff(day, R.duedate, Getdate()) - 365)
                     WHEN 1 THEN R.amount
                     WHEN 2 THEN R.amount
                     ELSE 0
                   END)                 AMOUNT10,
               Sum(R.amount) - Sum(CASE Sign(Datediff(day, R.duedate, Getdate())
                                        )
                                     WHEN -1 THEN R.amount
                                     WHEN 0 THEN R.amount
                                     ELSE 0
                                   END) AMOUNT11,
               Count(R.tran_id)         NO_OF_TRANS,
               ' '                      TRAN_CURR_VAL
        FROM   gpcomp1.gptrctrl TCTRL,
               gpcomp1.gprecl R
               LEFT OUTER JOIN gpcomp1.gpprob PR ON R.tran_id = PR.open_invoice_tran_id
               LEFT OUTER JOIN gpcomp1.gpprob P ON P.problem_id = PR.problem_id,
               gpcomp1.gpcust C 
			   LEFT OUTER JOIN gpglobal.gpcountry CP ON ( CP.country_code = C.country )
        WHERE  R.custno = C.custno
               AND R.trantype = TCTRL.trantype
               AND ( R.trantype IN ( 'B', 'C', 'D', 'F',
                                     'I', 'O', 'U', ' ' ) )
        GROUP  BY C.custno,
                  C.custno) T1,
       (SELECT Sum(R.amount)         AS TOTAL_ACCOUNT_AMOUNT,
               Isnull(C.custno, ' ') AS "KEY1"
        FROM   gpcomp1.gprecl R,
               gpcomp1.gpcust C
        WHERE  R.custno = C.custno
               AND ( R.trantype IN ( 'B', 'C', 'D', 'F',
                                     'I', 'O', 'U', ' ' ) )
        GROUP  BY C.custno) T2
WHERE  T1.key1 = T2.key1
ORDER  BY t1.key1 