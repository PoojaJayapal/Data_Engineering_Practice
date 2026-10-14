class Product:
    def __init__(self):
        print("Product Constructor")
p1=Product()
#2 Parametrized Constructor 
class Employee:
    def __init__(self,name,salary):
        self.name=name
        self.salary=salary
    def display(self):
        print("Employee Name:",self.name)
        print("Salary:",self.salary)
e=Employee("Pooja",45000)
e.display()


