CREATE TABLE staff_hierarchy (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT,
    designation VARCHAR(100)
);

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


-- 1. Employees having no manager
SELECT employee_id, employee_name, designation
FROM staff_hierarchy
WHERE manager_id IS NULL;
-- Raj Malhotra (CEO)

-- 2. Direct reports of the CEO
SELECT employee_id, employee_name, designation
FROM staff_hierarchy
WHERE manager_id = (SELECT employee_id
                    FROM staff_hierarchy
                    WHERE designation = 'CEO');

-- 3. Direct reports of the CTO
SELECT employee_id, employee_name, designation
FROM staff_hierarchy
WHERE manager_id = (SELECT employee_id
                    FROM staff_hierarchy
                    WHERE designation = 'CTO');

-- 4. Recursive CTE to display the complete hierarchy
WITH RECURSIVE org AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id, s.designation
    FROM staff_hierarchy s
    JOIN org o ON s.manager_id = o.employee_id
)
SELECT * FROM org;
-- 5. Add a hierarchy level to the result
WITH RECURSIVE org AS (
    SELECT employee_id, employee_name, manager_id, designation, 1 AS level_no
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id, s.designation, o.level_no + 1
    FROM staff_hierarchy s
    JOIN org o ON s.manager_id = o.employee_id
)
SELECT * FROM org
ORDER BY level_no, employee_id;

-- 6. All employees working below Meera Shah
WITH RECURSIVE team AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE manager_id = (SELECT employee_id
                        FROM staff_hierarchy
                        WHERE employee_name = 'Meera Shah')

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id, s.designation
    FROM staff_hierarchy s
    JOIN team t ON s.manager_id = t.employee_id
)
SELECT * FROM team;
-- 7. Everyone working below Aman Khan
WITH RECURSIVE team AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE manager_id = (SELECT employee_id
                        FROM staff_hierarchy
                        WHERE employee_name = 'Aman Khan')

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.manager_id, s.designation
    FROM staff_hierarchy s
    JOIN team t ON s.manager_id = t.employee_id
)
SELECT * FROM team;

-- 8. Employee -> manager relationships
SELECT e.employee_name AS employee,
       e.designation   AS employee_designation,
       m.employee_name AS manager,
       m.designation   AS manager_designation
FROM staff_hierarchy e
LEFT JOIN staff_hierarchy m ON e.manager_id = m.employee_id
ORDER BY e.employee_id;
-- 9. How many employees are at each hierarchy level
WITH RECURSIVE org AS (
    SELECT employee_id, manager_id, 1 AS level_no
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.employee_id, s.manager_id, o.level_no + 1
    FROM staff_hierarchy s
    JOIN org o ON s.manager_id = o.employee_id
)
SELECT level_no, COUNT(*) AS total_employees
FROM org
GROUP BY level_no
ORDER BY level_no;

-- 10. Organization starting with CEO and moving downward recursively
WITH RECURSIVE org AS (
    SELECT employee_id, employee_name, designation, manager_id,
           1 AS level_no,
           CAST(LPAD(employee_id, 3, '0') AS CHAR(200)) AS sort_path
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.employee_id, s.employee_name, s.designation, s.manager_id,
           o.level_no + 1,
           CONCAT(o.sort_path, '/', LPAD(s.employee_id, 3, '0'))
    FROM staff_hierarchy s
    JOIN org o ON s.manager_id = o.employee_id
)
SELECT CONCAT(REPEAT('    ', level_no - 1), employee_name) AS org_chart,
       designation,
       level_no
FROM org
ORDER BY sort_path;
