DROP DATABASE IF EXISTS library_aggregation_views_db;
CREATE DATABASE library_aggregation_views_db;
USE library_aggregation_views_db;

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
CREATE TABLE Issue (
    Issue_id VARCHAR(6) PRIMARY KEY,
    Book_id VARCHAR(6),
    Member_id VARCHAR(6),
    Issue_date DATE NOT NULL,
    Return_date DATE,
    Status ENUM('Issued', 'Returned', 'Overdue'),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id),
    FOREIGN KEY (Member_id) REFERENCES Member(Member_id)
);
INSERT INTO Issue (Issue_id, Book_id, Member_id, Issue_date, Return_date, Status)
VALUES
    ('I00001', 'B00001', 'M00001', '2024-01-01', '2024-01-10', 'Returned'),
    ('I00002', 'B00002', 'M00002', '2024-01-05', '2024-01-15', 'Issued'),
    ('I00003', 'B00003', 'M00001', '2024-01-10', '2024-01-20', 'Overdue'),
    ('I00004', 'B00004', 'M00003', '2024-02-15', '2024-02-25', 'Returned'),
    ('I00005', 'B00005', 'M00004', '2024-02-20', '2024-03-01', 'Issued');
-- Q1
SELECT * FROM Book WHERE Category = 'CS';
-- Q2
SELECT Category, COUNT(*) AS book_count FROM Book GROUP BY Category;
-- Q3
UPDATE Book SET Price = 500.00 WHERE Book_id = 'B00001';
-- Q4
DROP VIEW IF EXISTS library_book_view;
CREATE VIEW library_book_view AS SELECT Book_id, Title, Author FROM Book;
-- Q5
SELECT SUM(Qty_available) AS total_quantity_available FROM Book;
