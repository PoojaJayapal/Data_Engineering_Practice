#PUBLIC
class Animal:
    name=""
    def display(self):
        print(f"Animal Name: {self.name}")
a=Animal()
a.name="Dog"
a.display()

#PROTECTED
class Student:
    _name="IT"
s=Student()
print(s._name)
