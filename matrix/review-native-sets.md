# Independent review: native-set capability

Final reviewed scope: S40 non-escaping native working sets, superseding the earlier cached-integer, finite-table-order and escaping-tuple variants. Reviewer: Codex review_native_sets, 2026-11-14. Reviewed against edbd8bd: root language-matrix brief, S38 and full S40, SET-DESIGN.md, STEP3-PLAN.md, lift.py diff, native-set tests and ordinary AOT paths. This is the same single capability review throughout. Only this review artifact was edited by the reviewer; no tests, builds, suites, profiles or timing were executed by the reviewer.

## Current assessment

**No remaining concrete wrong-result defect found in the S40 scalar-only slice.** Native Set values may remain private working values, but no Set-bearing result may cross the boundary. Recursive detection covers Optional, tuples (including represented records), and lists. Set-bearing stores and unknown call arguments decline; the typed use allowlist admits only recognized order-independent operations. Iterators and sequence-conversion consumers decline. Reflected input mutators and pop remain excluded.

The implementation is a useful conservative initial slice rather than an unsound representation shortcut. Exact signed-int64 elements remove callback and mixed numeric equality hazards. Input sets are detached copies before preparation. Local displays and local non-reflected mutators use the existing checked integer path, and the local-source walk rejects bigint, subclass and callback-capable input graphs. No set element, table, selected owner or mutable result escapes, so canonical singleton identity, finite key universes and CPython table-version guards are unnecessary and have been removed. Empty input sets still decline. Float/bool element domains and float reductions remain outside this slice.

Calls inspect Set-bearing arguments recursively; stores inspect Set-bearing values. A list or record containing a Set is not an exemption. Unknown calls, list mutation helpers carrying Set values, attribute stores and subscript stores are excluded rather than assuming the receiver is private. Known inlined helpers remain admissible only when their resulting typed operations satisfy the same certificate. The planned explicit operand-type checks on the library-helper whitelist should be retained so the certificate does not rely solely on each polymorphic picker's separate rejection logic.

The remaining diagnostic detail sent to the coordinator is direct `for x in set_arg`: indexed loop lowering can fail Numba typing before the inferred-type observation checks run. `_prepare` historically returned False without a problem string for that compiler-error path. Require a named decline for this recognized forbidden set use; this is an acceptance/diagnostic issue, not an observed wrong result or a request to expand the representation.

## Previous findings and their disposition

- **Confirmed internal traversal wrongs:** list(set_arg) and set list comprehensions produced different list orders; `step3-sets-review-red-v1` reproduced both. The final use certificate rejects native traversal and conversion consumers. Existing witnesses now run Python and preserve order.
- **Selected-owner identity:** reflected=True was not a freshness proof. Direct, conditional, nested aggregate and polymorphic record-field returns required real ownership analysis. Final S40 does not box any native Set return, so these paths decline with Python preserving identity and aliases. The temporary SSA freshness/tuple disjointness analysis was removed.
- **Confirmed Optional alias wrong:** a None argument allowed Optional[Set] through the first escape detector. Recursive Optional detection now routes such returns to the same prohibition; the direct and tuple Optional witnesses preserve selected identity through Python.
- **Confirmed escaped-order wrongs:** external list/repr/pop exposed three differences despite unordered set equality passing. The finite0..7 workaround established only immediate traversal equivalence. It did not preserve later caller mutation behavior: copy pre-sizing and local deletion history differ from fresh boxing. The final total native-Set escape prohibition closes both immediate and future-mutation defects. The finite domain, version pin and exhaustive256-subset tests were removed from product as S40 requests; the concrete order/contextual witnesses remain as regressions.
- **Preparation and replay:** detached exact-int input sets and private local sets prevent speculative mutations or hash/equality callbacks on application sets. The missing-element witness checks KeyError and once-only copied-list effects. Unsupported subclasses choose original Python and execute their operator once.

## Evidence inspected

The coordinator owns and executed all locked runs. Read receipts and test sources establish:

- `step3-sets-scalar-green-v1`: exit0, 41 passed / 2 expected-fails.
- `step3-sets-scalar-aot-v1`: exit0, 42 passed / 2 expected-fails. Tests perform ordinary monitoring/capture and verification, real AOT builds of input-set algebra-to-scalar, local sets-to-scalar and a tuple of scalar outputs, reload, bigint guard misses, unchanged original set contents, and fresh-process native calls without importing Numba.
- The two strict expected-fails retain the future managed escaping-owner/element-provenance and mutable input ownership capabilities as open work. They are not asserted native support.

The AOT wrapper inherits input packing and guards, and exports only verified scalar-result signatures. Final S40 no longer needs a new Set boxer, startup change or write-back path. Returning native working sets is reserved for the managed CPython-owner design and S38.4's performance gate; it is not implicitly accepted by the matrix's unordered set oracle.

## Acceptance status

Independent safety review is complete for the final S40 non-escaping scope, subject to the coordinator's final typed-helper/name-decline follow-through and locked regression run on the final source. No additional representation variants or reviewer executions are requested. Product acceptance still requires the pinned matrix with no new wrong/crash, union suite, converted-row counts, whole-function held-out native/captured/verified/deployed accounting and next first failures. Focused success and candidate row counts do not substitute for those gates. No speed claim or coverage-capability timing is asserted here.

## P4 held-out collector audit before the full cohort

Read-only review of matrix/heldout_native.py and heldout_compare.py, plus the smoke receipt. `step3-sets-heldout-smoke-v1` completed successfully for json_loads and meteor_contest, before and after. Counts are based on actual own-source definitions and complete-call candidate replay, not AST support guesses. Whole-region candidates are valid whole-body attempts here; engine=region is not a partial-region count. The fixed375-definition denominator includes unobserved/excluded definitions, which must never be inferred native. Deployment is explicitly not performed, so deployed0 is an activity statement rather than a measured selection result.

Found and sent a count qualification before the full run: test_lifted snapshots compiled_samples/fallback_samples before its extra rare-call checks, and region extra checks likewise do not contribute those counts. A function that falls back on a retained rare shape could therefore be counted native by the collector's original predicate. The coordinator's proposed fix is valid: pass retained uniform and rare inputs together as the ordinary test_candidate input list, with extra=(), so all retained complete calls contribute to native/fallback classification inside existing verifier/reset wrappers. Label the resulting count as observed retained calls/shapes, not every dynamic call. Any recommendation remains diagnostic because this changes sample weighting and no deployment is performed.

Also sent three cheap reporting/sealing checks: call stdout/stderr equivalence specifically capture-monitor on/off (it is not a compiled-runner on/off run); assert workload source hashes against the input manifest and between before/after; reject or deduplicate repeated --programs entries before summing populations. Baseline source snapshot hashes and per-attempt complete-file result hashes are already checked. No further executable probes or product changes were requested by this collector audit.

The final source now includes the explicit typed-helper call certificate and named set compile-error fallback discussed above. Those earlier follow-through items are closed by inspection; final locked focused/matrix/union/cohort evidence remains the coordinator's acceptance gate.
