DROP DATABASE IF EXISTS employee_department_queries_db;
CREATE DATABASE employee_department_queries_db;
USE employee_department_queries_db;

CREATE TABLE Department (
    Dept_no VARCHAR(3) PRIMARY KEY,
    Dept_name VARCHAR(30) NOT NULL,
    Location VARCHAR(30) NOT NULL
);
INSERT INTO Department (Dept_no, Dept_name, Location)
VALUES
    ('D01', 'Research', 'Hyderabad'),
    ('D02', 'Development', 'Pune'),
    ('D03', 'Quality Assurance', 'Noida');
CREATE TABLE Employee (
    Emp_no VARCHAR(4) PRIMARY KEY,
    Emp_name VARCHAR(30) NOT NULL,
    Job VARCHAR(20),
    Hire_date DATE,
    Dept_no VARCHAR(3),
    Salary DECIMAL(10,2),
    FOREIGN KEY (Dept_no) REFERENCES Department(Dept_no)
);
INSERT INTO Employee (Emp_no, Emp_name, Job, Hire_date, Dept_no, Salary)
VALUES
    ('E001', 'Aarav Shah', 'Analyst', '2020-01-15', 'D01', '55000.00'),
    ('E002', 'Priya Iyer', 'Developer', '2021-03-20', 'D02', '65000.00'),
    ('E003', 'Neeraj Bose', 'Manager', '2018-06-10', 'D01', '90000.00'),
    ('E004', 'Sunita Roy', 'Tester', '2022-08-01', 'D03', '45000.00'),
    ('E005', 'Rahul Sinha', 'Developer', '2020-11-15', 'D02', '70000.00');
-- Q1
SELECT * FROM Employee;
-- Q2
SELECT * FROM Employee WHERE Dept_no = 'D01' AND Job != 'Manager';
-- Q3
SELECT COUNT(*) AS total_employees FROM Employee;
-- Q4
SELECT COUNT(*) AS developer_count FROM Employee WHERE Job = 'Developer' AND Hire_date > '2020-01-01';
-- Q5
DROP VIEW IF EXISTS employee_department_view;
CREATE VIEW employee_department_view AS SELECT Emp_no, Emp_name, Dept_no FROM Employee;
