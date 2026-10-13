-- ==================== DATA SETUP ====================
USE sql_practice_pack;

CREATE TABLE registrations (
    registration_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    mobile VARCHAR(40),
    city VARCHAR(50),
    postal_code VARCHAR(20)
);

INSERT INTO registrations VALUES
(1, '  rohit sharma ', ' ROHIT@GMAIL.COM ', '+91-98765-43210', 'hyderabad', '500001'),
(2, 'SARA KHAN', 'sara@yahoo.com', '99887 66554', ' MUMBAI ', '400001'),
(3, '  amit   patel ', '', '(040)99887766', 'Hyderabad', '500 032'),
(4, 'Neha Singh ', NULL, '9876543210', 'BANGALORE', '560001'),
(5, 'imran ali', 'IMRAN@MAIL.COM ', '91 9988772211', NULL, '500084'),
(6, 'Priya Rao', 'priya@gmail', '98765-AB210', 'Pune', '411001');


-- ==================== EXERCISES ====================

-- 1. Remove spaces
