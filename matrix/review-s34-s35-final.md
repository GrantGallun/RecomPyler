# S34/S35 final independent diagnostic acceptance

Accepted as a bounded diagnostic result. No concrete blocker remains for presenting COMBINED-BOUND.md to the user for the backend decision. This accepts the retained measurements and mechanism evidence within their stated domain; it does not accept a production backend/capability change or universal arbitrary-object equivalence. No workloads were executed by this reviewer.

## Evidence independently checked

Read COMBINED-BOUND.md, combined-summary.json, results-c.json, final guarded.c and runner, six guard-green-v5 records, gc-guard-v5.json, PLAIN-NUMBA.md and final/summary/source manifests, managed results/LLVM/source, fresh_aot.py and AOT-STATUS.md. Checked accepted combined receipt exit 0 and its pre/post acquisition audits with zero blockers. Located accepted managed s35-extension-v6-green receipt exit 0; earlier misleadingly named green-v4 was an actual failed retained attempt, not acceptance evidence.

Recounted all final plain rows from retained data: 781 unique IDs, exactly equal to the 781 current declined IDs; 170 matches, 37 differences, 574 compilation failures, zero unresolved harness classifications. Every match/difference contains an actual nopython signature. Intersecting by IDs with baseline-v1.jsonl's 655 declines independently yields 153/23/479 across all 655 rows. Explicit typed-dict/dtype/generator projections preserve the unfamiliar runtime types instead of silently normalizing them. Seven rerun results remain actual differences, and original artifacts are retained.

Verified hashes for every entry in plain-numba-summary.json, managed results' source hashes and AOT artifact, final combined-summary.json source hashes, and the C source/artifact entries in c-source-seal-v5.json. The earlier C seal's run_c.py entry predates the final runner ordering and differs, but combined-summary.json separately seals the current runner correctly. Keep both histories; this is resolved provenance, not a request to rerun.

The final C results contain 4+5+5 identical behavior cases and no gate errors. Success/error input refcounts are stable, with identity/child/finalizer checks retained. All six additional final guard/lifetime regressions report identical behavior. The new registered-GC callback guard causes Python fallback: final GC 16 pairs have zero witnesses/child failures, with zero C fast calls under the callback. These establish the fallback mechanism rather than proving that cached fast operations tolerate arbitrary GC re-entry.

## Conclusions supported by the measurements

Final combined medians in microseconds are:

| Function | CPython | Object-mode direct entry | Hand C | Managed AOT |
|---|---:|---:|---:|---:|
| GVector.__str__ | 0.228190 | 0.242605 | 0.223495 | 0.371820 |
| mutate_dict | 18.936600 | 27.542600 | 13.063400 | unmeasured |
| applyHPChange | 0.514405 | 0.751975 | 0.207320 | unmeasured |

Timed route deltas show 60,000 string direct-C attribute/format calls (the second counter slot, not the removed instance-dict fast path), 1,500 dictionary fast calls and 60,000 HP fast calls, with zero timed nominal Python fallbacks. Preflight compilation/error rendering before the single C configure resolves the earlier invalidated-dictionary cohort. Dictionary gain is about 1.45x and HP about 2.48x for these fixtures/domains. The roughly 2% string difference is unresolved by this small cohort and should remain no demonstrated gain. These are measured complete-call ceilings, not deployed product gains or a theorem that every possible boxed emitter has this performance.

The custom NRT-managed object type actually compiles and passes JIT/AOT gates, including reverse operand unwind, input/output ownership, error propagation and fresh-process AOT import/success/error without importing Numba. Saved LLVM uses PyUnicode_FromString, native C-API lowering and wrapper cleanup on both status paths. The prior legacy-symbol crash and operand-order failure are retained red evidence. Thus unchanged types.pyobject rejection does not imply extension-interface objects are impossible in nopython/AOT. The package's unchanged old import fails, but its adapted reference-managed design works. Other two managed function cells are correctly unmeasured.

AOT-STATUS appropriately distinguishes installed pending pycc deprecation from removal, the vendored builder layer from installed compiler/runtime, and PIXIE's development release from a supported Windows/drop-in replacement. No source-reading claim is substituted for an unperformed trial build.

## Scope to retain in the user-facing bound

The C watcher context is configured once for process lifetime, under CPython 3.14/GIL assumptions. Dictionary mutations are sticky invalidations; nonempty captured gc.callbacks selects fallback, and changing gc module bindings invalidates the context. Type-version access remains unstable ABI. Ambient cyclic-finalizer scheduling, asynchronous signals/frame inspection, allocator-failure injection, general keyword/arity adaptation, module unload and subinterpreters remain unproved. The report explicitly discloses these obligations and does not generalize the diagnostic into product eligibility. This is sufficient for the requested backend decision evidence, not a completed production guard analysis.

Keep the estimated 548/655 syntactic reach separate from measured plain-njit 153/655 fixture coverage; overlapping counts must not be added. No production matrix verdict or function-native count changes from these experiments. The proposed implementation line counts are estimates, not measured delivery commitments. Fix malformed rendered sizing ranges such as '800?1500lines' before presenting the report, but this does not require another workload.

Only this independent review document was written.
