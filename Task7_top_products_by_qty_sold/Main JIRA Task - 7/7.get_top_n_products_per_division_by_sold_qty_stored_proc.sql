/*JIRA Task 7:
Write a stored procedure for getting top n products in each division by their quantity sold in a given fiscal year */

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products_per_division_by_sold_qty`(
	in_fiscal_year INT,
    in_top_n INT
)
BEGIN
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
				ns.fiscal_year = in_fiscal_year
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
	WHERE drnk <=in_top_n
	ORDER BY 
		division ASC, 
		total_sold_quantity DESC;
END //
DELIMITER ;