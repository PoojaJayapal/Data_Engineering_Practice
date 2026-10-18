
# Q56: reusable functions

def calculate_order_total(unit_price, quantity):
    return unit_price * quantity


def calculate_discount(amount):
    # 10% discount for 50000 or more, otherwise 5%
    rate = 0.10 if amount >= 50000 else 0.05
    return amount * rate


def check_stock(stock):
    if stock > 20:
        return "High Stock"
    elif stock >= 1:
        return "Low Stock"
    return "Out of Stock"
