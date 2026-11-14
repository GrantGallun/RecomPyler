# Metadata-only proposal: current/final/C on Barnes and raytrace

Prepared without executing product, workload, binary, profile, build, test or timing. Root must freeze the final candidate and grant the CPU window before any execution. This proposal does not expand the held-out default deployment cohort or change its selection policy.

## Inputs and fresh profiles

Coordinator decision after this preparation: use fresh current and final profiles/builds for BOTH Barnes and raytrace. No historical profile/artifact reuse this wave. The identity comparison below remains a metadata cross-check, not the chosen execution procedure.

Use the exact existing absolute driver paths under `wave5-study/results/drivers`, not copied paths that alter function source identity: barnes_hut.py (SHA256 75c2550e69a0b565a8fdf1651a723f51e7f63333eb960fc778163722844bf7fa) and raytrace.py (6fbfc3df050c3eb08928a1f05fb7c3cec8058b24216f70d9f8ae55462e06ff2d). Use unchanged retained C source and executables. All six hashes are in native-input-metadata.json. Do not rebuild C or alter work sizes/algorithms.

Current baseline is integration93986c89/producta033ca1. A metadata-only comparison found all 30 source-manifest entries byte-identical to the Wave7 candidate, including heap.py, runner.py, seed source and native extensions. Historical Barnes profile plan is wave7-study/results/plans/candidate.json; selected artifact SHA256 76a7b0c2a9475553633ed9aa1621d27bdb4af76abdd3e5cbfeb2b5b37f6ea564, digest 8b850a3ec40ed1c9992ac80e245679f7e785fa6b866f2c2a6a64d7f9f892e495, r0. Existing selected-mode audit shows 100 AOT/zero JIT/fallback/unknown/rejected. These old records may corroborate the current baseline's static behavior, but the new study will capture fresh profiles/artifacts/audits. Never reuse historical latency as a new sample.

Raytrace Wave5 artifact is a historical older compiler and is unsuitable as the current baseline. Capture four fresh target-only profiles/builds: current and final for both workloads. Preserve original recommendation fields; explicitly label forced selected heap-region policy as diagnostic, not default deployment.

Keep selected artifacts immutable. Use isolated caches/source checkouts for baseline and final candidate. Do not rewrite old plan/source/evidence to make a key match. The final heap changes alter `_heap_key` (raw heap.py bytes plus runtime key), so current/final artifacts must remain distinct even if some generated body happens to match.

## Bounded proposed execution after approval

For each workload: one plain/current/final output-and-mode audit, then 20 rotating fresh timing children (five each plain CPython, unchanged C, current AOT, final AOT). Match the prior explicit inner best-of policy: Python/RP best of five reset states, C best of twenty. Report every raw sample, kernel median and process-wall median separately, with ratios against contemporaneous C. No extra cohort to chase a preferred result. C/runtime controls and frozen checked-hash bytecode policy match Wave7; team jobs serialize, shared host load remains disclosed.

Barnes: exact 200-particle/100-advance driver. Its timed interval includes the 100 advances and final energy computation; initial state creation/initial energy precede the timer. Energy remains outside the selected advance_system compiled region. Reuse existing full-state audit mechanics to compare all100 intermediate numeric/type/alias checkpoints plus initial/final vectors. Expect100AOT per one-state audit,500 per best-of-five timing child,2500 per native source over five children. Require exact independent actual-mode/product-counter reconciliation and no Numba import.

Raytrace: exact100x100 `_render` driver. Its timed interval includes fresh Canvas/Scene construction and rendering; final bytes/checksum formatting occurs after the interval. C allocates its output buffer outside its loop, so allocation/lifetime boundaries differ and must be stated. Target only Scene.render. Expect one AOT per rendered state, five per best-of-five child,25 per native source across five children. Preserve exact byte_sum/FNV outputs; strengthen Python/current/final untimed audit with all30000 output bytes, their type/length and canvas properties. Do not equate a matching checksum with exhaustive universal semantics. C's retained checksum is its existing finite output oracle unless a separately frozen non-timed full-byte observer is deliberately added.

Any actual fallback, JIT, unknown/rejected mode, failed output or invalid source/artifact identity invalidates that comparison cell; retain all failures. Do not silently select a faster subset or count artifact availability as AOT execution.

Separate instrumented phase runs are optional only if root requests them; no phase timing is needed to prove the list-address machine-code delta. If collected, keep them separate from headline latency and preserve prior caveats about overlapping preparation timers and observer overhead.

## Assembly deliverable

Bind static inspection to the actual successful selected digest/export and immutable PE hash for both sources, then follow wrapper → public adapter → borrowed internal body. For Barnes retain existing current force341-instruction reference and inspect final list header/item adjustment blocks, logical bounds/status/depth/type checks, calls/frame/stack operands. For raytrace bind Scene.render and inspect the inlined Canvas.plot RGB access blocks; compare exact physical-address adjustments before/after and retain logical index/byte-range guards. Do not rely on nearest exported symbol names or substitute a fixture JIT body.

C comparisons use the same immutable executables. Explain remaining layout differences (int64 heap slots versus direct structs/byte buffer), tagged values, status/recursion checks, and generic AOT versus -march=native C. Static counts support an instruction-pattern claim, not a percentage of runtime or cycles. If the inherited AugAssign repair is included, disclose it independently from the annotation and do not attribute every performance change to the proof alone.
