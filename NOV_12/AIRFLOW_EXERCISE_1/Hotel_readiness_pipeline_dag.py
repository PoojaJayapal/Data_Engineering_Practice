from airflow import DAG
from airflow.providers.standard.operators.python import PythonOperator
from datetime import datetime


def load_rooms():
    rooms = [
        {"room": 101, "status": "Ready", "cleaning_min": 0},
        {"room": 102, "status": "Cleaning", "cleaning_min": 25},
        {"room": 103, "status": "Ready", "cleaning_min": 0},
        {"room": 104, "status": "Cleaning", "cleaning_min": 40},
        {"room": 105, "status": "Cleaning", "cleaning_min": 30}
    ]
    print("Rooms loaded:", rooms)
    return rooms


def find_rooms_to_clean(**context):
    rooms = context["ti"].xcom_pull(task_ids="load_rooms")
    cleaning_rooms = [r["room"] for r in rooms if r["status"] == "Cleaning"]
    print("Rooms to clean:", cleaning_rooms)
    return cleaning_rooms


def calculate_cleaning_minutes(**context):
    rooms = context["ti"].xcom_pull(task_ids="load_rooms")
    total_minutes = sum(r["cleaning_min"] for r in rooms if r["status"] == "Cleaning")
    print("Total cleaning minutes:", total_minutes)
    return total_minutes


def generate_housekeeping_report(**context):
    cleaning_rooms = context["ti"].xcom_pull(task_ids="find_rooms_to_clean")
    total_minutes = context["ti"].xcom_pull(task_ids="calculate_cleaning_minutes")
    print("HOTEL HOUSEKEEPING REPORT")
    print("--------------------------")
    print("Rooms Needing Cleaning:", cleaning_rooms)
    print("Total Cleaning Time (mins):", total_minutes)


with DAG(
    dag_id="hotel_readiness_pipeline",
    start_date=datetime(2025, 1, 1),
    schedule=None,
    catchup=False
) as dag:

    task1 = PythonOperator(
        task_id="load_rooms",
        python_callable=load_rooms
    )

    task2 = PythonOperator(
        task_id="find_rooms_to_clean",
        python_callable=find_rooms_to_clean
    )

    task3 = PythonOperator(
        task_id="calculate_cleaning_minutes",
        python_callable=calculate_cleaning_minutes
    )

    task4 = PythonOperator(
        task_id="generate_housekeeping_report",
        python_callable=generate_housekeeping_report
    )

    task1 >> [task2, task3]
    [task2, task3] >> task4
