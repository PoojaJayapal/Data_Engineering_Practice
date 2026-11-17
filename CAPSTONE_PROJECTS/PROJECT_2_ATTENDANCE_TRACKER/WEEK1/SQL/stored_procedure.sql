USE attendance_tracker;

DROP PROCEDURE IF EXISTS sp_total_working_hours;

DELIMITER $$

CREATE PROCEDURE sp_total_working_hours(
    IN p_employee_id INT,     
    IN p_start_date  DATE,
    IN p_end_date    DATE
)
BEGIN
    SELECT
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        e.department,
        COUNT(a.attendance_id) AS days_worked,
        ROUND(COALESCE(SUM(TIMESTAMPDIFF(MINUTE, a.clock_in, a.clock_out) - a.break_minutes), 0) / 60, 2)
            AS total_working_hours
    FROM employees e
    LEFT JOIN attendance a
           ON a.employee_id = e.employee_id
          AND a.work_date BETWEEN p_start_date AND p_end_date
          AND a.clock_in  IS NOT NULL
          AND a.clock_out IS NOT NULL
    WHERE p_employee_id IS NULL OR e.employee_id = p_employee_id
    GROUP BY e.employee_id, employee_name, e.department
    ORDER BY total_working_hours DESC;
END$$

DELIMITER ;
