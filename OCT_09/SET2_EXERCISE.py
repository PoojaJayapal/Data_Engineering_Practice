sales = [
("North", 12000),
("South", 18000),
("West", 9500),
("North", 22000),
("East", 15000),
("South", 11000)
]
#1
print(*sales)
#2
for s in sales:
    print(s[0])
#3
for s in sales:
    print(s[1])
#4
for s in sales:
    if s[1]>12000:
        print(s[0],s[1])
#5
amt=0
for s in sales:
    amt=amt+s[1]
print(f"Total amount: {amt}")
#6
for s in sales:
    maxSales=s[1]
    minSales=s[1]
    if s[1]>maxSales:
        maxSales=s[1]
    if s[1]<minSales:
        minSales=s[1]
print(f"High sales: {maxSales}")
print(f"Low sales: {minSales}")
#7
lis=[]
for s in sales:
    lis.append(s[1])
print(f"List: {lis}")
#8
unique=set()
for s in sales:
    unique.add(s[0])
print(f"Set:{unique}")
#9
Sort_sales = sorted(sales, key=lambda t: t[1])
for record in Sort_sales:
    print(record)
#10
Sort_region = sorted(sales, key=lambda t: t[0])
for record in Sort_region:
    print(record)
# Tasks

# 1. Display all tuples.
# 2. Display only the region from every tuple.
# 3. Display only the sales amount.
# 4. Find sales greater than 12000 .
# 5. Calculate total sales.
# 6. Find the highest and lowest sales amount.
# 7. Create a list containing only sales amounts.
# 8. Find unique regions using a set.
# 9. Sort the tuples based on sales amount.
# 10. Sort the tuples based on region name.


