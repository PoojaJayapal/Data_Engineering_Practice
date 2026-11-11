
CREATE OR REFRESH STREAMING TABLE water_readings_bronze_pipeline
AS
SELECT *
FROM STREAM(workspace1.water_operations.water_meter_readings_source);

CREATE OR REFRESH STREAMING TABLE water_readings_silver_pipeline
AS
SELECT *
FROM STREAM(water_readings_bronze_pipeline)
WHERE reading_status = 'Valid'
AND flow_lpm > 0
AND consumption_liters > 0;

CREATE OR REFRESH MATERIALIZED VIEW zone_consumption_gold_pipeline
AS
SELECT
    s.zone_id,
    z.zone_name,
    z.district,
    SUM(s.consumption_liters) AS total_consumption,
    AVG(s.pressure_bar) AS average_pressure,
    COUNT(*) AS reading_count
FROM water_readings_silver_pipeline s
LEFT JOIN workspace1.water_operations.water_zones z
ON s.zone_id = z.zone_id
GROUP BY
    s.zone_id,
    z.zone_name,
    z.district;