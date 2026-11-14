# Explicit integer modes and native coverage

Both opt-in modes remove integer arithmetic checks and produce native bodies close to matched C. Full Python calls still carry boundary costs: checked and unchecked take 12.021 and 11.576 µs on the long-loop corpus, versus CPython's 111.446 µs, saved strict's 11.887 µs and guarded C's 7.995–8.137 µs. That is 9.27× and 9.63× CPython, with little additional full-call gain over saved strict. On all four shorter kernels the modes remain slower than ordinary strict and CPython. The wrapper fix substantially reduces the first prototype's overhead; it does not make either mode a universal speed upgrade.

Python-compatible strict execution remains the default. The new modes require an explicit `recompyler.experimental` import and per-function contract. Final implementation: `954848ee312b0ef8cdac7f8292b10334e9ccacbf`; saved strict comparison: `1d4084f914fa9594ecb801e3efa565edcd7e1241`. The implementation and coverage branches are combined in the local `codex/integrated-coverage` branch. The original dirty checkout is preserved; nothing was pushed.

## What each mode removes

Checked mode proves every reached integer intermediate fits signed int64, then guards the declared input bounds before native execution. A miss runs the original Python function. Unchecked-int64 explicitly wraps every admitted addition, subtraction and multiplication modulo 2^64; invalid representation or unavailable native execution raises `NumericContractError` rather than switching arithmetic back to Python.

| Mechanism | Strict default | Checked | Unchecked-int64 |
| --- | --- | --- | --- |
| Addition/subtraction overflow helper | Retained | Replaced at certified sites | Replaced at admitted sites |
| Multiplication floating magnitude check | Retained | Removed at certified sites | Removed at admitted sites |
| Adjacent arithmetic status test | Retained | Removed with replaced helper | Removed with replaced helper |
| Exact-int entry requirement | Existing specialization/loader | Retained | Retained |
| Tight declared input bounds | No experimental contract | Guarded every call | Omitted; documentary |
| Separate wrapper int64 range check | Existing loader check | Implied by validated tight bounds; duplicate removed | Retained |
| Native scalar-loader type/range check | Retained | Retained | Retained |
| Experimental runtime loop cap | None | Implied by checked stop bounds/literal; duplicate removed | Retained: `max(0, stop) <= 1024` |
| Binding/current defaults | Ordinary behavior | Fast positional binding; general keyword path retained | Same binding, invalid calls reject without Python body replay |
| Code, builtin, loader and outer execution/status guards | Retained | Retained | Retained |
| Heap/index/alias/layout/recursion/float safeguards | Ordinary behavior | Unchanged; those operations are outside this pilot | Unchanged; no unsafe memory or float mode |

Strict addition/subtraction detect signed overflow using XOR/sign tests. Strict multiplication converts both operands to float and checks product magnitude against a conservative 9.2e18 threshold. Each strict source site also emits a caller status check. Across the five kernels, the modes replace **195 arithmetic helper sites and 195 adjacent status-test sites**: 98 additions and 97 multiplications. These are source sites, not surviving machine branches. Optimizers merge or remove some checks.

The intrinsic data operations make no `nsw`/`nuw` promise. Bounded loop induction instructions may independently acquire valid no-wrap flags; searching an entire LLVM file for those words does not audit wrapping data arithmetic. The complete source inventory and actual-code reviews are retained in the [evidence](2026-11-12-modes-evidence/validation/wave10-independent-review/check-inventory.md), with the final entry-guard changes in the [binding review](2026-11-12-modes-evidence/validation/wave10-independent-review/BINDING-REVIEW.md).

The supported pilot is scalar integer names/literals, assignments including parallel tuples, +/−/×, a terminal scalar return and at most one nonnested builtin `range(stop)` loop. Stop is a literal or unrebound entry parameter; proof work is capped at 1,024 iterations. Calls, recursion, heap/array operations, dynamic branching and other arithmetic are excluded from these opt-ins. Ordinary strict lifting retains its broader eligibility. See [the API and examples](../experimental-numeric.md).

## Complete Python calls

Each value below is microseconds per completed call: median of seven fresh-process child medians, with three fixed corpus passes per child. Inputs, source algorithms, contracts, checksums and repetition counts were fixed before timing. All measured values lie in the Python-equivalent contract. The C references use the same algorithms with `-O3 -march=x86-64`, separate translation units and no LTO; they are not hand-derived optimal algorithms. C complete calls include explicit Python guards and a foreign-function boundary, so they are distinct from direct C kernel execution.

| Kernel | CPython | Saved strict | Final strict | Checked | Unchecked | C exact | C wrap |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| recurrence_1 | 0.057 | 5.012 | 5.255 | 5.951 | 5.921 | 2.519 | 2.632 |
| recurrence_16 | 0.250 | 5.217 | 5.096 | 5.858 | 5.778 | 2.532 | 2.645 |
| recurrence_64 | 0.842 | 5.253 | 5.026 | 5.882 | 5.662 | 2.804 | 2.672 |
| fibonacci | 0.591 | 4.607 | 4.752 | 5.765 | 5.504 | 2.136 | 2.218 |
| loop_recurrence16 | 111.446 | 11.887 | 11.164 | 12.021 | 11.576 | 7.995 | 8.137 |

The final comparison contains 355 cells and 361 raw process records: preparation, separate invalid-input audits, 20 fresh AOT builds/replay audits, then 245 complete-call timing children. All RP timing calls use actual AOT and import no Numba. Source/corpus/C files match the first cohort byte for byte. [Final manifest](2026-11-12-modes-evidence/numeric-final/manifest.json), [raw summary](2026-11-12-modes-evidence/numeric-final/summary.json).

The first prototype, `a5d11d7`, was retained after measurement exposed a regression: checked complete calls took 9.944–22.949 µs versus the saved strict version's 4.600–10.986 µs on the corresponding Fibonacci/long-loop cases. It built an `inspect.Signature` every call. The final version uses canonical positional tuples and cached parameter/guard positions, while reading live defaults and retaining general keyword binding. Checked bounds also discharge redundant wrapper int64/cap tests. No prototype samples were pooled into the final table.

## Actual assembly and native execution

The following are static instructions in the **actual AOT internal bodies**, selected through successful runtime export addresses and wrapper call targets. Padding and Python wrappers are excluded. Counts do not measure cycles or dynamically executed instructions.

| Kernel | Saved strict AOT | Experimental AOT | Matching C |
| --- | ---: | ---: | ---: |
| 16-step recurrence | 214 | 34 | 33 |
| Fibonacci | 23 | 17 | 35 |
| Loop with sixteen recurrence steps | 228 | 41 | 38 |

For the recurrence, the extra experimental instruction stores the result through Numba's result pointer. The long-loop difference adds argument/result handling and a different loop counter form. Fibonacci's smaller AOT body is a scalar loop; C unrolls it. Small static size alone does not establish higher speed. [AOT bindings and exact ranges](2026-11-12-modes-evidence/validation/wave10-independent-review/AOT-CODE-REVIEW.md).

Final selected-code comparison verifies all 20 AOT bodies and ten actual C exports have equal normalized instruction operands, opcode counts and closed control-flow graphs to the prototype. Runtime wrapper RVAs and direct call targets select the bodies; RIP-relative constants are compared as actual bytes. The final binding/configuration changes therefore leave these arithmetic bodies unchanged. Earlier native timings remain explicitly labelled with their original source; none were retagged as final measurements. [Body-equivalence record](2026-11-12-modes-evidence/numeric-final/native-code-equivalence.json).

The earlier, separately labelled prevalidated native batch measured the long loop at 5.159 µs per adapter invocation for checked, 5.158 µs unchecked, 5.591 µs saved strict, 5.221 µs C exact and 5.141 µs C wrap. Fibonacci measured 4.975/4.996 ns for the experimental adapters versus 19.170 ns saved strict and 3.779/3.730 ns C. These are corpus throughput measurements through an external C loop, not complete Python-call latency or final-source timing rows.

Those batches call linked selected JIT code through adapters. Experimental recurrence bodies inline where strict bodies retain native calls; timed Fibonacci adapters unroll differently from both AOT and JIT preflight. Consequently their speed differences include ABI, inlining and loop optimization. Region counters do not count these calls; the C loop independently recorded 241,153,920 invocations with zero status failures. Actual AOT and adapter identities are kept separate in the [code review](2026-11-12-modes-evidence/validation/wave10-independent-review/actual-code-review.md).

## General Python coverage

Three strict mechanisms were added without workload-name rules or lowered thresholds: guarded integer-tagged mixed list indices, class/MRO dispatch for callable objects stored in locals/containers/fields, and transaction rollback before observable builtin print statements. Type distinctions, receiver evaluation order, aliases, rebinding and effects remain guarded. Global callable-object names remain outside this bounded addition.

The fresh coverage comparison uses the unchanged chaos program at its original two repetitions and a separately declared 32-repetition diagnostic. Both use ordinary default selection and fresh-process deployment audits.

| Population | Saved strict actual native | Candidate actual native | Candidate process speed vs CPython |
| --- | --- | --- | ---: |
| Original short chaos case | None | None | 0.980× |
| Separate extended32 diagnostic | None | 32 AOT calls per run | 3.672× |

All five extended timing children and five separate audits completed 32 AOT calls each, zero JIT/fallback/unknown calls. The original short case remains unselected because startup exceeds savings. This is one original held-out subset case plus a separate longer diagnostic; the full historical 38-program denominator was not rerun or increased. [Coverage summary](2026-11-12-modes-evidence/coverage/summary.json).

The coverage cohort measured `a5d11d7`; final changes affect only the explicitly imported experimental module, its tests and documentation. Strict runtime/compiler files match byte for byte. Separate state diagnostics verify original None return, final RNG state, complete input graph/type/alias equivalence and input identities. A derived function adding `return im` verifies all 256×256 pixels. Each fresh AOT state call recorded three arena-growth retries and one successful completion, with exact final state and no compiler import. These diagnostics are separate from timing and default coverage counts.

## Correctness and reproducibility

Final product suite: **715 passed, 100 subtests passed, 22 warnings in 349.64 seconds**. All 65 tracked source/test/document/license inputs plus two native support binaries stayed unchanged. The warnings are the existing GPU occupancy and Numba IR-assumption warnings. The prototype full run additionally collected four archived protocol controls; its reported count is not the final product count.

Reviews reproduced and fixed source/proof drift, unchecked binding replay and real `inspect.Parameter.empty` defaults. A later review reproduced checked overflow caused by a contract subclass presenting different proof/guard bounds. Explicit modes now require an exact immutable `IntIntervals` object and exact string names before any configuration hooks. The default Python execution path is unaffected. RED/GREEN logs, source maps, native hashes and independent verification receipts are included in the [archive manifest](2026-11-12-modes-evidence/archive-manifest.json).

Mode/source/contract/proof implementation and native ABI identities are sealed into separate explicit AOT manifests. Wrong modes, bounds, source or binary hashes are rejected before native import. Strict builders cannot restore unchecked arithmetic through type-only seeds. Failed measurement setup attempts remain separate from successful cohorts; no dependency or shared compiler installation was changed.

## Generalizing the result

The useful pattern is to prove or guard assumptions at a region boundary, keep native representations through substantial computation, and retain Python replay for checked misses. Tests alone cannot prove that future integers fit, defaults stay fixed or objects keep their layout. Unchecked wrapping is an explicit arithmetic contract, not a universal removal of Python errors.

The next speed target is boundary work and larger fused regions; integer body checks are already close to C in these kernels. The next proof target is symbolic loop invariants and call-graph facts beyond enumerating bounded iterations. For coverage, saved evidence ranks first-class range values highest: 21 recorded decline rows across seven programs, with duplicated caller reports and additional blockers explicitly identified. Returned-iterable consumers and exact bigint/Decimal/Fraction paths need separate representations and semantics. [Coverage priorities and evidence](2026-11-12-modes-evidence/validation/coverage/COVERAGE-NEXT.md).
