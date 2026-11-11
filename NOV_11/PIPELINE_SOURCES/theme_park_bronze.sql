CREATE OR REFRESH STREAMING TABLE tp_entries_bronze
AS
SELECT *
FROM STREAM(tp_entries_raw);

CREATE OR REFRESH STREAMING TABLE tp_entries_silver
AS
SELECT
    *,
    ticket_price AS ticket_revenue
FROM STREAM(tp_entries_bronze)
WHERE status = 'Completed'
AND ticket_price > 0;

CREATE OR REFRESH MATERIALIZED VIEW tp_entries_gold
AS
SELECT
    attraction_id,
    COUNT(*) AS total_entries,
    SUM(ticket_revenue) AS total_revenue
FROM tp_entries_silver
GROUP BY attraction_id;