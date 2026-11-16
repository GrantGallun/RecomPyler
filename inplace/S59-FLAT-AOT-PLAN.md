# Guarded flat AOT implementation plan

> **For agentic workers:** use superpowers:executing-plans inline. S58 requires one implementation review after focused tests and shared10minute fuzz, no design/harness/evidence reviews; S59 says continue autonomously.

**Goal:** make the existing guarded direct flat numeric protocol usable by saved default AOT functions, first for FFT, without importing Numba at run time or deploying a slower wrapper.

**Architecture:** compile a separate no-NRT pycc module for admitted single-owner flat signatures. A small C bridge resolves a versioned immutable capsule from the installed _flat_native helper at module import, then forwards the already-audited C helper calls without imports/allocations in the borrowed interval. The runtime class regenerates existing Unit/source cache identity and final guard metadata without Numba, and delegates declined shapes to the existing AotLifted path. Candidate selection compares actual legacy AOT against actual flat AOT complete calls on independent inert sample copies; preserve the unmodified Python deployment gate and callable legacy seeds.

**Tech:** installed CPython3.14.4 Windows ABI, existing Numba/llvmlite build path, vendored _pycc, C/Python. No installs or writes outside this clone.

**Spec:** root brief Steps2/3 and steeringS49,S58,S59; private f8a2177f protocol and current field-only increment.

## Choices and constraints

- Keep general Heap IR unchanged for the first default slice; broad borrowed-owner graphs and reference publication remain later.
- Capsule bridge chosen over a saved raw function address or an import-library dependency: no process addresses are saved and installed packages need no .lib sidecar.
- Do not implement private source/owner analysis. Require shared provenance valid original binding on root/helper functions before producing a flat export. Unknown declines, including current S57 method/context binding refusals until accepted fix is merged. Binder runs only during explicit profile/build, not on hot runtime calls.
- Runtime imports no Numba/llvmlite/compiler-only _flat module. Existing C final-open guards remain authoritative after the real entry/profile point.
- Normal product cache identity includes compiler/runtime sources, helper binary identity and Python version; this is functional artifact invalidation, not S58 seals/manifests/receipts.
- Initial saved slice admits numeric list/array arguments and inert tuple/scalar nesting only. Member save/restore can follow once its constructor provenance and capture path are covered. No list/field reference stores, Python callbacks, returned containers or multiple borrowed roots.
- Whole-process20-loop timing with fresh cache/profile, alternate plain/recompyler3pairs, exact stdout, native/AOT/fallback counts, PyPy JOINED comparison; hold TIMING.lock only for selection/reported timings. Use noisy peer-overlap samples as measured.

## One capability, one review

Files: add src/recompyler/_flat_api.h (C API layout/version), _flat_link.c (import-time binding and helper forwards), _flat_runtime.py (no-Numba runtime), _flat_aot.py (builder/strict numeric probe/selection). Modify _flat_native.c (publish immutable API), _flat.py (share runtime protocol without changing checked compiler body), _pycc/modulemixin.c (conditional flat-link init), aot.py (optional saved flat entry and preferred guarded runtime). Test tests/test_flat_aot.py, existing protocol/shape/member tests and default AOT/runner tests.

- [x] Write fail-first isolated preparation tests: build_flat(fn,rows,folder) returns module/folder/variant metadata; FlatAot(fn,entry,fallback=None) runs first/warm native with bit-exact results and bytes, rollback occurs before exactly-once fallback, profile replacement is freshly validated, changed root/helper/source/runtime identity refuses, unsupported shapes delegate, saved module loads in a subprocess where Numba/llvmlite imports are blocked.
- [x] Observe missing API failures before product edits (4missing-module failures, s59-flat-aot-red.txt). Do not edit product/test sources while the current S59 member/merge full suite is running.
- [ ] Add capsule ABI/bridge and a separate no-NRT pycc build. Bind at module import; absent/wrong-version helper means ordinary load fallback. Warm native helpers perform no Python import/API lookup. No persistent raw-address metadata.
- [ ] Share the existing FlatLifted invoke/commit/authenticated-decline/accounting protocol in a runtime-only base, preserving all67 existing first/warm/observer/rollback/lifetime tests. Runtime variants contain exported callables, fresh existing guard metadata and expected root code; compiler subclass alone builds missing variants.
- [ ] Build/verify flat exports from inert clones (exact list/tuple/scalars/array only), with exact numeric types/float bits, exception chain/messages and postargument bytes. Shared original binding must prove root/helpers; field/class/default unknowns decline. No application deepcopy hooks.
- [ ] Integrate optional entries into existing AOT section. Compare actual loaded flat and legacy AOT complete-call medians before attaching a preferred flat entry; no slower measured candidate is selected. Ordinary source/shape/guard miss continues existing AOT/Python behavior.
- [ ] Run focused tests, ten-minute shared differential mode on the new saved entry, then one independent implementation review; reproduce/fix executable defects only, record other gaps in KNOWN-GAPS.md. Run the full suite once before commit.
- [ ] Commit, report matrix/heldout once while proceeding, and one three-pair fresh-cache whole-process program cohort beside PyPy. If no program gain, say so and choose the next S59 boundary target. Final-wave10pairs remain last.

## Review focus

Post-commit boxing/profile exceptions must never replay committed writes; import/binder setup stays outside native borrow; C capsule ABI/lifetime must match actual helper; fresh no-Numba reload validates code/globals/defaults; outer AotLifted counters must credit one actual successful route without changing fallback order.
