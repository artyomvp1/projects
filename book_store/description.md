# About the project
<i>Long story about this project</i>

## Tables
* [Create table scripts](table_organization.sql)

## Triggers
* [Price control](trigger_price_control.sql)
* [Balance change](trigger_balance_change.sql) 

## Procedures 
* [Cashback](procedure_cashback.sql)

## Jobs

## Reports
* [Total sales and customers median values](report_customer_median.sql)
* [Top 10 books sold](report_top_books_sold.sql)

# Known Isues
* More business operations should be logged using triggers
* Procedure 'CASHBACK' should lock table 'CUSTOMER' before updating via FOR UPDATE NOWAIT statement
