  +---------+      +-----------+      +----------------------+      +----------+
  |  Clean  | ---> |  Compile  | ---> | Elaborate & Optimize | ---> | Simulate |
  +---------+      +-----------+      +----------------------+      +----------+
  (Reset env)      (Parse/Syntax)     (Link hierarchy & WLF)        (Execute)

1. Compile
What is it?
Checking and translating individual code files into binary format.

Meaning:
The tool acts like a grammar checker and dictionary translator. It opens each file, verifies that your syntax is correct (no missing semicolons, valid types, proper keywords), and stores the result in a working directory (like work).

Why we use it:
Computers cannot understand human-readable SystemVerilog text directly. They need intermediate machine data.

Purpose:

Catch syntax mistakes early before building the full system.

Convert every module, class, interface, and package into a format the simulator understands.

Simple analogy:
Translating individual chapters of a book from a handwritten draft into printed pages.


2. Elaborate / Optimize
What is it?
Connecting the design hierarchy together into a single, executable snapshot.

Meaning:

Elaboration links everything together. It wires the testbench interface to the DUT, resolves parameters (such as bus widths like DATA_WIDTH=32), and expands module instances.

Optimization compiles that linked design into fast native machine code for your CPU, while keeping the signals you want to see visible in the waveform viewer.

Why we use it:
Compiling files separately does not create a working chip. You need a step that connects master pins to slave pins, calculates memory sizes, and builds the complete circuit in memory.

Purpose:

Resolve hierarchical paths (e.g., top.dut.axi_master.awvalid).

Apply parameter overrides (e.g., defparam or #(.WIDTH(64))).

Enable debug visibility flags (like +acc in Questa) so you can view waveforms.

Create a single executable snapshot (e.g., top_opt) that the simulator can run at high speed.

Simple analogy:
Assembling all the printed chapters into a single bound book with a clickable table of contents and page numbers.


3. Run / Simulate
  What is it?
Executing the compiled design over time ($t = 0\text{ ns}, 10\text{ ns}, \dots$).
  Meaning:
Starting the simulation engine. Clocks begin toggling, reset is applied, packets are generated, and data moves through the bus.
  Why we use it:
To see if the design behaves correctly according to the specification before manufacturing physical silicon.

  Purpose:

Run test sequences and drive stimuli through the DUT.

Check for protocol violations, functional bugs, and race conditions.

Generate simulation logs (sim.log) and waveform databases (.wlf, .fsdb, .vcd) for debugging.

Collect functional and code coverage to see what features were tested.

Simple analogy:
Turning the key to start the car engine and driving it on a test track to make sure the brakes and steering work.

Stage	                What does it do?	                Main question it answers	                   Key outputs
Compile	                Checks syntax & parses code	        "Is the code grammatically correct?"	           Binary units in work/
Elaborate / Optimize	Connects hierarchy & sets parameters	"Do all components plug together properly?"	   Runnable snapshot (e.g., top_opt)
Simulate	        Runs the design through time	        "Does the design work as intended?"	           Logs (sim.log), Waveforms (.wlf)


  
# Step 1: Default target chains dependencies in strict order
all: clean compile opt run

clean:
	rm -rf work transcript *.log *.wlf *.ucdb

compile:
	vlog -sv -f filelist.f

opt:
	vopt top_tb -o top_opt +acc

run:
	vsim -c top_opt -do "run -all; quit -f" +UVM_TESTNAME=axi_basic_test -l sim.log

    















  

  
  
