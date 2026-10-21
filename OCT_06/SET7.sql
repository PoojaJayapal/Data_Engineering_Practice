-- 1. Rank all records based on calls handled (basic SQL, no window function)
SELECT a.call_id, a.agent_name, a.team, a.calls_handled,
       (SELECT COUNT(*) + 1
        FROM call_performance b
        WHERE b.calls_handled > a.calls_handled) AS rank_no
FROM call_performance a
ORDER BY rank_no, a.call_id;

-- 2. ROW_NUMBER() from highest to lowest calls
SELECT call_id, agent_name, team, calls_handled,
       ROW_NUMBER() OVER (ORDER BY calls_handled DESC, call_id) AS row_num
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
       ROW_NUMBER() OVER (ORDER BY calls_handled DESC, call_id) AS row_num,
       RANK()       OVER (ORDER BY calls_handled DESC)          AS rank_no,
       DENSE_RANK() OVER (ORDER BY calls_handled DESC)          AS dense_rank_no
FROM call_performance
ORDER BY calls_handled DESC, call_id;

-- 6. Rank agents separately within each team
SELECT team, agent_name, performance_date, calls_handled,
       RANK() OVER (PARTITION BY team ORDER BY calls_handled DESC) AS team_rank
FROM call_performance
ORDER BY team, team_rank;

-- 7. Rank records according to customer rating
SELECT call_id, agent_name, team, customer_rating,
       RANK() OVER (ORDER BY customer_rating DESC) AS rating_rank
FROM call_performance
ORDER BY rating_rank, call_id;

-- 8. Top 3 performance records in each team
SELECT *
FROM (SELECT call_id, agent_name, team, calls_handled, performance_date,
             ROW_NUMBER() OVER (PARTITION BY team
                                ORDER BY calls_handled DESC, call_id) AS rn
      FROM call_performance) t
WHERE rn <= 3
ORDER BY team, rn;

-- 9. Each agent's best performance day
-- Window version
SELECT agent_name, performance_date, calls_handled
FROM (SELECT agent_name, performance_date, calls_handled,
             ROW_NUMBER() OVER (PARTITION BY agent_name
                                ORDER BY calls_handled DESC) AS rn
      FROM call_performance) t
WHERE rn = 1
ORDER BY agent_name;

-- 9b. Basic SQL version
SELECT c.agent_name, c.performance_date, c.calls_handled
FROM call_performance c
JOIN (SELECT agent_name, MAX(calls_handled) AS best_calls
      FROM call_performance
      GROUP BY agent_name) m
  ON c.agent_name = m.agent_name
 AND c.calls_handled = m.best_calls
ORDER BY c.agent_name;

-- 10. Rank agents based on their total calls handled
SELECT agent_name, SUM(calls_handled) AS total_calls,
       RANK() OVER (ORDER BY SUM(calls_handled) DESC) AS agent_rank
FROM call_performance
GROUP BY agent_name
ORDER BY agent_rank;
