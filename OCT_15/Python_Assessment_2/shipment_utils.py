# Q33: reusable shipment functions

def calculate_cost_per_kg(cost, weight):
    return cost / weight


def shipment_category(weight):
    if weight > 20:
        return "Heavy"
    elif weight >= 10:
        return "Medium"
    return "Light"


def calculate_shipping_cost(weight, rate_per_kg=60, base_fee=100):
    return base_fee + weight * rate_per_kg


def filter_by_status(shipments, status):
    return [s for s in shipments if s["status"] == status]
