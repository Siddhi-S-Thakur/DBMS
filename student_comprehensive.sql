DROP DATABASE IF EXISTS student_comprehensive_db;
CREATE DATABASE student_comprehensive_db;
USE student_comprehensive_db;

CREATE TABLE Student (
    Student_id VARCHAR(6) PRIMARY KEY,
    First_name VARCHAR(20) NOT NULL,
    Last_name VARCHAR(20) NOT NULL,
    DOB DATE NOT NULL,
    Address VARCHAR(50),
    CGPA DECIMAL(4,2) NOT NULL,
    Class VARCHAR(10)
);
INSERT INTO Student (Student_id, First_name, Last_name, DOB, Address, CGPA, Class)
VALUES
    ('S00001', 'Anjali', 'Sharma', '2003-01-15', 'Mumbai', '9.20', 'IT-A'),
    ('S00002', 'Rohit', 'Verma', '2002-05-21', 'Pune', '8.10', 'CS-A'),
    ('S00003', 'Pooja', 'Nair', '2003-08-09', 'Bangalore', '7.40', 'EC-A'),
    ('S00004', 'Karan', 'Shah', '2001-12-30', 'Delhi', '6.80', 'ME-A'),
    ('S00005', 'Neha', 'Kulkarni', '2002-03-11', 'Chennai', '8.75', 'CS-B'),
    ('S00006', 'Arjun', 'Menon', '2003-09-18', 'Hyderabad', '7.95', 'IT-B'),
    ('S00007', 'Isha', 'Patel', '2002-07-27', 'Ahmedabad', '9.55', 'CS-A');
-- Q1
SELECT * FROM Student;
-- Q2
SELECT Student_id, CGPA FROM Student;
-- Q3
SELECT AVG(CGPA) AS average_cgpa FROM Student;
-- Q4
SELECT COUNT(*) AS total_students FROM Student;
-- Q5
SELECT Class, SUM(CGPA) AS total_cgpa, COUNT(*) AS class_count FROM Student GROUP BY Class;
-- Q6
SELECT * FROM Student WHERE CGPA > 8.0;
-- Q7
SELECT CONCAT(First_name, ' ', Last_name) AS student_name FROM Student ORDER BY student_name DESC;
-- Q8
SELECT * FROM Student WHERE First_name = 'Anjali' AND CGPA > 7.5;



-- Q9
DELIMITER // 
 
CREATE FUNCTION Get_Grade(cg DECIMAL(4,2)) 
RETURNS VARCHAR(20) 
DETERMINISTIC 
BEGIN 
    DECLARE grade VARCHAR(20); 
 
    IF cg >= 9 THEN 
        SET grade = 'Outstanding'; 
    ELSEIF cg >= 8 THEN 
        SET grade = 'Excellent'; 
    ELSEIF cg >= 7 THEN 
        SET grade = 'Good'; 
    ELSE 
        SET grade = 'Average'; 
    END IF; 
 
    RETURN grade; 
END //
 
DELIMITER ; 

SELECT First_name, CGPA, Get_Grade(CGPA) AS Grade 
FROM Student; 


