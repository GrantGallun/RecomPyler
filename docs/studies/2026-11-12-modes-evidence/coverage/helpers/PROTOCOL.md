# Wave10 coverage-only comparison

This NEW helper directory adapts wave8 study.py and contains exact copies of audit.py/warm_bytecode.py/native_preflight.py. The study changes are only per-workload shim routing/inventory and an actual deployment audit before timing. prepare_impl.py and the state helpers are new. No old helper/result is edited. `prepare` reads metadata and binds full source/runtime/workload/helper hashes; `run` executes children and requires the root CPU grant.

Two cases are frozen: (1) the unchanged chaos workload and loops=2 shim from paired-final, labeled heldout subset denominator1; (2) the SAME unchanged script/arguments with a NEW shim differing only in LOOPS=32, labeled chaos_extended32 in the separate diagnostic group. The second case amortizes real startup under normal default policy and never enters the historical38 denominator. Historical0/38 is context, never a new full38 measurement. Baseline is strict `1d4084f914fa9594ecb801e3efa565edcd7e1241`; candidate is the final clean combined reviewed commit explicitly passed to prepare. Native support binaries must exist and match integration's retained originals; native_preflight enforces actual imports from each source tree.

Primary commands (replace paths only):

```
C:/Python314/python.exe study.py prepare --output NEW_OUTPUT --current BASELINE_CLONE --candidate COVERAGE_CLONE --candidate-commit FINAL_CLEAN_HEAD
C:/Python314/python.exe study.py run --output NEW_OUTPUT
C:/Python314/python.exe study.py summary --output NEW_OUTPUT
```

No force policy, script changes or tiny-helper counters. Only the separately labeled32-loop diagnostic multiplies repetitions. Each case gets fresh profiles and separate source-specific caches. The ordinary profile creates plans; default runner selection must itself select profitable work. A fresh instrumented deployment preflight then checks the actual full-entry AOT program and export reuse before any latency sample. If a plan selects work but the full entry has zero AOT completion, JIT, rejection or fallback, timing aborts for investigation. A no-selection short plan remains a valid0native result.

Timings are fresh CPython/current/candidate children, five rotating triplets per case, whole-process wall. Five further separate audit children per source/case reconcile runner totals against actual Region.attempt program mode/digest and unknown native/fallback/rejection counts. Audit imports/instrumentation never appear in headline timing children. Retain stdout/exit equality, all raw streams, per-process times, bytecode/artifact inventories and startup/cost recommendations even when deployment remains empty. Main counts:4profiles,30timingchildren,20postaudits,4deploymentpreaudits,4compile-onlywarmups,2nativepreflights. Explicit state diagnostic builds/AOT children are additional and never timed.

State diagnostics (separate from primary timings/population) use state_audit.py build then fresh aot mode for each source and each kind. Original kind uses the exact original entry and proves None return, full argument graph numerical/type/alias equivalence, original input identity preservation and exact final global random state. Pixels kind saves the original function body plus one final `return im`; it proves every pixel/row/type/shape against Python with a changed digest, explicitly labeled a derived canary. Original local pixels cannot be observed by its original None-return API.

```
C:/Python314/python.exe state_audit.py --mode build --kind original --script FROZEN_CHAOS --artifact NEW_ARTIFACT --output NEW_JSON
C:/Python314/python.exe state_audit.py --mode aot --kind original --script FROZEN_CHAOS --artifact SAME_ARTIFACT --output NEW_JSON
```

Use a separate artifact folder for pixels and substitute `--kind pixels`. PYTHONPATH must select exactly the intended source/src (and this helper directory for state helpers). RECOMPYLER_CACHE and NUMBA_CACHE_DIR must be isolated under the new output by source/kind. The baseline may decline structural compilation; record it as declined, do not build an artifact by changing source or forcing acceptance. In aot mode, count raw export entries independently, require completed AOT calls with zero JIT/fallback/reject and no Numba import. The artifact manifest binds module hashes, export/digest names, seed metadata, input source, generated pixel source and compiler source hashes.

No performance conclusion follows from source generation, verification counters or kernel diagnostics alone. If fresh default policy still selects nothing, report that failure honestly; an explicit-entry state canary is not new held-out default coverage.
