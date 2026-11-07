-- Тест 1: Дубликат телефона (uq_users_phone)
INSERT INTO users (id, first_name, last_name, phone, email, drivers_license, birth_date) VALUES
('e5555555-5555-5555-5555-555555555555', 'Петр', 'Смирнов',
 '+79991234567', 'petr.new@mail.ru', '77 55 445566', '1992-05-20');

-- Тест 2: Дубликат VIN автомобиля (uq_cars_vin)
INSERT INTO cars (brand, model, license_plate, vin, year, status) VALUES
('Toyota', 'Camry', 'Т678УФ77', 'KNADN512B65123456', 2023, 'available');

-- Тест 3: Составной UNIQUE — дубликат (rental_id, reason) (uq_fines_rental_reason)
INSERT INTO fines (rental_id, user_id, amount, issue_date, reason) VALUES
(4, 'c3333333-3333-3333-3333-333333333333', 2000.00, '2026-10-10',
 'Превышение скорости более чем на 40 км/ч');

-- Тест 4: Неверный формат телефона (chk_phone_number_format)
INSERT INTO users (id, first_name, last_name, phone, email, drivers_license, birth_date) VALUES
('f6666666-6666-6666-6666-666666666666', 'Николай', 'Иванов',
 '89991234567', 'nik.ivanov@mail.ru', '77 66 778899', '1990-01-01');

-- Тест 5: Возраст пользователя < 18 лет (chk_users_age)
INSERT INTO users (id, first_name, last_name, phone, email, drivers_license, birth_date) VALUES
('f7777777-7777-7777-7777-777777777777', 'Малыш', 'Тестов',
 '+79998887766', 'kid@mail.ru', '77 77 777777', '2015-01-01');

-- Тест 6: Год выпуска машины < 1886 (chk_cars_year)
INSERT INTO cars (brand, model, license_plate, vin, year, status) VALUES
('Ford', 'Model T', 'Х999ХХ77', '1FTFW1ET5DF123456', 1850, 'available');

-- Тест 7: Недопустимый статус машины (chk_cars_status)
INSERT INTO cars (brand, model, license_plate, vin, year, status) VALUES
('Mazda', 'CX-5', 'У555УУ77', 'JM3KFBCM5M0123456', 2023, 'stolen');

-- Тест 8: Минимальный возраст вне диапазона 18-100 (chk_tariffs_age)
INSERT INTO tariffs (name, price_per_minute, price_per_start, min_age) VALUES
('Детский', 5.00, 20.00, 10);

-- Тест 9: Время окончания раньше времени начала (chk_rentals_time)
INSERT INTO rentals (user_id, car_id, tariff_id, start_time, end_time, start_mileage, end_mileage) VALUES
('a1111111-1111-1111-1111-111111111111', 1, 1,
 '2026-10-13 15:00:00', '2026-10-13 14:00:00', 15100, 15150);

-- Тест 10: Конечный пробег меньше начального (chk_rentals_mileage)
INSERT INTO rentals (user_id, car_id, tariff_id, start_time, end_time, start_mileage, end_mileage) VALUES
('a1111111-1111-1111-1111-111111111111', 1, 1,
 '2026-10-13 16:00:00', '2026-10-13 17:00:00', 15200, 15100);

-- Тест 11: Отрицательная сумма штрафа (chk_fines_amount)
INSERT INTO fines (rental_id, user_id, amount, issue_date, reason) VALUES
(1, 'a1111111-1111-1111-1111-111111111111', -500.00, '2026-10-13',
 'Возврат средств');

-- Тест 12: ON DELETE RESTRICT — нельзя удалить пользователя с активными арендами (fk_rentals_user)
DELETE FROM users WHERE id = 'a1111111-1111-1111-1111-111111111111';
