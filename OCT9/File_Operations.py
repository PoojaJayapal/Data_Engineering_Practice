file = open("employees.txt", "w")

file.write("101,Aman,IT,75000\n")
file.write("102,Meera,HR,65000\n")
file.write("103,Rohan,Finance,70000\n")
file.close()
file = open("employees.txt", "r")

data=file.read()
print(data)
file.close()
file=open("employees.txt","r")
for line in file:
    print(line.strip())
file.close()
file=open("employees.txt","a")
file.write("104,sara,sales,60000\n")
file.close()
