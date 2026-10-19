from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()


class Employee(BaseModel):
    id: int
    name: str
    department: str
    designation: str
    salary: float
    city: str


employees: list[Employee] = []


# Exercise 2: Add employee (POST)
@app.post("/employees")
def add_employee(employee: Employee):
    employees.append(employee)
    return {"message": "Employee added", "employee": employee}


# Exercise 3: Retrieve all employees (GET)
@app.get("/employees")
def get_employees():
    return employees


# Exercise 4: Retrieve employee by ID (GET)
@app.get("/employees/{employee_id}")
def get_employee(employee_id: int):
    for employee in employees:
        if employee.id == employee_id:
            return employee
    raise HTTPException(status_code=404, detail="Employee not found")


# Exercise 5: Update employee (PUT)
@app.put("/employees/{employee_id}")
def update_employee(employee_id: int, updated_employee: Employee):
    for index, employee in enumerate(employees):
        if employee.id == employee_id:
            employees[index] = updated_employee
            return {"message": "Employee updated", "employee": updated_employee}
    raise HTTPException(status_code=404, detail="Employee not found")


# Exercise 6: Delete employee (DELETE)
@app.delete("/employees/{employee_id}")
def delete_employee(employee_id: int):
    for index, employee in enumerate(employees):
        if employee.id == employee_id:
            deleted = employees.pop(index)
            return {"message": "Employee deleted", "employee": deleted}
    raise HTTPException(status_code=404, detail="Employee not found")
