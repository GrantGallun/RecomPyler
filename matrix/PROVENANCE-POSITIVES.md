# Real-code provenance queries (S52)

The unchanged source layer proves 2 of 38 positive consumer queries from 14 real functions in eight original modules. The defensive corpus separately has 117 refusals and 17 original-owner proofs out of 134 cases. These figures measure different contracts.

No native-function gain or runtime root/callback permission follows from a source fact. Physical roots, journal topology, virtual fields and callee allocation tags still need runtime consumer transfers. The layer source remains accepted 0b8ffc2d, unchanged.

## Actual first blockers

- 32 queries: original source/bytecode binding.
- 4 queries: queried source owner absent or widened.

The source-binding failures include CPython3.14 method context flags, module-wide constant table ordering, closure context and instruction positions. A sound next extension recompiles the original context and compares exact code and positions; it does not mask flags or substitute normalized source. Four other queries lack an owner at the exact consumer operation.

## Cost of documented limitations

| Limitation or required transfer | Positive query IDs blocked |
|---|---|
| nested closures/nonlocal | richards_super.DeviceTask.fn.7, richards_super.DeviceTask.fn.8, richards_super.HandlerTask.fn.10, richards_super.HandlerTask.fn.11, regex_effbot.gen_string_table.30, regex_effbot.gen_string_table.31, regex_effbot.gen_string_table.32 |
| generators/async | 0 sampled cases |
| unsupported CFG | chaos.Spline.__call__.24, chaos.Spline.__call__.25, shlex.shlex.read_token.35 |
| loop dynamic instance correlation | richards_super.schedule.14, hexiom.Hex.link_nodes.16 |
| unknown callback or call result | richards_super.Task.qpkt.3, richards_super.Task.runTask.6, regex_dna.run_benchmarks.34, shlex.shlex.read_token.36, base64.bench_b64_small.37 |
| nonweak dependency live pins | 0 sampled cases |
| physical roots | richards_super.Task.runTask.5, richards_super.schedule.15, hexiom.Hex.link_nodes.17, hexiom.Done.filter_tiles.20, base64.bench_b64_small.38 |
| journal topology | richards_super.DeviceTask.fn.9, gc_collect.create_cycle.29 |
| virtual-field transfer | richards_super.HandlerTask.fn.12 |
| callee allocation tags | chaos.Chaosgame.transform_point.23, chaos.Spline.__call__.26, gc_collect.create_cycle.28 |

These mappings identify downstream consumer needs even when source binding fails first. Nonlocal, generators/async, variadic binding, match/walrus/delete and nonweak dependency live pins have no positive query here; no universal absence is inferred. The parked wave18 borrowed-list helper is an explicitly labelled auxiliary source, outside the 38 genuine held-out/character-loop queries. The real regex closure supplies the fresh-local-list consumer.

## Evidence and interpretation

- Frozen gate: `provenance-positive-v6/complete.json`, exit0, unchanged; 72 focused checks including matrix collector regressions.
- Exact queries and results: `provenance-positive-v6/pytest/test_real_consumer_queries_rep0/positive.json`.
- Counterexamples: `provenance-positive-v6/pytest/test_complete_corpus_contracts0/corpus.json`.
- Root corpus `wave17-matrix-should-prove.py` and clone fallback preserve whole original modules, original raw hashes, embedded logical-source hashes and the existing pyperf shim. Independent review verified original raw hashes.
- Each query pins original source site, Load/Store context, root set, field/index path and original code scope. Nested-cell/member-producer APIs remain explicitly missing rather than inferred from a token or member count.
- Each correctness attempt now copies a hash-sealed immutable corpus and all consumers read that explicit snapshot; missing explicit snapshots fail closed. Other runs may append cases without changing running evidence.

v1 positives are excluded after review (ambiguous selectors/impossible contracts); v2-v5 are superseded diagnostic iterations. The interrupted unicode-union-v2 and source-changed unicode-matrix-before-v2 are excluded. No failed or incomplete attempt is reused.
