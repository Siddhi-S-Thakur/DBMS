DROP DATABASE IF EXISTS bank_transactions_db;
CREATE DATABASE bank_transactions_db;
USE bank_transactions_db;

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
CREATE TABLE `Transaction` (
    Txn_id VARCHAR(8) PRIMARY KEY,
    Account_no VARCHAR(10),
    Txn_date DATE NOT NULL,
    Txn_type ENUM('Credit', 'Debit'),
    Amount DECIMAL(10,2) NOT NULL,
    Description VARCHAR(50)
    ,FOREIGN KEY (Account_no) REFERENCES Account(Account_no)
);
INSERT INTO `Transaction` (Txn_id, Account_no, Txn_date, Txn_type, Amount, Description)
VALUES
    ('T0000001', 'A0001001', '2024-03-01', 'Credit', '50000.00', 'Salary'),
    ('T0000002', 'A0001001', '2024-03-05', 'Debit', '10000.00', 'EMI'),
    ('T0000003', 'A0001002', '2024-03-10', 'Credit', '200000.00', 'Business'),
    ('T0000004', 'A0001003', '2024-03-15', 'Debit', '5000.00', 'Shopping'),
    ('T0000005', 'A0001005', '2024-03-20', 'Credit', '20000.00', 'Freelance'),
    ('T0000006', 'A0001006', '2024-03-25', 'Debit', '15000.00', 'Rent');
-- Q1
SELECT a.Customer_name, b.Branch_name
FROM Account a
JOIN Branch b ON b.Branch_code = a.Branch_code;
-- Q2
SELECT Customer_name, Balance
FROM Account
WHERE Account_no = (
    SELECT Account_no
    FROM `Transaction`
    WHERE Txn_id = 'T0000003'
);
-- Q3
SELECT
    Account_no,
    SUM(CASE WHEN Txn_type = 'Credit' THEN Amount ELSE 0 END) AS total_credited,
    SUM(CASE WHEN Txn_type = 'Debit' THEN Amount ELSE 0 END) AS total_debited
FROM `Transaction`
GROUP BY Account_no;
-- Q4
SELECT DISTINCT a.*
FROM Account a
JOIN `Transaction` t ON t.Account_no = a.Account_no
WHERE t.Txn_type = 'Debit'
  AND t.Amount > 10000;
