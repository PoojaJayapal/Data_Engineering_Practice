
-- 1. CREATE TABLE

CREATE TABLE hotel_bookings (
    booking_id INT PRIMARY KEY,
    hotel_city VARCHAR(50),
    room_type VARCHAR(50),
    nights INT,
    amount DECIMAL(10,2)
);


-- 2. INSERT RECORDS

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


-- 3. DISPLAY ALL RECORDS

SELECT * FROM hotel_bookings;


-- 4. FIND TOTAL REVENUE BY CITY

SELECT hotel_city, SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY hotel_city;


-- 5. FIND TOTAL REVENUE BY ROOM TYPE

SELECT room_type, SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY room_type;


-- 6. GROUP BY CITY AND ROOM TYPE

SELECT hotel_city, room_type,
       SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY hotel_city, room_type;


-- 7. PRODUCE CITY-WISE SUBTOTALS USING WITH ROLLUP

SELECT hotel_city, SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY hotel_city WITH ROLLUP;


-- 8. PRODUCE A GRAND TOTAL

SELECT SUM(amount) AS grand_total
FROM hotel_bookings;


-- 9. CALCULATE TOTAL NIGHTS BY CITY AND ROOM TYPE

SELECT hotel_city, room_type,
       SUM(nights) AS total_nights
FROM hotel_bookings
GROUP BY hotel_city, room_type;


-- 10. DISPLAY SUBTOTALS AND OVERALL TOTALS
-- IN THE SAME RESULT

SELECT hotel_city, room_type,
       SUM(amount) AS total_revenue
FROM hotel_bookings
GROUP BY hotel_city, room_type WITH ROLLUP;
```
