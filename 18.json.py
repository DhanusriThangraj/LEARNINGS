JSON stands for JavaScript Object Notation.

It is a lightweight data format used to store and exchange data between applications.

In simple words, JSON is a way to represent data in a structured format.
1. JSON example
{
    "name": "Dhanusri",
    "age": 23,
    "department": "ECE",
    "skills": ["Python", "Verilog", "SystemVerilog"]
}


Here:
- "name" → Key
- "Dhanusri" → Value
- "age" → Key
- 23 → Value
- "skills" → Key
- ["Python", "Verilog", "SystemVerilog"] → List of values.
2. JSON data types
JSON supports six types of values:
Data type	Example
String	"Python"
Number	25
Boolean	true
Array	[10, 20, 30]
Object	{"name": "Ram"}
Null	null

3. How to use JSON in Python?
Python provides a built-in module called json.

Example: Python dictionary to JSON
import jsonstudent = {    "name": "Dhanusri",    "age": 23,    "department": "ECE"}data = json.dumps(student)print(data)



Output:
{"name": "Dhanusri", "age": 23, "department": "ECE"}


Here, json.dumps() converts a Python dictionary into a JSON string.
4. Important JSON functions
Function	Purpose
json.dumps()	Python object → JSON string
json.loads()	JSON string → Python object
json.dump()	Write JSON data into a file
json.load()	Read JSON data from a file

5. Where do we use JSON?
- API communication
- Web development
- Configuration files
- Data exchange between Python and other programming languages
- Storing application settings
Remember: JSON is a data format, not a programming language.

Since you're learning Python, next you can learn how to work with JSON files (.json) using Python's json module.
