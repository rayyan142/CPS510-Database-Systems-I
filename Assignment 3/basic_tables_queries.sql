-- Queries --

-- Query 1: Retrieve distinct customer names and contact information
SELECT DISTINCT user_name, contact_info 
FROM customer 
ORDER BY user_name;

-- Query 2: List all vehicles in database
SELECT vehicle_make, vehicle_model
FROM vehicle
ORDER BY vehicle_make, vehicle_model;

-- Query 3: Retrieve financial records with earnings greater than or equal to $250
SELECT financial_id, earnings, insurance_cost, maintenance_cost 
FROM financial 
WHERE earnings >= 250
ORDER BY earnings DESC;

-- Query 4: Display payment records by customer
SELECT payment_id, customer_id, payment_amount
FROM payment
WHERE payment_amount >= 250
ORDER BY payment_amount DESC;

-- Query 5: List customers with rental duration
SELECT rental_id, customer_id, rental_duration
FROM rental
ORDER BY rental_duration DESC;

-- Query 8: Display the list of admins
SELECT admin_id, admin_name
FROM admin
ORDER BY admin_name DESC;

-- Query 9: Count the number of vehicles in each inventory category and their availability
SELECT inventory_id, availability
FROM inventory
WHERE availability = 'available'
