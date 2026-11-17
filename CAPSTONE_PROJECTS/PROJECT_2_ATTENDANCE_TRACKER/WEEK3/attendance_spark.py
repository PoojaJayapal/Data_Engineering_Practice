from pyspark.sql import SparkSession
from pyspark.sql import functions as F
import os

# ---------- 1. Start Spark Session ----------
spark = SparkSession.builder \
    .appName("EmployeeAttendanceAnalysis") \
    .getOrCreate()

# ---------- 2. Load Large Attendance Data ----------
attendance = spark.read.csv("attendance_large.csv", header=True, inferSchema=True)
tasks = spark.read.csv("tasks.csv", header=True, inferSchema=True)

print("Attendance Rows Loaded:", attendance.count())
print("Tasks Rows Loaded:", tasks.count())

# ---------- 3. Clean & Prepare ----------
attendance = attendance.withColumn("clock_in",  F.to_timestamp("clock_in")) \
                       .withColumn("clock_out", F.to_timestamp("clock_out"))

attendance = attendance.withColumn(
    "break_minutes",
    F.when(F.col("break_minutes") < 0, 0).otherwise(F.col("break_minutes"))
).fillna({"break_minutes": 0})

tasks = tasks.fillna({"tasks_completed": 0})

# Join attendance and tasks
df = attendance.join(tasks, on=["employee_id", "work_date"], how="inner")

# ---------- 4. Calculate Work Hours ----------
df = df.withColumn(
    "work_hours",
    (F.unix_timestamp("clock_out") - F.unix_timestamp("clock_in")) / 3600
    - F.col("break_minutes") / 60
)

# ---------- 5. Productivity Score ----------
df = df.withColumn(
    "productivity_score",
    F.when(F.col("work_hours") > 0,
           F.col("tasks_completed") / F.col("work_hours")
    ).otherwise(0)
)

# ---------- 6. Flag Late Logins (after 09:15) ----------
df = df.withColumn(
    "is_late",
    F.when(
        F.col("clock_in").isNotNull(),
        (F.hour("clock_in") * 60 + F.minute("clock_in")) > (9 * 60 + 15)
    ).otherwise(False)
)

# ---------- 7. Flag Absences ----------
df = df.withColumn(
    "is_absent",
    F.col("clock_in").isNull() & F.col("clock_out").isNull()
)

# ---------- 8. Show Late Logins ----------
print("\n========== LATE LOGINS ==========")
df.filter(F.col("is_late") == True) \
  .select("employee_id", "department", "work_date", "clock_in") \
  .orderBy("department", "work_date") \
  .show(20, truncate=False)

# ---------- 9. Show Absences ----------
print("\n========== ABSENCES ==========")
df.filter(F.col("is_absent") == True) \
  .select("employee_id", "department", "work_date") \
  .orderBy("department", "work_date") \
  .show(20, truncate=False)

# ---------- 10. Group by Department ----------
print("\n========== DEPARTMENT SUMMARY ==========")
dept_summary = df.groupBy("department").agg(
    F.round(F.mean("work_hours"),         2).alias("avg_work_hours"),
    F.round(F.mean("productivity_score"), 2).alias("avg_productivity"),
    F.sum(F.col("is_absent").cast("int")).alias("total_absences"),
    F.sum(F.col("is_late").cast("int"))  .alias("total_late_logins")
).orderBy("department")

dept_summary.show(truncate=False)

# ---------- 11. Attendance Issues by Department ----------
print("\n========== ATTENDANCE ISSUES BY DEPARTMENT ==========")
attendance_issues = df.groupBy("department").agg(
    F.sum(F.col("is_absent").cast("int")).alias("total_absences"),
    F.sum(F.col("is_late").cast("int"))  .alias("total_late_logins"),
    F.count("employee_id")               .alias("total_records")
).withColumn(
    "issue_rate_%",
    F.round(
        (F.col("total_absences") + F.col("total_late_logins")) /
        F.col("total_records") * 100, 2
    )
).orderBy(F.col("issue_rate_%").desc())

attendance_issues.show(truncate=False)

# ---------- 12. Save Output to output/ folder ----------
os.makedirs("output", exist_ok=True)

dept_summary.coalesce(1).write.csv(
    "output/department_summary", header=True, mode="overwrite"
)
attendance_issues.coalesce(1).write.csv(
    "output/attendance_issues", header=True, mode="overwrite"
)

print("\nDone! Outputs saved to output/ folder.")
spark.stop()
