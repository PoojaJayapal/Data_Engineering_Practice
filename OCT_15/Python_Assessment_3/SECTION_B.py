booking_amounts = [5000, 3500, 7500, 6000, 4000, 7000, 3000, 10000]

# Q11-13
total = sum(booking_amounts)
average = total / len(booking_amounts)
print("Total:", total)
print("Average:", average)
print("Highest:", max(booking_amounts), "Lowest:", min(booking_amounts))

# Q14
print("Greater than 5000:", [a for a in booking_amounts if a > 5000])

# Q15
print("Descending:", sorted(booking_amounts, reverse=True))

cities = ["Hyderabad", "Mumbai", "Pune", "Hyderabad", "Delhi", "Mumbai"]

# Q16-18
unique_cities = set(cities)
print("Unique:", unique_cities)
unique_cities.add("Chennai")
print("After add:", unique_cities)
print("Count:", len(unique_cities))

# Q19-20
event = ("E101", "AI Innovation Summit", "Hyderabad", 500)
event_id, event_name, venue, capacity = event
print(event_id, event_name, venue, capacity)

# Q21-25
registration = {
    "registration_id": "R1001",
    "attendee_name": "Aarav Shah",
    "city": "Hyderabad",
    "tickets": 2,
    "status": "Confirmed",
    "amount": 5000
}
registration["status"] = "Pending"          # Q22
registration["tickets"] += 1                # Q23
registration["email"] = "aarav@example.com" # Q24
for key, value in registration.items():     # Q25
    print(f"{key}: {value}")
