SELECT SUM(Amount) [Amount]
FROM (
select sum(amount) as Amount from gpcomp1.GPRECL (NOLOCK) where rclDate >= '2021-06-01' AND rclDate <= '2021-06-30' and PROMISED ='Y'
UNION
select sum(amount) from gpcomp1.GPRECLLog (NOLOCK) where rclDate >= '2021-06-01' AND rclDate <= '2021-06-30' and PROMISED ='Y'
) A

--SELECT SUM(e.amount) All promised invoices from GPRECL and GPRECLLOG where rclDate >= startDate AND rclDate <= endDate of the period + Filter
