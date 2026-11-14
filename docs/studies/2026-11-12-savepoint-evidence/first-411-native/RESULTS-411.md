The first targeted current/411 comparison passed all checks but showed **small, overlapping timing changes**: Barnes kernel36.3475→36.2738ms (0.20% less time); raytrace3.9311→3.8272ms (2.64% less). Raytrace whole-process median **increased2.31%**, from420.3720 to430.0978ms. These five-repetition distributions do not establish a clear throughput gain. Static instruction removal is reviewed separately and is not a cycle attribution.

This completed immutable cohort compares current`93986c89a5b512ef82a33af1f101bf6f796ae61f`/producta033 against first candidate`411624630f818bc548a3183e3a25cecf13116640`. ManifestSHA256`836382bb3dbdfdcf67a46c45a1f65ce8137a108e0a00cdcd404426a743fa00e2`. Both sources had fresh target-only profiles/builds, no historical artifacts/profiles/latencies reused. Original absolute Python drivers and C binaries/sources remain unchanged. The later header refinement will use a NEW output/source manifest and allfresh runs; these411records will not be overwritten or pooled.

| Case | CPython kernel ms | C kernel ms | Current kernel ms |411kernel ms | Current /411process ms | Current /411kernel time over C |
|---|---:|---:|---:|---:|---:|---:|
| Barnes |539.7056|9.134054|36.3475|36.2738|512.0595 /509.1083|3.9793x /3.9713x|
| Raytrace |161.1319|0.604630|3.9311|3.8272|420.3720 /430.0978|6.5017x /6.3298x|

Kernel values are medians of five rotating fresh-process bests: Python/RPbest-of5fresh states, Cbest-of20. Source current/411process work is identical; Cprocess executes20states versus5Python/RP, so do not equate process-wall ratios to a single-state kernel comparison. Python raytrace times freshCanvas/Scene construction and rendering; Callocates its output buffer outside the inner loop. Barnes retains200particles/100advances, with finalenergy inside the timed interval and outside the selected compiled region; initial state/energy are before the timer. No phases or separate arena/reconstruction timing were collected here.

Five kernel samples in process order, milliseconds:

| Program /source | Samples |
|---|---|
| Barnes current |37.3733,39.4751,36.3475,36.1697,35.7194|
| Barnes411 |36.3987,36.6420,36.2738,35.7056,36.0197|
| Raytrace current |4.0087,3.6827,3.9638,3.9311,3.6813|
| Raytrace411 |3.8561,3.7370,3.8272,4.6544,3.6470|

Barnes median process time fell0.58%; raytrace rose2.31%. Kernel speed ratios current/411are1.00203x and1.02715x respectively. All samples and process-wall vectors are preserved in results/ANALYSIS.json. Unknown shared-machine background load remains; no extra repetitions, subsets or cohort were chosen to seek favorable results.

All40timing processes passed unchanged numeric oracles. Barnes compares exact double bit patterns for initial/finalenergy andposition_sum; raytrace compares exact decimal byte_sum/FNV strings, including values beyond double precision. Existing Cchecksums are a finite oracle, not universal semantics or a new full-byte Cobserver. Current and411each executed2500AOT Barnes calls and25AOT raytrace calls across five timing processes: **5050successful timing AOT calls total, zero JIT/fallback**. The policy is explicit target-only --force diagnostic selection, not default held-out deployment.

Six separate untimed state processes (plain/current/411percase) passed. Barnes retains full initial/final1400scalar numeric/type vectors and mutable alias labels, plus exact100intermediate numeric/type/alias hashes; each native state audit has100AOT calls. Raytrace compares **all30000RGBbytes**, arraytype/typecode/itemsize, canvaswidth/height/types, before/after snapshots and preservation of the original mutablearray object; each native audit has1AOT call. These202separate actualAOT calls reconcile exactly to product counters, with zero JIT/fallback/rejected/unknown and no Numba import. They are not added to timing counts and are not counts of internal recursive function calls.

Profiles verified8/8captured Barnes calls/source and1/1Raytrace call/source under the maximum8sample setting. Combined fresh profile/capture/verification/JIT/AOT/startup-probe wall cost199.772s; compile-only warmups3.206s; state audits2.833s; address-only mapping0.732s. There are58completed top-level records:4profiles+40timings+6stateaudits+4warmups+4address maps, totaling236.292s child wall. No failures/timeouts or invalid comparison cells. Upfront profile/audit/mapping costs are excluded from deployment latency.

Actual successful selected exports are r0 in every case. Maps are results/programs/{barnes_hut,raytrace}/{current,final}-aot-map.json and bind immutable PEhashes/paths, selecteddigests, wrapperaddresses and successful audit evidence. Barnes wrappers areRVA0x11d0; raytrace0x11a0. Current/finalBarnes PEhashes04b0aa1b.../7c1bfc3e...; raytracec90fe871.../c5f726b4.... Mapping loads extensionmodules only to recoveraddresses, without kernel execution/build/timing. Root reviewer owns actualAOT/Cstatic review under wave8-assembly-analysis/actual-artifacts; no profilingJIT body is substituted for these artifacts.

Final411contains the physical-address annotation, inherited AugAssign evaluation-order repair and runnerstartup changes together. Timing is not isolated perpatch. Both source trees/runtime/packages/environment/helpers/originalinputs/shim/bytecode/AOT identities were frozen and verified; source-origin assertions validate profiler/heap/runner imports. Native support and CRLFseed bytes match exactly. Generic RP AOT target versus unchanged Clang21.1.6 -O3 -march=native -ffp-contract=off Ctarget remains an unmeasured tuning/layout difference. No array/type-contract change, boundary grouping, source numeric normalization or phase extrapolation was introduced.

The initial fixed49current-vs-CP cohort remains a separate immutable study. The prepared full paired411manifestcc7718... was never executed and is retained explicitly as unused metadata. Root selected a small header-proof/CSE refinement after reading actual411AOT; any later native/fullpaired experiment uses new paths/results and fresh matched runs. CPU slot was released after coordinator exit0 and final frozen checks.
