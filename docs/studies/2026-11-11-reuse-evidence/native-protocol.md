# Fresh-process reuse: native comparison diagnostic

Run only after the reviewed candidate is integrated and the paired study releases its exclusive measurement slot. Freeze `integration` source HEAD and every source/binary/driver hash in the recorded manifests. Previous `native-study` is immutable.

Nine unchanged original C comparison binaries and Python drivers were copied after verifying all hashes against the prior compiler/build manifest. The C ports retain `clang -O3 -march=native -ffp-contract=off` and UCRT linkage; this wave reruns their timings and checks, without claiming a new C compiler build or optimal assembly.

`RECOMPYLER_PAIRED_MANIFEST` must name the new frozen paired-study manifest containing `execution_environment`. `RECOMPYLER_NATIVE_SOURCE` selects the frozen source checkout (defaults to integration). Run `C:/Python314/python.exe compare_native.py run` with task-owned startup/cache/temp locations. The archived prior process executor preserves timeouts/output. This diagnostic generates fresh profiles, plans and default/forced executions; historical plans and results are never reused. Source code cannot change after measured-source.json is written. The sibling `wave3-native-baseline` contains identical assets and harness for a fresh previous-branch comparison, selecting the study's frozen baseline checkout.

Report all nine workloads and 13 check rows, including Python fallback. Kernel best times use five fresh-state repetitions for Python/RecomPyler and 20 for C, excluding setup, startup, profiling and compilation. Full process walls and profile costs remain separate. `--force` bypasses the overall recommendation only; an additional explicitly labelled warm diagnostic may select verified faster-than-Python candidates to expose kernel capacity, as in the prior study. This must never replace the unforced held-out headline.

Checks compare integer strings exactly and encoded floating-point values bitwise, including signed zero. Any check mismatch, build/profile error or timeout remains a failed row. Native/AOT/JIT/fallback counts must accompany results so a Python path cannot be described as native overhead.

The main paired study controls its own warm-bytecode protocol. These kernel timers exclude initial imports and use repeated calls; the separate native process-wall numbers use an isolated bytecode prefix and must be described under their recorded cache condition, not pooled with paired-study timings.
