--  DATA SETUP 
CREATE DATABASE telecom_assessment;
USE telecom_assessment;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    mobile VARCHAR(30),
    email VARCHAR(100)
);
INSERT INTO customers VALUES
(1, '  Arjun Rao ', 'Hyderabad', '98765-43210', ' ARJUN@GMAIL.COM '),
(2, 'SARA KHAN', 'Mumbai', '+91 99887 66554', 'sara@gmail.com'),
(3, 'Rohit Mehta ', 'Delhi', '9988 776 655', ''),
(4, 'Neha Singh', 'Hyderabad', '9876543210', 'neha@yahoo.com'),
(5, 'Imran Ali', 'Bangalore', '98765-AB210', NULL),
(6, 'Priya Nair', 'Pune', '9123456789', 'PRIYA@GMAIL.COM'),
(7, 'Kabir Shah', NULL, '9000011111', 'kabir@mail.com');

CREATE TABLE plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    monthly_charge DECIMAL(10,2)
);
INSERT INTO plans VALUES
(101, 'Basic', 399),
(102, 'Standard', 599),
(103, 'Premium', 999),
(104, 'Unlimited', 1499),
(105, 'Business', 1999);

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_id INT,
    plan_id INT,
    start_date DATE,
    status VARCHAR(20)
);
INSERT INTO subscriptions VALUES
(1001, 1, 103, '2026-01-01', 'Active'),
(1002, 2, 102, '2026-01-15', 'Active'),
(1003, 3, 101, '2026-02-01', 'Inactive'),
(1004, 4, 104, '2026-02-10', 'Active'),
(1005, 5, 102, '2026-03-01', 'Active'),
(1006, 1, 105, '2026-04-01', 'Active'),
(1007, 6, NULL, '2026-04-15', 'Pending'),
(1008, 20, 103, '2026-05-01', 'Active');

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    payment_date DATE,
    amount DECIMAL(10,2)
);
INSERT INTO payments VALUES
(501, 1, '2026-01-05', 999),
(502, 2, '2026-01-18', 599),
(503, 1, '2026-02-05', 999),
(504, 3, '2026-02-10', 399),
(505, 4, '2026-02-15', 1499),
(506, 2, '2026-03-18', 599),
(507, 5, '2026-03-20', 599),
(508, 1, '2026-04-05', 1999),
(509, 4, '2026-04-15', 1499),
(510, 5, '2026-05-20', 599),
(511, 2, '2026-05-22', 599),
(512, 1, '2026-06-05', 1999);


--SECTION A: BASICS & CRUD 
-- 1. Customer name, city and email for all customers
SELECT customer_name, city, email FROM customers;

-- 2. Customers from Hyderabad or Mumbai
SELECT * FROM customers
WHERE city = 'Hyderabad' OR city = 'Mumbai';

-- 3. Names containing the letter 'a'
SELECT * FROM customers
WHERE customer_name LIKE '%a%';

-- 4. Insert one new customer
INSERT INTO customers VALUES (8, 'Ananya Reddy', 'Chennai', '9812345678', 'ananya@gmail.com');

-- 5. Update the city of customer ID 6
UPDATE customers SET city = 'Chennai' WHERE customer_id = 6;

-- 6. Delete the customer inserted in Q4
DELETE FROM customers WHERE customer_id = 8;

-- 7. Customers ordered alphabetically by name
SELECT * FROM customers ORDER BY customer_name;


--  SECTION B: AGGREGATION

-- 8. Total number of payments and total amount 
SELECT COUNT(*) AS total_payments, SUM(amount) AS total_amount
FROM payments;

-- 9. Total payment amount for each customer
SELECT customer_id, SUM(amount) AS total_amount
FROM payments
GROUP BY customer_id;

-- 10. Customers whose total payments exceed 2000
SELECT customer_id, SUM(amount) AS total_amount
FROM payments
GROUP BY customer_id
HAVING SUM(amount) > 2000;

-- 11. Average payment amount for each customer
SELECT customer_id, AVG(amount) AS avg_amount
FROM payments
GROUP BY customer_id;


-- SECTION C: JOINS

-- 12. Customer name, plan name, monthly charge and subscription status
SELECT c.customer_name, p.plan_name, p.monthly_charge, s.status
FROM subscriptions s
JOIN customers c ON s.customer_id = c.customer_id
JOIN plans p ON s.plan_id = p.plan_id;

-- 13. All customers, including those with no subscription
SELECT c.*, s.subscription_id, s.status
FROM customers c
LEFT JOIN subscriptions s ON c.customer_id = s.customer_id;

-- 14. Subscriptions with no valid customer or plan
SELECT s.*
FROM subscriptions s
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN plans p ON s.plan_id = p.plan_id
WHERE c.customer_id IS NULL OR p.plan_id IS NULL;


--  SECTION D: DATA CLEANSING / REGEX

-- 15. Cleaned customer output
SELECT customer_id,
       TRIM(customer_name) AS customer_name,
       city,
       REGEXP_REPLACE(mobile, '[^0-9]', '') AS mobile,
       CASE
           WHEN TRIM(email) = '' THEN NULL
           ELSE LOWER(TRIM(email))
       END AS email
FROM customers;

-- 16. Mobile numbers containing alphabetic characters (Result: customer 5)
SELECT * FROM customers
WHERE mobile REGEXP '[A-Za-z]';
