# Fresh current-ray bound (S30)

Final accepted owner-v1 source; one shared lock, three fresh alternating processes per stage, every default pixel and exact native/AOT gate passes. Frozen47input hashes remain unchanged. No wave13 timing is reused. All transformations are diagnostic only.

| Stage | Median ms |
|---|---:|
| product | 2.82580 |
| current | 1.66840 |
| lists | 1.60810 |
| tuples | 1.68060 |
| float | 1.27610 |
| float-tuples | 1.23740 |
| float-stream | 0.86200 |
| calls-replay | 0.86410 |
| calls-inline | 0.87480 |
| hand-core | 0.78620 |
| hand | 0.81230 |
| c | 0.60415 |

| Conditional rung | Difference of medians ms | Median paired saving ms | Status/scope |
|---|---:|---:|---|
| product -> current | +1.15740 | +1.15740 | short diagnostic above6% convention; packing/validation/writeback and setup excluded from native timer |
| current -> lists | +0.06030 | +0.05270 | unresolved under6% convention; all scene/light list growth and copy removed; upfront capacity reservation retained |
| lists -> tuples | -0.07250 | -0.05480 | unresolved under6% convention; all per-intersection tuple bumps batched; every tuple payload/handle store retained |
| tuples -> float-tuples | +0.44320 | +0.41980 | short diagnostic above6% convention; whole-graph fixedFLOAT storage/scalar payload ABI and numeric checks together; diagnostic not general Python |
| float-tuples -> float-stream | +0.37540 | +0.37840 | short diagnostic above6% convention; all intersection tuple payloads plus private list materialization and firstIntersection consumer fused; grouped, not pure tuple latency |
| calls-replay -> calls-inline | -0.01070 | -0.01720 | unresolved under6% convention; one recursive dispatch/packed return edge removed, rayColour recursion retained |
| calls-inline -> hand-core | +0.08860 | +0.06460 | short diagnostic above6% convention; unclosed grouped representation/control/remaining-call gap, not a single cost |

Product minus full hand is 2.01350ms; native current minus hand core 0.88220ms. The boundary/setup group is 1.15740ms. Standalone current-to-FLOAT saves 0.39230ms, whereas FLOAT after tuple batching saves 0.44320ms; the ordering interaction is retained, not added twice. Stream-to-replay reoptimization changes -0.00210ms, restoring hand setup costs +0.02610ms, and hand-to-C is 0.20815ms. After the partial call stage, 0.08860ms remains unclosed native representation/control/recursive ABI. These signed conditional values telescope with the signed countersteps; no intrinsic cost partition is asserted.

Actual semantic counters: current283475bumps/1414615slots; preallocate268297/1343237; batchedtuples146177/1343237; FLOATtuples146177/1028217; FLOATstream115647/371822. Every row matches instrument-off/on fullpixels/highwater. All35776growth bumps disappear but20598upfront positive data allocations replace zero-capacity data blocks, so net list-stage reduction is15178bumps. Batching removes all122120individual tuple bumps and zero payload slots. Streaming then removes all15265private record lists (30530positive bumps) plus all payload/handle stores for122120record instances and firstIntersection traversal; it is a grouped materialization/consumer fusion, not a pure tuple allocation latency. The extra656395reserved record/list slots are gone.

FLOAT changes numeric kinds only for this known scene; no MIXED fields/operations remain and geometry scalar returns are three floats instead of payload/tag triples. It changes storage, scalar ABI, guards and arithmetic together, without changing the104981remaining instance bumps. The tested call transformation redirects literal selector calls, removes every optimized colourAt edge, retains one rayColour self-recursive site and has a matched reoptimization replay. Its paired samples reverse sign and show no resolved gain; do not infer recursive calls cost nothing. The unclosed0.0886msgroup still includes them.

Catalogue updates: R9 records fresh1.1574msboundary/setup group; R7 records remaining conditional0.4432msFLOAT/layout/ABI diagnostic and0.3923msstandalone context, not another accepted implementation gain; R19 adds conditional record/list/consumer fusion0.3754ms as open with virtual-container/effect/failure-order proofs required; R20 marks this tested selector/partialcall ablation as no-resolved-gain, leaving recursive ABI open. No new rule is implemented after item4. Evidence ray-current-summary.json,ray-current-counts.json,ray-current-input-manifest-v2.json,ray-current/*/build.json,raw/ray-current andray-current-review.md.
