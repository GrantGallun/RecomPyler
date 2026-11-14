# Combined coverage, deployment and native-speed study

The feature tracks are combined on `codex/integrated-coverage`. The AOT build failures are fixed, the corrected 49-workload study completed, and the final runtime safeguards passed **323 tests plus 38 subtests**, with no failures or skips. The primary working files were not changed.

The measurements show broader verified opportunities and lower fallback overhead, but **not broad native acceleration or a universal upgrade over CPython**. Correctly executing a program through Python fallback is separate from compiling its hot work efficiently.

## Revisions and validation

- Original feature baseline: `56211d5`; measured baseline `5083021` applies the same reviewed build-path fix used by integration.
- First combined engine: `75aefc1`. Its study retained two integrated profiler crashes rather than dropping them.
- Corrected measured engine: `dc02b957f3e5504aec305343e942a8d0d96a17b1`. The nested-class analysis and generator-inference crashes are fixed; both workloads passed in the complete rerun.
- Final runtime corrections: `d25b225` distinguishes executed/prepared AOT mode from export availability; `ee03841` prevents unexpected JIT compilation when the default plan budgets only AOT startup. These change the runner and tests, not emitted kernels, the heap/lifter, source-digest inputs, or the AOT ABI.
- The final code tree is identical to independently reviewed worker revision `43836db`, whose complete suite passed 323 tests and 38 subtests. Ten Numba warnings remain. The suite transcript is retained locally at `heldout-fixes/.tmp/runner-budget-full.txt`.

The full 49-program timing study measured `dc02b95`, before the two runner-only corrections. It was not repeated after those corrections; focused fresh-process tests, three actual longer-workload audits and the complete final suite validate the safeguard separately.

The combined work includes definite assignment and loop/exception forms; strings, dictionaries, sets and common argument binding; generator capture and supported consumers; module globals, random state and NumPy boundaries; lazy startup and rejected-batch execution. Support is conditional on the compiler's actual types and operations, not complete support for every use of those language features.

Review also corrected unsafe generator eager consumption, array writes repeated after fallback/retry, returned noncontiguous array views, nested-global alias restoration, and pickle hooks invoked during copy preflight. Some cases now conservatively use Python. Writable NumPy kernels snapshot writable inputs for rollback, adding memory and copy cost.

## Fixed-population result

| Population | Valid paired timings | CPython / baseline time | CPython / integration time | Mean largest verified opportunity, baseline → integration | Default native calls |
|---|---:|---:|---:|---:|---:|
| Held out: 38 fixed workloads | 37 | 0.901x | 0.974x | 0.487% → 3.192% | 0 |
| Nine tuned regression workloads | 9 | 1.158x | 1.176x | 51.78% → 50.98% | 2,020 → 2,010 |

Ratios are geometric means of per-program median complete-process timings; values above one are faster than CPython. Integration is about 8.1% faster than the previous baseline on the paired held-out set, while still about 2.7% slower than direct CPython in this configuration. The improvement there is reduced overhead, not deployed native work. Three held-out workloads exceed 10% verified opportunity, compared with one before.

Go and a two-deal poker self-play are separately attempted additions, not changes to the 38-program denominator. Both ran successfully and deployed no native calls. The small poker run was approximately neutral (1.007x CPython); this establishes no general bot speedup.

All 49 corrected profiles succeeded. All 735 fresh timing processes exited successfully and matched the corresponding stable plain-Python stdout. There were no timeouts. Most pyperformance workloads print nothing, so this is an exit/output check, not full result equivalence; captured sample verification and regression tests provide separate finite evidence.

The opportunity statistic is the largest verified candidate's cumulative region time (or ordinary function self time), capped at script time, divided by total profile time. It avoids adding overlapping regions but is **not union coverage or measured runtime actually compiled**. Verification alone does not mean a candidate is faster or recommended. The default held-out plans recommended no native deployment in this short-workload study.

## Method and limitations

The population was frozen from 47 historical successes: nine tuned and 38 held out. The 26 historical failures remain recorded, including dependency, data, argument and compatibility failures; Go's former recursion failure is explicitly reattempted as an addition. Go and poker do not change the fixed denominator. `python_startup` uses a no-op shim entry and is excluded from meaningful timing, leaving 37 held-out timing pairs.

Matched configuration: 40 hotspots, eight captured samples, two shim workload loops, five fresh-process repetitions, 180-second timeout, default runner without `--force`. Inputs, source trees, runtime/package identities and a sanitized environment were recorded. Timing modes rotate to reduce order effects. Startup, guards, loading and conversions remain in process time; profiling/building is separate.

The corrected study reuses the unchanged baseline's 49 successful profile records and plans byte-for-byte, after checking source/runtime/environment/shim/input/driver equality. All latency measurements are fresh and interleaved. Provenance records hash 196 copied evidence files and seven retained AOT modules. Baseline capture/verification/build cost is historical first-study evidence (403.88 s); corrected integration profile cost is fresh (451.11 s).

The frozen environment disabled bytecode writes. Source-bytecode cache validity was not equal across study versions; consequently, version-to-version startup differences must not automatically be attributed to compiler changes. A separate warm-bytecode control used isolated per-variant cache prefixes, two warmups and five fresh instrumented repetitions. Barnes–Hut medians were 0.397 s baseline / 0.412 s integration (plain 1.409 s), and neither imported Numba. Raytrace was 0.348 s baseline / 0.485 s integration (plain 0.494 s): the integrated default plan had rejected compilation. These controls are separate from the fixed-population headline.

Measurements are observations on one Windows/Ryzen 7 9800X3D system, not a statistical performance guarantee. Raw samples and regressions are retained.

## Gap to native C

Nine matching C ports were rebuilt with `clang -O3 -march=native -ffp-contract=off` and the same UCRT runtime as CPython. All numeric/check outputs matched. Warm kernel best times exclude startup, setup, profiling and compilation; C uses 20 repetitions, Python/RecomPyler five. Forced/warm diagnostics are separate from default deployment.

| Warm kernel | Time relative to C | Speed relative to Python |
|---|---:|---:|
| nbody | 1.21x | 18.98x |
| fannkuch | 1.92x | 9.63x |
| float | 2.14x | 17.45x |
| Richards, explicit warm diagnostic | 5.77x | 23.43x |
| Barnes–Hut | 5.54x | 10.73x |
| raytrace | 7.53x | 35.59x |
| coroutines | 10.12x | 11.46x |

Spectral norm only accelerated helpers and remained about 50x C time. Four SciMark kernels remained in Python; their large C gaps must not be called native-instruction overhead. Observed blockers include functions passed as values, `array.array('d')`, uncaptured eligible calls and constructor initialization restrictions. C is an optimized comparison implementation, not proof of optimal assembly.

## AOT deployment defect and safeguard

A longer diagnostic increased shim loops from two to twenty for the two meaningful held-out workloads whose first-study verified opportunity exceeded 10%: chaos and Richards_super. This was predeclared by opportunity, not selected for speed, and is not a replacement headline.

It did not establish general acceleration. Richards_super had a fast verified kernel but complete runs took approximately 1.2–7.4 s versus about 0.75 s in Python. Instrumented runs showed that saved AOT code was rejected and JIT used, despite the old report claiming AOT. Profiling built a heap ABI from an already populated global task graph; a fresh run began with empty globals and inferred different tags, fields and function order. Unordered class checks also changed source digests across processes. **The digest guard must stay: these layouts cannot safely share machine code.**

The final runner reports loaded artifacts separately and conservatively identifies prepared AOT execution. A default AOT-only plan now falls back to Python on deployment misses instead of silently paying for JIT; explicit `--force` and JIT-budgeted plans retain JIT. Three fresh runs of the real longer Richards_super case confirmed 20 Python fallbacks, zero compiled calls and no Numba import after the safeguard. They still took about 1.23–1.28 s: this is a safety improvement, not a claimed positive speedup.

NumPy source generation can still import Numba through `_nd` before export lookup. The safeguard prevents the subsequent unbudgeted JIT path; it is not a universal no-import guarantee.

## Generalization priorities

1. **Stable guarded typed programs and AOT ABI.** Persist/rebind the inferred layout, or canonicalize final types/tags/fields/function emission independently of mutable entry-state encounter order. Validate actual fresh-process AOT use, values, aliases and guards. Never bypass a digest check or substitute an export by name.
2. **Capture and deploy ordinary call forms.** Extend closure/argument capture, function-valued parameters, typed heterogeneous dictionaries, numeric `array.array` buffers and partially initialized objects. Install verified functions in imported files using file-aware identities; entry-script rewriting alone does not cover a real multi-module application.
3. **Native islands with exact state recovery.** Let supported hot loops coexist with Python calls, `with` and other unsupported operations. Materialize visible state at barriers and resume at the correct point, preserving effects exactly once. Restarting after irreversible effects is unsafe. Include safepoints and tests for changing globals, threads, signals and tracing.
4. **Remove proved representation cost.** Use escape analysis/scalar replacement, native layouts, range proofs and hoisted guards. Keep temporaries in registers and avoid repeated heap/copy boundaries. Evaluate host-targeted AOT with CPU-feature-keyed caches; current AOT builders leave the vendored CPU target generic.
5. **Parallelize proved independent work.** Measure CPU/GPU dispatch, packing and transfers before choosing a backend. The RTX 5080 is available, but this wave makes no new GPU speed claim.

Guarded specialization is an established mechanism ([CPython specialization design](https://peps.python.org/pep-0659/)). Object identity, mutation and protocols remain observable ([Python data model](https://docs.python.org/3.14/reference/datamodel.html)); integer precision and required floating-point behavior must be retained. LLVM documents alias checks and floating-point reduction restrictions in its [vectorizer guide](https://llvm.org/docs/Vectorizers.html). These facts support removing implementation overhead where proved, while keeping general Python execution available. They do not justify a universal C-speed guarantee.

## Evidence

The sibling `2026-11-11-evidence` directory contains compact metrics, detailed reports, review findings and the archived paired harness. Full raw plans, outputs, caches and manifests remain under `D:/Code/Datathon/recompyler-codex-20261111/wave2-study` and `native-study`. Those historical harnesses assume the recorded local directory layout; use a new output directory and regenerate a manifest for a new experiment.
