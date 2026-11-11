# RecomPyler

RecomPyler profiles ordinary Python scripts, tests CPU compilation on supported hot functions, and reports measured speedups alongside output checks. It includes a CPU and GPU benchmark for independent particle simulations.

## Try it

From the repository root, install the CLI in your Python environment:

```bash
python -m pip install ".[compile]"
recompyler profile examples/workload.py
recompyler benchmark
```

`python -m pip install .` installs the profiler without compiler dependencies. The benchmark requires the `compile` extra. CUDA measurements require a compatible NVIDIA driver and CUDA toolkit. If CUDA is unavailable, the benchmark prints a CPU comparison. Use `--cpu-only` to select that explicitly.

### Profile an existing script

```bash
recompyler profile --json profile.json path/to/script.py -- --input data.csv
recompyler profile --no-compile path/to/script.py
```

For coding agents and other tools, request the one-line JSON report:

```bash
recompyler profile --format compact --limit 5 --json profile.json path/to/script.py
```

The report uses schema `recompyler.profile.v1`. Each hotspot includes its source line, call count, self time, and candidate status. Verified candidates include their sample count, fallback count, warm speed ratios, and first-pass cost. The compact report contains no captured argument values. Use `--json` to read the report separately from anything the script prints.

RecomPyler runs the script once as `__main__` from your current working directory. Use it on scripts you trust to run. The profile goes to stderr, leaving stdout for the script. Put profiler options before the script path. Arguments after the path are passed to the script.

The report ranks functions defined in the script by time spent inside each function. It keeps a uniform random sample of each function's calls during the run, then compiles eligible functions with Numba and replays the sample. A verified candidate reproduced every sampled result exactly: the same types, and bit-identical floats. The report gives a speed ratio for calling the compiled function one call at a time, and one for running a batch of calls as a single compiled loop on each backend: one CPU thread, all CPU cores, and the GPU when CUDA is available. The batch is sized to the number of calls the script made, up to 65,536, and its timings include packing the arguments and GPU transfers. The CLI reports candidates for review and keeps the original script intact.

Eligible functions are top-level functions and methods that work on numbers, tuples, lists, `array.array` values and instances of plain Python classes, with loops (including `while True` and loop `else`), branches, slices, `append`/`insert`/`pop`, default arguments, other eligible helper functions, numeric module constants and the `math` functions listed in `lift.py`. Functions may return None and change list or `array.array` arguments in place: those arguments are passed as copies and written back after a successful compiled call, and the profiler checks the arguments each captured call left behind as well as its result. A `raise` hands the call to Python. An object of a class defined in Python travels as a record of its attributes: methods, `__getitem__`/`__setitem__` and arithmetic operators are compiled for its class, `C(...)` is compiled when `__init__` only sets attributes from its arguments, and attributes the code assigns are written back to the object. Recursion, `None` values, strings, dicts, I/O, NumPy arrays, identity comparisons and writes to global state are skipped, and the report says which construct ruled a function out.

A function counts as verified only when at least 90% of its captured calls ran compiled. Functions that change their arguments are timed one call at a time and not batched. Transcendental `math` functions are used only after a self-test shows the compiled results match Python bit for bit on the current machine, and never on the GPU.

Each verified function also gets a recommendation. It is recommended only if one compiled call is at least 5% faster than Python, and the time it saves over the calls the script made exceeds its start-up cost once the compiled code is cached. Batch speedups do not count, because they need the caller rewritten. The report then says whether running the script with `recompyler run` pays off overall: the recommended functions must together save more than a new process spends loading the compiler, which is measured once on this machine (about 0.7 s here: mostly importing NumPy and Numba). While Numba starts, RecomPyler stops it importing SciPy, which it loads only to check for BLAS; that saves about 0.3 s and leaves `np.dot` in a script's own Numba code working.

### Run a script with the recommended functions

```bash
recompyler profile --json plan.json path/to/script.py
recompyler run --plan plan.json path/to/script.py
```

`run` executes the script as `__main__` with each recommended function replaced by its guarded compiled version; the file on disk is not changed. A call the compiled version cannot answer exactly is handed to the original function, as everywhere else. If the plan found that loading the compiler costs more than it saves, the script runs in plain Python; `--force` uses the recommended functions anyway. Afterwards `run` prints how many calls each function answered compiled.

When the profile recommends functions and a C compiler is available (MSVC on Windows), the profiler also compiles them ahead of time with `numba.pycc` into an extension module in the cache directory, for the argument types it verified. `recompyler run` then calls that module and never imports Numba, so start-up is about 0.17 s instead of 0.7 s; the nbody example runs in about 0.4 s instead of 1.9 s in plain Python. At run time the function's code is regenerated from the current source, without compiling, and the module is used only if that code and its constants hash to what was built; otherwise the function is compiled with Numba as before. Functions on objects of Python classes, and argument types the profile did not see, also use Numba. Numba has deprecated `numba.pycc`, so RecomPyler carries its own copy in `recompyler/_pycc` (from Numba 0.65.1, BSD licence in `LICENSE.numba`); it still uses Numba's compiler and runtime, which are not deprecated, and a test builds a module with `numba.pycc` blocked.

Compiled code is kept on disk, in `%LOCALAPPDATA%\recompyler\cache` on Windows and `~/.cache/recompyler` elsewhere. Set `RECOMPYLER_CACHE` to another directory, or to `off`. A later run loads the machine code instead of compiling: fannkuch's start-up goes from about 3.9 s to 0.03 s. Each generated module is named after a hash of its source, its constants, the lifter and the Numba, NumPy and Python versions, so a changed value never loads stale code. Functions on objects of Python classes are compiled in every run.

Compiled code uses 64-bit integers, where Python's are unbounded. Wherever the two could disagree (integer overflow, shifts, `int()` of a large float, values of mixed type), the compiled version either checks at run time and hands the call back to the original function, or is not offered.

### Apply a verified optimization in Python

```python
from recompyler import optimize

samples = [(1.0, 0.5, 0.01), (2.0, 0.0, 0.02)]
fast = optimize(advance_particle, samples=samples)
print(fast.report)
print(fast(*samples[0]))
print(fast.map(samples))
```

Run `python examples/optimize_workload.py` for a complete example. `optimize` tests the CPU version against Python, then times the actual guarded call and batch paths. Each path activates independently when the warm measurement shows more than a 5% speedup. `report` includes the measured ratio and verification cost when available.

The first public API accepts pure functions with scalar numeric results and samples made of positional numbers or tuples. Only exact inputs from `samples` use the compiled path. New inputs and keyword calls run in Python. `.map()` uses the compiled path for a list or tuple matching the verified batch in size, order, and values. Other batches run as a regular Python loop. The reported timings include the runtime guards, with startup cost reported separately.

### Work directly with the experimental compiler

```python
from recompyler.lift import lift

fast = lift(advance_particle)
fast(1.0, 0.5, 0.01)                      # one call
fast.map([(1.0, 0.5, 0.01), (2.0, 0.0, 0.02)])  # many calls in one compiled loop
```

`lift` raises `recompyler.lift.Unsupported` with the reason if the function is outside the eligible subset.

`map` takes a backend, and every backend returns the same values as the Python loop:

```python
fast.map(calls, "parallel")   # all CPU cores
fast.map(calls, "gpu")        # CUDA
fast.map(calls, "auto")       # time each backend on the first batch of a size, then use the fastest
fast.map(rows_array, "gpu")   # 2-D float64, int64 or bool array in, array out
```

Passing a NumPy array with one row per call skips unpacking Python objects, which otherwise dominates large batches. On a Ryzen 7 9800X3D and RTX 5080, one million 128-step particle rows passed as an array took 665 ms on one CPU thread, 77 ms on all cores and 15.5 ms on the GPU including transfers. The same rows as a list of tuples took 318 ms on the GPU.

The GPU compiles with fused multiply-add turned off, so its floats match the CPU bit for bit. The first GPU batch of each input shape is also run on the CPU, and the GPU is used only if the two agree. Functions that build lists or use float `//` or `%` stay on the CPU, and `fast.gpu_note` says why. If CUDA is unavailable, `"gpu"` runs on the CPU.

Profiling uses `sys.monitoring` (Python 3.12+) and covers every thread. Only functions in the script, and in any file or folder given with `--include`, are timed. Library code runs unmonitored apart from the boundary calls into it, and each function's time in the libraries it calls directly is reported separately as `library_s`. The profiler's own time is taken out of the reported times. The per-call path is a small C extension (`recompyler._monitor`), built when a C compiler is available. Without it, the same logic runs as Python callbacks: these are slower, and on call-heavy scripts their correction for the profiler's own time is less accurate. Use `--no-compile` for a timing-only ranking without the overhead of recording calls.

### Compare CPU and GPU

```bash
recompyler benchmark --sizes 32 512 4096 32768 --json benchmark.json
```

Each input is a particle with an initial position, velocity, and time step. Every backend integrates the same 128-step trajectories using the same inputs. The report compares Python, compiled single-threaded CPU, compiled multithreaded CPU, and CUDA with either resident inputs or a host-to-device and device-to-host round trip. It records first-call overhead separately from the median warm times and checks every backend against the Python results.

On a Ryzen 7 9800X3D and RTX 5080, the fastest compiled CPU path took 0.023 ms at 32 particles versus 0.383 ms for the CUDA round trip. At 32,768 particles, the fastest CPU path took 6.63 ms and the CUDA round trip took 0.72 ms. These are warm medians on one machine, measured with reusable buffers and shared constants resident on the GPU. [Full example results](benchmarks/rtx5080.json)

## Development

```bash
python -m unittest discover -s tests -v
```
