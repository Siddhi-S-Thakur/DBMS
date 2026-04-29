DROP DATABASE IF EXISTS college_basic_db;
CREATE DATABASE college_basic_db;
USE college_basic_db;

CREATE TABLE Student (
    Student_id VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Branch VARCHAR(20) NOT NULL,
    Semester INT,
    City VARCHAR(20),
    CGPA DECIMAL(4,2) NOT NULL,
    Email VARCHAR(30) NOT NULL
);
INSERT INTO Student (Student_id, Name, Branch, Semester, City, CGPA, Email)
VALUES
    ('S00001', 'Ananya Tiwari', 'IT', 6, 'Mumbai', '8.50', 'ananya@college.edu'),
    ('S00002', 'Rohan Verma', 'CS', 4, 'Pune', '7.80', 'rohan@college.edu'),
    ('S00003', 'Pooja Nair', 'EC', 6, 'Bangalore', '9.10', 'pooja@college.edu'),
    ('S00004', 'Karan Shah', 'ME', 8, 'Delhi', '6.90', 'karan@college.edu'),
    ('S00005', 'Divya Pillai', 'CS', 2, 'Chennai', '8.20', 'divya@college.edu'),
    ('S00006', 'Arjun Menon', 'IT', 4, 'Mumbai', '7.50', 'arjun@college.edu');
CREATE TABLE Course (
    Course_id VARCHAR(6) PRIMARY KEY,
    Course_name VARCHAR(30) NOT NULL,
    Credits INT NOT NULL,
    Department VARCHAR(20) NOT NULL,
    Faculty VARCHAR(30) NOT NULL,
    Max_students INT NOT NULL
);
INSERT INTO Course (Course_id, Course_name, Credits, Department, Faculty, Max_students)
VALUES
    ('C00001', 'Database Systems', 4, 'IT', 'Prof. Joshi', 60),
    ('C00002', 'Computer Networks', 4, 'CS', 'Prof. Reddy', 60),
    ('C00003', 'Software Engineering', 3, 'IT', 'Prof. Patil', 55),
    ('C00004', 'Machine Learning', 4, 'CS', 'Prof. Kumar', 50),
    ('C00005', 'Digital Electronics', 4, 'EC', 'Prof. Bhat', 65);
-- Q1
SELECT Name, Branch, CGPA FROM Student;
-- Q2
SELECT * FROM Course WHERE Department = 'CS';
-- Q3
SELECT COUNT(*) AS total_students FROM Student;
-- Q4
RENAME TABLE Course TO Course_Catalog;
