# Native Cost Investigation Plan

> **For agentic workers:** Use superpowers:subagent-driven-development or superpowers:executing-plans for implementation; preserve raw experimental evidence.

**Goal:** Quantify safe-region and numeric-contract headroom against C and derive the next generalizable compiler proof.

**Architecture:** Keep manual causal diagnostics separate from production semantic changes. A frozen current-source control and explicit variants isolate hypotheses; source/assembly proof work independently determines which observed simplifications can be generated safely.

**Tech Stack:** Python, RecomPyler inspection tools, existing AOT/C artifacts, NumPy/Numba where new builds are required.

**Spec:** `docs/superpowers/specs/2026-11-11-native-costs.md`

## Constraints and review focus

- Current baseline0aeb157/producte35dce1; no changes to wave5 inputs/results.
- Same100advances, final-energy boundary, input state and check definitions; fresh comparison timings.
- Record type/identity changes in manual contract variants; matching finite checks does not establish universal equivalence.
- Grouped arena growth and retained allocations confound pure boundary subtraction; record them explicitly.
- Numeric proofs must reject nonzero/unknown integer sources and preserve tags, signed zero, exceptions and rollback.
- No source-name-specific production rules, global package changes or changes to user checkout.

## Tasks

- [x] Freeze small experiment protocol and source/contract matrix after read-only root-cause analysis.
- [x] Prepare and test variant generation; compare complete state observations and real native modes.
- [x] Run serialized fresh C/current/variant timing and separate attribution/assembly checks.
- [x] Derive bounded zero-or-float proof design, including recursive fixed-point and invalidation cases.
- [x] Implement the selected bounded zero-or-float integer-case rule after failing tests, independently review it, and measure fresh current/C/native assembly; preserve runtime type flags and reject unknown/nonzero integer facts.
- [x] Independently review conclusions, archive exact evidence and integrate the report/tools or validated production change.
