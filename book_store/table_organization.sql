/* TABLES AND VIEWS */
CREATE TABLE author (author_id NUMBER,
                     create_date DATE,
                     first_name VARCHAR2(30),
                     last_name VARCHAR2(30),
                     CONSTRAINT pk_author PRIMARY KEY(author_id) ) ;

CREATE TABLE publisher (publisher_id NUMBER,
                        create_date DATE,
                        publisher_name VARCHAR2(30),
                        country VARCHAR2(30),
                        CONSTRAINT pk_publisher PRIMARY KEY(publisher_id) ) ;

CREATE TABLE warehouse (warehouse_id NUMBER,
                        create_date DATE,
                        address VARCHAR2(80),
                        city VARCHAR2(20),
                        state CHAR(2),
                        postal_index NUMBER CHECK(postal_index BETWEEN 00000 AND 99999),
                        CONSTRAINT pk_warehouse PRIMARY KEY(warehouse_id) ) ;
                        
CREATE TABLE book (book_id NUMBER,
                    book_name VARCHAR2(100),
                    translated VARCHAR2(20),
                    genre VARCHAR2(20),
                    author_id NUMBER,
                    published NUMBER,
                    publisher_id NUMBER,
                    price NUMBER,
                    CONSTRAINT pk_book PRIMARY KEY(book_id),
                    CONSTRAINT fk_b_author_id FOREIGN KEY(author_id) REFERENCES author(author_id),
                    CONSTRAINT fk_b_publisher_id FOREIGN KEY(publisher_id) REFERENCES publisher(publisher_id) ) ;
                    
CREATE TABLE customer (customer_id NUMBER,
                       create_date DATE,
                       first_name VARCHAR2(30) NOT NULL,
                       last_name VARCHAR2(30) NOT NULL,
                       date_of_birth DATE,
                       balance NUMBER DEFAULT 0,
                       service_plan VARCHAR2(20),
                       CONSTRAINT pk_customer PRIMARY KEY(customer_id) ) ;

CREATE TABLE sales (sale_id NUMBER,
                    sales_date DATE,
                    shipping_date DATE,
                    customer_id NUMBER,
                    book_id NUMBER,
                    warehouse_id NUMBER, 
                    price_amount NUMBER,
                    tax_amount NUMBER,
                    total_amount NUMBER,
                    CONSTRAINT pk_sales PRIMARY KEY(sale_id),
                    CONSTRAINT fk_sales_customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
                    CONSTRAINT fk_sales_book_id FOREIGN KEY(book_id) REFERENCES book(book_id),
                    CONSTRAINT fk_sales_warehouse_id FOREIGN KEY(warehouse_id) REFERENCES warehouse(warehouse_id)
                    ) ;

CREATE TABLE customer_security (customer_id NUMBER,
                                create_date DATE,
                                login VARCHAR2(30),
                                password_hash VARCHAR2(100),
                                email VARCHAR2(100) CHECK(email LIKE '%@%.%'),
                                status CHAR(1),
                                CONSTRAINT pk_customer_security PRIMARY KEY (customer_id),
                                CONSTRAINT pk_customer_security_customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ) ;
                                
CREATE TABLE event_log (event_id NUMBER,
                        event_date DATE,
                        user_name VARCHAR2(30),
                        table_name VARCHAR2(30),
                        inserted_value VARCHAR2(100),
                        deleted_value VARCHAR2(100),
                        commentary CLOB,
                        CONSTRAINT pk_event_log PRIMARY KEY(event_id) ) ;

-- MATERIALIZED VIEW
CREATE MATERIALIZED VIEW vw_daily_sales 
AS
    SELECT sales_date,
           COUNT(*) AS total_sales,
           COUNT(DISTINCT customer_id) unique_customers,
           SUM(total_amount) total_amount
    FROM sales 
    GROUP BY sales_date
    ORDER BY sales_date ;
