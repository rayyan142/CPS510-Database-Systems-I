#!/bin/sh
sqlplus64 "r1faisal/10286760@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

SET PAGESIZE 50000;

-- Query 1: Retrieve customer names and vehicles they rented for more than 5 days using EXISTS
SELECT c.user_name, v.vehicle_make, v.vehicle_model, r.rental_duration
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN vehicle v ON r.vehicle_id = v.vehicle_id
WHERE r.rental_duration > 5
  AND EXISTS (
    SELECT 1
    FROM rental r2
    WHERE r2.customer_id = c.customer_id
      AND r2.rental_duration > 5
  );

-- Query 2: Count the number of rentals per customer
SELECT c.user_name, COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.user_name
ORDER BY rental_count DESC;

-- Query 3: Display total earnings, average insurance cost, and earnings per vehicle
SELECT v.vehicle_make, v.vehicle_model, 
       SUM(f.earnings) AS vehicle_earnings, 
       AVG(f.insurance_cost) AS insurance_costs,
       (SELECT SUM(f2.earnings) FROM financial f2) AS total_earnings,
       (SELECT AVG(f2.insurance_cost) FROM financial f2) AS avg_insurance
FROM vehicle v
JOIN rental r ON v.vehicle_id = r.vehicle_id
JOIN financial f ON r.financial_id = f.financial_id
GROUP BY v.vehicle_make, v.vehicle_model;

-- Query 4: Find all available vehicles in the inventory using UNION to combine results of available vehicles with those needing maintenance
SELECT v.vehicle_make, v.vehicle_model
FROM vehicle v
JOIN inventory i ON v.inventory_id = i.inventory_id
WHERE i.availability = 'available'
UNION
SELECT v.vehicle_make, v.vehicle_model
FROM vehicle v
JOIN inventory i ON v.inventory_id = i.inventory_id
WHERE i.availability = 'under maintenance';

-- Query 5: This query calculates the statistics for rental costs using MIN, MAX, and AVG functions
SELECT MIN(r.rental_cost) AS lowest_rental_cost, 
       MAX(r.rental_cost) AS highest_rental_cost, 
       AVG(r.rental_cost) AS average_rental_cost
FROM rental r;

-- Query 6: This query uses SUM, GROUP BY, and HAVING to find customers with total payments greater than $500
SELECT c.user_name, SUM(p.payment_amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.user_name
HAVING SUM(p.payment_amount) > 500;

exit;
EOF
