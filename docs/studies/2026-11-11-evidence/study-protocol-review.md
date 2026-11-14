# Wave 2 study harness review

Follow-up verdict: **Both original P2 findings resolved. Ready for manifest preparation and the coordinator-owned measurement slot.**

This was a bounded re-review of changed `wave2-study/compare.py`, `test_compare.py`, and `REVIEW-FIXES.md` against the two original findings. No benchmarks or tests were launched by the reviewer.

## Finding 1 — environment/runtime/dependency freeze: resolved

Schema 2 records a closed allowlist of system/compiler paths and runtime/thread settings. Child environments are constructed from that saved mapping instead of the current ambient environment. Unknown settings, credential variables, and arbitrary bot selectors are stripped; bot root, counter-model path, strategy/mode, and JIT enablement have explicit defaults tied to the inventoried bot tree. The manifest does not serialize arbitrary `os.environ` values.

`check_frozen` compares the current runtime identity with the frozen executable path/hash, interpreter identity, platform, Python DLL hashes, and distribution versions plus METADATA/RECORD fingerprints before accepting resume. Thus ordinary interpreter/package drift rejects reuse, while changed ambient JIT/thread/bot values cannot change subsequent child configuration. As with the requested fingerprint scope, this is not a byte-for-byte audit of every installed dependency or external compiler binary.

The added environment fixture checks stripped credentials, pinned bot/JIT behavior, and a frozen thread setting after the ambient value changes. The runtime fixture checks rejection of executable, package, and interpreter identity drift.

## Finding 2 — full input inventories: resolved

Preparation and validation now use the same `input_inventory` function and compare the entire mapping, catching additions, deletions, and changed bytes. Corpus inventories include inputs outside the explicit cache/results exclusions. Bot inventories include Python/native modules and every model file, with the same exclusions on both paths. Newly added optional models and local modules therefore invalidate resume.

The added fixture checks a newly added local module and a newly added optional model through `check_frozen`.

## Validation limits

The worker reports six tiny fixtures passing, including the three new failing-first regression fixtures. This review inspected those fixtures and implementation; it did not independently repeat them. No additional actionable issue was found within the requested two-finding scope. The prior review of rotational fresh-process timings, stdout/exit timing gates, paired timing subsets, fixed coverage denominators, and maximum-candidate proxy labels remains unchanged.
