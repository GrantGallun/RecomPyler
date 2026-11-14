# Compact Recursive ABI Plan

> **For agentic workers:** Use superpowers:subagent-driven-development or superpowers:executing-plans. Preserve raw evidence and coordinate heavy CPU work.

**Goal:** Reduce repeated recursive argument metadata with unchanged Python behavior and measured native-code evidence.

**Architecture:** Keep the public array adapter, use typed borrowed pointers plus length internally, and retain local array views for existing indexing semantics. Apply the transformation to complete generated recursive call graphs after SCC merging; use existing array lowering elsewhere.

**Tech Stack:** Python AST generation, Numba intrinsic/CPointer/carray, existing AOT/LLVM/C inspection tools and pytest.

**Spec:** `docs/superpowers/specs/2026-11-11-compact-abi.md`

## Constraints and review focus

- Baseline5d0fe52/product9ff4908; no previous cohort substitution.
- Public entry signature and seed/storage/type contracts stay unchanged; no false F/I noalias.
- Prove borrowed buffer lifetime and stable addresses across one native attempt; growth only after exit.
- Validate shape/stride invariants before extraction and safe error behavior even for empty status.
- Preserve self/SCC recursion, runtime helper calls, recursion/status behavior, rollback and negative indexing.
- New source/runtime helpers are included in digest/cache identity; no Numba import on AOT replay.
- Inspect actual LLVM for residual NRT/allocation work and actual selected AOT assembly for argument reduction.
- Timings, instrumented phases and static counts remain distinct; generic RP versus native C CPU policy remains explicit.

## Tasks

- [x] Implement tests that fail on descriptor marshalling/invariant handling, then the bounded generic internal transformation.
- [x] Review lifetime/alias/call-graph invariants and verify real native signatures, ownership work and Python edge behavior.
- [x] Run focused correctness/cache/AOT cases and the complete suite on frozen source; commit only after green results.
- [x] Freeze current/candidate source, unchanged inputs and benchmark protocol; run serialized fresh paired measurements and independent controls.
- [x] Compare actual audited AOT with current and C: arguments, stack reservation, instruction counts, checks and representation differences.
- [x] Independently review final code/data claims, archive exact evidence and integrate the reviewed implementation.

Final result: product `a033ca14`, 465 tests plus 52 subtests passed; a later fixture-only assertion refinement passed separately with product bytes unchanged. Fresh Barnes kernel 47.4918 to 35.8288 ms, 24.56% less time; C 9.115458 ms. Actual force assembly 524 to 341 instruction lines, recursive stack argument slots 29 to 6. Independent reviews clear. See `docs/studies/2026-11-11-compact-abi.md` and its exact evidence archive.

After the final documentation commit, the root performs the clean source-byte check and protected update of only the original local integration ref. The external `WAVE7-PLAN.md`, `STATUS.md` and final integration receipt record that operation without changing the user's current branch or dirty checkout.
