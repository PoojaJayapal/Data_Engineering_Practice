--Create database
CREATE DATABASE shop_db;
USE shop_db;


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

-- Insert
INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 55000, 15),
(2, 'Headphones', 'Electronics', 2500, 8),
(3, 'T-Shirt', 'Clothing', 600, 40),
(4, 'Notebook', 'Stationery', 50, 100),
(5, 'Rice Bag 5kg', 'Grocery', 450, 0),
(6, 'Water Bottle', 'Home', 300, 5);

-- 5. Display all products
SELECT * FROM products;

-- 6. Display only product name and price
SELECT product_name, price FROM products;

-- 7. Insert a new product named Wireless Mouse
INSERT INTO products VALUES (7, 'Wireless Mouse', 'Electronics', 800, 25);

-- 8. Change the price of one product using its Product id
UPDATE products
SET price = 650
WHERE product_id = 3;

-- 9. Increase price of all Electronics products by 10%
UPDATE products
SET price = price * 1.10
WHERE category = 'Electronics';

-- 10. Reduce stock quantity of one product after a sale
UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;

-- 11. Change the category of one product
UPDATE products
SET category = 'Kitchen'
WHERE product_id = 6;

-- 12. Products costing more than 1000
SELECT * FROM products
WHERE price > 1000;

-- 13. Products with stock quantity less than 10
SELECT * FROM products
WHERE stock_quantity < 10;

-- 14. Only Electronics products
SELECT * FROM products
WHERE category = 'Electronics';

-- 15. Sort products from highest price to lowest price
SELECT * FROM products
ORDER BY price DESC;

-- 16. Delete one product using its Product ID
DELETE FROM products
WHERE product_id = 4;

-- 17. Delete products whose stock quantity is 0
DELETE FROM products
WHERE stock_quantity = 0;

-- 18. Display all remaining products
SELECT * FROM products;
