# About the project
<i>Long story about this project</i>

## Tables
* customer - 
* customer_security - 
* author - 
* publisher - 
* warehouse - 
* book - 
* sales - 

## Triggers
* price_control - 
* balance_change - 

## Procedures 
* cashback - 

## Jobs

## Reports
* [Total sales and customers median values](report1.customer_median.sql)

# Known Isues
* More operations should be logged
* Procedure 'CASHBACK' should lock table 'CUSTOMER' before updating via FOR UPDATE NOWAIT statement
