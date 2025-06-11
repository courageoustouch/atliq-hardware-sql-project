-- Business Question 1: Which markets are our top performers based on sales volume?

SELECT 
	dc.market,
	SUM(fs.sold_quantity) AS total_sold_qty
FROM fact_sales_monthly fs
JOIN dim_customer dc
ON
	fs.customer_code = dc.customer_code
WHERE
	get_fiscal_year(fs.date) = 2021
GROUP BY dc.market
ORDER BY total_sold_qty DESC;

/*Insight: Top 3 markets based on sales volume -
1. India
2. USA
3. South Korea
*/