# Q13: shipping cost function
def calculate_shipping_cost(weight, rate_per_kg=60, base_fee=100):
    return base_fee + weight * rate_per_kg


# Q14: category by weight
def shipment_category(weight):
    if weight > 20:
        return "Heavy"
    elif weight >= 10:
        return "Medium"
    return "Light"


print(calculate_shipping_cost(12.5))
print(shipment_category(22.0), shipment_category(12.5), shipment_category(5.5))

shipments = [
    {"shipment_id": "S1001", "destination": "Hyderabad", "weight": 12.5, "status": "Delivered",  "cost": 850},
    {"shipment_id": "S1002", "destination": "Mumbai",    "weight": 8.0,  "status": "In Transit", "cost": 620},
    {"shipment_id": "S1003", "destination": "Bangalore", "weight": 18.5, "status": "Delivered",  "cost": 1250},
    {"shipment_id": "S1004", "destination": "Delhi",     "weight": 5.5,  "status": "Pending",    "cost": 480},
    {"shipment_id": "S1005", "destination": "Pune",      "weight": 22.0, "status": "Delivered",  "cost": 1600},
    {"shipment_id": "S1006", "destination": "Hyderabad", "weight": 10.0, "status": "In Transit", "cost": 740},
]

# Q15: lambda + filter for Delivered shipments
delivered = list(filter(lambda s: s["status"] == "Delivered", shipments))
print("Delivered:", [s["shipment_id"] for s in delivered])

# Q16: map to get all destinations
destinations = list(map(lambda s: s["destination"], shipments))
print("Destinations:", destinations)

# Q17: sort shipments by cost
sorted_by_cost = sorted(shipments, key=lambda s: s["cost"])
for s in sorted_by_cost:
    print(s["shipment_id"], s["cost"])
