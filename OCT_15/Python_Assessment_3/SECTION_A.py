# Q1-4: Booking
name = input("Attendee name: ")
tickets = int(input("Number of tickets: "))
ticket_price = float(input("Ticket price: "))

total = tickets * ticket_price
rate = 0.10 if total >= 10000 else 0.05
discount = total * rate
final_amount = total - discount

print(f"Attendee      : {name}")
print(f"Tickets       : {tickets}")
print(f"Ticket price  : ₹{ticket_price:,.2f}")
print(f"Total amount  : ₹{total:,.2f}")
print(f"Discount ({rate:.0%}): ₹{discount:,.2f}")
print(f"Final amount  : ₹{final_amount:,.2f}")

# Q5-6: Capacity check
capacity = int(input("Event capacity: "))
registered = int(input("Registered participants: "))

if registered == capacity:
    print("Full")
elif registered < capacity:
    print("Seats Available")
else:
    print("Invalid Data")

# Q7: 1-15
for i in range(1, 16):
    print(i, end=" ")
print()

# Q8: divisible by 3
for i in range(1, 16):
    if i % 3 == 0:
        print(i, end=" ")
print()

# Q9: countdown
n = 10
while n >= 1:
    print(n)
    n -= 1

# Q10: break and continue
for i in range(1, 11):
    if i == 3:
        continue          # skip 3
    if i == 8:
        break             # stop at 8
    print(i)
