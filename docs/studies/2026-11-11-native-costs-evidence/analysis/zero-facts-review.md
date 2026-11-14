# Integer-zero-or-float proof review

Baseline: integration `0aeb157e8d272e0b1d4787a173f5b66f75d81b01`. Independent review of `numeric-proof.md`, the frozen implementation and its focused/full evidence. No tests, builds or timing jobs run by this reviewer during the causal-study slot.

## Design assessment

The proposed fact is sound for the bounded transfer rules: if both operands are either floats or canonical positive-zero integer payloads, the integer case of `+`, `-` and `*` is canonical zero. Existing floating arithmetic, kind flags, errors and return representation remain intact. Unknown integer arguments/fields and nonzero integer producers must invalidate the certificate. Unary mixed negation must retain its existing normalization unless separately proved.

Candidate elimination across all local definitions/return leaves can establish recursive return facts by induction over finite successful executions. Cycles are not themselves counterexamples: a finite successful call must have a terminating return, and every transfer/return used by that execution must preserve the invariant. The proof generator must run without the optimization; emitted optimized code may consume only the stabilized certificate. Facts are tied to the actual specialized `_Function`, not a Python function name.

## Mandatory implementation audit points

- Mutable local `v_*` groups must be authorized only by all-definitions certificates, never the last AST traversal assignment. Branches, loop backedges, tuple/chained assignment and augmented assignment cannot leave a favorable stale fact.
- Generated temporary names are not universally single-assignment. `method_call` dispatch joins, conditional-expression joins, dictionary default paths and other direct emitted stores require a conservative meet or no certificate. Coercion into one branch must not authorize the entire merged target.
- `peek` rewinds temporary numbering; restore every ephemeral proof table when discarding its code. Unknown/mismatched producer writes must kill facts rather than retain an existing entry.
- Coercion must preserve the canonical integer-zero condition, not only mathematical zero. NumPy/optional/nullable or unsupported shapes should be unknown unless handled explicitly. Do not infer zero from float `-0.0` when the integer-kind flag could become true.
- Verify final ordinary kinds/call graph still match the proof pass. Unstable shape, proof-budget exhaustion or unhandled producers must use ordinary lowering, not introduce unsupported programs or optimistic code. The finite candidate lattice supplies a clear convergence bound.
- Do not publish new parameter/field assumptions through unchanged loader/seed metadata. All new facts must follow from guarded kinds and program code.

No concrete design unsoundness found in the stated bounded rule.

## Actual patch review, before native validation

Read the initial +116/-7 product diff and subsequent compile-reset amendment (+118/-7) in `wave6-zero-facts/src/recompyler/heap.py`, plus the new focused tests and saved frontend red/green logs. No concrete semantic unsoundness or convergence failure identified in the implementation.

- Local lookup consults only the candidate table via exact frozen local code groups. Assignment visitation cannot override a local with a favorable latest-branch fact.
- Conditional/polymorphic/dictionary merge result temporaries receive no certificate. Their branch-local sources may be certified, but their independently allocated merged destinations remain unknown. This avoids the multi-definition temporary hazard without requiring broad merge reasoning.
- `coerce` preserves numeric tuple leaf paths and declines unsupported/nullable shapes. Unknown producers remove existing registry entries. Copies used for tuples/chained assignments preserve producer facts, while heap reads remain unknown.
- Analysis starts with optimization disabled, invalidates candidates monotonically and runs at most the finite initial candidate count plus one passes. The final regeneration checks ordinary-type changes, reachable-order changes and certificate invalidation before publishing the sources; failure clears certificates and regenerates ordinary lowering.
- The scope also removes an exact-integer coercion check for a certified integer-zero operand in `as_mixed`. This is supported by the same invariant; no unknown integer conversion check is removed.
- Repeated `_Program.compile` originally retained the previous proof tables/mode before ordinary settlement. Root and reviewer independently noted that this violates the unoptimized-analysis invariant on a reused Program, even though current build paths generally construct fresh Programs. The implementer added an explicit reset at compile entry; inspected and accepted. A lightweight repeated-compile control was requested.
- One initial test expected integer overflow while its recursive accumulator was always floating. The implementer corrected this to a genuinely unknown out-of-exact-range integer return/coercion case; this was a fixture correction, not a product defect.

The recorded frontend run exercises real source generation with no Numba import: two expected baseline guard-removal failures, then six passing cases in 0.039 seconds including conservative unknown/nonzero, branch/loop/conditional and polymorphic controls and `peek` restoration.

## Final frozen code and validation review

Reviewed complete `0aeb157..9ff4908fdc58613d72287f71cfc6b70aa5e693ff` diff: exactly `heap.py` (+118/-7) and the new 297-line focused regression file. The final product diff is the already-reviewed implementation with compile-entry proof reset. No additional product changes appeared after the source review.

Read `wave6-zero-facts/build/zero-facts-validation/{manifest.json,focused.log,full.log}`. The frozen `heap.py` SHA256 is `e7ee3bb1fb2b8c42a6848383388ef28ed3eaf79e6a1f50e0fc53b210570e5109`.

- Focused **14 tests and 14 subtests passed in 10.34 seconds**. Inspected final cases cover exact numeric types/signs, large floating values/NaN/infinity, zero arithmetic, unknown/nonzero integer fallback, mutable aliases and division failure, unknown branch/loop/conditional/polymorphic producers, and recursion-limit fallback.
- Real LLVM checks confirm the exactness-bound test disappears from the certified recursive fixture while remaining in the unknown-integer control. This is fixture-native evidence, not Barnes actual-AOT assembly evidence.
- Fresh subprocess AOT test builds the real fixture artifact, requires **five successful AOT calls per loader, zero JIT/fallback, and no Numba import**, and checks public results against Python for both loaders.
- Repeated `_Program.compile` now has a passing exact source/digest stability control.
- Full suite: **441 tests and 52 subtests passed in 253.03 seconds**, with 22 known-category GPU occupancy/Numba SSA warnings. No reviewer-run builds/tests/timings were added during the study's CPU slot.

**Final production code verdict: clear / ready to integrate. No unresolved actionable correctness, proof-convergence or regression findings.** This verdict makes no workload-speed claim. Actual selected Barnes AOT instruction validation and the separately controlled performance study are distinct follow-up evidence.

## Production-study harness read-only note

Reviewed `wave6-proof-study/proof.py` and the manual study's protocol, variant construction, target-only profiling, state audits and arena/phase wrapper. Frozen evidence distinguishes manual numeric contracts from unchanged-source production proof, preserves original targets/artifacts, requires explicit actual AOT audit modes, and keeps phase instrumentation separate from timing.

One retained-data validation gap was reported to root: shared `causal.audit_compare` checks numeric/alias checkpoint hashes and initial/final types but does not compare each intermediate `types_sha256`. The production state audit already saves those hashes; root can compare every step read-only after completion without editing frozen helpers or rerunning workloads. Do not claim all-step type validation until that comparison passes. No production code defect identified.

**Gap closed:** reviewed `wave6-study/postverify.py` and the completed production `checkpoint-postverification.json`, then independently compared the retained plain/baseline/candidate checkpoint dictionaries. Their step sets are identical, contain exactly 100 steps, and every numeric/type/alias hash matches. The source comparison has no production type relaxation. Actual-mode counters reconcile to 100 successful AOT calls per state audit, zero JIT/fallback/rejected/unknown calls and no Numba import. `wave6-instructions/verification.json` records this independent check and evidence hashes.

The actual selected Barnes AOT PE also demonstrates the intended optimization: recursive-force references to the exact `2**53` constant fall from 14 to six; the six coordinate-field checks remain, while the eight recursive accumulator checks disappear. Public numeric-kind return flags remain. See `wave6-instructions/REPORT.md` for artifact/call-target provenance and excerpts. The unchanged-source production timing cohort shows **no observed speedup** (47.2972 ms baseline versus 47.4359 ms candidate); this does not alter the correctness verdict and must not be reported as a measured performance win.

## Condensed report accuracy review

Read integration `docs/studies/2026-11-11-native-costs.md` against the frozen manual/production analysis, reviewed code/test evidence and actual-binary report. **Clear: no actionable accuracy or attribution finding.** Manual 46.5740 to 29.7802 ms and C 9.0947 ms are correctly labeled changed-contract/grouped-boundary diagnostics; production 47.2972 to 47.4359 ms is explicitly no observed gain, with phase/startup causality left unresolved. Static 14-to-six bound references, 632-to-524 instruction lines, retained flags/frame, 29 outgoing stack slots, C theta 0.5 and Python-profile call counts are qualified correctly. The four proposed compiler mechanisms are future proof obligations, not claimed implementations. Validation totals 441 tests/52 subtests agree with the logs. The aggregate 3,900 diagnostic calls refers specifically to phase diagnostics; recommended that wording for precision, since separate state audits add 650 calls. No new tests, timing cohort or source changes were needed for this scoped documentation review.
