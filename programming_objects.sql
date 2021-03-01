-- TRIGGERS
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

