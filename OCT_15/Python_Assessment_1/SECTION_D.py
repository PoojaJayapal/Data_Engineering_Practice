class Product:
    #30
    def __init__(self, id, name, price,stock):
        self.id = id
        self.name = name
        self.price = price
        self.stock = stock
    #31
    def display_product(self):
        print(f"ID: {self.id}, NAME:{self.name}, PRICE: {self.price}, STOCK:{self.stock}")
    #32
    def calculate_value(self):
        print(self.price*self.stock)
# 33. Create two Product objects
p1 = Product(101, "Laptop", 50000, 5)
p2 = Product(102, "Mouse", 500, 20)
p1.calculate_value()
#34
class DiscountedProduct(Product):
    def __init__(self, id, name, price,stock,discount_percent):
        # 35
        self.discount_percent = discount_percent
        #36
        Product.__init__(self, id, name, price,stock)
     #37
    def display_product(self): \
            print(f"ID: {self.id}, Name: {self.name}, Price: {self.price}, Stock: {self.stock}, Discount: {self.discount_percent}%")
#38
class PremiumProduct(Product):
    def display_product(self):
        print(f"Premium Product: {self.name}, Price: {self.price}, Stock: {self.stock}")


# Create objects
p3 = DiscountedProduct(103, "Phone", 30000, 10, 15)
p4 = PremiumProduct(104, "Watch", 10000, 4)



# 39. Polymorphism
products = [p1, p3, p4]

for p in products:
    p.display_product()




