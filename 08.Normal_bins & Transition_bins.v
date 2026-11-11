1.active_transfer has multi-value transition sequences (=>):  
  Whenever a covergroup uses transition bins across sequences like (0 => 1 => 2 => 3) or has option.per_instance = 1, QuestaSim refuses to combine them into a single type score.   
  It forces the simulator to display each instance separately as INST ... #2, INST ... #3, up to INST ... #9.  
  The top-level TYPE score turns grey because Questa cannot calculate a combined average for separate transition sequences without explicit merging rules.   

2.nc_active uses simple scalar bins (bins inf[] = {[0:7]}):   
    By default in SystemVerilog, option.per_instance is 0.When option.per_instance = 0, QuestaSim automatically merges all 9 instances together in the background under the single header TYPE dd_nc_active.
    The 9 separate instances still exist in memory, but Questa hides the individual instance rows and shows only one merged percentage.


    The Reality of Your Code
    dd_nc_active did create 9 instances in memory—Questa simply merged them into one line in the viewer.  
    active_transfer also created 9 instances in memory, but because it has complex transition bins, Questa could not merge them, so it displayed all 9 rows (#1 through #9) and greyed out the parent.  
    Variable a did not create anything; it only supplied the numbers. 

    
    
