WITH cte AS 
(
	SELECT 
		dc.customer, 
		ROUND(SUM(ns.net_sales)/1000000, 2) as net_sales_mln
	FROM net_sales ns
	JOIN dim_customer dc
	ON 
		ns.customer_code = dc.customer_code
	WHERE 
		ns.fiscal_year = '2021'
	GROUP BY dc.customer
)
SELECT 
	customer,
    ROUND(net_sales_mln*100/SUM(net_sales_mln) OVER(), 2) AS net_sales_pct
FROM cte
ORDER BY net_sales_pct DESC;