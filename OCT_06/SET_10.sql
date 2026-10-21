CREATE TABLE hotel_bookings (
    booking_id INT PRIMARY KEY,
    hotel_city VARCHAR(50),
    room_type VARCHAR(50),
    nights INT,
    amount DECIMAL(10,2)
);

INSERT INTO hotel_bookings VALUES
(1, 'Hyderabad', 'Standard', 2, 6000),
(2, 'Hyderabad', 'Deluxe', 3, 13500),
(3, 'Hyderabad', 'Suite', 2, 18000),
(4, 'Mumbai', 'Standard', 2, 9000),
(5, 'Mumbai', 'Deluxe', 3, 18000),
(6, 'Mumbai', 'Suite', 1, 15000),
(7, 'Bangalore', 'Standard', 3, 10500),
(8, 'Bangalore', 'Deluxe', 2, 12000),
(9, 'Bangalore', 'Suite', 2, 20000);


-- 1. Total revenue by city
SELECT hotel_city, SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY hotel_city;

-- 2. Total revenue by room type
SELECT room_type, SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY room_type;


-- 3. Group by city and room type
SELECT hotel_city, room_type, SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY hotel_city, room_type;


-- 4. City-wise subtotals using WITH ROLLUP
SELECT hotel_city, SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY hotel_city WITH ROLLUP;


-- 5. Grand total
SELECT SUM(amount) AS grand_total
FROM hotel_bookings;


-- 6. Total nights by city and room type
SELECT hotel_city, room_type, SUM(nights) AS total_nights
FROM hotel_bookings
GROUP BY hotel_city, room_type;

-- 7. Subtotals and overall totals in the same result
SELECT
    CASE WHEN GROUPING(hotel_city) = 1 THEN 'ALL CITIES'
         ELSE hotel_city END AS hotel_city,
    CASE WHEN GROUPING(room_type) = 1 THEN 'ALL ROOM TYPES'
         ELSE room_type END AS room_type,
    SUM(amount) AS total_revenue,
    SUM(nights) AS total_nights
FROM hotel_bookings
GROUP BY hotel_city, room_type WITH ROLLUP;
--   Bangalore 42500 / 7 nights
-- Last row: ALL CITIES | ALL ROOM TYPES | 122000 | 20
