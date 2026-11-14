# Runtime AOT policy and reporting: independent review

Reviewed `43836db` (including `148a296`) in `heldout-fixes`, against `ca5a630`, using `WAVE2-runtime-policy-review.txt` and the current runner, region compiler, ordinary AOT loader and plan-budget code.

**Verdict: no actionable finding in this bounded runner-only correction. Suitable for integration after the pending full suite passes.** The policy prevents the demonstrated unbudgeted region JIT deployment on an AOT miss; it is not a universal guarantee that Numba can never be imported.

## Checked behavior

- `_AotOnlyExports` deliberately remains truthy through both `exports or {}` defaults. A matching digest returns the actual exported callable. A miss raises the existing `Unsupported` exception during generation, before the compiler's explicit JIT path; `Region.program_for` catches and caches that unsupported signature and ordinary `Region.__call__` performs Python fallback. No generated function or user function is executed by this missing-export lookup, so it does not duplicate the original call's effects.
- Missing region modules use the same truthy empty adapter and decline at digest lookup. Missing ordinary AOT modules or rejected `AotLifted` preparation mark the wrapper failed and execute the original Python function. The wrapper increments its Python-call count once when no lifted object was prepared. Argument expressions are evaluated by the caller once and their values pass through the wrapper; preparation does not reevaluate them.
- Default AOT-only behavior applies when all selected functions have corresponding exports. `--force` and selected plans containing uncovered/JIT-budgeted functions retain the previous ability to use JIT. The coverage check selects the ordinary or region export section according to the function's engine; it does not treat a region export as an ordinary one. This matches the intended conservative policy scope, rather than disabling all compilation globally.
- Reporting now separates `aot_loaded` from `ahead_of_time`. An ordinary AOT wrapper needs at least one successful compiled call for `ahead_of_time=true`. A region additionally requires all recorded prepared programs to be nonmissing, unbroken AOT programs. Thus export presence alone no longer claims successful AOT execution, and mixed/unknown preparation conservatively reports false.
- The reporting boolean is intentionally conservative, not a per-call AOT/JIT split: a rejected or unexecuted signature can make it false even if all successful native calls were AOT. Consumers must not reinterpret false as proof of JIT execution. Existing `compiled_calls` remains the native total; fallback reporting now includes wrapper preparation failures that directly run Python.
- No heap, lifter, lowering ABI or digest inputs changed. The existing ordinary/region AOT artifact compatibility checks still run, and the adapter does not weaken their digest/guard validation. Runner-only changes do not invalidate those compiled kernel artifacts.

## Independent validation

Ran only the two new focused files:

`tests/test_runner_budget.py tests/test_runner_modes.py`: **15 passed**.

The six fresh-process budget cases cover region digest miss, missing region module, missing ordinary module, matching region export, forced JIT and an uncovered mixed plan. They check two original mutations occur exactly twice, compiled/fallback counts, actual reporting and the presence/absence of Numba for this non-NumPy example. The nine reporting cases cover successful ordinary/region AOT, loaded-but-unused exports, JIT/mixed/unknown regional preparation, and fallback-only execution.

The matching region export test uses a test callable with the known tiny ABI rather than rebuilding a native extension. Real-extension and complete-suite validation remains the worker/coordinator's responsibility; no duplicate AOT build, full suite or benchmark was run for this review.

## Explicit NumPy limitation

`heap._Program.compile` assembles `extra_runtime()` before consulting the export dictionary. When arrays are used, `extra_runtime()` imports `_nd`, whose module-level imports include `numba.types` and `numba.extending.intrinsic`. Therefore an array region can import Numba before the new missing-digest adapter rejects it, even though it will not execute the later explicit JIT path. The same import can precede matching AOT selection. This is an existing initialization limitation outside this runner-only patch; neither these tests nor this verdict establishes universal no-import behavior or complete startup-cost neutrality. It should remain explicit in deployment/performance claims.

Interpreter: `C:/Python314/python.exe`; explicit `PYTHONPATH` points to `heldout-fixes/src`. Temporary files, bytecode and caches were directed to `review-scratch`. Product source remained read-only. No subagents or timing measurements were used.
