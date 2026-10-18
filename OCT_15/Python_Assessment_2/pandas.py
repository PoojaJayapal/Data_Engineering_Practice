import pandas as pd

# Q36: read shipments.csv
df = pd.read_csv("shipments.csv")
print(df.head())

# Q37: Delivered shipments
delivered = df.query("status == 'Delivered'")
print(delivered)

# Q38: count records by status
print(df["status"].value_counts())

# Q39: convert shipment_date to datetime
df["shipment_date"] = pd.to_datetime(df["shipment_date"])
df["month"] = df["shipment_date"].dt.month

# Q40: shipments by month and status
print(df.groupby(["month", "status"]).size().unstack(fill_value=0))

# Q41: average cost by destination
print(df.groupby("destination")["cost"].mean())

# Q42: total weight by destination
print(df.groupby("destination")["weight"].sum())

# Q43: dynamic usecols list
columns_needed = ["shipment_id", "destination", "status", "cost"]
selected = pd.read_csv("shipments.csv", usecols=columns_needed)
print(selected.head())

# Q44: read hubs.csv
hubs = pd.read_csv("hubs.csv")
print(hubs)

# Q45: inner join on hub_id
merged = pd.merge(df, hubs, on="hub_id", how="inner", suffixes=("", "_hub"))
print(merged[["shipment_id", "hub_id", "hub_name", "destination", "cost"]])

# Q46-47: total cost and number of shipments per hub
hub_summary = merged.groupby(["hub_id", "hub_name"]).agg(
    total_cost=("cost", "sum"),
    total_shipments=("shipment_id", "count")
).reset_index()

# Q48: sort hubs by total shipment cost
hub_summary = hub_summary.sort_values("total_cost", ascending=False)
print(hub_summary)

# Q49: save to CSV
hub_summary.to_csv("hub_summary.csv", index=False)

# Q50: save to JSON (record-oriented)
hub_summary.to_json("hub_summary.json", orient="records", indent=4)
