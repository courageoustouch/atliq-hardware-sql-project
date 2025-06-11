/*JIRA Task 6:
As a product owner, I want to see region wise % net sales breakdown by customers in a respective region so that
I can perform my regional analysis on financial performance of the company. The end result should be in form of pie charts for 
each region. Build resuable asset */

WITH cte AS
(
	SELECT 
		dc.customer, 
		dc.region,
		ROUND(SUM(ns.net_sales)/1000000, 2) net_sales_mln
	FROM net_sales ns
	JOIN dim_customer dc
	ON
		ns.customer_code = dc.customer_code
	WHERE 
		ns.fiscal_year = '2021'
	GROUP BY dc.customer, dc.region
	ORDER BY dc.region ASC, net_sales_mln DESC
)
SELECT 
	customer,
    region,
    net_sales_mln,
    ROUND(net_sales_mln*100/SUM(net_sales_mln) OVER(PARTITION BY region), 2) AS net_sales_pct
FROM cte
ORDER BY 
	region ASC,
	net_sales_pct DESC;
