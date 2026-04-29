DROP DATABASE IF EXISTS college_joins_db;
CREATE DATABASE college_joins_db;
USE college_joins_db;

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
CREATE TABLE Enrollment (
    Enroll_id VARCHAR(6) PRIMARY KEY,
    Student_id VARCHAR(6),
    Course_id VARCHAR(6),
    Enroll_date DATE NOT NULL,
    Grade ENUM('AA', 'AB', 'BB', 'BC', 'CC', 'FF'),
    Attendance INT,
    FOREIGN KEY (Student_id) REFERENCES Student(Student_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);
INSERT INTO Enrollment (Enroll_id, Student_id, Course_id, Enroll_date, Grade, Attendance)
VALUES
    ('E00001', 'S00001', 'C00001', '2023-07-01', 'AA', 92),
    ('E00002', 'S00001', 'C00003', '2023-07-01', 'AB', 88),
    ('E00003', 'S00002', 'C00002', '2023-07-01', 'BB', 75),
    ('E00004', 'S00003', 'C00005', '2023-07-01', 'AA', 95),
    ('E00005', 'S00004', 'C00003', '2023-07-01', 'BC', 60),
    ('E00006', 'S00005', 'C00004', '2023-07-01', 'AB', 85),
    ('E00007', 'S00006', 'C00001', '2023-07-01', 'BB', 78);
-- Q1
SELECT s.Name AS student_name, c.Course_name
FROM Enrollment e
JOIN Student s ON s.Student_id = e.Student_id
JOIN Course c ON c.Course_id = e.Course_id;
-- Q2
SELECT Name, Branch
FROM Student
WHERE Student_id = (
    SELECT Student_id
    FROM Enrollment
    WHERE Enroll_id = 'E00003'
);
-- Q3
SELECT s.Student_id, s.Name, SUM(c.Credits) AS total_credits
FROM Enrollment e
JOIN Student s ON s.Student_id = e.Student_id
JOIN Course c ON c.Course_id = e.Course_id
GROUP BY s.Student_id, s.Name;

-- Q4
SELECT *
FROM Student
WHERE Student_id IN (
    SELECT Student_id 
    FROM Enrollment 
    WHERE Grade = 'AA'
);
