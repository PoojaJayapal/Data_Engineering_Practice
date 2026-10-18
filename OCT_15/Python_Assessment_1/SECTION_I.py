import numpy as np

# Q82: order_size using NumPy (conditions are checked in order)
conditions = [
    merged["order_value"] >= 50000,
    merged["order_value"] >= 15000
]
choices = ["High", "Medium"]
merged["order_size"] = np.select(conditions, choices, default="Low")

# Q83: priority_customer
merged["priority_customer"] = np.where(
    merged["segment"] == "Corporate", "Priority", "Normal"
)

print(merged[["order_id", "customer_name", "segment", "order_value",
              "order_size", "priority_customer"]])

# Q84: save the enriched dataset
merged.to_csv("enriched_orders.csv", index=False)
