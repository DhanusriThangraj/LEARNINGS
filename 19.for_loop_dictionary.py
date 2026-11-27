for dut in duts.values(): means iterate through all the values stored in the dictionary duts, one by one.

Let's understand it step by step.
1. Example dictionary
duts = {    "dut1": "AXI",    "dut2": "APB",    "dut3": "UART"}



Here:
- duts → Dictionary name.
- "dut1", "dut2", "dut3" → Keys.
- "AXI", "APB", "UART" → Values.
2. Using duts.values()
for dut in duts.values():    print(dut)



Output:
AXI
APB
UART


How does the iteration work?
Iteration	dut value
1	AXI
2	APB
3	UART

3. Difference between keys(), values() and items()
duts.keys()    # Returns all keysduts.values()  # Returns all valuesduts.items()   # Returns key-value pairs



Example:
for dut in duts.keys():    print(dut)



Output: dut1, dut2, dut3
for dut in duts.values():    print(dut)



Output: AXI, APB, UART
for key, value in duts.items():    print(key, value)



Output:
dut1 AXI
dut2 APB
dut3 UART


4. Connection with SystemVerilog
Think of a Python dictionary like an associative array in SystemVerilog.

For example:
int duts[string];

duts["dut1"] = 10;
duts["dut2"] = 20;


Python dictionary:
duts = {    "dut1": 10,    "dut2": 20}



Remember:
- duts.keys() → Get keys.
- duts.values() → Get values.
- duts.items() → Get both keys and values.
This is particularly useful when iterating through multiple DUT instances in a Python-based verification environment.
