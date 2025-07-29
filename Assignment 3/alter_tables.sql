ALTER TABLE admin MODIFY
    admin_name VARCHAR2(100) NOT NULL;

ALTER TABLE financial MODIFY
    date_of_rental DATE NOT NULL;

ALTER TABLE inventory MODIFY
    availability VARCHAR2(50) DEFAULT 'available';

ALTER TABLE inventory
    ADD CONSTRAINT chk_inventory_availability CHECK ( availability IN ( 'available', 'rented', 'under maintenance' ) );

ALTER TABLE vehicle MODIFY
    vehicle_make VARCHAR2(100) NOT NULL;

ALTER TABLE vehicle MODIFY
    vehicle_model VARCHAR2(100) NOT NULL;

ALTER TABLE vehicle MODIFY
    vehicle_brand VARCHAR2(100) NOT NULL;

ALTER TABLE rental ADD CONSTRAINT chk_rental_duration CHECK ( rental_duration > 0 );

ALTER TABLE rental MODIFY
    rental_cost NUMBER NOT NULL;

ALTER TABLE rental ADD CONSTRAINT chk_rental_cost CHECK ( rental_cost >= 0 );