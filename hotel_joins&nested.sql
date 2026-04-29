DROP DATABASE IF EXISTS hotel_bookings_db;
CREATE DATABASE hotel_bookings_db;
USE hotel_bookings_db;

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
CREATE TABLE Booking (
    Booking_id VARCHAR(6) PRIMARY KEY,
    Guest_id VARCHAR(6),
    Room_no VARCHAR(5),
    Check_in DATE NOT NULL,
    Check_out DATE,
    Total_amount DECIMAL(10,2) NOT NULL,
    Payment_status ENUM('Paid', 'Pending', 'Partial'),
    FOREIGN KEY (Guest_id) REFERENCES Guest(Guest_id),
    FOREIGN KEY (Room_no) REFERENCES Room(Room_no)
);
INSERT INTO Booking (Booking_id, Guest_id, Room_no, Check_in, Check_out, Total_amount, Payment_status)
VALUES
    ('K00001', 'G00001', 'R0101', '2024-01-10', '2024-01-14', '10000.00', 'Paid'),
    ('K00002', 'G00002', 'R0301', '2024-01-12', '2024-01-15', '30000.00', 'Pending'),
    ('K00003', 'G00003', 'R0201', '2024-01-20', '2024-01-22', '10000.00', 'Paid'),
    ('K00004', 'G00004', 'R0102', '2024-02-01', '2024-02-03', '5000.00', 'Partial'),
    ('K00005', 'G00005', 'R0302', '2024-02-10', '2024-02-13', '30000.00', 'Paid');
    
    
    
-- Q1
SELECT g.Name AS guest_name, r.Room_type
FROM Booking b
JOIN Guest g ON g.Guest_id = b.Guest_id
JOIN Room r ON r.Room_no = b.Room_no
WHERE b.Payment_status = 'Paid';


-- Q2
SELECT Name, Country
FROM Guest
WHERE Guest_id = (
    SELECT Guest_id
    FROM Booking
    WHERE Booking_id = 'K00002'
);


-- Q3
SELECT r.Room_type, SUM(b.Total_amount) AS total_revenue
FROM Booking b
JOIN Room r ON r.Room_no = b.Room_no
GROUP BY r.Room_type;


-- Q4
SELECT g.Name 
FROM Guest g 
JOIN Booking b ON g.Guest_id = b.Guest_id 
WHERE b.Payment_status = 'Pending';
