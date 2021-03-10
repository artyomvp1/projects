create or replace FUNCTION get_price (v_book_id IN NUMBER) RETURN NUMBER
AS
    v_result NUMBER ;
BEGIN
    SELECT price
    INTO v_result
    FROM book
    WHERE book_id = v_book_id ;

    RETURN v_result ;
END ;
