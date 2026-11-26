1. What is __future__?
The __future__ module allows you to enable features from newer Python versions in older versions (where supported).
2. Example
from __future__ import annotations



Here:
- from – Python keyword.
- import – Python keyword.
- __future__ – Module name.
- annotations – Feature provided by that module.
3. How to check whether it is a keyword?
import keywordprint(keyword.iskeyword("__future__"))



Output:
False



4. Difference
Term	Meaning
Keyword	Reserved word in Python
Module	A Python file containing code
Package	A collection of related modules
__future__	Special built-in module

Remember: __future__ is a module, not a keyword. It is used to enable certain language features.

















annotions means'












I think you mean annotations (not annotions).

In Python, annotations means adding information about the expected data types of variables, function parameters, and return values.
1. Example without annotations
def add(a, b):    return a + bprint(add(10, 20))



Python doesn't explicitly tell us what data types a and b should have.
2. Example with annotations
def add(a: int, b: int) -> int:    return a + bprint(add(10, 20))



Explanation:
- a: int → a is expected to be an integer.
- b: int → b is expected to be an integer.
- -> int → The function is expected to return an integer.
Output:
30


3. Important point
Python does not enforce these type annotations automatically.

For example:
def add(a: int, b: int) -> int:    return a + bprint(add("Hello", "World"))



Output:
HelloWorld


It still executes because Python is dynamically typed.
4. Connection with __future__
from __future__ import annotations



This makes Python store annotations in a postponed form rather than evaluating them immediately.

In simple words: Annotations provide type information to developers and tools, but they don't automatically restrict the values passed to a function.
