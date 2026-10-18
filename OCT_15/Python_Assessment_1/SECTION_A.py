
#1
product_name=input("Enter the product name:")
unit_price=int(input("Enter the unit price:"))
quantity=int(input("Enter the quantity:"))
#2
total_price=unit_price*quantity
#3
if total_price>=50000:
    discount=0.1*total_price
    final_amount=total_price-discount
else:
    discount=0.05*total_price
    final_amount=total_price-discount
#4
print(f"Original amount: {total_price} , discount: {discount} , final amount: {final_amount}")
#5
stock=int(input("Enter the stock:"))
if stock>20:
    print("High Stock")
elif stock>=1 and stock<=20:
    print("Low Stock")
else:
    print("No stock")
#6
for i in range(1,11):
    print(i)
#7
stock=5
while stock>=0:
    print(stock)
    stock=stock-1
#8
i=6
while i>=0:
    i=i-1
    if i==5:
        continue
    print(i)
#9
j=10
while j>0:
    if j==8:
        break
    print(j)
    j=j-1





