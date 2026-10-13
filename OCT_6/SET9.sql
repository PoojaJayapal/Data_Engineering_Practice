

-- 1. CREATE TABLE

CREATE TABLE staff_hierarchy (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT,
    designation VARCHAR(100)
);


-- 2. INSERT RECORDS

INSERT INTO staff_hierarchy VALUES
(1, 'Raj Malhotra', NULL, 'CEO'),
(2, 'Meera Shah', 1, 'CTO'),
(3, 'Vikram Rao', 1, 'Sales Director'),
(4, 'Aman Khan', 2, 'Engineering Manager'),
(5, 'Sara Ali', 2, 'Data Manager'),
(6, 'Rohit Das', 4, 'Developer'),
(7, 'Priya Singh', 4, 'Developer'),
(8, 'Kabir Ahmed', 5, 'Data Engineer'),
(9, 'Neha Rao', 5, 'Data Analyst'),
(10, 'Imran Sheikh', 3, 'Sales Manager'),
(11, 'Pooja Jain', 10, 'Sales Executive');


-- 3. DISPLAY ALL RECORDS

SELECT * FROM staff_hierarchy;


-- 4. FIND EMPLOYEES HAVING NO MANAGER

SELECT *
FROM staff_hierarchy
WHERE manager_id IS NULL;


-- 5. FIND DIRECT REPORTS OF THE CEO

SELECT *
FROM staff_hierarchy
WHERE manager_id = 1;


-- 6. FIND DIRECT REPORTS OF THE CTO

SELECT *
FROM staff_hierarchy
WHERE manager_id = 2;


-- 7. DISPLAY THE COMPLETE HIERARCHY USING RECURSIVE CTE

WITH RECURSIVE company_hierarchy AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id, s.designation
    FROM staff_hierarchy s
    JOIN company_hierarchy h
        ON s.manager_id = h.employee_id
)
SELECT *
FROM company_hierarchy;


-- 8. DISPLAY HIERARCHY WITH LEVEL NUMBERS

WITH RECURSIVE company_hierarchy AS (
    SELECT employee_id, employee_name, manager_id,
           designation, 1 AS hierarchy_level
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id,
           s.designation, h.hierarchy_level + 1
    FROM staff_hierarchy s
    JOIN company_hierarchy h
        ON s.manager_id = h.employee_id
)
SELECT *
FROM company_hierarchy
ORDER BY hierarchy_level, employee_id;


-- 9. FIND ALL EMPLOYEES WORKING BELOW MEERA SHAH

WITH RECURSIVE employee_tree AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE employee_id = 2

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id, s.designation
    FROM staff_hierarchy s
    JOIN employee_tree e
        ON s.manager_id = e.employee_id
)
SELECT *
FROM employee_tree
WHERE employee_id <> 2;


-- 10. FIND EVERYONE WORKING BELOW AMAN KHAN

WITH RECURSIVE employee_tree AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE employee_id = 4

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id, s.designation
    FROM staff_hierarchy s
    JOIN employee_tree e
        ON s.manager_id = e.employee_id
)
SELECT *
FROM employee_tree
WHERE employee_id <> 4;


-- 11. DISPLAY EMPLOYEE-MANAGER RELATIONSHIPS

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM staff_hierarchy e
LEFT JOIN staff_hierarchy m
    ON e.manager_id = m.employee_id;


-- 12. COUNT EMPLOYEES AT EACH HIERARCHY LEVEL

WITH RECURSIVE company_hierarchy AS (
    SELECT employee_id, employee_name, manager_id,
           1 AS hierarchy_level
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id,
           h.hierarchy_level + 1
    FROM staff_hierarchy s
    JOIN company_hierarchy h
        ON s.manager_id = h.employee_id
)
SELECT
    hierarchy_level,
    COUNT(*) AS employee_count
FROM company_hierarchy
GROUP BY hierarchy_level
ORDER BY hierarchy_level;


-- 13. DISPLAY ORGANIZATION PATH FROM CEO DOWNWARD

WITH RECURSIVE organization AS (
    SELECT employee_id, employee_name, manager_id,
           designation,
           CAST(employee_name AS CHAR(1000)) AS hierarchy_path
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id,
           s.designation,
           CONCAT(o.hierarchy_path, ' -> ', s.employee_name)
    FROM staff_hierarchy s
    JOIN organization o
        ON s.manager_id = o.employee_id
)
SELECT *
FROM organization
ORDER BY employee_id;
```
