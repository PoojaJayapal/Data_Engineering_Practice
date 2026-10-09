
import csv
rows = [
    ["shipment_id", "customer", "city", "weight", "status", "cost"],
    ["S101", "Alpha Stores", "Hyderabad", 12.5, "Delivered", 850],
    ["S102", "Metro Mart", "Mumbai", 8.2, "In Transit", 620],
    ["S103", "Fresh Foods", "Hyderabad", 15.0, "Delivered", 1100],
    ["S104", "Quick Shop", "Pune", 5.5, "Pending", 450],
    ["S105", "Urban Retail", "Mumbai", 20.0, "Delivered", 1450],
    ["S106", "Daily Needs", "Delhi", 9.8, "In Transit", 700],
    ["S107", "Smart Bazaar", "Hyderabad", 7.5, "Pending", 550],
    ["S108", "Green Market", "Delhi", 18.2, "Delivered", 1300],
]

with open("shipments.csv", "w", newline="") as f:
    csv.writer(f).writerows(rows)

# 1 & 2. 
shipments = []
with open("shipments.csv", "r") as file:
    reader = csv.DictReader(file)
    for row in reader:
        shipments.append(row)

# 3
print("3. Complete list:")
for s in shipments:
    print(s)

# 4
print("\n4. ID, customer, status:")
for s in shipments:
    print(s["shipment_id"], s["customer"], s["status"])

# 5
for s in shipments:
    s["weight"] = float(s["weight"])
    s["cost"] = int(s["cost"])

# 6-
total_cost = 0
for s in shipments:
    total_cost += s["cost"]
print("\n6. Total shipping cost:", total_cost)

# 7

for s in shipments:
    if s["cost"] > 700:
        print(s["customer"], s["cost"])

# 8

delivered = filter(lambda s: s["status"] == "Delivered", shipments)
for s in delivered:
    print(s)

# 9
heavy = list(filter(lambda s: s["weight"] > 10, shipments))
for s in heavy:
    print(s["shipment_id"], s["customer"], s["weight"])

# 10
cities = list(map(lambda s: s["city"], shipments))
print("\n10. All cities:", cities)

# 11
unique_cities = set(map(lambda s: s["city"], shipments))
print("\n11. Unique cities:", unique_cities)

#12

by_cost = sorted(shipments, key=lambda s: s["cost"])
for s in by_cost:
    print(s["shipment_id"], s["customer"], s["cost"])

# 13

by_weight = sorted(shipments, key=lambda s: s["weight"], reverse=True)
for s in by_weight:
    print(s["shipment_id"], s["customer"], s["weight"])

#  14
print("\n14. Sorted by customer name:")
by_customer = sorted(shipments, key=lambda s: s["customer"])
for s in by_customer:
    print(s["shipment_id"], s["customer"])

# 15
cost_per_kg = lambda s: s["cost"] / s["weight"]
for s in shipments:
    print(s["shipment_id"], s["customer"], round(cost_per_kg(s), 2))

# Tasks

# 1. Read shipments.csv using Python's csv module.
# 2. Store all records inside a Python list.
# 3. Display the complete list.
# 4. Display only:
# shipment ID
# customer
# status
# 5. Convert weight and cost from strings to numeric values.
# 6. Calculate the total shipping cost.
# 7. Find shipments whose cost is greater than 700 .
# 8. Use filter() and lambda to display only Delivered shipments.
# 9. Use filter() and lambda to find shipments weighing more than 10 .
# 10. Use map() to extract all city names.
# 11. Use map() + set() to get the unique cities.
# 12. Sort the shipment list by cost from lowest to highest using key .

# 13. Sort by weight from highest to lowest.
# 14. Sort alphabetically by customer name.
# 15. Create a lambda function that calculates:

# cost per kg = cost / weight

# and display it for every shipment.
