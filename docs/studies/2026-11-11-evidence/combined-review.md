# Wave 2 combined integration review

## Scoped re-review of 75aefc1

**Current verdict: all three findings resolved; ready for source freeze from this scoped review, conditional on the coordinator's pending full-suite check.** No remaining actionable defect was established in the fix paths. This does not extend the original bounded review into a complete compatibility claim.

- **Generator interleaving: resolved.** The runner removes the eager loop rewrite and leaves selected generator functions in Python. Original end-to-end repro now prints `3`, with zero compiled calls and `lifted: false`. This intentionally gives up that generator optimization; it should not be counted as native runner coverage or used to claim an execution speedup from the profile's standalone region timing.
- **Strided view conversion and effects: resolved.** Programs which form array views now refuse noncontiguous inputs before execution. Both original loader repros succeed via Python with the correct shared row view and a single increment. Result-conversion `_Mismatch`/`MemoryError` also rolls back zero-copy array stores before heap write-back and fallback. The focused forced-rejection regression covers unchanged arguments after `attempt` and exactly-once effects through `Region.__call__`. Additional independent C- and Fortran-contiguous probes compile successfully under both loaders and retain view aliasing and strides.
- **Nested global graph identity: resolved.** Snapshots retain original node objects and original edges; restoration restores each node in place. The original real `test_region` repro still returns `verified` and now preserves `ROOT[0] is ALIAS`. Focused tests cover read-only/mutating globals and cycles. An independent two-root probe confirms preservation of a child shared across separate saved globals.

Evidence from this re-review:

- Re-ran unchanged `review-scratch/review_probe.py` and `review-scratch/global_full_probe.py` against `75aefc1`; all original observed discrepancies are corrected.
- Ran focused `tests/test_integrated_features.py` selection (`quiet_generator or strided_returned or global_verification or global_restore or result_conversion`): **10 passed, 10 deselected**.
- Added and ran scratch-only `review-scratch/fix_edge_probe.py`: C/F contiguous returned views with both loaders and overlapping global roots all pass.
- Inspected the complete four-file fix diff and its new conservative rejection/rollback paths. No source edits, no subagents, no duplicate full-suite run, no performance measurements. Full-suite evidence remains owned by the coordinator/worker.

---


Reviewed revision: `a0a6a149e6e8b66ad66c95a25ae813db84d3d8ad` on `codex/integrated-coverage`, against baseline `56211d5`.

Initial verdict at `a0a6a14`: **changes required**. Three reproducible correctness defects need correction before freezing the combined source. These concern active inherited behavior, within the requested review scope, rather than only textual merge conflicts.

## Resolved in 75aefc1 — P1: Empty-loop batching skips observable loop-target assignments

Location: `integration/src/recompyler/runner.py:85` (`_QuietLoops.visit_For`, especially the eligibility check and rewriting through `each_call`).

A loop whose body is `pass` still assigns its target after each yield. A generator can observe that target through a module global or closure. The rewritten loop runs the generator to completion before performing any target assignment, changing its values and the final state.

Reproducer (`review-scratch/quiet_target.py`, recommended region plan in `quiet_target.json`):

```python
x = 0
def values():
    for i in range(3):
        yield x + 1
for x in values():
    pass
print(x)
```

Python prints `3`. `runner.run_script(script, [], plan)` prints `1` and reports one compiled call, zero fallback calls. The plan selects `values` at line 2, `generator: true`, and a verified/recommended region candidate. The region's constant global guard holds when it begins, so it cannot detect the missing interleaved assignments.

Fix expectation: preserve per-yield target assignment semantics or conservatively leave such loops in Python unless their assignments provably cannot affect the generator. Add the above end-to-end runner regression, including output and compiled/fallback accounting. A `pass` body alone is insufficient proof.

## Resolved in 75aefc1 — P1: Strided array row results raise after committing direct array writes

Location: `integration/src/recompyler/heap.py:6137` (`_Unloader.view`), with the result-unloading boundary at `Region.attempt:6609`.

The loader and generated code accept noncontiguous arrays, but unloader view reconstruction uses `np.ndarray(..., buffer=root, ...)`. A noncontiguous root does not export the contiguous buffer required by this constructor. The exception escapes the attempt after the kernel has already modified the original array; no fallback or rollback covers this result-unloading failure.

```python
def first_row(a):
    a[0, 0] += 1.0
    return a[0]
a = np.arange(12., dtype=float).reshape(3, 4)[:, ::-1]
heap.lift_region(first_row)(a)
```

Python succeeds, returning `[4., 2., 1., 0.]` as a view into `a`. The region raises `ValueError: ndarray is not contiguous`; `a[0, 0]` has nevertheless changed from `3.0` to `4.0`. Confirmed with both `heap.NATIVE = True` and `False`.

Fix expectation: construct a valid shared view using a compatible owner/buffer while preserving strides and writeability, or reject this shape before direct writes. Any fallback triggered after execution must roll back direct array effects first. Add both-loader regression checking returned view aliasing and exactly-once mutation.

## Resolved in 75aefc1 — P1: Verification replaces nested global objects even for read-only code

Location: `integration/src/recompyler/profiler.py:445` (`_global_state`) and `:468` (`_restore_global` list case), called by `test_region.reset` and final restoration.

Global state is deep-copied and restored by replacing a top-level list/dict/object's children. This preserves value equality but destroys identity and aliases to the original children. Merely profiling a read-only function can permanently alter the application's graph; independent snapshots of overlapping globals and cyclic graphs have the same underlying issue.

```python
ROOT = [[1]]
ALIAS = ROOT[0]
def read_global(n):
    return ROOT[0][0] + n
assert ROOT[0] is ALIAS
result = test_region(read_global, [((2,), 3, (2,))], 1)
# result['status'] == 'verified', but ROOT[0] is ALIAS is now False
```

Confirmed with the real, unpatched `test_region` including its timing paths (`review-scratch/global_full_probe.py`). The combined initial probe also demonstrates the same issue with timing helpers stubbed, isolating restoration from timing.

Fix expectation: restore existing graph nodes in place with shared identity bookkeeping across roots, or conservatively skip verification where safe restoration is unsupported. Add a read-only nested-global regression and a mutable nested-global alias check. Restoration must preserve observable identity, not only equality.

## Evidence and limits

- Scratch probe: `D:/Code/Datathon/recompyler-codex-20261111/review-scratch/review_probe.py` reproduces all three defects; `global_full_probe.py` separately confirms the profiler defect without monkeypatches.
- Interpreter: `C:/Python314/python.exe`; `PYTHONPATH` explicitly points to `integration/src`. Cache, bytecode and temporary files were directed to `review-scratch`. No source files in integration, primary or original checkouts were edited.
- Read the wave plan, integration report, previous status and original interface notes. Inspected merged call binding, generator sinks/inlining and flow flags, superclass dispatch, native-kind exclusions, loaders/unloaders and transactional array execution; profiler copy preflight/global reset; Python/C generator sampling lifecycle; runner selection and plain path; cross-track regression tests.
- This was a bounded integration review, not an exhaustive compiler audit. No full suite duplicate or timing study was run. The build fix was already independently reviewed and excluded from re-review. The parent's pending full-suite results do not invalidate the concrete probes above.
- No additional actionable finding was established in the reviewed pickle-hook preflight, Python/C exceptional generator discard changes, or early plain-run path. This is not a blanket proof of those subsystems.

The integration worker received the reproducer paths and descriptions directly for focused fixes and regressions. The scoped re-review is recorded above.
