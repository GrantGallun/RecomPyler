# Step 1 existing-data component bound

Derived existing evidence only: no workload, build, test, profiler, or timing was run. This is component sizing with observer overhead retained, not a measured direct-access speedup. All units below are **microseconds per complete instrumented attempt**. Missing kernel partitions remain explicit; this file does not close step 1 or a missing-proof item.

## Six held-out regions: complete exclusive partition

The six exclude `Chaosgame.create_image_chaos` and `Richards.run`. Source is the fresh frozen `stages/base` S18-other contexts with exact existing AOT/digest checks, not the later accepted integration. Every integer attempt partition reconciles exactly. Exclusive load excludes nested arrays; exclusive writeback excludes nested result conversion. Inclusive envelopes must not be added.

| Region | n | Attempt | Load | Guards | Writeback | Result | Native |
|---|---:|---:|---:|---:|---:|---:|---:|
| Chaosgame.transform_point | 8 | 585.2000 | 51.5125 | 7.8875 | 5.9875 | 8.6000 | 4.5500 |
| create_cycle | 8 | 249.5250 | 16.0000 | 4.2625 | 76.9500 | 1.4000 | 2.7000 |
| create_gc_cycles | 2 | 9373.9500 | 9.9500 | 6.7000 | 10.7000 | 9040.7500 | 5.0000 |
| Hex.link_nodes | 2 | 1153.8500 | 146.9500 | 4.9000 | 22.7000 | 0.9500 | 7.3500 |
| DeviceTask.fn | 8 | 1192.7250 | 55.5500 | 16.3000 | 23.0500 | 2.0250 | 3.4250 |
| Task.qpkt | 8 | 2888.4000 | 55.0375 | 13.7250 | 42.9875 | 2.4500 | 3.7875 |

Every named other component (same exclusive partition):

| Region | program_lookup | binding | arrays | array_snapshot_rollback | arena_capacity | staged_payload_copy | control_writes | recursion_frame_scan | unloader_init | result_prepare | rng_store | bookkeeping |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Chaosgame.transform_point | 441.4250 | 7.3250 | 5.2250 | 0.8625 | 0.7625 | 3.1625 | 3.0875 | 2.1250 | 5.6250 | 2.4500 | 8.8125 | 25.8000 |
| create_cycle | 97.5000 | 7.2500 | 2.6750 | 0.8375 | 0.7375 | 1.8875 | 3.6500 | 1.9875 | 2.8625 | 4.4375 | 0.9125 | 23.4750 |
| create_gc_cycles | 224.5000 | 9.0500 | 3.0500 | 1.0000 | 1.1000 | 2.0500 | 5.6000 | 2.9000 | 3.8000 | 3.4000 | 1.4500 | 42.9500 |
| Hex.link_nodes | 897.4500 | 9.8500 | 2.9000 | 1.1500 | 1.0500 | 13.8000 | 3.1000 | 2.1500 | 7.2500 | 1.7000 | 0.9500 | 29.6500 |
| DeviceTask.fn | 1033.8500 | 7.1875 | 2.9125 | 1.0000 | 0.8125 | 1.9500 | 3.0500 | 2.0625 | 8.7500 | 2.6625 | 0.7750 | 27.3625 |
| Task.qpkt | 2701.8125 | 6.7250 | 3.7250 | 1.0875 | 0.7875 | 4.1000 | 3.9875 | 3.1875 | 10.4875 | 3.0750 | 1.1250 | 30.3125 |

Program lookup costs, chronological, from the same attempts:

| Region | Lookups us |
|---|---|
| Chaosgame.transform_point | 3504.0000, 4.2000, 4.0000, 3.7000, 4.0000, 4.2000, 3.7000, 3.6000 |
| create_cycle | 754.2000, 4.0000, 4.2000, 3.3000, 3.9000, 3.3000, 3.5000, 3.6000 |
| create_gc_cycles | 444.4000, 4.6000 |
| Hex.link_nodes | 1790.7000, 4.2000 |
| DeviceTask.fn | 4216.7000, 4026.8000, 6.5000, 3.6000, 3.7000, 6.1000, 3.8000, 3.6000 |
| Task.qpkt | 4617.2000, 3049.0000, 3697.1000, 3100.2000, 3.3000, 3533.2000, 3.8000, 3610.7000 |

`transform_point` mean lookup 441.4250 us comes from a 3504.0 us first lookup and later 3.6 to 4.2 us lookups. `Task.qpkt` repeats expensive contextual lookup on six of eight attempts. Preparation is distinct from native work and cannot be removed merely by borrowing object payloads. `create_gc_cycles` has zero tracked input identities and zero input payload in the separate counting context; its 9040.7500 us result conversion chiefly materializes the returned graph. Direct input access therefore leaves its largest cost. A direct-allocation/output-identity design is needed to address that output cost.

Separate fresh gate complete compiled/Python times (not additive or subtractable with the instrumented partition):

| Region | Compiled us | Python us |
|---|---:|---:|
| Chaosgame.transform_point | 32.9560 | 8.1581 |
| create_cycle | 89.9205 | 4.3933 |
| create_gc_cycles | 6614.7000 | 442.3534 |
| Hex.link_nodes | 146.4481 | 14.6153 |
| DeviceTask.fn | 4503.5375 | 7.7810 |
| Task.qpkt | 14819.1625 | 97.3981 |

Existing wave13 counterfactuals (separate cohorts, whole-kernel units): FFT product-to-direct saves 0.5771999859 ms, and raytrace product-to-native-original saves 1.1271000112 ms. These boundary rungs remove setup/loading/guards/writeback together; they are causal grouped counterfactual bounds, not fine component timings or a safe direct-store implementation. Raw steps are preserved in `components.json` from `ladder-v3-{scimark,raytrace}-summary.json`.

## Kernels: separate historical/current diagnostic contexts

| Context / region | n | Attempt | Load/pack | Guards | Writeback | Result | Native | Other |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| wave15 Barnes advance_system | 500 | 548.5746 | 115.4398 | 10.6998 | 40.1962 | 0.6638 | 161.1278 | 220.4472 |
| historical raytrace Scene.render (cold, 7 native entries) | 1 | 185142.5000 | 1524.2000 | 122.3000 | 610.9000 | 1.1000 | 10818.9000 | 172065.1000 |
| historical FFT FFT_inverse | 50 | 45.2480 | 8.1720 | 2.7120 | 5.0040 | included in native | 27.0820 | 2.2780 |
| historical FFT FFT_transform | 50 | 41.4260 | 5.3500 | 1.6040 | 2.2120 | included in native | 30.0780 | 2.1820 |

Barnes excluding only the first attempt (n=499): attempt 384.3699, load 114.7647, guards 10.6832, writeback 40.1405, result 0.6633, native 161.1309, residual other 56.9874 us. This explicitly described subset does not replace the all-attempt row. The all-attempt native sum / five 100-step resets is 16.11278 ms; comparing it to the separately measured 33.53 ms headline cannot establish an additive 48% share.

FFT historical records cover 50 transforms and 50 inverses, one driver reset. Result/status conversion is inside `_run`/native. Other combines shape preparation and binding. Raytrace is a single cold attempt including preparation and seven AOT retries; its 172065.1 us other value is not a warmed steady cost. Wave13 phase scripts refer to wave11 records; no `wave13-depth/depth/work/{scimark,raytrace}/phases.json` exists. The old records above are used explicitly as historical evidence, not relabelled wave13/current product measurements.

The separate wave13 Barnes C probe gives these diagnostic scopes per attempt; do not add them to outer Python timers or the wave15 row:

| Probe scope | us/attempt |
|---|---:|
| graph_walk_and_unclassified_guard_work | 164.1604 |
| exact_type_guards | 31.5110 |
| scalar_copy_in | 60.9260 |
| known_and_remember_alias_bookkeeping | 79.7928 |
| copy_out | 36.9858 |

The probe has 500 attempts and 6,821,638 timer switches. Range/conversion/contract work remains in graph/framework residuals. This heavy probe cannot decompose an uninstrumented boundary cost.

## Largest contributors and dominance checks

Across the six comparable S18 fine contexts, the three largest **individual per-call buckets** are:

- create_gc_cycles / result: 9040.7500 us.
- Task.qpkt / program_lookup: 2701.8125 us.
- DeviceTask.fn / program_lookup: 1033.8500 us.

As a deliberately count-weighted accounting of the 36 recorded attempts only, total is 60.3824 ms. Top three component totals: program_lookup 36.4406 ms, result 18.1992 ms, load 1.7386 ms. Top three region contributors: Task.qpkt 23.1072 ms, create_gc_cycles 18.7479 ms, DeviceTask.fn 9.5418 ms.
Leaving the largest region (Task.qpkt) out leaves 37.2752 ms; remaining top components: result 18.1796 ms, program_lookup 14.8261 ms, load 1.2983 ms. This is an observed-attempt accounting, not a cohort-wide workload saving.

A pooled top-three total across all nine targets is not meaningful: kernel contexts differ, raytrace is cold/retrying, and named kernel components are unresolved. Merely ranking the coarse individual magnitudes would put raytrace other (172065.1 us), raytrace native (10818.9 us), and create_gc_cycles result (9040.75 us) first; the first two are the same single cold/retrying attempt. This demonstrates why that ranking must not set the optimization priority.

## What direct reads/stores change

| Component | Direct read-only rule | Direct stores plus undo journal |
|---|---|---|
| load/pack | Removes arena payload copying for eligible live reads; still validates reachable shapes/types and pins owners | Same; does not remove entry guards or graph/alias checks |
| guards | Leaves necessary type, ABI, layout, shape, bounds, callable and effect guards; may combine traversals | Same, plus journal/observability/store guards |
| writeback | Removes input writeback for proven no-store regions | Replaces input arena walk/reconstruction with live publication and journal commit; cost shrinks, does not become zero |
| result | Leaves new-object boxing/materialization; returned input identity can bypass reconstruction only with explicit identity proof | Same; input journal does not optimize a newly allocated returned graph |
| program_lookup | Leaves parsing/type/program preparation and keyed signature lookup | Leaves it; separate sound cache/preparation change required |
| binding | Leaves argument binding; specialization may shrink separately | Same |
| arrays | May remove unused arena/view creation only if region needs no such ABI/storage | Same; actual arrays retain alias/stride/buffer contracts |
| array_snapshot_rollback | Leaves existing mutable array snapshot path; read-only effect proof can avoid unused snapshot | Live list/object journal does not replace buffer rollback |
| arena_capacity | Removes input arena capacity for eligible objects; output arena may remain | Same; journal capacity is a replacement cost |
| staged_payload_copy | Removes copies only for eligible direct inputs | Same; retained output/array copies remain |
| control_writes | Leaves needed status/arena/depth controls; hoist/remove only when proved unused | Same plus failure/journal controls |
| recursion_frame_scan | Leaves recursion-limit semantics unless a sound recursion summary avoids scan | Same |
| unloader_init | Removes input-only unloader initialization only when no output reconstruction remains | May shrink; new outputs still require it |
| result_prepare | Leaves necessary result metadata, alias/identity and ownership preparation | Same |
| rng_store | Leaves RNG semantics when used; skip only under effect proof of no RNG use | Same |
| bookkeeping | May shrink dispatch paths; no whole-bucket removal justified; observer overhead remains | Same; journal adds work |
| native | Changes representation and per-access loads; no measured saving follows from these timers | Adds journal/publication/reference work; unchanged body cost is not guaranteed |

Pins, entry validation, reference handling, journal allocation/commit, and output identity preservation are replacement costs. The removable fraction inside mixed buckets is not independently measured here. R9 stays open; the table is an implementation target, not permission to discard guard obligations.

## Missing evidence


- Barnes: named other subcomponents not separated in current wave15 phase record; first preparation is included in coarse residual.
- FFT: result conversion/status is included in native; no separate result number. Shape preparation and binding are combined in other. No named-other partition.
- Raytrace: only one cold attempt with seven native entries; warmed per-call load/guards/result/writeback and named-other partition are absent.
- No current integrated wave16 context is measured here. Existing instruments classify costs with observer overhead; a causal direct-access saving is not obtained by summing their buckets.

## Provenance

`components.json` preserves exact raw JSON paths/pointers, all numeric tables, contextual limitations, source/artifact integrity metadata, SHA-256 of every JSON read, and count-weighted calculations. `extract_existing.py` uses only Python standard-library file reads/arithmetic and writes these two derived files in this directory. It never imports runtime sources. Raw S18 source is the frozen base, and no later depth runtime source was consulted; depth accepted source cap d86f4e3 is respected.

Primary paths:

- `wave14-capture/capture/s18-other/{chaos,gc_collect,hexiom,richards_super}/data.json`, `/rows/<index>/attempts/*/exclusive_ns` (exact row indices in JSON).
- `wave14-capture/capture/s18-other/summary.json`, `/rows`; `s18-report/summary.json`, `/historical_boundary/rows` for separate counts.
- `wave15-depth2/depth2/barnes-native-phase.json`, `/attempts`; wave15 runtime module digests remain in the raw record.
- `wave11-ledger/gap-ledger/work/{scimark,raytrace}/phases.json`, `/attempts`; instrumentation `gap-ledger/lift_phases.py` and `tools/_phase_worker.py`.
- `wave13-depth/depth/boundary-phases.json`, `/native_exclusive_ticks`; scope labels and warnings carried verbatim in JSON.
- Scope/reference interpretation: `wave14-capture/capture/s18-report/STARTUP-BOUNDARY.md`, `wave13-depth/REPORT.md`, `wave13-depth/depth/IN-PLACE-DESIGN.md`.
