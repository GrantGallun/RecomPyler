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

RecomPyler runs the script once as `__main__` from your current working directory. Use it on scripts you trust to run. The profile goes to stderr, leaving stdout for the script. Put profiler options before the script path. Arguments after the path are passed to the script.

The report ranks functions defined in the script by time spent inside each function. It records numeric inputs and outputs during the run, then tests isolated copies of eligible helpers with Numba. The first version supports top-level scalar numeric functions with local arithmetic, branches, and `range` loops. It skips methods, external calls, and global state. It checks exact types and integer results, with a relative and absolute tolerance of `1e-12` for floats. A verified candidate matched the captured calls. The CLI reports candidates for review and keeps the original script intact.

Profiling covers the script's main thread. Use `--no-compile` for a timing-only ranking without the overhead of recording calls.

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
