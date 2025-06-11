/*As a product owner, I want a report for top markets, products, 
customers by net sales for a given financial year so that I can have a holistic view of our financial performance 
and can take appropriate actions to address any potential issues.
We will probably write stored proc for this as we will need this report going forward as well.
*/

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_markets_by_net_sales`(
	in_fiscal_year INT,
    in_top_n INT
)
BEGIN
	SELECT 
		market, 
        ROUND((SUM(net_sales)/1000000), 2) as ns_mln
	FROM net_sales
	WHERE fiscal_year = in_fiscal_year
	GROUP BY market
	ORDER BY ns_mln DESC
	LIMIT in_top_n;
END //
DELIMITER ;