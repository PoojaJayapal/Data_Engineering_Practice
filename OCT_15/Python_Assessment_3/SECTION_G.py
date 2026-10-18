import json

# Q61
with open("staff.json", "r") as f:
    staff = json.load(f)

# Q62
print(type(staff))            # <class 'list'>
print(type(staff[0]))         # <class 'dict'>

# Q63
print([s["name"] for s in staff])

# Q64
print([s["name"] for s in staff if s["department"] == "Operations"])

# Q65
print([s["name"] for s in staff if s["salary"] > 75000])

# Q66
print([s["name"] for s in staff if "Python" in s["skills"]])

# Q67
for s in staff:
    print(f"Name: {s['name']}, Rating: {s['performance']['rating']}, "
          f"Events Handled: {s['performance']['events_handled']}")

# Q68
print([s["name"] for s in staff if s["performance"]["rating"] > 4.5])

# Q69
all_skills = [skill for s in staff for skill in s["skills"]]
print(all_skills)

# Q70
print(set(all_skills))

# Q71
for s in sorted(staff, key=lambda x: x["salary"], reverse=True):
    print(s["name"], s["salary"])

# Q72
for s in sorted(staff, key=lambda x: x["performance"]["rating"], reverse=True):
    print(s["name"], s["performance"]["rating"])

# Q73
for s in staff:
    if s["staff_id"] == 503:
        s["skills"].append("Pandas")

# Q74
with open("staff_updated.json", "w") as f:
    json.dump(staff, f, indent=4)
