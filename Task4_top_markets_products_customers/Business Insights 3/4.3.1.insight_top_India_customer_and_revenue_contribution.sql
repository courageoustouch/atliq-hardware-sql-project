-- Business Question 3: Who are our top customers and how reliant are we on them?

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
		ns.market = 'India' AND
		ns.fiscal_year = '2021'
	GROUP BY dc.customer
	ORDER BY net_sales_mln DESC
) 
SELECT 
	*,
    net_sales_mln*100/SUM(net_sales_mln) OVER() net_sales_pct
FROM cte
ORDER BY net_sales_pct DESC;

/*Insight:
Top customers in India are Amazon, AtliQ Exclusive, and Flipkart and they are generating around 31% of revenue from India.
*/