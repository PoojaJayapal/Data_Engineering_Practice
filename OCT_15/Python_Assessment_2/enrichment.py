import pandas as pd
import numpy as np

df = pd.read_csv("shipments.csv")

# Q51: cost per kg
df["cost_per_kg"] = (df["cost"] / df["weight"]).round(2)

# Q52: NumPy classification
df["cost_class"] = np.where(df["cost"] >= 1200, "Expensive", "Normal")

# Q53: performance category based on status AND cost
conditions = [
    (df["status"] == "Delivered") & (df["cost"] >= 1200),
    (df["status"] == "Delivered") & (df["cost"] < 1200),
    (df["status"] == "In Transit") & (df["cost"] >= 1200),
    (df["status"] == "In Transit") & (df["cost"] < 1200),
    (df["status"] == "Pending") & (df["cost"] >= 1200),
    (df["status"] == "Pending") & (df["cost"] < 1200),
]
choices = [
    "Completed - High Value",
    "Completed - Standard",
    "On Route - High Value",
    "On Route - Standard",
    "Delayed Risk - High Value",
    "Delayed Risk - Standard",
]
df["performance_category"] = np.select(conditions, choices, default="Unknown")

print(df[["shipment_id", "status", "cost", "cost_per_kg", "cost_class", "performance_category"]])

# Q54: save the final enriched dataset
df.to_csv("shipment_analysis.csv", index=False)
