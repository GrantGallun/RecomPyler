# Independent S50 whole-program harness review

Static preflight review, 2026-11-14. Read s50_programs.py, run_s50_locked.py, prepare_s50_lock.py, run_locked audit, current CLI/profile/runner report semantics, both benchmark sources and recipes, long pyperf shim, and pypy-compare/rp_long.py. No product changes, workers, timings, lock changes or process intervention. Only this report is written. The live v2 waiter was not touched.

Reviewed hashes: s50_programs.py 542df94e4302ba132d1d44a3e87d06b3d981049c38cf5712603b3b464292cfca; run_s50_locked.py a7691a31cd12140ec911ce90c9a5a9dde5dc6c83f10b7492f4f7b39b61ec02b4; long shim pyperf.py f975adde0b540d87675f45be79d4cf441d2bde7cd1c2088a013820237fd9986d.

## Blocker: new cohort inputs and generated deployment artifacts are incompletely sealed

The wrapper correctly checks existing frozen product source before/after. The inner harness also hashes copied benchmark input files before/after. However the copied shim is hashed only at the end, s50_programs.py only at the end, the recipe manifest is never hashed, and run_s50_locked.py has no recorded initial/end hash. A harness/shim change during execution can therefore be assigned the final bytes instead of the executed bytes. The newly generated selection plan is hashed only after all timed runs, and generated native AOT artifacts are not added to a before/after cohort artifact manifest. Existing kernel artifact checks do not cover the S50 deployment artifacts created by profile.

Before execution, seal both harness files, the manifest and original/copied shim inputs; verify hashes after. Record exact interpreter identity and effective child environment used for each program. After each profile succeeds, freeze the generated plan and all referenced native artifact bytes before the first timed pair, verify them again after all pairs, and link those hashes in the complete receipt. Retain expected manifest benchmark hashes or record the precise copied workload source identity explicitly so the 20-loop result is attributable. Do not assert source_unchanged=True unless every required verification actually completed.

## Blocker: exception paths omit failure receipts

execute() writes a command receipt only after subprocess.run returns. TimeoutExpired and OSError bypass the command receipt entirely even though partial stdout/stderr may exist. The wrapper likewise writes its final receipt only after post-run verify() and success-summary parsing. A source/artifact mismatch, missing summary/complete file, JSON parse error, observer-finalization error or launch failure can exit through lock release without a structured final failure receipt.

Use try/except/finally receipt handling that records attempted command, timestamps, timeout/launch status, exit code when available, exception details and hashes of partial logs. The outer wrapper should retain complete=false with the failed verification stage, and its current owner token must still control lock release. Never produce timing.complete.json or accepted summary on a failed stage. Existing incomplete directories must remain excluded and must not be reused under a new interpretation.

## Confirmed command/count behavior

The CLI accepts the exact profile/run flags and placement used here. --limit 40 and --samples 8 match the saved PyPy comparison harness; no --force or threshold modification is present. Candidate verification and selection remain product-owned. run reports use functions as a list and include compiled_calls/aot_calls/jit_calls/fallback_calls, plus not_found and batch reports. The no-jit assertion is on actual successful execution counts. Empty functions with zero compiled calls is a legitimate unmodified selection outcome and must be reported as plain Python, not as deployed native work.

The copied shim sets LOOPS=20; bench_time_func calls func(20,*args), matching both scimark and spectral_norm. Both input folders currently contain only run_benchmark.py, so they do not shadow pyperf. Three fresh-process pairs alternate order correctly, and ratio-of-medians is computed correctly. Whole-process wall includes interpreter/startup/report overhead. Profile/selection is outside timed pairs but inside the timing lock.

Product profile/run reports print to stderr; stdout comparison therefore compares program stdout rather than CLI diagnostics. Pair zero establishes a Python reference, and every subsequent timed execution is compared exactly. These benchmarks normally print no numerical answer, so stdout_identical means precisely output bytes agree; it is not an independent numerical correctness certificate. Keep that claim literal and rely on the separate exact correctness gates for product semantics.

Do not start this separate waiter while the earlier Python timing waiter is still alive: the shared audit recognizes Python coordinator exclusion only for run_locked.py, so two run-specific waiting controllers can regard each other as competing workspace workloads. Starting S50 sequentially after the prior waiter exits avoids that issue without touching any live process.

Disposition: CLI, loop count, selection choice, pairing and report-field interpretation are valid. Correct the two receipt/provenance blockers before execution; no workload rerun or product edit was performed by this review.

## Recheck after harness fixes

Revised hashes inspected: s50_programs.py 4cad85e5a0ae85591deabfe6264780b21a1b9023636f8b7c9cfbb2107ef087c8; run_s50_locked.py 8336fba14e88160251a0baa97be63ed67b130379aeb5768d6c841acf6250c090. No cohort executed.

Structured command receipts now retain timeout/launch failures and partial-log hashes; the inner uncaught exception hook and outer exception handler write complete=false failure receipts. Manifest, inner harness and copied shim hashes are checked before/after each command. Generated plan and cache/rp contents are sealed after profile and checked before/after every timed run. These address the main findings above.

Confirmed cache coverage against actual product: lift._cache_dir reads RECOMPYLER_CACHE, which the harness sets to cache/rp. profiler.build_ahead_of_time and build_regions_ahead_of_time both use that directory, so its recursive file hash captures the generated scalar/region native exports. The long shim currently contains only pyperf.py; glob *.py covers all current executed shim support.

Remaining small required provenance correction: the initial fixed-input map includes s50_programs.py but does not include run_s50_locked.py or its imported run_locked.py helper; the outer wrapper never records/checks its own initial bytes. Seal those driver/helper files at main entry and verify them before emitting an accepted final receipt. Record the effective controlled environment/interpreter identity alongside the command when documenting reproducible runtime provenance. This is a static recheck; completion still depends on the actual complete source-unchanged receipts.

## Final preflight disposition

Final inspected s50_programs.py hash: 37c63b95384467d5ee88158846a2da4fd4cb140e00a2158f1b51fe2c0a435c0c. Wrapper remains 8336fba14e88160251a0baa97be63ed67b130379aeb5768d6c841acf6250c090; imported lock helper is 73b45d4ac43a3a62d2aa2b746e88128a2ae26dae1d609f7b66288c30efab3c3d.

Confirmed fixed_inputs now includes both wrapper and imported lock helper and is checked before/after each child command and at completion. Command receipts include interpreter executable/version and the controlled child environment. The previously identified preflight blockers are addressed. The harness is suitable for the authorized sequential S50 cohort under its timing lock. This is approval of the inspected measurement harness, not acceptance of results: any timeout, failed command, output mismatch, source/artifact mismatch, incomplete receipt or disturbed timing remains subject to the established exclusion/reporting rules. No cohort, worker, lock or live process was touched by this review.
