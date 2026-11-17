from datetime import datetime
import csv

from airflow import DAG
from airflow.operators.python import PythonOperator


# Task 1: Load batch records
def load_batches():
    with open("/opt/airflow/dags/factory_batches.csv", newline="") as file:
        rows = list(csv.DictReader(file))

    print("Batches loaded:", len(rows))
    return rows


# Task 2: Identify batches requiring quality review
def check_quality(ti):
    batches = ti.xcom_pull(task_ids="load_batches")

    review_batches = []

    for batch in batches:
        units = int(batch["units_produced"])
        defective = int(batch["defective_units"])

        if defective / units > 0.05:
            review_batches.append(batch["batch_id"])

    print("Batches requiring review:", review_batches)
    return review_batches


# Task 3: Calculate total production value
def calculate_value(ti):
    batches = ti.xcom_pull(task_ids="load_batches")

    total_value = 0

    for batch in batches:
        units = int(batch["units_produced"])
        price = int(batch["value_per_unit"])

        total_value += units * price

    print("Total production value:", total_value)
    return total_value


# Task 4: Generate final report
def generate_report(ti):
    batches = ti.xcom_pull(task_ids="load_batches")
    review_batches = ti.xcom_pull(task_ids="check_quality")
    total_value = ti.xcom_pull(task_ids="calculate_value")

    print("===== MANUFACTURING QUALITY REPORT =====")
    print("Total number of batches:", len(batches))
    print("Batches requiring review:", review_batches)
    print("Total production value:", total_value)
    print("========================================")


with DAG(
    dag_id="factory_quality_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False
) as dag:

    load_task = PythonOperator(
        task_id="load_batches",
        python_callable=load_batches
    )

    quality_task = PythonOperator(
        task_id="check_quality",
        python_callable=check_quality
    )

    value_task = PythonOperator(
        task_id="calculate_value",
        python_callable=calculate_value
    )

    report_task = PythonOperator(
        task_id="generate_report",
        python_callable=generate_report
    )

    load_task >> [quality_task, value_task] >> report_task
