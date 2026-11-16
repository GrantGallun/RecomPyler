# Step 2: sound named declines and cache identity

Execution baseline: 1,000 rows; 221 native, 655 declined, 4 wrong, 120 crashes. Raw evidence: baseline-v1.jsonl plus baseline-none-phases.jsonl. This step accepts correctness, not a speed claim.

1. Generated-module identity must include every semantic named binding, including method family/name. The source `_rc_method0(st,y,())` is identical for pop, reverse, and sort; the current disk key omits which binding it denotes. Cache entries for one method are being reused for another. Add the stable binding recipes to module and generated-record identities. Fail first: warm pop, then reverse and sort with identical source structure and arguments; each must match Python. No persisted-module loader or startup path is changed.
2. Numba overload pickers know when no implementation exists. At this recognition point, raise Unsupported with helper/type details instead of letting Numba generate TypingError. Catch that named decline explicitly in Lifted._prepare, record its reason, and use normal untouched Python fallback. Preserve the existing _RETYPE request/rebuild protocol before finalizing a decline. Internal compiler errors remain internal errors; do not catch them as Unsupported.
3. Bitwise operators currently bypass checked helpers and fail Numba on float, tuple, and None. Route them through typed helper pickers accepting int/bool only. Tuple/list truth must not use NumPy truth; typed truth/value helpers reject unsupported represented containers before execution, while int/float/bool/None keep Python truth. Tuple-valued and/or must decline because native unboxing cannot preserve the returned argument's tuple identity. Fail first: both and/or on each tuple truth outcome, short circuit, list truth, bool bitwise result types, invalid float/None operators.
4. None is a constant batch shape, not a NumPy scalar column. Handle shape N without dtype lookup, emit literal None in batch drivers, and validate each column is None. Fail first: None comparisons, not, and/or and mixed nested tuple batch rows. This affects batching only.
5. List index out of range should set the ordinary fallback flag before Numba can raise. Use explicit logical bounds in the list read helper. Retain the original list read and nominal return type for valid indices; no unchecked access. Fail first: negative/positive out of range, empty list, aliases and preceding private writes; exception message/class must come from the single Python fallback.
6. The range proof's proven sin helper currently declines integer inputs even though the proven range supplies representable numbers. It must accept int/bool only through an explicit exactly representable conversion or decline by name; float code must be unchanged. Fail first: int, bool, 2**53+1 and error cases.

Independent review, full matrix rerun, union suite and the four-kernel three-pair check follow; accepted changes are committed only in this clone. No loading, write-back, start-up or other wave source is edited.

## Review-driven comparison extension

Actual base probes find 5 wrong and 2 crash in 9 additional rows. Lower comparison chains into short-circuited checked pair calls, binding every middle expression once in a fresh compiler-local temporary. Numeric int/float pairs are checked for exact integer representability (|int| <= 2**53); outside it set the normal fallback flag and let Python perform its exact comparison. Float/float and int/int remain direct comparisons. Typed tuple comparisons decline when float/identity-bearing elements occur: unboxing has lost the shared-NaN element identity Python tuple comparison observes. Integer/bool tuples keep their existing lexicographic native path. Unsupported operand pairs decline at typed helper selection.

Complete generated-record identities with semantic binding recipes as for module files. Route literal numeric list indices through the same checked helper as variable indices. Tighten sequence arithmetic pickers to domains actually implemented: None+None and tuple*tuple must decline before entering Numba.


## Final independent-review corrections

Executed scalar selected-value probes revealed that numeric and/or also reboxes the selected argument. Value-producing Boolean helpers now admit bool/None singletons only; truth-only if/while/conditional/filter contexts use a separate recursive condition lowering. Four scalar identity rows and permanent public-lift assertions cover both selections and signed zero/noninterned integer input.

The union gate exposed raw registry addresses in the semantic binding key; stable class descriptors now normalize only make/blank/fill recipes. Unsupported-triggered record retyping persists the same learned kinds as the older compiler-error path. This preserves fresh-process native cache hits and the make_counted integer/bool coverage gates.

Three executed chain-call probes identified the introduced walrus-in-overload shape as an unresolved backend inference defect. Chains retain the backend's native short-circuit ast.Compare form, with each operand checked once in place; numeric integers beyond +/-2**53 flag fallback, and nonnumeric chains decline. Single comparisons retain exact pairwise helpers. This avoids duplicating side effects or eagerly evaluating later comparators. The conservative scope loss includes tuple chains and large integer-only chains; it is reported in the matrix.

Independent current-source review: review-step2-third.md. Acceptance evidence: step2-v3.jsonl (1,016 rows, 235 native/781 declined), step2-union-v4 (2,022 tests/131 subtests), forthcoming frozen-source four-kernel check. STEP2-REACHABILITY.md answers the original four wrong rows separately from profitability/deployment.
