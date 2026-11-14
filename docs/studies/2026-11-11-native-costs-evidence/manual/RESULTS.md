The controlled Barnes diagnostic reduced the kernel from46.5740ms to29.7802ms with a manual float contract plus four advances per compiled call. This is36.1% less kernel time (1.564x speedup), with3.274x the freshly measured C time remaining. These are diagnostic source/call-boundary variants, not production equivalence claims. The separate unchanged-source compiler comparison is in ../wave6-proof-study.

Source snapshot:0aeb157e8d272e0b1d4787a173f5b66f75d81b01, producte35dce1b7cef4019400696a9d7712ae8571a0b81. Frozen performed manifest results-v2/manifest.json SHA25677e07518f29ec54d697de1bd6ee94486b74fe89622cec4a5bd09a71d3e902795. Initial results/ was preparation-only and never executed. Final protocol: PROTOCOL.md. Complete raw stdout/stderr, exits, plans, binary hashes, state evidence, samples and component details are under results-v2/; machine-readable analysis: results-v2/ANALYSIS.json.

| Case | Kernel median ms | Process median ms | Kernel time/C | Actual timing AOT calls |
|---|---:|---:|---:|---:|
| Plain CPython |522.1456|2793.5390|57.412|—|
| Unchanged C |9.0947|203.1886|1.000|—|
| Current direct |46.5740|512.2342|5.121|2500|
| Current wrapper1 |47.1924|508.3246|5.189|2500|
| Current wrapper4 |34.2558|449.5427|3.767|625|
| Force-only direct |42.6232|481.7418|4.687|2500|
| Full-float direct |42.0559|482.9427|4.624|2500|
| Full-float wrapper4 |29.7802|427.8337|3.274|625|

All40 fresh timing processes passed the same three numeric output checks. Each process uses best-of-five freshly reset Python/RP states; C uses best-of20, fixed across cases. Reported kernel median is the median of five process bests. Process wall covers five versus20 inner states respectively and should not be interpreted as a single-state kernel comparison. All six RP rows use heapRegion and explicit manual target-only --force policy. Timing totals above span five processes; separate state audits use100calls for group1 and25 for group4. All actual JIT/fallback/rejected/unknown counts were zero. Instrumented state/phase audits are excluded from headline timings.

Wrapper1 was1.33% slower than direct, so introducing the caller alone did not improve this run. Wrapper4 used27.41% less time than wrapper1. Force-only used8.48% less time than current direct; full-float used9.70% less. Full-float wrapper4 used29.19% less than full-float direct and13.07% less than current wrapper4. These are measured contrasts, not independent additive contributions or general performance guarantees.

The separate instrumented warm component medians explain the broad pattern:

| Case | Load ms | Guards ms | Native ms | Writeback ms | Other attempt ms |
|---|---:|---:|---:|---:|---:|
| Current direct |9.4350|0.7553|27.6080|3.2305|4.3638|
| Current wrapper1 |9.6802|0.7807|27.5342|3.2382|4.3273|
| Current wrapper4 |2.4667|0.2322|27.3371|0.8440|1.2603|
| Force-only direct |9.2318|0.7333|23.7675|3.2703|4.2457|
| Full-float direct |9.7977|0.7618|23.8953|3.4985|4.2726|
| Full-float wrapper4 |2.3624|0.2205|22.8255|0.8670|1.1022|

Each component row groups100/group Region attempts per state reset, excludes the first of six resets and reports each component's own five-reset median. Result conversion is0.0112–0.0424ms. These separately instrumented component medians need not sum to the uninstrumented headline, and no whole-kernel warm six-reset median was captured (phase stdout is best-of-six only). Native timing includes observer overhead. All2700 phase attempts succeeded with2700 actual AOT calls, no JIT/fallback or imported Numba. Group4 retained more temporary allocation: current max arena top7538→19733slots; full-float5867→16673slots. Capacity stayed65536slots/524288bytes and there were zero growth-status2 exits/replays in all cases. Grouping therefore includes changed callgraph/inlining and retention; it is not a pure boundary subtraction and does not justify arbitrary lifetime resets.

Twelve separate plain/native audits retained full initial/final1400-scalar vectors and per-step numeric/type/alias hashes. All numeric bits and mutable alias labels matched at common logical steps (4,8,...100 for group4). Native types matched each variant's own plain execution at every checkpoint. Original/force-only/wrapper variants also matched control types at every checkpoint. Full-float differed in type at every retained post-step checkpoint, as declared: final acceleration.x and acceleration.y each changed200int zeros to float zeros; initial state had402 type differences (the400 acceleration fields plus one velocity.x and one velocity.y). No universal Python equivalence claim follows from this finite float/zero corpus. Full per-step evidence and independent actual-counter reconciliation: results-v2/checkpoint-postverification.json.

Five fresh profile/build processes cost277.188s total; compile-only warmup0.923s; twelve state-audit children6.893s; six phase children3.312s. Exact current direct reused historical90.570s profile evidence and its already verified AOT binary; that cost is not a fresh wave6 measurement. Its driver still executes at the original exact path, with source/runtime/environment/driver/artifact provenance retained. All latency runs and audits here are fresh. No profile cost is included in kernel or process-wall medians.

C remains the identical Clang21.1.6 binary built with-O3 -march=native -ffp-contract=off; RP uses the current generic Numba AOT CPU/features target. The effect of ISA/tuning mismatch is unmeasured and cannot be assigned to Python semantics. Unknown external background CPU load persisted; only team jobs were serialized. Five rotating fresh repetitions and all samples are retained, without claiming OS-wide quiet. Static instruction counts do not establish cycle costs. Production compiler improvement is measured separately on unchanged source; these manual contracts only identify headroom.
