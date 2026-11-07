BEGIN;

ALTER TABLE fines
    DROP CONSTRAINT fk_fines_user,
    DROP COLUMN user_id;

CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    rental_id INT NOT NULL,
    text_photo TEXT,
    img TEXT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'before',
    
    CONSTRAINT chk_photos_status CHECK (status IN ('before', 'after', 'accident')),

    CONSTRAINT fk_photos_rental
        FOREIGN KEY (rental_id) REFERENCES rentals(id)
        ON DELETE CASCADE
);

COMMIT;