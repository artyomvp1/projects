create or replace FUNCTION get_balance (v_customer_id IN NUMBER) RETURN NUMBER
AS
    v_result NUMBER ;

BEGIN
    SELECT balance 
    INTO v_result 
    FROM customer
    WHERE customer_id = v_customer_id ;

    RETURN v_result ;

END ;
