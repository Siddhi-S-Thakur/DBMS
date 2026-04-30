DROP DATABASE IF EXISTS library_basic_db;
CREATE DATABASE library_basic_db;
USE library_basic_db;

CREATE TABLE Book (
    Book_id VARCHAR(6) PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    Author VARCHAR(30) NOT NULL,
    Category VARCHAR(20),
    Price DECIMAL(8,2) NOT NULL,
    Qty_available INT NOT NULL
);
INSERT INTO Book (Book_id, Title, Author, Category, Price, Qty_available)
VALUES
    ('B00001', 'Data Structures', 'Mark Allen', 'CS', '450.00', 10),
    ('B00002', 'DBMS Concepts', 'Korth', 'CS', '550.00', 8),
    ('B00003', 'Operating Systems', 'Galvin', 'CS', '600.00', 5),
    ('B00004', 'Computer Networks', 'Tanenbaum', 'CS', '700.00', 6),
    ('B00005', 'Algorithms', 'Cormen', 'CS', '850.00', 4),
    ('B00006', 'Discrete Math', 'Kenneth Rosen', 'Math', '400.00', 12),
    ('B00007', 'Python Programming', 'Lutz', 'CS', '500.00', 7);
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
    ('M00005', 'Vijay Nair', 'Chennai', 'Tamil Nadu', '9876500004', 'Silver');
-- Q1
SELECT * FROM Book;
-- Q2
RENAME TABLE Book TO Book_Master;
-- Q3
SELECT COUNT(*) AS total_number_of_books FROM Book_Master;
-- Q4
SELECT Name, City FROM Member;
