# Independent F2 cache code review

**Approved for coordinator verification and timing; no correctness blockers found.** This was a static review only: no product import, test, workload, build, profiler, or timing was executed by this reviewer.

Reviewed actual `src/recompyler/escape.py` against the frozen integration-noop implementation and `inplace/F2-STRUCTURE-DESIGN.md`. The committed test oracle is byte-identical to that frozen implementation.

## Exact change check

A standard-library AST comparison reversed only the declared structural substitutions and matched the entire original module AST exactly: three per-instance cache assignments, one text helper, one cached parent-map substitution, three ordered-node loop substitutions, one cached node-count substitution, and seven lazy text substitutions. No origin transfer, event emission, allocation classification, summary update, iteration order, or convergence condition changed. This static comparison did not execute either module.

## Soundness findings

- `tuple(ast.walk(tree))` preserves the exact original breadth-first traversal, including repeated shared operator/context nodes. Parent maps are built in that same order; parent selection is unchanged.
- `_nodes`, `_parents`, and `_unparsed` belong to one analysis instance. Fresh analyses parse fresh source and create fresh caches. No input-object graph, runtime value, or cross-program cache was introduced.
- `_text` caches only `ast.unparse(node)` for immutable parsed nodes. The `None` sentinel handles even an empty cached string correctly. It does not cache origin, callee effect, conditional-capture result, or summary-dependent data.
- Every `scan` still builds a fresh origin environment and event set, recomputes local reaching-definition unions to its original bound, and reads current callee summaries. Conditional/control ancestry still uses the unchanged algorithm over the cached parent map.
- The analysis does not mutate its ASTs. Current scalar consumers reparse `FunctionIR.source` separately. The required immutability invariant therefore holds across present product call sites.
- Existing source/origin/digest validation and compilation guards are untouched. A final-source rebuild is required because the compiler digest includes `escape.py`.

## Verification boundary

The coordinator owns red/green tests and acceptance measurements. Prepared tests compare full reports/events/origins with the frozen oracle, mutate callee summaries before rescans, verify source/AST isolation, and require one structural walk per function plus one unparse per requested node and zero additional structural work on warm scans. This approval does not claim a whole-process saving; the recorded counterfactual remains a bound until product measurements pass.

## Reviewed identities

- Product escape.py SHA-256: `f2787ac24f8c49938bfd75fce4f8ff7223f88e8b79ac312f6a1660f26e9e9ae4`.
- Frozen/oracle escape.py SHA-256: `54ab41bb195df8b3577cb40374d1e0632e71a517d265ef5b1d0deb1dbca6bc20`.
- Design SHA-256: `91693a215a449605b0dfae6b074327cd09d8b8e8828d1280ae210f78426fd6fd`.
