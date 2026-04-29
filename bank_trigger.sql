DROP DATABASE IF EXISTS bank_trigger_cursor_db;
CREATE DATABASE bank_trigger_cursor_db;
USE bank_trigger_cursor_db;

CREATE TABLE Account (
    Account_no VARCHAR(10) PRIMARY KEY,
    Customer_name VARCHAR(30) NOT NULL,
    Account_type ENUM('Savings', 'Current', 'FD'),
    Branch_code VARCHAR(6),
    Balance DECIMAL(12,2) NOT NULL,
    Open_date DATE NOT NULL
);
INSERT INTO Account (Account_no, Customer_name, Account_type, Branch_code, Balance, Open_date)
VALUES
    ('A0001001', 'Sachin Tendulkar', 'Savings', 'B00001', '250000.00', '2010-01-15'),
    ('A0001002', 'Sunita Sharma', 'Current', 'B00002', '750000.00', '2015-03-20'),
    ('A0001003', 'Manish Gupta', 'Savings', 'B00001', '85000.00', '2018-06-10'),
    ('A0001004', 'Rekha Nair', 'FD', 'B00003', '1200000.00', '2020-08-05'),
    ('A0001005', 'Tanvir Ahmed', 'Savings', 'B00002', '45000.00', '2021-11-12'),
    ('A0001006', 'Poonam Jain', 'Current', 'B00003', '300000.00', '2022-01-01'),
    ('A0001007', 'Lakshmi Rao', 'Savings', 'B00004', '98000.00', '2023-04-18');



-- Q1
DROP TRIGGER IF EXISTS trg_uppercase_name;

DELIMITER $$ 
CREATE TRIGGER trg_uppercase_name 
BEFORE INSERT ON Account 
FOR EACH ROW 
BEGIN 
SET NEW.Customer_name = UPPER(NEW.Customer_name); 
END $$ 
DELIMITER ; 
 
INSERT INTO Account VALUES 
('A0001008','rahul sharma','Savings','B00001',50000.00,'2024-01-01'); 
SELECT * FROM Account; 

-- Q2
CREATE TABLE Acc_Backup AS SELECT * FROM Account;

-- Q3
ALTER TABLE Account ADD COLUMN Email VARCHAR(40);

