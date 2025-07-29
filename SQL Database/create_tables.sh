#!/bin/sh
sqlplus64 "r1faisal/10286760@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

CREATE TABLE customer (
    customer_id           NUMBER PRIMARY KEY,
    user_name             VARCHAR2(100) NOT NULL,
    driver_license_number VARCHAR2(50) NOT NULL UNIQUE,
    contact_info          VARCHAR2(150),
    user_address          VARCHAR2(255)
);

CREATE TABLE admin (
    admin_id   NUMBER PRIMARY KEY,
    admin_name VARCHAR2(100)
);

CREATE TABLE inventory (
    inventory_id NUMBER PRIMARY KEY,
    category     VARCHAR2(100),
    availability VARCHAR2(50)
);

CREATE TABLE vehicle (
    vehicle_id    NUMBER PRIMARY KEY,
    vehicle_make  VARCHAR2(100),
    vehicle_model VARCHAR2(100),
    inventory_id  NUMBER REFERENCES inventory (inventory_id)
);

CREATE TABLE payment (
    payment_id     NUMBER PRIMARY KEY,
    customer_id    NUMBER REFERENCES customer (customer_id),
    payment_type   VARCHAR2(50),
    payment_info   VARCHAR2(100),
    payment_amount NUMBER,
    payment_date   DATE
);

CREATE TABLE financial (
    financial_id     NUMBER PRIMARY KEY,
    earnings         NUMBER,
    insurance_cost   NUMBER,
    maintenance_cost NUMBER,
    payment_id       NUMBER REFERENCES payment (payment_id)
);

CREATE TABLE rental_dates (
    payment_id      NUMBER PRIMARY KEY,
    date_of_rental  DATE,
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

CREATE TABLE rental (
    rental_id       NUMBER PRIMARY KEY,
    rental_duration NUMBER,
    rental_cost     NUMBER,
    customer_id     NUMBER REFERENCES customer (customer_id),
    vehicle_id      NUMBER REFERENCES vehicle (vehicle_id),
    financial_id    NUMBER REFERENCES financial (financial_id)
);

CREATE TABLE customer_rental (
    customer_id   NUMBER REFERENCES customer (customer_id),
    customer_name VARCHAR2(100),
    rental_id     NUMBER REFERENCES rental (rental_id),
    PRIMARY KEY (customer_id, rental_id)
);

exit;
EOF
