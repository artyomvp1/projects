WITH x AS (SELECT s.customer_id,
                  SUBSTR(first_name, 1, 1) || '. ' || last_name AS full_name,
                  total_amount,
                  PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY total_amount) OVER(PARTITION BY s.customer_id) AS median_value
                  
            FROM sales s
            LEFT JOIN customer c ON c.customer_id = s.customer_id
            )

SELECT customer_id,
       full_name,
       COUNT(customer_id) AS books_bought,
       TO_CHAR(SUM(total_amount), '$9,999.99') AS spent,
       median_value
       
FROM x 
WHERE median_value >= 10

GROUP BY customer_id,
         full_name,
         median_value
HAVING COUNT(customer_id) > 5

ORDER BY 1 ;