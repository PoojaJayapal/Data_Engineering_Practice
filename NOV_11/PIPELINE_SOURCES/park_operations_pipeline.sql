
-- BRONZE: Read visitor entries from the append-only source
CREATE OR REFRESH STREAMING TABLE park_entries_bronze_pipeline
AS
SELECT *
FROM STREAM(workspace.default.tp_entries_raw);


-- SILVER: Keep valid completed entries and calculate revenue
CREATE OR REFRESH STREAMING TABLE park_entries_silver_pipeline
AS
SELECT
    entry_id,
    visitor_id,
    attraction_id,
    visit_date,
    entry_time,
    wait_minutes,
    ride_minutes,
    ticket_type,
    ticket_price,
    status,
    COALESCE(booking_channel, 'Unknown') AS booking_channel,
    ticket_price AS ticket_revenue
FROM STREAM(park_entries_bronze_pipeline)
WHERE entry_id IS NOT NULL
  AND attraction_id IS NOT NULL
  AND ticket_price > 0
  AND wait_minutes >= 0
  AND status = 'Completed';


-- GOLD: Entry count and revenue by attraction
CREATE OR REFRESH MATERIALIZED VIEW park_entries_gold_pipeline
AS
SELECT
    attraction_id,
    COUNT(*) AS total_entries,
    SUM(ticket_revenue) AS total_revenue
FROM park_entries_silver_pipeline
GROUP BY attraction_id;
