import json

# Q24: read employees.json
with open("employees.json", "r") as f:
    employees = json.load(f)

# Q25: all employee names
print("Names:", [e["name"] for e in employees])

# Q26: earning above 75000
print("Salary > 75000:", [e["name"] for e in employees if e["salary"] > 75000])

# Q27: employees who know Python
print("Know Python:", [e["name"] for e in employees if "Python" in e["skills"]])

# Q28: name and performance rating
for e in employees:
    print(f"{e['name']}: {e['performance']['rating']}")

# Q29: rating above 4.5
print("Rating > 4.5:", [e["name"] for e in employees if e["performance"]["rating"] > 4.5])

# Q30: sort by rating, descending
print("Sorted by rating:")
for e in sorted(employees, key=lambda x: x["performance"]["rating"], reverse=True):
    print(e["name"], e["performance"]["rating"])

# Q31: add one skill to employee 303
for e in employees:
    if e["employee_id"] == 303:
        e["skills"].append("Python")

# Q32: save the modified JSON
with open("employees_updated.json", "w") as f:
    json.dump(employees, f, indent=4)
