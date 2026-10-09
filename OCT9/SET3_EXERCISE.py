import json
data = [
    {
        "project_id": 101,
        "project_name": "Data Migration",
        "department": "IT",
        "budget": 450000,
        "technologies": ["Python", "SQL", "Azure"],
        "team": [
            {"name": "Vikram", "role": "Engineer", "experience": 4},
            {"name": "Meera", "role": "Analyst", "experience": 3}
        ]
    },
    {
        "project_id": 102,
        "project_name": "Customer Analytics",
        "department": "Analytics",
        "budget": 300000,
        "technologies": ["Python", "Pandas", "Power BI"],
        "team": [
            {"name": "Karan", "role": "Data Analyst", "experience": 5},
            {"name": "Zoya", "role": "Developer", "experience": 2}
        ]
    },
    {
        "project_id": 103,
        "project_name": "Cloud Modernization",
        "department": "Cloud",
        "budget": 600000,
        "technologies": ["Azure", "Docker", "Python"],
        "team": [
            {"name": "Naveen", "role": "Cloud Engineer", "experience": 6},
            {"name": "Isha", "role": "Engineer", "experience": 4}
        ]
    }
]

with open("projects.json", "w") as file:
    json.dump(data, file, indent=2)

# 1
with open("projects.json", "r") as file:
    projects = json.load(file)

# 2
print("Type:", type(projects))

# 3
print("\n Project names:")
for p in projects:
    print(p["project_name"])

# 4

for p in projects:
    if p["budget"] > 400000:
        print(p["project_name"], p["budget"])

# 5

for p in projects:
    if "Python" in p["technologies"]:
        print(p["project_name"])

# 6
total_budget = sum(p["budget"] for p in projects)
print("\n Total budget:", total_budget)

# 7
all_tech = []
for p in projects:
    all_tech.extend(p["technologies"])
print("\n All technologies:", all_tech)

# 8
print("\n Unique technologies:", set(all_tech))

# 9
for p in projects:
    for m in p["team"]:
        print(m["name"], m["role"], m["experience"])

# 10
for p in projects:
    for m in p["team"]:
        if m["experience"] > 3:
            print(m["name"], m["role"], m["experience"])

# 11
total_members = sum(len(p["team"]) for p in projects)
print("\n Total team members:", total_members)

# 12
for p in sorted(projects, key=lambda p: p["budget"], reverse=True):
    print(p["project_name"], p["budget"])

# 13
for p in sorted(projects, key=lambda p: p["project_name"]):
    print(p["project_name"])

# 14
for p in projects:
    p["team"].sort(key=lambda m: m["experience"])
    print(p["project_name"])
    for m in p["team"]:
        print("  ", m["name"], m["experience"])

# Tasks

# 1. Read the JSON file into Python.
# 2. Check the datatype of the returned object.
# 3. Display all project names.
# 4. Display projects having a budget above ₹4,00,000 .
# 5. Display projects that use Python .
# 6. Calculate the total budget of all projects.
# 7. Extract all technologies into one Python list.
# 8. Find the unique technologies.
# 9. Display every team member's:
# name
# role
# experience
# 10. Display team members having more than 3 years of experience.
# 11. Find the total number of team members across all projects.
# 12. Sort projects by budget from highest to lowest.
# 13. Sort projects alphabetically by project name.
# 14. Sort each project's team members based on experience.
