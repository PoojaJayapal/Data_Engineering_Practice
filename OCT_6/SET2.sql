-- ==================== DATA SETUP ====================
USE sql_practice_pack;
-- (If you are starting fresh, run first: CREATE DATABASE sql_practice_pack;)

CREATE TABLE food_orders (
    order_id INT PRIMARY KEY,
    restaurant VARCHAR(100),
    city VARCHAR(50),
    food_type VARCHAR(50),
    order_amount DECIMAL(10,2),
    delivery_partner VARCHAR(50),
    order_date DATE
);

INSERT INTO food_orders VALUES
(101, 'Spice Hub', 'Hyderabad', 'Indian', 850, 'Ravi', '2026-09-01'),
(102, 'Burger Zone', 'Hyderabad', 'Fast Food', 520, 'Kiran', '2026-09-01'),
(103, 'Pizza Point', 'Mumbai', 'Fast Food', 1100, 'Ravi', '2026-09-02'),
(104, 'Curry House', 'Bangalore', 'Indian', 760, 'Aman', '2026-09-02'),
(105, 'Spice Hub', 'Hyderabad', 'Indian', 1250, 'Kiran', '2026-09-03'),
(106, 'Sushi World', 'Mumbai', 'Japanese', 1800, 'Aman', '2026-09-03'),
(107, 'Pizza Point', 'Mumbai', 'Fast Food', 900, 'Ravi', '2026-09-04'),
(108, 'Curry House', 'Bangalore', 'Indian', 640, 'Kiran', '2026-09-04'),
(109, 'Burger Zone', 'Hyderabad', 'Fast Food', 430, 'Aman', '2026-09-05'),
(110, 'Sushi World', 'Mumbai', 'Japanese', 2100, 'Ravi', '2026-09-05'),
(111, 'Spice Hub', 'Hyderabad', 'Indian', 950, 'Aman', '2026-09-06'),
(112, 'Curry House', 'Bangalore', 'Indian', 880, 'Ravi', '2026-09-06');


-- ==================== EXERCISES ====================

-- 1. Total number of orders (Result: 12)
SELECT COUNT(*) AS total_orders
FROM food_orders;

-- 2. Total revenue (Result: 12180)
SELECT SUM(order_amount) AS total_revenue
FROM food_orders;

-- 3. Average order value (Result: 1015)
SELECT AVG(order_amount) AS avg_order_value
FROM food_orders;

-- 4. Highest order amount (Result: 2100)
SELECT MAX(order_amount) AS highest_order
FROM food_orders;

-- 5. Lowest order amount (Result: 430)
SELECT MIN(order_amount) AS lowest_order
FROM food_orders;

-- 6. Total revenue by city
SELECT city, SUM(order_amount) AS total_revenue
FROM food_orders
GROUP BY city;

-- 7. Number of orders by restaurant
SELECT restaurant, COUNT(*) AS total_orders
FROM food_orders
GROUP BY restaurant;

-- 8. Average order value by food type
SELECT food_type, AVG(order_amount) AS avg_order_value
FROM food_orders
GROUP BY food_type;

-- 9. Total revenue by delivery partner
SELECT delivery_partner, SUM(order_amount) AS total_revenue
FROM food_orders
GROUP BY delivery_partner;

-- 10. Cities having more than 3 orders (Result: Hyderabad and Mumbai)
SELECT city, COUNT(*) AS total_orders
FROM food_orders
GROUP BY city
HAVING COUNT(*) > 3;

-- 11. Restaurants generating more than 2000 revenue
--     (Result: Spice Hub, Curry House, Sushi World)
SELECT restaurant, SUM(order_amount) AS total_revenue
FROM food_orders
GROUP BY restaurant
HAVING SUM(order_amount) > 2000;

-- 12. Delivery partners whose average order amount exceeds 800
--     (Result: Ravi, Kiran, Aman)
SELECT delivery_partner, AVG(order_amount) AS avg_order_amount
FROM food_orders
GROUP BY delivery_partner
HAVING AVG(order_amount) > 800;

-- 13. Food types whose total revenue exceeds 2500
--     (Result: Indian, Fast Food, Japanese)
SELECT food_type, SUM(order_amount) AS total_revenue
FROM food_orders
GROUP BY food_type
HAVING SUM(order_amount) > 2500;

-- 14. City-wise revenue from highest to lowest
SELECT city, SUM(order_amount) AS total_revenue
FROM food_orders
GROUP BY city
ORDER BY total_revenue DESC;

-- 15. Top-performing restaurant based on revenue (Result: Sushi World, 3900)
SELECT restaurant, SUM(order_amount) AS total_revenue
FROM food_orders
GROUP BY restaurant
ORDER BY total_revenue DESC
LIMIT 1;
