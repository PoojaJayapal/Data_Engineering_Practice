import pandas as pd

customers = pd.read_csv("customers.csv")
orders = pd.read_csv("orders.csv")

# order_value is not in the file, so recreate it (same as Q67)
orders["order_value"] = orders["quantity"] * orders["unit_price"]

# Q75: inner join on customer_id
merged = pd.merge(orders, customers, on="customer_id", how="inner")

# Q76: selected columns
print(merged[["order_id", "customer_name", "city", "product", "status", "order_value"]])

# Q77: Delivered orders from Hyderabad
print(merged.query("status == 'Delivered' and city == 'Hyderabad'"))

# Q78: by city: total orders, total sales, average order value
city_summary = merged.groupby("city").agg(
    total_orders=("order_id", "count"),
    total_sales=("order_value", "sum"),
    avg_order_value=("order_value", "mean")
).reset_index()

# Q79: sort by total sales, descending
city_summary = city_summary.sort_values("total_sales", ascending=False)
print(city_summary)

# Q80: write to CSV
city_summary.to_csv("city_sales_summary.csv", index=False)

# Q81: write to record-oriented JSON
city_summary.to_json("city_sales_summary.json", orient="records", indent=4)
