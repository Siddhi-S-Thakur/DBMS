DROP DATABASE IF EXISTS hotel_function_procedure_db;
CREATE DATABASE hotel_function_procedure_db;
USE hotel_function_procedure_db;

CREATE TABLE Booking (
    Booking_id VARCHAR(6) PRIMARY KEY,
    Guest_id VARCHAR(6),
    Room_no VARCHAR(5),
    Check_in DATE NOT NULL,
    Check_out DATE,
    Total_amount DECIMAL(10,2) NOT NULL,
    Payment_status ENUM('Paid', 'Pending', 'Partial')
);
INSERT INTO Booking (Booking_id, Guest_id, Room_no, Check_in, Check_out, Total_amount, Payment_status)
VALUES
    ('K00001', 'G00001', 'R0101', '2024-01-10', '2024-01-14', '10000.00', 'Paid'),
    ('K00002', 'G00002', 'R0301', '2024-01-12', '2024-01-15', '30000.00', 'Pending'),
    ('K00003', 'G00003', 'R0201', '2024-01-20', '2024-01-22', '10000.00', 'Paid'),
    ('K00004', 'G00004', 'R0102', '2024-02-01', '2024-02-03', '5000.00', 'Partial'),
    ('K00005', 'G00005', 'R0302', '2024-02-10', '2024-02-13', '30000.00', 'Paid'),
    ('K00006', 'G00006', 'R0202', '2024-02-18', '2024-02-20', '10000.00', 'Pending'),
    ('K00007', 'G00007', 'R0101', '2024-03-01', '2024-03-02', '2500.00', 'Paid');


-- Q1
DELIMITER // 
 
CREATE FUNCTION Booking_Category(amount DECIMAL(10,2)) 
RETURNS VARCHAR(20) 
DETERMINISTIC 
BEGIN 
    DECLARE category VARCHAR(20); 
 
    IF amount > 20000 THEN 
        SET category = 'High Value'; 
    ELSEIF amount >= 10000 THEN 
        SET category = 'Medium Value'; 
    ELSE 
        SET category = 'Low Value'; 
    END IF; 
 
    RETURN category; 
END; 
// 
 
DELIMITER ; 

SELECT Booking_id, Total_amount, 
       Booking_Category(Total_amount) AS Category 
FROM Booking; 


-- Q2
DELIMITER // 
CREATE PROCEDURE Get_Total_Amount( 
IN g_id VARCHAR(6), 
OUT total DECIMAL(10,2) 
) 
BEGIN 
SELECT SUM(Total_amount) 
INTO total 
FROM Booking 
WHERE Guest_id = g_id; 
END // 
DELIMITER ; 

CALL Get_Total_Amount('G00001', @result); 
SELECT @result AS Total_Amount;
