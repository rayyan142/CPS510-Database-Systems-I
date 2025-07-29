-- CUSTOMER Table
CREATE TABLE CUSTOMER (
    Customer_ID INT PRIMARY KEY,
    User_Name VARCHAR2(100) NOT NULL,
    Driver_License_Number VARCHAR2(50) UNIQUE NOT NULL,
    Contact_Info VARCHAR2(150),
    User_Address VARCHAR2(255)
);

-- ADMIN Table
CREATE TABLE ADMIN (
    Admin_ID INT PRIMARY KEY,
    Admin_Name VARCHAR2(100) NOT NULL
);

-- INVENTORY Table
CREATE TABLE INVENTORY (
    Inventory_ID INT PRIMARY KEY,
    Category VARCHAR2(100) NOT NULL,
    Availability VARCHAR2(50) NOT NULL
);

-- VEHICLE Table
CREATE TABLE VEHICLE (
    Vehicle_ID INT PRIMARY KEY,
    Vehicle_Make VARCHAR2(100) NOT NULL,
    Vehicle_Model VARCHAR2(100) NOT NULL,
    Inventory_ID INT REFERENCES INVENTORY(Inventory_ID)
);

-- PAYMENT Table
CREATE TABLE PAYMENT (
    Payment_ID INT PRIMARY KEY,
    Customer_ID INT REFERENCES CUSTOMER(Customer_ID),
    Payment_Type VARCHAR2(50),
    Payment_Info VARCHAR2(100),
    Payment_Amount DECIMAL(10, 2),
    Payment_Date DATE NOT NULL
);

-- FINANCIAL Table
CREATE TABLE FINANCIAL (
    Financial_ID INT PRIMARY KEY,
    Earnings DECIMAL(10, 2),
    Insurance_Cost DECIMAL(10, 2),
    Maintenance_Cost DECIMAL(10, 2),
    Payment_ID INT REFERENCES PAYMENT(Payment_ID)
);

-- EARNINGS Table
CREATE TABLE EARNINGS (
    Financial_ID INT REFERENCES FINANCIAL(Financial_ID),
    Earning_Type VARCHAR2(50),
    Amount DECIMAL(10, 2),
    PRIMARY KEY (Financial_ID, Earning_Type)
);

-- RENTAL Table
CREATE TABLE RENTAL (
    Rental_ID INT PRIMARY KEY,
    Rental_Duration INT NOT NULL,
    Rental_Cost DECIMAL(10, 2) NOT NULL,
    Vehicle_ID INT REFERENCES VEHICLE(Vehicle_ID),
    Financial_ID INT REFERENCES FINANCIAL(Financial_ID)
);

-- RENTAL_DATES Table
CREATE TABLE RENTAL_DATES (
    Payment_ID INT REFERENCES PAYMENT(Payment_ID),
    Date_Of_Rental DATE NOT NULL,
    PRIMARY KEY (Payment_ID, Date_Of_Rental)
);

-- CUSTOMER_RENTAL Table
CREATE TABLE CUSTOMER_RENTAL (
    Customer_ID INT REFERENCES CUSTOMER(Customer_ID),
    Customer_Name VARCHAR2(100),
    Rental_ID INT REFERENCES RENTAL(Rental_ID),
    PRIMARY KEY (Customer_ID, Rental_ID)
);

-- VEHICLE_RENTAL Table
CREATE TABLE VEHICLE_RENTAL (
    Rental_ID INT REFERENCES RENTAL(Rental_ID),
    Vehicle_ID INT REFERENCES VEHICLE(Vehicle_ID),
    PRIMARY KEY (Rental_ID, Vehicle_ID)
);
