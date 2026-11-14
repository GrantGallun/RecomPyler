# Whole-branch review

Reviewed baseline `3f0370d5fe5c358b4a0b3fd8e1ea10a2f22f87bf` through integration `1ff502d3d0c7b3e160dbed0e97f7af9e99484e14`, including the complete eight-file diff, the spec/plan, actual surrounding compiler/runner code, tool documentation/tests, full-suite log, implementation evidence and actual-AOT instruction report. This was a read-only source/evidence review; no builds, tests, workloads or timings were run while the study held the CPU slot.

## Strengths

- Compiler changes use explicit, default-off proof markers only at checked object fields and class tags. Final addresses are cast after signed offset arithmetic; speculative nullable-tuple payloads retain signed indexing. The surrounding call sites support the stated invariant.
- Behavioral regressions exercise both loaders and include rollback, missing receivers, growth/exhaustion, negative indices/strides, polymorphic field checks, and numeric flags. The saved full-suite log confirms 405 passing tests and 38 passing subtests.
- Evidence tools preserve raw output, explicitly label caller-supplied provenance, separate execution modes, reject unsupported engine paths, and document attribution/timeout limits. The assembly report maps actual audited AOT exports and appropriately avoids deriving speed from static instruction counts.

## Findings

### P2 — Count recursive result conversion only once

**Location:** `integration/tools/_phase_worker.py:53–57` (installed for `_Unloader.result` at line 62).

The timer adds every invocation's inclusive duration into the same `result_ns` field. The real `_Unloader.result` recursively calls `self.result` for NumPy scalars, present optional values, and every tuple component (`heap.py:6258`, `6265`, `6275`). A tuple-returning region therefore counts child conversions both inside the outer call and again as independent durations; nested tuples repeat this at every depth. This overstates result conversion and understates `other_attempt_ns`, which is computed by subtracting all phase totals at line 106 and can become negative. This occurs within one target attempt, so the README warning about adding nested target-attempt totals does not address it.

Make phase measurement reentrant per active attempt and phase, counting only the outermost result conversion (or otherwise ensuring exclusive component accounting). Add a deterministic recursive-conversion regression checking the total and remainder. Existing fixture tests return a scalar and do not exercise this real call graph.

No compiler correctness findings identified in the documented optimization scope.

**Resolved:** Scoped re-review of fix `dc4c9f9378896a667e8593fbcad9cef2d807233b`, integrated by `226c945`, clears this finding. The phase timer now maintains recursion depth separately per phase/active attempt and unwinds it in `finally`, recording the outermost duration once. The deterministic regression demonstrates the original defect (`result_ns=360`, `attempt_ns=210`, `other_attempt_ns=-190`) and the saved fixed suite reports **18 passed in 2.92 seconds**. No additional fix requested.

## Declined to judge

- Inherited nullable-tuple shared identity behavior: baseline reproduction is preserved and the requested optimization does not change tuple payload semantics.
- Full arbitrary-Python equivalence or wider frontend coverage: neither is claimed by this bounded backend change.
- Process-tree cleanup after command timeout: direct-child-only behavior and surviving descendants are explicitly documented; redesign was excluded from this addition.
- Non-x86 disassembly dialects: the documentation explicitly scopes the command switches to x86 binaries.

## Assessment

**Ready to merge: yes, after the reviewed P2 fix.** Final code head reviewed: `226c945d64ee83d80e66481c501b843c000b16f6`. No remaining actionable compiler/tool or measurement-report findings.

## Final evidence and report review

- Read `wave5-validation/tools-integrated.txt`: the integrated 18-test tool suite passed in 2.92 seconds.
- Read the integrated real-AOT smoke `report.json`, `diagnostic.json` data and `verification.json`: successful exit/status; 100 attempts/native entries and 100 successful AOT calls; zero JIT/fallback; Numba absent; three checks match the frozen Python reference; loaded candidate artifact SHA256 matches the independently audited/disassembled PE; no negative per-attempt remainder.
- Reviewed completed `wave5-study/RESULTS.md` and `SUMMARY.json`, protocol, raw `results/summary.json`, phase payloads and the SciMark mixed-mode audit. Cross-checked all 13 selected kernel baseline/candidate/C times, all nine default process-wall pairs, Barnes phase medians and actual 600-AOT-call modes. Verified the stated manifest hash. Raw summary marks every variant's checks and all separate audits valid.
- The report keeps uninstrumented kernel, complete-process and instrumented native-entry boundaries distinct. It retains the Richards regression, overlapping unchanged-nbody control distributions, four Python SciMark rows, the changed ordinary FFT JIT/AOT mix, shared-host noise and the known inherited tuple-identity limitation. It does not infer speed from instruction counts or claim universal Python equivalence. Existing study phase measurements did not instrument recursive result conversion and were unaffected by the resolved generic-tool finding.

### Condensed repository overview follow-up

Read `integration/docs/studies/2026-11-11-heap-index.md` after the coordinator supplied it. Its five heap-engine rows, baseline/candidate/C values, ratios, complete-process walls, phase values, test totals and tool-smoke claims agree with the reviewed underlying evidence. It correctly separates forced/warm kernel diagnostics from default deployment, retains the Richards regression and coroutines limitation, and preserves the mixed FFT, unchanged nbody, shared-host, finite-check, tuple-identity, instrumentation and C-port caveats. The static assembly claims remain bounded to the audited artifacts and identified sequences.

**Scoped overview verdict: clear; no accuracy findings.** This follow-up was documentation-only; no product edits or further test runs were required. Archive-manifest format was inspected, but independent verification of every copied archive file remains the coordinator's recorded check.
