A Linear Feedback Shift Register (LFSR) is a shift register whose input bit is a linear function—almost always an XOR (or XNOR)—of its previous state. Because it uses minimal combinational logic, an LFSR is the standard hardware structure for generating fast, deterministic pseudo-random bit sequences (PRBS), cyclic redundancy checks (CRC), and Built-In Self-Test (BIST) patterns.

  Core Components & TerminologySeed: The initial non-zero value loaded into the flip-flops on reset.
    With XOR feedback, an all-zeros state is a "lock-up" state because $0 \oplus 0 = 0$, meaning the register will stay stuck at zero forever. 
      (XNOR feedback locks up on all-ones instead).Taps: Specific flip-flop output bit positions selected to be XORed together and fed back into the input.
      Characteristic Polynomial: A mathematical representation of the tap positions. For example, a 4-bit LFSR with taps at bits 4 and 3 is represented as $x^4 + x^3 + 1$.
      Maximal-Length Sequence: If the tap positions correspond to a primitive polynomial, an $n$-bit LFSR cycles through all $2^n - 1$ possible non-zero states before repeating.
        
