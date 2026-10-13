
CREATE DATABASE IF NOT EXISTS retail_sales_db;

USE retail_sales_db;

-- 1. Stores table
CREATE TABLE stores (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

-- 2. Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);

-- 3. Employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    designation VARCHAR(100),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- 4. Sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    store_id INT NOT NULL,
    employee_id INT,
    quantity INT NOT NULL,
    sale_date DATE NOT NULL,
    discount_percentage DECIMAL(5, 2) DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

