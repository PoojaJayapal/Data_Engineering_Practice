import event_utils                                   # Q76: import the entire module
from event_utils import calculate_discount           # Q78: import one function
import event_utils as eu                             # Q79: alias

# Q77: call all three functions
amount = event_utils.calculate_booking_amount(2500, 4)
print("Amount:", amount)
print("Discount:", event_utils.calculate_discount(amount))
print("Capacity status:", event_utils.check_event_capacity(500, 480))

# Q78: directly imported function
print("Direct import discount:", calculate_discount(6000))

# Q79: via alias
print("Alias capacity status:", eu.check_event_capacity(200, 200))
