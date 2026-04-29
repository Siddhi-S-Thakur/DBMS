DROP DATABASE IF EXISTS hotel_filtering_db;
CREATE DATABASE hotel_filtering_db;
USE hotel_filtering_db;

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
-- Q1
SELECT * FROM Room WHERE Room_type = 'Suite' AND Status = 'Available';
-- Q2
SELECT MAX(Rate_per_night) AS maximum_rate, MIN(Rate_per_night) AS minimum_rate FROM Room;
-- Q3
SELECT Room_type, COUNT(*) AS room_count FROM Room GROUP BY Room_type;
-- Q4
SELECT * FROM Room ORDER BY Rate_per_night DESC;
-- Q5
DROP VIEW IF EXISTS room_status_view;
CREATE VIEW room_status_view AS SELECT Room_no, Room_type, Status FROM Room;
