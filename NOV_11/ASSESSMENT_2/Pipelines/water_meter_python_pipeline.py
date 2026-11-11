from pyspark import pipelines as dp
from pyspark.sql.functions import col, sum, avg, count

@dp.table(name="water_readings_bronze_py")
def water_readings_bronze_py():
    return spark.readStream.table("water_meter_readings_source")


@dp.table(name="water_readings_silver_py")
def water_readings_silver_py():
    return (
        spark.readStream.table("water_readings_bronze_py")
        .filter(
            (col("reading_status") == "Valid") &
            (col("flow_lpm") > 0) &
            (col("consumption_liters") > 0)
        )
    )


@dp.materialized_view(name="water_readings_gold_py")
def water_readings_gold_py():
    return (
        spark.read.table("water_readings_silver_py")
        .groupBy("zone_id")
        .agg(
            sum("consumption_liters").alias("total_consumption"),
            avg("pressure_bar").alias("average_pressure"),
            count("*").alias("reading_count")
        )
    )