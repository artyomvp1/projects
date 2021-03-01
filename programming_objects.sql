/* TRIGGERS */
CREATE SEQUENCE event_log_sq -- SEQUENCE
    MINVALUE 1
    INCREMENT BY 1 ;

CREATE OR REPLACE TRIGGER price_control -- price change trigger
    AFTER UPDATE
    OF price
    ON book
    FOR EACH ROW
    WHEN (NEW.price != OLD.price)
DECLARE
    v_user VARCHAR2(30) ;
BEGIN
    SELECT user
    INTO v_user
    FROM DUAL ;
    
    INSERT INTO event_log
        VALUES(event_log_sq.NEXTVAL, SYSTIMESTAMP, v_user, 'BOOK', :NEW.price, :OLD.price, 
               'BOOK_ID: ' || :OLD.book_id || '(' || :OLD.book_name || '), price has been changed to ' || :NEW.price) ;
END ;
/

CREATE OR REPLACE TRIGGER balance_change -- balance change trigger
    AFTER UPDATE
    OF balance
    ON customer 
    FOR EACH ROW
    WHEN (NEW.balance != OLD.balance)  
DECLARE
    v_user VARCHAR2(30) ;
BEGIN
    SELECT user
    INTO v_user
    FROM DUAL ;
    
    INSERT INTO event_log
        VALUES(event_log_sq.NEXTVAL, SYSTIMESTAMP, v_user, 'CUSTOMER', :NEW.balance, :OLD.balance, 
               'CUSTOMER_ID: ' || :OLD.customer_id || ', balance has been changed to ' || :NEW.balance) ;             
END ;
/

/* PROCEDURES */
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

