# About
<i>This project is created to accommodate sales needs of a minimalistic book store. It is also aimed to ensure data integrity and database normalization principles. The database has comprehensive table relations and structure, which provide efficient completion of daily business processes. The project is aimed to consider analytical operations, so DBA and security topics are not covered.</i>

### Tables and views
* [Create table scripts](table_organization.sql)

### Triggers
* [Price control](trigger_price_control.sql)
* [Balance change](trigger_balance_change.sql) 

### Procedures 
* [Add sale](procedure_add_sale.sql)
* [Cashback](procedure_cashback.sql)

### Functions
* [Get balance](function_get_balance.sql)
* [Get price](function_get_price.sql)

### Jobs
* [Update views](job_update_views.sql)

## Reports
* [Total sales and customer's median values](report_customer_median.sql)
* [Last and last three customer's purchases](report_last_purchase.sql)
* [Top 10 books sold](report_top_books_sold.sql)

# Known Issues
* More business operations should be logged using triggers
* Procedure 'CASHBACK' should lock table 'CUSTOMER' before updating via FOR UPDATE NOWAIT statement
* Daily calculating the whole SALES table to refresh the materialized view VW_daily_sales
* Procedure 'ADD_SALE' should extract information for update using cursor or or bulk collecting.
