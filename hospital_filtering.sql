DROP DATABASE IF EXISTS hospital_filtering_db;
CREATE DATABASE hospital_filtering_db;
USE hospital_filtering_db;

CREATE TABLE Patient (
    Patient_id VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Age INT NOT NULL,
    Gender ENUM('M', 'F'),
    City VARCHAR(20),
    Blood_group VARCHAR(5),
    Contact BIGINT
);
INSERT INTO Patient (Patient_id, Name, Age, Gender, City, Blood_group, Contact)
VALUES
    ('P00001', 'Aarav Joshi', 35, 'M', 'Mumbai', 'A+', '9900001111'),
    ('P00002', 'Meena Rao', 28, 'F', 'Pune', 'B+', '9900002222'),
    ('P00003', 'Suresh Pillai', 45, 'M', 'Chennai', 'O+', '9900003333'),
    ('P00004', 'Kavita Singh', 32, 'F', 'Delhi', 'AB+', '9900004444'),
    ('P00005', 'Rohit Gupta', 52, 'M', 'Kolkata', 'A-', '9900005555'),
    ('P00006', 'Lata Desai', 40, 'F', 'Mumbai', 'B-', '9900006666');
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
    ('D00005', 'Dr. Bose', 'Pediatrics', 'Paeds', '900.00', 12);
-- Q1
SELECT * FROM Patient WHERE City IN ('Mumbai', 'Delhi');
-- Q2
SELECT * FROM Patient WHERE Name LIKE '%an%';
-- Q3
UPDATE Patient SET Contact = 9811223344 WHERE Patient_id = 'P00003';
-- Q4
SELECT MIN(Fees) AS minimum_consultation_fees FROM Doctor;
-- Q5
DROP VIEW IF EXISTS doctor_specialization_view;
CREATE VIEW doctor_specialization_view AS SELECT Doctor_id, Name, Specialization FROM Doctor;
