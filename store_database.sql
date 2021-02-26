/*
TABLES (sales, customers, log, views, aggregate)
TRIGGERS
INDEXES
SEQUENCES
PROCEDURES 
JOB
*/

-- Creating sequences for all tables
DECLARE
    TYPE c_type IS TABLE OF VARCHAR2(20) ;
    v_collection c_type := c_type('customer_sq', 'product_sq', 'sales_sq', 'event_log_sq1') ;
    
    v_sql VARCHAR2(100) ;
    
BEGIN
    FOR i IN v_collection.FIRST .. v_collection.LAST
    LOOP    
        v_sql := 'CREATE SEQUENCE ' || v_collection(i) || ' MINVALUE 1 INCREMENT BY 1' ;
        EXECUTE IMMEDIATE v_sql ;
    
    END LOOP ;
    
END ;

-- Create tables 
CREATE TABLE customer (customer_id NUMBER,
                       create_date DATE,
                       first_name  VARCHAR2(30),
                       last_name VARCHAR2(30),
                       deposit NUMBER,
                       CONSTRAINT pk_customer PRIMARY KEY(customer_id),
                       CONSTRAINT ch_customer_fn CHECK(REGEXP_LIKE(first_name, '[A-z]+')),
                       CONSTRAINT ch_customer_ln CHECK(REGEXP_LIKE(first_name, '[A-z]+'))
                       ) ;

CREATE TABLE product (product_id NUMBER,
                       create_date DATE,
                       product_name VARCHAR2(30),
                       product_code CHAR(3),
                       price_amount NUMBER,
                       commentary CLOB,
                       CONSTRAINT pk_product PRIMARY KEY(product_id),
                       CONSTRAINT ch_product_pn CHECK(REGEXP_LIKE(product_name, '[A-z]+')),
                       CONSTRAINT ch_product_pc CHECK(REGEXP_LIKE(product_code, '[A-Z][A-Z0-9][A-Z0-9]')),
                       CONSTRAINT u_product_pc UNIQUE(product_code)
                       ) ;
                    
CREATE TABLE sales (sale_id NUMBER, 
                    sales_date DATE, 
                    customer_id NUMBER, 
                    product_id NUMBER, 
                    price_amount NUMBER, 
                    tax_amount NUMBER,
                    total_amount NUMBER,
                    commision NUMBER,
                    CONSTRAINT pk_sales PRIMARY KEY(sale_id),
                    CONSTRAINT fk_sales_cid FOREIGN KEY(customer_id) REFERENCES customer.customer_id
                    ) ;

CREATE TABLE event_cat (e_id NUMBER,
                        event_type NUMBER,
                        commentary CLOB,
                        CONSTRAINT pk_event_cat PRIMARY KEY(e_id)
                        ) ;

CREATE TABLE event_log (event_id NUMBER,
                        event_date DATE,
                        user_id VARCHAR2(30),
                        object_id VARCHAR2(30),
                        event_code NUMBER, 
                        commentary CLOB,
                        CONSTRAINT pk_event_log PRIMARY KEY(event_id),
                        CONSTRAINT fk_event_log_ec FOREIGN KEY(event_code) REFERENCES event_cat.event_type
                        ) ;
                        
-- Trigger control 
CREATE OR REPLACE TRIGGER customer_control
    AFTER UPDATE
    ON customer
    
DECLARE
    v_user VARCHAR2(30) ;
    
BEGIN
    SELECT user
    INTO v_user 
    FROM DUAL ;
    
    INSERT INTO event_log
        VALUES(event_log_sq.NEXTVAL, SYSDATE, v_user, 'CUSTOMER', NULL, NULL, 'CUSTOMER has been updated') ;
        
END ;
