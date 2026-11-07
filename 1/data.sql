DELETE FROM fines;
DELETE FROM rentals;
DELETE FROM tariffs;
DELETE FROM cars;
DELETE FROM users;

INSERT INTO users (id, first_name, last_name, phone, email, drivers_license, birth_date) VALUES
('a1111111-1111-1111-1111-111111111111', 'Иван', 'Петров', '+79991234567', 'ivan.petrov@mail.ru', '77 11 223344', '1995-03-15'),
('b2222222-2222-2222-2222-222222222222', 'Мария', 'Сидорова', '+79997654321', 'm.sidorova@gmail.com', '77 22 556677', '1998-07-22'),
('c3333333-3333-3333-3333-333333333333', 'Алексей', 'Козлов', '+79991112233', 'kozlov@yandex.ru', '77 33 889900', '1990-11-03'),
('d4444444-4444-4444-4444-444444444444', 'Елена', 'Волкова', '+79994445566', 'volko.elena@mail.ru', '77 44 112233', '2000-01-10');

INSERT INTO cars (brand, model, license_plate, vin, year, status) VALUES
('Kia',        'Rio',     'А123ВС77', 'KNADN512B65123456', 2022, 'available'),
('Hyundai',    'Solaris', 'В456ГД77', 'Z94CB41DBJR123456', 2021, 'rented'),
('Volkswagen', 'Polo',    'Е789ЖЗ77', 'WVWZZZ6RZKE123456', 2023, 'available'),
('Skoda',      'Rapid',   'К012ЛМ77', 'TMBJH7NH8L5123456', 2020, 'maintenance'),
('Renault',    'Logan',   'Н345НО77', 'X7L1SRAB561234567', 2019, 'available');

INSERT INTO tariffs (name, price_per_minute, price_per_start, min_age) VALUES
('Поминутный',      8.00,  50.00, 21),
('Фиксированный', 150.00, 100.00, 21),
('Суточный',       10.00,  30.00, 25);

INSERT INTO rentals (user_id, car_id, tariff_id, start_time, end_time, start_mileage, end_mileage) VALUES
('a1111111-1111-1111-1111-111111111111', 1, 1, '2026-10-10 09:00:00', '2026-10-10 10:30:00', 15000, 15045),
('b2222222-2222-2222-2222-222222222222', 3, 2, '2026-10-11 14:00:00', '2026-10-11 15:15:00', 8500,  8530),
('b2222222-2222-2222-2222-222222222222', 2, 1, '2026-10-13 08:00:00', NULL, 22000, NULL),
('c3333333-3333-3333-3333-333333333333', 5, 3, '2026-10-09 18:00:00', '2026-10-10 09:00:00', 45000, 45320);

INSERT INTO fines (rental_id, amount, issue_date, reason) VALUES
(4, 1500.00, '2026-10-10', 'Превышение скорости более чем на 40 км/ч'),
(4, 3000.00, '2026-10-10', 'Парковка в неположенном месте'),
(2,  500.00, '2026-10-11', 'Курение в салоне автомобиля');