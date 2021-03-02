SELECT sale_id,
       sales_date,
       customer_id,
       total_amount AS current_purchase,
       NVL(LAG(total_amount, 1) OVER(PARTITION BY customer_id ORDER BY sale_id), 0) AS previous_purchase,
       NVL(SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY sale_id ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING), 0) AS last_three_purchases
       
FROM sales 
WHERE sales_date >= TO_DATE('01-JAN-2020', 'dd-mm-yyyy')
  AND sales_date <  TO_DATE('01-JAN-2021', 'dd-mm-yyyy')
  
ORDER BY 1 
;