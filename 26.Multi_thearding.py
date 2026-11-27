1. Multithreading (threading) – Running Multiple Tasks in One Program
Multithreading is a technique where a single Python program runs multiple smaller tasks (threads) concurrently—just like fork...join in SystemVerilog splits execution into parallel paths. All threads live inside the same process and share the exact same memory and variables.

Why Do We Use Multithreading?
Saves Waiting Time (I/O-Bound Tasks): When your script waits on slow external operations—such as reading/writing many log files, waiting for hardware/simulator responses, or sending network/API requests—one thread can keep working while another thread waits.

Keeps Programs Responsive: Background tasks (like monitoring a status flag or parsing logs) can run without freezing your main script.

How It Works (Basic threading Example)
Python
import threading
import time

def check_interface(name):
    print(f"Starting {name} check...")
    time.sleep(2)  # Simulates waiting for hardware/file I/O
    print(f"Finished {name} check!")

# 1. Create separate threads
t1 = threading.Thread(target=check_interface, args=("PCIe",))
t2 = threading.Thread(target=check_interface, args=("DDR",))

# 2. Start both threads at the same time (like fork)
t1.start()
t2.start()

# 3. Wait for both threads to finish (like join)
t1.join()
t2.join()

print("All checks completed!")
Output (takes ~2 seconds total instead of 4 seconds):

Plaintext
Starting PCIe check...
Starting DDR check...
Finished PCIe check!
Finished DDR check!
All checks completed!
2. ThreadPoolExecutor – Managing a Team of Reusable Worker Threads
ThreadPoolExecutor (from Python's built-in concurrent.futures module) is a modern, high-level manager that creates a fixed pool of reusable worker threads and automatically assigns your tasks to them.

Instead of manually creating, starting, and joining dozens of threading.Thread objects yourself, you give your tasks to the executor, and it handles scheduling, collecting return values, and cleaning up threads automatically.

Why Do We Use ThreadPoolExecutor?
Prevents Server Overload: If you have 500 simulation log files to parse, creating 500 raw threads at once can crash or slow down a shared Linux server. ThreadPoolExecutor(max_workers=4) limits execution to 4 threads at a time, queuing the rest safely.

Easy Return Values: Normal threading.Thread cannot easily return a value from a function (return result), whereas ThreadPoolExecutor makes collecting results from every thread effortless.

Automatic Cleanup (with statement): Just like with open(), using with ThreadPoolExecutor() as executor: automatically shuts down all worker threads when finished.

How It Works (Two Common Ways to Use It)
Method A: executor.map() (Best when running the same function on a list of items)
Python
from concurrent.futures import ThreadPoolExecutor
import time

def parse_log(log_file):
    time.sleep(1)  # Simulates reading a log file
    return f"{log_file}: PASS"

logs = ["pcie.log", "ddr.log", "nand.log", "misc.log"]

# Create a pool with 2 worker threads
with ThreadPoolExecutor(max_workers=2) as executor:
    results = executor.map(parse_log, logs)

for res in results:
    print(res)
Output (processes 2 logs at a time, taking ~2 seconds instead of 4):

Plaintext
pcie.log: PASS
ddr.log: PASS
nand.log: PASS
misc.log: PASS
Method B: executor.submit() (Best when running different functions or tracking individual tasks)
Python
from concurrent.futures import ThreadPoolExecutor

def task(name, seconds):
    return f"{name} done in {seconds}s"

with ThreadPoolExecutor(max_workers=2) as executor:
    # submit() returns a 'Future' object (a placeholder for the result)
    future1 = executor.submit(task, "PCIe", 2)
    future2 = executor.submit(task, "DDR", 1)

    # .result() waits for that specific task and grabs its return value
    print(future1.result())
    print(future2.result())
Related Topics
Python GIL (Global Interpreter Lock): Because of Python's GIL, threads take turns executing Python bytecode—so ThreadPoolExecutor is best for I/O-bound tasks (file reading/writing, network calls, subprocess/simulation commands), not heavy pure-math loops.

ProcessPoolExecutor (Multiprocessing): Looks almost identical to ThreadPoolExecutor, but spawns separate CPU processes instead of threads—used when you need true multi-core CPU speed for heavy math/data processing.

Future Object: The ticket/receipt returned by executor.submit(), letting you check .done(), .result(), or catch exceptions raised inside a worker thread.

threading.Lock(): Used when two threads try to write to the same shared variable or file at the exact same time, preventing corrupted data (race conditions).
