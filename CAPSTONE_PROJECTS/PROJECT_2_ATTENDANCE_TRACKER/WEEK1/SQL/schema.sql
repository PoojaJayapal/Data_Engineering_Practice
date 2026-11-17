CREATE DATABASE IF NOT EXISTS attendance_tracker;
USE attendance_tracker;


CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    email       VARCHAR(100),
    department  VARCHAR(50),
    designation VARCHAR(50),
    hire_date   DATE,
    status      VARCHAR(10) DEFAULT 'ACTIVE'
);

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id   INT,
    work_date     DATE,
    clock_in      DATETIME,
    clock_out     DATETIME,
    break_minutes INT DEFAULT 0,
    status        VARCHAR(10) DEFAULT 'PRESENT',
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE tasks (
    task_id        INT AUTO_INCREMENT PRIMARY KEY,
    employee_id    INT,
    title          VARCHAR(150),
    priority       VARCHAR(10) DEFAULT 'MEDIUM',
    assigned_date  DATE,
    due_date       DATE,
    completed_date DATE,
    status         VARCHAR(15) DEFAULT 'PENDING',
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
