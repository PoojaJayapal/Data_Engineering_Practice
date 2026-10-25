-- MySQL: schema, CRUD, stored procedure, indexes
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- TABLES
CREATE TABLE stores (
    store_id   INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    region     VARCHAR(50)  NOT NULL
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    store_id    INT NOT NULL,
    name        VARCHAR(100) NOT NULL,
    role        VARCHAR(50),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE products (
    product_id   INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price        DECIMAL(10,2) NOT NULL
);

CREATE TABLE sales (
    sale_id     INT AUTO_INCREMENT PRIMARY KEY,
    store_id    INT NOT NULL,
    product_id  INT NOT NULL,
    employee_id INT NOT NULL,
    quantity    INT NOT NULL,
    amount      DECIMAL(10,2) NOT NULL,
    sale_date   DATE NOT NULL,
    FOREIGN KEY (store_id)    REFERENCES stores(store_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- INDEXES (search by product and region)
CREATE INDEX idx_products_name ON products(product_name);
CREATE INDEX idx_stores_region ON stores(region);
CREATE INDEX idx_sales_product ON sales(product_id);

-- SAMPLE DATA
INSERT INTO stores (store_name, region) VALUES
    ('Downtown',  'West'),
    ('Lakeside',  'Midwest'),
    ('Harbor',    'East'),
    ('Sunset',    'South'),
    ('Hilltop',   'North');

INSERT INTO employees (store_id, name, role) VALUES
    (1, 'Maria',  'Manager'),
    (2, 'Priya',  'Cashier'),
    (3, 'Daniel', 'Supervisor'),
    (4, 'Sofia',  'Sales Associate'),
    (5, 'Arjun',  'Cashier');

INSERT INTO products (product_name, price) VALUES
    ('Headphones',    89.99),
    ('Coffee Maker',  59.50),
    ('Yoga Mat',      24.99),
    ('Running Jacket',74.25),
    ('Smart Watch',  199.00);

-- CRUD ON SALES
-- Create
INSERT INTO sales (store_id, product_id, employee_id, quantity, amount, sale_date) VALUES
    (1, 1, 1, 2, 179.98, '2025-01-15'),
    (1, 2, 1, 1,  59.50, '2025-01-15'),
    (2, 1, 2, 1,  89.99, '2025-01-15'),
    (3, 3, 3, 3,  74.97, '2025-01-16'),
    (4, 4, 4, 2, 148.50, '2025-01-16'),
    (5, 5, 5, 1, 199.00, '2025-01-17');

-- Read
SELECT * FROM sales;

-- Update
UPDATE sales SET quantity = 3, amount = 269.97 WHERE sale_id = 1;

-- Delete
DELETE FROM sales WHERE sale_id = 3;

-- STORED PROCEDURE: daily sales for a store
DELIMITER $$
CREATE PROCEDURE daily_sales(IN p_store_id INT, IN p_date DATE)
BEGIN
    SELECT store_id, sale_date,
           COUNT(*)       AS total_sales,
           SUM(quantity)  AS total_units,
           SUM(amount)    AS total_revenue
    FROM sales
    WHERE store_id = p_store_id AND sale_date = p_date
    GROUP BY store_id, sale_date;
END $$
DELIMITER ;

CALL daily_sales(1, '2025-01-15');
