# Recursive context and heap-load results

The strict compiler changes reduce Barnes-Hut kernel time by **8.10%** and raytrace by **6.33%** against the saved a9b version in a fresh matched experiment. Python behavior checks and fresh-process AOT reuse pass. Both kernels remain materially slower than the C references; held-out native coverage remains a separate problem.

Implementation source is `0373788b7be436e5e43b0a6a6f3fd40b2871c3a3`, integrated locally at code merge `4fca7509fce0647a7abbd2b5b69fcd424905e8c9`. All **61 tested source/test/native files** match the integration checkout byte-for-byte. The original working checkout and its changes were preserved. Nothing was pushed.

## Fresh kernel and process measurements

| Kernel median | Saved a9b | New 037 | Less kernel time | C reference | New / C time |
|---|---:|---:|---:|---:|---:|
| Barnes-Hut |35.9731 ms|33.0608 ms|8.10%|9.088993 ms|3.637x|
| Raytrace |3.6609 ms|3.4292 ms|6.33%|0.607967 ms|5.640x|

Every paired sample is faster in this cohort. Barnes ranges are35.1793–38.9277 versus32.3649–33.6340 ms; raytrace3.6067–3.6996 versus3.4015–3.6054 ms. Ranges do not overlap, although the raytrace gap is only0.0013 ms. Five fresh children per cell and uncontrolled host background do not establish universal gains or instruction-to-cycle attribution.

Whole-process medians are separate: Barnes490.1197→475.1701 ms (3.05% less, nonoverlapping ranges), raytrace388.4918→385.8284 ms (0.69% less, overlapping ranges). The ray kernel result is not a firm whole-process gain.

All **58 process records** passed: four fresh profiles,40 timing children,six full-state/mode audits,four warmups andfour maps. Timing recorded **5050 successful AOT calls**, separate audits202; zero JIT/fallback. Barnes initial/final vectors and all100 intermediate numeric/type/alias checkpoints match Python. Raytrace all30000 RGB bytes, types, dimensions and mutable-array identity match. Independent verification binds selected digest/export to actual binary hashes and runtime wrapper maps, then checks raw streams, counters, bytecode/artifacts and medians.

This is the unchanged target-only diagnostic with explicit force policy; it does not establish default selection or new held-out coverage. Python/RP use best-of-five reset states per child; C best-of-twenty. C uses host CPU tuning while RP AOT is generic. C also uses direct records/bytes and some narrower assumptions, including fixed theta in Barnes. Allocation/energy timing boundaries differ as documented in the retained protocol. The C ports are references, not proof of optimal assembly or identical Python semantics.

## What changed and why it generalizes

Recursive generated bodies now receive one pointer to a typed, immutable descriptor instead of five separate heap-context values. The public array interface and validation remain unchanged. A compile-time intrinsic creates one stack record in the public adapter; synchronous calls finish before its lifetime ends. Growth exits discard it and retries reconstruct it with new buffers. Builtin pointer-to-tuple typing preserves actual pointer types without a registry. F/I still alias the same storage, and their contents remain mutable.

Helpers already marked for AOT always-inlining receive the caller's five heap SSA values alongside the context pointer. They reconstruct views without reloading descriptor fields. Other boundaries, including recursive bodies and large helpers, retain the compact pointer interface. Call rewriting follows the callee's original marker, including SCC wrappers and public entry wrappers. Existing JIT/profiling `_plain` behavior remains; its wider helper calls are an explicit tradeoff, not a claim of independently measured JIT acceleration.

Ordinary list iteration now uses the existing nonnegative physical-slot proof for header/data/item addresses. It still reloads current length/data each iteration, captures the original list identity, and preserves append relocation, shrinking, rebinding, nullable tuple sentinels and body index checks. These are compiler rules, with no benchmark-name special cases. No error, recursion, numeric-kind or alias checks were globally disabled, and no noalias/readonly/invariant metadata was added.

## Actual selected assembly

| Barnes force | Saved a9b | New 037 | C |
|---|---:|---:|---:|
| Instruction lines, including one padding nop |334|316|116|
| Local stack reservation |280 B|248 B|88 B|
| Stack-operand instruction lines |67|45|22|
| Outgoing recursive stack words |6|2|0|
| Self calls |4|4|4|
| Exact2^53 references |6|6|0|

The actual recursive calls pass context/child in registers, with particle/theta occupying the two outgoing slots. Status checks precede returned data/tag use; depth checks, success-only decrements and numeric-kind handling remain. The adapter initializes one40 B record. Force reads its four needed fields once; unused arena length is not loaded.

Barnes advance executable lines fall318→281, local reservation248→200 B, and stack operands60→32. All three list iterator physical-wrap patterns disappear. Ray render executable lines fall997→995, frame472→440 B, stack operands118→103. Its recursive SCC falls2508→2400 executable lines, frame680→648 B, stack operands353→276. Render/SCC each load five descriptor fields at entry. These static counts are not dynamic instruction totals or cycle shares.

The first all-pointer prototype is preserved as a useful counterexample: it improved Barnes6.11% but regressed ray7.05%, with render growing999→1181 total lines and75 descriptor reads. The refinement removes those repeated reads without asserting payload immutability. Its timings above are fresh against a9b; older medians were not pooled or presented as a direct 578-versus037 timing experiment. See the [actual assembly report](2026-11-12-context-evidence/assembly/ACTUAL-037-REPORT.md) and [preserved prototype result](2026-11-12-context-evidence/first-prototype/RESULTS.md).

## Correctness and reuse

Final source passed **599 tests and52 subtests**, with22 retained known-category warnings, in300.90 seconds. All61 source/test/native inputs were identical before/after and still match integration. Focused validation passed120 tests plus14 subtests; new countertests first failed on the old implementation, including12 repeated descriptor loads in a mutating-helper fixture. Coverage includes actual noncanonical pointer payloads, both loaders, mutual/SCC entry interfaces, growth/reborrow, rollback/replay, numeric kinds, negative indices, NumPy/RNG effects, fresh AOT without Numba import, and recursive disk-cache reload.

Fresh independent whole-branch and evidence reviews are clear. The warning count and earlier fixture/expected-RED failures remain in raw validation logs. Tests and finite state audits support these cases; they are not a proof for arbitrary Python programs. No product/test changes followed the final freeze. The guarded heap support binary remains17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0.

## Full held-out result measured first

Before these optimizations, the saved a9b was compared against939 and CPython on the fixed49 population using1423 fresh process records. All passed, with independent verification. Results for **saved a9b**:

| Group | Native programs | Process speed versus CPython |
|---|---:|---:|
| Held-out38,37 meaningful timings |0/38|0.967146x: about3.4% longer time|
| Tuned9 |4/9|1.246752x|
| Separate Go/poker additions |0/2|0.967993x|

The same four tuned programs were native in both versions: Barnes, fannkuch, raytrace and SciMark,2020 timing AOT calls per source and zero JIT/fallback. There was no coverage expansion. Exact stdout/exit checks, often empty, are not complete semantic or native-time coverage proofs. A changed external bot tree was preserved; both versions and CPython used the identical143-file archival snapshot with path-only routing. Full records, costs and limitations are retained in the [saved-build study](2026-11-12-context-evidence/heldout/RESULTS.md).

The final037 changes were validated with the full correctness suite and the two selected native/C benchmarks. The full49 default-selection benchmark was not repeated on037; do not relabel saved-build coverage as a new037 coverage measurement.

## Remaining C gap and both faster modes

Remaining costs include heap handles/expanded layouts, cross-frame field reads, tagged numbers and exactness checks, recursion/status work, and repeated packing/writeback at Python boundaries. Invariant recursive arguments could remove the remaining two stack slots, but need activation-local environments and data-flow proof; unchanged arguments do not prove their fields immutable. Larger safe regions and compact layouts can address costs that instruction cleanup or relaxed arithmetic alone cannot remove.

Both requested mode approaches are specified, **not implemented**: checked input contracts with proof and fallback, and explicit restricted arithmetic with documented wrapping-int64 semantics. A passing training/test set cannot justify automatically disabling future error checks. The proposed first pilot proves every integer intermediate from declared intervals in checked mode, versus defined modulo2^64 behavior in the opt-in mode, retaining representation and memory safety checks. Tiny-kernel entry overhead can dominate; no mode speedup is claimed. See [both mode designs](2026-11-12-context-evidence/designs/EXPERIMENTAL-MODES.md).

## Reproducible evidence

The [capture index](2026-11-12-context-evidence/archive-manifest.json) binds raw native process/state/mode records, four actually selected PE binaries, unchanged Python/C inputs, frozen helpers, selected-code assembly, independent reviews and exact candidate/test/native checkpoint. Source captures are inside zip files or `.py.txt` to avoid accidental test discovery.

- Final worker0373788; local code merge4fca7509; context904f5b7 and iteration57835fa remain in history.
- Final native archive93278a74afc22d18c17596d5367a229bc1cd9c43; manifest095ecab621b1cf7876b3c165fb7bef5bc9ae4088512c3fcd7b8a6c3d63fe9133.
- Full saved-build archiveadd8fe34eba9ffbf74fb29077b6141bfcce144f5; manifest92d2cbf74740bad09c91feb84a391928e9cef31a580df5b8af5e08e97d8a72b6. Full49 raw data stays in that independently verified study repository.
- Candidate checkpoint SHA2562b94fbd4d5aab8f9563ea81345b8c17f66be092ba5cc040fd197b3bd5a18397f;104 verified members,61 frozen inputs.
- Final static checkpoint SHA256ae8b91756d316c7224995f6f4f99762ae72a2ad0366b03f87904f8915f3bfbb8;51 verified members.
