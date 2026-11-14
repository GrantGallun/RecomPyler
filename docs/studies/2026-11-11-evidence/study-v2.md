# Corrected frozen study, v2

Measured integration `dc02b957f3e5504aec305343e942a8d0d96a17b1` against unchanged baseline `5083021b7d9bbe66e4ad8fa6d39bdd526a47ff49` (original feature ancestry `56211d5`, same reviewed build fix). All 49 fresh integrated profiles and 735 fresh interleaved process timings completed successfully. No timeout, nonzero exit, or stdout/exit mismatch. Deepcopy and generators, which failed profiling on v1 integration `75aefc1`, now succeed. The run ended with a successful full source/runtime/input fingerprint check.

Baseline profile/verification/AOT evidence is reused verbatim from v1; baseline startup/profitability calibration is historical rather than contemporaneous. All latency measurements are fresh. The coordinator validated unchanged baseline/runtime/packages/frozen environment/shim/input/driver identities. Before and after the run, 196 copied baseline files and seven retained v1 AOT modules matched provenance hashes. All 245 baseline run-count reports are fresh; all 2020 deployed baseline calls are ahead-of-time, with zero fallback or JIT-deployed calls. The baseline reuse is comparable on these stated terms, not a claim of fresh baseline compilation.

Configuration is unchanged: limit 40, eight captured samples, five fresh processes per mode, timeout 180s, two bot deals with duplicate halves; default runner without force. Raw evidence is in results-v2/; v1 results and failures remain untouched.

## Paired outcomes

| Group | Fixed N | Meaningful paired timing N | CPython / baseline process wall | CPython / integrated process wall | Verified opportunity B → I | Recommended reach B → I |
|---|---:|---:|---:|---:|---:|---:|
| heldout | 38 | 37 | 0.90125x | 0.97412x | 0.487% → 3.192% | 0.000% → 0.000% |
| tuned | 9 | 9 | 1.15816x | 1.17589x | 51.777% → 50.975% | 42.828% → 42.551% |
| addition | 2 | 2 | 0.94490x | 0.97404x | 0.039% → 0.039% | 0.000% → 0.000% |

Ratios are geometric means of per-program median whole-process wall ratios. The held-out denominator stays 38; its meaningful timing subset is 37 because python_startup executes a shim no-op. Integrated held-out execution remains about 2.66% slower in process wall than direct CPython despite improving against the frozen baseline runner. Neither held-out programs nor the two additions deployed compiled calls or batches. Largest verified opportunity rose from 0.487% to 3.192%; programs exceeding 10% opportunity rose from one to three (chaos, generators, richards_super). Recommended reach remains zero on held-out code.

Verified opportunity is an overlap-safe maximum of a region's cumulative time or an ordinary function's self time divided by total profile time, capped at script self time. It is not dynamic union coverage or time actually running native code. Several verified kernels are slower than Python: chaos Spline.__call__ is about 0.255x and generators Tree.__iter__ about 0.031x in captured-call diagnostics. Richards.run in richards_super verifies at about 20.18x, yet the complete workload recommends nothing. Exact output/exit agreement is finite evidence: only the bot prints a result; all other workloads have empty stdout, so equality does not prove semantic equivalence beyond captured verification samples.

## Deployment and preserved regressions

Baseline deployed 2020 native calls over five runs: barnes_hut 1000, fannkuch 10, raytrace 10, scimark 1000. Integrated deployed 2010: barnes_hut 1000, fannkuch 10, scimark 1000. Both variants have zero wrapper fallback calls; Python-only programs bypass lifted wrappers and do not increment that counter. Both variants deployed zero batch rows.

Barnes_hut whole-process median regressed from baseline 0.476760s to integrated 0.619235s, despite both deploying 1000 AOT calls over five repetitions. This is an observed process-wall regression with unresolved cause. No attribution to the corrective patch, native code generation, or random timing noise is established.

Raytrace's integrated median is 0.515996s versus baseline 0.444306s. Its fresh integrated plan estimated startup at 0.274380s and saving at 0.152720s, so worth_running=false and all five integrated runs used Python. Baseline retains ten AOT calls from its reused profitable plan. V1 integration's calibration was startup 0.108084s, saving 0.165671s, worth_running=true. This is an observable plan-decision difference; candidate AOT existence does not establish default deployment. It limits attributing per-source speed differences solely to kernel implementation.

The tuned geometric mean does not establish absence of per-program regressions. Every per-program median is retained below.

## Per-program evidence

### heldout

| Program | Verified B → I | Recommended B → I | Median wall s: plain / B / I | Process speed B → I | Compiled B / I |
|---|---:|---:|---:|---:|---:|
| async_generators | 0.000% → 0.000% | 0.000% → 0.000% | 0.673971 / 0.718959 / 0.690762 | 0.937x → 0.976x | 0 / 0 |
| asyncio_tcp | 0.000% → 0.000% | 0.000% → 0.000% | 1.249754 / 1.201906 / 1.191775 | 1.040x → 1.049x | 0 / 0 |
| asyncio_websockets | 0.000% → 0.000% | 0.000% → 0.000% | 0.508215 / 0.543714 / 0.512161 | 0.935x → 0.992x | 0 / 0 |
| base64 | 0.000% → 0.000% | 0.000% → 0.000% | 2.619930 / 2.660139 / 2.672691 | 0.985x → 0.980x | 0 / 0 |
| chaos | 14.498% → 38.278% | 0.000% → 0.000% | 0.254309 / 0.287693 / 0.268873 | 0.884x → 0.946x | 0 / 0 |
| comprehensions | 0.000% → 0.000% | 0.000% → 0.000% | 0.181360 / 0.199609 / 0.175980 | 0.909x → 1.031x | 0 / 0 |
| concurrent_imap | 0.001% → 0.001% | 0.000% → 0.000% | 0.600210 / 0.633964 / 0.615497 | 0.947x → 0.975x | 0 / 0 |
| decimal_factorial | 0.000% → 0.000% | 0.000% → 0.000% | 0.512107 / 0.541251 / 0.523964 | 0.946x → 0.977x | 0 / 0 |
| decimal_pi | 0.000% → 0.000% | 0.000% → 0.000% | 0.554784 / 0.563952 / 0.548365 | 0.984x → 1.012x | 0 / 0 |
| deepcopy | 0.000% → 0.000% | 0.000% → 0.000% | 0.161034 / 0.205232 / 0.175994 | 0.785x → 0.915x | 0 / 0 |
| deltablue | 0.040% → 0.042% | 0.000% → 0.000% | 0.168641 / 0.208539 / 0.179828 | 0.809x → 0.938x | 0 / 0 |
| fastapi | 0.000% → 0.000% | 0.000% → 0.000% | 10.399446 / 10.333785 / 10.378691 | 1.006x → 1.002x | 0 / 0 |
| gc_collect | 0.740% → 0.960% | 0.000% → 0.000% | 0.182193 / 0.215887 / 0.190994 | 0.844x → 0.954x | 0 / 0 |
| gc_traversal | 0.000% → 0.000% | 0.000% → 0.000% | 0.180053 / 0.214679 / 0.197081 | 0.839x → 0.914x | 0 / 0 |
| generators | 0.000% → 26.874% | 0.000% → 0.000% | 0.232194 / 0.266028 / 0.244412 | 0.873x → 0.950x | 0 / 0 |
| hexiom | 1.584% → 1.421% | 0.000% → 0.000% | 0.174609 / 0.212646 / 0.181433 | 0.821x → 0.962x | 0 / 0 |
| json_dumps | 0.000% → 0.000% | 0.000% → 0.000% | 0.187609 / 0.220739 / 0.191122 | 0.850x → 0.982x | 0 / 0 |
| json_loads | 0.000% → 0.000% | 0.000% → 0.000% | 0.177187 / 0.206468 / 0.177386 | 0.858x → 0.999x | 0 / 0 |
| logging | 0.000% → 0.000% | 0.000% → 0.000% | 0.168715 / 0.200474 / 0.177249 | 0.842x → 0.952x | 0 / 0 |
| mdp | 0.796% → 0.790% | 0.000% → 0.000% | 1.760042 / 1.778223 / 1.749896 | 0.990x → 1.006x | 0 / 0 |
| meteor_contest | 0.000% → 0.000% | 0.000% → 0.000% | 0.306500 / 0.332704 / 0.314672 | 0.921x → 0.974x | 0 / 0 |
| nqueens | 0.000% → 0.000% | 0.000% → 0.000% | 0.287649 / 0.332579 / 0.300455 | 0.865x → 0.957x | 0 / 0 |
| pathlib | 0.000% → 0.000% | 0.000% → 0.000% | 0.701127 / 0.695660 / 0.678778 | 1.008x → 1.033x | 0 / 0 |
| pidigits | 0.000% → 0.000% | 0.000% → 0.000% | 0.447106 / 0.469155 / 0.453403 | 0.953x → 0.986x | 0 / 0 |
| pprint | 0.000% → 0.000% | 0.000% → 0.000% | 3.044882 / 3.078305 / 3.062859 | 0.989x → 0.994x | 0 / 0 |
| python_startup (shim no-op) | 0.000% → 0.000% | 0.000% → 0.000% | 0.164286 / 0.205012 / 0.177362 | 0.801x → 0.926x | 0 / 0 |
| regex_compile | 0.000% → 0.000% | 0.000% → 0.000% | 0.378271 / 0.421372 / 0.399256 | 0.898x → 0.947x | 0 / 0 |
| regex_dna | 0.000% → 0.000% | 0.000% → 0.000% | 0.459390 / 0.501807 / 0.478597 | 0.915x → 0.960x | 0 / 0 |
| regex_effbot | 0.000% → 0.000% | 0.000% → 0.000% | 0.208893 / 0.240644 / 0.218314 | 0.868x → 0.957x | 0 / 0 |
| regex_v8 | 0.000% → 0.000% | 0.000% → 0.000% | 0.237619 / 0.293767 / 0.237495 | 0.809x → 1.001x | 0 / 0 |
| richards_super | 0.842% → 52.916% | 0.000% → 0.000% | 0.219369 / 0.261177 / 0.230781 | 0.840x → 0.951x | 0 / 0 |
| sqlalchemy_declarative | 0.000% → 0.000% | 0.000% → 0.000% | 0.571241 / 0.581959 / 0.585245 | 0.982x → 0.976x | 0 / 0 |
| sqlite_synth | 0.001% → 0.002% | 0.000% → 0.000% | 0.178401 / 0.208123 / 0.187556 | 0.857x → 0.951x | 0 / 0 |
| sympy | 0.000% → 0.000% | 0.000% → 0.000% | 1.535296 / 1.579054 / 1.565020 | 0.972x → 0.981x | 0 / 0 |
| typing_runtime_protocols | 0.000% → 0.000% | 0.000% → 0.000% | 0.182259 / 0.218294 / 0.190731 | 0.835x → 0.956x | 0 / 0 |
| unpack_sequence | 0.000% → 0.000% | 0.000% → 0.000% | 0.175401 / 0.221117 / 0.183306 | 0.793x → 0.957x | 0 / 0 |
| xml_etree | 0.000% → 0.000% | 0.000% → 0.000% | 0.664555 / 0.696791 / 0.679059 | 0.954x → 0.979x | 0 / 0 |
| yaml | 0.000% → 0.000% | 0.000% → 0.000% | 0.208293 / 0.231293 / 0.210536 | 0.901x → 0.989x | 0 / 0 |

### tuned

| Program | Verified B → I | Recommended B → I | Median wall s: plain / B / I | Process speed B → I | Compiled B / I |
|---|---:|---:|---:|---:|---:|
| barnes_hut | 84.906% → 85.119% | 84.906% → 85.119% | 1.328506 / 0.476760 / 0.619235 | 2.787x → 2.145x | 1000 / 1000 |
| coroutines | 29.509% → 27.885% | 29.509% → 27.885% | 0.199325 / 0.226713 / 0.204005 | 0.879x → 0.977x | 0 / 0 |
| fannkuch | 78.040% → 77.810% | 78.040% → 77.810% | 0.606168 / 0.350787 / 0.333303 | 1.728x → 1.819x | 10 / 10 |
| float | 31.196% → 29.685% | 31.196% → 29.685% | 0.266234 / 0.304195 / 0.275625 | 0.875x → 0.966x | 0 / 0 |
| nbody | 62.626% → 63.735% | 62.626% → 63.735% | 0.311520 / 0.342146 / 0.322368 | 0.910x → 0.966x | 0 / 0 |
| raytrace | 68.886% → 69.118% | 68.886% → 69.118% | 0.514284 / 0.444306 / 0.515996 | 1.157x → 0.997x | 10 / 0 |
| richards | 49.174% → 44.444% | 0.000% → 0.000% | 0.215592 / 0.257761 / 0.223781 | 0.836x → 0.963x | 0 / 0 |
| scimark | 30.290% → 29.611% | 30.290% → 29.611% | 0.860734 / 0.670540 / 0.668872 | 1.284x → 1.287x | 1000 / 1000 |
| spectral_norm | 31.365% → 31.368% | 0.000% → 0.000% | 0.299272 / 0.334681 / 0.306137 | 0.894x → 0.978x | 0 / 0 |

### addition

| Program | Verified B → I | Recommended B → I | Median wall s: plain / B / I | Process speed B → I | Compiled B / I |
|---|---:|---:|---:|---:|---:|
| go | 0.006% → 0.004% | 0.000% → 0.000% | 0.337844 / 0.380508 / 0.358668 | 0.888x → 0.942x | 0 / 0 |
| poker_selfplay | 0.071% → 0.075% | 0.000% → 0.000% | 0.611395 / 0.608001 / 0.607002 | 1.006x → 1.007x | 0 / 0 |

## Cost and blockers

Baseline combined profile/capture/verification/JIT/AOT/startup-probe cost is **403.88s, reused v1 evidence**. Integrated combined cost is **451.11s, freshly measured in v2**. These are not clean build-only timers and not directly contemporaneous cost measurements. Candidate first_pass_s/warm_start_s and AOT metadata are preserved; overlapping candidate costs must not be summed into whole-program latency. Fresh v2 child wall totals 995.22s across 784 subprocesses.

Top held-out blockers, baseline, normalized mean self-time share over the same fixed 38 programs:

- 3.54%: '…' may be read before assignment
- 2.43%: not captured: the function is a generator
- 2.20%: global '…' is not a numeric constant
- 2.09%: '…' is recursive
- 1.93%: an int argument too large for 64 bits
- 1.61%: not captured: the function is an async generator
- 1.50%: call
- 0.97%: a '…' object with attributes its __init__ does not set
- 0.73%: '…' returns a value on some paths and None on others
- 0.61%: no calls with numeric arguments and results were captured

Top held-out blockers, integrated, normalized mean self-time share over the same fixed 38 programs:

- 2.43%: '…' has a closure, keyword-only arguments, *args or is a generator
- 2.28%: With
- 2.12%: '…' is recursive
- 2.11%: global '…' is not a numeric constant
- 1.95%: call
- 1.90%: an int argument too large for 64 bits
- 0.91%: not captured: the function not a module-level function or a method
- 0.65%: '…' returns a value on some paths and None on others
- 0.57%: '…' may be read before assignment
- 0.34%: range() on int

Go and bot remain separate additions and recommend no native functions. Bot's nonempty result stdout matches exactly in every mode; the limited two-deal workload is not a full bot evaluation. Its imported-module deployment limitation remains a code-inspection finding; this study has no profitable bot plan to exercise it. All 26 historical package/data/argument exclusions remain listed in the manifest; none was silently repaired or removed. Next work should address deployment profitability and boundary/startup costs, preserve the observed tuned regressions, and test any changes in a separately versioned cohort. C warm-kernel diagnostics and a longer predeclared cohort are separate experiments.
