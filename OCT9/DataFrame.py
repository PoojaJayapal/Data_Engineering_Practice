import pandas as pd
df = pd.read_csv("orders.csv")
print(df)
print(df.head())
print(df.tail())
print(df.columns)
print(df.shape)
print(df.dtypes)
df.info()

print(df["product"])
print(df[["order_id","product","amount"]])
#Filter
delivered=df.query("status=='Delivered'")
print(delivered)
result=df.query("amount>20000")
print(result)
