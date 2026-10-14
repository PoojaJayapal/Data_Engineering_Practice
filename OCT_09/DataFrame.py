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
#EG 1
print(df["status"].value_counts())
#EG 2
result=(df.groupby("status").size())
print(result)
#Both EG1 AND EG2 GIVES THE SAME RESULT
#EG 3
df["order_date"]=pd.to_datetime(df["order_date"])
df["month"]=df["order_date"].dt.month
print(df)
