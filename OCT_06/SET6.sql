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


-- 1. Each row along with total calls handled across the entire table
SELECT c.*,
       (SELECT SUM(calls_handled) FROM call_performance) AS total_calls_all
FROM call_performance c;

-- 2. Each row along with total calls handled by its team
SELECT c.*, t.team_total_calls
FROM call_performance c
JOIN (SELECT team, SUM(calls_handled) AS team_total_calls
      FROM call_performance
      GROUP BY team) t ON c.team = t.team;

-- 3. Each agent's record along with average calls handled by the team
SELECT c.*, t.team_avg_calls
FROM call_performance c
JOIN (SELECT team, ROUND(AVG(calls_handled), 2) AS team_avg_calls
      FROM call_performance
      GROUP BY team) t ON c.team = t.team;

-- 4. Each row along with team average customer rating
SELECT c.*, t.team_avg_rating
FROM call_performance c
JOIN (SELECT team, ROUND(AVG(customer_rating), 2) AS team_avg_rating
      FROM call_performance
      GROUP BY team) t ON c.team = t.team;

-- 5. Cumulative calls handled by each agent ordered by date
SELECT a.agent_name, a.performance_date, a.calls_handled,
       SUM(b.calls_handled) AS cumulative_calls
FROM call_performance a
JOIN call_performance b
  ON a.agent_name = b.agent_name
 AND b.performance_date <= a.performance_date
GROUP BY a.call_id, a.agent_name, a.performance_date, a.calls_handled
ORDER BY a.agent_name, a.performance_date;

-- 6. Cumulative calls at the team level (per team, per day)
SELECT d1.team, d1.performance_date, d1.daily_calls,
       SUM(d2.daily_calls) AS team_cumulative_calls
FROM (SELECT team, performance_date, SUM(calls_handled) AS daily_calls
      FROM call_performance
      GROUP BY team, performance_date) d1
JOIN (SELECT team, performance_date, SUM(calls_handled) AS daily_calls
      FROM call_performance
      GROUP BY team, performance_date) d2
  ON d1.team = d2.team
 AND d2.performance_date <= d1.performance_date
GROUP BY d1.team, d1.performance_date, d1.daily_calls
ORDER BY d1.team, d1.performance_date;

-- 7. Compare each row's calls with the team's average calls
SELECT c.agent_name, c.team, c.performance_date, c.calls_handled,
       t.team_avg_calls,
       ROUND(c.calls_handled - t.team_avg_calls, 2) AS diff_from_team_avg
FROM call_performance c
JOIN (SELECT team, AVG(calls_handled) AS team_avg_calls
      FROM call_performance
      GROUP BY team) t ON c.team = t.team;

-- 8. Previous day's call count for each agent
SELECT a.agent_name, a.performance_date, a.calls_handled,
       p.calls_handled AS previous_day_calls
FROM call_performance a
LEFT JOIN call_performance p
  ON a.agent_name = p.agent_name
 AND p.performance_date = DATE_SUB(a.performance_date, INTERVAL 1 DAY)
ORDER BY a.agent_name, a.performance_date;

-- 9. Difference between current and previous call count
SELECT a.agent_name, a.performance_date, a.calls_handled,
       p.calls_handled AS previous_day_calls,
       a.calls_handled - p.calls_handled AS call_difference
FROM call_performance a
LEFT JOIN call_performance p
  ON a.agent_name = p.agent_name
 AND p.performance_date = DATE_SUB(a.performance_date, INTERVAL 1 DAY)
ORDER BY a.agent_name, a.performance_date;

-- 10. Total calls handled by each agent without collapsing rows
SELECT c.*, t.agent_total_calls
FROM call_performance c
JOIN (SELECT agent_name, SUM(calls_handled) AS agent_total_calls
      FROM call_performance
      GROUP BY agent_name) t ON c.agent_name = t.agent_name
ORDER BY c.agent_name, c.performance_date;
