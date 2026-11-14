# Wave 3 matched deployment study

Prepared without expensive profile, compilation, native execution or timing runs. Product review/full-suite and a real native graph-state audit remain required before the coordinator grants the measurement slot.

## Frozen comparator and scope

The comparator is a new independent snapshot at `wave3-study/baseline`, commit `dba45a7379402ea33664a5754a2fe6f0927b6855`, branch `codex/wave3-baseline`. It contains all tracked files plus the two native extensions copied byte-for-byte from the unchanged dba integration. `baseline-snapshot.json` records C-source and extension hashes; no borrowed Git object store is used. The original user checkout and all wave2 files remain untouched. Candidate source will be supplied after review, full-suite success and freeze. No baseline508 or historical profile reuse is permitted in this comparison.

The same fixed population remains 38 held-out and nine tuned programs. Go and poker are separate additions, never added to the 38 denominator. Inputs, model inventory, two-deal poker driver, source arguments and shim are checked against the frozen v2 reference; changed or newly added inputs are rejected. Configuration is fixed at limit40, samples8, shim loops2, five repetitions, timeout180, default runner without force. Missing packages/data and failed profiles remain explicit. Python_startup's no-op is retained in coverage accounting and excluded from meaningful timing.

## Execution order and bytecode

Per program, an isolated shared `PYTHONPYCACHEPREFIX` serves all three modes. Absolute source paths keep each source tree's entries distinct. Existing source-side pycs are never consulted.

1. Compile-only warm both complete src trees, frozen shim and workload source. The helper does not import or execute workload code; it excludes .venv/.git/results/cache directories. Checked-hash pycs avoid stale timestamp reuse.
2. Fresh-profile both sources with independent initially empty RecomPyler/Numba caches, allowing writes only into this task-owned bytecode prefix. Profiling order alternates by program. These profiles populate the union of needed runtime-dependency pycs. Both source trees are already warm before startup/profitability probes.
3. Repeat compile-only warmup, then hash/freeze the complete bytecode inventory. Fresh latency children and separate audits use writes disabled. Full bytecode inventory equality is checked before and after timing/audits and on resume.
4. Run five fresh processes each for direct CPython, baseline default CLI and candidate default CLI. Rotate their order by repetition. Raw stdout/stderr, exit, command, wall time, plans and call reports persist atomically. Completed records are never silently retried.
5. After that program's ordinary timings, run five separate untimed audit processes per source, alternating source order. Their overhead and eager imports are excluded from headline latency. They use identical inputs/default plans/frozen bytecode and ordinary profile-created compiler caches.

This deliberately changes wave2's bytecode protocol. Historical v2 timing numbers are context only. No cold-bytecode companion is scheduled. Controlled cold or warm effects require a separately declared follow-up.

## Actual execution modes

Ordinary timing reports retain compiled/fallback/batch totals. Exact `aot_calls_total` and `jit_calls_total` are available only when every relevant function row in all five reports supplies the new fields; legacy, missing or partial fields stay **null**, not zero. Exact mode totals must reconcile to compiled totals. Conservative ahead_of_time booleans and export availability never substitute for per-call evidence.

The independent audit patches runtime wrappers only inside its child. A successful Region.attempt is classified using the actual selected `latest` program's explicit compiler-mode flag. True counts AOT; false counts JIT/cache-backed native execution; absent/unknown mode stays unknown. Rejected attempts are separate from successful native calls. Ordinary Lifted call deltas classify accepted AotLifted subclasses as AOT. Wrapper fallback deltas are retained; runner-only preparation-failure fallback counts remain separately identified. JIT counts do not claim a machine-code disk-cache hit or a fresh compilation.

Each audit preserves its own output, exit, actual mode counts, per-digest events, Numba import state and total reconciliation. New product exact counters are cross-checked against that independent audit process. Unknown modes, mismatches, missing payloads, or uninstrumented batch execution invalidate an audit claim. No audit total is treated as the corresponding uninstrumented timing process's mode evidence. Five audit repetitions expose nondeterministic deployment; report per-program call ranges and per-group native/AOT program-count ranges separately from latency counters. Candidate exact timing counters directly describe its five latency processes. Legacy baseline timing mode remains unknown where fields are absent.

`native_preflight.py` verifies imported C-extension origin/hash only. It is **not** sufficient native execution proof. Before full measurement, the reviewed product's actual initially-empty → populated graph fixture must be run through audit.py, with real rebuilt native extensions and a matching AOT export, checking values/mutations, selected AOT calls, zero unintended JIT, and reconciliation. Fake fixtures validate instrumentation mechanics only. The coordinator owns this gate with the product worker; nothing expensive has been launched during preparation.

## Accounting and planned workload

Fixed study: 98 fresh profiles + up to735 ordinary fresh timings +490 fresh untimed audits +98 compile-only warmup children +two import-path preflights. Expected runtime is longer than v2: roughly 20–40 minutes depending on build/audit paths. Each child has its own 180s timeout; preserve timeouts and partial output rather than infer a speedup. No source or configuration repair is allowed mid-freeze.

Process speed is median plain wall / median default wall. Paired geomeans list their identical successful meaningful subset; coverage denominators remain fixed 38/9, with additions separate. Empty stdout equality is necessary evidence, not full result equivalence. Profile CLI output can include the report itself and is not compared as proof of plain-script output equivalence.

Largest verified candidate reach remains an opportunity proxy: max cumulative region reach or ordinary self time, capped to script self time and divided by total profile time. Do not sum overlapping regions. Report recommendation reach separately from native deployment, programs with actual native timing calls, and programs with reconciled actual-mode audits.

Record combined profile capture/verification/JIT/AOT/startup-probe wall separately for each fresh source. Record both compile-only bytecode warmups separately. Retain candidate first_pass/warm_start and AOT metadata, without inventing a clean build-only timer or summing overlapping candidate costs. Audit wall is instrumentation cost, not speed evidence.

Manifest schema3 retains `execution_environment` for the coordinator's native comparison wrappers. It freezes interpreter/runtime DLL/distribution identity, sanitized allowlisted environment and explicit bot defaults, source/native hashes and Git status, full filtered input inventory, shim/driver/helper hashes. New/deleted inputs invalidate resume. Bytecode inventory lives per program after its profiles, so freshly generated pycs do not mutate the source manifest.

## Commands after the review gate

```powershell
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave3-study/study.py prepare --candidate <FROZEN_CANDIDATE_PATH> --output D:/Code/Datathon/recompyler-codex-20261111/wave3-study/results
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave3-study/study.py run --output D:/Code/Datathon/recompyler-codex-20261111/wave3-study/results
```

Preparation is metadata/hashing only. Manifest path will be `wave3-study/results/manifest.json`. `summary` regenerates summaries; `--names` resumes selected frozen programs without changing the denominator.

Only after paired timing, prepare/run the same predeclared long diagnostic in a distinct directory:

```powershell
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave3-study/study.py prepare --candidate <FROZEN_CANDIDATE_PATH> --cohort long --output D:/Code/Datathon/recompyler-codex-20261111/wave3-study/results-long
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave3-study/study.py run --output D:/Code/Datathon/recompyler-codex-20261111/wave3-study/results-long
```

This keeps chaos and richards_super only, shim loops20, same40/8/5/180 configuration, fresh profiles and ten fresh untimed audits per program. Its selection was the earlier predeclared >10% opportunity criterion, not post-hoc speed selection. It demonstrates whether a profitable fresh default plan actually deploys AOT; it does not alter the 38-program headline. The coordinator owns the nine unchanged C-port diagnostics in wave3-native / wave3-native-baseline after paired timing; their best-of-kernel checks/costs and actual modes stay separate from whole-process timing.

## Fixture evidence

Fail-first tests initially rejected missing audit/warm-bytecode functionality. A separate added regression then failed for absent exact timing-mode handling. Latest tiny validation: 13 tests pass. Cases cover mixed AOT/JIT/rejected attempts, unknown-mode safety, ordinary AOT/fallback counter deltas, null legacy/partial timing fields, frozen bytecode additions, shared prefix settings, compile-only behavior without workload execution (including ignored invalid .venv source), timeout/raw-output/resume, runtime/package/input additions and sanitized credential-free environment. No product import, profile, AOT/JIT compile, corpus run, bot run or timing experiment was executed.
