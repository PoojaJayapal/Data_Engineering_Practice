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


--  1. Student name and course name 
SELECT s.student_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c     ON e.course_id  = c.course_id;

-- 2. Student name, city, course name, fee 
SELECT s.student_name, s.city, c.course_name, c.fee
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c     ON e.course_id  = c.course_id;

-- 3. Students enrolled in Data Engineering 
SELECT s.student_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c     ON e.course_id  = c.course_id
WHERE c.course_name = 'Data Engineering';

-- 4. All students, including those with no enrollment
SELECT s.student_name, c.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c     ON e.course_id  = c.course_id;

-- 5. Students who never enrolled 
SELECT s.student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

--  6. All courses, including those with no students 
SELECT c.course_name, s.student_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id  = e.course_id
LEFT JOIN students s    ON e.student_id = s.student_id;

-- 7. Courses with no enrollments 
SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

-- 8. Enrollments with no valid student 
SELECT e.*
FROM enrollments e
LEFT JOIN students s ON e.student_id = s.student_id
WHERE s.student_id IS NULL;


-- 9. Enrollments with no valid course 
SELECT e.*
FROM enrollments e
LEFT JOIN courses c ON e.course_id = c.course_id
WHERE c.course_id IS NULL;

-- 10. Total courses taken by each student 
SELECT s.student_name, COUNT(c.course_id) AS total_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c     ON e.course_id  = c.course_id
GROUP BY s.student_id, s.student_name;

--11. Total fees per student
SELECT s.student_name, COALESCE(SUM(c.fee), 0) AS total_fees
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c     ON e.course_id  = c.course_id
GROUP BY s.student_id, s.student_name;


-- 12. Students enrolled in more than one course 
SELECT s.student_name, COUNT(c.course_id) AS total_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c     ON e.course_id  = c.course_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(c.course_id) > 1;

--  13. Courses having more than one student 
SELECT c.course_name, COUNT(s.student_id) AS total_students
FROM courses c
JOIN enrollments e ON c.course_id  = e.course_id
JOIN students s    ON e.student_id = s.student_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(s.student_id) > 1;


--14. Total enrollment revenue by course
SELECT c.course_name, COALESCE(SUM(c.fee), 0) AS total_revenue
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


--  15. Course with the highest enrollment revenue
SELECT c.course_name, SUM(c.fee) AS total_revenue
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_revenue DESC
LIMIT 1;
