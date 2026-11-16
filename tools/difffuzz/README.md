# Differential fuzzer

Run from the checkout root (Python, NumPy and Numba must already be installed):

```powershell
$env:PYTHONPATH='tools'
python -m difffuzz --minutes 10 --workers 4 --match method.str --run wave17-matrix --publish
```

Use this ten-minute mode on the changed capability **before the one independent implementation review and before committing**. Correctness work runs at below-normal priority, uses one to four worker processes, and never takes TIMING.lock. `--minutes` is a total wall-clock budget; `--case-timeout` kills only this driver's child for a stuck subject. Timeouts, unsupported oracle objects, resource filters, and worker errors are reported separately; none count as passing checks. This is trusted-project-code execution, not a sandbox.

The default inventory contains all matrix catalogue rows, module-level subject functions statically extracted from `tests/test_*.py`, and functions in the shared provenance corpus (or its local fallback). Extraction retains inert literal setup, ordinary definitions, and selected standard-library imports. It does not execute test-module setup, test methods or test bodies. Missing dependencies and unsupported objects can make these extracted functions unavailable; the report does not claim all discovered functions executed. `--file path.py` adds a fixture, `--match substring` selects subjects, and `--sources matrix,tests,corpus` selects inventories. The checkout currently has 1,016 matrix rows; the later 1,026-row branch is discovered automatically when merged.

Each subject gets a fixed, logged seed. Cold and warm public compiled calls are compared with CPython on independent inert graph copies. The oracle checks exact types, IEEE float/complex bits including signed zero and NaN payload, exception type/message/args/chains, stdout/stderr, fixture globals/events, every argument and its reachable supported containers, and graph sharing. Identity is exact against argument parts, globals, closures and original code constants, and between repeated nonnumeric result references. Exact builtin int/float/complex identity is exempt under S49; bool/None and numeric subclasses are not. Clean Python fallback is acceptable but still compared. Construction declines are separate from checked calls. `native` requires an actual native counter increment.

Boundary probes include 64-bit edges and larger integers, bools, infinities, payload NaN, -0.0, numeric subclasses, empty/singleton containers, 1/2/4-byte Unicode, empty bytes, repeated parameters and nested aliases. Inputs which could cause huge loops/powers/allocations are explicitly resource-filtered; a timeout is not a decline. The first implementation does not support every opaque extension object, recursive tuple graph, mutable closure factory, coroutine or arbitrary callback/finalizer observer. These are `unchecked`, not evidence of equivalence. A fixture that needs richer setup should be supplied as a small dedicated matrix/corpus wrapper.

Layer (a), argument fuzzing, is the default. Add `--mutations 4` for layer (b): operator changes, boundary constants, a branch/one-iteration loop wrapper, or adjacent assignment swaps in those existing subjects. Every edited program is compared to its own CPython behavior. Mutation is syntactic; it does not claim an inferred static type proof.

Wrong outcomes trigger bounded greedy argument reduction and statement deletion, always requiring reproduction. A minimized portable recipe is checked again. This is a local minimum within the reduction/time budget, not a proof of global minimality. If an input cannot be represented portably, the original descriptor, seed and trial remain logged explicitly. `--publish` immediately writes each finding under `provenance-cases/<run>-difffuzz-*.py` and appends its seed and module to REQUESTS.md; use your own run prefix. Corpus files contain literal replay metadata so importing the shared corpus does not execute a subject. Replay one with:

```powershell
python -m difffuzz --replay ../provenance-cases/wave17-matrix-difffuzz-1731-1.py --minutes 1 --output matrix/difffuzz-replay
```

`results.jsonl` retains each executed outcome; `report.json` summarizes checked calls, separate exclusions/errors, inventory and completed subjects, layer (a)/(b) findings and compiler engines. Exit 1 means a mismatch or compiler/worker error. A clean exit is only a report of the sampled checks; inspect timeout/unchecked counts as well.

To test accepted trunk without importing a dirty working tree, use `--product-repo ../wave16-inplace --product-commit HEAD`. It exports that commit's source locally and records the exact commit in the report; this is source selection, not an evidence seal. Use `--product-source path/to/src` for another existing checkout. The tool itself changes no compiler product source.

Managed AST subjects use `--engine managed`. A fixture may declare `FUZZ_ARGUMENTS = {'function_name': "(ast.parse('a,[b,c]=value').body[0].targets[0],)"}` to supply trusted constructors; `import ast` is retained. Exact standard AST graphs are cloned with their native allocator and replayed with field/alias preservation. The generated domain includes nested target patterns, unsupported targets and missing fields. For example: `python -m difffuzz --minutes 10 --workers 2 --sources=explicit --file ../provenance-cases/wave17-matrix-managed-ast.py --engine managed --trials 96 --mutations 4`.
