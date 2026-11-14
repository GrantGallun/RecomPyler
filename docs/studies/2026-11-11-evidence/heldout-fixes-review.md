# Held-out crash fixes: independent review

Reviewed `ca5a63033beb7e73763b3441e07e9cac10b9cb02` in the read-only `heldout-fixes` copy, against `75aefc1`, using `WAVE2-heldout-fix-review.txt` and `WAVE2-heldout-fixes.md`.

**Verdict: no actionable findings in these bounded fixes. Suitable for integration import, conditional on the pending complete-suite result.**

## Review conclusions

- The new `ClassDef` branch avoids reading function-only `.args`. It collects the class binding and walks decorators, bases and keyword values while excluding class-body and type-parameter bindings. This matches the existing flow walker for the supported surrounding-scope analysis. Local class execution remains unsupported and now declines cleanly; the patch does not claim native class-definition support.
- Profiler discovery now includes the generator's hidden collecting list, matching `Region.attempt` and the generator entry signature. Ordinary captured positional parameters remain in their original order. The monitoring sampler already rejects variadic and keyword-only functions, so this change does not introduce a conflicting sampled binding convention.
- The recursive delegation catch is limited to internal `_Pending` during code generation. It sets `program.changed`, forcing another complete generation pass; generated source is not compiled/executed until inference settles. The existing 60-pass bound still raises `Unsupported` for unresolved inference. Unsupported delegation restrictions are unchanged and their exceptions are not swallowed. No runtime side effects are replayed by this inference retry.

## Independent validation

- Ran only `tests/test_heldout_regressions.py`: **8 passed**.
- Added and ran scratch-only `review-scratch/heldout_effect_probe.py`. A recursive generator delegates through a helper that appends to an effects list before returning the next argument. At depths 0 and 3, compiled attempts produce the correct yielded values and effects exactly once. Its unsupported `sum(...)` consumer falls back once and produces the same values/effects, without leaking `_Pending`.
- Interpreter: `C:/Python314/python.exe`. Explicit `PYTHONPATH` uses `heldout-fixes/src`; cache, bytecode and temporary paths remain under `review-scratch`.

No source changes, subagents, complete-suite duplication, corpus benchmark reruns or timing measurements were performed. The reported 66-test check and two actual corpus profile successes were read as worker evidence, not independently rerun. This review covers these crash corrections and adjacent inference/scope behavior only; it does not establish general generator compatibility or corrected aggregate coverage/performance. The coordinator's full-suite validation and fresh fixed-corpus study remain separate requirements.
