# Matched native C diagnostics

Measured compiler source: dc02b957f3e5504aec305343e942a8d0d96a17b1. Nine C ports compiled with clang -O3 -march=native -ffp-contract=off, linked to the same UCRT runtime as CPython. Compiler version, build commands and file hashes are in manifest.json; source and execution settings are in measured-source.json.

These are best kernel times (Python/RecomPyler five repetitions; C twenty), excluding process startup/setup/profile. Default and forced process records remain separate. The forced flag alone bypasses the overall-plan gate, not every function recommendation. An additional warm diagnostic explicitly selects verified candidates measured above1.05x for spectral_norm, richards and scimark. Only the spectral_norm and richards warm-override rows below use that extra selection; FFT uses the original forced result. This is a tuned diagnostic, not the held-out headline or a guarantee of optimal assembly.

Every reported C/default/forced/warm diagnostic exited0 and matched the Python check outputs, including exact encoded floating values and signed zeros. These are finite workload checks, not proof of arbitrary Python equivalence.

| Workload | C ms | Python ms | Warm RecomPyler ms | Time / C | Python / time | Path |
|---|---:|---:|---:|---:|---:|---|
| fannkuch | 12.2213 | 226.4141 | 23.5194 | 1.92x | 9.63x | forced |
| float | 1.1208 | 41.8901 | 2.4013 | 2.14x | 17.44x | forced |
| nbody | 3.1290 | 71.6732 | 3.7759 | 1.21x | 18.98x | forced |
| spectral_norm | 0.5183 | 56.5049 | 25.9115 | 49.99x | 2.18x | warm override; partial helper acceleration |
| coroutines | 0.1194 | 13.8470 | 1.2087 | 10.12x | 11.46x | forced |
| richards | 0.1829 | 24.7375 | 1.0559 | 5.77x | 23.43x | warm override |
| raytrace | 0.6042 | 161.9467 | 4.5499 | 7.53x | 35.59x | forced |
| barnes_hut | 9.1813 | 546.2166 | 50.8875 | 5.54x | 10.73x | forced |
| scimark / sor | 0.1755 | 65.5867 | 67.2770 | 383.40x | 0.97x | Python fallback |
| scimark / sparse_mat_mult | 0.0110 | 2.2560 | 2.3904 | 217.96x | 0.94x | Python fallback |
| scimark / monte_carlo | 0.2394 | 37.2736 | 37.4322 | 156.38x | 1.00x | Python fallback |
| scimark / lu | 0.0415 | 56.8483 | 55.6239 | 1340.82x | 1.02x | Python fallback |
| scimark / fft | 0.4282 | 161.9265 | 2.7573 | 6.44x | 58.73x | forced |

Nbody is within about21% of this optimized C port in the warm kernel. Fannkuch and float take about1.9x and2.1x C time. Compiled object-heavy kernels retain larger gaps (roughly5–10x here). Spectral norm remains partially in Python; SOR/sparse/MonteCarlo/LU are fallback rows and their large C ratios must not be called native-code overhead.

Concrete observed blockers: spectral norm passes functions as values; sparse/LU use array.array(typecode d), which the region heap does not support; MonteCarlo constructs an object before all its attributes are set; SOR did not capture eligible numeric calls. These are frontend/capture/layout opportunities before machine-code tuning.

Startup is material: the explicit warmed Richards path took about7.19s for the complete diagnostic process despite a1.06ms best kernel, because it used JIT rather than an AOT module. Keep this separate from default-run gains.

Bytecode writing was disabled in the execution environment, matching the paired study. Source bytecode-cache validity differed between versions; warm kernel timers exclude those import costs. A separate warm-bytecode startup control follows.
