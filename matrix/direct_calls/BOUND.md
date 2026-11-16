> Historical S33 result. The extension-interface feasibility conclusion is updated by [COMBINED-BOUND.md](COMBINED-BOUND.md), which proves typed managed objects through existing nopython/AOT. Raw S33 results below remain unchanged.

# S33 direct CPython-object call feasibility

The unchanged RecomPyler nopython/AOT pipeline cannot carry arbitrary Python objects. All three explicit pyobject signatures fail type inference with `TypingError: non-precise type pyobject`, before reference management, exception lowering or linking is reached. This is an observed current-path limitation, not a proof that object AOT cannot be implemented. No product backend/export flags were changed.

Numba's existing object-mode JIT does carry owned Python references and emits CPython C-API operations. The hand-reexpressed bodies compile with forceobj=True, looplift=False. Their compiled overload.entry_point is a real built-in CPython callable; all gates and the boxed timing column below call that entry directly. The separate generic dispatcher column retains the observed dynamic-type dispatch cost; it is not the boxed-body ceiling.

| Complete held-out function | CPython us | Boxed compiled entry us | CPython / boxed | Generic dispatcher us | Current product whole-function native | Unchanged AOT |
|---|---:|---:|---:|---:|---|---|
| chaos.GVector.__str__ | 0.217985 | 0.222560 | 0.979x | 21.773970 | 0; named decline | pyobject typing failure |
| json_loads.mutate_dict | 22.963400 | 42.070800 | 0.546x | 109.419800 | 0; named decline | pyobject typing failure |
| mdp.applyHPChange | 0.526370 | 0.776275 | 0.678x | 38.795470 | 0; named decline | pyobject typing failure |

Three alternating pairs per function under TIMING.lock; each sample repeats the complete call 20,000 / 500 / 20,000 times respectively. Fixture construction stays outside both calls. Raw times, sample order, source bodies, compile times, errors and generated LLVM callsites are in results.json and *.ll; acquisition/process audits are ../logs/s33-direct-call-v2.*. Initial dispatcher-only measurements remain results-v1-dispatcher.json and the v1 logs. source-seal.json binds the actual v2 harness, bodies and unchanged AOT compiler.

All 14 value/error/state cases passed. Additional gates preserve selected result/child identities, original dict/key order and Random state; 10,000-call success and exceptional refcounts are stable; mid-loop errors, owned child finalizers and weakref release agree. These tests establish the observed scenarios, not arbitrary-object lifetime correctness in every possible hook. No native product deployment occurred.

The string formatter is within about 2% of CPython and has no resolved gain. The dict loop and mixed builtin/method function are slower on every paired sample. Generic boxed object-mode lowering alone provides no measured speed benefit for these calls; the string formatting work already invokes CPython C operations. The experiment does not attribute every slowdown to time inside C, nor establish the fastest hand-optimized C emitter. No profitability gate was changed.

Actual emitted callsites include PyObject_GetAttr, PyObject_Call, PyNumber_Remainder/Multiply/Add, PyObject_GetItem/SetItem, PyObject_GetIter/PyIter_Next, PyDict operations and reference-count APIs. Specialized vectorcall and PyObject_RichCompare direct callsites were not witnessed in these three bodies. String methods/formatting can call generic object/number APIs. Transitive Python payload methods still execute Python; the translated body/loop itself has no interpreter loop.

## Matrix and ordinary-source reach

The current product matrix stays 235 native / 781 declined / zero wrong/crash. The prototype has no automatic source emitter, capture/verification integration or deployable AOT backend, so it turns **zero production matrix rows** newly native. estimated-reach.json lists every original declined row: **548 of 655 are syntax candidates**, explicitly an estimate for a future boxed whole-body backend, not executed support. The excluded 107 require additional binding/context, nested-function/generator/async, comprehension, class, exception-statement or other lowering work. Even included rows require real guards, ownership, execution and AOT tests before a verdict can change.

The three sampled ordinary functions currently have 0/3 whole-function native executions; the hand-reexpressed experiment has 3/3 compiled bodies. STATIC-FREQUENCY.md/static-frequency.json enumerate 375 function definitions in 40 available held-out-owned files and 340 total own/possible-imported-stdlib files. No native count/share for all 375 is inferred; 372 definitions were not exercised by this small prototype. No Step 3 capability has landed, so the before/after whole-function execution census remains a required capability acceptance measure. Static source counts and historical profile weights are side-by-side evidence, never deployed counts.

## Decision alternatives, sized estimates

These sizes are engineering estimates including tests; they are not measurements or commitments. They are concrete next choices, not implemented backends.

| Alternative | First usable scope | Estimated size and work | Main limitation |
|---|---|---|---|
| Integrate dependency object-mode with object AOT export | Whole bodies expressible by current Numba object mode | 0.8-1.5k lines plus ownership/ABI/environment/guard tests; adapt compiler/export/environment persistence and product selection | Small examples are already slower; saved object globals/lifetimes and Python-version compatibility need proof; overlaps startup ownership |
| Small CPython-C-API whole-function emitter beside numeric path | Straight-line/branch/loop code, boxed values, direct calls, exact exceptions | 1.5-3k lines plus AST/ownership/cleanup/guard/AOT tests for first slice; 3-6k for wider statements/calls/closures | New backend; all exits and references must be generated soundly; API calls alone do not guarantee speed |
| Continue native kinds and add guarded boxed call boundaries | Borrowed immutable strings/bytes first; then dict/set and callable environments | Roughly 1-2k lines per first native-kind slice plus 1-2k shared boxed ownership/call support; larger whole-language integration | Several independent representations; callbacks and mutation complicate guards; all four S32 ceilings still required |

S33.1 says: ?Do not start a backend change in this run; that decision goes back to the user.? Therefore the decision is returned with these measured alternatives. The per-subsystem S32 hottest-function ceilings follow the chosen mechanism; they have not been replaced by these three ordinary examples. S32-ceiling-selection-review.md retains exact hottest-function nominations, inputs, overlapping-weight/concentration limits and candidate native representations.
