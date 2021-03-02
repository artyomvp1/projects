CREATE OR REPLACE PROCEDURE cashback (start_date DATE,
                                      end_date DATE,
                                      threshold NUMBER,
                                      cashback_percent NUMBER
                                      )
AS
    v_rec1 sales.customer_id%TYPE ;
    v_rec2 customer.balance%TYPE ;
    v_rec3 NUMBER ;
    v_cur SYS_REFCURSOR ;
    
BEGIN
    OPEN v_cur FOR
        SELECT s.customer_id, 
               balance,
               SUM(total_amount) AS total_amount
         FROM sales s
         LEFT JOIN customer c ON c.customer_id = s.customer_id
         WHERE sales_date >= start_date
           AND sales_date <  end_date
         GROUP BY s.customer_id, balance
         HAVING SUM(total_amount) >= threshold ;
         
    LOOP
        FETCH v_cur INTO v_rec1, v_rec2, v_rec3 ;
        EXIT WHEN v_cur%NOTFOUND ;
            UPDATE customer
            SET balance = v_rec2 + v_rec3 * cashback_percent / 100
            WHERE customer_id = v_rec1 ;
    END LOOP ;
    
    CLOSE v_cur ;
    
    COMMIT ;  
END ;
/

