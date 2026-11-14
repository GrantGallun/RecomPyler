# AOT-only startup budget safeguard

Commit `43836db` on isolated `codex/heldout-fixes`, parent `148a296`. Only runner.py and tests/test_runner_budget.py changed. Compilation algorithms, emitted kernels, loader/layout ABI, AOT schema, heap.py and lift.py were untouched. The measured integration copy was not edited.

## Policy

A default run whose selected recommendations all have nonempty AOT export entries uses an AOT-only deployment policy. A region digest miss becomes Unsupported before JIT entry and is cached by Region as an unsupported signature; the original Python function runs instead. A missing ordinary AOT module or rejected ordinary AOT wrapper likewise falls back to Python without attempting the ordinary JIT lifter. Direct Python calls after preparation failure are now included in fallback counts.

The internal `_AotOnlyExports` mapping stays truthy even if an AOT module could not load, so the existing `exports or {}` defaults preserve the restrictive policy. It returns only an exact matching export and raises Unsupported on a missing digest. It never ignores a source hash or substitutes another export.

`--force` retains explicit JIT opt-in. A plan with an uncovered selected recommendation already budgets JIT and keeps the existing behavior. Matching AOT exports continue to execute. This fixes unbudgeted JIT on deployment misses; it does not fix the graph-layout or unordered-emission causes diagnosed in WAVE2-AOT-AUDIT.md.

## Tests and evidence

Six fresh-process regression cases exercise loaded-but-unmatched region exports, unavailable region and ordinary AOT modules, an exact-match region export, --force, and a plan with an uncovered/JIT-budgeted recommendation. They check exact single application of list mutations, compiled/fallback counts, actual AOT reporting, and Numba import state.

- Before the safeguard: **3 failed, 3 passed** (`heldout-fixes/.tmp/runner-budget-before.txt`). Default misses incorrectly imported Numba and executed JIT code.
- Focused budget/mode/CLI/interaction checks: **53 passed, 2 subtests passed**, 27.05 s (`heldout-fixes/.tmp/runner-budget-focused.txt`).
- Full suite with all source/tests frozen at the commit: **323 passed, 38 subtests passed, 10 warnings**, zero failures/skips, 75.14 s (`heldout-fixes/.tmp/runner-budget-full.txt`).

Python: C:/Python314/python.exe, explicit local PYTHONPATH and task-local cache/TEMP/TMP. Working tree clean; whitespace checks pass. No timing benchmark was run by this worker. Validation slot released after all jobs finished.

## Scope of the import guarantee

The fresh scalar/list regression processes prove no Numba import on their AOT-only misses and exact AOT match. This is **not a universal no-import guarantee**: existing heap.extra_runtime imports recompyler._nd before digest lookup for ndarray kernels, and _nd imports Numba at module scope. The coordinator explicitly retained this separate array source-generation limitation to keep the engine and ABI untouched. The safeguard's contract is no unbudgeted JIT compilation after an AOT-only digest/load miss.
