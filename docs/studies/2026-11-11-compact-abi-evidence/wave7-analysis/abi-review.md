# Compact heap ABI independent review

Scope: baseline integration `5d0fe52`, product zero-fact implementation `9ff4908fdc58613d72287f71cfc6b70aa5e693ff`; compact-ABI implementation in `wave7-compact-abi`, frozen commit `a033ca14c40afed052a6266a0a575f6cc11559ea`. Design, actual patch, native validation and selected Barnes AOT inspection are reviewed below. No reviewer-run build, kernel, profile or timing job has been started.

## Bounded design assessment

Passing four typed borrowed pointers plus one common arena length to internal generated functions is a reasonable bounded first change. Reconstruct local one-dimensional `numba.carray` views so existing checked operations and signed/nullable index behavior survive. Keep the original public entry's four ndarray arguments and semantic arguments, with an adapter into the internal implementation; retain result flags, status and recursion depth semantics. Apply the rewrite after mutual-recursion merging so merged SCC functions and their wrappers have a consistent ABI.

A single heap-context pointer might be narrower still, but adds descriptor layout/allocation/address-lifetime machinery. Deriving the I pointer by casting F would remove one scalar but couples the intrinsic to alias/representation details more tightly. Neither is necessary to test the four-pointer/common-length hypothesis. No performance benefit follows merely from having fewer source parameters; final native signatures and call sites must demonstrate the reduction.

## Existing invariants supporting borrowed pointers

Read baseline `heap.py` `Region.arrays()` and `Region.attempt()`:

- `arrays()` allocates F as a contiguous one-dimensional float64 array, I as its int64 view, top as int64 length four, and status as uint8 length one. All four are writable runtime-owned buffers. F and I have identical slot counts and alias the same bytes.
- The synchronous call `program.run(F, I, top, st, *passed)` is surrounded by Python references to all four arrays. A local view does not need to acquire or transfer ownership; it must not escape the native call or be returned as a new owner.
- Arena exhaustion signals status two. Allocation capacity changes and reconstruction/reloading occur only after the native call returns. Therefore pointers are stable during a single native attempt, including recursive calls. The proof does not cover a new in-native grow operation.
- `top[0]` is allocation position, `[1]` depth, `[2]` limit, `[3]` failure location. All helpers must observe the same mutable top/status storage; copying their current values into per-call state would be incorrect.
- External ndarray payloads are separately retained by the loader and have rollback snapshots when written. RNG state is stored through I and committed after success. A heap-view rewrite must preserve these mechanisms and must not rewrite their separate pointer/layout logic.

No new input-value fact, field layout, alias restriction or ownership assumption is needed beyond these existing internal buffer invariants. The public Python/Region path, not arbitrary malformed calls into a private generated helper, establishes the buffer contract.

The intrinsic itself can be typed for a readonly ndarray, while carray reconstructs a writable local view. That is not a valid Region heap context: external readonly ndarray inputs are recorded as separate handle/address metadata by `_Loader.ndarray`, never substituted for the runtime-owned F/I/top/status arrays. Their `NdT` checks are unchanged. The adapter's length/shape/stride checks do not make it a general arbitrary-buffer FFI API, and this review makes no preservation claim for manually passing readonly buffers to private generated entries.

## Installed-backend evidence and review hazards

Read installed `numba/np/arrayobj.py` around `impl_carray`, `get_cfarray_intrinsic`, `np_cfarray` and `populate_array`. A CPointer supplies the dtype; carray constructs shape/strides, bitcasts the data pointer and populates an array with null meminfo and parent. This is borrowed, unmanaged storage. It preserves ndarray indexing semantics that a wholesale direct-pointer indexing rewrite could accidentally change. Actual emitted LLVM must still be inspected, rather than assuming every temporary descriptor is optimized away.

Specific actual-patch checks:

1. Intrinsic typing admits only the intended ndarray forms and returns a correctly typed data pointer. It introduces no `noalias`, readonly or ownership assertion. F/I aliasing must remain legal even with distinct element-pointer types.
2. Both F and I views use the exact common arena length; top/status use four/one. Length uses the backend's pointer-sized integer convention without narrowing. Existing negative-index normalization, optional/nullable tuple behavior and checked helpers remain unchanged.
3. The source rewrite updates every generated internal definition and call, including direct self recursion, entry recursion, SCC merged functions, thin SCC wrappers and specialized helpers. It does not route an internal recursive call back through the public array adapter, or accidentally transform runtime math/RNG/ndarray helper APIs.
4. The wrapper keeps the entry name and public AOT export signature; the renamed internal entry participates in recursion normally. Function names cannot collide with generated locals, helpers or SCC names. Repeated compilation must not accumulate wrappers or change stable source/digests.
5. Source/hash identity incorporates the pointer intrinsic and all rewritten code. AOT reuse and disk-cache reload must be validated in fresh processes; a JIT-only fixture is insufficient evidence for actual selected Barnes AOT.
6. `lift.py`'s existing `_refcounts_unneeded` declines calls whose return types contain NRT-managed data. New carray producers may cause it to decline where it previously removed refcounts. Null meminfo may let LLVM eliminate these operations; check actual native LLVM for new NRT/allocator work instead of assuming either outcome. This is an investigation target, not an established bug.
7. Growth, failure/rollback, recursion limit, aliases, ndarray views and RNG need meaningful existing/focused native controls. Product return tags and all public numeric semantics remain unchanged. Unsupported optional transformation paths must retain ordinary eligibility rather than silently introducing a new fallback category.

## Required later evidence and comparison limits

Inspect the actual frozen candidate digest/export PE selected by successful Barnes AOT audits. Follow wrapper-to-entry-to-recursive-force calls and retain artifact/tool/source hashes. Compare against current product `9ff4908`, not the earlier pre-proof product. Quantify scoped static instruction lines, stack-operand lines, outgoing argument slots, frame reservation, retained exactness references, result tags and field/child layout. Do not convert those static values or earlier Python profile call counts into dynamic traffic/cycle percentages.

Use fresh current/candidate/C timing under the root-owned study protocol, with ordinary timing separate from phase instrumentation. Existing C uses a narrower node/index/two-output-pointer force call, specialized theta 0.5, different fixed layout/lifetime choices and `-march=native`; RP's generic AOT target remains a comparison limitation. A compact ABI does not by itself remove those differences, numeric tags/checks, shared status/depth tracking, heap handle loads or Python boundary work.

Initial verdict: **design is plausible within the existing internal buffer invariants; actual implementation and native evidence pending.** No concrete design unsoundness found so far. Risks above were sent to root and implementer before code review.

## Initial actual patch review

Read the initial `_borrow_heap_context` transform, `_BORROWED_HEAP` intrinsic and compile integration in the implementer worktree. No concrete semantic finding in this diff:

- Each post-merge generated definition is renamed consistently; calls to those exact generated names replace their four array arguments with the five borrowed values. Ordinary runtime helpers are outside the rename map. Direct self/entry recursion and merged SCC names therefore use the same internal convention.
- Original `info.name` remains the public lookup/export name. The appended adapter retains four ndarray parameters and original semantic scalars, checks dimensions, lengths and strides before extracting any pointers, and forwards to the renamed entry.
- Shape assumptions are explicitly defended for direct adapter calls, including an empty status buffer. No noalias or ownership attribute is introduced by `_heap_data`.
- Decorator spelling is retained because `_plain` and disk-cache rewriting depend on it. Generated intrinsic text and transformed source contribute to normal digest/cache identity. `_Gen` overwrites `info.source` during ordinary settlement on repeated compilation, so the new per-info source assignment does not itself accumulate wrappers.
- The first focused fixture inspects the actual internal dispatcher signature and LLVM, with four CPointer values, int64 length and two semantic scalars. Its public dispatcher retains four arrays. The test checks the native definition for NRT refcount/allocation remnants, rather than treating a signature-text rewrite as backend proof.

Expanded SCC/nullable/growth/rollback/fresh-AOT/cache controls and the frozen full run remain pending. Existing tests that inspected the old public dispatcher's body must follow the new internal dispatcher to continue validating field-index and numeric-proof code generation. Actual Barnes AOT evidence remains separate from fixture LLVM.

Reviewed the subsequent conservative activation gate: `any(info.recursive for info in self.order)` controls both AST rewriting and inclusion of the borrowed-view intrinsic. `mark_recursive()` computes self-reachability in the settled specialized call graph, covering direct and mutual recursion; all functions inside an activated region still use one internal convention. Wholly nonrecursive regions keep their existing generated bodies. This is a sound scope reduction and avoids unnecessary adapter/code-generation work in unrelated programs; source digest changes due to the compiler source change remain intentional.

Read expanded tests for repeated compile/source identity, SCC/default arguments, shared aliases/negative indices/nullable tuple payloads, arena growth followed by reborrow, rollback/exactly-once Python effects, recursion-limit fallback and fresh-process AOT reuse for four fixtures with both loaders. Requested recursive ndarray-overlap/rollback and random.Random coverage specifically because nonrecursive existing cases no longer exercise the new path. Final recorded results and fresh JIT cache-linking control remain to be reviewed.

Read the additional recursive NumPy and random-state tests and logs: overlapping negative-stride views are restored after an explicit failed native attempt, then updated exactly once by Python fallback; Random state crosses twist boundaries, matches ordinary Python and is unchanged by a failed native attempt. Recorded boundary run: four passed in 3.19 seconds. The fresh-process disk-cache recursion control recorded one pass in 4.32 seconds. Main focused final log records 56 tests and 14 subtests passed in 36.61 seconds before the added boundary cases.

One concrete evidence precision issue was reported before freeze: `fixture-native` initially selects `program.entry.name + '_borrowed'`, but its retained LLVM is outer specialized caller `f0_recursive_sum_borrowed`, which calls `f1_recursive_sum_borrowed`. The compact argument list is directly visible, but a no-NRT assertion limited to f0's first LLVM definition does not independently check the self-recursive helper. Requested selection of actual `info.recursive` dispatchers (or all compiled borrowed functions), plus a recursive call-target check. This is a fixture/evidence correction, not a product correctness finding; the full run need not be interrupted for it.

## Final frozen implementation and validation verdict

Read the complete `5d0fe52..a033ca14c40afed052a6266a0a575f6cc11559ea` diff: only `heap.py` (+73/-1) and the 339-line focused test file. The final product is the reviewed transform with conservative recursion activation; no product edits followed the native/full runs. Worker status was clean. Independently checked final file SHA256 values against `wave7-validation/abi-manifest.json`:

- `heap.py`: `38b77af3e77c73b132db4d973242eb30e8cbc590003b7cb9820e7430c9b3edd6`.
- Final focused test file: `fb63b694ec7fd9009b3cb9e98c78f8206b546cebeec904f7a3f36d4cea9d7533`.

Full recorded run: **465 tests and 52 subtests passed in 282.91 seconds**, with 22 known-category warnings. The actual-recursive fixture assertion was strengthened afterward, with product bytes unchanged; its affected test then passed in 1.26 seconds. The manifest explicitly distinguishes the full-run test-file hash from the final targeted test-file hash. It does not claim the post-refinement test bytes underwent another full suite.

The evidence precision issue is closed. Read `fixture-native-precision-final/report.json`, symbol-bound definitions and the final test: all compiled borrowed dispatchers are checked individually; actual recursive `f1_recursive_sum` has two machine-IR self calls, four typed pointers plus one length plus two semantic scalars, no surviving NRT ownership/allocation calls in its definition, and no F/I noalias attributes. The public adapter still takes four arrays. A first evidence matcher failed on LLVM numeric SSA suffixes; the final matcher accepts those suffixes, and both the failed partial evidence and corrected result are retained. This was a validation-script issue, not a product defect.

**Production code verdict: clear / ready to integrate. No unresolved actionable correctness, lifetime, aliasing, recursion-linking or validation-provenance finding.** This verdict covers the supported Region-owned writable buffer contract. It makes no arbitrary private-buffer API claim and no workload-speed claim. Actual selected Barnes AOT structure and fresh current/candidate/C results remain separately required evidence.

## Actual selected Barnes AOT and completed study review

Completed `wave7-instructions/REPORT.md` with full disassembly, scoped excerpts, static counts, tool/artifact/plan/audit hashes and independent `verification.json`. Selected candidate SHA256 `76a7b0c2a9475553633ed9aa1621d27bdb4af76abdd3e5cbfeb2b5b37f6ea564` matches the frozen inventory; selected current baseline is the earlier zero-fact product's `94afcc7b...` artifact. Both static wrapper mappings match independently supplied runtime maps, and the candidate chain follows wrapper `0x1800011d0` to array adapter `0x180001090`, borrowed advance `0x1800025d0`, then recursive force `0x180002c30`. No measured native artifact was imported or executed by this reviewer.

Actual force structure: outgoing stack argument slots **29 to six at each of four self-call sites**; static instruction lines **524 to 341**; stack-operand lines **275 to 69**; local reservation **488 to 280 bytes**. Six exact-coordinate-bound references remain; two double/two-kind-byte results remain. The scoped force body calls only itself, with no newly introduced refcount-helper or heap-allocation call. C remains a separate narrower four-register interface, 116 static instructions, 22 stack-operand lines and 88-byte local reservation, with theta constant 0.5. Static structure is not a cycle attribution or pure-spill count.

Independently checked frozen artifact/assembly/plan/audit hashes, actual-mode counters, both complete 100-step numeric/type/alias comparisons and full initial/final vectors. All production state checks match plain Python without relaxed types. Three independent recursive generality controls also report valid outputs and eight successful AOT calls per source/case, zero JIT/fallback/rejected/unknown. Normalized `_region_seed.py` contents are equal despite retained LF/CRLF raw-byte/hash differences; the report explicitly records this nonsemantic difference instead of claiming only one raw source file differs.

Read all fresh kernel/wall sample vectors and recomputed medians/ratios: current **47.4918 ms**, candidate **35.8288 ms**, fresh C **9.115458 ms**. Observed kernel reduction is **24.558%**, speedup **1.32552x**, and candidate time is **3.93055x C** versus current **5.21003x C**. Five-sample kernel ranges do not overlap in this cohort; shared-host limitations remain. Instrumented warm native medians 30.6576/17.4821 ms are separately labeled and do not identify an exact component share. Cold selection 47.990/65.311 ms is one overlapping preparation timer per side, not isolated source-generation cost. No additional timing jobs were run.

**Completed code/artifact/study verdict: clear.** The actual binary demonstrates the requested narrower recursive convention and the retained unchanged-source cohort demonstrates an observed improvement. Numeric contracts, memory layout, lifetime and error handling were not silently relaxed. The report distinguishes the remaining C differences and makes no universal performance or Python-equivalence claim.
