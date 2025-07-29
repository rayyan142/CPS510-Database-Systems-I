#!/bin/sh
sqlplus64 "r1faisal/10286760@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

SET PAGESIZE 50000;

-- Display all records from each table
SELECT * FROM customer;
SELECT * FROM admin;
SELECT * FROM inventory;
SELECT * FROM vehicle;
SELECT * FROM payment;
SELECT * FROM financial;
SELECT * FROM rental_dates;
SELECT * FROM rental;
SELECT * FROM customer_rental;

exit;
EOF
