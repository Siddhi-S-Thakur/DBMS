DROP DATABASE IF EXISTS worker_title_queries_db;
CREATE DATABASE worker_title_queries_db;
USE worker_title_queries_db;

CREATE TABLE Worker (
    Worker_id INT PRIMARY KEY,
    First_name VARCHAR(20),
    Last_name VARCHAR(20),
    Salary DECIMAL(10,2),
    Joining_date DATE,
    Department VARCHAR(20)
);
INSERT INTO Worker (Worker_id, First_name, Last_name, Salary, Joining_date, Department)
VALUES
    (1, 'Rohan', 'Mehta', '120000.00', '2019-03-15', 'HR'),
    (2, 'Swati', 'Joshi', '95000.00', '2020-07-22', 'IT'),
    (3, 'Anil', 'Nair', '250000.00', '2018-01-10', 'IT'),
    (4, 'Deepa', 'Sharma', '450000.00', '2017-06-01', 'Finance'),
    (5, 'Vikas', 'Rao', '450000.00', '2020-11-30', 'Finance'),
    (6, 'Kavya', 'Patel', '175000.00', '2021-03-05', 'Ops'),
    (7, 'Suraj', 'Das', '70000.00', '2016-09-20', 'Ops'),
    (8, 'Neha', 'Bhat', '88000.00', '2022-04-11', 'HR');
CREATE TABLE Bonus (
    Worker_id INT,
    Bonus_date DATE,
    Bonus_amount DECIMAL(10,2)
);
INSERT INTO Bonus (Worker_id, Bonus_date, Bonus_amount)
VALUES
    (1, '2023-03-15', '7000.00'),
    (2, '2023-07-22', '4500.00'),
    (3, '2023-01-10', '6000.00'),
    (1, '2023-09-01', '5500.00'),
    (4, '2023-06-01', '8000.00');
CREATE TABLE Title (
    Worker_id INT PRIMARY KEY,
    Worker_title VARCHAR(30),
    Affected_from DATE
);
INSERT INTO Title (Worker_id, Worker_title, Affected_from)
VALUES
    (1, 'Senior Manager', '2022-01-01'),
    (2, 'Tech Lead', '2022-06-11'),
    (8, 'Executive', '2023-01-01'),
    (5, 'Manager', '2022-11-11'),
    (4, 'Director', '2021-06-01'),
    (7, 'Senior Exec', '2023-04-01'),
    (6, 'Lead Analyst', '2022-03-01'),
    (3, 'Architect', '2021-01-10');
-- Q1
SELECT * FROM Worker WHERE First_name LIKE '%a' AND LENGTH(First_name) >= 5;
-- Q2
SELECT * FROM Worker WHERE Salary BETWEEN 90000 AND 450000;
-- Q3
SELECT COUNT(*) AS ops_employee_count FROM Worker WHERE Department = 'Ops';
-- Q4
SELECT w.*
FROM Worker w
JOIN Title t ON t.Worker_id = w.Worker_id
WHERE t.Worker_title IN ('Manager', 'Senior Manager');
-- Q5
DESCRIBE Bonus;
