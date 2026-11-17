In RTL verification, functional verification coverage and code coverage are two different ways of measuring how thoroughly your RTL design has been verified.

The most important distinction is:

Code coverage: Measures how much of your RTL code has been exercised during simulation.

Functional coverage: Measures how much of the intended functionality and design scenarios have been verified during simulation.

Achieving 100% code coverage does not necessarily mean that your design is functionally verified.

Let's look at both in the context of an FPGA/ASIC RTL design.

1. Code coverage
Code coverage is generally calculated automatically by the simulation tool (for example, QuestaSim, VCS, or Xcelium).

The simulator observes which portions of your RTL code are executed during simulation.

Common types of code coverage include:

Coverage type

What it measures

Line coverage

Whether each executable RTL line was executed

Statement coverage

Whether each statement was executed

Branch coverage

Whether both outcomes of an if/else or conditional branch were exercised

Toggle coverage

Whether signals have transitioned from 0 to 1 and 1 to 0

FSM coverage

Whether all FSM states and transitions were exercised

Expression coverage

Whether relevant Boolean expression outcomes were exercised


  Example:

Consider this RTL:


systemverilog
always_comb begin
    if (enable)
        data_out = data_in;
    else
        data_out = 0;
end
Suppose your testbench only tests enable = 1.

The simulator reports:

The if branch was exercised.

The else branch was not exercised.

Branch coverage is 50%.

If you subsequently test enable = 0, branch coverage becomes 100%.

Notice that the simulator does not need to understand what the circuit is supposed to do. It simply observes which code paths have been executed.

2. Functional verification coverage
Functional coverage is different. Here, the verification engineer defines what functionality needs to be tested and what scenarios must be covered.

The simulator does not automatically know the complete functional requirements of your design. The verification engineer must explicitly define the coverage requirements.



  For example, consider designing an asynchronous FIFO.

You might want to verify the following scenarios:

FIFO is completely empty.

FIFO receives one data word.

FIFO reaches half-full condition.

FIFO reaches completely full condition.

Read and write operations happen simultaneously.

Read is attempted when FIFO is empty.

Write is attempted when FIFO is full.

FIFO performs a complete write/read cycle.

These are functional scenarios, not RTL code statements.

You can execute every line of the FIFO RTL and still fail to test some of these scenarios.

How does the simulator calculate functional coverage?
SystemVerilog provides a feature called covergroups.

The verification engineer writes SystemVerilog coverage code that describes the conditions and combinations that need to be tested.

For example:


systemverilog
covergroup fifo_coverage @(posedge clk);

    // FIFO occupancy coverage
    coverpoint fifo_count {
        bins empty = {0};
        bins low = {[1:3]};
        bins medium = {[4:6]};
        bins high = {[7:9]};
        bins full = {10};
    }

    // Read and write operation coverage
    coverpoint {wr_en, rd_en} {
        bins idle = {2'b00};
        bins write_only = {2'b10};
        bins read_only = {2'b01};
        bins simultaneous = {2'b11};
    }

    // FIFO status coverage
    coverpoint {full, empty} {
        bins normal = {2'b00};
        bins full_state = {2'b10};
        bins empty_state = {2'b01};
    }

endgroup
You instantiate the coverage group in your testbench:


systemverilog
fifo_coverage fifo_cov = new();
At each rising clock edge, the simulator samples the specified signals and updates the coverage statistics.

For example, suppose the FIFO occupancy takes these values during simulation:


text
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
All five occupancy bins have been hit.

Therefore:

C
o
v
e
r
a
g
e
=
B
i
n
s
 
H
i
t
T
o
t
a
l
 
B
i
n
s
×
100
Coverage= 
Total Bins
Bins Hit
​
 ×100
C
o
v
e
r
a
g
e
=
5
5
×
100
=
100
%
Coverage= 
5
5
​
 ×100=100%
This is how functional coverage is calculated at its simplest level.

Cross coverage: An important feature
Functional coverage becomes much more powerful when you consider combinations of conditions.

For example, in a FIFO, you might want to verify:

Read operation when FIFO is almost empty.

Read operation when FIFO is almost full.

Write operation when FIFO is almost empty.

Write operation when FIFO is almost full.

You can define cross coverage:


systemverilog
covergroup fifo_coverage @(posedge clk);

    cp_count: coverpoint fifo_count {
        bins empty = {0};
        bins low = {[1:3]};
        bins medium = {[4:6]};
        bins high = {[7:9]};
        bins full = {10};
    }

    cp_operation: coverpoint {wr_en, rd_en} {
        bins idle = {2'b00};
        bins write = {2'b10};
        bins read = {2'b01};
        bins simultaneous = {2'b11};
    }

    cross cp_count, cp_operation;

endgroup
Now the simulator tracks combinations of FIFO occupancy and operations.

For example, it can determine whether a read operation was performed when the FIFO was almost full.

This is particularly useful because many RTL bugs occur only under particular combinations of operating conditions.

3. Key differences between code coverage and functional coverage
Consider the following example:

You have designed an AXI4-Lite slave interface.

Verification scenario

Code coverage

Functional coverage

Read transaction

Checks whether read-related RTL executed

Checks whether read transaction completed correctly

Write transaction

Checks whether write-related RTL executed

Checks whether write transaction completed correctly

Read and write simultaneously

Checks whether relevant RTL branches executed

Checks whether simultaneous operation was tested

Invalid address

Checks whether error-handling code executed

Checks whether invalid-address scenarios were tested

Back-to-back transactions

Checks whether relevant logic executed

Checks whether consecutive transactions were exercised

Reset during transaction

Checks whether reset logic executed

Checks whether reset recovery was verified

The key point is that code coverage is based on RTL execution, whereas functional coverage is based on verification requirements.

4. How are coverage percentages calculated?
Let's assume you have the following coverage results:

Example verification report

Code coverage

95%
Functional coverage

72%
Interpretation

95% code coverage means most RTL statements, branches, toggles, etc. have been exercised.

72% functional coverage means some of the planned functional scenarios have not yet been tested.

This is a very realistic situation. Your RTL may be executing correctly in many different ways, but certain corner cases might still be missing.

Also, coverage percentages are generally reported separately for different coverage types. They should not simply be averaged into one number without a defined methodology.

5. Who calculates functional coverage?
This is an important distinction.

Activity

Responsibility

Code coverage calculation

Simulator automatically

Functional coverage definition

Verification engineer

Functional coverage sampling

Simulator, based on coverage code

Functional coverage calculation

Simulator

Coverage gap analysis

Verification engineer

Verification completeness assessment

Verification engineer

The simulator calculates functional coverage, but the verification engineer must define what constitutes complete functional verification.

For example, if you forget to define a coverage point for FIFO overflow, your functional coverage might report 100% even though FIFO overflow was never tested.

100% functional coverage does not automatically guarantee a bug-free design.

You also need assertions, scoreboards, reference models and other checking mechanisms to establish that the RTL behaves correctly.

6. My recommendation for an RTL verification methodology
For a reasonably complex FPGA or ASIC block, I would recommend tracking three independent things:

Code coverage: Are all the important parts of the RTL exercised?

Functional coverage: Have all the required operating scenarios been tested?

Assertions/protocol checking: Does the RTL actually behave according to the specification?

Overall RTL verification strategy

Functional specification

Define features, scenarios and corner cases

Testbench + stimulus generation

Generate directed and random tests

RTL simulation

DUT execution and response checking

Code coverage

RTL execution

Functional coverage

Scenario completion

Assertions

Correctness checks

Coverage closure and verification sign-off

One additional recommendation: If you are developing a reusable IP block, define a functional coverage plan directly from the IP specification before writing the testbench. This makes it much easier to identify missing test scenarios.
                                                                            

                                                                            
  
