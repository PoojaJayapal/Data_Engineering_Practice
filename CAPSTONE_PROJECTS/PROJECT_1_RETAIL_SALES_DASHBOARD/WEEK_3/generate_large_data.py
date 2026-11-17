from pathlib import Path

import numpy as np
import pandas as pd

ROWS = 10_000
OUT_FILE = Path(__file__).parent / "data" / "sales_large.csv"

rng = np.random.default_rng(42)

PRODUCTS = [
    (1, "Headphones",     "Electronics", 89.99, 0.62, 0.28, 0.03),
    (2, "Coffee Maker",   "Home",        59.50, 0.65, 0.22, 0.04),
    (3, "Yoga Mat",       "Sports",      24.99, 0.55, 0.10, 0.02),   
    (4, "Running Jacket", "Apparel",     74.25, 0.60, 0.15, 0.15),   
    (5, "Smart Watch",    "Electronics", 199.00, 0.70, 0.25, 0.05),
]
prod = pd.DataFrame(PRODUCTS, columns=[
    "product_id", "product_name", "category", "price", "cost_ratio", "weight", "return_rate"])

idx = rng.choice(len(prod), size=ROWS, p=prod["weight"])
chosen = prod.iloc[idx].reset_index(drop=True)

quantity = rng.integers(1, 7, size=ROWS)
discount = rng.choice([0, 0, 5, 10, 15, 20], size=ROWS)

returned = rng.binomial(quantity, chosen["return_rate"].to_numpy())

dates = pd.to_datetime("2025-01-01") + pd.to_timedelta(rng.integers(0, 365, size=ROWS), unit="D")

df = pd.DataFrame({
    "sale_id": np.arange(1, ROWS + 1),
    "store_id": rng.integers(1, 6, size=ROWS),
    "product_id": chosen["product_id"],
    "product_name": chosen["product_name"],
    "category": chosen["category"],
    "quantity": quantity,
    "price": chosen["price"],
    "discount_pct": discount,
    "cost": np.round(quantity * chosen["price"] * chosen["cost_ratio"], 2),
    "sale_date": dates.strftime("%Y-%m-%d"),
    "returned_qty": returned,
})

OUT_FILE.parent.mkdir(exist_ok=True)
df.to_csv(OUT_FILE, index=False)
print(f"Saved {len(df):,} rows to {OUT_FILE}")
