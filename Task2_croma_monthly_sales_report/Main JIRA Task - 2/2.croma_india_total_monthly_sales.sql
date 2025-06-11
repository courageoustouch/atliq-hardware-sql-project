/* JIRA Task 2: 
Gross monthly total sales report for Croma
Description
As a product owner, I need an aggregate monthly gross sales report for Croma India customer so that I can track how much sales this particular customer is generating for AtliQ and manage our relationships accordingly.
The report should have the following fields,
1. Month
2. Total gross sales amount to Croma India in this month
*/

SELECT 
	fs.date, 
    ROUND(SUM(fs.sold_quantity*fgp.gross_price), 2) AS gross_sales_amount
FROM fact_sales_monthly fs
JOIN fact_gross_price fgp
ON 
	fs.product_code = fgp.product_code AND 
    get_fiscal_year(fs.date) = fgp.fiscal_year
WHERE 
	customer_code = "90002002"
GROUP BY fs.date;