# Wave8 independent retained-assembly investigation

Read-only analysis against integration 93986c89/product a033ca1. No product edits, artifact imports, compilation, tests, profiles or timing runs. Adjacent scripts read retained audit/plan JSON, verify artifact hashes, map PE exports and run read-only disassembly. These are historical observations, not results of the pending held-out rerun.

## Main recommendation

The strongest bounded next optimization is a proof that validated list header addresses and checked list element addresses are nonnegative. The remaining signed-array normalization is visible in actual raytrace AOT and the current compact Barnes AOT. It can be removed while retaining Python's logical negative-index and bounds behavior. Exact code sites, proof boundaries and meaningful fail-first tests are in LIST-INDEX-PROOF.md. This is ready for implementation review; CPU verification still needs the coordinated window.

## What the retained comparisons actually execute

| Workload | Historical candidate kernel / C | Audited execution | Interpretation |
|---|---:|---|---|
| raytrace | 4.2369 / 0.6039 ms | Five successful Scene.render heap AOT calls, zero JIT/fallback | Actual selected AOT provides a useful repeated instruction pattern. Historical pre-W6/W7 result. |
| Richards | 1.1021 / 0.1850 ms | heap JIT/cache, not AOT | Cannot describe the timing gap as an inspected AOT binary difference. |
| spectral_norm | 24.9762 / 0.5178 ms | ordinary JIT helpers with outer Python | The large whole-kernel ratio is not a pure native-code tax. |
| SciMark FFT | 2.6590 / 0.4258 ms | FFT_transform: 250 JIT; FFT_inverse: 250 AOT; _total: 15 JIT outside/around FFT checks | Mixed path; inverse AOT inspection is valid, but whole FFT time is not an isolated inverse/heap measurement. |

Source: wave5-study/RESULTS.md and each programs/<name>/candidate-forced.audit.json or candidate-warm.audit.json. SciMark SOR/sparse/MonteCarlo/LU stayed Python and are excluded from native instruction claims. Earlier FFT baseline used both transform/inverse AOT, so that cross-state change cannot be attributed to the heap optimization. A current rerun must independently qualify every mode again.

## Pattern 1: physical list-address adjustment

Raytrace selected artifact SHA256 ef001c5a6907ee2012dc3bb1d218dc4effc9cc8adedf4f86348d4f4c6c087b6b; actual digest 0ed2b2e934d6be111a7f709c78ab62e052e513796dcf3372079253dc4f72d035/export r0. PyMethodDef wrapper 0x1800028b0 calls native 0x180001090. At 255a/255e the compiled code derives a sign correction for the list header; at 258b–259d it adjusts the header+2 address; at 25a9/25ad it adjusts the checked data+index physical address. This repeats around the RGB stores. The Python logical-negative and bounds checks at 256e–2585 are separate and necessary.

The C render loop clamps and stores bytes directly (1a02/1a1c/1a39). C uses uint8 output storage and direct structs, while the Python heap lowering stores array('B') values in int64 slots and preserves dynamic semantics. The proof removes only the redundant address normalization, not every difference in this block. Current Wave7 Barnes force retains the same list header/data pattern at 2cb6 onward; its separate immutable report binds that code to the actual selected successful AOT artifact.

This proposal does not remove status/depth guards, type flags, alias handling, rollback or signed nullable-tuple payload indexing. It does not convert static counts into cycles or forecast a timing gain.

## Pattern 2: guarded counted-loop bounds/status proof, deferred

The actual selected SciMark inverse AOT artifact is SHA256 185a02839775a091d004f7f5e87f20a57aa366fb63a72001058445e6c6eb0a20, digest 21f96acd5ba27875040fad65de84c40fcabd58fd4121099b3b0c3755c431c017, export f1. Static wrapper 0x180002f10 calls inverse native entry 0x180002190. Do not substitute the module's f0 transform body: the candidate audit used JIT for transform.

The inverse normalization loop at 0x180002380 performs load/multiply/store, then 239a polls the sticky status and 239f compares the induction variable against the actual array length on each iteration. The driver function performs `for i in range(N): data[i] *= norm`. N is an independent argument, so an unconditional bounds removal is unsound. Current lift.py:2425–2447 implements checked get/set; one failure can set status and suppress later work. The C source's fft_inverse (191 onward) has a direct counted double-array multiply, with fixed benchmark dimensions supplied by main. I have not bound a specific C machine loop to that source and make no C instruction-count claim for it.

A future general rule could prove the induction variable lies within an immutable one-dimensional float-array extent. `range(len(data))` may supply a static bound; independent N requires a dominating guard `0 <= N <= len(data)` and a checked slow path. Removing sticky-status polling further requires a body effect proof that nothing can set status, and preservation of incoming failed status. Unknown calls, integer overflow, conversions, resizing, arbitrary indexing, division and observable effects must invalidate the proof. Do not hoist a failing check across preceding FFT writes without preserving transactional behavior. Keep operation order, signed zeros/NaN/inf and aliases; no reassociation or invented noalias guarantee.

This is larger than the list-address annotation and is explicitly deferred for this wave. Relevant tests would include zero/negative/oversized N, prior failed status, short arrays, stride/alias views, and failure after partial effects. The historical mixed FFT timing cannot quantify this loop's cost or its likely speedup.

## Startup change review

Read wave8-runtime-fix/src/recompyler/runner.py actual diff: a single parsed-plan snapshot feeds private selectors while public recommended/regional path APIs remain; AST visitor construction and selected-only imports are lazy; plain execution compiles source bytes. No code correctness blocker identified. No global plan cache or selection-threshold change is present. The existing API already requires Path via script.parent. Python's compiler handles encoding cookies/BOM/newlines on bytes; malformed-source error wording need not match tokenize.open exactly.

Review remains conditional on the worker's expanded encoding/newline/traceback, public-selector, selected/force, restoration/SystemExit and fresh-subprocess import controls. Initial four-test red/green evidence was reported by the worker, not rerun by this reviewer. Runtime/coverage improvements must be measured separately from the proposed native instruction annotation.

## Evidence limitations

retained-provenance.json records selected artifacts, exports, hashes and PE maps. Complete disassemblies are adjacent; misleading nearest exported symbol names are not treated as generated function identities. No current slowdown ranking has been inferred from these old times. Generic AOT CPU targeting versus native-target C, representation, algorithm details and timing boundaries remain comparison differences. Any next measured result requires current successful selected-mode audits and unchanged semantic checks.
