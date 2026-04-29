DROP DATABASE IF EXISTS hospital_function_procedure_db;
CREATE DATABASE hospital_function_procedure_db;
USE hospital_function_procedure_db;

CREATE TABLE Appointment (
    Appt_id VARCHAR(6) PRIMARY KEY,
    Patient_id VARCHAR(6),
    Doctor_id VARCHAR(6),
    Appt_date DATE NOT NULL,
    Appt_time VARCHAR(10) NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled')
);
INSERT INTO Appointment (Appt_id, Patient_id, Doctor_id, Appt_date, Appt_time, Status)
VALUES
    ('A00001', 'P00001', 'D00001', '2024-01-10', '10:00 AM', 'Completed'),
    ('A00002', 'P00002', 'D00003', '2024-01-11', '11:30 AM', 'Scheduled'),
    ('A00003', 'P00003', 'D00002', '2024-01-12', '09:00 AM', 'Cancelled'),
    ('A00004', 'P00004', 'D00004', '2024-01-15', '02:00 PM', 'Completed'),
    ('A00005', 'P00005', 'D00001', '2024-01-20', '03:30 PM', 'Scheduled'),
    ('A00006', 'P00006', 'D00005', '2024-01-22', '10:00 AM', 'Completed'),
    ('A00007', 'P00002', 'D00001', '2024-01-25', '04:00 PM', 'Scheduled');


-- Q1
DELIMITER $$ 
 
CREATE FUNCTION GetPriority(status_val VARCHAR(20)) 
RETURNS VARCHAR(20) 
DETERMINISTIC 
BEGIN 
    DECLARE priority_val VARCHAR(20); 
 
    IF status_val = 'Cancelled' THEN 
        SET priority_val = 'Urgent'; 
    ELSEIF status_val = 'Completed' THEN 
        SET priority_val = 'Normal'; 
    ELSEIF status_val = 'Scheduled' THEN 
        SET priority_val = 'Pending'; 
    ELSE 
        SET priority_val = 'Unknown'; 
    END IF; 
RETURN priority_val; 
END$$ 
DELIMITER ; 

SELECT Appt_id, Status, GetPriority(Status) AS Priority 
FROM Appointment;


-- Q2
DELIMITER $$ 
CREATE PROCEDURE GetAppointmentCount( 
IN doc_id VARCHAR(10), 
OUT total_count INT 
) 
BEGIN 
SELECT COUNT(*) INTO total_count 
FROM Appointment 
WHERE Doctor_id = doc_id; 
END$$ 
DELIMITER ; 

CALL GetAppointmentCount('D001', @count); 
SELECT @count AS Total_Appointments; 

