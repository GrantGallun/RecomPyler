# Function/cell and native local-helper result

Canonical ownership interfaces are correctness-validated. The broader function/visitor capability is explicitly UNACCEPTED: three source-frame cases remain strict expected failures, and every measured case is slower than CPython. No default deployment is enabled.

## Measured six-case comparison

One short TIMING.lock acquisition, released successfully; raw `s67-family-final-timing.log`. Measurements include the source-ordered owner and callback guard corrections, before the dependency-light extraction and final shared native_frame/context-view integration. They are descriptive pre-integration prototype numbers, not a latency acceptance result for the final hook revision. The process scan recorded no matching workspace commands before/after; this is the scan's observation, not a proof of globally idle hardware.

| Case | CPython us | Plain parent us | Native family us | Native / CPython | Source dispatch / entry | All shared dispatch / entry |
|---|---:|---:|---:|---:|---:|---:|
| _local_names | 6.871 | 20.022 | 424.393 | 61.76x | 23 | 23 |
| closure_in_loop | 0.876 | 43.870 | 32.967 | 37.62x | 32 | 64 |
| ast_walk_loop | 3.833 | 23.873 | 23.847 | 6.22x | 16 | 16 |
| two_helpers | 2.001 | 49.740 | 38.712 | 19.35x | 0 | 0 |
| list_recursion | 0.485 | 8.805 | 25.875 | 53.36x | 0 | 0 |
| captured_list_counter | 3.267 | 11.937 | 12.022 | 3.68x | 1 | 1 |

These are shared dispatcher counters, including formerly counted=False calls. They do not instrument every Python method invoked inside a custom mapping protocol. The two_helpers native common path uses the exact source-data dict and direct Add/append; its zero count is not obtained by moving arithmetic to an uncounted dispatcher. closure_in_loop still dispatches 32 Multiply and 32 InPlaceAdd operations. _local_names still dispatches the AST iterator 23 times. The AST walk and captured-counter parents still invoke managed operations/helpers. Native local-call counters alone are not speed progress: _local_names is 21.20x slower than its plain parent and list recursion is 2.94x slower.

## Implementation and exactness

Original nested CodeType/default tuple/keyword-name owners and real closure cells are preserved. Generator construction uses original code, eager outer iteration and lazy original inner execution. Native visitors use source locals, direct cell operations, nonescaping helper catalogues, transitive captured cells, dependency-ordered compilation, and inlined nonrecursive children. Actual CPython helper function objects are still created to preserve recursive closure cycles. Source locals and cells have one ordered owner; native root SSA mirrors its current values into that owner.

Unknown global callback protocols and custom AST hash/equality cannot invalidate pooled class/recursion assumptions. The general backend preserves their actual behavior; native admission refuses unproved protocols. Direct cell errors use captured interpreter exception classes after builtins rebinding. Active original functions stay pinned through return/error. Temporary recursive preparation closures no longer retain source functions until GC.

## Validation and limits

The one combined four-worker below-normal full gate: 3430 passed, 131 subtests, four expected xfails, zero skips/failures, all four exits zero (`native-family-suite-{0,1,2,3}.log`). One model review: `review-managed-data-pool.md`; one family review: `review-function-visitor-family.md`. Its two executable cleanup findings and the analogous native SSA case were corrected. Shared operation review remains the provider's single review; its concrete flags/unpack/builtin-authentication corrections were consumed with focused tests.

Precommit ten-minute-mode seed76201 exhausted 51 subjects: 2039 native, 13 declined, 99 resource-filtered, 15 fixture-unavailable, zero findings. Earlier final family76001:6868 native/zero findings; post-root76101:2039 native/zero findings. Exclusions are not passes. Matrix-backed experimental call seed75901:18 base rows/54 subjects,1962 native/zero findings;15 base rows had native checked inputs, call.star/call.double_star were construction declines and call.varkw declined. This does not move ordinary default matrix rows.

Post-full concrete fixes used focused checks only under S58: callback admission39pass; active-function/dispatch14pass; preparation/provenance42pass plus3 strict frame xfails; shared operation complements13pass plus the corrected clone-local3pass; shared owner extraction35pass. The root-location builtin-authentication subprocess attempt failed PYTHONPATH and is excluded. The old pointer-only method patch and superseded flags-only patch are excluded as final provider evidence; the reviewed provider is the final source. Builtin cell error classes have a separate red-to-green check.

Three literal source-frame failures are not passing evidence: error traceback retention, successful callback traceback retention, and callback f_back code identity (`s68-source-frames-red.log`, `tests/test_managed_frame_owners.py`). They require the shared activation design in `SOURCE-FRAME-ACTIVATION-DESIGN.md`. A source owner mapping is not a PyFrameObject. No exact callback-frame or competitive-speed acceptance is claimed.

The postcommit refresh on exported9419f8ec source completed:1026rows254native772declined0wrong/crash;196captured60verified60/375whole-native0deployed,365observed definitions. These counts are unchanged from the prior accepted baseline. Raw parent completion is native-family-postcommit.log; all program children exited0. No timing/deployment selection was performed. Captured-not-native136 functions remain in the normalized first-failure ranking; uncaptured definitions stay non-native in the fixed375 denominator.

| First failure | Functions | Programs |
|---|---:|---:|
| the compiled version did not apply to the captured calls | 18 | 9 |
| local functions/closure or unsupported signature | 17 | 7 |
| outside the supported subset: global 'pyperf' is not a numeric constant | 17 | 6 |
| outside the supported subset: keyword or starred argument at line 3 | 9 | 2 |
| outside the supported subset: global 'strings' is not a numeric constant | 5 | 2 |
| outside the supported subset: global 'subcount' is not a numeric constant | 5 | 1 |
| outside the supported subset: constant None at line 2 | 4 | 2 |
| outside the supported subset: global 'regexs' is not a numeric constant | 4 | 2 |
| outside the supported subset: call at line 2 | 3 | 2 |
| comparison rule: snapshot rule: class not proven pure Python (extension or dynamic type) | 2 | 2 |

Detailed source rows: native-family-first-failures.json. The final shared ordered frame/context integration passes40focused checks; exact cell exception rebinding passes18plus3known frame xfails; final owned complement48plus3known frame xfails. The activation query is fail-closed by contract; it is not a real source-frame implementation. The experimental API is separate from automatic deployment.
