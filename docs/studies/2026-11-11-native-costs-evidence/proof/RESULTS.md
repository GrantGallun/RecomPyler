The unchanged-source compiler proof change showed no measured Barnes speedup: kernel median47.2972→47.4359ms (+0.293% time;0.9971x speedup), with strongly overlapping five-run distributions. Fresh C was9.123802ms, leaving candidate kernel time5.199x C. Preserve this result independently of the faster manual-contract diagnostic in ../wave6-study/RESULTS.md.

Baseline is clean0aeb157e8d272e0b1d4787a173f5b66f75d81b01 (producte35dce1b7cef4019400696a9d7712ae8571a0b81). Candidate is clean9ff4908fdc58613d72287f71cfc6b70aa5e693ff, heap SHA256e7ee3bb1fb2b8c42a6848383388ef28ed3eaf79e6a1f50e0fc53b210570e5109. Both execute the identical original Barnes driver at its exact old path. Frozen manifest results/manifest.json SHA256b58ae5be6211787fae5a47cf5943b277d61443edf70a12e05d3cde6eda58c46d. Raw evidence and complete machine-readable results: results/ANALYSIS.json.

| Case | Kernel median ms | Five kernel samples ms | Process median ms | Timing AOT/JIT/fallback |
|---|---:|---|---:|---|
| Plain CPython |536.8640|537.1377,551.0031,536.8640,531.2906,529.9555|2897.2178|—|
| Unchanged C |9.123802|9.140491,9.123802,9.125948,9.114027,9.106398|206.0098|—|
| Baseline |47.2972|46.9322,47.7933,46.5808,51.8982,47.2972|530.8935|2500/0/0|
| Proof candidate |47.4359|46.6169,47.4857,48.0205,47.4359,46.2769|540.1634|2500/0/0|

All20 fresh timing children passed identical numeric checks. Each RP row is heapRegion under explicit target-only forced diagnostic policy. Python/RP process executes five fresh state resets and reports its best kernel; C executes20 and reports its best. The table is the median of five rotating fresh processes, with process wall measured separately. Candidate process wall was1.746% higher; no claim of statistical certainty or causal slowdown follows from five overlapping kernel samples on a shared machine.

Two separate native full-state audits each completed100actualAOT calls with zero JIT/fallback/rejected/unknown; actual auditor counts reconciled exactly with product counters, with no Numba import. Baseline, candidate and plain match all100 numerical, Python-type and mutable-alias checkpoint hashes plus full initial/final1400-scalar vectors and identity labels. Evidence: results/checkpoint-postverification.json. These finite checks support the unchanged workload result and do not establish universal semantics equivalence.

| Separately instrumented phase | Baseline ms | Candidate ms |
|---|---:|---:|
| Load |9.1300|10.6163|
| Guards |0.7185|0.7851|
| Native entries |27.5022|30.3387|
| Result |0.0334|0.0384|
| Writeback |3.3424|3.4514|
| Other attempt |4.3132|4.7613|
| Attempt total |45.3348|50.2293|

Phase values are individual component medians over five warm100-call resets, first of six excluded. Components were observed in separate sequential processes and all increased here, while uninstrumented kernel distributions overlap. This does not isolate a code-generation regression. No whole-kernel warm six-reset median was captured; stdout reports best-of-six only. Each source had600successful phaseAOT calls, zero JIT/fallback, no imported Numba,65536-slot/524288-byte capacity,7538-slot maximum top and zero growth retries.

Candidate fresh profile/capture/verification/AOT-build process cost56.731s. Baseline's exact verified AOT binary and90.570s profile cost are reused historical evidence, not a fresh profiling claim. All reported latency and state/phase audits are fresh and distinct from the manual-six matrix. Compile-only warmup and complete audit costs are in results/ANALYSIS.json. Bytecode was warmed equally for both complete source trees/shim/driver and union profile dependencies, frozen, then write-disabled. Source/runtime/package/environment/input/AOT/bytecode identity was verified before/after; no timeouts, output failures or invalid modes.

Actual successful AOT maps: results/baseline-aot-map.json and results/candidate-aot-map.json. Baseline selected digest a0f9dde9c40c4c638a5a799fba1be65e7c353ab533d9f75c68334174b1f19c1f, artifact SHA256226403d22c98758ad52a79d49d3daf4641f9e2cdd6b1cad9c6e23a11e5f7bc9e. Candidate digest ab7a5260a3ecad9c50cc0b5ca7997455e7a913b7da1c1c35ccdfc32c43c50e2a, artifact SHA25694afcc7bfed19eeb450e1f3aae3fe0f37aab6e48ba1e08ae1f3122997e4e2fda. Both successful r0 wrappers map toRVA0x19e0. These maps use actual selected100-call audits, not export availability or profiling JIT code; Mapping loads extension modules to recover wrapper addresses, without executing kernels, compiling or timing. Independent disassembly follows in root's instruction report; static instruction counts do not establish cycles.

RP uses generic CPU/features AOT; C is the unchanged Clang21.1.6 -O3 -march=native -ffp-contract=off binary. ISA/tuning impact is unmeasured. Unknown external background load means serialized team jobs do not imply an otherwise quiet OS. No extra cohort or follow-up timing was added to seek a favorable result.
