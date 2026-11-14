# Development evidence tools

`dev_inspect.py` is a small Python 3.10+ standard-library CLI. It inspects files without importing RecomPyler except in the explicitly executing `phases` command. Run it from any directory; supply the checkout, interpreter, target, plan and evidence paths explicitly. No machine-specific directories are embedded in the tools.

Every command writes to a **new** `--output` directory and refuses to overwrite an existing one. Preserve these directories when comparing revisions. Paths and SHA-256 hashes identify inputs; a filename or an `aot` label alone does not prove which code ran. Exit status is 0 for success, 2 for an error; `diff` additionally returns 1 for differences. Child stdout/stderr are retained as bytes, including failures.

## Compare source, assembly, JSON reports, or arbitrary files

```sh
python tools/dev_inspect.py diff /work/before.py /work/after.py --output /evidence/source-diff
python tools/dev_inspect.py diff /work/old.asm /work/new.asm --normalize asm-addresses --output /evidence/asm-diff
```

The default compares **all bytes**: no address, whitespace, newline, timestamp or JSON-key normalization. `left.raw` and `right.raw` preserve the exact input. `diff.txt` is a unified diff of JSON-quoted Latin-1 byte lines, making CR/LF, non-UTF8 bytes and a missing final newline visible. It is an inspection view, not a patch file. `report.json` distinguishes `raw_equal` from `compared_equal`.

Normalization is opt-in and ordered: `--normalize newlines` maps CRLF/CR to LF; `--normalize asm-addresses` removes only hexadecimal address prefixes ending in `:` at the start of a line. It does **not** remove branch targets, RIP-relative comments, raw instruction bytes or symbol names. Raw copies remain unchanged. JSON reports are deliberately not re-sorted by default.

## Inspect an existing native artifact

```sh
python tools/dev_inspect.py asm --binary /artifacts/kernel.pyd --tool /tools/llvm-objdump --kind actual-aot --output /evidence/aot-asm
python tools/dev_inspect.py asm --binary /artifacts/kernel.o --tool /usr/bin/objdump --format gnu --kind cached-jit --output /evidence/jit-asm
python tools/dev_inspect.py asm --binary /artifacts/benchmark.exe --tool /tools/llvm-objdump --kind c --start 0x140002710 --stop 0x1400028e8 --output /evidence/c-force
```

This executes the **disassembler**, never the inspected binary. It retains raw disassembly, import/header/symbol output, tool version output, full argument vectors, binary hash and disassembler executable hash. Both supported command dialects request x86 Intel syntax; these examples target the compiler's x86 binaries. `--tool-arg` can add arguments before the disassembler switches (for a wrapper, for example).

`--kind actual-aot|cached-jit|c|unknown` is explicitly **caller supplied**, not inferred or verified. Establish actual AOT selection using runtime counters and the plan's digest/export mapping before assigning that label. A cached Numba object/LLVM dump is not evidence for an AOT entry. Empty or ambiguous symbols are left as raw evidence: the tool does not invent names or guess which function is hot. Optional address ranges require independently established mapping and both endpoints. No recompilation or package installation occurs.

## Capture C comparison provenance

```sh
python tools/dev_inspect.py c --source /ports/nbody.c --include /ports/common.h --binary /artifacts/nbody.exe --compiler /tools/clang --flag=-O3 --flag=-march=native --flag=-ffp-contract=off --output /evidence/c-inputs
```

The command snapshots the source bytes and hashes the listed source, headers and optional binary. Compiler path/hash/version and flags retain their supplied order. Flags are **user supplied**, not recovered from the executable, and no build is performed. Include dependent headers explicitly. Keep the original build log/command alongside this evidence to establish that these inputs produced that binary. The tool does not claim algorithm, workload, arithmetic-order or layout equivalence between a C port and Python.

## Attribute a region run

```sh
python tools/dev_inspect.py phases --repo /work/recompyler --python /venv/bin/python --script /work/driver.py --plan /plans/driver.json --function advance_system --arg=2 --artifact /artifacts/kernel.pyd --output /evidence/phases
```

This command **executes the target script**, with its normal effects, in the supplied interpreter. It uses the requested checkout's `src`, not the installed package. `--cwd` defaults to that checkout. Add script arguments with repeated `--arg` (use `--arg=-option` for leading dashes). `--line` disambiguates same-name functions; qualified names are also checked against the runtime function. The selected function must be a recommended `heap.Region` target in the plan. Ordinary lift/batch paths, unselected or ambiguous targets, and runs with no observed target attempts produce explicit errors; an unsupported path is never presented as zero overhead.

`--force` preserves the runner's existing force behavior, including permission to JIT on a deployment miss; omit it to retain the plan's normal AOT-only budget safeguards. This tool does not build an AOT plan. Normal compilation, if the runner allows it, uses a fresh output-local RecomPyler cache and Numba cache. `--cache` overrides the RecomPyler cache only. Existing AOT modules are loaded from the plan's paths. Existing target environment variables and dependencies remain available.

The output is an **instrumented diagnostic**, not a benchmark or an uninstrumented speed result. Each target attempt records:

- Total attempt time, loader time, guards, native entry, result conversion and write-back in nanoseconds; the remainder includes preparation, inference/compilation and other unmeasured work.
- Native entry count and actual AOT/JIT mode for every entry, including failed entries and retries.
- Successful AOT/JIT counter deltas and attempt success, separately from native entries. The runner's full report supplies actual compiled/fallback counts; Python fallback execution happens outside the attempt timer.

Recursive calls within the same phase and active attempt are timed only at the outermost call, so recursive tuple/optional result conversion is not counted repeatedly.

`stdout.bin`/`stderr.bin` retain the real target output; `checks` extracts lines beginning `check ` without judging their correctness. Script, plan, compiler source and optional artifact hashes are captured. Planned AOT artifact candidates and actually loaded native modules are recorded separately, so an available artifact does not imply execution. All method patches are restored on success or exception, and instrumentation runs in a child process. This adapter uses private compiler APIs and reports incompatible or unsupported APIs explicitly.

Do not add component totals across nested target attempts as if they were disjoint; outer attempt time includes inner calls. Native time includes the Python-to-native entry wrapper overhead. Timers, extra Python frames, and output/module hashing can perturb the run, including recursion depth; use ordinary uninstrumented runs for performance comparisons.

## Run named regression cases

```sh
python tools/dev_inspect.py cases --list
python tools/dev_inspect.py cases cross-process --repo /work/recompyler --python /venv/bin/python --dry-run --output /evidence/case-command
python tools/dev_inspect.py cases negative-indices --repo /work/recompyler --python /venv/bin/python --output /evidence/negative-indices
python tools/dev_inspect.py cases native-present --repo /work/recompyler --python /venv/bin/python --output /evidence/native-code
```

Named cases select existing pytest regressions: `negative-indices`, `native-present`, `nullable-fields`, `rollback`, `cross-process`, and `native-reuse`. They run against the explicit repo's source and tests, retain the command/test hashes/output, and propagate failure. Missing test files report the case unavailable (older checkouts may lack heap-index tests). `native-present` checks generated native LLVM evidence; `native-reuse` builds real AOT fixtures and checks fresh-process use and guards. These can compile and take time; use `--dry-run` while another measurement is running. Tests require that interpreter's project test/compile dependencies; the tool never installs them.

All child commands support `--timeout` (seconds, default 300). The timeout kills the direct child only. **Descendants spawned by scripts, tests or compilers may survive**; avoid using a short timeout as a process-tree cleanup mechanism, and inspect/stop owned descendants before beginning timing work. This limitation is also recorded in command reports.

## Tool verification

```sh
python -m pytest tests/test_dev_inspect.py -q
```

These lightweight tests exercise actual CLI subprocesses, byte-roundtrip evidence, disassembler failures, named-case command execution, unsupported/missing phase coverage, AOT/JIT counters, failed native attempts and patch restoration using an isolated fixture engine. They do not build native artifacts or claim real-compiler performance. A saved-plan phase smoke test against a real AOT artifact should be run separately when a measurement slot is available.
