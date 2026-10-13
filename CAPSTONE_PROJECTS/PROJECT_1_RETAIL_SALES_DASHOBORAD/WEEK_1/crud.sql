
USE retail_sales_db;

-- =====================================
-- 1. INSERT SAMPLE DATA
-- =====================================

-- Insert stores
INSERT INTO stores (store_name, region, city) VALUES
('Chennai Central', 'South', 'Chennai'),
('Bangalore Mall', 'South', 'Bangalore'),
('Mumbai Plaza', 'West', 'Mumbai');

-- Insert products
INSERT INTO products (product_name, category, price, cost) VALUES
('Laptop', 'Electronics', 55000.00, 42000.00),
('Headphones', 'Electronics', 2000.00, 1200.00),
('Office Chair', 'Furniture', 8000.00, 5000.00),
('Keyboard', 'Electronics', 1500.00, 800.00);

-- Insert employees
INSERT INTO employees (employee_name, designation, store_id) VALUES
('Arun Kumar', 'Sales Executive', 1),
('Priya Sharma', 'Store Manager', 1),
('Rahul Verma', 'Sales Executive', 2),
('Sneha Patel', 'Sales Executive', 3);

-- Insert sales
INSERT INTO sales
(product_id, store_id, employee_id, quantity, sale_date, discount_percentage)
VALUES
(1, 1, 1, 2, '2026-10-01', 5.00),
(2, 1, 1, 5, '2026-10-01', 0.00),
(3, 2, 3, 3, '2026-10-02', 10.00),
(4, 2, 3, 4, '2026-10-02', 0.00),
(1, 3, 4, 1, '2026-10-03', 5.00),
(2, 3, 4, 10, '2026-10-03', 2.00);

-- =====================================
-- 2. READ: VIEW ALL SALES
-- =====================================

SELECT * FROM sales;

-- =====================================
-- 3. READ: VIEW SALES WITH PRODUCT AND STORE DETAILS
-- =====================================

SELECT
    s.sale_id,
    p.product_name,
    st.store_name,
    s.quantity,
    p.price,
    s.sale_date
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN stores st ON s.store_id = st.store_id;

-- =====================================
-- 4. UPDATE: CHANGE A SALES QUANTITY


UPDATE sales
SET quantity = 3
WHERE sale_id = 1;

-- Verify the update
SELECT * FROM sales WHERE sale_id = 1;

-- =====================================
-- 5. DELETE: REMOVE A SALES RECORD
-- =====================================

DELETE FROM sales
WHERE sale_id = 6;

-- Verify the deletion
SELECT * FROM sales;
