DROP DATABASE IF EXISTS library_function_cursor_db;
CREATE DATABASE library_function_cursor_db;
USE library_function_cursor_db;

CREATE TABLE Book (
    Book_id VARCHAR(6) PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    Author VARCHAR(30) NOT NULL,
    Category VARCHAR(20),
    Price DECIMAL(8,2) NOT NULL,
    Qty_available INT NOT NULL
);
INSERT INTO Book (Book_id, Title, Author, Category, Price, Qty_available)
VALUES
    ('B00001', 'Data Structures', 'Mark Allen', 'CS', '450.00', 10),
    ('B00002', 'DBMS Concepts', 'Korth', 'CS', '550.00', 8),
    ('B00003', 'Operating Systems', 'Galvin', 'CS', '600.00', 5),
    ('B00004', 'Computer Networks', 'Tanenbaum', 'CS', '700.00', 6),
    ('B00005', 'Algorithms', 'Cormen', 'CS', '850.00', 4),
    ('B00006', 'Discrete Math', 'Kenneth Rosen', 'Math', '400.00', 12),
    ('B00007', 'Python Programming', 'Lutz', 'CS', '500.00', 7);



-- Q1
DELIMITER // 
 
CREATE FUNCTION Price_Category(p DECIMAL(8,2)) 
RETURNS VARCHAR(20) 
DETERMINISTIC 
BEGIN 
    DECLARE category VARCHAR(20); 
 
    IF p < 400 THEN 
        SET category = 'Budget'; 
    ELSEIF p BETWEEN 400 AND 700 THEN 
        SET category = 'Mid-Range'; 
    ELSE 
        SET category = 'Premium'; 
    END IF; 
 
    RETURN category; 
END // 
 
DELIMITER ; 

SELECT Book_id, Title, Price, Price_Category(Price) AS Category_Label 
FROM Book; 



