
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

--Create MySQL tables for products, stores, sales, and employees
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);
CREATE TABLE stores (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    store_id INT,
    employee_id INT,
    quantity INT,
    sale_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


-- SAMPLE DATA for stores

INSERT INTO stores (store_name, city, state)
VALUES
('Chennai Store', 'Chennai', 'Tamil Nadu'),
('Bangalore Store', 'Bangalore', 'Karnataka'),
('Hyderabad Store', 'Hyderabad', 'Telangana'),
('Coimbatore Store', 'Coimbatore', 'Tamil Nadu');

-- SAMPLE DATA for employees

INSERT INTO employees (employee_name, department, salary, store_id)
VALUES
('Arun', 'Sales', 30000, 1),
('Priya', 'Sales', 35000, 1),
('Rahul', 'Marketing', 40000, 2),
('Sneha', 'Sales', 32000, 2),
('Karthik', 'Sales', 28000, 3),
('Divya', 'Marketing', 38000, 4),
('Vijay', 'Sales', 31000, 3);

-- SAMPLE DATA for products

INSERT INTO products (product_name, category, price, stock_quantity)
VALUES
('Laptop', 'Electronics', 55000, 20),
('Mobile', 'Electronics', 25000, 30),
('Headphones', 'Accessories', 2000, 50),
('Keyboard', 'Accessories', 1500, 40),
('Monitor', 'Electronics', 12000, 15),
('Mouse', 'Accessories', 800, 60),
('Tablet', 'Electronics', 30000, 25);

-- SAMPLE DATA for sales

INSERT INTO sales (product_id, store_id, employee_id, quantity, sale_date, total_amount)
VALUES
(1, 1, 1, 2, '2026-10-01', 110000),
(2, 1, 2, 3, '2026-10-02', 75000),
(3, 2, 3, 5, '2026-10-03', 10000),
(4, 2, 4, 4, '2026-10-04', 6000),
(5, 3, 5, 2, '2026-10-05', 24000),
(6, 3, 7, 10, '2026-10-06', 8000),
(7, 4, 6, 1, '2026-10-07', 30000),
(1, 2, 3, 1, '2026-10-08', 55000),
(2, 3, 5, 2, '2026-10-09', 50000),
(3, 4, 6, 3, '2026-10-10', 6000);

-- Insert sales data with CRUD operations
--1.CREATE 
INSERT INTO sales
(product_id, store_id, employee_id, quantity, sale_date, total_amount)
VALUES
(4, 1, 1, 2, '2026-11-01', 3000);
--2.READ
SELECT * FROM sales;
--3.UPDATE 
UPDATE sales
SET quantity = 5
WHERE sale_id = 1;
--4.DELETE
DELETE FROM sales
WHERE sale_id = 14;

-- Write a stored procedure to calculate daily sales for a store
DELIMITER //

CREATE PROCEDURE daily_sales(IN p_store_id INT)
BEGIN
    SELECT
        sale_date,
        store_id,
        SUM(total_amount) AS daily_sales
    FROM sales
    WHERE store_id = p_store_id
    GROUP BY sale_date, store_id
    ORDER BY sale_date;
END //

DELIMITER ;
CALL daily_sales(1);

--Add indexes to search by product and region
--1. Index on product
CREATE INDEX idx_product
ON sales(product_id);
--2. Index on region (state)
CREATE INDEX idx_region
ON stores(state);

--searches using product ID
SELECT *
FROM sales
WHERE product_id = 2;

--searches using region(state)
SELECT *
FROM stores
WHERE state = 'Tamil Nadu';




