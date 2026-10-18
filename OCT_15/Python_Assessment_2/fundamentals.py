
# Q1: accept weight and cost
weight = float(input("Shipment weight (kg): "))
cost = float(input("Shipment cost: "))

# Q2: cost per kg
cost_per_kg = cost / weight
print(f"Cost per kg: ₹{cost_per_kg:.2f}")

# Q3: classify by weight
if weight > 20:
    category = "Heavy"
elif weight >= 10:
    category = "Medium"
else:
    category = "Light"
print(f"Category: {category}")

# Q4: shipment numbers 1-20
for i in range(1, 21):
    print(i, end=" ")
print()

# Q5: only even shipment numbers
for i in range(1, 21):
    if i % 2 == 0:
        print(i, end=" ")
print()

# Q6: five processing attempts with a while loop
attempt = 1
while attempt <= 5:
    print(f"Processing attempt {attempt} of 5")
    attempt += 1
