# Fresh-process native reuse study

The fresh-process reuse fix is validated and the fixed-population, longer-workload and matched C studies are complete. The concrete improvement is reliable saved-native deployment on longer Richards_super. The short held-out cohort still executes no RecomPyler-native work.

## Fixed-population results

| Population | Meaningful timing pairs | Previous integration / Python speed | Candidate / Python speed | Programs executing RecomPyler native calls |
|---|---:|---:|---:|---:|
| Held out, fixed 38 | 37 | 0.959742x | 0.958756x | 0 â†’ 0 |
| Tuned regression set | 9 | 1.289856x | 1.294033x | 4 â†’ 4 |
| Separate Go/poker additions | 2 | 0.971665x | 0.988961x | 0 â†’ 0 |

These are geometric means of complete-process median timings; above one is faster than direct CPython. The candidate takes about 4.3% longer than CPython on the paired short held-out set. Relative to the matched previous integration, the observed held-out speed difference is -0.10% and the tuned difference +0.32%: no meaningful broad speed improvement is established by these small differences. Both versions selected ordinary Python/library execution for every short held-out workload.

The four tuned deployed programs are Barnesâ€“Hut, fannkuch, raytrace and SciMark FFT. Candidate latency processes recorded **2,020 AOT calls, zero JIT calls and zero selected-wrapper fallbacks** over five repetitions. Five separate audits independently confirmed the same aggregate AOT composition for each source. Baseline latency records lack exact mode counters; the audits classify their own processes rather than retroactively identifying baseline timing modes. Native/library work done internally by NumPy or other packages is outside these RecomPyler counters. Unselected Python execution is not counted as a selected-wrapper fallback.

The mean largest verified-candidate opportunity proxy fell from 3.646% to 2.941% on the fixed held-out denominator; three programs exceed 10% in both versions. Tuned proxy values are 54.216% versus 50.791%. These timing-derived proxies are retained as observed, not interpreted as proof of new language support, union coverage or actual native time. Actual held-out native deployment stayed zero.

All **98 fresh profiles, 735 latency processes and 490 audit processes** completed successfully. All latency outputs/exits matched the corresponding stable Python runs; all 98 source/workload audit sets reconciled with no unknown native mode. Another 98 compile-only warmup processes succeeded, and final source/runtime/input/bytecode checks passed. Fresh capture/verification/build wall totals were 480.663 seconds baseline and 484.941 seconds candidate. Audit and warmup costs are separate.

Go measured 0.960577x â†’ 0.966510x Python; two-deal poker measured 0.982882x â†’ 1.011933x, with no native calls. The small poker result establishes no general bot acceleration.

## Longer-workload deployment result

The predeclared diagnostic uses the same chaos and Richards_super bodies with 20 shim loops rather than two. It does not change the fixed 38-program denominator.

| Workload | Python median | Previous integration median | Candidate median | Candidate / Python speed | Candidate native calls across five timing processes |
|---|---:|---:|---:|---:|---:|
| chaos | 0.850025 s | 0.869808 s | 0.872031 s | 0.974765x | 0 |
| Richards_super | 0.689172 s | 0.974361 s | 0.382138 s | 1.803462x | 100 AOT, 0 JIT, 0 fallback |

Richards_super now executes the selected hot region through saved native code in each fresh process. The prior version rejected that code and recorded 100 Python fallbacks across five latency runs. The candidate is **2.54976x the previous plugin's speed** and **1.80346x CPython's speed** on this diagnostic. Five separate audits per source reproduce the respective 100-fallback and 100-AOT totals, with no unknown modes and no Numba import in any audit process. This is a measured whole-process deployment improvement, not just artifact availability or a warm-kernel estimate.

All four fresh long profiles, 30 latency processes and 20 audit processes completed successfully, with matching latency/audit outputs and reconciled execution evidence. The candidate Richards profile took 178.267 seconds, within the unchanged 180-second per-process limit. Profiling, verification and building remain substantial one-time costs excluded from the 0.382-second run; a new user must amortize them over repeated execution. Chaos stayed on the ordinary Python/library path and did not gain speed.

## Current gap to optimized C

Both source versions were freshly profiled and executed against nine unchanged matched C ports. All reported numeric check values matched, and all 42 separate mode audits reconciled. The table shows best warm kernels, with startup/setup/profile excluded. The Richards row is the basic benchmark variant under explicit warm selection, distinct from the longer held-out Richards_super above.

| Candidate kernel | Candidate time / C | Python / candidate speed | Actual path |
|---|---:|---:|---|
| nbody | 1.14x | 19.17x | AOT |
| float | 1.40x | 28.57x | AOT |
| fannkuch | 1.92x | 9.21x | AOT |
| Richards, explicit warm | 5.78x | 20.95x | JIT |
| Barnesâ€“Hut | 5.74x | 10.09x | AOT |
| SciMark FFT | 6.49x | 57.26x | AOT |
| raytrace | 7.42x | 35.11x | AOT |
| coroutines | 9.51x | 11.33x | AOT |
| spectral norm | 47.33x | 2.40x | JIT helpers; outer work remains Python |

Four other SciMark kernels (SOR, sparse multiplication, Monte Carlo and LU) remained in Python; their large C gaps are not native-instruction overhead. Only FFT_transform and FFT_inverse had successful native calls in the SciMark audit. All 13 kernel rows and both sources' raw times are retained in the separate native report and compact comparison.

The warm body results do not establish broad progress toward C over the previous integration. Nbody stayed approximately 3.56 ms, while Barnesâ€“Hut rose from 49.25 to 52.32 ms; both positive and negative differences remain in the report. Small differences in best-of-five observations, and differences in each side's C reference timing, have no statistical or causal guarantee.

The basic Richards explicit warm process still used JIT in both versions and took 8.28 seconds for the candidate despite a 1.085 ms best kernel. This is not the default long Richards_super AOT result. Startup, selected policy and native body speed must remain separate.

## Next constraints exposed by the evidence

Reliable guarded reuse is now demonstrated for representable typed programs; it does not itself expand the supported frontend or make short workloads profitable. The fixed held-out native count remains zero. The next coverage work should target ordinary captured call forms, closures/function-valued arguments, standard numeric buffers, partially initialized/dynamic object fields and file-aware deployment in imported modules.

Mixed Python/native regions need explicit state recovery and exactly-once effects, so unsupported calls can coexist with a supported hot loop. For object-rich native kernels, reducing representation, copying, allocation and repeated boundary/guard costs is the route suggested by the larger C gaps. Efficient simple numeric kernels already demonstrate that the backend can approach C on suitable inputs. These are future priorities, not features claimed by this change. Observable Python behavior must remain guarded or execute through Python.

## Revisions and correctness

The comparator is the previous completed integration, `dba45a7379402ea33664a5754a2fe6f0927b6855`, in a new independent snapshot. The candidate is `0d2c3d33215f7c289b89944214d4c7b8eaf9ac89` on `codex/integrated-coverage`. All tracked product source/tests in the integration checkout were byte-compared with the worker's tested tree. The original working branch, index and uncommitted changes are preserved; only its separate integration branch ref was updated.

The final complete suite passed **383 tests plus 38 subtests**, with ten warnings, no failures and no skips. Targeted validation passed 75 native, execution-mode and CLI tests. Independent whole-branch review found two issues, both corrected in one combined change and cleared by a scoped re-review. Earlier review also corrected rejection hooks, signature changes, startup-only dependency validation and new math-operation validation; transcripts remain in the evidence archive.

The real held-out Richards_super gate builds from populated globals, then executes from empty globals in four fresh processes, with two object loaders and hash seeds 17, 29, 37 and 53. Every process ran one saved native call: **AOT 1, JIT 0, fallback 0**, with no Numba import. Values matched 9,297 holds and 23,246 queued packets, and the global state retained its identity. The final build produced three exports and two inference seeds. This establishes reuse for this workload and these cases; it is not a speed measurement or proof for arbitrary Python.

## What changed

Profiling used to infer object layouts from populated global graphs, while deployment inferred from initially empty graphs. Both could generate internally valid but incompatible class tags, fields and function order. Unordered class checks added independent source variation. The exact digest check correctly rejected incompatible code.

The new path saves versioned, data-only type/layout information. Strict descriptions retain original specializations; widened descriptions preserve empty startup branches. It restores no mutable user values. It resolves current live bindings, regenerates normal code and guards, and requires exact source/metadata compatibility before choosing the saved native export. Loaders still validate current values, types, aliases and cycles.

Newly reachable startup branches may introduce functions or constructors absent from the warm profile. A sealed dependency description validates their code, defaults, constructors and inheritance before regeneration, with live checks for later changes. Build-time math compatibility checks also cover newly generated operations. Parameter/return machine formats and constant-return contracts must stay compatible. Metadata rejection cannot enter speculative JIT; default AOT-only budgets and explicit JIT/force policies remain separate.

If any original specialization cannot receive a valid guarded strict description, the whole function retains its original exact-source exports with an explicitly recorded legacy-only policy. Partial metadata cannot hide another valid legacy export. This conservatively preserves baseline behavior for cases such as generator-code constants or unused mutable defaults; it does not claim guarded cold-layout reuse for those functions.

Successful AOT and JIT/cache-backed native calls are now counted separately after state commit, using the program actually executed. Failed preparation, retries and Python fallback do not count as successful native work. Export availability and the conservative historical boolean remain separate metadata.

## Measurement protocol

The fixed population remains 38 held-out and nine tuned workloads. Go and two-deal poker remain separate additions. The no-op python_startup entry remains recorded and is excluded from meaningful timing. Both sources receive fresh profiles: limit 40, eight samples, two shim loops, five rotating fresh-process latency repetitions and 180-second timeout, default unforced selection. Five separate untimed mode audits per source/workload check real native execution and reconciliation without adding audit overhead to latency.

Both complete source trees, shim and workload are warmed into a task-owned bytecode prefix before profiling and again before latency. Fresh profiles populate a shared runtime-dependency union; the bytecode inventory is then frozen and writes disabled. Existing source-side pycs are excluded. This corrects the unequal cache conditions in the earlier study; historical speed numbers are context, while the new dba baseline is the comparator. Profiling/building, warmup and audits remain separate from latency.

An initial run at `afd09b0` was stopped after mixed-signature coverage loss was found. Four workloads completed; base64 was interrupted. Its manifest, outputs, plans and caches are retained as partial evidence and never resumed or pooled with final results. The final fixed study is `wave3-study/results-v2`; the predeclared longer chaos/Richards_super diagnostic is `results-long-v2`. No source or harness edits are allowed during these runs.

Native C comparisons freshly executed both source versions and the same nine hash-verified C ports, retaining 13 kernel rows including Python fallback. C binaries retain the previous local clang `-O3 -march=native -ffp-contract=off` build and UCRT linkage; no new C build is claimed. Warm kernel best times exclude setup/startup/profile and use five repetitions for Python/RecomPyler versus 20 for C. Full process walls and actual native modes remain separate. These ports are optimized comparisons, not proof of optimal assembly.

## Interpretation limits

Largest verified-candidate profile share is an opportunity proxy, not union coverage or time actually spent in native code. Native-call totals and the number of workloads executing native code are deployment evidence, not an executed-runtime percentage. JIT counts include disk-cache-backed native execution and do not prove a fresh compilation or cache hit.

Most pyperformance workloads print no result. Matching stdout/exit is useful finite evidence, not full semantic equivalence; captured sample checks, native-port numeric checks and regressions provide additional evidence. Measurements are observations on one Windows machine, not a statistical guarantee.

NumPy source helpers can still import Numba before AOT lookup. The fixed non-NumPy Richards gate establishes no compiler import for that case, not a universal no-import guarantee. Unrepresentable metadata and unsupported operations still use conservative fallback or the legacy exact-source path. Broad Python coverage and universal C-speed execution remain unproven.

## Evidence and reproduction

The adjacent `2026-11-11-reuse-evidence` archive contains compact fixed/long metrics, the full 26-row native comparison, implementation and independent review reports, final test transcripts and historical scripts. Raw fixed/long records and manifests remain in `D:/Code/Datathon/recompyler-codex-20261111/wave3-study/results-v2` and `results-long-v2`. Native records remain in `wave3-native-baseline` and `wave3-native`; the rebuilt real-workload gate is in `review-scratch/wave3-real-richards-v2`. Manifest identities and archive hashes are retained.

Historical scripts require the recorded local layout or adaptation and a new manifest. Profiling/building must be repeated when generator/type-schema compatibility changes. None of this work was pushed or merged into the user's current working branch.
