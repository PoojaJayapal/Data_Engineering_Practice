
-- Week 1 | 01_schema.sql
-- Creates database and tables: employees, attendance, tasks

CREATE DATABASE IF NOT EXISTS attendance_tracker;
USE attendance_tracker;

DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    department    VARCHAR(50)  NOT NULL,
    designation   VARCHAR(50),
    hire_date     DATE         NOT NULL,
    status        ENUM('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id   INT  NOT NULL,
    work_date     DATE NOT NULL,
    clock_in      DATETIME NULL,
    clock_out     DATETIME NULL,
    break_minutes INT NOT NULL DEFAULT 0,
    status        ENUM('PRESENT','LATE','ABSENT','LEAVE') NOT NULL DEFAULT 'PRESENT',
    CONSTRAINT fk_att_emp FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT uq_emp_date UNIQUE (employee_id, work_date),   -- one record per employee per day
    CONSTRAINT chk_clock CHECK (clock_out IS NULL OR clock_in IS NULL OR clock_out > clock_in)
);

CREATE TABLE tasks (
    task_id        INT AUTO_INCREMENT PRIMARY KEY,
    employee_id    INT NOT NULL,
    title          VARCHAR(150) NOT NULL,
    priority       ENUM('LOW','MEDIUM','HIGH') NOT NULL DEFAULT 'MEDIUM',
    assigned_date  DATE NOT NULL,
    due_date       DATE NOT NULL,
    completed_date DATE NULL,
    status         ENUM('PENDING','IN_PROGRESS','COMPLETED') NOT NULL DEFAULT 'PENDING',
    CONSTRAINT fk_task_emp FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
