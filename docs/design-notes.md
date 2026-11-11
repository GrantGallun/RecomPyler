# RecomPyler design notes

Reference for design decisions and open questions. Read when planning work, not for every task. Measured numbers come from the Ryzen 7 9800X3D / RTX 5080 machine unless stated.

## 1. Positioning

- **What it is:** an accelerator that runs inside CPython. It profiles real runs, compiles hot code, verifies the results, and falls back to CPython for everything else. It is not a new interpreter.
- **Why not a new interpreter:** PyPy is fast but isn't widely used because of the C API (C extensions are slow or broken), lagging Python versions, warm-up time, missing wheels, and switching being all-or-nothing. Staying inside CPython avoids all of these.
- **Why other in-CPython projects died:** Pyjion and Pyston-lite gained only 10–30%, which wasn't worth installing. RecomPyler's edge is data-layout lowering (lists, tuples and classes to arrays and records), which gives 10x+ (nbody 17–28x).
- **The LLM angle:** LLMs write Python 90–97% of the time when no language is specified ("LLMs Love Python", arXiv 2503.17181) and score lower in other languages (MultiPL-E, Multi-SWE-bench). Pitch: *the Python LLMs already write, made fast with no changes.* Never fork the syntax: Mojo shows models struggle with a language that looks like Python but isn't.
- **Gap nobody fills:** compiling LLM-written Python for speed, with fallback and feedback an agent can act on. Monty (Pydantic) is a sandbox, not an accelerator. Quasar and PopPy target tool calls and I/O.

## 2. Core promises

1. **Never different:** exact by default, verified, with fallback.
2. **Never slower:** the cost model plus the compile cache. One slowdown and users uninstall.
3. **Zero configuration:** no decorators, annotations or source edits.
4. **Normal debugging:** same tracebacks, `pdb` and variable names (see §8).

Wording to use: "matched on every sampled call, falls back on anything unsupported", not "guaranteed identical". Behavior that is *not* promised to match: timing, memory, `id()` values, `sys.getsizeof`, GC order.

## 3. Optimization modes

| | Static (least cost) | Dynamic (default) | Full (experimental, LLM) |
|---|---|---|---|
| Inputs | Source only | Source + profiles | + LLM proposals |
| Runs user code to analyze | No | User's own runs, plus replaying side-effect-free functions | Same, plus verifying candidates |
| Network | Never | Never | Configured model only |
| Guarantee | Proven equivalent | Guarded specialization + fallback | Tested, not proven |
| Rewrites | Dead code removal, constant folding, CSE, hoisting, inlining, provable layout lowering | Type/shape specialization, devirtualization (with watchers), hot/cold splitting, layout changes, batching, CPU/GPU choice, autotuning | Algorithm changes, data-structure swaps (list→set), memoization, NumPy rewrites, removing redundant work that isn't provably dead |

- **Plan lockfile (`recompyler.lock`):** records chosen variants, modes and backends per function and hardware class, so dynamic mode makes the same choices on every run (for CI and reproducible builds).
- Static mode alone doesn't get far on unannotated Python; most type information comes from profiling.

### Full-mode (LLM) rules

1. Deterministic default; full mode is opt-in (`--mode full`) with a configured provider. Local models supported. Code leaves the machine only with explicit consent. Cost cap per run.
2. LLM output **never bypasses verification** and **never edits user source**. Rewrites live in the cache; they are offered as a patch.
3. **Accepted rewrites are pinned** with provenance (model, prompt hash, verification record), so later runs never call the LLM.
4. **Removing code:** accepted automatically only if purity analysis shows the removed code can't have side effects **and** verification passes. Anything that calls unknown functions, touches attributes (possible properties), does I/O, writes globals, uses `del`, or can raise goes to review as a diff. Traps that look like no-ops: `x + 0.0` (turns -0.0 into 0.0), unused `int(s)` (validation), `list(gen)` (runs the generator), `x == x` (NaN check), `.copy()` (separates aliasing), `.sort()` (ordering).
5. Report the guarantee level per function (proven / guarded / tested on N inputs).

### Agent interface (`recompyler mcp`, `--json`)

Deterministic tools for outside agents, useful even without full mode. Build this before the rewrite loop.
- Read-only: `profile`, `report` (per line: compiled or why not), `roofline`, `variants`, `explain_fallback`.
- Actions: `submit_rewrite` (same verifier; returns pass/fail, first mismatching input, speedup), `benchmark` (cold and warm), `set_mode` (needs user confirmation), `pin`/`unpin`, `invalidate`.

## 4. Floating-point exactness modes

| Mode | Promise | Allows | Check |
|---|---|---|---|
| `exact` (default) | Same bits | Layout, unboxing, SIMD and parallelism on element-by-element work | Bit-identical on all samples |
| `tolerance` | Relative error ≤ bound | FMA, fastmath, parallel and tree reductions | Report worst error; warn about branches that depend on floats |
| `stochastic` | Same distribution | GPU random numbers, float32, per-simulation random streams | Statistical tests |

- Exact mode loses mainly reductions, FMA and fast math functions (about 2–4x on reduction-heavy code); layout is the big win and stays exact.
- Python 3.12+ `sum()` on floats uses Neumaier compensated summation; compiled `sum` must match it.
- Branches flip on 1-ulp differences, and chaotic simulations diverge, so tolerance has to be per workload.
- Show the price of exactness in reports: `exact 12x │ tolerance 19x (max rel err 3e-15)`.

## 5. Hardware selection (PyClutch)

- Gears: CPython → compiled serial → `prange` → GPU. Most code never passes gear 2.
- Measured crossover: 32 particles, CPU 16x faster; 32,768 particles, GPU 9x faster. 1M rows: list of tuples 318 ms on GPU vs array 15.5 ms. Data movement dominates.
- Measure, don't predict: time both backends on the first batch (already run on CPU for checking), store the crossover per function, shape and machine, and use hysteresis.
- **Background mode** (objective: least CPU, not least time): GPU with **blocking sync** (CUDA busy-waits a core by default), CPU work at low priority, report CPU time saved. Good for overnight poker and Monte Carlo runs.
- GPU threads are 10–100x slower than a CPU core on serial code; the GPU needs thousands of independent items. Different warps or blocks *can* run different code, and streams run kernels concurrently.
- Divergence: group similar work, turn branches into arithmetic, use lookup tables.
- Order of work: cost model choosing Python vs compiled first (fixes slow tiny functions), then `prange`, then GPU.

## 6. Parallelism

- **Data parallelism** (same code, many items) suits the GPU. **Task parallelism** (independent segments) suits CPU threads.
- Build a dependence graph; compute work and span; skip parallelizing when work ÷ span is small.
- Candidate loop test: writes only `out[i]` or a reduction; reads nothing the loop writes. Check statically on the lowered IR plus empirically (run sampled iterations reversed or shuffled; compare).
- GPU rewrites: outer independent loop becomes the kernel, AoS→SoA, private accumulators then combine (tolerance only for floats), scatter→gather (not exact).
- A shared `random` creates a dependence: per-thread streams require stochastic mode.
- Splitting at instruction level across threads isn't worth it (syncing ~20–100 ns between cores vs <1 ns per instruction; CPUs already run out of order). Splitting one task across a GPU block with `__syncthreads` is worth it for wide inner work (range evaluation, runouts, reductions).
- **Concrete target:** detect `multiprocessing.Pool.map(f, items)` or `concurrent.futures` mapping a side-effect-free `f`, and replace it with a compiled batch on threads or GPU.
- Prior art: polyhedral compilers (PLUTO, Polly, PPCG), Numba `parallel=True` (use as a baseline), JAX `vmap`, Dask and Ray.

## 7. Object model and the C API

Spike results are in `../recompyler-capi-spike/FINDINGS.md`.

- Converting scalars at the boundary: lean C-API crossing ~32 ns vs CPython's own call ~42 ns. **Numba `objmode` costs ~350–460 ns: never use it in hot loops.**
- Keep 50% of the compiled speedup with ~20 ns of work per crossing; 90% with ~300 ns.
- Sharing a buffer costs ~100 ns flat; converting to a list costs 10–25 ns per element.
- Containers: a synced copy (push changed slots, pointer scan after mutation) costs 1–2 ns per element. Rebuilding each call costs 10–13 ns per element and can be slower than CPython. Keeping PyObjects as the real data (compiled code reads them in place) needs no syncing; reads cost 2.4 vs 0.4 ns per element.
- **Current decision:** CPython objects are the real data whenever outside code can see them; fast copies live only inside compiled regions, synced lazily.
- **Kept open as a research track, with kill criteria:** an independent object model whose exported types match CPython's layout exactly (needs a non-moving allocator); detecting C writes with memory protection; AI-assisted porting of the top C extensions to a portable API (HPy); a hybrid with embedded CPython only for extensions.
- Next deciding experiment: a layout-compatible list and float passed to real extensions (`json.dumps`, `re`, NumPy) vs the mirror design on nested, mutated data.
- Untested: mutable nested elements, references C code keeps after a call returns (switch to PyObject-as-truth permanently), dicts (`PyDict_AddWatcher`), free-threaded builds.
- **C-function side-effect table** (reads, mutates, keeps references, raises, releases the GIL) for the stdlib and common extensions: needed by lazy syncing, purity analysis and full mode.

## 8. Correctness infrastructure

- **Guards and invalidation:** CPython 3.12+ watchers (`PyDict_AddWatcher`, `PyType_AddWatcher`, `PyFunction_AddWatcher`, code watchers) throw away compiled code when classes, globals or functions change.
- **Exceptions mid-region:** need a strategy (side-effect-free regions only, an undo log, or deoptimizing mid-loop). Rerunning a call in CPython for perfect tracebacks is only valid for side-effect-free calls.
- **Debugging:** deoptimization (rebuild real Python frames from a source map of values and line numbers) or rerun in CPython. Per-line "compiled / fell back because X" reports.
- **Aliasing and identity:** array lowering breaks `is` and shared mutation; every lowering needs alias analysis plus a runtime check with fallback.
- **Replaying user code** to verify conflicts with "don't run user code during compilation". Replay only side-effect-free functions; verify the rest by shadow execution during the user's own run.
- **Conformance:** CPython's own test suite (`python -m test`) under RecomPyler, plus pyperformance, plus a corpus of LLM-written scripts. Hypothesis-generated inputs for verification beyond sampled calls.
- **Cache:** key on source, bytecode, dependency versions, Python build, CPU/GPU, RecomPyler version and type profile. Cached native code is executable, so hash entries and lock down permissions.

## 9. Performance targets and measurement

- Order of impact: algorithm and data layout (10–1000x) > hardware choice (2–50x) > vectorization (2–8x) > instruction selection (1.1–1.5x, LLVM handles it).
- **Roofline reporting:** compute- or memory-bound, and percent of hardware peak (e.g. `52 GB/s, memory-bound, 83% of bandwidth`). A better success measure than speedup over CPython.
- Realistic ceilings: numeric loops 10–30x (C speed 50–100x); fixed-field objects 3–10x; strings/dicts 1.5–3x; NumPy-bound and I/O-bound ~1x. CPU-heavy scripts 5–15x optimistically; typical app code 1.2–2x. PyPy averages ~4–5x as the general reference.
- The number that matters most is **coverage**: the share of real run time inside the compiled subset (6.2% after milestone 4).
- Compile cost (~1.8 s Numba) needs the on-disk cache plus **tiered background compilation**: run in CPython, compile hot functions on a background thread, swap them in.

## 10. Vision document review (2026-11-10)

Missing from the product vision: debugging and explainability, an explicit never-slower requirement, how it hooks in (import hook, PEP 523, swapping code objects, `sys.monitoring`), the watcher mechanism, exceptions mid-region, the C-function side-effect table, generators/async/closures (~6% of blocked time), cache security, free-threaded Python, CPython's test suite for conformance, v1 scope and non-goals with current numbers.

Conflicts with evidence:
- "Not constrained by CPython's object model" plus a C API layer: reword Phase 1 to "fast crossing path and lazy syncing" (needed by both architectures), with the independent object model as a research track.
- "Don't run user code to benchmark" vs replay verification: see §8.
- "Mostly AOT": profiling needs a first run; tiered compilation reconciles them.
- Phase order: move the cost model and cache into Phase 1; move C API interop to Phase 3 or later.
- Backend-independent IR: Numba IR plus LLVM until a second backend needs more.
- Resource budgets are only enforceable for resources RecomPyler allocates.
- Same random sequence as serial and parallel simulations can't both hold: parallel random numbers need stochastic mode.

Principle to add: optimize top-down (algorithm and layout first, hardware second, codegen third) and measure against hardware limits.

## 11. Tools to borrow

- Backends: Numba (current), mypyc (native classes), Cython pure-Python mode, NVIDIA Warp, CuPy (blocking sync, residency), `numba-cuda`.
- Analysis: `sys.monitoring` (PEP 669), MonkeyType (runtime types), `ty`/pyright (static types), Hypothesis (verification).
- Running many jobs: Numba `prange`, free-threaded 3.14t, `psutil`/`os.nice`, Ray or Dask later.

## 12. Presentation

- Resume: about 6.5/10 now; 8–8.5 with classes, `pip install`, a one-command demo, a write-up and a poker case study. Commit the milestones so the repo shows the real state.
- Lead any post with the insight ("the 28x came from data layout, not the compiler"), plain README, honest limits, and a one-line disclosure of AI assistance. Be able to explain every design decision. Show HN, Numba Discourse and Scientific Python before r/Python.
