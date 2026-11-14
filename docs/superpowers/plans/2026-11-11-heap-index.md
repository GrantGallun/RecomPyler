# Heap Index Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox syntax for tracking.

**Goal:** Safely remove internal heap negative-index adjustments and provide reproducible tools and measurements.

**Architecture:** Keep physical heap access proof separate from Python logical indexing. Develop the compiler change and developer tools on independent branches, review both, then freeze an integrated candidate for serialized correctness, assembly and matched C comparisons.

**Tech Stack:** Python, NumPy/Numba, pytest, LLVM disassembly, existing matched C ports.

**Spec:** `docs/superpowers/specs/2026-11-11-heap-index.md`

## Global Constraints

- Baseline integration `3f0370d` (product `0d2c3d3`); no silent baseline substitution.
- Preserve Python negative indices, nullable handles, failure/retry behavior, aliases and overflow safeguards.
- No global tool/package changes, pushes, or modification of the user's working checkout.
- Keep old evidence immutable; retain raw new measurements and output/mode checks.
- Serialize CPU-heavy tests, compilation and timing. Attribute instrumented results separately.

## Review Focus

- Negative user list/string indices and slices must normalize before physical indexing.
- Null/unbound handles and failed allocation must exit before any physical access.
- Heap growth/retry must not duplicate effects; alias identity and rollback must survive.
- Unsigned casts must not alter signed arithmetic, sentinel tests or intermediate offsets.
- Tools must handle missing binaries/tools, unsupported engines, ambiguous symbols and mixed provenance explicitly.

## Tasks

### 1. Compiler and regressions (integration_wave2)

**Files:** `src/recompyler/heap.py`, focused `tests/` additions as justified by existing conventions.

- [x] Inspect all transformed access sites; record the invariant and scope.
- [x] Write and run a failing structural regression and behavioral edge cases.
- [x] Implement narrowly at physical accesses; run focused cases and complete compiler suite.
- [x] Independently review safety and quality; commit the tested source.

### 2. Repository development tools (combined_review_wave2)

**Files:** a small repository `tools/` CLI, documentation and isolated tool tests, following existing layout.

- [x] Add lossless differ, assembly inspection and C source/build provenance commands.
- [x] Add explicit-path phase attribution and named regression case invocation.
- [x] Test real CLI behavior and error cases; document portable example commands.
- [x] Independently review and commit the tools.

### 3. Current-version and C comparison (study_wave2 + root)

**Files:** new external `wave5-study/` frozen harness/evidence and committed `docs/studies/` report.

- [x] Freeze current baseline and protocol before timing; retain exact source/native dependency hashes.
- [x] Integrate and freeze candidate after correctness and review; align actual source bytes.
- [x] Inspect baseline and candidate actual AOT assembly and unchanged C assembly.
- [x] Run paired workloads, verify checks and native modes, compare all samples and phase attribution.
- [x] Report gains/regressions with timing boundaries and remaining C gap; archive compact evidence.

### 4. Final integration (root)

- [x] Obtain whole-branch review and address actionable findings.
- [x] Verify clean integration, source/evidence hashes and final recorded test results.
- [x] Safely update only the original repository's local integration ref; assert user checkout/index unchanged.
- [x] Deliver measured outcome and reusable tool/report links, with no unsupported optimality claims.
