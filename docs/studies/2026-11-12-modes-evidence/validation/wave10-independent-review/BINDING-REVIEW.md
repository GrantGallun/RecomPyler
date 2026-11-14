# Independent binding and proof-closure review

**Source review: CLEAR** at `954848ee312b0ef8cdac7f8292b10334e9ccacbf` in `wave10-binding`. No actionable finding remains from this review. This is a source/proof review, not a claim that the full suite or final native-artifact comparison has completed.

Frozen source identities recorded in `wave10-binding-analysis/after-contract-fix-input-map.json`:

| File | SHA256 |
| --- | --- |
| `src/recompyler/experimental.py` | `6e8ef5a8abd00b7ce2f8f91950a67aa231b00b51eeb732301cad579427053cd8` |
| `src/recompyler/heap.py` | `24f3d93ba9df6f6f8bb065bad013af5973a051d633e589b421a2a45de7db80a8` |

## Binding and guard conclusions

The fast path accepts only an exact positional tuple, no keyword-only parameters, and either `kwargs=None` or an exact empty dict. Fixed-parameter eligibility already excludes varargs/kwargs functions. It computes missing arguments from the guarded code's positional count, rejects excess arguments or insufficient defaults, and uses the current trailing defaults on every call. Base `tuple.__len__` and `tuple.__getitem__` operations bypass defaults-subclass hooks; oversized default tuples correctly contribute only the needed trailing values. The supplied argument tuple cannot override concatenation because the fast-path type is exact.

Real `inspect.Parameter.empty` defaults remain actual default values, not missing arguments. Positional-only calls are valid on this path; keyword calls, keyword-only functions and other direct-attempt containers retain the general binder. Changed defaults are read anew, including keyword-default mutations in the general path. Code identity and custom signature/wrapper metadata guards run before cached parameter positions are used. Checked binding/contract misses return to ordinary Python through the existing wrapper; unchecked misses reject without executing the original body.

For checked mode, the exact-int tight interval guard implies int64 representation because configuration validates every interval within signed int64. The same guarded stop interval, or the validated literal, implies the construction-time maximum of 1024 positive loop trips. Therefore removing the separate checked wrapper int64 comparison and loop-cap test is sound. The scalar loader's int64 check remains. Unchecked tight intervals are documentary, so its explicit int64 and operational loop-cap guards remain mandatory and are retained.

## Resolved contract-subclass blocker

The first cached-guard implementation read private `_items`, while proof analysis used mapping access. An accepted `IntIntervals` subclass could return narrow bounds from `__getitem__` while storing wider bounds in `_items`. For checked `x*x`, that proved `x` in [-1,1] but admitted `x=2**32`, causing native wrapping zero instead of Python `2**64`.

This was reproduced by the implementation agent: [red-contract-subclass.txt](/D:/Code/Datathon/recompyler-codex-20261111/wave10-binding-analysis/red-contract-subclass.txt) records `AssertionError: 0 != 18446744073709551616`. Final `lift_numeric` rejects nonexact `IntIntervals` instances before proof/mapping access; `load_numeric` routes through that same entry. Configuration also rejects nonexact string parameter names before identifier hooks. Thus proof input, cached guard bounds and policy metadata share the same immutable exact configuration representation. The fix does not rely on subclass methods honoring an informal contract.

The final three regressions cover the divergent-bound case, rejection in both modes before mapping hooks execute, and rejection of string-subclass names before identifier hooks. The reviewer confirmed that the final fix adds only the expected exact-name check and exact-contract restriction relative to the previously reviewed binding change.

## Evidence and remaining verification

The implementation receipt [CONTRACT-CLOSURE-RECEIPT.json](/D:/Code/Datathon/recompyler-codex-20261111/wave10-binding-analysis/CONTRACT-CLOSURE-RECEIPT.json) records the actual subclass failure, the separate name-key failure, three passing closure regressions, and a focused union of 116 passing tests with 48 subtests in 9.84 seconds. These are the implementation agent's recorded executions, not tests rerun by this reviewer.

Source comparison confirms that arithmetic intrinsics, interval-analysis implementation, policy lowering and all of `heap.py` are unchanged by the binding optimization. The remaining change is Python binding/guard work and exact configuration closure. This establishes unchanged lowering source, **not yet equality of final generated IR, native bytes or artifact identities**: the experimental implementation hash participates in policy identity, so final identities legitimately change.

At this review checkpoint the full suite is running under another owner, and final-source native-body equivalence metadata remains pending. Both must be reported from their own receipts before claiming full verification or transferring prototype assembly conclusions to final artifacts. Earlier prototype timing and AOT/JIT/adapter reviews remain explicitly prototype evidence.

Review work used source and existing receipt reads only. No product imports, tests, compilation, profiling, benchmark workloads or product edits were performed.
