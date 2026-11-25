In Python, Modules and Packages are used to organize and reuse code. Let's understand them with simple examples.
1. What is a Module in Python?
A module is simply a Python file (.py) that contains Python code, such as functions, variables and classes.

For example, create a file called calculator.py.

calculator.py
def add(a, b):    return a + bdef sub(a, b):    return a - bx = 100



Here:
- add() and sub() are functions.
- x is a variable.
- calculator.py is a module.
We can reuse this module in another Python file.

main.py
import calculatorprint(calculator.add(10, 20))print(calculator.sub(20, 5))print(calculator.x)



Output:
30
15
100


Here, import calculator allows us to access the code inside calculator.py.
2. What is a Package in Python?
A package is a collection of related Python modules organized inside a directory (folder).

For example:
my_package/

calculator.py
Module

mathematics.py
Module

init.py

Package initialization file



Here:
- my_package is a package.
- calculator.py is a module.
- mathematics.py is another module.
- __init__.py is traditionally used to identify and initialize a regular Python package. Modern Python also supports namespace packages without it.
How to import a module from a package?
from my_package import calculatorprint(calculator.add(10, 20))



3. Difference between Module and Package
Module	Package
A Python file	A directory containing modules
Contains functions, variables, classes	Organizes related modules
Example: math.py	Example: numpy
Used to organize code	Used to organize multiple modules

4. What are built-in modules?
Python already provides several modules.

Examples:
Module	Purpose
math	Mathematical operations
random	Generate random values
os	Operating system operations
datetime	Date and time
sys	Python interpreter information

Example:
import mathprint(math.sqrt(25))print(math.factorial(5))



Output:
5.0
120


5. What are third-party packages?
These are packages developed by external developers and installed separately using pip.

Examples:










NumPy

Numerical calculations and arrays













Pandas

Data analysis and data manipulation













Matplotlib

Data visualization and graphs


Install using:
pip install numpy
pip install pandas
pip install matplotlib



6. Test your understanding
1. What is a module in Python?

A Python file

A collection of folders

An operating system

Correct! A module is a Python file containing reusable code.


2. What is a package?

A single variable

A collection of related modules

A Python operator

Correct! A package organizes related modules in a directory.


3. Which command installs a third-party package?

import numpy

pip install numpy

python numpy

Incorrect. pip install numpy installs NumPy.

Check answersYour score: 2/3

One important thing to remember:
- Module = One Python file.
- Package = Collection of related modules.
- Library = A broader collection of reusable code, often made up of modules and packages.
