The compact recursive ABI reduced Barnes kernel time from **47.4918 ms to 35.8288 ms**: **24.56% less time, 1.326× speedup**. Fresh unchanged C measured 9.115458 ms, so candidate kernel time is **3.931× C**, down from the current baseline's 5.210×. Whole-process median improved **8.53%**, from 559.6180 to 511.8625 ms. The Python workload and numeric contracts are unchanged.

Baseline is current source `5d0fe5296e077b893a0d9c920f6ccfe798696eeb`, product `9ff4908fdc58613d72287f71cfc6b70aa5e693ff`; candidate is clean `a033ca14c40afed052a6266a0a575f6cc11559ea`. All processes execute the original exact `wave5-study/results/drivers/barnes_hut.py` path. Performed primary manifest SHA256: `308adefb126b9d36f4742ec29bb4590f807d2955293f168aa2c90d0dd6bcaabc`. Controls manifest: `3696d2640f48ead8dc5ca89d8aa3086e6af4691e711871e1682db4733e538516`. Raw evidence, all counters and costs are in `results/ANALYSIS.json` and `results-regression/`.

| Case | Median kernel ms | Five kernel samples ms, process order | Median process ms | Actual timing AOT/JIT/fallback |
|---|---:|---|---:|---|
| Plain CPython |552.2853|554.7885, 552.2853, 539.0740, 553.1052, 529.8457|2961.4642|—|
| Unchanged C |9.115458|9.131670, 9.114265, 9.126186, 9.115458, 9.093523|207.7995|—|
| Current baseline |47.4918|46.9036, 47.4918, 50.7206, 49.4300, 47.4779|559.6180|2500 / 0 / 0|
| Compact ABI candidate |35.8288|35.8818, 35.6484, 36.5932, 35.8288, 35.0590|511.8625|2500 / 0 / 0|

These are five rotating fresh processes per case. Each Python/RP process reports its best of five state-reset kernels; C reports best of 20, unchanged across versions. Kernel medians are medians of those process bests. Process wall includes startup, cold source reconstruction and five versus 20 states respectively, so it is not a single-state kernel comparison. All 20 processes passed the same three exact numeric checks. Both RP rows use the same explicit target-only forced AOT policy, not a claim about automatically selected default deployment. Baseline and candidate kernel sample ranges do not overlap in this run; no formal confidence interval or otherwise quiet OS is claimed.

Three separate Barnes state processes (plain, baseline, candidate) retained full initial/final 1400-scalar numeric/type vectors and mutable identity/alias labels, plus all 100 post-step numeric/type/alias hashes. All match exactly, including intermediate Python types. Each native audit observed 100 successful actual AOT calls, zero JIT/fallback/rejected/unknown, exact reconciliation with product counters and no Numba import. Evidence: `results/checkpoint-postverification.json`. The same original objects and field types are preserved on this corpus. These finite checks do not establish universal Python equivalence.

Separate instrumented phase results expose where the time remains:

| Warm phase median per 100 advances | Baseline ms | Candidate ms |
|---|---:|---:|
| Load |10.4110|9.8389|
| Guards |0.8569|0.7617|
| Native entries |30.6576|17.4821|
| Result |0.0478|0.0372|
| Writeback |3.6494|3.5889|
| Other attempt |4.7906|4.6390|
| Attempt total |50.5733|36.6521|
| Instrumented whole kernel, including external Python energy |53.8001|39.5747|

Each component is its own median of five warm resets after excluding the first of six. Raw per-reset values and all six whole-kernel times are retained. The separately instrumented native component decreased while boundary load/writeback costs remained substantial. Components include observer overhead and their independent medians need not sum to the uninstrumented headline. This does not assign cycles to individual static instructions or turn phase medians into additive counterfactual savings. The root reviewer separately maps the actual selected AOT/C machine code.

Cold instrumented whole kernels were 170.9959 ms baseline and 187.8845 ms candidate. The single observed `Region.program_for` call took **47.990 ms versus 65.311 ms**. It includes cold saved-graph/source reconstruction, AOT preparation/validation and nested load; it overlaps other phase attribution and is not a pure source-restore timer. Later successful calls use the prepared fastpath and bypass this method, so no cached-call zero or median is invented. First-attempt other time was 47.8370 versus 65.0662 ms. The higher measured cold preparation cost limits how much the kernel gain appears in whole-process time. The driver `_times` timer starts after initial state construction/energy and before first advance; first-use imports and reconstruction can therefore enter its cold value.

Each phase process completed 600 successful actual AOT calls with zero JIT/fallback and no imported Numba. Both used the same 65,536-slot / 524,288-byte capacity, maximum top 7,538 slots, and zero growth-status2 exits/replays. The allocation watermark is not a live-memory or lifetime proof. No boundary grouping, type relaxation, array rewrite or wider compiled loop was introduced this wave.

Three independent bounded generality controls also passed on both sources:

| Control | Work checked | Actual native audit calls |
|---|---|---:|
| Recursive object |127-node tree reduction; float result and unchanged fields/object identities|8 AOT/source|
| Recursive containers |12-node recursion; shared mutable list, negative indexing, exact updates and identities|8 AOT/source|
| Recursive returns |16-node chain; recursive tuple/object returns, original object identity and exact types|8 AOT/source|

All six fresh control profiles verified; all nine plain/native audit processes had matching output and successful exits. The six native audits total 48 actual AOT calls, zero JIT/fallback/rejected/unknown, exact product-counter reconciliation and no Numba import. No C comparison or speed claim is made for these tiny controls. They are separate from the implementer's complete compiler suite and from Barnes timing.

Fresh Barnes profile/capture/verification/AOT-build cost was **65.160 s**. Current baseline reused only its exact verified wave6 proof-candidate AOT/profile, with **56.731 s historical profile cost**; no old timing was reused. Six fresh control profiles cost **38.997 s** total. Primary compile-only warmup cost 1.472 s, three state-audit children 1.949 s, two phase children 1.230 s. These costs are excluded from latency medians. Equal checked-hash bytecode warmup covered both complete source trees, shim, original driver and union profile dependencies; then bytecode was frozen and writes disabled. All final source/runtime/package/environment/input/helper/AOT/bytecode fingerprints verified.

Actual selected AOT maps are `results/baseline-aot-map.json` and `results/candidate-aot-map.json`. Baseline uses current `ab7a5260...` / r0 / PE SHA256 `94afcc7b...`. Candidate uses digest `8b850a3ec40ed1c9992ac80e245679f7e785fa6b866f2c2a6a64d7f9f892e495`, export r0, wrapper RVA `0x11d0`, PE SHA256 `76a7b0c2a9475553633ed9aa1621d27bdb4af76abdd3e5cbfeb2b5b37f6ea564`. These come from successful actual 100-call audits, not available exports or profiling JIT. Mapping loads extension modules to recover addresses without executing kernels, compiling or timing. Control selected-artifact maps are retained per program/source as well.

`SOURCE-DIFF-NOTES.json` discloses raw provenance: heap source changes semantically; `_region_seed.py` additionally differs only in LF versus CRLF bytes. Baseline seed SHA256 is `cbca700e...`; candidate is `e9fd4e12...`; newline-normalized source is identical. The measured candidate, complete suite and AOT fixtures used the frozen CRLF bytes. Neither source tree, manifest nor helper was changed after freeze, and baseline reuse strictly matches the LF baseline bytes.

C remains the unchanged Clang 21.1.6 binary using `-O3 -march=native -ffp-contract=off`; RP uses the current generic CPU/features AOT target. ISA/tuning impact is unmeasured and cannot be assigned to Python semantics. Unknown external background load persisted; team jobs were serialized and process order rotated, without OS-wide exclusivity. All samples, stdout/stderr, exits and actual modes are preserved. No failures, timeouts or invalid modes were excluded, and no extra cohort was added to seek a favorable result.
