-- Business Question 2: How does product performance vary across divisions?
-- 2021
SELECT 
	dp.division,
	SUM(ns.sold_quantity) as total_sold_quantity
FROM net_sales ns
JOIN dim_product dp
ON 
	ns.product_code = dp.product_code
WHERE 
	ns.fiscal_year = '2021'
GROUP BY dp.division
ORDER BY total_sold_quantity;

-- 2020
SELECT 
	dp.division,
	SUM(ns.sold_quantity) as total_sold_quantity
FROM net_sales ns
JOIN dim_product dp
ON 
	ns.product_code = dp.product_code
WHERE 
	ns.fiscal_year = '2020'
GROUP BY dp.division
ORDER BY total_sold_quantity;

-- 2019
SELECT 
	dp.division,
	SUM(ns.sold_quantity) as total_sold_quantity
FROM net_sales ns
JOIN dim_product dp
ON 
	ns.product_code = dp.product_code
WHERE 
	ns.fiscal_year = '2019'
GROUP BY dp.division
ORDER BY total_sold_quantity;