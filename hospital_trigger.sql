DROP DATABASE IF EXISTS hospital_trigger_cursor_db;
CREATE DATABASE hospital_trigger_cursor_db;
USE hospital_trigger_cursor_db;

CREATE TABLE Doctor (
    Doctor_id VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Specialization VARCHAR(30) NOT NULL,
    Department VARCHAR(20),
    Fees DECIMAL(8,2) NOT NULL,
    Experience_yrs INT
);
INSERT INTO Doctor (Doctor_id, Name, Specialization, Department, Fees, Experience_yrs)
VALUES
    ('D00001', 'Dr. Kapoor', 'Cardiology', 'Cardio', '1500.00', 15),
    ('D00002', 'Dr. Reddy', 'Neurology', 'Neuro', '2000.00', 20),
    ('D00003', 'Dr. Iyer', 'Orthopedics', 'Ortho', '1200.00', 10),
    ('D00004', 'Dr. Sharma', 'Dermatology', 'Skin', '800.00', 8),
    ('D00005', 'Dr. Bose', 'Pediatrics', 'Paeds', '900.00', 12),
    ('D00006', 'Dr. Khan', 'Oncology', 'Cancer', '1800.00', 14),
    ('D00007', 'Dr. Menon', 'Radiology', 'Imaging', '1600.00', 11);


-- Q1
DELIMITER $$ 
 
CREATE TRIGGER trg_specialization_titlecase 
BEFORE INSERT ON Doctor 
FOR EACH ROW 
BEGIN 
    SET NEW.Specialization = CONCAT( 
        UPPER(LEFT(NEW.Specialization, 1)), 
        LOWER(SUBSTRING(NEW.Specialization, 2)) 
    ); 
END$$ 
DELIMITER ; 

INSERT INTO Doctor VALUES ('D008', 'Test Doctor', 'cardiology', 'Heart', 500, 3); 
SELECT Doctor_id, Specialization FROM Doctor WHERE Doctor_id = 'D008'; 


-- Q2
CREATE TABLE Doctor_Backup AS SELECT * FROM Doctor;
-- Q3
ALTER TABLE Doctor ADD COLUMN Qualification VARCHAR(50);
-- Q4
DESC Doctor;
