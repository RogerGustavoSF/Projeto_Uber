-- Creating the database and using it
CREATE DATABASE db_uber;
USE db_uber;

-- Creating the drivers table
CREATE TABLE drivers (
    drv_id TINYINT IDENTITY(1,1) PRIMARY KEY,
    drv_name VARCHAR(100) NOT NULL,
    drv_vehicle_plate VARCHAR(7) NOT NULL,
    drv_average_rating DECIMAL(3,2) NOT NULL
);

-- Creating the passengers table
CREATE TABLE passengers (
    psg_id TINYINT IDENTITY(1,1) PRIMARY KEY,
    psg_name VARCHAR(100) NOT NULL,
    psg_phone VARCHAR(14) NOT NULL
);

-- Creating the trips table
CREATE TABLE trips (
    tp_id TINYINT IDENTITY(1,1) PRIMARY KEY,
    tp_id_driver TINYINT NOT NULL,
    tp_id_passenger TINYINT NOT NULL,
    tp_date_time DATETIME NOT NULL,
    tp_origin VARCHAR(50) NOT NULL,
    tp_destination VARCHAR(50) NOT NULL,
    tp_distance_km SMALLINT NOT NULL,
    tp_price DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (tp_id_driver) REFERENCES drivers(drv_id),
    FOREIGN KEY (tp_id_passenger) REFERENCES passengers(psg_id)
);

-- Inserting data into drivers table
INSERT INTO drivers (drv_name, drv_vehicle_plate, drv_average_rating) VALUES
('Noah', 'ABC1D23', 4.77),
('Robert', 'EFG4H56', 5.00),
('Matt', 'IJK78L9', 3.00),
('Mary', 'ZDB6E87', 4.55),
('John', 'LQG3P54', 2.80);

-- Inserting data into passengers table
INSERT INTO passengers (psg_name, psg_phone) VALUES
('Victor', '(51)99999-9999'),
('Emma', '(51)98888-8888'),
('Thomas', '(51)97777-7777'),
('Gabriel', '(51)96666-6666'),
('Michael', '(51)95555-5555'),
('Olivia', '(51)94444-4444'),
('Dave', '(51)93333-3333');

-- Inserting data into trips table
INSERT INTO trips (tp_id_driver, tp_id_passenger, tp_date_time, tp_origin, tp_destination, tp_distance_km, tp_price) VALUES
(1, 1, '2023-01-30 10:00:00', 'São Leopoldo', 'Canudos', 11.8, 22.90),
(1, 2, '2023-02-27 11:00:00', 'Esteio', 'Caxias do Sul', 104.0, 158.58),
(1, 3, '2023-03-25 12:00:00', 'Erechim', 'Estância Velha', 337.0, 469.96),
(2, 4, '2023-04-20 13:00:00', 'Guaíba', 'Gravataí', 49.90, 69.93),
(2, 5, '2023-05-17 14:00:00', 'Viamão', 'Cachoeirinha', 18.2, 31.47),
(2, 6, '2023-06-15 15:00:00', 'Alvorada', 'Eldorado do Sul', 28.0, 34.99),
(2, 7, '2023-07-10 16:00:00', 'Sapiranga', 'Novo Hamburgo', 16.6, 26.90),
(4, 3, '2023-08-07 17:00:00', 'Parobé', 'Ivoti', 41.4, 63.85),
(4, 4, '2023-09-05 18:00:00', 'Montenegro', 'Portão', 27.8, 49.97),
(4, 5, '2023-10-03 19:00:00', 'Canela', 'Campo Bom', 74.8, 140.48);

-- Enabling settings for identity insert and transaction handling
SET NOCOUNT ON;
SET XACT_ABORT ON;

-- Updating drivers table
UPDATE drivers SET drv_vehicle_plate = 'DEF789' WHERE drv_name = 'Robert';
UPDATE drivers SET drv_average_rating = 0.5 WHERE drv_average_rating >= 4.0;

-- Updating trips table
UPDATE trips SET tp_price = 20.0 WHERE tp_date_time < '2023-06-01';
UPDATE trips SET tp_destination = 'Porto Alegre' WHERE tp_origin = 'São Leopoldo';
UPDATE trips SET tp_price = 250.00 WHERE tp_id_driver = 1 AND tp_id_passenger = 2;

-- Updating passengers table
UPDATE passengers SET psg_phone = '(51)91111-1111' WHERE psg_name = 'Victor';
UPDATE passengers SET psg_name = 'Isabella' WHERE psg_phone = '(51)96666-6666';

-- Some SELECT statements:

-- 1. Returning the name of the driver, the name of the passenger, and the distance traveled for all trips over 10 km
SELECT drv.drv_name AS Driver_name, psg.psg_name AS Passenger_name, trp.tp_distance_km AS Trip_distance_km
FROM trips trp
JOIN drivers drv ON trp.tp_id_driver = drv.drv_id
JOIN passengers psg ON trp.tp_id_passenger = psg.psg_id 
WHERE trp.tp_distance_km > 10.0;

-- 2. Returning the average rating of drivers
SELECT AVG(drv_average_rating) AS Driver_avg_rating FROM drivers;

-- 3. Listing all drivers who have not made any trips yet
SELECT drv.drv_name AS Driver_name FROM drivers drv
LEFT JOIN trips trp ON drv.drv_id = trp.tp_id_driver 
WHERE trp.tp_id IS NULL;

-- 4. Listing the average distance traveled for all trips and the average price of trips
SELECT AVG(tp_distance_km) AS Trip_distance_km, AVG(tp_price) AS Trip_price FROM trips;

-- Deleting trips:
DELETE FROM trips WHERE tp_distance_km < 5.0;
DELETE FROM trips WHERE tp_date_time < '2023-08-30 15:30:00';
DELETE FROM drivers WHERE drv_name = 'John';  -- Assuming 'Lucas' was a mistake in your code
DELETE FROM passengers WHERE psg_phone = '(51)94444-4444';
DELETE FROM trips WHERE tp_price > 200.00;
DELETE FROM trips WHERE tp_id_driver = 1;

-- Deleting all trips
DELETE FROM trips;
