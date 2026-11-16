# S46 ten-region component diagnostic

Both complete source-identical passes are retained (v7 and the one required disturbed repeat v8). Every row has eight warmed uniform replay samples per pass, actual successful CPUDispatcher calls and exact existing result/argument checks. All four application on/off outputs match the prior completed selection. Peer correctness was alive at Normal priority in both passes; actual priorities and process IDs are recorded. This is descriptive development evidence only. Failed v5 contributes nothing.

Times below are min–max of the two pass means, in microseconds per observed complete replay. Timers and native-entry observation remain installed. Native is the dispatcher/body/boxing envelope; pure machine-body time is not isolated. These totals differ from the earlier selection context and cannot be subtracted from its medians.

| Region | Complete | Load | Native envelope | Write-back | Other |
|---|---:|---:|---:|---:|---:|
| Chaosgame.transform_point | 128.45–131.21 | 39.96–43.48 | 3.69–4.22 | 3.95–4.22 | 79.29–80.85 |
| Spline.__call__ | 67.00–83.22 | 11.61–15.28 | 2.08–2.99 | 1.73–2.02 | 51.59–62.94 |
| create_cycle | 135.09–174.79 | 11.31–24.45 | 1.85–2.61 | 74.56–81.70 | 47.36–66.02 |
| Hex.link_nodes | 250.46–291.77 | 153.46–171.57 | 6.51–7.40 | 17.09–19.60 | 73.40–93.20 |
| Done.filter_tiles | 87.86–104.83 | 20.39–20.93 | 3.51–8.97 | 11.78–14.35 | 52.19–60.58 |
| schedule | 419.23–458.85 | 112.64–140.03 | 2.95–6.04 | 176.89–185.78 | 123.66–130.10 |
| Task.runTask | 542.83–609.69 | 262.11–292.65 | 5.26–5.64 | 66.96–79.10 | 208.11–232.68 |
| HandlerTask.fn | 668.74–742.95 | 423.50–478.30 | 4.91–5.28 | 60.26–69.12 | 180.06–190.25 |
| DeviceTask.fn | 577.99–623.36 | 301.14–331.20 | 4.65–5.53 | 69.36–74.00 | 202.84–212.64 |
| Task.qpkt | 460.69–610.17 | 231.41–330.43 | 4.31–6.58 | 47.36–48.66 | 177.60–224.51 |

## Decision and limits

Load is the largest named non-observer component in the large Richards calls. HandlerTask.fn is 423.50–478.30us; DeviceTask.fn 301.14–331.20us; the third-largest load differs by pass (Task.runTask262.11us in v7, Task.qpkt330.43us in v8). There is no summed “unlocked time”: these calls overlap and have different frequencies. The small native envelope does not explain the large completed-call gap. Direct input payload access remains the next implementation direction, before vectorcall.

Load plus write-back is an upper envelope of work touched by Steps2/3, not an achievable saving. A fresh callback-free layout/kind/alias/root validation walk, strong interval pins and result materialization remain necessary; no component is declared wholly removable. Direct reads avoid numeric payload staging for certified read-only cells; direct stores replace publication with guarded journal work. Output allocation and identity-preserving object materialization remain. RNG and mandatory guards are not silently dropped. No new deployment count or speedup is claimed.

All ten effect summaries include writes, including writes to private temporaries. Spline.__call__ reads caller inputs but creates a private work list and returns either an original point or a new GVector. Treating a private allocation as an arbitrary caller-object write or treating its output as always fresh are both unsound. Constructor-origin unknowns affect chaos/gc; Hex.link_nodes has object-shape unknowns; the existing conservative effect lattice reports no unknowns for the checked Richards variants or Done.filter_tiles, but that alone proves neither physical roots nor source-owner transfers. The shared layer and consumer runtime certificates must close each obligation before direct execution.

The complete named-other breakdown for each pass follows; observer bookkeeping is measured overhead, not product saving.

### Chaosgame.transform_point

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 7.388 | 7.150 |
| program_lookup | 4.388 | 3.925 |
| guards | 10.438 | 9.912 |
| arrays | 2.275 | 2.200 |
| array_snapshot_rollback | 0.750 | 0.800 |
| arena_capacity | 0.775 | 0.738 |
| staged_payload_copy | 2.987 | 2.962 |
| control_writes | 1.650 | 1.550 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 4.888 | 4.775 |
| result_prepare | 2.362 | 2.350 |
| result | 8.025 | 7.862 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 33.362 | 36.625 |

### Spline.__call__

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 7.812 | 5.612 |
| program_lookup | 3.812 | 3.388 |
| guards | 6.112 | 4.525 |
| arrays | 2.362 | 2.025 |
| array_snapshot_rollback | 0.825 | 0.750 |
| arena_capacity | 0.825 | 0.725 |
| staged_payload_copy | 2.000 | 1.788 |
| control_writes | 2.025 | 1.675 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 3.612 | 2.950 |
| result_prepare | 2.688 | 2.362 |
| result | 8.037 | 6.650 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 22.825 | 19.137 |

### create_cycle

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 7.300 | 6.388 |
| program_lookup | 5.562 | 3.413 |
| guards | 5.150 | 3.888 |
| arrays | 2.900 | 2.237 |
| array_snapshot_rollback | 0.925 | 1.038 |
| arena_capacity | 1.150 | 0.762 |
| staged_payload_copy | 2.562 | 1.788 |
| control_writes | 2.150 | 1.700 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 3.487 | 2.400 |
| result_prepare | 1.688 | 1.413 |
| result | 0.900 | 0.800 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 32.250 | 21.538 |

### Hex.link_nodes

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 7.562 | 8.338 |
| program_lookup | 4.237 | 5.375 |
| guards | 6.050 | 7.263 |
| arrays | 2.388 | 2.788 |
| array_snapshot_rollback | 0.900 | 0.988 |
| arena_capacity | 0.825 | 0.950 |
| staged_payload_copy | 14.262 | 22.788 |
| control_writes | 1.562 | 2.000 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 6.300 | 8.088 |
| result_prepare | 1.613 | 1.925 |
| result | 0.887 | 1.038 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 26.812 | 31.663 |

### Done.filter_tiles

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 6.138 | 12.725 |
| program_lookup | 3.888 | 3.712 |
| guards | 5.088 | 5.287 |
| arrays | 2.188 | 2.312 |
| array_snapshot_rollback | 0.887 | 0.800 |
| arena_capacity | 0.950 | 0.963 |
| staged_payload_copy | 1.863 | 1.950 |
| control_writes | 1.925 | 2.188 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 4.088 | 4.300 |
| result_prepare | 1.837 | 1.625 |
| result | 0.863 | 0.887 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 22.475 | 23.825 |

### schedule

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 6.475 | 9.975 |
| program_lookup | 4.088 | 4.463 |
| guards | 16.950 | 18.288 |
| arrays | 2.175 | 2.962 |
| array_snapshot_rollback | 0.800 | 0.850 |
| arena_capacity | 0.713 | 0.850 |
| staged_payload_copy | 1.825 | 1.938 |
| control_writes | 1.562 | 1.625 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 32.475 | 33.062 |
| result_prepare | 2.350 | 2.175 |
| result | 1.050 | 0.950 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 53.200 | 52.962 |

### Task.runTask

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 8.575 | 9.225 |
| program_lookup | 17.012 | 18.075 |
| guards | 45.663 | 49.837 |
| arrays | 5.112 | 5.475 |
| array_snapshot_rollback | 1.012 | 1.225 |
| arena_capacity | 1.050 | 1.212 |
| staged_payload_copy | 2.250 | 2.550 |
| control_writes | 2.200 | 2.413 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 52.513 | 63.737 |
| result_prepare | 3.700 | 4.500 |
| result | 2.675 | 3.087 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 66.350 | 71.338 |

### HandlerTask.fn

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 8.925 | 8.700 |
| program_lookup | 12.262 | 12.963 |
| guards | 25.288 | 25.950 |
| arrays | 4.237 | 4.000 |
| array_snapshot_rollback | 1.700 | 1.150 |
| arena_capacity | 1.137 | 1.238 |
| staged_payload_copy | 2.150 | 2.288 |
| control_writes | 2.250 | 2.150 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 53.163 | 58.763 |
| result_prepare | 3.800 | 3.950 |
| result | 2.550 | 2.763 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 62.600 | 66.338 |

### DeviceTask.fn

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 10.588 | 9.150 |
| program_lookup | 7.838 | 9.012 |
| guards | 24.738 | 24.700 |
| arrays | 4.338 | 3.775 |
| array_snapshot_rollback | 1.175 | 1.663 |
| arena_capacity | 1.087 | 1.325 |
| staged_payload_copy | 2.163 | 2.325 |
| control_writes | 2.337 | 2.400 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 60.625 | 62.413 |
| result_prepare | 4.013 | 3.913 |
| result | 2.875 | 2.712 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 90.862 | 79.450 |

### Task.qpkt

| Other component | v7 us | v8 us |
|---|---:|---:|
| binding | 7.963 | 10.412 |
| program_lookup | 14.188 | 20.000 |
| guards | 33.900 | 44.812 |
| arrays | 4.350 | 5.862 |
| array_snapshot_rollback | 1.012 | 1.512 |
| arena_capacity | 1.025 | 1.262 |
| staged_payload_copy | 2.225 | 2.675 |
| control_writes | 2.138 | 2.712 |
| recursion_frame_scan | 0.000 | 0.000 |
| unloader_init | 50.175 | 57.500 |
| result_prepare | 3.675 | 5.775 |
| result | 2.663 | 3.087 |
| rng_store | 0.000 | 0.000 |
| shape_prepare | 0.000 | 0.000 |
| boundary_init | 0.000 | 0.000 |
| boundary_discard | 0.000 | 0.000 |
| result_validation | 0.000 | 0.000 |
| bookkeeping | 54.288 | 68.900 |

Evidence: S46-TEN-BOUND.json retains source and receipt hashes. Source/input/shim/application checks are in each pass complete.json and each program complete.json. The earlier 33-program selection remains2022captured/100verified/2deployed,2programs. The86sub-microsecond Python regions have no measured standalone profitable route; their useful direction remains compiled callers/inlining, as CHECKPOINT80 records.
