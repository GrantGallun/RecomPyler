# Prospective final binding comparison

Source preparation only. No build, test, profile, workload or measurement has
been run with these helpers. The coordinator must supply a fresh correctness
gate and CPU grant after the generalized binder change is frozen.

The negative a5d prototype cohort remains immutable at `results-formal-v1`.
Final primary comparisons use fresh CPython, strict1d4084f, final candidate
strict, final checked, final unchecked-int64, C exact and C wrap processes.
The five source-backed kernels, all source bytes, valid corpus bytes, contracts,
per-function repetition counts, exact integer/type oracles, separate invalid
semantic audits and seven rotating round orders are unchanged. Metadata
preparation asserts identical kernel/corpus/C-source hashes against v1.

This cohort times COMPLETE CALLS ONLY:245 fresh children (five kernels, seven
variants, seven rotations), three samples per child. Keep all samples; aggregate
the child medians as in v1. RP timing calls use explicitly built fresh AOT and
must import no Numba. CPython/C retain the same complete-call boundaries. All
first-call, construction, JIT preparation, AOT building and whole-child costs
remain separately recorded. No independently measured medians are subtracted.

Preparation includes70 JIT/original/C validation and semantic audit cells,
20 fresh AOT builds and20 fresh AOT/invalid semantic replay audits. Total355
cells plus six C build/disassembly/export records =361 raw process records.
The fixed reference is current strict1d4084f; there is no pooling of a5d timings
into a new final-source row. The old negative result remains a separate cohort.

The unchanged prevalidated native batches are NOT timed again. Preserve their
original a5d identity and interpretation: C-loop adapter invocations, linked
selected JIT code, physical calls/inlining explicitly distinguished from AOT.
Capture all final cold JIT prepare LLVM/ASM and actual selected final AOT PEs,
runtime wrapper RVAs, code-body ranges and C exports. Compare normalized final
native CFG/instruction/op/check counts against v1 before describing native
code as unchanged. Retained old native timings are not relabelled final data.
If equivalence fails, stop and report the difference to the coordinator; do not
silently reuse old native timing or launch a new native benchmark.

No product, policy threshold, caller contract, force flag, kernel, input or
repetition count changes are authorized by this helper directory. The final
candidate path/commit must be clean and match the coordinator's tested freeze.
All source/C/header/license/native inputs are copied and hashed. The new
manifest and frozen helper snapshot own these changes; no v1 helper is edited.

Selected-code text is captured with explicit LF newlines. Postprocessing also
records actual raw byte hashes and canonical runtime text hashes separately,
retaining v1's CRLF captures without rewriting them.
