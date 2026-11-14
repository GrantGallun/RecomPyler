# Frozen paired study results

Measured integration `75aefc135a72cd5abe480d7e444db624ab04b43f` against baseline `5083021b7d9bbe66e4ad8fa6d39bdd526a47ff49` (original feature ancestry `56211d5`, same reviewed build fix). Both source trees remained clean and passed final fingerprint validation. All 49 workloads completed; harness exited 0. No timeouts, no valid-plan stdout/exit mismatches. Integrated deepcopy and generators profile processes exited 1, so those programs have no integrated speed result.

Configuration: limit 40, eight samples, five fresh processes per mode, per-process timeout 180s; default runner with profile-created disk cache, no force. Full raw plans/output/exit/call evidence is in results/. Historical reports select population only. Plain CPython is rerun for every workload.

| Group | Fixed N | Paired meaningful timing N | CPython / baseline wall | CPython / integrated wall | Largest verified opportunity, baseline → integrated | Recommended reach, baseline → integrated |
|---|---:|---:|---:|---:|---:|---:|
| heldout | 38 | 35 | 0.8940x | 0.9754x | 0.487% → 2.395% | 0.000% → 0.000% |
| tuned | 9 | 9 | 1.1308x | 1.2480x | 51.777% → 51.105% | 42.828% → 42.354% |
| addition | 2 | 2 | 0.9386x | 0.9714x | 0.039% → 0.041% | 0.000% → 0.000% |

Timing ratios are geometric means of per-program median process-wall ratios on the identical listed paired subset. Held-out timing excludes the two integrated profile failures and python_startup's shim no-op; the fixed coverage denominator stays 38. Failed profiles contribute zero to the fixed-denominator opportunity average, which is an accounting convention, not a measured zero opportunity. Integrated held-out default execution is still slower than direct CPython on this population. All held-out programs and both additions deployed zero compiled calls/batch rows. Calls below refer to top-level region/function invocations, not every native helper invocation.

Only four tuned workloads deployed compiled calls (same totals for each source, across five runs): barnes_hut 1000, fannkuch 10, raytrace 10, scimark 1000. All instrumented fallback-call counts were zero; programs with no recommendations execute Python without a lifted wrapper, so that counter is not a count of all Python work. Full counters and not_found lists are retained in summary.json.

The largest verified-candidate reach is an opportunity proxy: max cumulative region reach or ordinary function self time / total profile time, capped at script time. It is not a union of regions or measured time actually compiled. Recommended reach is separately reported and can remain nonzero when the whole-program startup gate rejects deployment. Captured kernel ratios exclude startup/profile cost.

## Failures

- deepcopy, integrated only: flow.py function_locals walks ClassDef then _defaults reads node.args; AttributeError: 'ClassDef' object has no attribute 'args'. Raw trace: results/programs/deepcopy/integrated-profile.stderr.
- generators, integrated only: heap.py generator_loop → delegate → call raises uncaught recompyler.heap._Pending (call line 4380). Raw trace: results/programs/generators/integrated-profile.stderr.

No frozen source, harness, manifest, or failed record was changed. Repairs require a separately versioned follow-up.

## Per-program results

Opportunity and recommendation columns are percentages of the profiled run. Speed columns compare identical fresh processes; failed means no valid integrated plan/timing. Empty stdout is not a full result-equivalence check. Only the bot emitted nonempty stdout in this study; all other output comparisons concern empty output plus successful exits. Sample verification remains separate finite evidence.

### heldout

| Program | Verified proxy B → I | Recommended B → I | Process speed B → I | Compiled calls B / I |
|---|---:|---:|---:|---:|
| async_generators | 0.000% → 0.000% | 0.000% → 0.000% | 0.936x → 0.966x | 0 / 0 |
| asyncio_tcp | 0.000% → 0.000% | 0.000% → 0.000% | 0.927x → 1.025x | 0 / 0 |
| asyncio_websockets | 0.000% → 0.000% | 0.000% → 0.000% | 0.946x → 0.972x | 0 / 0 |
| base64 | 0.000% → 0.000% | 0.000% → 0.000% | 0.996x → 1.005x | 0 / 0 |
| chaos | 14.498% → 36.633% | 0.000% → 0.000% | 0.885x → 1.005x | 0 / 0 |
| comprehensions | 0.000% → 0.000% | 0.000% → 0.000% | 0.840x → 0.954x | 0 / 0 |
| concurrent_imap | 0.001% → 0.004% | 0.000% → 0.000% | 0.909x → 0.968x | 0 / 0 |
| decimal_factorial | 0.000% → 0.000% | 0.000% → 0.000% | 0.945x → 0.998x | 0 / 0 |
| decimal_pi | 0.000% → 0.000% | 0.000% → 0.000% | 0.922x → 0.972x | 0 / 0 |
| deepcopy | 0.000% → failed | 0.000% → failed | 0.824x → failed | 0 / 0 |
| deltablue | 0.040% → 0.042% | 0.000% → 0.000% | 0.802x → 0.940x | 0 / 0 |
| fastapi | 0.000% → 0.000% | 0.000% → 0.000% | 0.977x → 0.972x | 0 / 0 |
| gc_collect | 0.740% → 0.874% | 0.000% → 0.000% | 0.872x → 0.998x | 0 / 0 |
| gc_traversal | 0.000% → 0.000% | 0.000% → 0.000% | 0.842x → 0.926x | 0 / 0 |
| generators | 0.000% → failed | 0.000% → failed | 0.880x → failed | 0 / 0 |
| hexiom | 1.584% → 1.432% | 0.000% → 0.000% | 0.796x → 0.901x | 0 / 0 |
| json_dumps | 0.000% → 0.000% | 0.000% → 0.000% | 0.892x → 0.997x | 0 / 0 |
| json_loads | 0.000% → 0.000% | 0.000% → 0.000% | 0.830x → 0.941x | 0 / 0 |
| logging | 0.000% → 0.000% | 0.000% → 0.000% | 0.839x → 0.935x | 0 / 0 |
| mdp | 0.796% → 0.791% | 0.000% → 0.000% | 0.994x → 0.992x | 0 / 0 |
| meteor_contest | 0.000% → 0.000% | 0.000% → 0.000% | 0.920x → 1.000x | 0 / 0 |
| nqueens | 0.000% → 0.000% | 0.000% → 0.000% | 0.923x → 0.987x | 0 / 0 |
| pathlib | 0.000% → 0.000% | 0.000% → 0.000% | 0.958x → 1.036x | 0 / 0 |
| pidigits | 0.000% → 0.000% | 0.000% → 0.000% | 0.936x → 1.002x | 0 / 0 |
| pprint | 0.000% → 0.000% | 0.000% → 0.000% | 0.981x → 0.972x | 0 / 0 |
| python_startup (shim no-op) | 0.000% → 0.000% | 0.000% → 0.000% | 0.850x → 0.971x | 0 / 0 |
| regex_compile | 0.000% → 0.000% | 0.000% → 0.000% | 0.900x → 0.983x | 0 / 0 |
| regex_dna | 0.000% → 0.000% | 0.000% → 0.000% | 0.925x → 0.975x | 0 / 0 |
| regex_effbot | 0.000% → 0.000% | 0.000% → 0.000% | 0.877x → 1.017x | 0 / 0 |
| regex_v8 | 0.000% → 0.000% | 0.000% → 0.000% | 0.799x → 0.951x | 0 / 0 |
| richards_super | 0.842% → 51.217% | 0.000% → 0.000% | 0.873x → 0.965x | 0 / 0 |
| sqlalchemy_declarative | 0.000% → 0.000% | 0.000% → 0.000% | 0.963x → 0.997x | 0 / 0 |
| sqlite_synth | 0.001% → 0.002% | 0.000% → 0.000% | 0.825x → 0.968x | 0 / 0 |
| sympy | 0.000% → 0.000% | 0.000% → 0.000% | 0.976x → 0.991x | 0 / 0 |
| typing_runtime_protocols | 0.000% → 0.000% | 0.000% → 0.000% | 0.837x → 0.965x | 0 / 0 |
| unpack_sequence | 0.000% → 0.000% | 0.000% → 0.000% | 0.759x → 0.920x | 0 / 0 |
| xml_etree | 0.000% → 0.000% | 0.000% → 0.000% | 0.922x → 0.997x | 0 / 0 |
| yaml | 0.000% → 0.000% | 0.000% → 0.000% | 0.845x → 0.959x | 0 / 0 |

### tuned

| Program | Verified proxy B → I | Recommended B → I | Process speed B → I | Compiled calls B / I |
|---|---:|---:|---:|---:|
| barnes_hut | 84.906% → 84.659% | 84.906% → 84.659% | 2.709x → 2.967x | 1000 / 1000 |
| coroutines | 29.509% → 31.152% | 29.509% → 31.152% | 0.836x → 0.926x | 0 / 0 |
| fannkuch | 78.040% → 77.820% | 78.040% → 77.820% | 1.528x → 1.793x | 10 / 10 |
| float | 31.196% → 28.409% | 31.196% → 28.409% | 0.906x → 1.002x | 0 / 0 |
| nbody | 62.626% → 64.311% | 62.626% → 64.311% | 0.906x → 0.991x | 0 / 0 |
| raytrace | 68.886% → 63.478% | 68.886% → 63.478% | 1.122x → 1.228x | 10 / 10 |
| richards | 49.174% → 46.268% | 0.000% → 0.000% | 0.846x → 0.944x | 0 / 0 |
| scimark | 30.290% → 31.358% | 30.290% → 31.358% | 1.281x → 1.327x | 1000 / 1000 |
| spectral_norm | 31.365% → 32.489% | 0.000% → 0.000% | 0.876x → 0.975x | 0 / 0 |

### addition

| Program | Verified proxy B → I | Recommended B → I | Process speed B → I | Compiled calls B / I |
|---|---:|---:|---:|---:|
| go | 0.006% → 0.008% | 0.000% → 0.000% | 0.920x → 0.997x | 0 / 0 |
| poker_selfplay | 0.071% → 0.074% | 0.000% → 0.000% | 0.957x → 0.947x | 0 / 0 |

## Profile/build cost and blockers

Total combined capture + verification + JIT/AOT + startup-probe wall cost: baseline 403.88s, integrated 439.38s across 49 attempts each. These costs are separate from process-speed ratios. This API does not expose a clean build-only timer; raw candidate first_pass_s/warm_start_s and AOT sections remain in plans. Profile costs must not be reconstructed by summing overlapping candidates.

Top held-out blockers (baseline; normalized labels, mean self-time share over fixed 38, failed profiles contribute no blocker rows):

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

Top held-out blockers (integrated; normalized labels, mean self-time share over fixed 38, failed profiles contribute no blocker rows):

- 2.43%: '…' has a closure, keyword-only arguments, *args or is a generator
- 2.30%: With
- 2.12%: global '…' is not a numeric constant
- 2.11%: '…' is recursive
- 1.96%: call
- 1.93%: an int argument too large for 64 bits
- 0.93%: not captured: the function not a module-level function or a method
- 0.58%: '…' may be read before assignment
- 0.33%: range() on int
- 0.32%: constant (string, None or other)

The two-deal bot addition stayed below 0.08% verified opportunity in each source and recommended nothing. Its default run therefore compiled nothing; there were no not_found entries because no function was picked. The imported-module deployment limitation found during code inspection remains a structural next priority but was not exercised by a profitable bot plan here. Go succeeded under this exact limited-sample configuration but also recommended nothing. Neither addition changes the 38 held-out denominator.

Frozen package/input/environment choices and historical exclusions are in manifest.json; fixture evidence and methodology are in REVIEW-FIXES.md and ../WAVE2-study.md. Separate C diagnostics must not be merged into these default end-to-end claims.
