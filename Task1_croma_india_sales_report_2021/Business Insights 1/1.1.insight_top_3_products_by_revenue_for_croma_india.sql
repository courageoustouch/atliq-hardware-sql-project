-- Business Question 1: Which products generated the most revenue in FY 2021?”
SELECT  
	dp.product AS product_name,
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
GROUP BY dp.product
ORDER BY gross_price_total DESC
LIMIT 3;

/* So, the top 3 products by revenue are 
1. AQ Electron 5 3600 Desktop Processor
2. AQ Wi Power Dx2
3. AQ BZ Allin1
*/