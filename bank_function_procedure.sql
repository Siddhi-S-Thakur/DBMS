DROP DATABASE IF EXISTS bank_function_procedure_db;
CREATE DATABASE bank_function_procedure_db;
USE bank_function_procedure_db;

CREATE TABLE `Transaction` (
    Txn_id VARCHAR(8) PRIMARY KEY,
    Account_no VARCHAR(10),
    Txn_date DATE NOT NULL,
    Txn_type ENUM('Credit', 'Debit'),
    Amount DECIMAL(10,2) NOT NULL,
    Description VARCHAR(50)
);
INSERT INTO `Transaction` (Txn_id, Account_no, Txn_date, Txn_type, Amount, Description)
VALUES
    ('T0000001', 'A0001001', '2024-03-01', 'Credit', '50000.00', 'Salary'),
    ('T0000002', 'A0001001', '2024-03-05', 'Debit', '10000.00', 'EMI'),
    ('T0000003', 'A0001002', '2024-03-10', 'Credit', '200000.00', 'Business'),
    ('T0000004', 'A0001003', '2024-03-15', 'Debit', '5000.00', 'Shopping'),
    ('T0000005', 'A0001005', '2024-03-20', 'Credit', '20000.00', 'Freelance'),
    ('T0000006', 'A0001006', '2024-03-25', 'Debit', '15000.00', 'Rent'),
    ('T0000007', 'A0001007', '2024-03-28', 'Credit', '12000.00', 'Refund');




DROP FUNCTION IF EXISTS classify_transaction_amount;
DELIMITER $$ 
 
CREATE FUNCTION txn_category(amt DECIMAL(10,2)) 
RETURNS VARCHAR(20) 
DETERMINISTIC 
BEGIN 
    DECLARE result VARCHAR(20); 
 
    IF amt > 50000 THEN 
        SET result = 'High Value'; 
    ELSEIF amt >= 10000 AND amt <= 50000 THEN 
        SET result = 'Mid Value'; 
    ELSE 
        SET result = 'Low Value'; 
    END IF; 
 
    RETURN result; 
END $$ 
 
DELIMITER ; 
SELECT Txn_id, classify_transaction_amount(Amount) AS transaction_label FROM `Transaction`;




-- Q2
DROP PROCEDURE IF EXISTS total_credit;
DELIMITER $$ 
CREATE PROCEDURE total_credit( 
IN acc_no VARCHAR(10), 
OUT total_amt DECIMAL(12,2) 
) 
BEGIN 
SELECT SUM(Amount) 
INTO total_amt 
FROM Transaction 
WHERE Account_no = acc_no AND Txn_type = 'Credit'; 
END $$ 
DELIMITER ;

CALL total_credit('A0001001', @result); 
SELECT @result AS Total_Credit;
