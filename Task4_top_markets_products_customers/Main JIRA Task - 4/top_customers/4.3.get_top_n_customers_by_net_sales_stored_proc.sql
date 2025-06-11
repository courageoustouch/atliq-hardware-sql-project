/*JIRA Task 4:
As a product owner, I want a report for top markets, products, customers by net sales for a given financial year 
so that I can have a holistic view of our financial performance and can take appropriate actions to address any potential issues.
We will probably write stored proc for this as we will need this report going forward as well.
*/

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_customers_by_net_sales`(
	in_market VARCHAR(80),
	in_fiscal_year INT,
    in_top_n INT
)
BEGIN
	SELECT 
		dc.customer,
		ROUND(SUM(ns.net_sales)/1000000, 2) as net_sales_mln
	FROM net_sales ns
	JOIN dim_customer dc
	ON 
		ns.customer_code = dc.customer_code
	WHERE 
		ns.market = in_market AND
		ns.fiscal_year = in_fiscal_year
	GROUP BY dc.customer
	ORDER BY net_sales_mln DESC
	LIMIT in_top_n;
END //
DELIMITER ;
