CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
	in_fiscal_year INT
)
BEGIN
	WITH cte AS (
		SELECT 
			customer_code,
			SUM(sold_quantity) AS total_sold_quantity,
			SUM(forecast_quantity) AS total_forecast_quantity,
			SUM(forecast_quantity-sold_quantity) AS net_err,
			SUM(forecast_quantity-sold_quantity)*100/SUM(forecast_quantity) AS net_err_pct,
			SUM(ABS(forecast_quantity-sold_quantity)) AS abs_net_err,
			SUM(ABS(forecast_quantity-sold_quantity))*100/SUM(forecast_quantity) AS abs_net_err_pct
		FROM fact_act_est
		WHERE fiscal_year = in_fiscal_year
		GROUP BY customer_code
	)
	SELECT 
		c.customer_code AS customer_code,
		dc.customer AS customer_name,
		dc.market AS market,
		c.total_sold_quantity AS total_sold_quantity,
		c.total_forecast_quantity AS total_forecast_quantity,
		c.net_err AS net_error,
		c.net_err_pct AS net_error_pct,
		c.abs_net_err AS abs_net_error,
		c.abs_net_err_pct AS abs_net_error_pct,
		IF(c.abs_net_err_pct > 100, 0, 100-c.abs_net_err_pct) AS forecast_accuracy
	FROM cte c
	JOIN dim_customer dc
	ON 
		c.customer_code = dc.customer_code
	ORDER BY forecast_accuracy DESC;
END