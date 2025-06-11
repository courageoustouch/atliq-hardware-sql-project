-- Business Question 2: Which months are peak vs. low for Croma India’s purchases?

WITH cte AS
(
	SELECT 
		fs.date,
		MONTH(fs.date) AS mm,
		ROUND(SUM(fs.sold_quantity*fgp.gross_price), 2) AS gross_sales_amount
	FROM fact_sales_monthly fs
	JOIN fact_gross_price fgp
	ON 
		fs.product_code = fgp.product_code AND 
		get_fiscal_year(fs.date) = fgp.fiscal_year
	WHERE 
		customer_code = "90002002"
	GROUP BY fs.date
	ORDER BY fs.date ASC
)
SELECT 
	mm,
    SUM(gross_sales_amount) AS total_gross_sales_amount
FROM cte
GROUP BY mm
ORDER BY total_gross_sales_amount ASC;

/*Insights:
Low Month: May
Peak Month: Dec
*/