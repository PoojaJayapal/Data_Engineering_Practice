class Event:
    def __init__(self, event_id, event_name, capacity, ticket_price):   # Q36
        self.event_id = event_id
        self.event_name = event_name
        self.capacity = capacity
        self.ticket_price = ticket_price

    def display_event(self):                                           # Q37
        print(f"Event {self.event_id}: {self.event_name} | "
              f"Capacity: {self.capacity} | Ticket price: ₹{self.ticket_price}")

    def calculate_revenue(self, tickets_sold):                         # Q38
        return tickets_sold * self.ticket_price


# Q39
e1 = Event("E101", "AI Innovation Summit", 500, 2500)
e2 = Event("E102", "Leadership Forum", 350, 3500)
e1.display_event()
e2.display_event()
print("Revenue:", e1.calculate_revenue(100))


class OnlineEvent(Event):
    def __init__(self, event_id, event_name, capacity, ticket_price, platform):
        super().__init__(event_id, event_name, capacity, ticket_price)  # Q41
        self.platform = platform                                        # Q40

    def display_event(self):                                            # Q42
        super().display_event()
        print(f"   Platform: {self.platform}")


class PhysicalEvent(Event):
    def __init__(self, event_id, event_name, capacity, ticket_price, venue):
        super().__init__(event_id, event_name, capacity, ticket_price)
        self.venue = venue                                              # Q43

    def display_event(self):                                            # Q44
        super().display_event()
        print(f"   Venue: {self.venue}")


# Q45-46
events = [
    OnlineEvent("E201", "Python Webinar", 1000, 500, "Zoom"),
    PhysicalEvent("E202", "Design Expo", 250, 1500, "Pune Convention Centre"),
]
for ev in events:
    ev.display_event()      # polymorphism
