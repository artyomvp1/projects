CREATE SEQUENCE event_log_sq
    MINVALUE 1
    INCREMENT BY 1 ;

-- Track new prices of the books
CREATE OR REPLACE TRIGGER price_control
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

