from pathlib import Path

import numpy as np
import pandas as pd

BASE_DIR = Path(__file__).parent
DATA_DIR = BASE_DIR / "data"
OUTPUT_DIR = BASE_DIR / "output"

# 1. LOAD

def load_data():
    sales = pd.read_csv(DATA_DIR / "sales.csv")
    products = pd.read_csv(DATA_DIR / "products.csv")
    return sales, products



# 2. CLEAN (pandas)
def clean_data(sales):
    print(f"Rows loaded: {len(sales)}")
    print("Missing values before cleaning:")
    print(sales.isna().sum()[sales.isna().sum() > 0], "\n")

    # Remove duplicate rows
    sales = sales.drop_duplicates()

    # Correct data types
    sales["sale_date"] = pd.to_datetime(sales["sale_date"], errors="coerce")
    for col in ["quantity", "price", "discount_pct", "cost"]:
        sales[col] = pd.to_numeric(sales[col], errors="coerce")

    # Drop rows that can't be used at all
    sales = sales.dropna(subset=["sale_id", "store_id", "product_id", "price", "sale_date"])

    # Fill missing values
    sales["quantity"] = sales["quantity"].fillna(sales["quantity"].median())
    sales["discount_pct"] = sales["discount_pct"].fillna(0)

    # Missing cost -> estimate using the typical cost-to-price ratio
    known = sales["cost"].notna()
    cost_ratio = (sales.loc[known, "cost"] /
                  (sales.loc[known, "quantity"] * sales.loc[known, "price"])).median()
    sales["cost"] = sales["cost"].fillna(sales["quantity"] * sales["price"] * cost_ratio).round(2)

    # Final data types
    sales = sales.astype({
        "sale_id": "int64", "store_id": "int64", "product_id": "int64",
        "quantity": "int64",
    })

    print(f"Rows after cleaning: {len(sales)}\n")
    return sales.reset_index(drop=True)


# 3. CALCULATE (numpy)
def add_calculated_fields(df):
    gross = df["quantity"].to_numpy() * df["price"].to_numpy()
    discount_amount = gross * df["discount_pct"].to_numpy() / 100
    revenue = gross - discount_amount
    profit = revenue - df["cost"].to_numpy()

    df["gross_amount"] = np.round(gross, 2)
    df["discount_amount"] = np.round(discount_amount, 2)
    df["revenue"] = np.round(revenue, 2)
    df["profit"] = np.round(profit, 2)
    # profit margin %, protected against divide-by-zero
    df["profit_margin_pct"] = np.round(
        np.where(revenue > 0, profit / np.where(revenue == 0, 1, revenue) * 100, 0), 2
    )
    return df


# 4. SUMMARY
def summarize(df, group_cols):
    out = df.groupby(group_cols).agg(
        total_revenue=("revenue", "sum"),
        total_profit=("profit", "sum"),
        avg_discount_pct=("discount_pct", "mean"),
    )
    out["profit_margin_pct"] = np.round(out["total_profit"] / out["total_revenue"] * 100, 2)
    out[["total_revenue", "total_profit", "avg_discount_pct"]] = (
        out[["total_revenue", "total_profit", "avg_discount_pct"]].round(2)
    )
    return out.sort_values("total_revenue", ascending=False)


def main():
    sales, products = load_data()
    df = clean_data(sales)
    df = df.merge(products, on="product_id", how="left")
    df["product_name"] = df["product_name"].fillna("Unknown")
    df["category"] = df["category"].fillna("Unknown")
    df = add_calculated_fields(df)

    # Save cleaned dataset with calculated fields
    OUTPUT_DIR.mkdir(exist_ok=True)
    df.to_csv(OUTPUT_DIR / "cleaned_sales.csv", index=False)

    pd.set_option("display.width", 120)
    pd.set_option("display.max_columns", None)
    print("=== TOTAL REVENUE BY PRODUCT ===")
    print(summarize(df, ["product_name"]), "\n")

    print("=== TOTAL REVENUE BY STORE ===")
    print(summarize(df, ["store_id"]), "\n")

    print("=== TOTAL REVENUE BY PRODUCT AND STORE ===")
    print(summarize(df, ["product_name", "store_id"]), "\n")

    print(f"Overall revenue: {df['revenue'].sum():,.2f} | "
          f"profit: {df['profit'].sum():,.2f}")
    print(f"Cleaned dataset saved to {OUTPUT_DIR / 'cleaned_sales.csv'}")


if __name__ == "__main__":
    main()
