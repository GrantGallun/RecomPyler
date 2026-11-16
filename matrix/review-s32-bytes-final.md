# S32 bytes ceiling final independent review

Current route selection is S36's remaining-time rule: borrowed buffers are primary for all four byte controls. The half-saving decision section below is historical and superseded; the accepted measurements and correctness scope remain unchanged.

Accepted as bounded diagnostic evidence after the half-ceiling decision correction. No concrete source, ownership, artifact or measurement blocker remains within the explicitly disclosed CPython 3.14/GIL/trusted-initial-context domain. This is not acceptance of a product capability or backend change. No workloads were executed by this reviewer; only this review document was written.

## Evidence checked

Read final BYTES-BOUND.md, bytes-bridge-v6.json, bytes-seal.json, C/include/context sources, managed bridge/fresh-process runner, ownership/timing gates and mutation probes. Verified every bytes-seal entry against current bytes: all source files (including installed base64.py), both helper and managed AOT binaries, existing Toolchain builder, shared managed type, final JSON, receipt and audit match. The accepted s32-bytes-bridge-v6 receipt exits 0; its audit has zero competing blockers before and after atomic lock acquisition.

Independently recounted 1,614 identical behavior/exception/event gates, zero bad behavior cases, 18 ownership groups with equal reference/compiled output reference counts, and 24 completed timing cells. Each timing variant has three retained samples. All 504 recorded route samples have zero fallback; every borrowed route's fast delta equals its requested call count. Fresh AOT subprocess exits 0 and reports all six translated bodies plus error propagation passing without importing Numba.

The existing-pipeline obligation is honestly represented: managed nopython/AOT bodies call complete translated C helpers through typed CPython APIs and NRT-owned object values, with boundary costs included. They are explicitly bridges to hand C, not automatic source recognition or per-operation native-byte lowering in the product. Direct-C and managed columns remain separate. Artifact identity and fresh import prevent substituting earlier JIT-only feasibility for AOT evidence.

## Concrete review findings resolved

Executed regressions now cover and correct the altered-table partial-zero path, bytearray/non-exact input handling, boxed tail comparison/slice callback order, converter rebinding and code mutation, outer/inner reverse-cache subclasses, struct binding/import-cache mismatch, base64 module subclass attribute hooks and mutated keyword defaults. Final mutation witnesses pass through all six C/njit/AOT variants. C uses the captured base64.struct binding, guards exact module shapes before bypassing module lookup, checks helper code/defaults and known-inert cache state before conversion, and falls back to the captured original before body callbacks. Base32 output sizing uses safe quotient/remainder arithmetic.

The native loops retain exact immutable input bytes and required table/cache owners while borrowing their data. Managed bridge temporaries own callable/argument-tuple/result references and unwind in reverse order; MemInfo failure compensation follows the installed increment-before-allocation contract. Actual success/error/reference loops and full run_matrix.exception projections support the tested ownership and exception-chain claims. These claims remain finite executed gates, not a proof of every object environment.

## Decision arithmetic correction accepted

The earlier statement that no boxed body reaches half the best absolute saving was incorrect for a85decode. The coordinator corrected the criterion and decision without changing sources, binaries or timing data. At 1MiB raw input, CPython a85decode is 109,876.2us; boxed AOT is 54,097.3us; best direct C is 817.2us. The saved-time fraction is (109876.2 - 54097.3) / (109876.2 - 817.2) = about 0.511. Therefore an initial a85-only slice can use the cheaper boxed route under S32's half-saving rule. Boxed _b32decode and both _85encode alphabets fail that threshold and support choosing a borrowed-byte route. Borrowed AOT retains nearly all measured large-call savings; tiny managed calls often regress and still need the ordinary profitability gate. No additional workload is necessary for this arithmetic/report correction.

## Limits to keep explicit

Only default decoder flags are represented. All boolean _85encode flags are tested, but public a85encode wrapping/adobe behavior is outside that helper. Input shapes outside the translated domain use original fallback and are not new native coverage. Timing uses the listed deterministic realistic input recipe and complete calls, not a fresh held-out deployment cohort.

All three hot functions are from base64. Historical inclusive envelopes overlap, and the 0.000510s leave-base64-out bytes association remains disclosed. This provides bytes/codec evidence and does not select a Unicode representation; a separate real Unicode control remains required.

Context is captured from trusted initial modules under the GIL. Nonempty gc.callbacks forces entry fallback. Ambient cyclic finalizers, asynchronous/concurrent mutation, hostile import-time state, out-of-memory injection, free-threading and subinterpreters remain outside the proved domain. Module context retains references for process lifetime. Private _PyBytes_Resize means CPython ABI dependence; upper-bound allocation followed by resize is not a guarantee of one physical allocation. The a85 4*n+4 reservation/roughly five-times-result overhead is disclosed and peak memory was not measured.

No production matrix rows, automatic whole-function counts or captured/verified/deployed counts change from these experiments. Implementation sizes are estimates. Keep the pending user backend decision and remaining subsystem ceilings distinct from this accepted bytes diagnostic.


## S36 supersession and small-input arithmetic review

Read S36, revised BYTES-BOUND.md, clone-local RULES.md and REPORT.md; checked arithmetic against sealed bytes-bridge-v6.json only. No new measurements or workloads were run. S36 explicitly withdraws the old half-absolute-saving rule, including the previously valid 0.511 a85 boxed-saving decision. Prefer remaining time within 2x of the best measured route. At 1MiB, borrowed-AOT/best-direct-C remaining-time ratios are approximately 1.0645 (a85decode), 1.0838 (_b32decode), 1.0180 (_85encode-a85), and 1.0042 (_85encode-b85). Thus all four choose borrowed buffers as primary; boxed/original paths remain for guard and profitability misses. The old half-saving fraction table is historical arithmetic and has no current selection authority.

The revised small-input pipeline table correctly compares CPython, boxed AOT and borrowed AOT. At 20 raw bytes, a85 borrowed AOT wins at 1.9671us versus CPython 2.6173us. CPython wins for b32 (1.9597 versus 2.7144us), a85 encoding helper (1.1605 versus 2.0521us) and b85 encoding helper (1.0894 versus 2.0801us). At 127 bytes borrowed AOT wins all four. The first observed pipeline win is therefore already at the smallest measured 20-byte a85 input; for the other three it lies between the measured 20 and 127-byte points, reported as (20,127]. This is a sparse observed crossing, not a fitted/exact or universally monotonic threshold, and no significance is inferred from three samples.

Direct-C context is also correctly separated from existing-pipeline overhead. At 20 bytes borrowed C has the lowest median for a85 decoding, b32 and a85 helper; CPython has the lowest median for b85 helper. At 127 bytes borrowed C wins all four. These raw-C minima are diagnostic context, not a promise that the AOT boundary is free.

BYTES-BOUND.md and clone-local RULES.md state the current S36 choice consistently. The REPORT.md update explicitly supersedes its earlier recommendation; an old unlabeled 'choose that cheaper initial slice' sentence should be rewritten or marked historical to avoid two active-looking choices in a standalone report. This is a documentation clarity correction, not a source/artifact or measurement defect. No further blocker to the accepted bytes diagnostic was found.
