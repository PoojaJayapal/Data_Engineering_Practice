import shipment_utils                                  # Q34/Q35: normal import
from shipment_utils import shipment_category           # Q35: specific-function import

shipments = [
    {"shipment_id": "S1001", "destination": "Hyderabad", "weight": 12.5, "status": "Delivered",  "cost": 850},
    {"shipment_id": "S1002", "destination": "Mumbai",    "weight": 8.0,  "status": "In Transit", "cost": 620},
    {"shipment_id": "S1005", "destination": "Pune",      "weight": 22.0, "status": "Delivered",  "cost": 1600},
]

# Normal import: call with the module name
print("Cost per kg:", shipment_utils.calculate_cost_per_kg(850, 12.5))
print("Shipping cost:", shipment_utils.calculate_shipping_cost(12.5))
delivered = shipment_utils.filter_by_status(shipments, "Delivered")
print("Delivered:", [s["shipment_id"] for s in delivered])

# Specific import: call without the module name
print("Category:", shipment_category(22.0))
