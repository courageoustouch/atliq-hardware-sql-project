-- Business Question 1: Which markets should we focus on to improve forecast reliability?

WITH cte1 AS (
		SELECT 
			customer_code,
			SUM(sold_quantity) AS total_sold_quantity,
			SUM(forecast_quantity) AS total_forecast_quantity,
			SUM(forecast_quantity-sold_quantity) AS net_err,
			SUM(forecast_quantity-sold_quantity)*100/SUM(forecast_quantity) AS net_err_pct,
			SUM(ABS(forecast_quantity-sold_quantity)) AS abs_net_err,
			SUM(ABS(forecast_quantity-sold_quantity))*100/SUM(forecast_quantity) AS abs_net_err_pct
		FROM fact_act_est
		WHERE fiscal_year = '2021'
		GROUP BY customer_code
), cte2 AS (
		SELECT 
			c1.customer_code AS customer_code,
			dc.customer AS customer_name,
			dc.market AS market,
			c1.total_sold_quantity AS total_sold_quantity,
			c1.total_forecast_quantity AS total_forecast_quantity,
			c1.net_err AS net_error,
			c1.net_err_pct AS net_error_pct,
			c1.abs_net_err AS abs_net_error,
			c1.abs_net_err_pct AS abs_net_error_pct,
			IF(c1.abs_net_err_pct > 100, 0, 100-c1.abs_net_err_pct) AS forecast_accuracy
		FROM cte1 c1
		JOIN dim_customer dc
		ON 
			c1.customer_code = dc.customer_code
		ORDER BY forecast_accuracy DESC
	)
SELECT 
	market,
    ROUND(AVG(forecast_accuracy), 2) AS avg_forecast_accuracy
FROM cte2
GROUP BY market
ORDER BY avg_forecast_accuracy ASC;

-- Netherlands, South Korea and Sweden have the lowest forecast accuracy and hence should be in our focus to improve forecast reliability.