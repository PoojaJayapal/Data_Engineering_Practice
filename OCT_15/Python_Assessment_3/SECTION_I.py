import pandas as pd

# Q80
df = pd.read_csv("registrations.csv")

# Q81
print(df.head())
print(df.tail())
print(df.shape)
print(df.columns)
print(df.dtypes)

# Q82
print(df[["attendee_name", "city", "status", "amount"]])

# Q83
print(df.query("status == 'Confirmed'"))

# Q84
print(df.query("amount > 6000"))

# Q85
print(df.query("status == 'Confirmed' and city == 'Hyderabad'"))

# Q86
print(df["status"].value_counts())

# Q87
print(df.groupby("status")["amount"].sum())

# Q88
print(df.groupby("city")["amount"].mean())
