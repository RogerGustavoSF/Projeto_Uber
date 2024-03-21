CREATE DATABASE uber;
USE uber;

CREATE TABLE drivers (
id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name_driver VARCHAR(50) NOT NULL,
vehicle_plate VARCHAR(7) NOT NULL,
avg_rating DECIMAL(3,2) NOT NULL,
phone_driver VARCHAR(14) NOT NULL
);

CREATE TABLE passengers (
id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name_psg VARCHAR(50) NOT NULL,
phone_psg VARCHAR(14) NOT NULL
);

CREATE TABLE trips (
id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_driver TINYINT NOT NULL,
id_psg TINYINT NOT NULL,
date_time DATETIME NOT NULL,
origin VARCHAR(30) NOT NULL,
destination VARCHAR(30) NOT NULL,
distance_km SMALLINT NOT NULL,
price DECIMAL(5,2) NOT NULL,
FOREIGN KEY (id_driver) REFERENCES drivers(id),
FOREIGN KEY (id_psg) REFERENCES passengers(id)
);

INSERT INTO drivers VALUES
(DEFAULT, 'Noah', 'ABC1D23', 4.77, '(51)98765-4321'),
(DEFAULT, 'Robert', 'EFG4H56', 5.00, '(51)97654-3210'),
(DEFAULT, 'Matt', 'IJK78L9', 3.00, '(51)96543-2198'),
(DEFAULT, 'Mary', 'ZDB6E87', 4.55, '(51)95432-1987'),
(DEFAULT, 'John', 'LQG3P54', 2.80, '(51)94321-9876');

INSERT INTO passengers VALUES
(DEFAULT, 'Victor', '(51)99999-9999'),
(DEFAULT, 'Emma', '(51)98888-8888'),
(DEFAULT, 'Thomas', '(51)97777-7777'),
(DEFAULT, 'Gabriel', '(51)96666-6666'),
(DEFAULT, 'Michael', '(51)95555-5555'),
(DEFAULT, 'Olivia', '(51)94444-4444'),
(DEFAULT, 'Dave', '(51)93333-3333');

INSERT INTO trips VALUES
(DEFAULT, 1, 1, '2023-01-30 10:00:00', 'São Leopoldo', 'Canudos', 11.8, 22.90),
(DEFAULT, 1, 2, '2023-02-27 11:00:00', 'Esteio', 'Caxias do Sul', 104.0, 158.58),
(DEFAULT, 1, 3, '2023-03-25 12:00:00', 'Erechim', 'Estância Velha', 337.0, 469.96),
(DEFAULT, 2, 4, '2023-04-20 13:00:00', 'Guaíba', 'Gravataí', 49.90, 69.93),
(DEFAULT, 2, 5, '2023-05-17 14:00:00', 'Viamão', 'Cachoeirinha', 18.2, 31.47),
(DEFAULT, 2, 6, '2023-06-15 15:00:00', 'Alvorada', 'Eldorado do Sul', 28.0, 34.99),
(DEFAULT, 2, 7, '2023-07-10 16:00:00', 'Sapiranga', 'Novo Hamburgo', 16.6, 26.90),
(DEFAULT, 4, 3, '2023-08-07 17:00:00', 'Parobé', 'Ivoti', 41.4, 63.85),
(DEFAULT, 4, 4, '2023-09-05 18:00:00', 'Montenegro', 'Portão', 27.8, 49.97),
(DEFAULT, 4, 5, '2023-10-03 19:00:00', 'Canela', 'Campo Bom', 74.8, 140.48);

SET SQL_SAFE_UPDATES = 0;
UPDATE drivers SET vehicle_plate = 'DEF789' WHERE name_driver = 'Robert';
UPDATE drivers SET avg_rating = 0.5 WHERE avg_rating >= 4.0;
UPDATE trips SET price = 20.0 WHERE date_time < '2023-06-01';
UPDATE trips SET destination = 'Porto Alegre' WHERE origin = 'São Leopoldo';
UPDATE trips SET price = 250.00 WHERE id_driver = 1 AND id_psg = 2;
UPDATE passengers SET phone_psg = '(51)91111-1111' WHERE name_psg = 'Victor';
UPDATE passengers SET name_psg = 'Isabella' WHERE phone_psg = '(51)96666-6666';

-- Some SELECTs for demonstration:
-- Returning the name of the driver, the name of the passenger, and the distance traveled for all trips over 10 km.
SELECT drivers.name_driver AS Driver_name, passengers.name_psg AS Name_passenger, trips.distance_km 
FROM trips
JOIN drivers ON trips.id_driver = drivers.id
JOIN passengers ON trips.id_psg = passengers.id 
WHERE CAST(trips.distance_km AS DECIMAL(8,2)) > 10.0;

-- Returning the average rating of drivers:
SELECT ROUND(AVG(avg_rating), 2) AS Avg_rating FROM drivers;

-- Listing all drivers who have not made any trips yet:
SELECT drivers.name_driver AS Driver_name 
FROM drivers 
LEFT JOIN trips ON drivers.id = trips.id_driver 
WHERE trips.id IS NULL;

-- Listing the average distance traveled for all trips and the average price of trips:
SELECT ROUND(AVG(distance_km), 2) AS Avg_kmDistance, ROUND(AVG(price), 2) AS Avg_price 
FROM trips;

-- Some DELETEs for demonstration:
DELETE FROM trips 
WHERE distance_km < 5.0;
DELETE FROM trips 
WHERE date_time < '2023-08-30 15:30:00';
DELETE FROM drivers 
WHERE name_driver = 'Noah';
DELETE FROM passengers 
WHERE phone_psg = '(51)94444-4444';
DELETE FROM trips 
WHERE price > 200.00;
DELETE FROM trips 
WHERE id_driver = 1;

DELETE FROM trips;
