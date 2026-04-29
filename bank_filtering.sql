DROP DATABASE IF EXISTS bank_filtering_db;
CREATE DATABASE bank_filtering_db;
USE bank_filtering_db;

CREATE TABLE Branch (
    Branch_code VARCHAR(6) PRIMARY KEY,
    Branch_name VARCHAR(30) NOT NULL,
    City VARCHAR(20) NOT NULL,
    State VARCHAR(20),
    IFSC VARCHAR(11) NOT NULL,
    Manager VARCHAR(30)
);
INSERT INTO Branch (Branch_code, Branch_name, City, State, IFSC, Manager)
VALUES
    ('B00001', 'Andheri Branch', 'Mumbai', 'Maharashtra', 'SBIN0001234', 'Mr. Desai'),
    ('B00002', 'Connaught Place', 'Delhi', 'Delhi', 'SBIN0001235', 'Ms. Kapoor'),
    ('B00003', 'MG Road', 'Bangalore', 'Karnataka', 'SBIN0001236', 'Mr. Rao'),
    ('B00004', 'Anna Nagar', 'Chennai', 'Tamil Nadu', 'SBIN0001237', 'Ms. Iyer');
CREATE TABLE Account (
    Account_no VARCHAR(10) PRIMARY KEY,
    Customer_name VARCHAR(30) NOT NULL,
    Account_type ENUM('Savings', 'Current', 'FD'),
    Branch_code VARCHAR(6),
    Balance DECIMAL(12,2) NOT NULL,
    Open_date DATE NOT NULL
    ,FOREIGN KEY (Branch_code) REFERENCES Branch(Branch_code)
);
INSERT INTO Account (Account_no, Customer_name, Account_type, Branch_code, Balance, Open_date)
VALUES
    ('A0001001', 'Sachin Tendulkar', 'Savings', 'B00001', '250000.00', '2010-01-15'),
    ('A0001002', 'Sunita Sharma', 'Current', 'B00002', '750000.00', '2015-03-20'),
    ('A0001003', 'Manish Gupta', 'Savings', 'B00001', '85000.00', '2018-06-10'),
    ('A0001004', 'Rekha Nair', 'FD', 'B00003', '1200000.00', '2020-08-05'),
    ('A0001005', 'Tanvir Ahmed', 'Savings', 'B00002', '45000.00', '2021-11-12'),
    ('A0001006', 'Poonam Jain', 'Current', 'B00003', '300000.00', '2022-01-01');
-- Q1
SELECT * FROM Account WHERE Balance > 200000;
-- Q2
SELECT * FROM Account WHERE Customer_name LIKE '_a%';
-- Q3
SELECT MAX(Balance) AS maximum_balance, MIN(Balance) AS minimum_balance FROM Account;
-- Q4
SELECT Account_type, COUNT(*) AS account_count FROM Account GROUP BY Account_type;
-- Q5
DROP VIEW IF EXISTS account_type_view;
CREATE VIEW account_type_view AS SELECT Account_no, Customer_name, Account_type FROM Account;
