import csv

# Q53-54
records = []
with open("registrations.csv", newline="") as f:
    reader = csv.DictReader(f)
    for row in reader:
        records.append(row)

# Q57: convert numeric fields
for r in records:
    r["amount"] = float(r["amount"])
    r["tickets"] = int(r["tickets"])

# Q55
print("Confirmed:")
for r in records:
    if r["status"] == "Confirmed":
        print(r)

# Q56
print("Hyderabad:")
for r in records:
    if r["city"] == "Hyderabad":
        print(r)

# Q58
print("Amount > 7000:")
for r in records:
    if r["amount"] > 7000:
        print(r["registration_id"], r["attendee_name"], r["amount"])

# Q59
print("Total amount:", sum(r["amount"] for r in records))

# Q60
all_cities = [r["city"] for r in records]
print("All cities:", all_cities)
print("Unique cities:", set(all_cities))
