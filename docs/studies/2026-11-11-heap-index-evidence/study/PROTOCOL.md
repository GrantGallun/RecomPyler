# Wave 5: narrow object-field indexing A/B

This task-local study compares the new physical object-field index annotation against **current** baseline integration `3f0370d5fe5c358b4a0b3fd8e1ea10a2f22f87bf` (product `0d2c3d3`), not the earlier dba baseline. No new frontend coverage or universal Python-equivalence claim is intended. Historical wave3/wave4 files remain immutable.

## Baseline and correctness scope

`baseline/` is a clean independent clone with no borrowed object store. Two ignored native extensions were copied byte-for-byte from integration; `BASELINE.json` records their hashes and matching C sources, with no rebuild claim. All28 tracked src files were compared against the actual current integration bytes. One newline-only difference in _region_seed.py was aligned only after normalized equality, then Git filters/index were refreshed without a staged change. `BASELINE-RAW-ALIGNMENT.json` records all actual source hashes. Candidate will be frozen only after review/full tests and exact tested-byte alignment.

The reviewed narrow proof applies only to object field reads/writes and polymorphic tag reads after handle() verifies presence. Loader/checked allocation supplies a complete object layout in the finite <=2**27-slot arena; fixed field/flag offsets keep the final physical address nonnegative and bounded. The cast surrounds the complete signed sum, not its operands. Numeric MIXED/optional/NumPy scalar flag slots propagate the proof. Tuple payload recursion deliberately stays signed because a nullable tuple's -1 handle may still participate in ignored speculative payload reads. User list/string indices, containers, helpers, sentinels, raw ndarray strides and Python loaders remain unchanged.

Independent review of the actual117-line diff found no actionable semantic issue in that scope. Focused/full-suite evidence is owned by the implementer/coordinator. A tuple-return identity failure was reproduced on the baseline and is outside this narrow optimization; equal benchmark values do not establish arbitrary identity/alias compatibility. Do not hide that limitation or weaken existing guards to obtain a speedup.

## Frozen matched measurement

`bench.py prepare` copies the nine existing hash-verified C binaries, matching Python drivers and C sources into a new results directory. C stays the same clang21.1.6 `-O3 -march=native -ffp-contract=off`/UCRT build; no new C build or historical timing reuse. Scripts have exactly the prior state-reset bodies and numeric checks. Input inventories, current source/Git/native hashes, helper hashes, interpreter/runtime DLL/distribution identity and sanitized allowed environment are frozen. New/deleted inputs or changed helpers invalidate resume.

Order starts Barnes, nbody, float and SciMark, then fannkuch, spectral_norm, coroutines, basic Richards and raytrace. Both sources receive fresh isolated profiles (limit40, samples8, one inner state). Profile order alternates by program. Before profiles and again before timing, compile-only warmups populate a shared task-owned per-program bytecode prefix for both src trees/drivers/shim. Runtime dependencies are warmed by the union of both profiles. Freeze/hash the entire prefix, then disable writes throughout timings/audits. Preexisting source pycs are excluded.

Five rotating fresh process repetitions measure direct CPython, a common C reference, baseline default/forced and candidate default/forced. Python/RP retain five fresh-state inner repetitions; C retains20, the historical explicit difference held constant across source versions. Each process emits its best inner-kernel time and numeric checks. The kernel comparison uses the median of those five best-inner observations; whole-run comparison uses median process wall including setup/imports/compiler load/guards/conversion/execution/check printing. Default unforced process wall is the deployment headline; forced kernel evidence is explicitly diagnostic.

As in the prior declared native comparison, basic Richards, spectral norm and SciMark additionally select verified candidates above1.05x for a separately labelled explicit warm view with force permitted. This rule is declared before results; it can choose different native paths in each source. Report the actual per-row path, and do not attribute a changed path to better machine instructions. The selected kernel table uses this warm view for those three, forced for the other six; retain every default/forced result regardless. No fastest-mode post-hoc selection.

Total:18 fresh profiles,300 ordinary timing children,42 separate untimed mode audits,18 compile-only bytecode warmups. Per-child timeout300s matches the earlier native diagnostic. Expected wall about12–20minutes, dominated by fresh AOT/profile construction, followed by two small phase and two read-only artifact-mapping jobs. No49-workload rerun is proposed. Failure, mismatch or timeout records persist rather than being silently retried.

Only this team's performance jobs are serialized. Root observed an unknown external Python process consuming CPU during preparation; its ownership was not established and it was not terminated. This is a shared Windows host, not an OS-wide quiet-machine guarantee. Retain all fresh-process/kernel sample distributions and use paired rotations plus a newly timed common C reference from the same period. Do not compare absolute times directly with historical C measurements or attribute small differences to this optimization without supporting evidence.

Checks require identical key sets, integers and float bit patterns, including signed zero. Timing lines are excluded from numeric equivalence. Pure Python rows remain visible among all13 kernels; aggregate FFT native calls must never be assigned to SOR/sparse/MonteCarlo/LU. Both sources now provide exact successful AOT/JIT/fallback counters, retained per timing process; missing fields stay unknown. Separate actual-program mode audits reconcile wrapper/product counters and printed checks, but do not retroactively classify uninstrumented timing processes. No output consistency claim extends beyond the finite numeric checks/regressions.

## Native entry/boundary and assembly evidence

After ordinary paired timings, `bench.py phases` runs an instrumented Barnes diagnostic for each source with six repetitions of100advances. The first is excluded from warmed component medians. Load/guard/native-extension-entry/write-back/other-attempt/final-Python-energy costs are separate. All600 advances must succeed through actual AOT, with the same printed check values; otherwise the diagnostic is invalid and raw evidence is retained. Timers add overhead, the native entry includes the C-extension ABI wrapper, and this process never supplies a headline timing sample.

`bench.py map-aot` consumes each newly built plan and its successful separate AOT audit. It maps the actually executed digest to the saved export and actual loaded PE wrapper address, preserving artifact/plan/audit SHA-256. The assembly tool follows that wrapper's machine call targets to the internal entry/body. Use these new measured artifacts, never a historical export or profiling JIT assembly in place of the selected AOT code. Profiling JIT LLVM may be retained only with that explicit label.

The separate tools owner supplies a configurable disassembly executable (`--tool`); this study contains no hardcoded Swift path. Compare the force-load/object-field normalization blocks and preserve excerpts/symbol address maps. Show static signed-index normalization removed even if speed differences are small or noisy. Static instruction counts are not cycles, do not establish hot-path frequency and do not by themselves apportion the native or whole-process gap.

## Commands after review/source freeze and CPU slot

```powershell
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave5-study/bench.py prepare --candidate <FROZEN_CANDIDATE_PATH> --output D:/Code/Datathon/recompyler-codex-20261111/wave5-study/results
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave5-study/bench.py run --output D:/Code/Datathon/recompyler-codex-20261111/wave5-study/results
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave5-study/bench.py phases --output D:/Code/Datathon/recompyler-codex-20261111/wave5-study/results
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave5-study/bench.py map-aot --output D:/Code/Datathon/recompyler-codex-20261111/wave5-study/results
```

Preparation does metadata/copying/hashing only. Root grants the exclusive heavy profile/timing/diagnostic slot after full-suite and review. The harness is task-local evidence tooling, not the independently developed generic repository CLI. No benchmark, profile, native build or timing experiment ran during preparation. Tiny mechanics fixtures pass; they validate bitwise/key checks, parse separation, predeclared mode policy and complete inventory additions.
