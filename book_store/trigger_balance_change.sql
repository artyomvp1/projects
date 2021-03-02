CREATE OR REPLACE TRIGGER balance_change
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
