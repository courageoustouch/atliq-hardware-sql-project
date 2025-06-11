-- Business Question 2: Which months had peak sales for each product?

WITH cte1 AS
(
	SELECT 
		fs.date AS mm, 
		dp.product_code AS product_code, 
		dp.product AS product_name, 
		dp.variant AS variant, 
		fs.sold_quantity AS sold_quantity, 
		fgp.gross_price AS gross_price_per_item, 
		ROUND((fs.sold_quantity *  fgp.gross_price), 2) AS gross_price_total
	FROM fact_sales_monthly fs
	JOIN dim_product dp
	ON 
		fs.product_code = dp.product_code 
	JOIN fact_gross_price fgp
	ON 
		fs.product_code = fgp.product_code AND
		get_fiscal_year(fs.date) = fgp.fiscal_year
	WHERE 
		customer_code="90002002" AND
		get_fiscal_year(date) = 2021
		get_fiscal_year(date) = 2021
	ORDER BY mm ASC, gross_price_total DESC
), cte2 AS (
SELECT
	*,
    DENSE_RANK() OVER(PARTITION BY product_code ORDER BY gross_price_total DESC) AS drnk
FROM cte1
) 
SELECT 
	product_code,
    product_name,
    variant,
    mm AS max_sales_month,
    gross_price_total AS max_sales
FROM cte2
WHERE drnk <=1;