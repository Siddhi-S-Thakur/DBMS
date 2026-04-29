DROP DATABASE IF EXISTS employee_management_operations_db;
CREATE DATABASE employee_management_operations_db;
USE employee_management_operations_db;

CREATE TABLE Employee (
    Employee_id VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(30),
    Designation VARCHAR(30) NOT NULL,
    Branch VARCHAR(30),
    Date_of_joining DATE,
    Date_of_superannuation DATE,
    Salary DECIMAL(10,2)
);
INSERT INTO Employee (Employee_id, Name, Designation, Branch, Date_of_joining, Date_of_superannuation, Salary)
VALUES
    ('E00001', 'Asha Menon', 'Analyst', 'Mumbai', '2015-06-15', '2035-06-15', '65000.00'),
    ('E00002', 'Ravi Kumar', 'Manager', 'Delhi', '2012-03-10', '2032-03-10', '95000.00'),
    ('E00003', 'Nikita Rao', 'Developer', 'Bangalore', '2018-09-01', '2038-09-01', '72000.00'),
    ('E00004', 'Sanjay Patel', 'HR', 'Mumbai', '2016-11-20', '2036-11-20', '54000.00'),
    ('E00005', 'Meera Shah', 'Tester', 'Pune', '2019-01-05', '2039-01-05', '50000.00'),
    ('E00006', 'Aditya Jain', 'Developer', 'Delhi', '2021-07-12', '2041-07-12', '68000.00'),
    ('E00007', 'Kriti Sinha', 'Architect', 'Bangalore', '2014-04-25', '2034-04-25', '110000.00');
-- Q1
ALTER TABLE Employee ADD COLUMN Department VARCHAR(30);
-- Q2
DESCRIBE Employee;
-- Q3
CREATE TABLE Emp_Archive AS SELECT * FROM Employee;


-- Q4
DROP TRIGGER IF EXISTS trg_employee_uppercase;
DELIMITER // 
CREATE TRIGGER before_insert_employee 
BEFORE INSERT ON Employee 
FOR EACH ROW 
BEGIN 
SET NEW.Name = UPPER(NEW.Name); 
END; 
// 
DELIMITER ; 

INSERT INTO Employee  
VALUES ('E008', 'anirudh', 'Developer', 'Mumbai', '2022-01-01', '2042-01-01', 80000, 'IT'); 
SELECT Employee_id, Name FROM Employee;


-- Q5
CREATE VIEW Branch_View AS 
SELECT Branch, Salary 
FROM Employee; 
DELIMITER // 
CREATE PROCEDURE Get_Total_Salary ( 
IN b_name VARCHAR(20), 
OUT total INT 
) 
BEGIN 
SELECT SUM(Salary) 
INTO total 
FROM Employee 
WHERE Branch = b_name; 
END; 
// 
DELIMITER ; 

CALL Get_Total_Salary('Pune', @total); 
SELECT @total;
