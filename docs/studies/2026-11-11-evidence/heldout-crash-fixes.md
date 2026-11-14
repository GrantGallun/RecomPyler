# Held-out profile crash corrections

Owned copy: `heldout-fixes`, branch `codex/heldout-fixes`, based on frozen `75aefc1`. The frozen integration copy and study evidence are unchanged. Preparation used only code/trace inspection and test authoring while timing ran; tests and implementation began only after the coordinator released the validation slot.

## Root causes and focused changes

1. The deepcopy workload reached `flow.function_locals`, whose shared FunctionDef/AsyncFunctionDef/ClassDef branch called `_defaults(ClassDef)` and read nonexistent `.args`. ClassDef now has its own local-name collection branch, walking decorators, bases and keyword values in the enclosing scope, and excluding class bodies and type parameters. It mirrors the existing analysis walker's ClassDef rule.
2. Generator profiler discovery called `Region.program_for` directly without the generator entry's hidden collecting-list argument. Recursive delegation consequently encountered BOTTOM and leaked internal `_Pending`. Discovery now seeds that output list just as `Region.attempt` does. Separately, recursive delegation can encounter a helper result whose type is learned on a later inference pass; it now defers that statement and requests another pass, as expression calls already do. The existing finite settling limit still produces Unsupported/fallback if types cannot resolve. No broad exception catch was added.

Product delta: 20 added/3 removed lines across flow.py, heap.py and profiler.py, plus eight focused regression tests.

## Red/green evidence

- Before changes: **7 failed, 1 passed** in the eight new tests (`heldout-fixes/.tmp/heldout-before.txt`). Both exact internal exceptions reproduced, including a second `_Pending` case with a deferred helper result.
- After changes: **66 passed, 20 subtests passed** in 5.37 s across new regressions, flow, monitor and integrated interaction tests (`heldout-fixes/.tmp/heldout-focused.txt`).
- Class regressions cover surrounding local names, header walrus bindings, conditional class definitions, unbound base reads, excluded class-body/type-parameter bindings and clean profiling refusal.
- Generator regressions cover profiling the small recursive Tree.__iter__ reduced from the corpus, supported delayed helper inference, and clean fallback for an unsupported recursive consumer.

## Actual corpus profile validation

Both formerly crashing corpus profiles were rerun in fresh processes with the frozen study's pyperf shim, frozen execution environment, `--limit 40 --samples 8`, explicit heldout-fixes/src PYTHONPATH and separate local caches/TEMP. Each had a 180-second timeout; neither timed out.

- **deepcopy**: exit 0, plan produced; `benchmark_reduce` cleanly skipped for unsupported ClassDef.
- **generators**: exit 0, plan produced; `__iter__` verified all eight captured samples.
- Both stdout hashes remain SHA-256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (empty stdout), matching the frozen executions.

Exact commands/cwd/status and output transcripts are in `heldout-fixes/.tmp/heldout-profiles/{deepcopy,generators}/profile.json`, `.stdout`, `.stderr`, alongside `fixed.plan.json`. The repeatable validation driver is `.tmp/validate_corpus.py`. These are post-fix correctness checks, not timing results, and do not replace the frozen study's two failures or establish a new 49-program aggregate result.

## Commit and final validation

Committed as `ca5a63033beb7e73763b3441e07e9cac10b9cb02` (`codex/heldout-fixes`); working tree clean.

The first full-suite run returned 306 passed and 2 failures (`heldout-fixes/.tmp/heldout-full.txt`, 205.18 s). That run was invalidated: the worker shortened the new test module docstring after collection, shifting source line numbers used by inspect.getsource. Both failures said the generator fixture source could not be found; they were not recurrence of the original internal exceptions. No product source changed during that run.

A fresh full-suite run with all files fixed at the committed revision completed **308 passed, 38 subtests passed, 10 warnings, zero failures/skips**, in 74.18 s (`heldout-fixes/.tmp/heldout-full-final.txt`). Git status is clean and diff whitespace checks pass. Independent review cleared the focused commit with eight regression tests and additional probes.

No native-extension source changed or shared installation was modified. Validation is complete and the CPU/GPU slot is released. The delta is ready for coordinator import; the frozen integration75 copy remains untouched by this worker.
