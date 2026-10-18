sales = [65000, 4500, 36000, 12000, 18000, 72000, 9000]
total_sales=0
#10
for s in sales:
    total_sales=total_sales+s
print(f"Total sales: {total_sales}")
#11
highest_sale=sales[0]
lowest_sale=sales[0]
for s in sales:
    if s>highest_sale:
        highest_sale=s
    if s<lowest_sale:
        lowest_sale=s
print(f"Highest sale: {highest_sale}, lowest sale: {lowest_sale}")
#12
for s in sales:
    if s>20000:
        print(s)
#13
sales.sort(reverse=True)
print(f"Sorted sales: {sales}")
#14
cities = [
"Hyderabad",
"Mumbai",
"Delhi",
"Hyderabad",
"Pune",
"Mumbai"]
print(f"Unique cities: {set(cities)}")
#15
tup=(101,"pen","stationary",20)
product_id, product_name, category, price = tup

print(product_id)
print(product_name)
print(category)
print(price)
#16
dic={"id":101,"Name":"Pooja","City":"Chennai","Orders":3,"Active_Status":True}
print(dic)
#17
dic["City"]="Madurai"
#18
dic["Orders"]=dic["Orders"]+1
#19
dic["Email"]="xxx@gmail.com"
#20
for key, value in dic.items():
    print(f"{key}: {value}")




