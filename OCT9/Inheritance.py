#type 1
class Employee:
    def __init__(self,name,salary):
        self.name=name
        self.salary=salary
    def display(self):
        print("Name:",self.name)
        print("Salary:",self.salary)
class  Developer(Employee):
    pass
d1=Developer("Pooja",45000)
d1.display()
#type 2
class Employee:
    def __init__(self,name,salary):
        self.name=name
        self.salary=salary
    def display(self):
        print(f"Employee Name: {self.name}, Salary: {self.salary}")
class Developer(Employee):
    def devmethod(self):
        print(f"Developer name: {self.name}, Salary: {self.salary}")
d=Developer("Pooja",45000)
d.display()
d.devmethod()

#type 3 
class Student:
    def __init__(self,name,id):
        self.name=name
        self.id=id
    def teacher(self,Tname):
        self.Tname=Tname
    def principal(self,pname):
        self.pname=pname
    def display(self):
        print(f"Student Name: {self.name}, Student ID: {self.id}")
        print(f"Teacher Name:{self.Tname}")
        print(f"Principal Name:{self.pname}")

class Teacher(Student):
    pass
class Principal(Student):
    def view(self):
        print(f"Displaying teacher name: {self.Tname}")
p=Principal("Mithra",3)
p.teacher("Pooja")
p.principal("Deepa")
p.display()
p.view()



