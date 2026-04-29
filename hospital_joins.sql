DROP DATABASE IF EXISTS hospital_joins_db;
CREATE DATABASE hospital_joins_db;
USE hospital_joins_db;

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
CREATE TABLE Appointment (
    Appt_id VARCHAR(6) PRIMARY KEY,
    Patient_id VARCHAR(6),
    Doctor_id VARCHAR(6),
    Appt_date DATE NOT NULL,
    Appt_time VARCHAR(10) NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id)
);
INSERT INTO Appointment (Appt_id, Patient_id, Doctor_id, Appt_date, Appt_time, Status)
VALUES
    ('A00001', 'P00001', 'D00001', '2024-01-10', '10:00 AM', 'Completed'),
    ('A00002', 'P00002', 'D00003', '2024-01-11', '11:30 AM', 'Scheduled'),
    ('A00003', 'P00003', 'D00002', '2024-01-12', '09:00 AM', 'Cancelled'),
    ('A00004', 'P00004', 'D00004', '2024-01-15', '02:00 PM', 'Completed'),
    ('A00005', 'P00005', 'D00001', '2024-01-20', '03:30 PM', 'Scheduled'),
    ('A00006', 'P00006', 'D00005', '2024-01-22', '10:00 AM', 'Completed');
-- Q1
SELECT p.Name AS patient_name, d.Name AS doctor_name
FROM Appointment a
JOIN Patient p ON p.Patient_id = a.Patient_id
JOIN Doctor d ON d.Doctor_id = a.Doctor_id
WHERE a.Status = 'Completed';
-- Q2
SELECT Name, City
FROM Patient
WHERE Patient_id = (
    SELECT Patient_id
    FROM Appointment
    WHERE Appt_id = 'A00003'
);
-- Q3
SELECT d.Doctor_id, d.Name, COUNT(*) AS appointment_count
FROM Appointment a
JOIN Doctor d ON d.Doctor_id = a.Doctor_id
GROUP BY d.Doctor_id, d.Name
ORDER BY appointment_count DESC;
-- Q4
SELECT * FROM Doctor WHERE Fees > (SELECT AVG(Fees) FROM Doctor);
