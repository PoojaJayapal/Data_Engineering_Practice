product={
    "p_id":1,
    "p_name":"Pen",
    "p_price":20,}
print(product)
print(product["p_name"])
product["p_id"]=2
print(product)
print(product.get("Discount"))
product["Unit"]=5
print(product)
product.pop("p_name")
print(product)
del product["Unit"]
print(product)
