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


-- 1. Remove spaces before and after names
SELECT registration_id, TRIM(full_name) AS clean_name
FROM registrations;

-- 1b. Also collapse extra spaces inside names
SELECT registration_id,
       REGEXP_REPLACE(TRIM(full_name), '[[:space:]]+', ' ') AS clean_name
FROM registrations;

-- 2. Convert names to uppercase
SELECT registration_id,
       UPPER(REGEXP_REPLACE(TRIM(full_name), '[[:space:]]+', ' ')) AS name_upper
FROM registrations;

-- 3. Convert email addresses to lowercase
SELECT registration_id, LOWER(TRIM(email)) AS email_lower
FROM registrations;

-- 4. Convert blank email values into NULL
SELECT registration_id, NULLIF(LOWER(TRIM(email)), '') AS email_clean
FROM registrations;

-- 5. Remove spaces and hyphens from mobile numbers
SELECT registration_id,
       REPLACE(REPLACE(mobile, ' ', ''), '-', '') AS mobile_clean
FROM registrations;

-- 6. Remove every non-numeric character from mobile numbers
SELECT registration_id,
       REGEXP_REPLACE(mobile, '[^0-9]', '') AS mobile_digits
FROM registrations;

-- 7. Standardize city names to uppercase
SELECT registration_id, UPPER(TRIM(city)) AS city_upper
FROM registrations;

-- 8. Find records where city is NULL
SELECT *
FROM registrations
WHERE city IS NULL;

-- 9. Find records where email is NULL or blank
SELECT *
FROM registrations
WHERE email IS NULL OR TRIM(email) = '';

-- 10. Find only Gmail email addresses using RegEx
SELECT *
FROM registrations
WHERE LOWER(TRIM(email)) REGEXP '@gmail[.]com$';

-- 11. Identify incorrectly formatted email addresses
SELECT registration_id, email
FROM registrations
WHERE TRIM(email) <> ''
  AND LOWER(TRIM(email)) NOT REGEXP '^[a-z0-9._%+-]+@[a-z0-9.-]+[.][a-z]{2,}$';

-- 12. Extract only numeric characters from postal codes
SELECT registration_id,
       REGEXP_REPLACE(postal_code, '[^0-9]', '') AS postal_clean
FROM registrations;

-- 13. Find mobile numbers containing alphabetic characters
SELECT *
FROM registrations
WHERE mobile REGEXP '[A-Za-z]';

-- 14. Cleaned output containing name, email, mobile and city
SELECT UPPER(REGEXP_REPLACE(TRIM(full_name), '[[:space:]]+', ' ')) AS name,
       NULLIF(LOWER(TRIM(email)), '')                              AS email,
       REGEXP_REPLACE(mobile, '[^0-9]', '')                        AS mobile,
       UPPER(TRIM(city))                                           AS city
FROM registrations;

-- 15. Create a cleaned copy of the data in another table
CREATE TABLE registrations_clean (
    registration_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    mobile VARCHAR(40),
    city VARCHAR(50),
    postal_code VARCHAR(20)
);

INSERT INTO registrations_clean
SELECT registration_id,
       UPPER(REGEXP_REPLACE(TRIM(full_name), '[[:space:]]+', ' ')),
       NULLIF(LOWER(TRIM(email)), ''),
       REGEXP_REPLACE(mobile, '[^0-9]', ''),
       UPPER(TRIM(city)),
       REGEXP_REPLACE(postal_code, '[^0-9]', '')
FROM registrations;

SELECT * FROM registrations_clean;
