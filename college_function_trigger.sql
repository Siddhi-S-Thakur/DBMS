DROP DATABASE IF EXISTS college_function_trigger_db;
CREATE DATABASE college_function_trigger_db;
USE college_function_trigger_db;

CREATE TABLE Student (
    Student_id VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Branch VARCHAR(20) NOT NULL,
    Semester INT,
    City VARCHAR(20),
    CGPA DECIMAL(4,2) NOT NULL,
    Email VARCHAR(30) NOT NULL
);
INSERT INTO Student (Student_id, Name, Branch, Semester, City, CGPA, Email)
VALUES
    ('S00001', 'Ananya Tiwari', 'IT', 6, 'Mumbai', '8.50', 'ananya@college.edu'),
    ('S00002', 'Rohan Verma', 'CS', 4, 'Pune', '7.80', 'rohan@college.edu'),
    ('S00003', 'Pooja Nair', 'EC', 6, 'Bangalore', '9.10', 'pooja@college.edu'),
    ('S00004', 'Karan Shah', 'ME', 8, 'Delhi', '6.90', 'karan@college.edu'),
    ('S00005', 'Divya Pillai', 'CS', 2, 'Chennai', '8.20', 'divya@college.edu'),
    ('S00006', 'Arjun Menon', 'IT', 4, 'Mumbai', '7.50', 'arjun@college.edu'),
    ('S00007', 'Neha Kulkarni', 'CS', 6, 'Hyderabad', '9.00', 'neha@college.edu');
CREATE TABLE Student_Audit (
    Audit_id INT AUTO_INCREMENT PRIMARY KEY,
    Student_id VARCHAR(6),
    Old_CGPA DECIMAL(4,2),
    New_CGPA DECIMAL(4,2),
    Changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Q1
DROP FUNCTION IF EXISTS GetClass;
DELIMITER $$ 
CREATE FUNCTION GetClass(cgpa DECIMAL(3,2)) 
RETURNS VARCHAR(20) 
DETERMINISTIC 
BEGIN 
    DECLARE result VARCHAR(20); 
 
    IF cgpa >= 9 THEN 
        SET result = 'Distinction'; 
    ELSEIF cgpa >= 7 THEN 
        SET result = 'First Class'; 
    ELSEIF cgpa >= 5.5 THEN 
        SET result = 'Second Class'; 
    ELSEIF cgpa >= 4 THEN 
        SET result = 'Pass'; 
    ELSE 
        SET result = 'Fail'; 
    END IF; 
 
    RETURN result; 
END$$ 
 
DELIMITER ; 
 
SELECT Student_id, Name, CGPA, GetClass(CGPA) AS Class 
FROM Student;



-- Q2
DROP TRIGGER IF EXISTS trg_student_audit_update;
DELIMITER $$
CREATE TRIGGER trg_student_audit_update
AFTER UPDATE ON Student
FOR EACH ROW
BEGIN
    INSERT INTO Student_Audit (Student_id, Old_CGPA, New_CGPA)
    VALUES (OLD.Student_id, OLD.CGPA, NEW.CGPA);
END$$
DELIMITER ;
UPDATE Student SET CGPA = 8.80 WHERE Student_id = 'S00001';
SELECT * FROM Student_Audit;
