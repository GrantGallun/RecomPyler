# Wave 10 source-level check inventory

Reviewed combined commit `a5d11d7745da8d324e46e544f929849c0598cddd`. This inventory is derived from source inspection only. No product imports, source generation, tests, compilation, profiling, LLVM inspection or assembly inspection were performed for this deliverable. The two product files matched the working-tree commit when inspected.

| Input | SHA256 of inspected bytes |
| --- | --- |
| `wave10-combined/src/recompyler/heap.py` | `24f3d93ba9df6f6f8bb065bad013af5973a051d633e589b421a2a45de7db80a8` |
| `wave10-combined/src/recompyler/experimental.py` | `c681942f89604e42708e20fac650baa7813f2be9c1f9b8164a463e135035e3b5` |
| `wave10-measurements/prepare.py` | `fc07a2f8f09e18d3a0ce649876150396515a317a6e5004e362bfee432f7e4d37` |

## Arithmetic checks: precise source comparison

The table applies to scalar `INT/INT` addition, subtraction and multiplication sites admitted by the experimental grammar. Ordinary strict behavior remains the default. Checked lowering requires a certificate matching the AST span and operation; unchecked lowering requires an admitted site. Other strict operations and types keep their existing lowering.

| Mechanism | Strict | Checked | Unchecked-int64 |
| --- | --- | --- | --- |
| Addition | Calls `add_i(st, a, b)` | Calls `_numeric_add(a, b)` at a certified site | Calls `_numeric_add(a, b)` at an admitted site |
| Addition helper overflow detection | Computes `r=a+b`; tests `((a ^ r) & (b ^ r)) < 0`; conditionally sets `st[0]=1`; returns `r` | Entire helper call bypassed, including its two XORs, AND, sign comparison and conditional status write | Same bypass |
| Subtraction | Calls `sub_i(st, a, b)` | Calls `_numeric_sub(a, b)` at a certified site | Calls `_numeric_sub(a, b)` at an admitted site |
| Subtraction helper overflow detection | Computes `r=a-b`; tests `((a ^ b) & (a ^ r)) < 0`; conditionally sets `st[0]=1`; returns `r` | Entire helper call bypassed, including its two XORs, AND, sign comparison and conditional status write | Same bypass |
| Multiplication | Calls `mul_i(st, a, b)` | Calls `_numeric_mul(a, b)` at a certified site | Calls `_numeric_mul(a, b)` at an admitted site |
| Multiplication helper magnitude check | Computes `float(a)*float(b)`; tests `estimate >= 9.2e18 or estimate <= -9.2e18`; on failure sets `st[0]=1` and returns zero; otherwise returns `a*b` | Entire helper call bypassed: two integer-to-float conversions, floating multiplication, two threshold comparisons, short-circuit OR and failure branch/status write | Same bypass |
| Caller status test after each arithmetic helper | Emits `if st[0]: return <dummy result>` immediately after the helper call | Not emitted at replaced site | Not emitted at replaced site |
| Integer operation emitted by intrinsic | Not selected | LLVM `add`, `sub` or `mul`, `flags=()` | LLVM `add`, `sub` or `mul`, `flags=()` |
| Meaning of overflow | Status causes ordinary Python replay | Host interval proof plus entry guards establishes that the operation cannot overflow for admitted calls | Overflow is deliberately signed modulo 2^64; no Python-arithmetic replay |
| Intrinsic typing restriction | Not applicable | Integer operands, signature `int64(int64,int64)` | Same |

Strict multiplication uses a conservative floating magnitude threshold, not an exact full-int64 product-overflow test. It can replay a mathematically representable product near the int64 endpoints. Checked mode can admit such a product when the interval proof establishes safety. Both policies use the same wrapping intrinsic implementation; checked mode's equivalence to Python comes from its proof and guards, not from different LLVM flags. Empty flags mean the intrinsic does not add `nsw` or `nuw` promises; this is not a claim about every instruction after optimization.

Evidence: [strict helpers, heap.py:1998](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:1998), [caller status emitter, heap.py:3661](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:3661), [policy selection, heap.py:3843](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:3843), [intrinsics, experimental.py:34](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/experimental.py:34), [site authorization, experimental.py:314](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/experimental.py:314).

## Entry and execution checks

| Check or behavior | Strict | Checked | Unchecked-int64 |
| --- | --- | --- | --- |
| Argument binding and current defaults | Existing ordinary binding; simple positional path checks argument count and fills defaults; keyword/keyword-only path uses ordinary binder | Code-based fixed-parameter signature is rebound every call; current positional/keyword defaults read; annotations are not evaluated; real `inspect.Parameter.empty` defaults retain presence | Same experimental binder |
| Binding failure | Ordinary Python replay, which produces Python's binding error | Same replay behavior | `NumericContractError`, without calling original body |
| Exact entry type | Existing specialization/type loader; strict mode may separately support bool/float/etc. | Every parameter must be exact Python `int` before native entry; otherwise replay | Every parameter must be exact Python `int`; otherwise reject |
| Signed int64 representation | Integer specialization seeding and scalar loader reject out-of-range ints; ordinary replay | Explicit wrapper bound `INT_MIN <= value <= INT_MAX`, plus unchanged scalar loader check | Same wrapper and loader checks; reject rather than replay |
| Tight declared interval | No experimental interval check | Per-parameter inclusive lower/upper guard; miss replays Python | Omitted; tight intervals are documentary, not runtime restrictions |
| Construction-time intermediate proof | No experimental interval proof | Arbitrary-precision host interval arithmetic checks every reached intermediate; unions per-site facts across loop iterations; parallel assignment uses preassignment environment | No no-overflow certificate required; structural eligibility still checked |
| Construction-time loop bound | No experimental 1024 cap | One nonnested builtin `range(stop)` loop; contract/literal maximum positive trip count must be <=1024 | Same construction cap applies to supplied contract/literal, despite tight runtime intervals being documentary |
| Runtime loop cap | No new 1024 check | Explicit `max(0, stop) > 1024` rejection test remains even when implied by checked interval | Explicit `max(0, stop) > 1024` rejection test remains and is essential; negative stop means zero trips |
| Code and binding-metadata guard | Existing ordinary guards | Wrapper checks original code identity and disallows custom `__signature__`/`__wrapped__` metadata | Same; reject on failure |
| Proof-to-source integrity | No experimental proof identity | Fresh `_Program` source/code hash must equal certified origin before signed-literal normalization | Same identity check |
| Builtin `range` identity | Existing builtin lookup and per-call guard where used | Retained; construction also requires actual unshadowed builtin | Retained |
| Reused program / direct `attempt` | Existing guards | Entry guards execute before inherited `attempt`; only then `_bound_entry=True` avoids duplicate binding | Same; direct `attempt` does not bypass contract/type/cap guards |
| Scalar loader type/range checks | Retained | Retained, despite wrapper checks | Retained |
| Program guard dispatch before native call | Retained | Retained | Retained |
| Heap arena allocation/capacity handling in executor | Retained | Retained | Retained |
| Outer status initialization/inspection | `st[0]=0` before run; executor inspects status, handles growth/status failure afterward | Retained; removal is only the selected per-arithmetic helper/status pairs | Retained |
| Generic generated `fail` / status machinery | Retained | Retained; no global deletion or replacement | Retained |
| Unbound-local status guards | Existing flow analysis and `bound_check` | Not globally removed; checked proof also rejects reads not definitely bound over allowed exits | Not globally removed; status failure rejects rather than switching to Python arithmetic |
| Native compilation/execution/guard failure | Ordinary Python replay | Ordinary Python replay through inherited executor behavior | Converts failure to `NumericContractError`; no ordinary arithmetic fallback |
| `RecursionError` fallback behavior | Existing wrapper may replay Python | Inherited checked behavior | Own call wrapper converts to `NumericContractError` |
| Heap, arrays, aliasing, layout, indexing and capacity checks | Existing strict eligibility and guards remain | Pilot excludes heap/array operations; no corresponding checks disabled | Same exclusion; no unsafe memory mode enabled |
| Recursive calls / depth checks | Existing strict support and guards | Recursion/calls excluded by pilot; general executor still prepares depth budget | Same exclusion; no recursion check disabled |
| Floats, division, other operators and fastmath | Existing strict behavior | Excluded by pilot; unchanged globally | Same exclusion; no global float/error policy change |
| AOT isolation | Existing strict builder/loader | Separate explicit policy-tagged builder/loader; full policy/source/ABI/binary validation | Same explicit isolation; strict builder skips experimental wrappers |

For these scalar kernels `_Loader.argument` reaches `_Loader.scalar(INT, value)`. This is a Python scalar-loader path; do not describe the kernels as exercising the native C object/list bulk loader. The wrapper's explicit type/int64 checks do not remove that second scalar validation. The executor still prepares heap arrays, status and depth information even though the kernel grammar itself contains no object/array accesses or recursive calls.

Evidence: [experimental binding, experimental.py:127](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/experimental.py:127), [proof and loop analysis, experimental.py:169](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/experimental.py:169), [source identity, experimental.py:385](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/experimental.py:385), [per-call guards, experimental.py:414](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/experimental.py:414), [scalar loader, heap.py:6129](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:6129), [argument loading, heap.py:6388](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:6388), [executor, heap.py:6905](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:6905), [generic failure, heap.py:3650](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:3650), [unbound guard, heap.py:3750](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:3750), [recursive depth check, heap.py:4714](/D:/Code/Datathon/recompyler-codex-20261111/wave10-combined/src/recompyler/heap.py:4714).

## Five planned kernels: static arithmetic-site counts

The corpus producer [prepare.py](/D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/prepare.py) constructs three straight-line recurrences, Fibonacci and a loop containing sixteen recurrence steps. Counts below are exact counts of arithmetic expression sites in those source templates, excluding loop control, assignments, guards and helper internals. Subtraction is supported but is not exercised by these five kernels.

| Kernel | Parameters | Add sites | Sub sites | Mul sites | Total arithmetic sites | Runtime source-operation evaluations per completed call |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| `recurrence_1` | 3 | 1 | 0 | 1 | 2 | 2 |
| `recurrence_16` | 3 | 16 | 0 | 16 | 32 | 32 |
| `recurrence_64` | 3 | 64 | 0 | 64 | 128 | 128 |
| `fibonacci` | 1 | 1 | 0 | 0 | 1 | `max(0,n)`; checked corpus maximum 80 |
| `loop_recurrence16` | 4 | 16 | 0 | 16 | 32 | `32*max(0,n)`; checked corpus maximum 32768 |
| Sum of distinct source sites across five kernels | — | 98 | 0 | 97 | 195 | Not a dynamic total |

For Fibonacci, tuple reassignment evaluates `a+b` against the old `a,b`; returning `a` does not eliminate the source addition that assigns the next `b`. At checked `n=80`, the final next-value intermediate is F81 = 37889062373143906. This table counts language-level source evaluation, not optimizer-retained operations.

## Generated-source lowering counts versus optimized code

The next table is a source-emitter deduction for the all-exact-int specialization, with every listed arithmetic site certified/admitted. It is not an observation from generated artifacts. Each strict site emits one corresponding helper call and one caller `if st[0]` test. Each experimental site emits one intrinsic call and neither that strict helper call nor its adjacent status test. Loop body sites are counted once, not multiplied by trip count.

| Kernel | Strict helper-call sites | Strict adjacent status-test sites | Checked intrinsic-call sites | Unchecked intrinsic-call sites | Adjacent status-test sites omitted per experimental version |
| --- | ---: | ---: | ---: | ---: | ---: |
| `recurrence_1` | 2 | 2 | 2 | 2 | 2 |
| `recurrence_16` | 32 | 32 | 32 | 32 | 32 |
| `recurrence_64` | 128 | 128 | 128 | 128 | 128 |
| `fibonacci` | 1 | 1 | 1 | 1 | 1 |
| `loop_recurrence16` | 32 | 32 | 32 | 32 | 32 |
| Sum across five kernels | 195 | 195 | 195 | 195 | 195 |

The 195 replaced strict helper-call sites comprise 98 calls to `add_i` and 97 calls to `mul_i`; no `sub_i` call sites occur in this corpus. Each helper also contains its own conditional overflow/magnitude test. Counting one instantiated helper conditional plus one caller conditional per source site gives 390 source-level conditional occurrences before considering optimization, but this is not 390 machine branches. In particular, multiplication's one conditional expression contains two threshold comparisons. Runtime helper definitions are shared source declarations, not 195 separately declared helper functions; the generated module continues to include the strict runtime helpers even when the entry function no longer calls them at these sites.

The recurrence contracts use B=2^20, x,z in [-B,B], y in [-1,1]. After S recurrence steps, conservative interval magnitude is at most (S+1)B. Consequently the planned checked maximum final bounds are 2097152 (`recurrence_1`), 17825792 (`recurrence_16`), 68157440 (`recurrence_64`) and 17180917760 (`loop_recurrence16` at 1024 trips and 16384 steps). Multiplication intermediates are no larger than the preceding accumulator magnitude. These are arithmetic derivations from the template and contract, not reported runtime proof outputs.

Optimized LLVM/assembly instruction counts, actual helper inlining, branch elimination, loop unrolling, vectorization, dependency-chain transformations and executed hardware counters are **not measured here**. Compiler optimization may remove, combine or transform source operations and checks. The exact emitted artifact and selected native export must be inspected separately. Neither the 195 replaced sites nor the 390 source-level conditional occurrences imply a cycle saving or a speedup. Complete-call timings must include the retained binding, guards, loader and executor; prevalidated native-body timings must be labeled separately.
