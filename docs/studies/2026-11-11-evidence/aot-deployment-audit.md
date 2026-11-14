# AOT deployment audit: Richards_super

Audited source: integration `dc02b95`. This is a diagnosis only; no product source was changed.

## Findings

### P1 — Saved region export is not selected in a fresh process

The long-study plan exports digest `d00b43547e58028876354c5be96320e5a4c46c14497812116665928cbd525d94` as `r0` from `rcaotr_5839b154c31de6a7e1988b0c`. Fresh runtime generation does not reproduce that source digest, so `_Program.compile` correctly declines that export and takes the Numba path. The guard is doing necessary work: the source variants actually use different class tags and field offsets, not just different identifiers.

The primary cause is **encounter-order-dependent layout derived from mutable global state**:

1. `profiler.test_region` discovers/builds a new program after the profiled script has run. Its global `taskWorkArea.taskList` then contains the constructed task graph.
2. A fresh `runner.run_script` reaches `Richards.run` while that global task list is still `None` and the task table contains only `None`.
3. `heap._Program.global_value` seeds types from that current global graph. `_seed` recursively registers the encountered classes. `register` appends classes to `members` and adds their fields in encounter order. `tag` uses the member index; `layout` uses field insertion order.
4. With empty globals, inference first discovers classes from constructor calls in the function body. With populated globals, graph traversal first finds `DeviceTask`, followed by its linked predecessors. The resulting code and ABI differ.

Observed source-generation metadata:

| Family | Fresh global graph | Populated global graph |
| --- | --- | --- |
| TaskState member/tag order | IdleTask, TaskState, WorkTask, HandlerTask, DeviceTask | DeviceTask, HandlerTask, WorkTask, IdleTask, TaskState |
| TaskRec member/tag order | IdleTaskRec, WorkerTaskRec, HandlerTaskRec, DeviceTaskRec | DeviceTaskRec, HandlerTaskRec, WorkerTaskRec, IdleTaskRec |
| TaskRec field order | control, count, destination, device_in, work_in, pending | pending, device_in, work_in, count, destination, control |

For example, the saved profile source writes the IdleTask tag as `3`; the fresh runtime source writes `0`. `IdleTaskRec.control` uses slot `6` in the populated layout and slot `1` in the fresh layout. Function specialization/numbering also differs. Both programs can be internally valid while being incompatible with each other's loader ABI.

**Exact evidence:** Restoring the known inline/cache decorators in the retained generated source `rc_heap_c83e3b40873b95948608f549.py` reproduces the plan's full `d00b...` digest exactly. The same reconstruction for retained runtime files matches independent fresh source generation:

| Retained generated cache file | Reconstructed source digest |
| --- | --- |
| rc_heap_c83e3b40873b95948608f549.py (profile export) | d00b43547e58028876354c5be96320e5a4c46c14497812116665928cbd525d94 |
| rc_heap_f22bf1ba79e99c6362ccbd36.py (fresh variant A) | 3dc8ab6604b3068784d4b9607bf7d69ef6c8aac846c7a1a17fed0d17fcd6bdf1 |
| rc_heap_93705b758160fa256b4b3cc2.py (fresh variant B) | 497408a5f95fc27ee440f6b9ee3397c54ef319de97bed59f747ee98d94ccda8f |

The reproduction populated the six-task graph by temporarily replacing `schedule` with a no-op, running only construction once, then restoring the original function before generating source. It did not execute the scheduling benchmark. This controlled graph change alone reproduces the tag/field-order change. Its populated digest differs slightly from the retained post-workload profile source because it is a pre-scheduling graph; the exact exported digest is independently identified from the retained profile cache above.

### P2 — Unordered class checks independently make digests process-dependent

`ObjT.classes` is a `frozenset`. `heap._Gen.attr_check` (around line 3776) iterates it directly to emit an OR chain of acceptable tags. Two independent fresh source-generation processes with identical empty globals produced the two fresh digests above. Their generated source differed in exactly eight lines, solely by:

```python
I[t4] == 1 or I[t4] == 0
# versus
I[t4] == 0 or I[t4] == 1
```

Each process reproduced its own source exactly on a second generation pass. Thus mutable graph shape is not the only issue: unordered emission also splits source digests and disk caches across fresh processes. Sorting these checks by assigned tag would resolve this demonstrated secondary source of instability, but would **not** resolve the populated-versus-empty ABI mismatch.

### P2 — Run report claims AOT availability as AOT execution

In `runner.prepare`, regional preparation sets:

```python
state['lifted'] = lift_region(fn, built_ahead)
state['ahead_of_time'] = bool(built_ahead)
```

The final report returns that state unchanged. No check observes whether a runtime program actually selected an export. Consequently `wave2-study/aot-mode-audit.json` records three runs reporting `ahead_of_time: true` and 20 compiled calls while instrumentation records `program.ahead_of_time: false` and Numba imported in every run.

`compiled_calls` still correctly counts region execution; it does not distinguish AOT from JIT/cache-loaded native execution. Export presence should be reported separately from successful AOT calls. A single function may also execute multiple signatures with mixed AOT/JIT/fallback modes, so reading only the latest program or setting a boolean at preparation is insufficient for reliable per-call accounting.

## Focused safe plan

1. **Correct reporting independently.** Count successful calls by the actual program selected at execution: AOT, JIT/cache, and Python fallback. Keep export availability as separate metadata if useful. Preserve total compiled-call compatibility. Test an available-but-unmatched export and mixed-signature execution, and ensure failed attempts/fallbacks are not counted as successful native calls. This need not alter compilation or dispatch.
2. **Make source emission deterministic.** Start with the proven unordered `attr_check` clauses, then audit other unordered source-affecting collections. Test fresh processes with identical argument/global graphs and require identical source/digests. This is a bounded improvement but not a complete Richards AOT solution.
3. **Handle the profiled-layout versus fresh-layout boundary deliberately.** Two viable designs need separate validation: persist/rebind the guarded typed program and its loader ABI from the AOT build, or canonicalize the fully inferred class families, tags, layouts and function emission before regenerating both code and loader plans. Do not simply ignore a digest mismatch, substitute an export by function name, or normalize tags/offsets out of the hash: those would execute machine code against the wrong heap ABI.
4. Add an end-to-end fresh-process regression with initially empty globals that become a polymorphic graph during profiling. Build AOT, start a clean process, require actual AOT execution with no Numba import and verify values, mutations, aliases and guards. Only after this passes should the Richards deployment and whole-process profitability be remeasured.

Profile-time warm-start simulations reuse already inferred programs while globals are in the same process/state, so they do not establish fresh-process AOT selection. A safe profitability check must measure the actual deployment mode, including any digest-miss/JIT startup costs.

## Evidence, scope and limits

- Existing evidence: `wave2-study/aot-mode-audit.json`; long-study plan and generated Python cache under `wave2-study/results-long/.../richards_super`.
- Independent scripts: `review-scratch/aot_source_probe.py`, `review-scratch/aot_cache_probe.py`.
- Generated source, metadata and diffs: `review-scratch/aot-audit/` and `review-scratch/aot-audit-repeat/`. `cached-source-digests.json` links retained cache files to full source digests; `source-generation.json` records layouts and repeated generation results.
- Source generation uses a diagnostic AOT-map stand-in that captures the ordinary generated program before compiler import. It never calls the stand-in or executes generated kernels. Both processes assert that Numba was not imported. No shared source/cache was modified; new artifacts are scratch-only.
- No timing runs, full suites or AOT rebuilds were performed. The observed whole-process penalty is consistent with unexpected entry into the JIT path, but this audit does not apportion the reported 1.2–7.4 seconds among imports, inference, compilation, disk-cache loading and execution. Numba being imported does not prove every run recompiles machine code.
- This finding is specific to the demonstrated Richards_super region. It does not invalidate separately instrumented actual-AOT evidence for other study programs, or infer broader language compatibility.
