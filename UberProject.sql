CREATE TABLE drivers (
    id TINYINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    vehicle_plate VARCHAR(7) NOT NULL,
    average_rating DECIMAL(3,2) NOT NULL
);

CREATE TABLE passengers (
    id TINYINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(14) NOT NULL
);

CREATE TABLE trips (
    id TINYINT IDENTITY(1,1) PRIMARY KEY,
    id_driver TINYINT NOT NULL,
    id_passenger TINYINT NOT NULL,
    date_time DATETIME NOT NULL,
    origin VARCHAR(30) NOT NULL,
    destination VARCHAR(30) NOT NULL,
    distance_km SMALLINT NOT NULL,
    price DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (id_driver) REFERENCES drivers(id),
    FOREIGN KEY (id_passenger) REFERENCES passengers(id)
);

INSERT INTO drivers (name, vehicle_plate, average_rating) VALUES
('Noah', 'ABC1D23', 4.77),
('Robert', 'EFG4H56', 5.00),
('Matt', 'IJK78L9', 3.00),
('Mary', 'ZDB6E87', 4.55),
('John', 'LQG3P54', 2.80);

INSERT INTO passengers (name, phone) VALUES
('Victor', '(51)99999-9999'),
('Emma', '(51)98888-8888'),
('Thomas', '(51)97777-7777'),
('Gabriel', '(51)96666-6666'),
('Michael', '(51)95555-5555'),
('Olivia', '(51)94444-4444'),
('Dave', '(51)93333-3333');

INSERT INTO trips (id_driver, id_passenger, date_time, origin, destination, distance_km, price) VALUES
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

SET NOCOUNT ON;
SET XACT_ABORT ON;

SET IDENTITY_INSERT drivers ON;
UPDATE drivers SET vehicle_plate = 'DEF789' WHERE name = 'Robert';
UPDATE drivers SET average_rating = 0.5 WHERE average_rating >= 4.0;
SET IDENTITY_INSERT drivers OFF;

UPDATE trips SET price = 20.0 WHERE date_time < '2023-06-01';
UPDATE trips SET destination = 'Porto Alegre' WHERE origin = 'São Leopoldo';
UPDATE trips SET price = 250.00 WHERE id_driver = 1 AND id_passenger = 2;

UPDATE passengers SET phone = '(51)91111-1111' WHERE name = 'Victor';
UPDATE passengers SET name = 'Isabella' WHERE phone = '(51)96666-6666';


-- Some SELECTs:
-- Returning the name of the driver, the name of the passenger, and the distance traveled for all trips over 10 km.
SELECT drivers.name AS driver_name, p.name AS passenger_name, trips.distance_km 
FROM trips
JOIN drivers ON trips.id_driver = drivers.id
JOIN passengers p ON trips.id_passenger = p.id 
WHERE CAST(trips.distance_km AS DECIMAL(8,2)) > 10.0;

-- Returning the average rating of drivers:
SELECT AVG(average_rating) FROM drivers;

-- Listing all drivers who have not made any trips yet:
SELECT drivers.name FROM drivers
LEFT JOIN trips ON drivers.id = trips.id_driver 
WHERE trips.id IS NULL;

-- Listing the average distance traveled for all trips and the average price of trips:
SELECT AVG(distance_km), AVG(price) FROM trips;

-- Deleting trips:
DELETE FROM trips WHERE distance_km < 5.0;
DELETE FROM trips WHERE date_time < '2023-08-30 15:30:00';
DELETE FROM drivers WHERE name = 'Lucas';
DELETE FROM passengers WHERE phone = '(51)94444-4444';
DELETE FROM trips WHERE price > 200.00;
DELETE FROM trips WHERE id_driver = 1;

DELETE FROM trips;
