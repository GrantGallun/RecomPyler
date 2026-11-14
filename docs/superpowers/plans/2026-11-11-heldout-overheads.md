# Held-out Overhead Implementation Plan

> **For agentic workers:** Use superpowers:subagent-driven-development or superpowers:executing-plans. Coordinate all builds, tests and measurements through the root CPU gate.

**Goal:** Measure the complete held-out suite and reduce evidenced reusable overhead with unchanged supported Python behavior.

**Architecture:** Independent frozen baseline study; one-plan/lazy plain runtime path; separately proved generated physical-address optimization only where valid; matched final cohort and actual selected native/C inspection.

**Tech Stack:** Python runner/AST generation, Numba LLVM/AOT, existing dev_inspect tools and pytest, raw JSON study manifests.

**Spec:** `docs/superpowers/specs/2026-11-11-heldout-overheads.md`

## Constraints and review focus

- Baseline93986c89/producta033;38heldout/9tuned/2separate additions;37meaningful heldout; loops2/limit40/samples8/reps5/audits5/timeout180/defaultunforced.
- Unselected Python execution, selected fallback, successful AOT/JIT calls and opportunity proxies are distinct.
- Preserve user checkout, old evidence, exact frozen source/newlines, native extensions, runtime/input/bytecode identities; never mix cohorts.
- Public selection helpers, force/batch decisions and report/mode contracts remain compatible.
- Native logical negative-index/bounds/error checks remain; nullable/signed addresses require explicit exclusion or proof.
- Encoding/exception/global-state restoration and both heap loaders/alias/growth/rollback require relevant controls.

## Tasks

- [x] Prepare/review initial current-vs-CPython full49workload protocol, mechanics and manifests; complete serialized fresh profiles/timings/audits.
- [x] Implement startup cleanup in isolated `wave8-runtime-fix`: fail-first unused-import/one-plan-read/encoding/state tests; minimal runner changes; focused regressions and independent review.
- [x] Reproduce inherited list augmented-assignment RHS-resize defect with native/Python comparisons; capture base/index once and reindex at the setter, preserving transactional effects and exceptions. Validate/commit the correctness repair separately.
- [x] Implement the reviewed physical-list-address proof only at enumerated checked sites. Add failing symbol-bound native code-generation assertions plus semantic edge controls before the bounded compiler change; retain signed tuple payloads and logical checks.
- [x] Run required focused/native reuse and full-suite checks on combined reviewed source. Freeze/commit and integrate product.
- [x] Apply the evidenced two-site ListT/ArrT len/truth header-consistency refinement in a new clone from411. Verify fail-first native CSE controls, mutation/alias behavior, fresh AOT and a new full suite; preserve the first411native experiment.
- [x] Repair confirmed cached-contract guard bypasses for containers, object classes and NumPy formats in Python/C loaders; rebuild and capability-guard the native support binary; preserve old-binary fallback and matching native aliases/cycles.
- [ ] Run separate matched current/final full-population comparisons, with targeted actual AOT/C inspection and justified kernel measurements; retain failures and costs.
- [ ] Independently verify claims/raw artifacts, archive exact evidence, commit report and safely update only original local integration ref.

Parent `WAVE8-PLAN.md` is the live ledger for paths, source hashes, test evidence, CPU ownership, completed process counts and remaining work. No speed or coverage improvement is assumed in advance.

Paused at the user's request after final source `a9b59be` passed572tests+52subtests with all58inputs unchanged. The final new-source native/C and paired held-out performance runs have not started. Read `docs/studies/2026-11-12-savepoint.md` before any later explicit resume; no automatic overnight work is queued.
