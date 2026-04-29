DROP DATABASE IF EXISTS hotel_basic_db;
CREATE DATABASE hotel_basic_db;
USE hotel_basic_db;

CREATE TABLE Room (
    Room_no VARCHAR(5) PRIMARY KEY,
    Room_type ENUM('Standard', 'Deluxe', 'Suite'),
    Floor_no INT NOT NULL,
    Capacity INT NOT NULL,
    Rate_per_night DECIMAL(8,2) NOT NULL,
    Status ENUM('Available', 'Occupied', 'Maintenance')
);
INSERT INTO Room (Room_no, Room_type, Floor_no, Capacity, Rate_per_night, Status)
VALUES
    ('R0101', 'Standard', 1, 2, '2500.00', 'Available'),
    ('R0102', 'Standard', 1, 2, '2500.00', 'Occupied'),
    ('R0201', 'Deluxe', 2, 3, '5000.00', 'Available'),
    ('R0202', 'Deluxe', 2, 3, '5000.00', 'Maintenance'),
    ('R0301', 'Suite', 3, 4, '10000.00', 'Occupied'),
    ('R0302', 'Suite', 3, 4, '10000.00', 'Available');
CREATE TABLE Guest (
    Guest_id VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    City VARCHAR(20),
    Country VARCHAR(20) DEFAULT 'India',
    Phone BIGINT NOT NULL,
    Email VARCHAR(30)
);
INSERT INTO Guest (Guest_id, Name, City, Country, Phone, Email)
VALUES
    ('G00001', 'Nidhi Kapoor', 'Mumbai', 'India', '9811001100', 'nidhi@mail.com'),
    ('G00002', 'James Smith', 'London', 'UK', '9811002200', 'james@mail.com'),
    ('G00003', 'Akira Tanaka', 'Tokyo', 'Japan', '9811003300', 'akira@mail.com'),
    ('G00004', 'Rashida Khan', 'Dubai', 'UAE', '9811004400', 'rashida@mail.com'),
    ('G00005', 'Priyanka Sen', 'Kolkata', 'India', '9811005500', 'priya@mail.com');
-- Q1
SELECT * FROM Room;
-- Q2
SELECT * FROM Guest WHERE Country = 'India';
-- Q3
SELECT COUNT(*) AS total_available_rooms FROM Room WHERE Status = 'Available';
-- Q4
RENAME TABLE Guest TO Guest_Register;
