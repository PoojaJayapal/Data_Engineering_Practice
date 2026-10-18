#21
def calculate_total(price,quantity):
    total=price*quantity
    return total
print(calculate_total(10,2))
#22
def calculate_discount(total_amount,discount):
    discount=(discount/100)*total_amount
    return discount
print(calculate_discount(100,10))
#23
def total_sales(sales):
    return sum(sales)
sales=[1000,2000,3000]
print(total_sales(sales))
#24
def product(dic):
    if dic["stock"]>0:
        return "Available"
    else:
        return "Out Of Stock"
dic={"name":"Laptop","category":"Electronics","stock":3}
print(product(dic))
#25
square_numbers=lambda num:[x*x for x in num]
print(square_numbers([5,10]))

#26
sales=[65000, 4500, 36000, 12000, 18000, 72000, 9000]
greater_sales=filter(lambda x:x>20000,sales )
print(list(greater_sales))
#27
customers = [
    {"name": "Pooja", "city": "Chennai"},
    {"name": "Ravi", "city": "Mumbai"},
    {"name": "Priya", "city": "Chennai"}
]
cities=list(map(lambda c:c["city"],customers))
print(cities)
#28
unique_cities = set(cities)
print(unique_cities)
products = [
    {"name": "Laptop", "price": 50000},
    {"name": "Mouse", "price": 500},
    {"name": "Phone", "price": 20000}
]
products.sort(key=lambda x: x["price"])
print(products)
