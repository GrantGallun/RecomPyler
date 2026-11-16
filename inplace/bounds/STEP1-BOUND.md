# Step 1 component bound (accepted Step 0 source)

Kernel source: `integration-native-shapes-s37`, accepted CHECKPOINT63. Five resets; plain/on/off application bytes, exact AOT counts, every retry entry and exclusive sums pass. Independent review: `../s37-step1-review.md`. All values are **microseconds per instrumented complete call**, with timer/wrapper overhead retained. They are component sizing, not causal savings or additive to separate uninstrumented call times.

## Kernel load / guard / writeback / result partition

| Kernel / region | Scope | Load | Guards | Writeback | Result | Native | Sum all components |
|---|---|---:|---:|---:|---:|---:|---:|
| barnes_hut / advance_system | all attempts | 98.0620 | 6.7028 | 34.0068 | 0.6910 | 140.3966 | 1477.0156 |
| barnes_hut / advance_system | exclude entire first reset | 93.6262 | 6.0747 | 32.0907 | 0.6833 | 136.3515 | 324.9312 |
| scimark / FFT_transform | all attempts | 7.4548 | 3.3036 | 4.7156 | 0.9092 | 9.6324 | 116.8436 |
| scimark / FFT_transform | exclude entire first reset | 7.3340 | 3.3545 | 4.8015 | 0.9015 | 9.7375 | 118.7485 |
| scimark / FFT_inverse | all attempts | 8.4428 | 3.0276 | 3.9928 | 0.8292 | 9.0452 | 110.6040 |
| scimark / FFT_inverse | exclude entire first reset | 8.6835 | 3.0240 | 3.9815 | 0.8095 | 8.9800 | 111.0160 |
| raytrace / Scene.render | all attempts | 289.1400 | 51.7200 | 448.5600 | 1.2200 | 2639.0400 | 787283.9000 |
| raytrace / Scene.render | exclude entire first reset | 117.3750 | 47.0750 | 439.5750 | 1.2000 | 1715.9750 | 2397.5250 |

Guards means `guards_hold`; type/range/layout validation also remains inside load. FFT extension return boxing stays inside native; result is Python status/tuple conversion and boundary reconstruction. Runner wrapping, module construction and import startup are outside these attempt timers. First-reset-excluded subsets are descriptive warm scopes, not a replacement for all attempts.

## Every named other kernel component

| Kernel / region | Scope | Component | us/call |
|---|---|---|---:|
| barnes_hut / advance_system | all attempts | binding | 3.4026 |
| barnes_hut / advance_system | all attempts | program_lookup | 1141.4820 |
| barnes_hut / advance_system | all attempts | arrays | 1.8668 |
| barnes_hut / advance_system | all attempts | array_snapshot_rollback | 0.9226 |
| barnes_hut / advance_system | all attempts | arena_capacity | 0.5840 |
| barnes_hut / advance_system | all attempts | staged_payload_copy | 1.5366 |
| barnes_hut / advance_system | all attempts | control_writes | 2.0578 |
| barnes_hut / advance_system | all attempts | recursion_frame_scan | 1.6848 |
| barnes_hut / advance_system | all attempts | unloader_init | 26.9732 |
| barnes_hut / advance_system | all attempts | result_prepare | 1.1564 |
| barnes_hut / advance_system | all attempts | rng_store | 0.6192 |
| barnes_hut / advance_system | all attempts | shape_prepare | 0.0000 |
| barnes_hut / advance_system | all attempts | boundary_init | 0.0000 |
| barnes_hut / advance_system | all attempts | boundary_discard | 0.0000 |
| barnes_hut / advance_system | all attempts | result_validation | 0.0000 |
| barnes_hut / advance_system | all attempts | bookkeeping | 14.8704 |
| barnes_hut / advance_system | exclude entire first reset | binding | 3.3342 |
| barnes_hut / advance_system | exclude entire first reset | program_lookup | 2.8915 |
| barnes_hut / advance_system | exclude entire first reset | arrays | 1.6952 |
| barnes_hut / advance_system | exclude entire first reset | array_snapshot_rollback | 0.5923 |
| barnes_hut / advance_system | exclude entire first reset | arena_capacity | 0.5785 |
| barnes_hut / advance_system | exclude entire first reset | staged_payload_copy | 1.5300 |
| barnes_hut / advance_system | exclude entire first reset | control_writes | 2.0192 |
| barnes_hut / advance_system | exclude entire first reset | recursion_frame_scan | 1.4683 |
| barnes_hut / advance_system | exclude entire first reset | unloader_init | 26.4235 |
| barnes_hut / advance_system | exclude entire first reset | result_prepare | 1.1435 |
| barnes_hut / advance_system | exclude entire first reset | rng_store | 0.5657 |
| barnes_hut / advance_system | exclude entire first reset | shape_prepare | 0.0000 |
| barnes_hut / advance_system | exclude entire first reset | boundary_init | 0.0000 |
| barnes_hut / advance_system | exclude entire first reset | boundary_discard | 0.0000 |
| barnes_hut / advance_system | exclude entire first reset | result_validation | 0.0000 |
| barnes_hut / advance_system | exclude entire first reset | bookkeeping | 13.8628 |
| scimark / FFT_transform | all attempts | binding | 1.0728 |
| scimark / FFT_transform | all attempts | program_lookup | 0.0136 |
| scimark / FFT_transform | all attempts | arrays | 0.0000 |
| scimark / FFT_transform | all attempts | array_snapshot_rollback | 0.0000 |
| scimark / FFT_transform | all attempts | arena_capacity | 0.0000 |
| scimark / FFT_transform | all attempts | staged_payload_copy | 0.0000 |
| scimark / FFT_transform | all attempts | control_writes | 0.7340 |
| scimark / FFT_transform | all attempts | recursion_frame_scan | 0.0000 |
| scimark / FFT_transform | all attempts | unloader_init | 0.0000 |
| scimark / FFT_transform | all attempts | result_prepare | 0.0000 |
| scimark / FFT_transform | all attempts | rng_store | 0.0000 |
| scimark / FFT_transform | all attempts | shape_prepare | 1.5096 |
| scimark / FFT_transform | all attempts | boundary_init | 1.0580 |
| scimark / FFT_transform | all attempts | boundary_discard | 0.0072 |
| scimark / FFT_transform | all attempts | result_validation | 0.8136 |
| scimark / FFT_transform | all attempts | bookkeeping | 85.6192 |
| scimark / FFT_transform | exclude entire first reset | binding | 1.0720 |
| scimark / FFT_transform | exclude entire first reset | program_lookup | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | arrays | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | array_snapshot_rollback | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | arena_capacity | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | staged_payload_copy | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | control_writes | 0.7190 |
| scimark / FFT_transform | exclude entire first reset | recursion_frame_scan | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | unloader_init | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | result_prepare | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | rng_store | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | shape_prepare | 1.6420 |
| scimark / FFT_transform | exclude entire first reset | boundary_init | 1.0430 |
| scimark / FFT_transform | exclude entire first reset | boundary_discard | 0.0000 |
| scimark / FFT_transform | exclude entire first reset | result_validation | 0.8120 |
| scimark / FFT_transform | exclude entire first reset | bookkeeping | 87.3315 |
| scimark / FFT_inverse | all attempts | binding | 1.0292 |
| scimark / FFT_inverse | all attempts | program_lookup | 0.0120 |
| scimark / FFT_inverse | all attempts | arrays | 0.0000 |
| scimark / FFT_inverse | all attempts | array_snapshot_rollback | 0.0000 |
| scimark / FFT_inverse | all attempts | arena_capacity | 0.0000 |
| scimark / FFT_inverse | all attempts | staged_payload_copy | 0.0000 |
| scimark / FFT_inverse | all attempts | control_writes | 0.6960 |
| scimark / FFT_inverse | all attempts | recursion_frame_scan | 0.0000 |
| scimark / FFT_inverse | all attempts | unloader_init | 0.0000 |
| scimark / FFT_inverse | all attempts | result_prepare | 0.0000 |
| scimark / FFT_inverse | all attempts | rng_store | 0.0000 |
| scimark / FFT_inverse | all attempts | shape_prepare | 0.9276 |
| scimark / FFT_inverse | all attempts | boundary_init | 1.0244 |
| scimark / FFT_inverse | all attempts | boundary_discard | 0.0056 |
| scimark / FFT_inverse | all attempts | result_validation | 0.7768 |
| scimark / FFT_inverse | all attempts | bookkeeping | 80.7948 |
| scimark / FFT_inverse | exclude entire first reset | binding | 1.0190 |
| scimark / FFT_inverse | exclude entire first reset | program_lookup | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | arrays | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | array_snapshot_rollback | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | arena_capacity | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | staged_payload_copy | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | control_writes | 0.6950 |
| scimark / FFT_inverse | exclude entire first reset | recursion_frame_scan | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | unloader_init | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | result_prepare | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | rng_store | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | shape_prepare | 0.9445 |
| scimark / FFT_inverse | exclude entire first reset | boundary_init | 1.0145 |
| scimark / FFT_inverse | exclude entire first reset | boundary_discard | 0.0000 |
| scimark / FFT_inverse | exclude entire first reset | result_validation | 0.7725 |
| scimark / FFT_inverse | exclude entire first reset | bookkeeping | 81.0920 |
| raytrace / Scene.render | all attempts | binding | 7.7800 |
| raytrace / Scene.render | all attempts | program_lookup | 783548.7600 |
| raytrace / Scene.render | all attempts | arrays | 60.7000 |
| raytrace / Scene.render | all attempts | array_snapshot_rollback | 2.9200 |
| raytrace / Scene.render | all attempts | arena_capacity | 2.4800 |
| raytrace / Scene.render | all attempts | staged_payload_copy | 72.4800 |
| raytrace / Scene.render | all attempts | control_writes | 18.7200 |
| raytrace / Scene.render | all attempts | recursion_frame_scan | 4.9600 |
| raytrace / Scene.render | all attempts | unloader_init | 8.9800 |
| raytrace / Scene.render | all attempts | result_prepare | 2.1000 |
| raytrace / Scene.render | all attempts | rng_store | 2.1000 |
| raytrace / Scene.render | all attempts | shape_prepare | 0.0000 |
| raytrace / Scene.render | all attempts | boundary_init | 0.0000 |
| raytrace / Scene.render | all attempts | boundary_discard | 0.0000 |
| raytrace / Scene.render | all attempts | result_validation | 0.0000 |
| raytrace / Scene.render | all attempts | bookkeeping | 122.2400 |
| raytrace / Scene.render | exclude entire first reset | binding | 6.5750 |
| raytrace / Scene.render | exclude entire first reset | program_lookup | 4.3000 |
| raytrace / Scene.render | exclude entire first reset | arrays | 2.4000 |
| raytrace / Scene.render | exclude entire first reset | array_snapshot_rollback | 1.0500 |
| raytrace / Scene.render | exclude entire first reset | arena_capacity | 0.6750 |
| raytrace / Scene.render | exclude entire first reset | staged_payload_copy | 17.0250 |
| raytrace / Scene.render | exclude entire first reset | control_writes | 2.5500 |
| raytrace / Scene.render | exclude entire first reset | recursion_frame_scan | 2.2500 |
| raytrace / Scene.render | exclude entire first reset | unloader_init | 8.5000 |
| raytrace / Scene.render | exclude entire first reset | result_prepare | 2.1750 |
| raytrace / Scene.render | exclude entire first reset | rng_store | 2.2000 |
| raytrace / Scene.render | exclude entire first reset | shape_prepare | 0.0000 |
| raytrace / Scene.render | exclude entire first reset | boundary_init | 0.0000 |
| raytrace / Scene.render | exclude entire first reset | boundary_discard | 0.0000 |
| raytrace / Scene.render | exclude entire first reset | result_validation | 0.0000 |
| raytrace / Scene.render | exclude entire first reset | bookkeeping | 26.6250 |

## Six held-out regions (existing measured instruments)

These are the existing frozen coverage S18 contexts, not remeasured or relabelled current wave16. Keep all first-use costs; source/attempt counts and raw JSON pointers are in `components.json`.

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

## Effect on components and bounds

The complete removes/shrinks/unchanged matrix remains in [BOUND.md](BOUND.md), section What direct reads/stores change. Direct reads remove eligible numeric payload copy and input writeback for no-store regions, while retaining fresh type/layout/shape validation and pins; direct stores replace writeback with publication/journal commit and retain new-output conversion. Preparation, needed controls/depth/RNG, callbacks and new graph creation need separate proof. Pins, journal allocation, boxing/provenance and fresh validation are replacement costs; no component sum is claimed removable.

The three largest comparable held-out per-call buckets remain create_gc_cycles result **9040.7500 us**, Task.qpkt program lookup **2701.8125 us**, and DeviceTask.fn program lookup **1033.8500 us**. Within warmed kernels the largest boundary buckets are raytrace writeback **439.5750 us**, raytrace load **117.3750 us**, Barnes load **93.62625 us**. FFT instrumented bookkeeping (87.33/81.09 us) includes large observer effects and must not be mistaken for that much removable production dispatch.

All-attempt raytrace lookup **783548.76 us/call** and Barnes lookup **1141.482 us/call** are dominated by the first preparation under instrumentation. Do not pool these cold scopes with warmed kernel or held-out values to invent an overall saving. The prior six-region observed-attempt aggregate is60.3824ms; leaving Task.qpkt out leaves37.2752ms. Historical causal grouped boundary rungs remain FFT0.5772ms/ray1.1271ms; current fine timers do not replace those causal bounds.

Named Step4 targets carried from S37: Barnes+2.5% and FFT+1.5% per-call lifetime/allocation guard regression; transform_point first lookup3504us versus3.6-4.2us warm (mean441.425us); create_gc_cycles new-output conversion9040.75us with zero input identities. Direct input access alone cannot remove the latter output cost.

Raw current kernel evidence: `kernel-s37-components-v1/summary.json` plus per-kernel complete/on/off child records, root `../logs/step1-components-s37-v1.receipt.json` (exit0). All old data paths and exclusions remain in `components.json`.
