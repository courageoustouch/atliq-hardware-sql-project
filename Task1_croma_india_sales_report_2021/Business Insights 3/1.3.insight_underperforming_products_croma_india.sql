-- Business Question 3: Are any products consistently underperforming?”
WITH cte1 AS (
	SELECT  
		fs.date AS mm,
		dp.product AS product_name,
		ROUND(SUM(fs.sold_quantity *  fgp.gross_price), 2) as gross_price_total
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
	GROUP BY mm, product_name
), cte2 AS (
	SELECT 
		*,
        DENSE_RANK() OVER(PARTITION BY mm ORDER BY gross_price_total ASC) AS drnk
	FROM cte1
)
SELECT 
	mm,
    product_name AS lowest_selling_product_name,
    gross_price_total AS sales_amount
FROM cte2
WHERE drnk <= 1;

/* So the products that tend to make lowest sales every month for croma India are:
1. AQ LION x1
2. AQ Pen Drive 2 IN 1
*/
