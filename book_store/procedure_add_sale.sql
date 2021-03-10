create or replace PROCEDURE add_sale(v_customer_id IN NUMBER,
                                     v_book_id IN NUMBER,
                                     v_warehouse_id IN NUMBER )
AS
    v_balance NUMBER ;
    v_price NUMBER ;
    v_tax NUMBER ;
    v_exp EXCEPTION ;
BEGIN
    SELECT get_balance(v_customer_id)
    INTO v_balance 
    FROM DUAL ;

    SELECT get_price(v_book_id)
    INTO v_price 
    FROM DUAL ;

    IF v_balance >= v_price THEN
        UPDATE customer
        SET balance = v_balance - v_price 
        WHERE customer_id = v_customer_id ;

        INSERT INTO sales
            VALUES(sales_sq.NEXTVAL, SYSDATE, NULL, v_customer_id, v_book_id, v_warehouse_id, v_price, ROUND(v_price/10, 2), v_price + ROUND(v_price/10, 2)) ; 
        COMMIT ;

    ELSE
        RAISE v_exp ;

    END IF ;
EXCEPTION 
    WHEN v_exp THEN
        DBMS_OUTPUT.PUT_LINE('Balance error') ;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ': ' || SQLERRM) ;
END ;
