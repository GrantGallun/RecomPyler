# Compact recursive heap calls: implementation and measured C gap

The new internal calling convention reduces Barnes-Hut kernel time from **47.4918 to 35.8288 ms**, **24.56% less time / 1.326× speedup**, on unchanged Python source. The fresh C reference takes **9.115458 ms**: the gap falls from **5.210× to 3.931× C time**. Whole-process median falls **8.53%**, from 559.6180 to 511.8625 ms. This is a general transformation of supported recursive heap-region call graphs, with no workload-name check, numeric relaxation or source rewrite required from the Python programmer.

Production commit: `a033ca14c40afed052a6266a0a575f6cc11559ea`, merged into the integration branch at `f568dcf2568a06a99ce9f6daf6e497a919d045a9`. Baseline: `5d0fe5296e077b893a0d9c920f6ccfe798696eeb` (product `9ff4908fdc58613d72287f71cfc6b70aa5e693ff`). The separate complete raw study is committed locally at `f087533ec047216fd4f7dccea0286e03f45c1628` in `D:/Code/Datathon/recompyler-codex-20261111/wave7-study`. Nothing was pushed or merged into the user's current branch.

## What changed and why it generalizes

Previously, every generated recursive call passed four full ndarray descriptors for the float arena, its integer view, allocation/depth counters and status. The optimizer retained a large amount of descriptor marshalling at each recursive edge. These arrays have the same owners and stable addresses throughout one synchronous native attempt; repeated ownership and shape metadata are unnecessary there.

The public entry still accepts the original four arrays and semantic arguments. It validates the one-dimensional shape, lengths and strides once, then extracts **four typed borrowed pointers plus one common arena length**. Internal generated functions reconstruct local borrowed `carray` views. This keeps ordinary signed/negative indexing and existing helpers while giving native calls a smaller argument list.

The pass runs after specialized type settlement and mutual-recursion merging. It consistently rewrites all generated functions and their call sites inside a recursive region, including self recursion, mutually recursive groups and their wrappers. Runtime helpers retain their established interfaces. Completely nonrecursive regions retain their existing generated bodies. This does not extend frontend eligibility to previously unsupported Python programs.

The proof relies on existing internal ownership invariants, not a property of Barnes-Hut: the Region owns writable contiguous buffers, Python references keep them alive through the call, and arena growth happens only after a native status exit. A new attempt borrows the new addresses. F and I alias the same allocation; no false `noalias` assertion is added. External ndarray payloads remain separately retained and checked. This is not an arbitrary-buffer foreign-function interface.

Python-visible result tags, recursion limits, status handling, failure rollback, mutable identities, negative indexing, RNG state and numeric exactness rules are retained. Generated pointer helpers participate in source/cache identity. Fresh AOT replay resolves the saved artifact before executing generated Numba imports.

## Fresh timings and execution coverage

| Same 200-particle, 100-step workload | Kernel median ms | Complete process median ms | Timing AOT / JIT / fallback calls |
|---|---:|---:|---|
| CPython | 552.2853 | 2961.4642 | — |
| C | 9.115458 | 207.7995 | — |
| Current compiler | 47.4918 | 559.6180 | 2500 / 0 / 0 |
| Compact recursive ABI | 35.8288 | 511.8625 | 2500 / 0 / 0 |

Candidate kernel speed is **15.41× CPython** in this experiment. Native deployment for the selected region was already complete before this change: the improvement comes from faster native execution, not newly compiled calls. The kernel still includes final Python energy calculation outside the compiled advance region.

There are five rotating fresh processes per case. Python/RP report the best of five reset-state kernels per process, C the best of 20, unchanged across versions. The table takes the median of those process bests; process walls include startup, cold reconstruction and all resets. RP uses the same explicit target-only forced AOT policy on both sources. These are diagnostic deployment results, not default-selection coverage for all held-out programs.

All 20 timing processes exited successfully and matched three exact numeric checks. Candidate samples span 35.0590–36.5932 ms; current samples 46.9036–50.7206 ms. Unknown background work persisted despite serialization of team jobs; no OS-wide exclusivity, confidence interval or cycle attribution is claimed.

Separate state audits match plain Python at **all 100 steps**, including numeric, type and mutable-alias hashes and full initial/final 1400-scalar vectors. Each source has 100 actual successful AOT calls and zero JIT/fallback/rejected/unknown calls. Separate phase runs add 1200 successful AOT calls with zero JIT/fallback. None of these audit/phase processes imported Numba. All actual counters reconcile with product counters.

Three independent controls cover a 127-node recursive object reduction, recursive mutation of a shared list with negative indices, and recursive tuple/object returns preserving identity and exact types. All six fresh profiles and nine plain/native audit processes pass; native audits total 48 AOT calls with zero JIT/fallback/rejected/unknown. These are bounded correctness/generality controls; no speed or C-parity claim is made for them.

## How much the actual assembly differs

These measurements inspect the **actual AOT binaries selected by successful executions**, not a different profiling specialization. The candidate chain is wrapper `0x1800011d0` → public array adapter `0x180001090` → borrowed advance `0x1800025d0` → recursive force `0x180002c30`. Full mapping, provenance, excerpts and recount methods are archived.

| Recursive force routine | Current | Compact ABI | C |
|---|---:|---:|---:|
| Static instruction lines | 524 | **341** | 116 |
| Lines with stack-pointer operands | 275 | **69** | 22 |
| Address span, bytes | 3152 | **1584** | 480 |
| Local stack reservation, bytes | 488 | **280** | 88 |
| Outgoing 8-byte stack argument slots per recursive call | 29 | **6** | 0 |
| Coordinate exactness-bound comparisons against 2**53 | 6 | **6** | 0 |

One matched recursive-call setup slice falls from 53 to 11 instruction lines; its call-and-return excerpt from 19 to 16. The saved baseline setup excerpt has 55 lines because it also includes two depth-guard instructions; the candidate's excerpt starts after its corresponding guard. These are explicitly scoped excerpts, not all-path dynamic counts. The candidate force has four recursive calls and no additional NRT/allocator calls. Both double results and their numeric-kind bytes remain. The final self-recursive LLVM fixture separately verifies four typed pointer parameters plus length, actual self calls, no NRT ownership/allocation operations and no F/I `noalias`.

Static instructions are about **35% fewer** than before, but still **2.94× C**. Stack operand lines include arguments and ordinary loads/stores, not exclusively spills. Stack reservation excludes pushes and other frames. Address spans include alignment. These numbers describe structure; they are not executed-instruction counts, cycle ratios or a partition of the measured 3.93× gap.

## What still prevents C speed, and what can be generalized next

1. **Numeric kinds and exactness checks.** Six comparisons against exactly 2**53 remain in the coordinate subtraction/square/sum path. Python fields can contain integers; results retain two numeric-kind bytes, including integer-zero base cases. C has untagged doubles. A broader proof of stable kinds/ranges, or a guarded specialized path with correct exit/rollback, could remove work. Observing floats once does not justify silently changing arbitrary Python arithmetic.
2. **Error and recursion state.** Native code increments/checks depth before each recursive call, tests shared status afterward, stores error locations and decrements depth. C has no corresponding Python fallback/recursion contract. Hoisting or proving checks redundant needs a valid bound or another way to preserve the same observable behavior.
3. **Representation and extra loads.** RP loads handles for center and position objects, then their slots; child/list access carries its own representation. C embeds numeric fields and child pointers in fixed records and uses a contiguous particle array. Flattening nonescaping objects or selecting guarded fixed layouts could generalize. It must preserve shared identities, mutations and escape behavior. This patch changes neither layout nor lifetime.
4. **Remaining call interface and specialization.** Candidate still carries five context scalars, semantic arguments and the backend's result/exception convention, leaving six outgoing stack slots. C passes node, particle index and two output pointers in four registers and specializes theta to **0.5**. A single borrowed context pointer and guarded value specialization are further hypotheses, not measured savings in this wave.
5. **Crossing between Python and native state.** Every one of the 100 advances still loads Python objects and writes results back. Larger compiled regions or retained native state could avoid repeated conversion when escape/alias/mutation proofs allow it. This cost cannot be removed by making force's arithmetic instructions shorter.
6. **Backend target differences.** RP AOT remains generic CPU/features; C uses Clang 21.1.6 with `-O3 -march=native -ffp-contract=off`. C's scalar VEX instructions do not demonstrate vectorized traversal. The CPU-target contribution is unmeasured. The C port is a reference implementation, not proof of optimal assembly.

Much of the residual work is a compiler/representation opportunity. The general strategy is to prove a constraint unnecessary for a region, or guard it once and retain a correct fallback. Universal C-equivalent time for arbitrary Python programs is not established: dynamically observable behavior and supported inputs determine which assumptions can safely be removed.

Separate instrumented warm medians support the distinction between native and boundary costs:

| Per 100 advances, instrumented | Current ms | Compact ABI ms |
|---|---:|---:|
| Native entries | 30.6576 | **17.4821** |
| Load Python objects | 10.4110 | 9.8389 |
| Writeback | 3.6494 | 3.5889 |
| Entire instrumented kernel | 53.8001 | 39.5747 |

These are separate instrumented runs and independent component medians. They include observer overhead, do not add to the headline latency, and cannot assign an exact fraction of savings to particular instructions. Both sources have the same 65,536-slot / 512 KiB arena capacity, maximum top 7,538 slots and zero growth retries.

Cold behavior is a material limitation: the single observed `Region.program_for` invocation increases **47.990 → 65.311 ms**, and instrumented cold kernel time **170.9959 → 187.8845 ms**. That method includes saved-graph/source reconstruction, AOT preparation/validation and nested loading; it overlaps phase timers and is not a pure source-restore timer. Prepared fastpaths bypass subsequent calls, so no cached-call zero is inferred. Fresh candidate capture/verification/AOT profiling cost **65.160 s**. Baseline reused its exact validated artifact/profile, whose **56.731 s** cost is historical; no old latency was reused. Generality-control profiles cost another 38.997 s, excluded from latency medians.

## Correctness, review and reproducible evidence

The full suite recorded **465 passed and 52 subtests passed**, 22 known-category warnings, in 282.91 s. Focused controls exercise mutual recursion/default arguments, both loaders, growth/reborrow, aliases/negative indices, nullable tuples, recursion-limit fallback, exact-once rollback, recursive overlapping/negative-stride NumPy views, Random twist/state rollback and fresh JIT-cache/AOT reuse.

After that full run, a test-only precision refinement selected the actual self-recursive specialized helper rather than its outer caller and checked all borrowed native definitions. The affected final test passed separately (1 passed, 23 deselected, 1.26 s), with product bytes unchanged. Both full-run and final test-file hashes and the initially failed evidence matcher are retained; the final test bytes are not presented as having undergone another full suite. Independent production-code/lifetime/alias/recursion and actual AOT/data reviews found no unresolved actionable findings.

Candidate heap source SHA256: `38b77af3e77c73b132db4d973242eb30e8cbc590003b7cb9820e7430c9b3edd6`. Integration's tracked source/test bytes match the frozen worker exactly. There is a disclosed LF/CRLF-only `_region_seed.py` difference between baseline and candidate: normalized contents match; raw identities remain distinct in manifests and saved artifacts. Neither frozen source was changed after measurement.

Selected PE SHA256 values:

- Current: `94afcc7bfed19eeb450e1f3aae3fe0f37aab6e48ba1e08ae1f3122997e4e2fda`.
- Compact ABI: `76a7b0c2a9475553633ed9aa1621d27bdb4af76abdd3e5cbfeb2b5b37f6ea564`.
- C: `4fd003eeea3b3bf997c90889340719fd71e8f698da5feca673ece46e9418f9ff`.

The primary manifest hash is `308adefb126b9d36f4742ec29bb4590f807d2955293f168aa2c90d0dd6bcaabc`; controls manifest `3696d2640f48ead8dc5ca89d8aa3086e6af4691e711871e1682db4733e538516`.

The adjacent [evidence archive](2026-11-11-compact-abi-evidence/archive-manifest.json) contains the entire 392-file / 5,005,987-byte committed study, both frozen source inventories, eight selected native artifacts, raw samples/states/phases, full assembly, correctness logs, final LLVM fixtures, independent reviews and root verification. Python source captures use `.py.txt` names to avoid unintended test discovery; `archive-manifest.json` maps every capture back to its original name and byte hash. The original study retains executable helpers. Its 54 raw process output records include one reused historical profile record; all other preparation/measurement/control/mapping records are new. Archive hashes preserve exact bytes.

Root verification independently compares all 392 study Git blobs to disk, recomputes medians from raw outputs, reconciles counters, compares all state snapshots/checkpoints and recounts force assembly. Existing development inspection tools remain in `tools/dev_inspect.py`; this wave uses their diff on the scoped actual AOT force excerpts. These tools and measured evidence support the next optimization; they do not replace the needed semantic proof.
