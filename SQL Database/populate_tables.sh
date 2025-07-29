#!/bin/sh
sqlplus64 "r1faisal/10286760@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

-- Insert data into the customer table
INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address)
VALUES (1, 'Rayyan Faisal', 'DL123456', 'r1faisal@torontomu.ca', 'M5B 2K3');
INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address)
VALUES (2, 'Aman Dhillon', 'DL223456', 'aman.dhillon@torontomu.ca', 'M5B 2K3');
INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address)
VALUES (3, 'Joshua Antony', 'DL333456', 'j1antony@torontomu.ca', 'M5B 2K3');
INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address)
VALUES (4, 'Afeef Islam', 'DL444456', 'afeef.islam@torontomu.ca', 'M5B 2K3');

-- Insert data into the admin table
INSERT INTO admin (admin_id, admin_name) 
VALUES (1, 'Admin One');
INSERT INTO admin (admin_id, admin_name) 
VALUES (2, 'Admin Two');
INSERT INTO admin (admin_id, admin_name) 
VALUES (3, 'Admin Three');
INSERT INTO admin (admin_id, admin_name) 
VALUES (4, 'Admin Four');

-- Insert data into the inventory table
INSERT INTO inventory (inventory_id, category, availability)
VALUES (1, 'Sedan', 'available');
INSERT INTO inventory (inventory_id, category, availability)
VALUES (2, 'SUV', 'under maintenance');
INSERT INTO inventory (inventory_id, category, availability)
VALUES (3, 'Truck', 'available');
INSERT INTO inventory (inventory_id, category, availability)
VALUES (4, 'Luxury', 'rented');

-- Insert data into the vehicle table
INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id)
VALUES (1, 'Honda', 'Civic', 1);
INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id)
VALUES (2, 'BMW', 'X5', 2);
INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id)
VALUES (3, 'Ford', 'F-150', 3);
INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id)
VALUES (4, 'Chevrolet', 'Corvette', 4);

-- Insert data into the payment table
INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date)
VALUES (1, 1, 'Credit Card', 'Visa - **** 1234', 330, DATE '2023-09-01');
INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date)       
VALUES (2, 2, 'Debit Card', 'MasterCard - **** 5678', 270, DATE '2023-09-03');
INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date)
VALUES (3, 3, 'Paypal', 'PayPal - rayyan@gmail.com', 650, DATE '2023-09-05');
INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date)
VALUES (4, 4, 'Cash', 'N/A', 160, DATE '2023-09-08');

-- Insert data into the financial table
INSERT INTO financial (financial_id, earnings, insurance_cost, maintenance_cost, payment_id)
VALUES (1, 300, 30, 0, 1);
INSERT INTO financial (financial_id, earnings, insurance_cost, maintenance_cost, payment_id)
VALUES (2, 250, 20, 0, 2);
INSERT INTO financial (financial_id, earnings, insurance_cost, maintenance_cost, payment_id)
VALUES (3, 600, 50, 10, 3);
INSERT INTO financial (financial_id, earnings, insurance_cost, maintenance_cost, payment_id)
VALUES (4, 150, 10, 15, 4);

-- Insert data into the rental_dates table
INSERT INTO rental_dates (payment_id, date_of_rental)
VALUES (1, DATE '2023-09-01');
INSERT INTO rental_dates (payment_id, date_of_rental)
VALUES (2, DATE '2023-09-03');
INSERT INTO rental_dates (payment_id, date_of_rental)
VALUES (3, DATE '2023-09-05');
INSERT INTO rental_dates (payment_id, date_of_rental)
VALUES (4, DATE '2023-09-08');

-- Insert data into the rental table
INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id)
VALUES (1, 7, 300, 1, 1, 1);
INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id)
VALUES (2, 5, 250, 2, 2, 2);
INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id)
VALUES (3, 10, 600, 3, 3, 3);
INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id)
VALUES (4, 3, 150, 4, 4, 4);

-- Insert data into the customer_rental table
INSERT INTO customer_rental (customer_id, customer_name, rental_id)
VALUES (1, 'Rayyan Faisal', 1);
INSERT INTO customer_rental (customer_id, customer_name, rental_id)
VALUES (2, 'Aman Dhillon', 2);
INSERT INTO customer_rental (customer_id, customer_name, rental_id)
VALUES (3, 'Joshua Antony', 3);
INSERT INTO customer_rental (customer_id, customer_name, rental_id)
VALUES (4, 'Afeef Islam', 4);

exit;
EOF
