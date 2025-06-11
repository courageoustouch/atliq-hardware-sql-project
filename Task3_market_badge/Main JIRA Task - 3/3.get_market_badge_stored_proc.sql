DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge`(
	IN in_market VARCHAR(50),
    IN in_fiscal_year INT,
    OUT out_market_badge VARCHAR(50)
)
BEGIN
	#setting default quantity 
    DECLARE total_sold_quantity INT DEFAULT 0;
    
    # setting default market
    IF in_market = "" THEN
		SET in_market = "India";
	END IF;
    
	SELECT SUM(sold_quantity) INTO total_sold_quantity
	FROM fact_sales_monthly fs
	JOIN dim_customer dc
	ON
		fs.customer_code = dc.customer_code
	WHERE 
		dc.market = in_market AND
		get_fiscal_year(fs.date) = in_fiscal_year
	GROUP BY dc.market;
    
    IF total_sold_quantity > 5000000 THEN
		SET out_market_badge = "Gold";
	ELSE
		SET out_market_badge = "Silver";
	END IF;
END //
DELIMITER ;
