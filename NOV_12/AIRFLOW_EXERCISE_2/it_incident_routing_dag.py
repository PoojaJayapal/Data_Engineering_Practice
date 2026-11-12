from airflow import DAG
from airflow.providers.standard.operators.python import (
    PythonOperator,
    BranchPythonOperator
)
from datetime import datetime, timedelta


def load_incident():
    incident = {
        "ticket_id": "INC-402",
        "service": "Email",
        "severity": "Low",
        "reported_by": "Operations"
    }
    print("Incident loaded:", incident)
    return incident


def choose_response(**context):
    incident = context["ti"].xcom_pull(task_ids="load_incident")
    severity = incident["severity"]
    print("Severity level:", severity)
    if severity in ["High", "Critical"]:
        return "urgent_response"
    else:
        return "standard_response"


def urgent_response(**context):
    attempt = context["ti"].try_number
    print("Attempt number:", attempt)
    if attempt == 1:
        raise Exception("Urgent response system temporarily unavailable")
    print("ESCALATION: High severity incident assigned to senior engineer")
    print("Ticket INC-402 escalated immediately")


def standard_response():
    print("Standard ticket assigned to service desk")
    print("Ticket INC-402 queued for normal processing")


def write_audit(**context):
    incident = context["ti"].xcom_pull(task_ids="load_incident")
    print("AUDIT LOG")
    print("--------------------------")
    print("Ticket ID:", incident["ticket_id"])
    print("Service:", incident["service"])
    print("Severity:", incident["severity"])
    print("Reported By:", incident["reported_by"])
    print("Incident routing completed successfully")


with DAG(
    dag_id="it_incident_routing_pipeline",
    start_date=datetime(2025, 1, 1),
    schedule=None,
    catchup=False
) as dag:

    task1 = PythonOperator(
        task_id="load_incident",
        python_callable=load_incident
    )

    task2 = BranchPythonOperator(
        task_id="choose_response",
        python_callable=choose_response
    )

    task3 = PythonOperator(
        task_id="urgent_response",
        python_callable=urgent_response,
        retries=1,
        retry_delay=timedelta(seconds=15)
    )

    task4 = PythonOperator(
        task_id="standard_response",
        python_callable=standard_response
    )

    task5 = PythonOperator(
        task_id="write_audit",
        python_callable=write_audit,
        trigger_rule="none_failed_min_one_success"
    )

    task1 >> task2
    task2 >> [task3, task4]
    [task3, task4] >> task5
