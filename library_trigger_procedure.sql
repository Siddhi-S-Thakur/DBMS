DROP DATABASE IF EXISTS library_trigger_procedure_db;
CREATE DATABASE library_trigger_procedure_db;
USE library_trigger_procedure_db;

CREATE TABLE Member (
    Member_id VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    City VARCHAR(20),
    State VARCHAR(20),
    Phone BIGINT,
    Membership_type ENUM('Gold', 'Silver', 'Basic')
);
INSERT INTO Member (Member_id, Name, City, State, Phone, Membership_type)
VALUES
    ('M00001', 'Rahul Sharma', 'Mumbai', 'Maharashtra', '9876543210', 'Gold'),
    ('M00002', 'Priya Mehta', 'Pune', 'Maharashtra', '9876500001', 'Silver'),
    ('M00003', 'Arun Kumar', 'Delhi', 'Delhi', '9876500002', 'Basic'),
    ('M00004', 'Sneha Patil', 'Bangalore', 'Karnataka', '9876500003', 'Gold'),
    ('M00005', 'Vijay Nair', 'Chennai', 'Tamil Nadu', '9876500004', 'Silver'),
    ('M00006', 'Kiran Das', 'Hyderabad', 'Telangana', '9876500005', 'Basic'),
    ('M00007', 'Meera Joshi', 'Ahmedabad', 'Gujarat', '9876500006', 'Gold');
CREATE TABLE Issue (
    Issue_id VARCHAR(6) PRIMARY KEY,
    Book_id VARCHAR(6),
    Member_id VARCHAR(6),
    Issue_date DATE NOT NULL,
    Return_date DATE,
    Status ENUM('Issued', 'Returned', 'Overdue'),
    FOREIGN KEY (Member_id) REFERENCES Member(Member_id)
);
INSERT INTO Issue (Issue_id, Book_id, Member_id, Issue_date, Return_date, Status)
VALUES
    ('I00001', 'B00001', 'M00001', '2024-01-01', '2024-01-10', 'Returned'),
    ('I00002', 'B00002', 'M00002', '2024-01-05', '2024-01-15', 'Issued'),
    ('I00003', 'B00003', 'M00001', '2024-01-10', '2024-01-20', 'Overdue'),
    ('I00004', 'B00004', 'M00003', '2024-02-15', '2024-02-25', 'Returned'),
    ('I00005', 'B00005', 'M00004', '2024-02-20', '2024-03-01', 'Issued'),
    ('I00006', 'B00006', 'M00005', '2024-03-05', '2024-03-15', 'Returned'),
    ('I00007', 'B00007', 'M00006', '2024-03-10', '2024-03-20', 'Issued');



-- Q1
DELIMITER $$ 
 
CREATE TRIGGER trg_member_uppercase 
BEFORE INSERT ON Member 
FOR EACH ROW 
BEGIN 
    SET NEW.Name = UPPER(NEW.Name); 
END$$ 
 
DELIMITER ; 
 
INSERT INTO Member VALUES 
(8, 'yash', 'Mumbai', 'Maharashtra', '9999999999', 'Gold'); 
 
SELECT * FROM Member; 




-- Q2
DROP PROCEDURE IF EXISTS get_member_issue_count;
DELIMITER $$
CREATE PROCEDURE get_member_issue_count(IN p_member_id VARCHAR(6), OUT p_total INT)
BEGIN
    SELECT COUNT(*)
    INTO p_total
    FROM Issue
    WHERE Member_id = p_member_id
      AND Status = 'Issued';
END$$
DELIMITER ;

SET @member_issue_total = 0;
CALL get_member_issue_count('M00001', @member_issue_total);
SELECT @member_issue_total AS total_books_currently_issued;
