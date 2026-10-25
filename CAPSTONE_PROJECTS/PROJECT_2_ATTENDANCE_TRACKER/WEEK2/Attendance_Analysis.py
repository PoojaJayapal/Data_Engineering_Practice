import pandas as pd
import numpy as np

# ---------- 1. Read data ----------
attendance = pd.read_csv("attendance.csv")
tasks = pd.read_csv("tasks.csv")
print("Rows before cleaning:", len(attendance))

# ---------- 2. Clean data ----------
attendance = attendance.drop_duplicates()
tasks = tasks.drop_duplicates()

attendance["clock_in"] = pd.to_datetime(attendance["clock_in"], errors="coerce")
attendance["clock_out"] = pd.to_datetime(attendance["clock_out"], errors="coerce")

# missing or negative break -> 0
attendance["break_minutes"] = attendance["break_minutes"].fillna(0)
attendance.loc[attendance["break_minutes"] < 0, "break_minutes"] = 0

# absent = no clock_in and no clock_out
attendance["is_absent"] = attendance["clock_in"].isna() & attendance["clock_out"].isna()

# drop rows with only one of clock_in / clock_out
only_one_missing = attendance["clock_in"].isna() != attendance["clock_out"].isna()
attendance = attendance[~only_one_missing]

# drop rows where clock_out is before clock_in
attendance = attendance[~(attendance["clock_out"] < attendance["clock_in"])]

# missing task count -> 0
tasks["tasks_completed"] = tasks["tasks_completed"].fillna(0)

print("Rows after cleaning:", len(attendance))

# ---------- 3. Calculate work hours and productivity ----------
df = attendance.merge(tasks, on=["employee_id", "work_date"])

total_hours = (df["clock_out"] - df["clock_in"]) / np.timedelta64(1, "h")
df["work_hours"] = total_hours - df["break_minutes"] / 60
df["work_hours"] = df["work_hours"].fillna(0)

df["productivity_score"] = np.where(df["work_hours"] > 0,
                                    df["tasks_completed"] / df["work_hours"], 0)

late_time = pd.to_datetime(df["work_date"].astype(str) + " 09:15:00")
df["is_late"] = df["clock_in"] > late_time

df.to_csv("cleaned_attendance.csv", index=False)

# ---------- 4. Report ----------
summary = df.groupby(["employee_id", "department"]).agg(
    avg_work_hours=("work_hours", "mean"),
    avg_productivity=("productivity_score", "mean"),
    days_absent=("is_absent", "sum"),
    days_late=("is_late", "sum")
).reset_index().round(2)

print("\nTOP 3 PERFORMERS")
print(summary.sort_values("avg_productivity", ascending=False).head(3).to_string(index=False))

print("\nBOTTOM 3 PERFORMERS")
print(summary.sort_values("avg_productivity").head(3).to_string(index=False))

print("\nFREQUENT ABSENTEES (2+ days)")
absentees = summary[summary["days_absent"] >= 2].sort_values("days_absent", ascending=False)
print(absentees.to_string(index=False))
