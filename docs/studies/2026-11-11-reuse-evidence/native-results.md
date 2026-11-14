# Matched native C diagnostic: fresh-process reuse

Previous source dba45a7379402ea33664a5754a2fe6f0927b6855; candidate 0d2c3d33215f7c289b89944214d4c7b8eaf9ac89. Nine unchanged, hash-verified local clang -O3 -march=native -ffp-contract=off C binaries retain UCRT linkage; all C/Python/default/forced/warm check values matched. Both sources received fresh profiles and executions, alternating source order by workload. All 42 separate actual-mode audit processes reconcile and match check values. No unknown native mode.

Best kernel times exclude startup, setup, profiling and compilation. Python/RecomPyler use five fresh-state repetitions, C twenty. C is an optimized comparison implementation, not proof of optimal assembly. Per-version C runs are retained; the table uses candidate-side C times. Whole process walls and all mode counts remain in the raw records.

| Kernel | C ms | Previous RP ms | Candidate RP ms | Candidate time / C | Python / candidate | Actual selected path |
|---|---:|---:|---:|---:|---:|---|
| fannkuch | 12.2390 | 23.2754 | 23.5506 | 1.92x | 9.21x | AOT |
| float | 1.0266 | 1.4540 | 1.4336 | 1.40x | 28.57x | AOT |
| nbody | 3.1161 | 3.5550 | 3.5613 | 1.14x | 19.17x | AOT |
| spectral_norm | 0.5183 | 24.7354 | 24.5306 | 47.33x | 2.40x | JIT helpers only; outer Python work remains |
| coroutines | 0.1276 | 1.3393 | 1.2130 | 9.51x | 11.33x | AOT |
| richards | 0.1876 | 1.4555 | 1.0852 | 5.78x | 20.95x | Explicit warm diagnostic; JIT |
| raytrace | 0.6037 | 4.4033 | 4.4819 | 7.42x | 35.11x | AOT |
| barnes_hut | 9.1081 | 49.2461 | 52.3244 | 5.74x | 10.09x | AOT |
| scimark / sor | 0.1726 | 66.1328 | 64.7770 | 375.27x | 1.03x | Python fallback |
| scimark / sparse_mat_mult | 0.0107 | 2.2274 | 2.2402 | 208.80x | 0.99x | Python fallback |
| scimark / monte_carlo | 0.2389 | 36.9825 | 37.1746 | 155.61x | 0.98x | Python fallback |
| scimark / lu | 0.0434 | 55.8161 | 53.8465 | 1240.93x | 1.01x | Python fallback |
| scimark / fft | 0.4265 | 2.7640 | 2.7670 | 6.49x | 57.26x | AOT |

Richards and spectral_norm use explicitly labelled warm selection of verified candidates above 1.05x, with force permitted. Other rows use the ordinary forced diagnostic. This does not replace default deployment measurements. Spectral norm accelerates JIT helpers only; substantial Python work remains. SciMark mode audits identify only FFT_transform and FFT_inverse as native functions; aggregate FFT call counts must not be assigned to SOR, sparse, MonteCarlo or LU. Those four rows are Python fallback, not native-code overhead.

The basic Richards explicit warm diagnostic used JIT in BOTH versions: complete process wall 9.3051 s previous versus 8.2793 s candidate, despite 1.4555/1.0852 ms best kernels. It is a different Python benchmark variant from the held-out Richards_super, whose default long study used saved AOT code at 0.3821 s complete-process median. Do not combine the variants or confuse their startup policies.

Warm body performance remains broadly similar to the prior integration, with both improvements and regressions retained. For example, Barnes rose from 49.2461 to 52.3244 ms and nbody stayed near 3.56 ms. Five best-time observations on one host do not establish statistical or compiler-causal significance for small differences. The demonstrated new gain is reliable deployment on the long guarded workload, not a general native instruction optimization.

Full evidence: wave3-native-baseline and wave3-native manifests, measured-source.json, raw process records/stdout/stderr, plans, counts, warm-diagnostic-results.json and native-mode-audits.json. The compact 26-row comparison is wave3-native-comparison.json. Helper/source/environment hashes freeze the diagnostics; no C compiler build was repeated in this wave.
