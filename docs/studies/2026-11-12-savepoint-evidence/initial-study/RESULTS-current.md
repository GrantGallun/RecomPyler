The full fixed current-vs-CPython cohort completed: **all49profiles,490fresh timings and245independent audits passed**, with no timeout or failed process. The38held-out programs had **zero actual native calls** under the unchanged default selection policy. Their37meaningful timings had a **0.965119x process-speed geomean versus CPython**, equivalent to **3.61% longer time**. The nine tuned programs averaged **1.253317x speedup**, with four actually entering native code. Go and poker remain separate additions.

This is the immutable **initial current-first** cohort, source `93986c89a5b512ef82a33af1f101bf6f796ae61f`, product `a033ca14c40afed052a6266a0a575f6cc11559ea`. The independent source clone preserves all raw newline/native-support bytes. Manifest `results-current/manifest.json` SHA256 is `07a61e41f7f763e55af8433a647710376406d26d56e73bf607cbcdff16b2da51`. No old profile, artifact or latency was reused. Later fixes require a new paired cohort with fresh CP/current/candidate timing; these initial medians will not be pooled with it.

| Group | Fixed programs | Meaningful timing pairs | Process-speed geomean vs CPython | Actual native programs | Mean largest verified opportunity proxy | Mean recommended reach |
|---|---:|---:|---:|---:|---:|---:|
| Held-out |38|37|0.965119x|0|2.7091%|0%|
| Tuned |9|9|1.253317x|4|45.2093%|38.0017%|
| Separate additions |2|2|0.987946x|0|0.0269%|0%|

Python_startup is retained in the38-profile denominator and excluded from meaningful speed because its shim entry does no benchmark work. All other fixed programs have valid timing pairs. The26historical exclusions are recorded, not repaired or newly claimed tested. All49names/order/groups/arguments/includes/shim/input inventories match the original frozen population.

Only these four default-runner workloads executed native code:

| Program | CPython median s | Current median s | Whole-process speedup | Successful timing AOT/JIT/fallback calls |
|---|---:|---:|---:|---|
| Barnes |1.293065|0.415432|3.112579x|1000 /0 /0|
| Fannkuch |0.573056|0.289763|1.977671x|10 /0 /0|
| Raytrace |0.486125|0.416602|1.166882x|10 /0 /0|
| SciMark |0.845684|0.636783|1.328056x|1000 /0 /0|

Across245current ordinary timing processes (five perprogram), the reports total **2020actual AOT calls, zero JIT/fallback/batch rows**, with no unknown mode fields. The separate245audit processes independently observe the same aggregate composition; their2020AOT calls are separate evidence, not additional timing calls. All49programs reconcile product counters and independent successful-mode audits; native/AOT program counts by audit repetition are heldout0/0, tuned4/4, additions0/0 in every repetition. Counts are successful runner-process region/lifter entry calls, not dynamic recursive calls or a cross-process native-time trace.

The other45programs report **no selected wrappers**. Their zero wrapper-fallback count does not mean zero Python work: they execute ordinary Python directly. No selected-not-found, selected-only-Python or batch execution occurred. All held-out recommended reach is zero; verified opportunities in chaos33.34%, generators18.23% and Richards_super48.28% were not deployed under this short fixed workload. Basic Richards is a separate tuned entry and also selected no wrapper. These are opportunity/selection facts, not a claim that arbitrary recursion or generators are universally unsupported.

The slowest measured current processes are:

| Workload | Current median s | CPython median s | Speedup | Actual deployment |
|---|---:|---:|---:|---|
| FastAPI |10.740281|10.525701|0.980021x|Python; no selected wrapper|
| pprint |3.106255|3.036150|0.977431x|Python; no selected wrapper|
| base64 |2.660683|2.667347|1.002505x|Python; no selected wrapper|
| mdp |1.739250|1.779941|1.023395x|Python; no selected wrapper|
| sympy |1.554507|1.527947|0.982914x|Python; no selected wrapper|
| asyncio_tcp |1.149428|1.164010|1.012686x|Python; no selected wrapper|

Largest positive current-minus-CPython median differences are FastAPI214.58ms, pprint70.11ms, sympy26.56ms, regex_compile20.44ms, meteor_contest19.57ms, pidigits19.14ms and generators17.69ms. Largest relative time increases include gc_collect9.57%, gc_traversal9.12%, generators8.74%, typing_runtime_protocols7.85% and sqlite_synth7.47%. These are observed process differences on a shared machine; the native backend did not run in those cases, so they cannot be assigned to redundant native instructions. Startup/CLI execution is a separate fix hypothesis, requiring the later fresh paired experiment. Full sample vectors and both slowdown rankings are retained in `results-current/ANALYSIS.json`.

Candidate rejection reasons are primarily frontend/semantic constraints, separate from deployment economics. Ranked held-out mean self-time shares include closure/keyword-only/*args/generator restrictions2.18%, region With2.08%, nonnumeric globals1.94%, ordinary-lifter recursion1.90%, region integer arguments beyond64bits1.73% and unsupported calls1.73%. These are candidate-specific rejection strings and profiled self-time shares, not exclusive percentages of total runtime or general capability statements. Context managers, dynamic globals/calls and arbitrary-size integers require preserving Python semantics; they are not invitations to drop guards. Some candidate rows failed finite verification or compiled only part of their captured calls and were correctly rejected; no observed output/exit mismatch was accepted as a valid timing pair. Actual new fixes are evaluated separately.

The largest verified candidate reach is **max(cumulative region/self ordinary function)**, capped to script self time and divided by profile total; it is not summed across overlaps. Its mean is a recorded opportunity proxy, not exact dynamic native coverage. Recommendation reach is also a profile metric. Actual default native use is given independently by the counters above. Do not substitute kernel candidate microbench speedups for whole-process speedups.

Costs: fresh combined capture/verification/JIT/AOT/startup-probe profile wall **556.432s**; compile-only bytecode warmups **47.714s**; separate audit wall **174.375s**. All883top-level study child records total **1125.278s** wall, finishing over about19m50s elapsed. The883records are49profiles+490ordinary timings+245audits+98warmups+1native import preflight; profile-created subprocesses are included in profile wall, not counted as separate study records. There is no clean build-only timer. Profile/audit/warmup costs are excluded from deployment latency.

Each workload uses original unchanged loops2/limit40/samples8/5repetitions/180s timeout, default runner without force, two-deal poker arguments, fresh per-source caches, compile-only checked-hash warming of complete source/shim/workload plus profile dependency union, frozen bytecode and write-disabled timings/audits. Source/runtime/DLL/package metadata/environment/helper/shim/full input inventories and all49per-program bytecode/AOT hashes passed final validation. Team jobs were serialized; unknown background machine load remains, and five repetitions do not establish a formal significance claim.

Exact stdout bytes and process exits agree. **Only poker prints result output; the other48entries print no result. Empty stdout/exit equality does not prove full numerical or object-state equivalence.** Captured verification samples are finite evidence; profile CLI stdout is not used as script-output proof. The separate reviewed compiler suite and upcoming selected native full-state audits address additional correctness questions, without changing this cohort's workload. No manual type, array, wider-boundary or semantic relaxation was introduced.

Raw plans, stdout/stderr, exits, hashes, per-run counters, five audit repetitions, fixed-denominator summaries, blockers, all samples and rankings are under `results-current/`. `ANALYSIS.json` is expanded evidence and `COMPACT.json` is the aggregate. CPU slot was explicitly released after coordinator exit0 and final frozen checks; no further performance runs belong to this initial cohort.
