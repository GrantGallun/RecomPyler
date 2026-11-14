# Combined coverage integration

Owned copy: `D:/Code/Datathon/recompyler-codex-20261111/integration`; branch `codex/integrated-coverage`. Original repositories were read only.

## Ancestry and source preservation

The integration starts from original `prior/dataflow` (`f8ab815`). Boundary commits and the first-wave array rollback were replayed as `f65422a` (from `f2dcefe`), `0dc638a` (from `48fdfca`), and `8ff1daa` (from `cbf5bde`).

Standalone snapshots have synthetic child commits whose trees exactly match the fetched snapshot heads but whose parents preserve original shared ancestry:

| Track | Snapshot head | Synthetic import | Parent |
| --- | --- | --- | --- |
| Containers | `05e6d467c8ed22a42998347fee852e57e0253c71` | `238b19f81e062553e61228a20e9070c9fc73a7d6` | `prior/containers` (`a834e17`) |
| Generators | `14127e37be10861297579caf47b2b7560dee68b1` | `0d1c945846f48944db8a107502d0397f558b57e1` | `prior/base` (`56211d5`) |
| Runtime | `94e898f0902eeba7d6105bb795ffa79e7faad211` | `c02f6a9639e26227a2cc4b4a9c6d53dc50acd4cb` | `prior/base` (`56211d5`) |

These import all inherited uncommitted feature work as well as the first-wave fixes. Source snapshot manifests remain in the shared parent directory.

## Merge stages and fixes

- `8a12c21`: container merge. Combined string/dict/set types with NumPy/RNG types, native-loader exclusions, runtime helpers, globals restoration and keyword call interfaces. Preserved dataflow and array rollback. Resolved an old list-only membership helper shadowing the newer general container membership method, and restored a neighboring superclass helper omitted during conflict resolution. Container/boundary/array/flow check: **74 passed, 36 subtests passed** (`.tmp/container-tests.txt`).
- `3015f5c`: generator merge. Preserved lifecycle capture, async/generator flags, flow checks, object truth hooks, array handling and entry keyword binding. Rebuilt both C extensions locally (`.tmp/wave2-build.txt`). Combined track check: **110 passed, 36 subtests passed** (`.tmp/generator-tests.txt`).
- Added `tests/test_integrated_features.py`: module keyword calls; generator entry keywords; copied/inlined unbound-read checks including repeated invocations; variadic generator binding; recursive collecting calls. Before fixes, cross-track probes demonstrated incorrect successful execution of an unbound generator local and incorrect `[2]` instead of `[(2,)]` from `*args`. Preserving unbound-read metadata across AST copies, resetting per-invocation flags and binding the original signature corrected these. Hidden collecting-list arguments bypass the public signature binder. Five focused interaction tests pass. Inlining generators with closures remains conservatively refused; entry generator compilation retains ordinary closure handling.

## Validation configuration

Python: `C:/Python314/python.exe`; explicit `PYTHONPATH=<integration>/src`, `RECOMPYLER_CACHE=<integration>/.tmp/wave2-cache`, `TEMP` and `TMP=<integration>/.tmp`. Native extensions rebuilt with `setup.py build_ext --inplace` after importing generator monitor changes. No performance benchmarks were run.

Pre-build full suite: **279 passed, 2 failed, 1 skipped, 38 subtests passed**, 22 warnings, 195.54 s (`.tmp/wave2-full-tests.txt`). The only failures were the two known AOT tests.

- `8931582`: full runtime merge (including rejected-plan plain-run behavior).
- `45af6fa`: focused inherited-runtime correctness fix. Three probes demonstrated nested pickle hooks running during preflight; `_plain_pickle_graph` now rejects hook-bearing objects before `Pickler.dump`. It conservatively uses snapshot for custom-access/new/slot types and nonplain hash keys. Plain cyclic object graphs retain optimized copying and aliases. Tests cover nested `__reduce__`, `__reduce_ex__`, `__getstate__`, `__setstate__`, and the successful cyclic plain-copy path. Ten combined interaction tests passed.
- `a0a6a14`: independently reviewed build fix imported from build worker `78ca7a357807d9e6096e2a526b38c6ff6974de56`. Build-fixed full suite: **289 passed, 1 failed, 38 subtests passed**, 10 warnings, 83.61 s (`.tmp/wave2-full-build-fixed.txt`). Both AOT failures are resolved. Remaining failure was the existing timing-ratio assertion in `MonitorTest.test_library_time_is_kept_apart`: 0.001497 s measured library time versus 0.001546 s threshold. A focused complete monitor rerun passed **36 tests** (`.tmp/wave2-monitor-rerun.txt`). No source was changed for this timing failure. A repeat full run was interrupted when independent review produced three new correctness findings; its incomplete transcript is `.tmp/wave2-full-final.txt`. Both complete earlier transcripts are retained.

Verified synthetic import tree equality: containers `d3c77909a73b49b490cf74c498bfe488538b0734`; generators `6a1c265fb2e2c3de9286187e4086175a49f131a0`; runtime `ad23240d076e924187e8764fc8b22e46a327b239`.

## Concerns for review

The inherited pickle preflight concern was reproduced and corrected at coordinator request (see above). Recursive generator consumption beyond direct collecting/delegation remains unsupported and falls back; the interaction test checks the Python result rather than claiming native support for that shape.


## Independent-review corrections

`75aefc1` fixes the three independently reproduced findings. Seven new regression cases first failed (`.tmp/review-regressions-before.txt`), and all seven passed after correction. The broader affected-file run passed **68 tests and 2 subtests** in 36.92 s (`.tmp/review-affected-tests.txt`).

1. Removed the eager quiet-loop runner rewrite. Even `for x in values(): pass` performs target assignments between yields; a generator reading global `x` must see those assignments. Direct generator execution in the runner stays lazy, so this path currently has no native acceleration. Compiling generators inside supported whole regions remains available.
2. Programs creating NumPy views now decline noncontiguous input arrays during loading, before native stores. Returned-view conversion errors are represented as a mismatch; zero-copy array writes are restored before fallback and before any heap write-back. Regressions cover read-only and mutating row returns under both loaders, shared storage/strides, and injected conversion failures with both array and heap effects. This is conservative: even an internal row view in a noncontiguous array currently triggers fallback.
3. Global-state capture now saves each original reachable graph node's shallow contents and edges. Restore reinstates the original nodes and links, preserving nested aliases and cycles instead of replacing them with deep copies. Lists, dicts, plain-object dictionaries, numeric arrays and Random state are supported; unsupported graphs conservatively skip verification. Regressions cover read-only and mutating nested globals, plus a cyclic list/object graph.

Final complete suite at `75aefc1`: **300 passed, 38 subtests passed, 10 warnings**, zero failures/skips, 126.77 s (`.tmp/wave2-reviewed-full.txt`). Both AOT tests pass. Working tree is clean and `git diff --check` passes.

Independent scoped re-review confirms all three original repros corrected, including real unstubbed profiler verification. Reviewer independently ran ten focused regressions and extra C/F-contiguous returned-view probes under both loaders, plus overlapping saved-global roots. No remaining actionable finding in those fix paths; see `WAVE2-integration-REVIEW.md`.

Ownership handed back to coordinator at `75aefc1`. No test or benchmark process remains running from this worker. Do not interpret standalone generator region timing as deployed runner coverage or speedup: direct runner generators now remain Python for correct interleaving.
