-- Business Question 1: Which products are the most in-demand within each division?

WITH cte2 AS
	(
		WITH cte1 AS
		(
			SELECT 
				dp.division,
				dp.product,
				SUM(ns.sold_quantity) as total_sold_quantity
			FROM net_sales ns
			JOIN dim_product dp
			ON 
				ns.product_code = dp.product_code
			WHERE 
				ns.fiscal_year = '2021'
			GROUP BY dp.division, dp.product
			ORDER BY dp.division ASC, total_sold_quantity DESC
		)
		SELECT 
			*,
			dense_rank() over(partition by division order by total_sold_quantity DESC) as drnk
		FROM cte1
	)
	SELECT 
		division, 
		product, 
		total_sold_quantity
	FROM cte2 
	WHERE drnk <=3
	ORDER BY 
		division ASC, 
		total_sold_quantity DESC;