-- 1. CREATE DATABASE
CREATE DATABASE training_db;
USE training_db;

-- 2. CREATE EMPLOYEES TABLE
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    city VARCHAR(50)
);


-- 3. INSERT SAMPLE DATA
INSERT INTO employees
(employee_id, employee_name, department, salary, city)
VALUES
(101, 'Arun Kumar', 'IT', 60000, 'Hyderabad'),
(102, 'Meera Shah', 'HR', 45000, 'Mumbai'),
(103, 'Ravi Reddy', 'IT', 75000, 'Hyderabad'),
(104, 'Priya Nair', 'Finance', 55000, 'Bangalore'),
(105, 'Sameer Khan', 'IT', 80000, 'Pune'),
(106, 'Neha Gupta', 'HR', 40000, 'Delhi'),
(107, 'Vikram Rao', 'Finance', 65000, 'Hyderabad'),
(108, 'Anjali Singh', 'IT', 50000, NULL);

-- 1. Select all records
SELECT * FROM employees;

-- 2. Select specific columns
SELECT employee_id, employee_name, department FROM employees;

-- 3. WHERE condition
SELECT * FROM employees
WHERE department = 'IT';

-- 4. Comparison operators
SELECT * FROM employees
WHERE salary > 50000;

-- 5. AND condition
SELECT * FROM employees
WHERE department = 'IT' AND salary > 50000;

-- 6. OR condition
SELECT * FROM employees
WHERE department = 'IT' OR department = 'HR';

-- 7. IN
SELECT * FROM employees
WHERE department IN ('IT', 'HR');

-- 8. BETWEEN
SELECT * FROM employees
WHERE salary BETWEEN 40000 AND 70000;

-- 9. LIKE
SELECT * FROM employees WHERE employee_name LIKE 'A%';

-- 10. ORDER BY ascending
SELECT * FROM employees
ORDER BY salary ASC;
