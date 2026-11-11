from pyspark import pipelines as dp
from pyspark.sql.functions import col, count, sum

# Bronze streaming table
@dp.table(name="tp_entries_bronze_python")
def tp_entries_bronze_python():
    return spark.readStream.table("tp_entries_raw")


# Silver streaming table
@dp.table(name="tp_entries_silver_python")
def tp_entries_silver_python():
    return (
        spark.readStream.table("tp_entries_bronze_python")
        .filter(
            (col("status") == "Completed") &
            (col("ticket_price") > 0)
        )
        .withColumn("ticket_revenue", col("ticket_price"))
    )


# Gold materialized view
@dp.materialized_view(name="tp_entries_gold_python")
def tp_entries_gold_python():
    return (
        spark.read.table("tp_entries_silver_python")
        .groupBy("attraction_id")
        .agg(
            count("*").alias("total_entries"),
            sum("ticket_revenue").alias("total_revenue")
        )
    )