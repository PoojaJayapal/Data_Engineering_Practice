import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

# ---------- Settings ----------
NUM_EMPLOYEES = 500
DEPARTMENTS = ["Engineering", "HR", "Sales", "Finance", "Support"]
START_DATE = datetime(2026, 1, 1)
END_DATE = datetime(2026, 10, 31)
OUTPUT_FILE = "attendance_large.csv"

# ---------- Generate Dates ----------
date_range = []
current = START_DATE
while current <= END_DATE:
    if current.weekday() < 5:  # Monday to Friday only
        date_range.append(current.date())
    current += timedelta(days=1)

# ---------- Generate Data ----------
rows = []
for emp_id in range(1, NUM_EMPLOYEES + 1):
    dept = random.choice(DEPARTMENTS)
    for work_date in date_range:
        is_absent = random.random() < 0.05  # 5% absence rate

        if is_absent:
            rows.append({
                "employee_id": emp_id,
                "department": dept,
                "work_date": work_date,
                "clock_in": None,
                "clock_out": None,
                "break_minutes": random.choice([30, 45, 60])
            })
        else:
            # clock in between 8:50 and 9:30
            clock_in_minutes = random.randint(-10, 30)
            clock_in = datetime.combine(work_date, datetime.min.time()) \
                       + timedelta(hours=9, minutes=clock_in_minutes)

            # work 7 to 9 hours
            work_duration = random.uniform(7, 9)
            clock_out = clock_in + timedelta(hours=work_duration)

            rows.append({
                "employee_id": emp_id,
                "department": dept,
                "work_date": work_date,
                "clock_in": clock_in,
                "clock_out": clock_out,
                "break_minutes": random.choice([30, 45, 60])
            })

# ---------- Save to CSV ----------
df = pd.DataFrame(rows)
df.to_csv(OUTPUT_FILE, index=False)
print(f"Generated {len(df)} rows -> saved to {OUTPUT_FILE}")
