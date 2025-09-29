-- queries.sql
-- Requêtes Window Functions pour l'assignement

------------------------------------------------
-- 1. Ranking Functions : Top produits par région
------------------------------------------------
SELECT region, product_id, product_name, total_revenue, rnk
FROM (
  SELECT c.region,
         p.product_id,
         p.name AS product_name,
         SUM(t.amount) AS total_revenue,
         RANK() OVER (PARTITION BY c.region ORDER BY SUM(t.amount) DESC) AS rnk
  FROM transactions t
  JOIN customers c ON t.customer_id = c.customer_id
  JOIN products p ON t.product_id = p.product_id
  GROUP BY c.region, p.product_id, p.name
)
WHERE rnk <= 5
ORDER BY region, rnk;

------------------------------------------------
-- 2. Aggregate Functions : Totaux cumulés mensuels
------------------------------------------------
SELECT month,
       monthly_sales,
       SUM(monthly_sales) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM (
  SELECT TO_CHAR(sale_date,'YYYY-MM') AS month,
         SUM(amount) AS monthly_sales
  FROM transactions
  GROUP BY TO_CHAR(sale_date,'YYYY-MM')
)
ORDER BY month;

------------------------------------------------
-- 3. Navigation Functions : Croissance mois à mois
------------------------------------------------
SELECT month,
       monthly_sales,
       prev_month_sales,
       ROUND(((monthly_sales - prev_month_sales) / NULLIF(prev_month_sales,0)) * 100,2) AS growth_pct
FROM (
  SELECT month, monthly_sales,
         LAG(monthly_sales) OVER (ORDER BY month) AS prev_month_sales
  FROM (
    SELECT TO_CHAR(sale_date,'YYYY-MM') AS month,
           SUM(amount) AS monthly_sales
    FROM transactions
    GROUP BY TO_CHAR(sale_date,'YYYY-MM')
  )
)
ORDER BY month;

------------------------------------------------
-- 4. Distribution Functions : Segmentation clients
------------------------------------------------
SELECT customer_id, total_spent,
       NTILE(4) OVER (ORDER BY total_spent DESC) AS quartile,
       CUME_DIST() OVER (ORDER BY total_spent DESC) AS cume_dist
       FROM (
  SELECT customer_id, SUM(amount) AS total_spent
  FROM transactions
  GROUP BY customer_id
)
ORDER BY total_spent DESC;
