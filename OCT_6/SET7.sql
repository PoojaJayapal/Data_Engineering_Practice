-- ==================== DATA SETUP ====================
CREATE DATABASE IF NOT EXISTS sql_practice_pack;
USE sql_practice_pack;

DROP TABLE IF EXISTS call_performance;

CREATE TABLE call_performance (
    call_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    team VARCHAR(50),
    calls_handled INT,
    customer_rating DECIMAL(3,2),
    performance_date DATE
);

INSERT INTO call_performance VALUES
(1, 'Aman', 'Alpha', 42, 4.50, '2026-09-01'),
(2, 'Sara', 'Alpha', 38, 4.70, '2026-09-01'),
(3, 'Ravi', 'Beta', 50, 4.20, '2026-09-01'),
(4, 'Neha', 'Beta', 45, 4.80, '2026-09-01'),
(5, 'Aman', 'Alpha', 48, 4.60, '2026-09-02'),
(6, 'Sara', 'Alpha', 44, 4.50, '2026-09-02'),
(7, 'Ravi', 'Beta', 46, 4.30, '2026-09-02'),
(8, 'Neha', 'Beta', 52, 4.90, '2026-09-02'),
(9, 'Kabir', 'Alpha', 41, 4.40, '2026-09-01'),
(10, 'Kabir', 'Alpha', 49, 4.60, '2026-09-02'),
(11, 'Pooja', 'Beta', 45, 4.70, '2026-09-01'),
(12, 'Pooja', 'Beta', 50, 4.80, '2026-09-02');


-- ==================== EXERCISES ====================

-- 1. Rank all records based on calls handled
SELECT call_id, agent_name, team, calls_handled,
       RANK() OVER (ORDER BY calls_handled DESC) AS rank_no
FROM call_performance;

-- 2. ROW_NUMBER() from highest to lowest calls
SELECT call_id, agent_name, team, calls_handled,
       ROW_NUMBER() OVER (ORDER BY calls_handled DESC) AS row_no
FROM call_performance;

-- 3. RANK()
SELECT call_id, agent_name, team, calls_handled,
       RANK() OVER (ORDER BY calls_handled DESC) AS rank_no
FROM call_performance;

-- 4. DENSE_RANK()
SELECT call_id, agent_name, team, calls_handled,
       DENSE_RANK() OVER (ORDER BY calls_handled DESC) AS dense_rank_no
FROM call_performance;

-- 5. Compare all three ranking functions
SELECT call_id, agent_name, calls_handled,
       ROW_NUMBER() OVER (ORDER BY calls_handled DESC) AS row_no,
       RANK()       OVER (ORDER BY calls_handled DESC)
