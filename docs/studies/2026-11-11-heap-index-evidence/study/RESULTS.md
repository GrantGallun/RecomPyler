# Nonnegative object-field indexing: matched results

Current baseline `3f0370d5fe5c358b4a0b3fd8e1ea10a2f22f87bf` (product 0d2c3d3), candidate `e35dce1b7cef4019400696a9d7712ae8571a0b81`. Manifest SHA256 `158e4e6183652faa1318c47dc3c9ee7a4a8946a178829919f92e26bd806ea392`. All 18 fresh profiles, 300 ordinary timing children, 42 independent mode audits and both separate six-repetition Barnes phase jobs succeeded. Numeric checks matched in every timing/audit/phase process; no timeout or unknown actual audit mode. Final source/runtime/input/AOT-artifact/bytecode checks passed. The CPU slot was explicitly released before further team validation.

The narrow change removes signed-negative-index normalization only from proved physical object fields/tags. Python container indices, nullable tuple payload reads, raw ndarray strides, helpers and fallback checks stay unchanged. This is no new frontend coverage claim. The inherited tuple-field return identity limitation remains outside this change; matching these finite checks is not universal Python equivalence.

## Targeted heap-region observations

Uninstrumented kernel metric: median of five fresh-process best-of-five inner times. Explicit warm/forced policy is declared in the protocol, not chosen from results. The matched C column is newly timed common best-of20-inner observations, also median over five processes. Smaller time is better.

| Targeted region | Baseline ms | Candidate ms | Candidate time change | Candidate/C time | Actual path B → C |
|---|---:|---:|---:|---:|---|
| barnes_hut | 49.0671 | 47.4893 | -3.22% | 5.21x | heapRegion/AOT → heapRegion/AOT |
| float | 1.4408 | 1.4058 | -2.43% | 1.26x | heapRegion/AOT → heapRegion/AOT |
| richards | 1.0618 | 1.1021 | +3.80% | 5.96x | heapRegion/JIT/cache → heapRegion/JIT/cache |
| raytrace | 4.4852 | 4.2369 | -5.54% | 7.02x | heapRegion/AOT → heapRegion/AOT |

Barnes forced median best kernel fell 49.0671→47.4893ms (3.2% less time, 1.0332x speed). Float and raytrace also fell in this sample, while basic Richards JIT increased. These are observations on a shared Windows machine with an unknown external CPU consumer; five samples do not establish statistical significance or exclusive attribution. All sample vectors are retained, including regressions and alternative default results.

## All 13 matched kernel rows

| Kernel | C ms | Python ms | Baseline ms | Candidate ms | Candidate/C time | Python/candidate speed | Candidate engine |
|---|---:|---:|---:|---:|---:|---:|---|
| barnes_hut | 9.1083 | 535.6739 | 49.0671 | 47.4893 | 5.21x | 11.28x | heapRegion/AOT |
| nbody | 3.1204 | 68.6265 | 3.6052 | 3.7626 | 1.21x | 18.24x | ordinaryLifted/AOT |
| float | 1.1182 | 40.3615 | 1.4408 | 1.4058 | 1.26x | 28.71x | heapRegion/AOT |
| scimark/sor | 0.1690 | 65.5554 | 65.1293 | 65.9569 | 390.19x | 0.99x | Python |
| scimark/sparse_mat_mult | 0.0107 | 2.2399 | 2.2478 | 2.2411 | 208.88x | 1.00x | Python |
| scimark/monte_carlo | 0.2384 | 36.6984 | 36.8571 | 36.6789 | 153.84x | 1.00x | Python |
| scimark/lu | 0.0432 | 54.0810 | 54.4881 | 54.6993 | 1267.54x | 0.99x | Python |
| scimark/fft | 0.4258 | 157.5269 | 2.7296 | 2.6590 | 6.24x | 59.24x | ordinaryLifted/JIT/cache; ordinaryLifted/AOT |
| fannkuch | 12.2466 | 213.7134 | 23.4061 | 23.6076 | 1.93x | 9.05x | ordinaryLifted/AOT |
| spectral_norm | 0.5178 | 56.9633 | 24.1595 | 24.9762 | 48.23x | 2.28x | ordinaryLifted/JIT/cache helpers; outer Python |
| coroutines | 0.1194 | 13.6387 | 1.2229 | 1.2113 | 10.14x | 11.26x | heapRegion/AOT |
| richards | 0.1850 | 23.1199 | 1.0618 | 1.1021 | 5.96x | 20.98x | heapRegion/JIT/cache |
| raytrace | 0.6039 | 157.2279 | 4.4852 | 4.2369 | 7.02x | 37.11x | heapRegion/AOT |

The four non-FFT SciMark components execute Python, so their C gaps are not native instruction overhead. SciMark's warm candidate FFT path is mixed ordinary JIT/AOT: FFT_transform uses JIT and FFT_inverse uses AOT, while both are AOT in the baseline. Both sources additionally JIT _total outside the FFT kernel timer. Do not attribute FFT timing differences to this heap-index optimization or assign aggregate workload counters to every SciMark row. Spectral norm uses ordinary JIT helpers with outer Python work.

Nbody is an unchanged ordinary-AotLifted control, not the modified heap engine. Its median 3.6052→3.7626ms increase is retained; sample ranges overlap strongly (baseline 3.5156–3.8052ms, candidate 3.5253–3.9312ms). Independent actual PE comparison finds .text and .pdata bytes identical. No additional timing cohort was run and no changed nbody instruction claim is made.

## Complete-process walls

Seconds per whole driver containing five inner states (SciMark includes all five kernels). Default is unforced deployment. Selected view is the predeclared forced/warm kernel diagnostic, and its wall includes startup/compiler loading/JIT if used; kernel speed is not whole-process speed.

| Workload | Python s | Default B → C s | Selected B → C s | Selected view |
|---|---:|---:|---:|---|
| barnes_hut | 2.843233 | 0.529219 → 0.517286 | 0.524897 → 0.518646 | forced |
| nbody | 0.465437 | 0.487412 → 0.475881 | 0.237113 → 0.235076 | forced |
| float | 0.340208 | 0.335464 → 0.334969 | 0.238192 → 0.238023 | forced |
| scimark | 1.794916 | 1.132783 → 1.114076 | 1.549684 → 1.555081 | warm |
| fannkuch | 1.220308 | 0.344431 → 0.340281 | 0.349346 → 0.347561 | forced |
| spectral_norm | 0.423815 | 0.425785 → 0.429532 | 0.811255 → 0.818090 | warm |
| coroutines | 0.188793 | 0.200291 → 0.197366 | 0.223992 → 0.230083 | forced |
| richards | 0.240448 | 0.250624 → 0.245534 | 1.147580 → 1.142657 | warm |
| raytrace | 0.928230 | 0.940227 → 0.950579 | 0.370617 → 0.369598 | forced |

## Separate Barnes attribution and actual machine code

Each source's instrumented diagnostic made 600 successful AOT advance calls (100 per repetition), zero JIT/fallback, with matching numeric checks. Excluding the first repetition, native-extension-entry medians were 31.4393→27.4435ms; instrumented whole-kernel medians 51.8119→48.0503ms. Load 9.2806→9.4542ms, write-back 3.3203→3.2936ms and guards 0.7393→0.7541ms stayed roughly similar. All six per-repetition component records are in SUMMARY.json. Timers add overhead; native entry includes the ABI wrapper, and independently selected component medians are not an exact additive partition. These figures do not replace the uninstrumented headline samples.

The newly built, actually audited r0 exports are mapped to PE SHA/digest/wrapper addresses in results/diagnostics. The independent wave5-instructions/REPORT.md follows wrapper call targets into the actual selected artifacts: the identified QuadTree mass-field load shrinks from five instructions to one, force cmovl 18→1 and sar63 5→2. Remaining normalization corresponds to deliberately unchanged list paths; MIXED/exact-integer, recursion/status and representation work remain. These are static facts, not cycles, dynamic frequencies or a predicted fivefold speedup. Profiling JIT LLVM is not relabeled as this AOT assembly.

## Costs and evidence

Fresh combined capture/verification/source-construction/JIT/AOT/startup-probe wall was baseline 287.98s and candidate 284.81s. Compile-only warmups12.36s; separate audits24.32s. Those costs and phase instrumentation are separate from ordinary timings. The API does not provide a clean build-only timer.

SUMMARY.json retains all 13 rows with source hashes, engines, exact per-function AOT/JIT/fallback timing counters, separate audit composition, all kernel/wall sample vectors, selected/default walls, profile costs and six-repetition phase evidence. Complete process records/stdout/stderr/counts/plans, frozen bytecode/artifact identities and actual binaries remain under results/. Both exact current source trees use the same controlled warm-bytecode procedure. C binaries are unchanged hash-verified clang 21.1.6 -O3/-march=native/-ffp-contract=off/UCRT ports; they were newly timed, not rebuilt, and are optimized comparisons rather than proof of optimal assembly. The known C/Python lifetime and representation caveats remain.
