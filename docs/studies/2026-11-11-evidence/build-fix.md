# Wave 2 AOT build repair

Status: ready for coordinator import. Focused commit **78ca7a357807d9e6096e2a526b38c6ff6974de56** on `codex/build-fix`, based on `cbf5bde`. The owned checkout is `D:/Code/Datathon/recompyler-codex-20261111/build-fix`; its tracked working tree is clean. Only `src/recompyler/_pycc/platform.py` and new `tests/test_pycc_platform.py` are in the commit. No primary/integration sources, installed packages, or global settings were changed.

## Root cause and reproduction

Reproduced first with:

```powershell
$env:PYTHONPATH="$PWD\src;$PWD\tests"
$env:RECOMPYLER_CACHE="$PWD\build\cache"
$env:PYTHONPYCACHEPREFIX="$PWD\build\pycache"
& C:\Python314\python.exe -m unittest test_aot test_heap.RegionTests.test_regions_built_ahead_of_time_run_without_numba -v
```

Both tests failed, without skipping, while distutils tried to create `C:\Code\Datathon\recompyler-codex-20261111`. Direct inspection of the installed `distutils._msvccompiler.MSVCCompiler` established the exact boundary:

```python
compiler.object_filenames(
    [r'D:\Code\source.c', r'C:\Python314\Lib\site-packages\numba\cext\utils.c'],
    output_dir=r'C:\Users\grant\AppData\Local\Temp\aot')
# ['C:\\Code\\source.obj', 'C:\\Python314\\Lib\\site-packages\\numba\\cext\\utils.obj']
```

Its `_make_out_path()` calls `_make_relative()` on the source basename. That removes the Windows drive but leaves the root separator. `os.path.join(output_dir, rooted_basename)` then discards the build directory. Cross-drive repository sources, installed runtime sources, and temp/build directories therefore escaped the intended output tree. The old compiler probe also explicitly requested the drive anchor as output directory, allowing objects outside its temporary directory. Its old cleanup attempted `os.remove(file_object)`, caught the resulting exception, and leaked the temporary folder.

## Repair

The vendored helper now scopes an `object_filenames` override to the individual compiler instance and compile call, restoring the original method in `finally`. Object naming receives only safe relative names derived from a SHA-256 of the normalized absolute source path, including its extension. The backend still chooses its own object extension. Equal stems from different folders, drives, and C/C++ source extensions produce distinct object names.

Crucially, `compiler.compile()` receives the original source paths and original include directories, dependencies, macros, and flags. No source staging, renaming, copying, or current-directory change occurs, so quoted sibling includes and relative-path interpretation retain their normal meaning. This fixes objects under an absolute or relative output directory without changing setuptools itself.

The compiler probe uses that same helper, requests its source's temporary directory as output, and uses `TemporaryDirectory` for cleanup of both sources and objects.

## Regression and validation evidence

The first two new tests were added and run before the production repair. They failed as intended: the compilation test detected an object under `D:\Users\grant\AppData\Local\Temp\...`, outside the D: checkout output directory, and the probe test rejected output at the drive anchor. The tests check containment before the backend creates directories, then perform real C and C++ compilation after the fix.

Final focused command:

```powershell
& C:\Python314\python.exe -m unittest test_pycc_platform test_aot test_heap.RegionTests.test_regions_built_ahead_of_time_run_without_numba -v
```

**5 tests passed, zero skips, 16.234 s**, with explicit local `PYTHONPATH`, `RECOMPYLER_CACHE`, and `PYTHONPYCACHEPREFIX` as above. These cover:

- Absolute C: temp sources compiled into a D: checkout output, plus a relative source path.
- Same-named files in separate folders and same-stem `.c`/`.cpp` sources producing four existing distinct object files.
- Quoted sibling includes, additional include directories, define and undefine macros, dependency arguments, unchanged source contents, and unchanged process cwd.
- C and C++ probe objects contained in their temporary source directories, then completely cleaned up.
- Restoration of original compiler object naming after successful compilation and a real backend unknown-file-type failure.
- The existing vendored AOT smoke with `numba.pycc` blocked during building and Numba/llvmlite blocked in the consuming process.
- The existing heap-region AOT smoke, which reports its expected values, no fallback, ahead-of-time execution, and no Numba loaded.

Full project command:

```powershell
$env:RECOMPYLER_CACHE="$PWD\build\full-cache"
& C:\Python314\python.exe -m unittest discover -s tests -v
```

**221 tests passed, zero skips, 155.852 s.** The additional restoration regression was added while this suite was already running, so this count excludes that one test; it is included in the final five-test focused run above. No failure is excluded. The full suite includes **`test_cli.CliTests.test_run_uses_an_ahead_of_time_module_without_numba`**, which passed through actual CLI `profile` and CLI `run`, comparing script output and exceptions with Python, checking 200 compiled calls and one fallback, and checking no Numba loaded. It also checks a changed constant rejects stale AOT code.

An additional correctness-only CLI smoke constructed a hand-selected plan with the actual AOT build API, then launched `python -m recompyler run --force --plan ... --json ...`. A `sitecustomize` import hook actively blocked both Numba and llvmlite. Its output was `[4.5, 7.5, -1.5] False False`; the JSON reported `compiled_calls=1`, `fallback_calls=0`, `ahead_of_time=true`, and no missing functions. This smoke deliberately does not make a timing recommendation.

`git diff --check` passed. Imported source and both copied native extensions were verified to come from this worker checkout. No native source changed, so no extension rebuild was necessary.

Local evidence artifacts, excluded from the focused source commit:

- `build-fix/build/full-suite.log`
- `build-fix/build/focused.log`
- `build-fix/build/cli-aot.log`
- `build-fix/build/verify_cli_aot.py` and `build-fix/build/cli-aot/run.json`

## Environment and limits

Python `C:/Python314/python.exe`, 3.14.4, Windows AMD64; setuptools 70.2.0; Numba 0.68.1; NumPy 2.4.4. NumPy/Numba were imported from the existing C: user site installation; project source and native extensions were imported from the D: checkout. Tests used task-local caches; system temp directories stayed on C:. There were no dedicated timing benchmarks.

The full suite emitted existing Numba CUDA occupancy warnings, Numba internal SSA warnings in object tests, and ResourceWarnings in the batch test's generated script. The explicit CLI build emitted upstream Numba `listobject.c` MSVC C4244 conversion warnings. None caused a failure; no installed dependency was modified to silence them.

Validated here with MSVC, not a separate Unix compiler. The helper uses backend-supported object naming and preserves its extension rules, but non-Windows execution remains coordinator/CI coverage. A single Toolchain/compiler instance is not intended for simultaneous compile calls; the override is instance-local and exception-safe, not a new shared-compiler concurrency facility. SHA-256 path naming makes collisions practically negligible and avoids long source-directory subtrees, while changing internal object basenames only.
