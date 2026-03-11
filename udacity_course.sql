WITH cte1 AS (SELECT s.name AS rep_name, r.name AS region_name,                       
              SUM(o.total_amt_usd) AS total_sales
              FROM orders AS o
              JOIN accounts AS a
              ON o.account_id = a.id
              JOIN sales_reps AS s
              ON a.sales_rep_id = s.id
              JOIN region AS r
              ON s.region_id = r.id
              GROUP BY rep_name, region_name
),
max_total_sales AS (SELECT c.region_name AS region, c.rep_name AS rep,
                    MAX(c.total_sales) AS max_total_sales
                    FROM cte1 AS c
                    GROUP BY region, rep
                    ORDER BY max_total_sales
)
SELECT m.region, c.rep_name AS rep, m.max_total_sales AS top_sales
FROM max_total_sales AS m
JOIN cte1 AS c
ON m.region = c.region_name AND m.max_total_sales = c.total_sales;


