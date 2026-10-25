# Creates fake attendance.csv and tasks.csv (with some dirty data)
import pandas as pd
import numpy as np

np.random.seed(1)

departments = {1: "Engineering", 2: "Engineering", 3: "Engineering",
               4: "HR", 5: "HR", 6: "Sales", 7: "Sales",
               8: "Finance", 9: "Finance", 10: "Support"}

# chance of being absent for each employee
absent_chance = {1: 0.02, 2: 0.0, 3: 0.1, 4: 0.05, 5: 0.02,
                 6: 0.3, 7: 0.1, 8: 0.03, 9: 0.2, 10: 0.2}

days = pd.bdate_range("2026-10-12", "2026-10-23")   

attendance_rows = []
task_rows = []

for emp_id in departments:
    for day in days:
        tasks_assigned = np.random.randint(3, 7)

        if np.random.rand() < absent_chance[emp_id]:
            clock_in = None
            clock_out = None
            tasks_done = 0
        else:
            late_minutes = np.random.randint(0, 50)
            clock_in = day + pd.Timedelta(hours=9, minutes=late_minutes)
            clock_out = clock_in + pd.Timedelta(hours=np.random.uniform(7, 9.5))
            tasks_done = np.random.randint(1, tasks_assigned + 1)

        attendance_rows.append({
            "employee_id": emp_id,
            "department": departments[emp_id],
            "work_date": day.date(),
            "clock_in": clock_in,
            "clock_out": clock_out,
            "break_minutes": np.random.choice([30, 45, 60])
        })
        task_rows.append({
            "employee_id": emp_id,
            "work_date": day.date(),
            "tasks_assigned": tasks_assigned,
            "tasks_completed": tasks_done
        })

attendance = pd.DataFrame(attendance_rows)
tasks = pd.DataFrame(task_rows)

# ---- add some dirty data on purpose ----
attendance.loc[5, "break_minutes"] = None              # missing break
attendance.loc[12, "clock_out"] = None                 # clock-in but no clock-out
attendance.loc[20, "clock_out"] = attendance.loc[20, "clock_in"] - pd.Timedelta(hours=1)  # invalid time
attendance.loc[30, "break_minutes"] = -10              # negative break
tasks.loc[8, "tasks_completed"] = None                 # missing task count
attendance = pd.concat([attendance, attendance.iloc[[40]]])   # duplicate row

attendance.to_csv("data/raw/attendance.csv", index=False)
tasks.to_csv("data/raw/tasks.csv", index=False)
print("Raw files created:", len(attendance), "attendance rows,", len(tasks), "task rows")
