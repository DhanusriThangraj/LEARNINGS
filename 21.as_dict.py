as_dict usually means "convert something into a dictionary" or "represent something as a dictionary."

It is not a Python keyword or built-in method. It is a name chosen by the developer.
1. Example
class Student:    def __init__(self, name, age):        self.name = name        self.age = age    def as_dict(self):        return {            "name": self.name,            "age": self.age        }s1 = Student("Dhanusri", 23)print(s1.as_dict())



Output:
{'name': 'Dhanusri', 'age': 23} 



2. How does it work?
1. s1 is an object of the Student class.
2. self.name contains "Dhanusri".
3. self.age contains 23.
4. as_dict() collects these values into a dictionary.
5. return sends that dictionary back.
3. Difference between as_dict and dict
Expression	Meaning
as_dict()	Usually a user-defined method to return an object as a dictionary
dict()	Python's built-in function to create a dictionary

Remember: Whenever you see as_dict() in Python code, check its implementation. Usually, it converts an object's attributes or data into a dictionary.
