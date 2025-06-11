-- Business Question 1: Which markets are driving the majority of our revenue?

WITH cte AS (
	SELECT 
		market, 
		ROUND((SUM(net_sales)/1000000), 2) as ns_mln
	FROM net_sales
	WHERE fiscal_year = 2021
	GROUP BY market
)
SELECT 
	*,
    ns_mln*100/SUM(ns_mln) OVER() AS ns_pct
FROM cte
ORDER BY ns_pct DESC;

/* Insight:
Around 49% of revenue is coming from the top 3 markets - India, USA, South Korea -
out of the total 27 markets */