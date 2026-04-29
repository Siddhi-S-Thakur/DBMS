DROP DATABASE IF EXISTS hotel_trigger_cursor_db;
CREATE DATABASE hotel_trigger_cursor_db;
USE hotel_trigger_cursor_db;

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
    ('G00005', 'Priyanka Sen', 'Kolkata', 'India', '9811005500', 'priya@mail.com'),
    ('G00006', 'Amit Verma', 'Delhi', 'India', '9811006600', 'amit@mail.com'),
    ('G00007', 'Sara Lee', 'Singapore', 'Singapore', '9811007700', 'sara@mail.com');
CREATE TABLE Guest_Audit (
    Audit_id INT AUTO_INCREMENT PRIMARY KEY,
    Guest_id VARCHAR(6),
    Old_Email VARCHAR(30),
    New_Email VARCHAR(30),
    Changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Q1
DELIMITER // 
CREATE TRIGGER trg_guest_update 
AFTER UPDATE ON Guest 
FOR EACH ROW 
BEGIN 
INSERT INTO Guest_Audit 
VALUES (OLD.Guest_id, OLD.Name, OLD.City, OLD.Country, OLD.Phone, OLD.Email, 
CURDATE()); 
END; 
// 
DELIMITER ; 

UPDATE Guest 
SET City = 'Bangalore' 
WHERE Guest_id = 'G00001'; 
SELECT * FROM Guest_Audit; 




-- Q2
CREATE TABLE Guest_Backup AS SELECT * FROM Guest;

-- Q3
ALTER TABLE Guest ADD COLUMN Loyalty_points INT;


