USE attendance_tracker;

CREATE INDEX idx_emp_department   ON employees (department);
CREATE INDEX idx_att_work_date    ON attendance (work_date);
CREATE INDEX idx_att_status_date  ON attendance (status, work_date);
CREATE INDEX idx_task_emp_status  ON tasks (employee_id, status);

-- Verify
SHOW INDEX FROM employees;
SHOW INDEX FROM attendance;
SHOW INDEX FROM tasks;

-- Check an index is used
EXPLAIN SELECT * FROM employees WHERE department = 'Engineering';
