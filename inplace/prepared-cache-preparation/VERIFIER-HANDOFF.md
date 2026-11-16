# Prepared hit verification and matched repeat (prepared only)

No product implementation or workload has been run by this preparation. Activate only after the coordinator's DESIGN and implementation/test/review steps.

The cache API agreed with the implementer is `recompyler._prepared`, runtime Programs exposing `run`, `source`, `digest`, `ahead_of_time`, and primitive Region `prepared_hits`, `prepared_misses`, `prepared_reasons`. A hit counts only after sealed metadata matches the current live loader. Computational success uses the existing independent `program.run` entry observer plus completed attempt, not the metadata seal export.

Use a new immutable source snapshot, here named `integration-prepared`, and new plans under `inplace/prepared-plans-v1/{chaos,richards_super}/plan.json`. Build those plans using the exact original v4 input paths and `integration-smoke20-v4/shim`; do not copy/relocate/rewrite their script origins or mutate the v4 plans. The plans need not manufacture old-style saved-0 receipt/count files: these scripts reuse the existing v4 expected identities/counts and script arguments. Each verifier child calls the real runner once from cold application globals; no fixture precedes it.

After both new plans/artifacts are prepared, source is frozen and current matched-v1 summary is complete, execute from wave16-inplace with one acquisition per command:

```powershell
python -B inplace/run_locked.py prepared-hit-v1 python inplace/prepared-cache-preparation/verify_prepared_hit.py --source inplace/bases/integration-prepared/src --plan-root inplace/prepared-plans-v1 --output inplace/prepared-hit-v1 --lock-label prepared-hit-v1

python -B inplace/run_locked.py s31-matched-prepared-v1 python inplace/prepared-cache-preparation/matched_smoke_prepared.py --integration-variant integration-prepared --integrated-plan-root inplace/prepared-plans-v1 --output inplace/s31-matched-prepared-v1 --lock-label s31-matched-prepared-v1
```

The verifier forbids regeneration, source unparse, and Numba/llvmlite imports before the saved runner. It requires actual prepared hit(s), 20 independently observed successful computational AOT calls, zero JIT/fallback/unknown successes, exact native plan/export/file hashes and exact stdout/stderr against matched-v1 plain. Capacity retry entries remain separate from successful completion counts. A valid hit that loads no computational native code fails. Forbidden work uses a BaseException sentinel so ordinary fallback exception catches cannot hide it; the final violation list also must be empty. This is an untimed diagnostic, not a performance row.

The repeat harness is an owned copy of the reviewed S31 matched harness with only its location/import path and integrated-plan root decoupled from the common v4 inputs. It preserves v1 harness/results and uses new output directories. It performs one coverage profile/select per program, independent audits for both sources, and three balanced Latin triples (plain/coverage/integrated, coverage/integrated/plain, integrated/plain/coverage) under common warning/stdio/bytecode settings. It reports actual medians, never a startup model.

The NumericVersions guard scans imported product modules for the actual class/run interface when the later depth commits add it. If the implementation moves any forbidden analysis entry or changes the agreed prepared counters/runtime Program API, update/review the verifier before activation rather than weakening its checks.
