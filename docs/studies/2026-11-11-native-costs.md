# Attacking the remaining native gap

The tools now support a more concrete answer than attributing the 5.21x gap to Python in general. A controlled manual experiment reduced Barnes–Hut from **46.5740 to 29.7802 ms**, with a freshly measured C reference at **9.0947 ms**. Grouping calls accounts for the larger observed improvement; simplifying numeric representation helps too. Their combination still takes **3.274x C's time**.

We also implemented a reusable compiler proof that removes redundant integer checks without changing the workload's Python contract. It reaches the actual Barnes AOT code, but its standalone comparison shows **no measured speedup: 47.2972→47.4359 ms**, with overlapping samples. Fewer instructions are evidence of a successful transformation, not evidence of a faster program.

The production source is `9ff4908fdc58613d72287f71cfc6b70aa5e693ff`, based on current integration `0aeb157` (product `e35dce1`). It is merged into the isolated local `codex/integrated-coverage` branch. **441 tests and 52 subtests passed**; independent code, artifact, state and report reviews found no remaining correctness issue. No wider frontend-coverage or universal Python-to-C parity claim is made.

## What the experiments isolate

The fixed six-case manual study uses one compiler source, identical initial states of 200 particles, 100 advances, unchanged arithmetic order and final Python energy inside the original timed boundary. A one-step wrapper controls for introducing a new caller. Four-step grouping reduces region entries from 100 to 25. The current control reuses its hash-verified AOT plan; all timings and audits are fresh. New targets use exactly verified target-only AOT plans under an explicit diagnostic policy, rather than default deployment recommendations.

| Manual diagnostic | Kernel median ms | Time/C | Numeric/type contract |
|---|---:|---:|---|
| Current direct | 46.5740 | 5.121x | Original |
| Current, one-step wrapper | 47.1924 | 5.189x | Original |
| Current, four-step wrapper | 34.2558 | 3.767x | Original source bodies, grouped boundary |
| Force-zero returns/accumulators made float | 42.6232 | 4.687x | Internal method return types relaxed |
| Float-only fields plus force treatment | 42.0559 | 4.624x | Explicit float-only contract |
| Float-only plus four-step wrapper | 29.7802 | 3.274x | Both manual treatments |
| Matched unchanged C | 9.0947 | 1.000x | Existing comparison port |

These are medians of five rotating fresh processes' best-of-five reset-state kernels. C retains the best of 20 inner states per process. The manual combined treatment uses **36.1% less kernel time** than current direct; the effects are not independent additive cost shares. The one-step wrapper alone was slower. Grouping four versus one wrapper saves 27.4%; force-only versus direct saves 8.48%.

Separate instrumented component medians reinforce the boundary observation: current loading is 9.4350 ms and write-back 3.2305 ms per 100 steps; with grouping four they are 2.4667 ms and 0.8440 ms. Native-entry time is 27.6080 ms current versus 27.3371 ms grouped. Force-only native entry is 23.7675 ms; the full-float/grouped combination is 22.8255 ms. Timers add overhead, medians do not form an exact partition, and these are not replacements for ordinary timings.

Grouping retains more temporary trees. Current allocation high-water rises from 7,538 to 19,733 slots; full-float rises from 5,867 to 16,673. All variants use a 512 KiB arena with zero growth retries. High-water is not live-memory proof. These results do not justify rewinding storage or extrapolating to 100-step fusion without escape/lifetime analysis.

Every numerical bit-pattern and mutable-alias checkpoint matches at common steps. Native execution also matches each variant's own Python types. Full-float deliberately changes 402 initial and 400 final numeric field types, including integer acceleration zeros becoming floats; its cross-contract type difference is recorded at every checkpoint. Force-only keeps root-state types here but changes the method's return contract. These are useful diagnostics, not automatic semantics-preserving rewrites for arbitrary inputs or direct callers.

See the [complete manual results](2026-11-11-native-costs-evidence/manual/RESULTS.md), all sample vectors and [checkpoint verification](2026-11-11-native-costs-evidence/manual/checkpoint-postverification.json).

## The first generalizable proof, implemented

The new rule certifies: **if a numeric value is an integer, it can only be canonical integer zero; otherwise it is a float**. Literal-zero base returns, float-valued leaves and recursive sums can establish this from code. It is useful for recursive accumulators, independently of benchmark names or sampled values.

After ordinary type inference, the compiler starts with candidate certificates for locals and helper return leaves, then monotonically invalidates them at every unknown or nonzero producer. Parameters and fields remain unknown unless their existing type is definitely float. Retained recursive certificates are justified over finite successful call trees. Only after convergence does it omit mixed `+/-/*` integer magnitude checks and integer-zero normalization where both operands are certified. It also removes an integer-to-mixed range check for a certified zero. Runtime type flags, layouts, return widths, arithmetic order and fallback remain intact.

Unsupported shapes and ambiguous merged values lose the fact. Fast-mixed/generator/coroutine cases are conservatively skipped. Temporary facts are restored when speculative generation rewinds, all-definitions facts govern mutable locals, and proof failure regenerates ordinary code. No new value assumption is taken from profiling and no benchmark identifier appears in the rule. The [proof design](2026-11-11-native-costs-evidence/analysis/numeric-proof.md) describes soundness and limitations.

Validation includes native LLVM, public int/float types, signed zero, large floats, infinity/NaN, unknown/nonzero integers, branches/loops/polymorphism, temporary copies, repeated compilation, aliases, exactly-once exception effects, recursion limits and fresh-process AOT reuse with both loaders and no Numba import. Focused 14 tests/14 subtests and full 441 tests/52 subtests passed. The 22 warnings are existing-category GPU occupancy/Numba SSA warnings. All 51 tracked source/test files in integration match the tested worker byte-for-byte.

## Honest production performance result

The production comparison uses the **unchanged original workload source** on both compiler versions, a separate frozen manifest and fresh C/current/candidate timings. It does not reuse the faster manual-contract timings.

| Production comparison | Kernel median ms | Whole-process median ms |
|---|---:|---:|
| Current compiler | 47.2972 | 530.8935 |
| Zero-fact compiler | 47.4359 | 540.1634 |
| C kernel reference | 9.123802 | Different inner repetition count |

Kernel time is 0.293% higher and process wall 1.746% higher in this cohort. Samples overlap strongly. Extra proof-generation passes are a possible startup cost, but their cost was not isolated; these measurements do not establish a significant causal regression or a gain. Separate sequential phase processes had increases across loading as well as native time and cannot isolate a native-code regression.

All 20 timing processes passed, with 2,500 actual AOT calls per compiler, zero JIT/fallback. Both full-state audits match all 100 numerical, Python-type and mutable-alias checkpoints plus full initial/final vectors. Each phase diagnostic completes 600 AOT calls with no growth retry. The candidate's fresh combined capture/verification/AOT process costs 56.731 s; the control's profile cost is explicitly reused historical evidence, not a fresh build-time comparison. [Complete proof results](2026-11-11-native-costs-evidence/proof/RESULTS.md).

The rule remains a validated general compiler building block. This study supplies no standalone Barnes speedup claim.

## What the actual native code says to attack next

Independent inspection follows successfully audited AOT exports and verifies PE hashes and wrapper/function addresses. The zero-fact rule removes **eight of fourteen** exactness-bound references in force; the six unknown-coordinate checks remain. Static force instruction lines fall 632→524. Tags and the `0x1e8` local stack reservation remain.

The manual force-only and full-float functions have 471 and 418 static instruction lines, and untagged two-double returns with `0x198` local reservation. Even full-float still marshals **29 outgoing eight-byte stack argument slots** before a recursive call. The compiler expands four heap arrays' descriptors plus semantic arguments through its internal ABI. C uses a much narrower recursive interface, `0x58` local reservation and a specialized theta constant 0.5. These are concrete instruction facts, not measured cycle taxes.

The earlier Python profile of the same 100-step driver observed 2,144,216 force calls. It is not a native/C hardware counter, but it gives useful context for investigating recursive argument passing. Do not multiply static instruction counts by that profile count and present the product as measured traffic or elapsed cost. See the [actual AOT/C report and excerpts](2026-11-11-native-costs-evidence/assembly/REPORT.md).

The next reusable compiler mechanisms follow from these observations:

1. **Closed-loop effects and lifetime proofs.** Enclose more work in one region only when no Python observation intervenes; reclaim temporary arenas only after proving that fresh handles cannot escape into old reachable state. Preserve partial-error behavior and exactly-once effects. Existing constructor initialization checks are not this proof.
2. **Internal result-tag liveness.** Extend the zero fact with a use proof across recursive callers, so flags can disappear from internal results when no consumer can observe the distinction. Keep tagged public results, stores and type-sensitive uses.
3. **A compact internal heap-context ABI.** Preserve the public boundary while passing borrowed pointers/lengths/shared status through a smaller internal context. Prove owner lifetimes, stable buffers, growth exits and shared state. F/I alias; `noalias` is not valid.
4. **Guarded values and private layouts.** Stable theta/capacity or nonescaping records can permit C-like specialization only with explicit guards or static origin/alias proofs.

This is how a manual win becomes general: state the assumption, prove or guard it for each region, specialize within that scope, and retain the ordinary path elsewhere. The same goal alone does not make layouts, calling conventions, static information and observable language behavior identical.

## Limits and reproducibility

RP AOT currently uses a generic CPU target while C uses Clang 21.1.6 `-O3 -march=native -ffp-contract=off`. The impact of that mismatch is unmeasured. Host-specialized artifacts would need feature-aware identity and compatibility guards. C also has fixed representation/lifetime choices; its optimized port is not proof of optimal assembly. Python final energy remains in the RP kernel boundary.

The shared Windows machine had unknown background load. Team heavy jobs were serialized; no OS-wide quiet or statistical-significance claim is made. Neither study adds frontend coverage or default-deployment evidence. The inherited tuple-identity limitation remains separate and unchanged.

Across both studies, 60 fresh timing processes, 16,250 timing AOT calls and 3,900 phase-diagnostic AOT calls were independently verified, along with every checkpoint comparison. Separate state audits add 650 AOT calls. All measured timing/state/phase JIT and fallback counts are zero. Source/runtime/input/artifact/bytecode identities stayed fixed. [Exact evidence manifest](2026-11-11-native-costs-evidence/archive-manifest.json).

Complete raw records and selected AOT binaries are committed locally in independent study repositories: manual `1205c60e321d628c321c6e0df8f58abc9158103a` and production proof `187f331594db2e6662219fee8f17ba000cf4269e`. The adjacent compact archive retains reports, matrices, manifests, logs, code/proof notes, checkpoint receipts and disassembly. Archived test helpers use text suffixes to avoid accidental pytest discovery. No user working files or global packages were changed, and nothing was pushed.
