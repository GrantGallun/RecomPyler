# Concrete lowering and activation notes

Preparation only. These notes refine implementation hooks; they are not product code.

## Keep existing ABI assumptions visible

`ScalarReplacer.clone` indexes generated native arguments after the first four `F, I, top, st`, constructs new scalar parameter types, and creates flattened return/update tuples. A direct context argument must not be inserted before this pass. `_borrow_heap_context` also currently recreates `top` with length 4. Blindly adding a parameter or extending top without updating that view would corrupt recursive calls.

A small option to minimize ABI churn is to reserve `top[4]` in the direct variant as the runtime DirectContext pointer. Allocate a five-cell top only for direct execution; emit the borrowed top view with the direct variant's declared control-cell count. The initial four control cells retain their meanings. This propagates the live map/helper table through every existing call without doubling scalar-clone numeric arguments. The helper intrinsic reads the runtime pointer, not a cached process address. Do not use this slot on the ordinary variant or assume the ordinary four-cell array has extra capacity.

If explicit context arguments are preferred, add them after R8 and teach all recursive merge/context and helper call transformations the new ABI together. Do not apply an untyped text replacement to a subset of functions.

## Semantic metadata and identity passes

The checked generator currently returns `(kind, codes)`. Numeric origin cannot be inferred solely from equal source strings: separate equal constants, numeric globals, defaults and dynamic arithmetic executions can have identical payload spelling and different identities. Use an explicit identity graph with stable semantic nodes and numeric leaf layout.

Suggested identity graph API:

```
ValueNode(function, origin_site, leaf_path, producer, operands)
MemoryNode(canonical_location, numeric_leaf_path)
CallNode(callee, argument_leaves, result_leaves)
DemandResult(
    demanded_values, demanded_memory, parameter_leaves, return_leaves,
    producer_recipes, unsupported_producers)
```

Collect nodes during stable checked generation. `peek` must save/restore the graph alongside its current line/counter/zero/object-allocation snapshots; speculative type peeks must not create live producer sites. `settle` replaces, rather than accumulates, per-function nodes each iteration. An unsupported graph extraction must decline the direct variant without altering ordinary eligibility.

Concrete hooks:

- `expr_Constant`, `constant`, `expr_Name`, argument binding and attribute globals: distinguish literal co_consts origin, guarded global identity and default identity. `constant(value, node)` is currently also used for globals, so treating every synthesized ast.Constant as co_consts is incorrect.
- `temp`, `copy_codes`, `var_codes`, `assign`, `coerce`: transfer stable leaf IDs through copies and representation changes. Local names have reaching-definition edges; immutable generated temporaries have one defining node. MIXED has one numeric node across its two codes.
- `expr_IfExp`, branches and loops: compute demand from all reaching definitions, emit token assignments in the same selected control-flow branch as payload assignments. Do not choose an identity from the final compile-time visit.
- `slot/store`, list constructors, slices, repeated lists and copy helpers: memory nodes transfer identity and originate live Existing boxes. Generic I reads also represent handles/tags, so classify from the kind/location metadata.
- `call`: bind arguments exactly as payload binding does. A callee's `constant` return optimization currently replaces return payloads with generated literals; direct code must preserve the callee's semantic result token even when its payload is constant-folded.
- `do_Return`: save demanded return tokens before finally blocks, just as it currently saves payloads. A finally-block mutation cannot change the already-selected returned numeric object.
- `ScalarReplacer.virtual/clone/Lower`: export a mapping from each replaced numeric location to virtual scalar leaves, plus clone parameter/return/update substitutions. Apply these substitutions to the identity graph, then solve/verify it again before emitting token code. Metadata must survive copy/parse/unparse, not rely solely on Python AST custom attributes that reparsing drops.
- `_merge_cycles/_borrow_heap_context`: preserve token parameters/returns and context propagation for recursive groups, or issue a concrete recursive direct-decline until that transfer is covered. Recursive effects themselves still participate in the fixed point.

The demand solver is monotone over finite value/memory/call nodes: start at entry returns and escaping stored leaves, add move/phi/memory/call dependencies, stop operand traversal at a certified independent producer, and re-enqueue callee callers when parameter/return demands widen. Recursive groups reach a finite fixed point because dynamic token allocation is an emission/runtime issue, not a growing compile-time graph.

Clone demand diagnostics have a concrete test contract: `program.direct_report["identity"]["parameter_tokens"]` maps every emitted function name to its hidden numeric token parameter count. Arithmetic-only field-passing clones must report zero. A demanded return producer does not require identity tokens for arithmetic-only input fields.

## Producer categories to cover

1. Existing and forwarding: argument, exact field/list load, actual co_consts/global/default, local/tuple assignment, branch/loop, pass-through call, exact numeric unary plus, exact identity conversions, and min/max's selected operand. Equal min/max operands choose the first object according to Python's ordering behavior; payload equality alone does not identify it.
2. Certified independent result: specific exact-kind arithmetic and comparisons. Each certificate names the operation and result boxing recipe; do not certify all integer operations by family because some operators may reuse operands.
3. Exact boxed recipe: e.g. operations whose operand-returning cases are difficult to classify. Demand the necessary operands and retain their tokens in a deferred recipe. Prefer running the exact boxed operation after all raw reads stop; cache its one actual result for every alias. If execution is required inside the envelope, certify bounded work, no pending-call/signal checks and non-observing allocation separately from exact operand types, or decline that demanded producer before entry and report its opcode.
4. Unsupported producer: explicit whole-region arena guard, with an actual counterexample test. It is not an excuse to omit the requested identity analysis.

Positive integer abs, equal-operand min/max, unary plus and exact float(float) are fail-first examples. Constant-folded returns from two functions are tested against each original function's actual constant identities rather than assuming equal constants are necessarily distinct.

## Runtime token storage

Use C-owned raw token cells with stable indices. Existing cells own a pinned PyObject pointer. Deferred cells store kind/payload/recipe and an optional materialized reference. Allocate a new Deferred cell for each demanded dynamic producer execution; aliases carry its index. Grow token storage only via an audited allocator with no Python callback and no invalidated addresses; generated code holds indices so the table may move. Check capacity/overflow before any write and use the existing failure status when the table cannot grow.

Token storage can remain raw until after native reads finish. In pure readers, independently boxable deferred results may be materialized at output construction. Existing references returned from input graph locations must be selected before unrelated graph pins are dropped. Output tuples/lists preserve shared token IDs, while two Deferred IDs with equal payloads remain different boxes except required canonical int/bool behavior.

For allocation-failure behavior, a pure read attempt can drop raw state and replay Python with no graph rollback. Any exception reconstruction or tracked result allocation happens only after the raw-read interval and after unrelated nested pins have been released. The later direct-store task will need stronger preallocation/rollback rules and is not enabled here.

## Preparation artifact and execution gate

`test_direct_reads.py` is intentionally outside `tests/`. It has not been imported or executed. After IMPLEMENT, move it into the suite and have the coordinator launch the first fail-first run with the clone-local lock runner, for example:

```
C:\Python314\python.exe inplace/run_locked.py task2-direct-red C:\Python314\python.exe -m pytest tests/test_direct_reads.py -q --tb=short
```

Do not run this while Step0/Step1 or another queued lock job owns the coordinator's execution slot. Split subsequent red/green subsets only around concrete implementation stages. Native builds and all test invocations go through the same coordinator-owned runner; independent guard review precedes timing.


## Hot live loads and physical location handoff

Lower live numeric use to LLVM intrinsics that inline descriptor lookup, cell-pointer dereference and float/int64 decoding. Runtime `direct_abi()` exports offsetof/sizeof/alignment facts derived by the installed-header-built extension; the direct variant digest seals those facts. No copied PyLong/float/dictionary offsets or persisted addresses enter source. C calls remain appropriate for the entry envelope, rare checked exits and audited raw token growth; a Python/C or indirect C call on every numeric read is not the intended hot path.

Choose physical PyObject** field/item cells as the map's durable location abstraction, plus pinned owners/boxes and one token per numeric leaf. No callback or mutator can change that cell during this read-only interval. Do not attach invariant/noalias metadata that would be unsound when Step3 introduces an alias-visible store. A cached-box-only first implementation must document its readonly restriction and replace or refresh that cache on every future published store.

Use one loaded box SSA value to decode MIXED payload/tag; both pieces and its token describe that same object. Long digit/sign masks, shifts and widths come from header facts. Unsigned accumulation plus a separately checked sign handles INT64_MIN without signed overflow. Direct helper generation consumes typed storage roles after R8, not generic I/F subscript text.

See typed-ir.md for exact metadata/substitution records and native-build-proof.md for the mandatory post-build stale-binary check. Both draft test files move only after IMPLEMENT; the first red command may name tests/test_direct_reads.py and tests/test_direct_read_review.py together once the coordinator schedules it.