/* Task 1:
As a product owner, I want to generate a report of individual product sales (aggregated on a monthly basis at the product level) for Croma India customers for FY-2021 so that I can track individual product sales and run further product analytics on it in excel.
The report should have the following fields.
1. Month
2. Product Name & Variant
3. Sold Quantity
4. Gross Price Per Item
5. Gross Price Total
*/

SELECT 
	fs.date AS month, 
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
ORDER BY month ASC, gross_price_total DESC;