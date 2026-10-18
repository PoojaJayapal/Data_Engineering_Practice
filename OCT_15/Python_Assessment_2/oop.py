# Q18-20: Shipment class
class Shipment:
    def __init__(self, shipment_id, destination, weight, cost):   # Q19
        self.shipment_id = shipment_id
        self.destination = destination
        self.weight = weight
        self.cost = cost

    def display(self):                                            # Q20
        print(f"Shipment {self.shipment_id} | {self.destination} | "
              f"{self.weight} kg | Cost: ₹{self.cost}")

    def total_cost(self):
        return self.cost


# Q21-22: ExpressShipment with a surcharge
class ExpressShipment(Shipment):
    def __init__(self, shipment_id, destination, weight, cost, surcharge=200):
        super().__init__(shipment_id, destination, weight, cost)
        self.surcharge = surcharge

    def total_cost(self):                                         # Q22: override
        return self.cost + self.surcharge

    def display(self):
        print(f"EXPRESS Shipment {self.shipment_id} | {self.destination} | "
              f"{self.weight} kg | Cost: ₹{self.cost} + surcharge ₹{self.surcharge} "
              f"= ₹{self.total_cost()}")


# Q23: polymorphism
shipments = [
    Shipment("S1001", "Hyderabad", 12.5, 850),
    Shipment("S1003", "Bangalore", 18.5, 1250),
    ExpressShipment("S1005", "Pune", 22.0, 1600),
    ExpressShipment("S1010", "Pune", 25.0, 1750, surcharge=300),
]

for s in shipments:
    s.display()
    print("   Total cost:", s.total_cost())
