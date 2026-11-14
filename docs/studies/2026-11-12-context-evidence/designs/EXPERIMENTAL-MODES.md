# Two experimental numeric modes: bounded pilot proposal

The user has authorized trying both checked contracts and an explicit unchecked mode. This document specifies a separate pilot after the strict recursive-context work and saved measurements. No experimental mode, production change, test, Numba import, build, profile or benchmark has been executed for this document. The context candidate remains unchanged except for its test draft.

## Practical first pilot

Implement exact-Python-int, straight-line scalar `+`, `-` and `*` regions, with an explicit per-parameter interval contract. Compare strict compilation, checked interval proof and explicit wrapping-int64 execution on the same source. For example:

```python
def mul_add(x, y, z):
    return x * y + z
```

Contract: `type(x) is type(y) is type(z) is int`, each in `[-2**20, 2**20]`. Host-side arbitrary-precision interval arithmetic proves every multiplication result in `[-2**40,2**40]` and final addition in `[-2**40-2**20,2**40+2**20]`, strictly inside signed int64. The checked path can omit the existing multiplication/addition overflow tests while preserving arbitrary Python behavior through entry fallback. The unchecked path intentionally computes signed two's-complement modulo-2**64 results for all representable int64 inputs, even when they violate the tighter interval promise; it keeps mandatory type/representation checks.

This is a small, implementable proof/lowering surface and exercises both requested ideas without changing default compilation. It does not predict a meaningful whole-program speedup: Python guard and call/conversion overhead can exceed a tiny expression's native work. Its first success criterion is exact semantic separation and actual assembly showing the specified numeric checks removed. A larger proved region is a later timing prerequisite, not an excuse to claim speed from this toy kernel.

Explicit initial exclusions: bool, int subclasses, NumPy scalars, float/MIXED/optional inputs, division/modulo/power/shifts, user calls, heap/container/ndarray access, mutation, globals, closures, branches, loops, recursion, generators and callbacks. Accept only a small straight-line assignment/return grammar with known machine-int expressions; reject unsupported syntax before building an experimental artifact. This is a generic eligibility rule, never a function/workload-name special case.

## Exact existing check families and discharge requirements

Locations refer to frozen `wave8-header-fix/src/recompyler/heap.py` a9b. Line numbers identify source anchors and can shift later.

| Check family / source | Existing purpose | Checked contract/proof needed | Unchecked v1 policy |
|---|---|---|---|
| `add_i`, `sub_i`, `mul_i`, lines1940-1969; `_Gen.binop` whole-int branch3780 | Python arbitrary-size int results cannot silently wrap; mul helper also conservatively exits near int64 range | Exact input integer guards plus sound interval proof for **every intermediate** reaching that operation; preserve Python int result type | Only family omitted in pilot; explicit raw LLVM wrapping add/sub/mul, no signed-overflow poison |
| `as_mixed`, `as_float(exact=True)`, lines3701-3730 | Converting integer arithmetic/comparison operands through doubles must remain exact where Python uses the integer itself | Integer magnitude/operation range and kind proofs, including intermediate values and observable result kinds | Retained; mixed/float inputs excluded from pilot |
| `_Gen.binop` MIXED branch3791-3812, including result magnitude and `+=0.0` | Two runtime ints held in doubles must remain exact; canonical integer zero and numeric-kind results | Guard stable kinds/ranges, prove each relevant result magnitude below exact boundary, preserve int/float identity and zero behavior | Retained; no tag stripping or double-only rewrite in pilot |
| Division zero and conversion at3815; `floordiv_i`/`mod_i`1965 onward | Python ZeroDivisionError, signed INT_MIN/-1 cases, floor/mod behavior | Prove divisor excludes both zeros for floats, signed corner behavior, exact conversion and Python quotient/remainder semantics | Retained; division/modulo excluded |
| `math_call`4662 onward, `math_extra`5117 and `check_math`971 | sqrt/domain/range/conversion errors and host math agreement | Domain/finite/range proof and existing exact-math agreement; do not equate nonnegative input with finite output for every function | Retained; no fastmath/reassociation/FMA policy change |
| Unary negation/abs, int conversion at4200,4720-4742 | INT_MIN overflow and NaN/Inf/out-of-range conversions | Prove representable output/conversion domain, preserving Python errors/types | Retained; dynamic unary/conversion operations excluded |
| `handle`, `present`, `bound_check`, `guard_attribute`, lines3691,3733,3882,3997 | None/unbound/class errors and dispatch/layout validity | Nonnull/definite-assignment/type proof valid at each use, accounting for branches/rebinding | Retained; object/optional/unbound cases excluded |
| `index`3999 and `nd_locate`4880 | Python negative-index normalization and bounds; native memory access safety | Prove normalized logical range against the live size, plus physical layout/address validity; alias calls/resizing invalidate cached bounds | Retained unconditionally unless independently proved; no unchecked raw indexing |
| Container helpers, e.g.dict/set mutation/version checks2967,3255; byte conversion5834 | Python container/error/iteration semantics and byte range | Transitive effect, alias, length/version/type proofs; byte value bound0..255 | Retained; containers excluded |
| Recursive call depth/status at4623; host top[2] at6864 | Recursion-limit behavior, safe unwind and native stack bound | Rank/depth proof plus comparison against current per-call Python frame/recursion budget; no arbitrary graph-depth assumption | Retained; recursion excluded |
| `alloc`1852, status2/retry at6877, loader/address guards | Arena capacity and safe retry; no stale pointers or out-of-bounds native storage | Exact allocation bound on all paths and trusted retained lifetimes, otherwise keep check | Retained; no capacity/memory-safety relaxation |
| `_Gen.fail`3591 and `_Gen.check`3602 | Shared mechanism for many different semantic and safety exits | Remove only specifically certified sites, never the generic mechanism | Never globally disable these functions |

Input type/layout/schema and function/global guards also remain. Current seeded plans provide types, never assumed runtime values; they cannot be reused as range certificates without extending their identity/guard contract. Tests and profiling observations do not prove a check redundant for unseen inputs.

## Existing strict numeric proofs are not new modes

The current compiler already has two relevant strict transformations. `_Program.fast_mixed` is selected only when `floats_unseen()` proves numeric kinds/sign distinctions unobservable in returned values and in all reachable written-back fields/containers. It does not mean inputs are known floats. Its lowering substitutes a fixed integer-kind flag and **retains result-magnitude exactness checks at every applicable operation**. Barnes writes observable numeric fields, so forcing this switch would bypass its existing proof and would not even eliminate all magnitude checks.

`prove_zero_int_results()` (line921) is a separate fixed-point certificate: a value's integer case, if any, is canonical integer zero. It conservatively eliminates only certified mixed arithmetic magnitude/normalization work while preserving kinds/flags and observable types. Unknown parameters/heap reads and nonzero integer producers invalidate facts; optional proof failure regenerates ordinary code. The saved analysis and approved implementation are documented in `wave8-header-fix/docs/studies/2026-11-11-native-costs-evidence/analysis/numeric-proof.md`.

These are useful design precedents for per-value proof tables, conservative invalidation and keeping proof failure from reducing eligibility. Neither supplies an explicit caller interval contract, generic int64 overflow proof or opt-in wrapping semantics. Reuse the architecture where appropriate; do not relabel current fast_mixed as the requested unchecked mode or force-enable either existing proof on observed values. The pilot's interval facts must remain separate from zero-only facts and type-only AOT seeds.

## Mode A: checked interval contract, strict Python behavior

Suggested dedicated API shape (proposal, no new default runner setting):

```python
from recompyler.experimental import IntIntervals, lift_numeric
contract = IntIntervals(x=(-2**20, 2**20), y=(-2**20, 2**20), z=(-2**20, 2**20))
checked = lift_numeric(mul_add, mode="checked", contract=contract)
```

`IntIntervals` is an immutable canonical contract, not a mutable callback or runtime global. Bounds are exact Python ints; reject bool bounds, malformed/reversed intervals, omitted/unknown parameter names and bounds outside representable inputs at construction. Validate the supported function grammar and exact parameter binding. Version the contract/proof schema.

On each call, before any user-visible effect, bind arguments exactly as the original supported function does and check `type(value) is int` plus the interval bounds. A failed guard invokes the original function with original arguments, preserving its result/type/exception. For example bool or a huge Python int falls back; it is not rejected simply because the optimization contract does not apply. Invalid API configuration is a configuration error, distinct from a valid call outside the optimization contract.

For a successful guard, compute a sound interval for each expression in compiler host code using arbitrary-precision integers: addition endpoint sums; subtraction cross-endpoint differences; multiplication min/max of all four endpoint products. Propagate assignment intervals in evaluation order. Require each arithmetic result fit signed int64. Certificates name the function/code identity, settled exact-int machine kind, expression origin and operation, operands/results and proof version. A certificate for the final result alone is insufficient: `(x*y)-large_value` can overflow at the product even if the final mathematical answer fits.

At the certified `_Gen.binop` whole-int site, emit ordinary exact machine arithmetic without the corresponding `*_i` overflow helper/status test. Keep all unproved checks and all other statuses. Never pattern-match/remove an arbitrary `self.fail(condition)` string. If proof fails for an operation, either retain its current check or decline that pilot specialization; do not narrow accepted Python calls. Strict default and out-of-contract checked behavior stay Python-compatible.

This pilot's original inputs are immutable machine scalars and it has no user calls or side effects, so entry facts remain true. Extending to mutable fields, arrays, callbacks or calls requires effect/alias/escape analysis or guards repeated after invalidation. Observing a field's value in training does not establish that property during later recursion or mutation.

## Mode B: explicit unchecked wrapping-int64 contract

The caller must explicitly request `lift_numeric(..., mode="unchecked-int64", contract=...)`. Avoid a process-wide disable-checks environment variable or automatic promotion after tests. Report the selected mode when inspecting the region/artifact.

The mode promises exact Python-int parameters representable in signed int64 and requests the same generic restricted grammar. Mandatory entry checks still verify exact type and int64 representability. A representation/type failure raises a documented experimental contract error **before execution**, rather than passing an invalid native value, truncating a huge Python int or invoking arbitrary conversion hooks. The exact exception API must be specified before implementation. Tight interval guards are omitted in this mode; these bounds are caller promises/documentation and do not license unsafe memory access.

Every `+`, `-`, `*` in the admitted arithmetic grammar computes modulo2**64, interpreted as signed two's-complement int64 when returned to Python. Use explicit intrinsic LLVM add/sub/mul without `nsw`/`nuw` promises to give wrapping a defined meaning; do not rely on an optimizer's incidental overflow behavior. There is no signed-overflow undefined behavior. Result is a Python int representing that signed int64 value. For valid proved interval inputs it equals Python; outside the tighter interval but still representable inputs it can differ. Example: `(2**40)*(2**40)+1` returns1 in unchecked mode while Python returns `2**80+1`.

This pilot changes numeric overflow behavior only. It does not enable float reassociation, reduced precision, FMA contraction, altered NaN/Inf/signed-zero behavior, dtype coercion, omitted bounds/capacity/recursion checks or removal of arbitrary Python error checks. Broader modes need their own named policy/semantics and artifacts. A future float-only mode would need to specify result kinds, integer conversion, zero signs and math exceptions separately; it must not quietly inherit this integer policy.

## API, source and cache isolation

- Keep experimental entry points in an explicit experimental module. Existing `lift_region`, runner defaults and automatic selection remain strict. Shared internals may gain an immutable numeric-policy parameter with a strict default, but no mutable module-global policy affects existing regions.
- Include mode name, semantic-policy version, canonical parameter interval schema, proof version and wrapping-helper implementation in generated source/digest identity. Also include origin function identity/bytecode and the existing source/native ABI identity. Two identical input types with different bounds/modes must not share a program incorrectly.
- Extend any per-Region program key beyond `_signature`'s type-only key when experimental policy is involved. Store one immutable policy on the wrapper; never reuse a strict program object and patch its `run` in place. Defaults cannot discover/use unchecked exports simply because machine signatures match.
- For the minimal JIT pilot, decline generic seed widening and default runner AOT export. Add explicit experimental AOT building/loading only after a mode-tagged manifest/schema is implemented. Its sealed identity must contain policy/contract/proof metadata, and explicit loader selection must compare them before accepting an export. No range contract may be restored from a type-only strict seed. AOT timing must wait for this extension, rather than silently deploying a JIT-only policy through an old plan.
- If reusing existing build helpers, tag experimental sections/exports distinctly and make strict/default consumers ignore or reject them. A normal source digest match remains necessary but is not a replacement for correct selected policy/guard execution. Cache roots can be separate for audit clarity; correct identity is required even if directories are accidentally shared.
- Checked counters should separate guard-miss Python calls, proof-ineligible strict paths and successful contract-native calls. Unchecked reports should show mandatory representation rejection versus native calls and the selected arithmetic policy. Existing actual AOT/JIT/fallback counters remain accurate; benchmark scripts cannot relabel fallback as native success.

## Validation matrix before implementation claims

1. Construction/eligibility: bounds and parameter canonicalization; exact bool exclusion; unsupported operations/calls/mutation/branch/recursion rejected for pilot; same result under repeated contract construction; different mode/bounds/proof versions have different identities. Monkeypatch intrinsic text and verify source/cache identity changes.
2. Interval proof: exact endpoints, negative multiplication signs, zero, INT64_MIN/MAX boundaries, narrow final result with overflowing intermediate, wide range proof failure, reassignment ordering and constants. Validate with independent mathematical oracles and exhaustive small integer domains. Tests support the proof implementation; they do not replace its soundness argument.
3. Checked semantics: valid random and endpoint inputs equal original Python in value and exact type. Tight-bound misses, bool, subclasses, floats, huge ints and unusual arguments follow original binding/results/errors. Guard rejection occurs before native execution and before any conversion hook/effect. Existing strict regions remain unchanged.
4. Unchecked semantics: valid promised inputs equal checked/Python. Representable out-of-tight-contract values match an independent modular oracle `((mathematical_result + 2**63) % 2**64)-2**63`, including multiply/add/sub overflow and INT64 endpoints. Nonrepresentable/type-invalid values raise the specified contract error before native execution. Neither mode truncates pointers or indexes memory unsafely.
5. Lifetime/cache isolation: strict→checked→unchecked creation order and reverse order; same shared cache; changed bounds; changed source; new process; explicit AOT manifests and stale-mode rejection after their schema is added. AOT replay cannot import Numba just to establish a saved artifact match.
6. Integration safety: full existing suite and direct strict-mode tests after the coordinator's CPU gate. The pilot is a separate change/freeze/review from recursive-context optimization. No experimental semantics are folded into headline strict results.

## Assembly and timing experiment

| Variant | Inputs | Expected numeric behavior | Evidence |
|---|---|---|---|
| CPython original | All original supported calls | Arbitrary-precision Python ints | Reference result/type/error oracle |
| Current strict region | Same calls | Current checked native with Python replay | Actual mode counters and selected code |
| Checked contract | Valid range + invalid-call audit set | Python-compatible, guard misses replay | Guard cost reported; actual two certified arithmetic sites lose overflow/status work |
| Unchecked-int64 | Int64 representable; separate out-of-tight-contract set | Defined signed modulo arithmetic | Independent wrapping oracle; mandatory representation guard retained |
| C checked-contract reference | Identical proved range | Same arithmetic/result policy | Avoid C signed-overflow UB; guards/boundary stated |
| C wrapping reference | Int64 representable | Unsigned operations then explicit signed interpretation | Contract-matched reference, not arbitrary Python baseline |

Bind actual selected export/digest/manifest/binary hashes and map arithmetic body/call chain. Check removal of integer overflow tests and mul helper's float estimate, retained expected boundary guard path and absence of accidental fastmath/noalias/`nsw` in the unchecked wrapping operations. Do not count a CPython wrapper or unrelated specialization as the kernel. Report compilation/profile costs and complete-process wall separately from native arithmetic timing.

The tiny `mul_add` pilot is an assembly/semantic experiment. Use enough calls to expose native work only if the complete call/guard cost is also retained and labeled; do not subtract independently measured medians to invent a speedup. A meaningful kernel benchmark should next use a larger supported proved region or batch loop, with a separate loop/range invariant proof and boundary cost amortized exactly as both reference implementations do.

A possible next bounded extension is a scalar counted loop with explicit bounded steps and a proved recurrence, still without mutable heap/arrays/recursion. Derive bounds for every iteration and intermediate with host integer mathematics; retain iteration-count/representation safety and preserve original behavior for negative/out-of-range step counts via checked fallback. The compiler may collapse a simple loop algebraically, so verify actual selected assembly before deciding it is a useful workload. Container batch scans can amortize guards but introduce alias, mutation and O(n) validation costs and belong to a later phase.

Run separate valid/invalid audits and fresh rotating timing children for strict/checked/unchecked and their matching references; retain all distributions and process costs. Treat invalid unchecked cases as semantic audits, never average them into Python-equivalent speed numbers. If guard overhead or proof machinery loses on complete calls, report that result. Removing two check sites from a tiny expression cannot establish that all remaining Barnes/C gap is checks or that arbitrary Python can achieve C latency.

## Implementation boundary and sequence

After strict context candidate is validated/measured: agree on this pilot's public exception and unsupported-region policy, write RED proof/identity/semantic tests, implement immutable policy plus interval certificates and explicit wrap intrinsics, inspect LLVM/assembly, review independently, then separately add experimental AOT manifest/replay and benchmark only when ready. Broader integer/float/object/recursive modes remain separate proposed extensions. This document authorizes no concurrent CPU work and changes no strict product behavior.
