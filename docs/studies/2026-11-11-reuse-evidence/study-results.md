# Wave3 final matched study, v2

Candidate `0d2c3d33215f7c289b89944214d4c7b8eaf9ac89` versus the independent final-existing-branch baseline `dba45a7379402ea33664a5754a2fe6f0927b6855`. Both source trees stayed frozen and passed final runtime/input/bytecode/source checks. All 49 fixed workloads and both separately predeclared long workloads completed. No failed profile/process, timeout, stdout/exit mismatch, unknown successful native audit mode or audit reconciliation failure occurred. All 510 separate audit children succeeded. The earlier afd09b0 run remains preserved as a stopped partial experiment and is not included.

The fixed study freshly profiled both sources (98 profiles), ran 735 ordinary fresh-process timings and 490 separate untimed audits. The long diagnostic added four fresh profiles, 30 timings and 20 audits. Configuration is limit 40/samples 8/repetitions 5/timeout 180/default unforced; fixed shim loops 2, long loops 20. Both complete source trees/workloads were warmed into a per-program task-owned bytecode prefix, runtime-dependency caches were populated by the union of both profiles, then the bytecode inventory was frozen with writes disabled throughout timings/audits. This changed cache protocol is why historical wave2 figures are context rather than the comparator.

## Fixed population results

| Group | Fixed N / meaningful timing N | CPython/default baseline | CPython/default candidate | Verified opportunity B → C | Recommended reach B → C | Actual native timing programs B / C |
|---|---:|---:|---:|---:|---:|---:|
| heldout | 38 / 37 | 0.959742x | 0.958756x | 3.646% → 2.941% | 0.000% → 0.000% | 0 / 0 |
| tuned | 9 / 9 | 1.289856x | 1.294033x | 54.216% → 50.791% | 47.942% → 40.627% | 4 / 4 |
| addition | 2 / 2 | 0.971665x | 0.988961x | 0.027% → 0.038% | 0.000% → 0.000% | 0 / 0 |

Ratios are geometric means of per-program median process-wall ratios. Paired subsets are identical across sources and explicitly listed in each raw summary. Held-out denominator stays 38; python_startup's shim no-op is excluded from its 37 meaningful timing programs. Additions go/bot remain separate. Candidate held-out default execution is still slower than plain CPython, with no short-workload native deployment. The small aggregate source-to-source timing differences do not establish statistically significant improvement. Opportunity declined numerically in this matched sample; it remains a profile/captured-candidate proxy, not a runtime coverage measure.

## Exact native modes and independent audit variability

Candidate fixed timing counters report 2020 successful native calls: Barnes 1000, fannkuch 10, raytrace 10, scimark 1000; all 2020 AOT, zero JIT/fallback/batch rows. Baseline timing reports the same 2020 compiled calls, but its legacy reports lack exact mode fields: AOT/JIT are unknown in those timing processes. Its separate audits, which must not be relabeled timing evidence, observe 2020 AOT/0JIT/0fallback. Candidate audits independently observe the same composition and agree with exact product counters in their own processes.

All five audit repetitions give native/AOT program counts 0/0 for held-out, 4/4 for tuned and 0/0 for additions, for both sources. No deployment-mode variability was observed in these repeated processes. Full per-program audit mode/count vectors remain in the compact analysis JSON and raw audit payloads. Programs executing Python directly do not enter a lifted wrapper; their zero wrapper-fallback count does not mean zero Python work.

## Predeclared long startup-amortization diagnostic

Only chaos and richards_super, selected by the earlier declared opportunity criterion, use loops 20. This cohort is not added to the 38 held-out denominator and uses no forced plan. It has fresh profiles, new caches and the same controlled bytecode protocol.

| Program | Plain / baseline / candidate median s | CPython/default B → C | Timing native / fallback B → C | Candidate exact AOT / JIT | Separate audits B → C |
|---|---:|---:|---:|---:|---:|
| chaos | 0.850025 / 0.869808 / 0.872031 | 0.977255x → 0.974765x | 0 / 0 → 0 / 0 | no native call | AOT0, fallback0 → AOT0, fallback0 |
| richards_super | 0.689172 / 0.974361 / 0.382138 | 0.707307x → 1.803462x | 0 / 100 → 100 / 0 | 100 / 0 | AOT0, fallback100 → AOT100, fallback0 |

Richards_super selects the whole region Richards.run at line 385 on both sides, with default worth_running=true and nonempty AOT exports (no force). Baseline plan startup 0.100792s/saving 0.420728s; candidate startup 0.110004s/saving 0.435069s. Candidate plan contains three export aliases and two seed bindings. Its 100 accepted calls therefore establish execution, rather than inferring use from those available exports. Both default runners apply their AOT-only startup safeguard; baseline mismatches go to Python rather than unbudgeted JIT.

Richards_super candidate deploys 20 successful AOT calls in every fresh timing process: 100 AOT/0JIT/0fallback across five runs. Five independent audits each confirm 20 AOT/0JIT/0fallback and no Numba import before bootstrap, during bootstrap or afterward. Baseline has 20 Python fallbacks per process and no native call, reproduced independently in all five audits without Numba import; its legacy timing mode fields remain unknown. Candidate process latency is about 2.55x faster than the baseline default runner and 1.8035x faster than plain CPython on this declared long workload. Chaos still recommends/deploys no native work. This demonstrates fresh AOT deployment for the repeated Richards workload, not broad held-out acceleration or general equivalence.

## Costs and limits
- Fixed: fresh combined profile wall baseline480.66s, candidate484.94s; compile-only bytecode warmups70.19s; separate audit wall348.62s; all completed child wall1894.11s.
- Long: fresh combined profile wall baseline153.08s, candidate189.43s; compile-only bytecode warmups2.80s; separate audit wall15.70s; all completed child wall384.62s.

Candidate long Richards_super profiling alone took 178.267s, just within 180s. This is upfront capture/verification/JIT/AOT/startup-probe cost, excluded from ordinary deployment latency and retained as a cost of preparing the plan. The API provides no clean build-only timer. Audit wall includes instrumentation/import overhead and is not a latency sample. Candidate first-pass/warm microbench times remain in raw plans; do not sum overlapping candidates or substitute them for whole-process speed.

Largest verified opportunity is max cumulative region reach or ordinary self time, capped to script self time / total profile time. It is not dynamic union coverage or actual native time. Captured eight-call verification is finite evidence. Only the bot prints nonempty result stdout in the fixed study; empty stdout/exit agreement does not prove full workload-result equivalence. Profile CLI stdout may include its report and is not treated as script-output correctness evidence. Guard/fallback semantics and broader correctness rely on the separately reviewed regression suite/native graph-state gate, not these empty outputs alone.

## Per-program fixed evidence

| Program | Verified proxy B → C | Median wall s plain / B / C | Process speed B → C | Timing compiled B / C | Candidate AOT / JIT |
|---|---:|---:|---:|---:|---:|
| async_generators | 0.000% → 0.000% | 0.649600 / 0.656778 / 0.675924 | 0.989x → 0.961x | 0 / 0 | no native call |
| asyncio_tcp | 0.000% → 0.000% | 1.163608 / 1.283018 / 1.135942 | 0.907x → 1.024x | 0 / 0 | no native call |
| asyncio_websockets | 0.000% → 0.000% | 0.487019 / 0.495036 / 0.492621 | 0.984x → 0.989x | 0 / 0 | no native call |
| barnes_hut | 87.004% → 83.567% | 1.286947 / 0.382652 / 0.390136 | 3.363x → 3.299x | 1000 / 1000 | 1000 / 0 |
| base64 | 0.000% → 0.000% | 2.632075 / 2.651836 / 2.657507 | 0.993x → 0.990x | 0 / 0 | no native call |
| chaos | 50.921% → 29.862% | 0.201182 / 0.219419 / 0.218147 | 0.917x → 0.922x | 0 / 0 | no native call |
| comprehensions | 0.000% → 0.000% | 0.127939 / 0.136132 / 0.135621 | 0.940x → 0.943x | 0 / 0 | no native call |
| concurrent_imap | 0.005% → -0.003% | 0.416901 / 0.423471 / 0.433742 | 0.984x → 0.961x | 0 / 0 | no native call |
| coroutines | 20.707% → 46.120% | 0.156686 / 0.166263 / 0.158462 | 0.942x → 0.989x | 0 / 0 | no native call |
| decimal_factorial | 0.000% → 0.000% | 0.474600 / 0.483401 / 0.487625 | 0.982x → 0.973x | 0 / 0 | no native call |
| decimal_pi | 0.000% → 0.000% | 0.500718 / 0.502454 / 0.502316 | 0.997x → 0.997x | 0 / 0 | no native call |
| deepcopy | 0.000% → 0.000% | 0.133452 / 0.139907 / 0.141953 | 0.954x → 0.940x | 0 / 0 | no native call |
| deltablue | 0.050% → 0.071% | 0.130303 / 0.152426 / 0.147881 | 0.855x → 0.881x | 0 / 0 | no native call |
| fannkuch | 84.480% → 71.309% | 0.555647 / 0.279671 / 0.289245 | 1.987x → 1.921x | 10 / 10 | 10 / 0 |
| fastapi | 0.000% → 0.000% | 10.580668 / 10.668873 / 10.657298 | 0.992x → 0.993x | 0 / 0 | no native call |
| float | 41.621% → 18.977% | 0.202481 / 0.216843 / 0.218456 | 0.934x → 0.927x | 0 / 0 | no native call |
| gc_collect | 0.613% → 2.200% | 0.128344 / 0.137500 / 0.132945 | 0.933x → 0.965x | 0 / 0 | no native call |
| gc_traversal | 0.000% → 0.000% | 0.139396 / 0.146379 / 0.149335 | 0.952x → 0.933x | 0 / 0 | no native call |
| generators | 15.800% → 30.138% | 0.195592 / 0.205506 / 0.199646 | 0.952x → 0.980x | 0 / 0 | no native call |
| hexiom | 3.057% → 1.021% | 0.137117 / 0.146762 / 0.144134 | 0.934x → 0.951x | 0 / 0 | no native call |
| json_dumps | 0.000% → 0.000% | 0.138275 / 0.142906 / 0.143827 | 0.968x → 0.961x | 0 / 0 | no native call |
| json_loads | 0.000% → 0.000% | 0.129334 / 0.134167 / 0.136982 | 0.964x → 0.944x | 0 / 0 | no native call |
| logging | 0.000% → 0.000% | 0.120512 / 0.127108 / 0.132967 | 0.948x → 0.906x | 0 / 0 | no native call |
| mdp | 0.853% → 0.764% | 1.727784 / 1.756701 / 1.730379 | 0.984x → 0.999x | 0 / 0 | no native call |
| meteor_contest | 0.000% → 0.000% | 0.274635 / 0.282335 / 0.282956 | 0.973x → 0.971x | 0 / 0 | no native call |
| nbody | 74.839% → 49.615% | 0.269489 / 0.274460 / 0.271377 | 0.982x → 0.993x | 0 / 0 | no native call |
| nqueens | 0.000% → 0.000% | 0.245189 / 0.252603 / 0.258090 | 0.971x → 0.950x | 0 / 0 | no native call |
| pathlib | 0.000% → 0.000% | 0.582906 / 0.598688 / 0.627433 | 0.974x → 0.929x | 0 / 0 | no native call |
| pidigits | 0.000% → 0.000% | 0.396946 / 0.395878 / 0.409610 | 1.003x → 0.969x | 0 / 0 | no native call |
| pprint | 0.000% → 0.000% | 2.978133 / 3.038123 / 3.070563 | 0.980x → 0.970x | 0 / 0 | no native call |
| python_startup (no-op) | 0.000% → 0.000% | 0.124062 / 0.138344 / 0.132448 | 0.897x → 0.937x | 0 / 0 | no native call |
| raytrace | 73.891% → 66.351% | 0.496175 / 0.387624 / 0.367231 | 1.280x → 1.351x | 10 / 10 | 10 / 0 |
| regex_compile | 0.000% → 0.000% | 0.321344 / 0.329454 / 0.344808 | 0.975x → 0.932x | 0 / 0 | no native call |
| regex_dna | 0.000% → 0.000% | 0.414783 / 0.412554 / 0.420038 | 1.005x → 0.987x | 0 / 0 | no native call |
| regex_effbot | 0.000% → 0.000% | 0.145990 / 0.155407 / 0.153403 | 0.939x → 0.952x | 0 / 0 | no native call |
| regex_v8 | 0.000% → 0.000% | 0.168707 / 0.176919 / 0.175416 | 0.954x → 0.962x | 0 / 0 | no native call |
| richards | 34.752% → 65.346% | 0.174972 / 0.178548 / 0.177442 | 0.980x → 0.986x | 0 / 0 | no native call |
| richards_super | 67.241% → 47.721% | 0.178150 / 0.189376 / 0.183623 | 0.941x → 0.970x | 0 / 0 | no native call |
| scimark | 31.304% → 29.700% | 0.823656 / 0.593812 / 0.611588 | 1.387x → 1.347x | 1000 / 1000 | 1000 / 0 |
| spectral_norm | 39.350% → 26.133% | 0.257638 / 0.261890 / 0.262040 | 0.984x → 0.983x | 0 / 0 | no native call |
| sqlalchemy_declarative | 0.000% → 0.000% | 0.553940 / 0.544954 / 0.535846 | 1.016x → 1.034x | 0 / 0 | no native call |
| sqlite_synth | 0.003% → 0.001% | 0.131516 / 0.145181 / 0.144102 | 0.906x → 0.913x | 0 / 0 | no native call |
| sympy | 0.000% → 0.000% | 1.413683 / 1.433090 / 1.445995 | 0.986x → 0.978x | 0 / 0 | no native call |
| typing_runtime_protocols | 0.000% → 0.000% | 0.122223 / 0.133781 / 0.137517 | 0.914x → 0.889x | 0 / 0 | no native call |
| unpack_sequence | 0.000% → 0.000% | 0.120398 / 0.135891 / 0.133663 | 0.886x → 0.901x | 0 / 0 | no native call |
| xml_etree | 0.000% → 0.000% | 0.629929 / 0.621478 / 0.621025 | 1.014x → 1.014x | 0 / 0 | no native call |
| yaml | 0.000% → 0.000% | 0.172581 / 0.177545 / 0.179323 | 0.972x → 0.962x | 0 / 0 | no native call |
| go | 0.005% → 0.003% | 0.292361 / 0.304360 / 0.302491 | 0.961x → 0.967x | 0 / 0 | no native call |
| poker_selfplay | 0.049% → 0.072% | 0.623323 / 0.634180 / 0.615973 | 0.983x → 1.012x | 0 / 0 | no native call |

Per-program regressions remain visible; the aggregate is not a no-regression claim. For example Barnes, fannkuch and scimark candidate medians are slightly slower here, while raytrace is faster. Five repetitions on one machine do not establish the causes or significance.

## Top fixed held-out blockers

baseline, normalized mean self-time share over all 38:

- 2.32%: '…' is recursive
- 2.21%: With
- 2.18%: '…' has a closure, keyword-only arguments, *args or is a generator
- 1.94%: global '…' is not a numeric constant
- 1.78%: an int argument too large for 64 bits
- 1.73%: call
- 0.92%: not captured: the function not a module-level function or a method
- 0.63%: '…' may be read before assignment
- 0.58%: '…' returns a value on some paths and None on others
- 0.40%: range() on int

candidate, normalized mean self-time share over all 38:

- 2.74%: '…' has a closure, keyword-only arguments, *args or is a generator
- 2.35%: global '…' is not a numeric constant
- 2.32%: With
- 2.21%: call
- 2.19%: an int argument too large for 64 bits
- 1.88%: '…' is recursive
- 0.97%: not captured: the function not a module-level function or a method
- 0.83%: '…' returns a value on some paths and None on others
- 0.52%: '…' may be read before assignment
- 0.34%: range() on int

Raw plans, failure-preserving process records, stdout/stderr, timing count JSON, exact source/input/runtime/environment identities and frozen pycache inventories are under results-v2/ and results-long-v2/. Compact machine-readable evidence is SUMMARY-v2.json; expanded per-program evidence is results-v2-analysis.json. The 26 historical exclusions remain in manifests; no failed package/data/argument workload was repaired during measurement. Native C diagnostics belong to the coordinator's subsequent experiment and are not mixed into these figures. CPU measurement slot was explicitly released before those jobs began.
