-- ==================== DATA SETUP ====================
USE sql_practice_pack;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO students VALUES
(1, 'Arun', 'Hyderabad'),
(2, 'Megha', 'Mumbai'),
(3, 'Zaid', 'Hyderabad'),
(4, 'Pooja', 'Pune'),
(5, 'Rohan', 'Delhi'),
(6, 'Sana', NULL),
(7, 'Vijay', 'Bangalore');

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    fee DECIMAL(10,2)
);
INSERT INTO courses VALUES
(101, 'Python', 15000),
(102, 'Data Engineering', 25000),
(103, 'Power BI', 12000),
(104, 'Cloud Computing', 20000),
(105, 'Cyber Security', 22000),
(106, 'Machine Learning', 28000);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE
);
INSERT INTO enrollments VALUES
(1001, 1, 101, '2026-09-01'),
(1002, 1, 102, '2026-09-03'),
(1003, 2, 103, '2026-09-04'),
(1004, 3, 102, '2026-09-05'),
(1005, 4, 104, '2026-09-06'),
(1006, 2, 101, '2026-09-07'),
(1007, 3, 105, '2026-09-08'),
(1008, 20, 102, '2026-09-09'),
(1009, 5, NULL, '2026-09-10');


-- ==================== EXERCISES ====================

-- 1. Student name and course name
SELECT s.student_name, c.course_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- 2. Student name, city, course name and fee
SELECT s.student_name, s.city, c.course_name, c.fee
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- 3. Students enrolled in Data Engineering (Result: Arun, Zaid)
SELECT s.student_name
F
