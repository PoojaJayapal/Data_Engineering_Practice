CREATE OR REFRESH STREAMING TABLE water_readings_bronze
AS
SELECT *
FROM STREAM(water_meter_readings_source);

CREATE OR REFRESH STREAMING TABLE water_readings_silver
AS
SELECT *
FROM STREAM(water_readings_bronze)
WHERE reading_status = 'Valid'
  AND flow_lpm > 0
  AND consumption_liters > 0;

  CREATE OR REFRESH MATERIALIZED VIEW water_readings_gold
AS
SELECT
    zone_id,
    SUM(consumption_liters) AS total_consumption,
    AVG(pressure_bar) AS average_pressure,
    COUNT(*) AS reading_count
FROM water_readings_silver
GROUP BY zone_id;
