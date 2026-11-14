# AOT execution-mode reporting correction

Isolated branch `codex/heldout-fixes`; report-only commit `148a296` (parent `ca5a630`). Only `src/recompyler/runner.py` and `tests/test_runner_modes.py` changed. No heap/lift compilation logic, AOT artifact schema, shared installation or measured integration source was changed.

## Evidence and behavior

Coordinator evidence `wave2-study/aot-mode-audit.json` showed three fresh RichardsSuper executions reporting `ahead_of_time: true` despite their actual region programs having `ahead_of_time: false` and importing Numba. The old runner flag recorded whether exports had been supplied, not whether execution used them.

The report now separates:

- `aot_loaded`: usable exports were loaded for the selected wrapper. This is availability, not proof of execution mode.
- `ahead_of_time`: at least one compiled call executed and, for a Region, **every prepared program** is non-null, not broken and marked ahead-of-time by the compiler. For the ordinary AotLifted path, the accepted AOT wrapper must have executed at least one compiled call.

The Region predicate is deliberately conservative because there are no per-signature execution counters. `false` can mean mixed or unknown preparation, or zero compiled calls; it does not itself prove JIT execution. A true flag describes compiled calls, not Python fallbacks reported separately. Artifact presence alone can no longer yield a true execution-mode flag.

## Regression and validation evidence

- Failed-first run: **5 failed, 4 passed** (`heldout-fixes/.tmp/runner-modes-before.txt`). Cases cover loaded exports with a digest miss/JIT program, mixed AOT/JIT programs, an unknown signature, a prepared wrapper that only falls back, valid AOT execution, and zero-call controls. Ordinary AotLifted is tested separately.
- Focused CLI/interaction run: **47 passed, 2 subtests passed**, 24.01 s (`heldout-fixes/.tmp/runner-modes-focused.txt`).
- Complete suite, all files frozen at the commit: **317 passed, 38 subtests passed, 10 warnings**, zero failures/skips, 69.35 s (`heldout-fixes/.tmp/runner-modes-full.txt`).

Python was `C:/Python314/python.exe`, with explicit heldout-fixes/src PYTHONPATH and task-local cache/TEMP/TMP. Working tree clean; whitespace diff checks pass. No timing benchmark or compiler-algorithm change is claimed. Validation jobs have finished and the slot is released to the coordinator.
