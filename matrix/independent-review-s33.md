# S33 independent acceptance review

Reviewed actual direct_calls/results.json (v2 direct entry), results-v1-dispatcher.json, emitted LLVM, v1/v2 logs and lock receipts, current runner, static_frequency.py and static-frequency artifacts. No workloads were run for this review; no product files were edited.

## Decision

Accept the experiment as evidence for the S33 BOUND, with the claim boundaries below. No further blocking defect was found in the measured prototype or corrected static artifact. This accepts a feasibility result, not a new deployed backend/capability or a speed claim.

## Observed execution

Both locked runs exited 0, and their final before/after-acquisition audits recorded zero competing-workspace blockers. The v2 experiment uses the existing compiled overload.entry_point (recorded builtin_function_or_method), rather than the generic Numba dispatcher, for behavior/ownership gates and direct-entry timing. Dispatcher timing is retained separately.

All 14 behavior cases match CPython (4 string, 5 dictionary, 5 mixed-object cases), with no gate-error field. Saved identity, unchanged-input/key-order, success/error reference-count and weakref/finalizer checks pass for their tested scenarios. JSON includes a second-iteration callback failure and a successful update followed by bytes conversion failure; the latter is repeatedly exercised for cleanup. These are concrete ownership/unwind witnesses, not a universal proof for arbitrary object hooks.

| Complete call | CPython median us | Boxed direct-entry median us | CPython / boxed |
|---|---:|---:|---:|
| chaos.GVector.__str__ | 0.217985 | 0.222560 | 0.979 |
| json_loads.mutate_dict | 22.963400 | 42.070800 | 0.546 |
| mdp.applyHPChange | 0.526370 | 0.776275 | 0.678 |

Each is three alternating pairs with the stated sample repetition count. No function shows a measured speedup. Treat the string result as a near tie/no demonstrated gain; do not turn its roughly 2% median difference into a resolved regression from three pairs. The dictionary and mixed-object samples are consistently slower, but preserve raw variability rather than advertising their exact ratio as a universal penalty.

Generic-dispatcher medians were 21.773970, 109.419800 and 38.795470 us in v2. V1's dispatcher-only medians are retained as the corrected boundary experiment, not the best boxed-call result. The dispatcher overhead must not be attributed to the translated body.

Object-mode compilation cost is separately recorded (approximately 0.0276, 0.1764, 0.0647 seconds). It is not included in steady-state complete-call numbers.

## What the experiment establishes

The existing Numba dependency can JIT a whole boxed body with ordinary Python objects, native control flow and CPython operations. The dictionary LLVM contains actual PyObject_GetIter, PyIter_Next and PyObject_SetItem callsites; the three modules contain actual GetAttr, PyObject_Call, PyNumber arithmetic/formatting, reference increments/decrements and error handling. The loop body is translated with loop lifting disabled, while called Python payloads can still execute Python internally.

All three unchanged strict-njit signatures fail with TypingError/non-precise type pyobject. All three unchanged production _pycc exports with the same signatures fail at the nopython frontend for the same reason. Current product lift also records actual named declines for the three originals.

The supported conclusion is therefore:

- Existing dependency object-mode JIT: feasible for the three tested complete bodies, including the tested exception/ownership behavior.
- Current RecomPyler nopython/AOT path: does not support those generic pyobject signatures as configured.
- Production capture/guards/automatic emitter/AOT/deployment integration: not built or demonstrated by this prototype.
- Future object-mode AOT: not proved impossible by these failures; it would require a separate authorized engineering route.

Actual direct vectorcall and PyObject_RichCompare callsites are absent in the recorded three modules. Do not state that every API named in S33 was independently exercised. Builtin min/max may perform comparisons internally through their normal Python C implementations, which is a different claim.

No selected direct-entry implementation beats CPython. That does not prove all its time is inherently inside CPython C code or that every better boxed emitter is impossible: this object-mode lowering also pays generic global lookups, boxed temporaries and reference-count overhead. The defensible result is no gain for these implementations/inputs. No region should be deployed on these results.

## Reach estimate

estimated-reach.json clearly labels 548 of the original 655 declined rows as a syntax-based future-mechanism candidate estimate and records zero newly native production rows. Its list and exclusions are reviewable. It is not 548 executed native rows, expected speedups or deployment successes; a future whole-body emitter plus missing integrations is assumed. Keep this label in the BOUND and final report.

## Static artifact acceptance

The current artifact covers 1,016 matrix rows, 40 own files, 375 named function definitions and 340 total own/stdlib source files. It records zero skipped sources and zero unresolved mapped rows, own/excluded/source manifests, and grouped/top-40-row views. Its recorded verdict-source SHA256 matches the current matrix.json exactly.

Previously identified concrete mappings are corrected: pass -> Pass, destructuring -> assignment:unpack, del_attr -> delete:Attribute, anext variants -> actual anext candidate calls, and TypeVar/TypeVarTuple/ParamSpec -> distinct type-parameter AST families. Load-only displays, nested definitions under control flow and f-string conversion/spec roles are present. No remaining specific static blocker was found in the inspected corrections.

Keep its existing caveats: runtime receiver types/builtin shadowing are not inferred; variants can share overlapping candidate counts; integer computations are not the same as large literal tokens; static possible-import closure includes conditional imports and cannot prove the exact runtime module set. The 375 definitions are a denominator, not an observed whole-function-native count.

## BOUND/report requirements

Lead with feasible dependency JIT versus unsupported unchanged production nopython/AOT, the direct-entry timing table and zero newly native production rows. Retain v1 as dispatcher-boundary correction evidence. Supply the two or three realistic alternative routes and engineering-size estimates S33 requests, with estimates clearly labeled; return that backend choice to the user before starting one.

S32's later hottest-function representation ceilings remain separate. This small S33 prototype does not replace those subsystem measurements or authorize further backend work.

Only matrix/independent-review-s33.md was written.

