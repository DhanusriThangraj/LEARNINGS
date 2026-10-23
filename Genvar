In the SystemVerilog IEEE standard (IEEE 1800), genvar is classified as a structural keyword / elaboration declaration identifier, not a variable data type like logic, bit, int, or reg.

Why It Is Not a Standard Data Type
You Cannot Combine It with Other Types:
With real data types, you can declare arrays, signed/unsigned attributes, or packed vectors. With genvar, none of that is allowed:

Code snippet
genvar [7:0] g;       // SYNTAX ERROR: Cannot give it a vector width
unsigned genvar g;    // SYNTAX ERROR: Cannot use signed/unsigned qualifiers
genvar g_arr[4];      // SYNTAX ERROR: Cannot create an array of genvars
It Does Not Allocate Memory:
A standard data type (like int or logic) allocates actual storage in hardware gates/registers or simulation heap memory. A genvar allocates zero storage; it only exists as a compiler internal evaluation counter during elaboration.

It Cannot Be Used Inside Procedural Blocks:
Standard data types can be used anywhere (inside tasks, functions, initial, or always blocks). A genvar can only be used inside generate loop headers:

Code snippet
initial begin
  genvar g; // SYNTAX ERROR: genvar is illegal inside procedural blocks
end
It Cannot Be Passed via Ports or Arguments:
You cannot have a module port, function input, or class property typed as a genvar:

Code snippet
module sub (input genvar g); // SYNTAX ERROR
function void my_func(genvar g); // SYNTAX ERROR
How to Think of genvar
Think of genvar as a compile-time macro counter or a blueprint replicator stamp:

Its underlying arithmetic behaves like an integer (32-bit signed math).

But its role is solely to guide the compiler on how many times to replicate structural hardware during elaboration.
