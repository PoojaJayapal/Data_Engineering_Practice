# Q26
def calculate_booking(ticket_price, tickets):
    return ticket_price * tickets

# Q27
def calculate_discount(amount):
    rate = 0.10 if amount >= 10000 else 0.05
    return amount * rate

# Q28
def is_active(status):
    return status.strip().lower() in ("confirmed", "pending")

# Q29
def total_amount(amounts):
    return sum(amounts)

print(calculate_booking(2500, 2))
print(calculate_discount(10000))
print(is_active("Cancelled"), is_active("Confirmed"))
print(total_amount([5000, 3500, 7500]))

# Q30
increase_10 = lambda amt: amt * 1.10
print(increase_10(5000))

# Q31
amounts = [5000, 3500, 7500, 6000, 4000, 7000, 3000, 10000]
print(list(filter(lambda a: a > 6000, amounts)))

# Q32
registrations = [
    {"registration_id": "R1001", "attendee_name": "Aarav Shah",  "city": "Hyderabad", "status": "Confirmed", "amount": 5000},
    {"registration_id": "R1003", "attendee_name": "Faiz Ahmed",  "city": "Pune",      "status": "Pending",   "amount": 7500},
    {"registration_id": "R1005", "attendee_name": "Mohit Kapoor","city": "Delhi",     "status": "Cancelled", "amount": 4000},
    {"registration_id": "R1006", "attendee_name": "Ananya Das",  "city": "Hyderabad", "status": "Confirmed", "amount": 7000},
    {"registration_id": "R1009", "attendee_name": "Harish Nair", "city": "Chennai",   "status": "Confirmed", "amount": 8000},
]
confirmed = list(filter(lambda r: r["status"] == "Confirmed", registrations))
print(confirmed)

# Q33
print(list(map(lambda r: r["city"], registrations)))

# Q34
print(set(map(lambda r: r["city"], registrations)))

# Q35
sorted_regs = sorted(registrations, key=lambda r: r["amount"])
for r in sorted_regs:
    print(r["attendee_name"], r["amount"])
