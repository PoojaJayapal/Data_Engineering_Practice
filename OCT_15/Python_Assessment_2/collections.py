# Q7: list of shipment costs
costs = [850, 620, 1250, 480, 1600, 740, 590, 1100, 920, 1750, 520, 1050]

# Q8: total, average, minimum, maximum
print("Total:", sum(costs))
print("Average:", sum(costs) / len(costs))
print("Minimum:", min(costs))
print("Maximum:", max(costs))

# Q9: remove duplicate destinations using a set
destinations = [
    "Hyderabad", "Mumbai", "Bangalore", "Delhi", "Pune", "Hyderabad",
    "Mumbai", "Delhi", "Bangalore", "Pune", "Hyderabad", "Mumbai"
]
unique_destinations = set(destinations)
print("Unique destinations:", unique_destinations)

# Q10: one shipment as a dictionary
shipment = {
    "shipment_id": "S1001",
    "hub_id": "H01",
    "destination": "Hyderabad",
    "weight": 12.5,
    "status": "Delivered",
    "cost": 850
}
print(shipment)

# Q11: multiple shipments as a list of dictionaries
shipments = [
    {"shipment_id": "S1001", "destination": "Hyderabad", "weight": 12.5, "status": "Delivered",  "cost": 850},
    {"shipment_id": "S1002", "destination": "Mumbai",    "weight": 8.0,  "status": "In Transit", "cost": 620},
    {"shipment_id": "S1003", "destination": "Bangalore", "weight": 18.5, "status": "Delivered",  "cost": 1250},
    {"shipment_id": "S1004", "destination": "Delhi",     "weight": 5.5,  "status": "Pending",    "cost": 480},
    {"shipment_id": "S1005", "destination": "Pune",      "weight": 22.0, "status": "Delivered",  "cost": 1600},
    {"shipment_id": "S1006", "destination": "Hyderabad", "weight": 10.0, "status": "In Transit", "cost": 740},
]

# Q12: filter list records by status
delivered = [s for s in shipments if s["status"] == "Delivered"]
print("Delivered shipments:")
for s in delivered:
    print(s)
