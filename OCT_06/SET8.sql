-- ==================== DATA SETUP ====================
CREATE DATABASE IF NOT EXISTS sql_practice_pack;
USE sql_practice_pack;

DROP TABLE IF EXISTS insurance_claims;

CREATE TABLE insurance_claims (
    claim_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    insurance_type VARCHAR(50),
    claim_amount DECIMAL(12,2),
    branch VARCHAR(50)
);

INSERT INTO insurance_claims VALUES
(1, 'Ajay Kumar', 'Health', 75000, 'Hyderabad'),
(2, 'Meena Shah', 'Motor', 45000, 'Mumbai'),
(3, 'Rohit Jain', 'Health', 125000, 'Hyderabad'),
(4, 'Sara Ali', 'Travel', 30000, 'Delhi'),
(5, 'Vikas Rao', 'Motor', 85000, 'Mumbai'),
(6, 'Nisha Singh', 'Health', 60000, 'Delhi'),
(7, 'Imran Khan', 'Travel', 55000, 'Hyderabad'),
(8, 'Pooja Patel', 'Motor', 40000, 'Delhi'),
(9, 'Karan Mehta', 'Health', 150000, 'Mumbai'),
(10, 'Farah Ahmed', 'Travel', 35000, 'Hyderabad');


-- ==================== CTE EXERCISES ====================

-- 1. CTE calculating total claims by insurance type
WITH type_total AS (
    SELECT insurance_type, SUM(claim_amount) AS total_claims
    FROM insurance_claims
    GROUP BY insurance_type
)
SELECT * FROM type_total;

-- 2. CTE calculating total claims by branch
WITH branch_total AS (
    SELECT branch, SUM(claim_amount) AS total_claims
    FROM insurance_claims
    GROUP BY branch
)
SELECT * FROM branch_total;

-- 3. Insurance types whose total claim amount exceeds 200000 (Result: Health)
WITH type_total AS (
    SELECT insurance_type, SUM(claim_amount) AS total_claims
    FROM insurance_claims
    GROUP BY insurance_type
)
SELECT * FROM type_total
WHERE total_claims > 200000;

-- 4. CTE for average claim amount, then claims above that average
WITH avg_cte AS (
    SELECT AVG(claim_amount) AS avg_claim
    FROM insurance_claims
)
SELECT c.*
FROM insurance_claims c
JOIN avg_cte a ON c.claim_amount > a.avg_claim;

-- 5. Rank insurance types by total claim amount
WITH type_total AS (
    SELECT insurance_type, SUM(claim_amount) AS total_claims
    FROM insurance_claims
    GROUP BY insurance_type
)
SELECT insurance_type, total_claims,
       RANK() OVER (ORDER BY total_claims DESC) AS type_rank
FROM type_total;

-- 6. Two CTEs in the same query, combined
WITH type_total AS (
    SELECT insurance_type, SUM(claim_amount) AS type_claims
    FROM insurance_claims
    GROUP BY insurance_type
),
branch_total AS (
    SELECT branch, SUM(claim_amount) AS branch_claims
    FROM insurance_claims
    GROUP BY branch
)
SELECT c.claim_id, c.customer_name, c.insurance_type, t.type_claims,
       c.branch, b.branch_claims
FROM insurance_claims c
JOIN type_total t   ON c.insurance_type = t.insurance_type
JOIN branch_total b ON c.branch = b.branch;


-- ==================== CORRELATED SUBQUERY EXERCISES ====================

-- 7. Claims greater than the average for their own insurance type
SELECT c.*
FROM insurance_claims c
WHERE c.claim_amount > (
    SELECT AVG(x.claim_amount)
    FROM insurance_claims x
    WHERE x.insurance_type = c.insurance_type
);

-- 8. Claims greater than the average at their own branch
SELECT c.*
FROM insurance_claims c
WHERE c.claim_amount > (
    SELECT AVG(x.claim_amount)
    FROM insurance_claims x
    WHERE x.branch = c.branch
);

-- 9. Largest claim for each insurance type
SELECT c.*
FROM insurance_claims c
WHERE c.claim_amount = (
    SELECT MAX(x.claim_amount)
    FROM insurance_claims x
    WHERE x.insurance_type = c.insurance_type
);

-- 10. Customers whose claim is above the branch average
SELECT c.customer_name, c.branch, c.claim_amount
FROM insurance_claims c
WHERE c.claim_amount > (
    SELECT AVG(x.claim_amount)
    FROM insurance_claims x
    WHERE x.branch = c.branch
);
