DROP TABLE IF EXISTS fines;
DROP TABLE IF EXISTS rentals;
DROP TABLE IF EXISTS tariffs;
DROP TABLE IF EXISTS cars;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(12) NOT NULL,
    email VARCHAR(70) NOT NULL,
    drivers_license VARCHAR(20) NOT NULL,
    birth_date DATE NOT NULL,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_users_phone UNIQUE (phone),
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT uq_users_dl UNIQUE (drivers_license),

    CONSTRAINT chk_phone_number_format CHECK (
        phone ~ '^\+7[0-9]{10}$'
    ),

    CONSTRAINT chk_users_age CHECK (
        birth_date <= CURRENT_DATE - INTERVAL '18 years'
    )
);

CREATE TABLE cars (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    license_plate VARCHAR(50) NOT NULL,
    vin VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'available',

    CONSTRAINT uq_cars_plate UNIQUE (license_plate),
    CONSTRAINT uq_cars_vin UNIQUE (vin),

    CONSTRAINT chk_cars_year CHECK (
        year BETWEEN 1886 AND EXTRACT(YEAR FROM CURRENT_DATE)
    ),

    CONSTRAINT chk_cars_status CHECK (
        status IN ('available', 'rented', 'maintenance')
    )
);

CREATE TABLE tariffs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price_per_minute NUMERIC(10, 2) NOT NULL,
    price_per_start NUMERIC(10, 2) NOT NULL,
    min_age INT NOT NULL,

    CONSTRAINT uq_tariffs_name UNIQUE (name),

    CONSTRAINT chk_tariffs_price CHECK (
        price_per_minute >= 0 AND price_per_start >= 0
    ),

    CONSTRAINT chk_tariffs_age CHECK (min_age BETWEEN 18 AND 100)
);

CREATE TABLE rentals (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL,
    car_id INT NOT NULL,
    tariff_id INT NOT NULL,
    start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP,
    start_mileage INT NOT NULL,
    end_mileage INT,

    CONSTRAINT fk_rentals_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_rentals_car
        FOREIGN KEY (car_id) REFERENCES cars(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_rentals_tariff
        FOREIGN KEY (tariff_id) REFERENCES tariffs(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_rentals_time CHECK (
        end_time IS NULL OR end_time > start_time
    ),

    CONSTRAINT chk_rentals_mileage CHECK (
        end_mileage IS NULL OR end_mileage > start_mileage
    )
);

CREATE TABLE fines (
    id SERIAL PRIMARY KEY,
    rental_id INT NOT NULL,
    user_id UUID NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    issue_date DATE NOT NULL,
    reason TEXT NOT NULL,

    CONSTRAINT fk_fines_rental
        FOREIGN KEY (rental_id) REFERENCES rentals(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_fines_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_fines_rental_reason UNIQUE (rental_id, reason),
    CONSTRAINT chk_fines_amount CHECK (amount > 0)
);