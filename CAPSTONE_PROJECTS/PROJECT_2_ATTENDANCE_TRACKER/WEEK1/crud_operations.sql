USE attendance_tracker;

-- ---------- CREATE ----------
-- New employee
INSERT INTO employees (first_name, last_name, email, department, designation, hire_date)
VALUES ('Neha', 'Verma', 'neha.verma@company.com', 'Support', 'Support Agent', CURDATE());

-- CLOCK-IN 
INSERT INTO attendance (employee_id, work_date, clock_in, status)
VALUES (1, CURDATE(), NOW(), IF(TIME(NOW()) > '09:15:00', 'LATE', 'PRESENT'));

-- New task
INSERT INTO tasks (employee_id, title, priority, assigned_date, due_date)
VALUES (1, 'Write unit tests', 'HIGH', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 DAY));

-- ---------- UPDATE ----------
-- CLOCK-OUT (only closes today's open record)
UPDATE attendance
SET clock_out = NOW(), break_minutes = 45
WHERE employee_id = 1 AND work_date = CURDATE() AND clock_out IS NULL;

-- Mark a task completed
UPDATE tasks
SET status = 'COMPLETED', completed_date = CURDATE()
WHERE task_id = 1;

-- Change department
UPDATE employees SET department = 'Sales' WHERE employee_id = 10;

-- ---------- READ ----------
-- All employees in a department
SELECT * FROM employees WHERE department = 'Engineering';

-- Today's attendance with names
SELECT e.employee_id, CONCAT(e.first_name,' ',e.last_name) AS name,
       a.clock_in, a.clock_out, a.status
FROM attendance a
JOIN employees e ON e.employee_id = a.employee_id
WHERE a.work_date = CURDATE();

-- Late logins in the last 30 days
SELECT employee_id, work_date, clock_in
FROM attendance
WHERE status = 'LATE' AND work_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Absence count per employee
SELECT e.employee_id, CONCAT(e.first_name,' ',e.last_name) AS name, COUNT(*) AS absences
FROM attendance a
JOIN employees e ON e.employee_id = a.employee_id
WHERE a.status = 'ABSENT'
GROUP BY e.employee_id, name
ORDER BY absences DESC;

-- Task completion by employee
SELECT employee_id,
       COUNT(*) AS total_tasks,
       SUM(status = 'COMPLETED') AS completed
FROM tasks
GROUP BY employee_id;

-- ---------- DELETE ----------
-- Delete a task
DELETE FROM tasks WHERE task_id = 2;

-- Delete a wrongly created attendance record
DELETE FROM attendance WHERE employee_id = 1 AND work_date = CURDATE();

-- Soft-delete is safer for employees (keeps history)
UPDATE employees SET status = 'INACTIVE' WHERE employee_id = 11;
