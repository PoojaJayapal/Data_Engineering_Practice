"""Week 3 - PySpark store-level insights

1. Load the large sales file
2. Filter underperforming products (low sales or high returns)
3. Group by store and calculate average monthly revenue
4. Save both results as CSV files in output/
"""
from pathlib import Path

from pyspark.sql import SparkSession
from pyspark.sql import functions as F

# ----- Settings (change these if you want different rules) -----
RETURN_RATE_LIMIT = 0.10      # flag products with more than 10% of units returned
# "Low sales" = product revenue below the average product revenue

BASE_DIR = Path(__file__).parent
INPUT_FILE = BASE_DIR / "data" / "sales_large.csv"
OUTPUT_DIR = BASE_DIR / "output"


def main():
    spark = (SparkSession.builder
             .appName("RetailStoreInsights")
             .master("local[*]")
             .getOrCreate())
    spark.sparkContext.setLogLevel("ERROR")

    # ------------------------------------------------------------
    # 1. LOAD
    # ------------------------------------------------------------
    sales = (spark.read
             .option("header", True)
             .option("inferSchema", True)
             .csv(str(INPUT_FILE)))
    print(f"Rows loaded: {sales.count():,}")

    # Revenue per sale (after discount)
    sales = sales.withColumn(
        "revenue",
        F.round(F.col("quantity") * F.col("price") * (1 - F.col("discount_pct") / 100), 2))

    # ------------------------------------------------------------
    # 2. FILTER: underperforming products
    # ------------------------------------------------------------
    products = (sales.groupBy("product_id", "product_name", "category")
                .agg(F.sum("quantity").alias("units_sold"),
                     F.round(F.sum("revenue"), 2).alias("total_revenue"),
                     F.sum("returned_qty").alias("units_returned"))
                .withColumn("return_rate",
                            F.round(F.col("units_returned") / F.col("units_sold"), 4)))

    avg_revenue = products.agg(F.avg("total_revenue")).first()[0]

    flagged = products.filter(
        (F.col("total_revenue") < avg_revenue) |
        (F.col("return_rate") > RETURN_RATE_LIMIT))

    underperforming = (flagged.withColumn(
        "reason",
        F.when((F.col("total_revenue") < avg_revenue) &
               (F.col("return_rate") > RETURN_RATE_LIMIT), "low sales + high returns")
         .when(F.col("total_revenue") < avg_revenue, "low sales")
         .otherwise("high returns"))
        .orderBy("total_revenue"))

    print(f"\nAverage product revenue: {avg_revenue:,.2f}")
    print(f"Return rate limit: {RETURN_RATE_LIMIT:.0%}")
    print("\n=== UNDERPERFORMING PRODUCTS ===")
    underperforming.show(truncate=False)

    # ------------------------------------------------------------
    # 3. GROUP BY STORE: average monthly revenue
    # ------------------------------------------------------------
    monthly = (sales
               .withColumn("month", F.date_format(F.to_date("sale_date"), "yyyy-MM"))
               .groupBy("store_id", "month")
               .agg(F.sum("revenue").alias("monthly_revenue")))

    store_summary = (monthly.groupBy("store_id")
                     .agg(F.round(F.avg("monthly_revenue"), 2).alias("avg_monthly_revenue"),
                          F.round(F.sum("monthly_revenue"), 2).alias("total_revenue"),
                          F.count("month").alias("months_with_sales"))
                     .orderBy(F.col("avg_monthly_revenue").desc()))

    print("=== STORE SUMMARY (average monthly revenue) ===")
    store_summary.show()

    # ------------------------------------------------------------
    # 4. SAVE (results are small, so write as single CSV files)
    # ------------------------------------------------------------
    OUTPUT_DIR.mkdir(exist_ok=True)
    underperforming.toPandas().to_csv(OUTPUT_DIR / "underperforming_products.csv", index=False)
    store_summary.toPandas().to_csv(OUTPUT_DIR / "store_summary.csv", index=False)
    print(f"Saved results to {OUTPUT_DIR}")

    spark.stop()


if __name__ == "__main__":
    main()
