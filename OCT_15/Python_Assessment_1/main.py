import retail_utils                                  # Q57: import the module
from retail_utils import check_stock                 # Q59: import one function directly
import retail_utils as ru                            # Q60: import with an alias

# Q58: call all three functions through the module name
total = retail_utils.calculate_order_total(65000, 1)
print("Order total:", total)

discount = retail_utils.calculate_discount(total)
print("Discount:", discount)

print("Stock status:", retail_utils.check_stock(12))

# Q59: call the directly imported function without the module name
print("Direct call:", check_stock(0))

# Q60: call using the alias
print("Alias call:", ru.calculate_order_total(3000, 4))
print("Alias discount:", ru.calculate_discount(12000))
