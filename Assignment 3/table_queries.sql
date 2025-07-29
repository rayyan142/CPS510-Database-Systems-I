-- Populating Admin Table --

INSERT INTO admin (admin_id, admin_name) VALUES (1, 'Admin One');
INSERT INTO admin (admin_id, admin_name) VALUES (2, 'Admin Two');
INSERT INTO admin (admin_id, admin_name) VALUES (3, 'Admin Three');
INSERT INTO admin (admin_id, admin_name) VALUES (4, 'Admin Four');

SELECT * FROM admin;
    
-- Populating Customer Table --

INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address) 
VALUES (1, 'r1faisal', 501196760, 'r1faisal@torontomu.ca', 'M5B 2K3');

INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address)
VALUES (2, 'aman.dhillon', 501171540, 'aman.dhillon@torontomu.ca', 'M5B 2K3');

INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address)
VALUES (3, 'j1antony', 501197645, 'j1antony@torontomu.ca', 'M5B 2K3');

INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address)
VALUES (4, 'afeef.islam', 501159386, 'afeef.islam@torontomu.ca', 'M5B 2K3');

SELECT * FROM customer;
    
-- Populating Financial Table --

INSERT INTO financial (financial_id, date_of_rental, earnings, insurance_cost, maintenance_cost, payment_id)
VALUES (1, DATE '2024-10-03', 300, 30, 0, 1);

INSERT INTO financial (financial_id, date_of_rental, earnings, insurance_cost, maintenance_cost, payment_id)
VALUES (2, DATE '2024-10-03', 250, 20, 0, 2);

INSERT INTO financial (financial_id, date_of_rental, earnings, insurance_cost, maintenance_cost, payment_id)
VALUES (3, DATE '2024-10-03', 600, 50, 10, 3);

INSERT INTO financial (financial_id, date_of_rental, earnings, insurance_cost, maintenance_cost, payment_id)
VALUES (4, DATE '2024-10-03', 150, 10, 15, 4);

SELECT * FROM financial;
    
-- Populating Inventory Table --

INSERT INTO inventory (inventory_id, category, availability) 
VALUES (1, 'Sedan', 'available');

INSERT INTO inventory (inventory_id, category, availability)
VALUES (2, 'SUV', 'under maintenance');

INSERT INTO inventory (inventory_id, category, availability)
VALUES (3, 'Truck', 'available');

INSERT INTO inventory (inventory_id, category, availability)
VALUES (4, 'Luxury', 'rented');

SELECT * FROM inventory;
    
-- Populating Payment Table --

INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date)
VALUES (1, 1, 'Credit Card', 'Visa - **** 1234', 330, DATE '2023-09-01');

INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date)       
VALUES (2, 2, 'Debit Card', 'MasterCard - **** 5678', 270, DATE '2023-09-03');
   
INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date)
VALUES (3, 3, 'Paypal', 'PayPal - rayyan@gmail.com', 650, DATE '2023-09-05');

INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date)
VALUES (4, 4, 'Cash', 'N/A', 160, DATE '2023-09-08');

SELECT * FROM payment;

-- Populating Rental Table --

INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id)
VALUES (1, 7, 300, 1, 1, 1);

INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id)
VALUES (2, 5, 250, 2, 2, 2);

INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id)
VALUES (3, 10, 600, 3, 3, 3);

INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id)
VALUES (4, 3, 150, 4, 4, 4);

SELECT * FROM rental;

-- Populating Vehicle Table --

INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id)
VALUES (1, 'Honda', 'Civic', 1);

INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id)
VALUES (2, 'BMW', 'X5', 2);

INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id)
VALUES (3, 'Ford', 'F-150', 3);

INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id)
VALUES (4, 'Chevrolet', 'Corvette', 4);

SELECT * FROM vehicle;

-- Displaying ALL Tables --

SELECT * FROM admin;
SELECT * FROM customer;
SELECT * FROM financial;
SELECT * FROM inventory;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM vehicle;

-- Queries --

-- Query 1: Retrieve distinct customer names and contact information
SELECT DISTINCT user_name, contact_info 
FROM customer 
ORDER BY user_name;

-- Query 2: List all available vehicles by make and model
SELECT vehicle_make, vehicle_model
FROM vehicle v
JOIN inventory i ON v.inventory_id = i.inventory_id
WHERE i.availability = 'available'
ORDER BY vehicle_make, vehicle_model;

-- Query 3: Retrieve financial records with earnings greater than or equal to $250
SELECT financial_id, earnings, insurance_cost, maintenance_cost 
FROM financial 
WHERE earnings >= 250
ORDER BY earnings DESC;

-- Query 4: Display payment records by customer
SELECT p.payment_id, c.user_name, p.payment_type, p.payment_amount, p.payment_date
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
ORDER BY p.payment_date DESC;

-- Query 5: List all rentals with vehicle and financial details
SELECT r.rental_id, v.vehicle_make, v.vehicle_model, f.earnings, f.insurance_cost 
FROM rental r
JOIN vehicle v ON r.vehicle_id = v.vehicle_id
JOIN financial f ON r.financial_id = f.financial_id
ORDER BY r.rental_id;

-- Query 6: List all vehicles rented for more than 5 days
SELECT v.vehicle_make, v.vehicle_model, r.rental_duration
FROM vehicle v
JOIN rental r ON v.vehicle_id = r.vehicle_id
WHERE r.rental_duration > 5
ORDER BY r.rental_duration DESC;

-- Query 7: Show customers who have made payments greater than $300
SELECT c.user_name, p.payment_type, p.payment_amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_amount > 300
ORDER BY p.payment_amount DESC;

-- Create a view for admins and the number of rentals they have managed
CREATE VIEW admin_rentals_summary AS
SELECT a.admin_name, COUNT(r.rental_id) AS rentals_managed
FROM admin a
JOIN rental r ON a.admin_id = r.customer_id
GROUP BY a.admin_name
ORDER BY rentals_managed DESC;

SELECT * FROM admin_rentals_summary;

-- View for customers with payments greater than $300
CREATE VIEW high_value_customers AS
SELECT c.user_name, p.payment_type, p.payment_amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_amount > 300
ORDER BY p.payment_amount DESC;

SELECT * FROM high_value_customers;iew for available vehicles by make and model
CREATE VIEW available_vehicles AS
SELECT v.vehicle_make, v.vehicle_model
FROM vehicle v
JOIN inventory i ON v.inventory_id = i.inventory_id
WHERE i.availability = 'available'
ORDER BY v.vehicle_make, v.vehicle_model;

SELECT * FROM available_vehicles;

-- Create a view for customers with payments greater than $300
CREATE VIEW high_value_customers AS
SELECT c.user_name, p.payment_type, p.payment_amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_amount > 300
ORDER BY p.payment_amount DESC;

SELECT * FROM high_value_customers;

















