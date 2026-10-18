import pandas as pd

# Q61: read the CSV into a DataFrame
df = pd.read_csv("orders.csv")

# Q62: first 5 rows
print(df.head())

# Q63: column names and datatypes
print(df.columns)
print(df.dtypes)

# Q64: shape
print(df.shape)

# Q65: Delivered orders using query()
delivered = df.query("status == 'Delivered'")
print(delivered)

# Q66: quantity greater than 2
print(df[df["quantity"] > 2])

# Q67: new column order_value
df["order_value"] = df["quantity"] * df["unit_price"]
print(df[["order_id", "quantity", "unit_price", "order_value"]])

# Q68: count orders by status
print(df["status"].value_counts())

# Q69: convert order_date to datetime
df["order_date"] = pd.to_datetime(df["order_date"])
print(df.dtypes)

# Q70: month column
df["month"] = df["order_date"].dt.month
print(df[["order_id", "order_date", "month"]])

# Q71: order count by month and status
print(df.groupby(["month", "status"]).size())

# Q72: total order value by category
print(df.groupby("category")["order_value"].sum())

# Q73: average order value by category
print(df.groupby("category")["order_value"].mean())

# Q74: sort by order value, descending
print(df.sort_values("order_value", ascending=False))
