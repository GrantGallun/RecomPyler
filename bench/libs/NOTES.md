
## Test-first result handling
The first fixture run found email policy headers are str subclasses, not exact
str values. Project header values to strings explicitly; typed digest remains
strict and rejects unexpected output types.

## Step 1 interface
Run `python bench/libs/runner.py` from the clone for fresh-process correctness.
`--timing` takes the shared root lock and records three 0.2-second-or-longer
batches per case. JSON stores per-call seconds, batch seconds, repeat count,
warm-up and typed output digest. `--pypy PATH` probes only that interpreter's
installed packages; no CPython binary packages are injected into PyPy.
Fixtures include 15 cases across all 14 S85 package roots. Census scope is
reported explicitly as modules loaded by preparation/execution, not all files
in a distribution. Imports and setup are outside measurement.

## Evidence so far
- Workload fixtures: all 15 CPython outputs deterministic; six roots import under
  local PyPy. Stock timing deferred while other heavy jobs are visible.
- Correctness probes use explicit candidate installation, never deployment.
  Loaded-module census budgets are 60 seconds per workload, and report every
  unattempted function. A partial pass does not prove every native body ran.
- GPU S86: numba-cuda LTO reintroduced FMA after NVVM fma=False. Raw particle
  probe changed from 62/73 mismatches to 0/73 with strict PTX (LTO disabled for
  the generated device helpers and kernel). No GPU speed claim is made.
- Source-fix review found no concrete wrong result or crash. Affected files:
  27 tests passed, including the adversarial multiply/add/subnormal/zero case.
- First fast gate had missing local _flat_native and old GPU failures. Built
  _flat_native offline with its required signature macro. Superseded failed
  gate was stopped at 88%; the corrected warm gate is running with one worker
  alongside the serial census (two active correctness workers total).

## Current acceptance boundary
The strict CUDA repair is commit3ca8d5ea and passed the 3996-test fast gate.
The counted library pass verifies native execution for nine workloads; all six
zero-entry workloads remain explicitly unverified. Full current data is in
RESULT.md and results/installed-counted-correctness.json. No counter wrapper
may be used to claim speed. Cold imports and decision-cache policy have ten
focused tests; the opt-in hook remains a partial delivery prototype. A matching
receipt cannot supply timings to newly generated code. Native object relocation
must pass a fresh-process execution test before cache delivery can be complete.
