-- Business Question 1: How is Croma India’s monthly gross sales trending over the fiscal year?

SELECT 
	fs.date, 
    get_fiscal_year(fs.date) AS fiscal_year,
    ROUND(SUM(fs.sold_quantity*fgp.gross_price), 2) AS gross_sales_amount
FROM fact_sales_monthly fs
JOIN fact_gross_price fgp
ON 
	fs.product_code = fgp.product_code AND 
    get_fiscal_year(fs.date) = fgp.fiscal_year
WHERE 
	customer_code = "90002002"
GROUP BY fs.date
ORDER BY fs.date ASC;