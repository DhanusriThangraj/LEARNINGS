covergroup ldpc_parity_drive with function sample(...), if I rename sample to parity, do I also need to change how the covergroup is sampled?"
  No — sample Is a Fixed SystemVerilog Keyword
In SystemVerilog, with function sample(...) uses the reserved built-in method name sample. You cannot rename sample to parity in the covergroup header:

  // ILLEGAL SYNTAX (Compiler Error):
covergroup ldpc_parity_drive with function parity(bit [1103:0] parity_val); 

// LEGAL SYNTAX (Must always be named 'sample'):
covergroup ldpc_parity_drive with function sample(bit [1103:0] parity_val);

  Why It Works Without Renaming
Every covergroup has its own built-in .sample(...) method scoped to that specific covergroup instance. Even if you have 10 different covergroups in the same class, they all use with function sample(...) without conflicting with each other:

ldpc_chunk_drive.sample(tr.pf_dd_chunk_data[i]); — calls ldpc_chunk_drive's sample method.

ldpc_parity_drive.sample(tr.pf_dd_parity[i]); — calls ldpc_parity_drive's sample method.

Your outer wrapper function in the coverage class (function void sample_parity(pf_aux_transaction tr)) can keep whatever custom name you want, while the inner covergroup call must always be .sample(...).  
