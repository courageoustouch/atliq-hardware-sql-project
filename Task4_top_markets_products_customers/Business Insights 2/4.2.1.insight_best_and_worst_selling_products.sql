-- Business Question 2: Which products are our bestsellers and which ones are underperforming?

SELECT 
	dp.product, 
    ROUND(SUM(net_sales)/1000000, 2) AS net_sales_mln
FROM net_sales ns
JOIN dim_product dp
ON
	ns.product_code = dp.product_code
WHERE
	ns.fiscal_year = 2021 
GROUP BY dp.product
ORDER BY net_sales_mln ASC;

/*Insight:
Best Selling products:
1. AQ BZ Allin1
2. AQ Qwerty
3. AQ Trigger

Worst Selling products:
1. AQ LION x1
2. AQ Pen Drive 2 IN 1
3. AQ LION x2
*/