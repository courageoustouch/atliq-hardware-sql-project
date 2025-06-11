-- Business Question 2: Are there markets close to becoming Gold that we should target for growth?

WITH cte1 AS
(
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
), cte2 AS (
	SELECT
		*,
        IF(total_sold_qty > 5000000, "Gold", "Silver") AS market_badge
	FROM cte1
    ORDER BY total_sold_qty DESC
)
SELECT
	*
FROM cte2
WHERE market_badge = "Silver"
LIMIT 3;

/*Market closest to becoming Gold is South Korea
but even that is lagging behind by roughly 1 million */