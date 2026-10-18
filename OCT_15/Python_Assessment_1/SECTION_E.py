import csv
import json

# ---------- Text file (Q40-43) ----------
# Q40-41: create activity.txt and write three messages
with open("activity.txt", "w") as f:
    f.write("Order processing started\n")
    f.write("Customer records validated\n")
    f.write("Inventory check completed\n")

# Q42: append one more message
with open("activity.txt", "a") as f:
    f.write("Order summary generated\n")

# Q43: read and display the complete file
with open("activity.txt", "r") as f:
    print(f.read())

# ---------- CSV: customers.csv (Q44-47) ----------
# Q44-45: read with the csv module and store in a list
customers = []
with open("customers.csv", newline="") as f:
    reader = csv.DictReader(f)
    for row in reader:
        customers.append(row)

# Q46: only active customers (the CSV stores "True"/"False" as text)
print("Active customers:")
for c in customers:
    if c["active"] == "True":
        print(c["customer_id"], c["customer_name"], c["city"])

# Q47: only Hyderabad customers
print("\nHyderabad customers:")
for c in customers:
    if c["city"] == "Hyderabad":
        print(c["customer_id"], c["customer_name"], c["segment"])

# ---------- JSON: products.json (Q48-55) ----------
# Q48: read the JSON file
with open("products.json", "r") as f:
    products = json.load(f)

# Q49: all product names
print("\nProduct names:")
for p in products:
    print(p["product_name"])

# Q50: products costing above 10000
print("\nProducts above 10000:")
for p in products:
    if p["price"] > 10000:
        print(p["product_name"], p["price"])

# Q51: supplier name and city for every product
print("\nSuppliers:")
for p in products:
    print(f"{p['product_name']}: {p['supplier']['name']} ({p['supplier']['city']})")

# Q52: all colors into one list
all_colors = [color for p in products for color in p["colors"]]
print("\nAll colors:", all_colors)

# Q53: unique colors
print("Unique colors:", set(all_colors))

# Q54: increase stock of product ID 202 (adding 10)
for p in products:
    if p["product_id"] == 202:
        p["stock"] += 10
        print("\nNew stock for product 202:", p["stock"])

# Q55: write modified data to a new file
with open("products_updated.json", "w") as f:
    json.dump(products, f, indent=4)
