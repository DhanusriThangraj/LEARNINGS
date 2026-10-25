Port-Disambiguation (or simply Port-Renamer).
Port disambiguation means resolving ambiguity when multiple interfaces, signals, or network connections share identical or similar identifiers, ensuring traffic or data reaches the exact intended port without collision or confusion.

1. What is it?
`uvm_analysis_imp_decl is a pre-defined UVM macro used to create custom analysis implementation (analysis_imp) port types with unique suffix names.

2. Meaning & The Problem It Solves
In standard UVM, every uvm_analysis_imp expects a function named exactly:

Code snippet
function void write(T t);
If a component (like a Scoreboard) receives data from only one Monitor, having a single write() function works fine:
  
[Monitor] ---> (write) ---> [Scoreboard: write()]
The Problem:
What if your Scoreboard needs to receive transactions from two or more monitors (for example, an AXI Master Monitor and an AXI Slave Monitor)?

If you create two standard uvm_analysis_imp ports inside the same Scoreboard:

Both ports will look for a function named write().

SystemVerilog does not allow two functions with the exact same name in the same class.

The compiler throws a name collision error.

  3. Purpose & When to Use It
Purpose: It generates a new implementation port class that calls write_<suffix>() instead of the generic write().

When to use it: Whenever a single UVM component (usually a Scoreboard or Coverage Collector) needs multiple analysis implementation ports to receive data from different sources.

4. How to Use It (Step-by-Step)
Step 1: Declare the macro outside the class
Declare the macro with your custom suffixes before defining your class (or at the package level).

  // Creates a port that calls write_m_axi()
`uvm_analysis_imp_decl(_m_axi)

// Creates a port that calls write_s_axi()
`uvm_analysis_imp_decl(_s_axi)

  Rule: The macro automatically creates a new class name by appending your suffix:
uvm_analysis_imp + _suffix => uvm_analysis_imp_suffix
    Step 2: Instantiate the custom implementation ports in your Scoreboard

    class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  // Use the newly declared types: uvm_analysis_imp_<suffix>
  uvm_analysis_imp_m_axi #(axi_seq_item, my_scoreboard) m_axi_export;
  uvm_analysis_imp_s_axi #(axi_seq_item, my_scoreboard) s_axi_export;

  function new(string name = "my_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    m_axi_export = new("m_axi_export", this);
    s_axi_export = new("s_axi_export", this);
  endfunction

  // Step 3: Implement the two separate write functions!
  virtual function void write_m_axi(axi_seq_item item);
    `uvm_info(get_type_name(), "Received packet from Master Monitor", UVM_LOW)
    // Push into master queue or check logic
  endfunction

  virtual function void write_s_axi(axi_seq_item item);
    `uvm_info(get_type_name(), "Received packet from Slave Monitor", UVM_LOW)
    // Push into slave queue or compare
  endfunction

endclass

    Step 4: Connect the ports in the Environment (connect_phase)
    class my_env extends uvm_env;
  `uvm_component_utils(my_env)

  master_agent m_agt;
  slave_agent  s_agt;
  my_scoreboard scb;

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Master monitor connects to the master export (triggers write_m_axi)
    m_agt.mon.ap.connect(scb.m_axi_export);

    // Slave monitor connects to the slave export (triggers write_s_axi)
    s_agt.mon.ap.connect(scb.s_axi_export);
  endfunction
endclass
Quick Summary
          Feature                      Standard uvm_analysis_imp                  With `uvm_analysis_imp_decl(_xyz)
          Class name                  uvm_analysis_imp #(T, IMP)                 uvm_analysis_imp_xyz #(T, IMP)
          Function called               write(T t)                                      write_xyz(T t)
          Best used for               Single input stream                         Multiple input streams in one component
    

    
