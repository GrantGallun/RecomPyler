# RecomPyler savepoint — paused at the user's request

Work is saved and this agent team is stopped. The latest implementation is reviewed and validated; its final performance comparison has **not** run. Do not start work automatically overnight.

Latest product: `a9b59be60cdf568c8f6b63442e7efa88fd16fdd2` in `D:/Code/Datathon/recompyler-codex-20261111/wave8-header-fix`, branch `codex/wave8-header-consistency`. It is integrated into local `codex/integrated-coverage`. The user's current branch and working changes are preserved; nothing was pushed or merged into that current branch.

## Completed and verified

- Earlier compact recursive calls reduced Barnes kernel time **47.49 → 35.83 ms**, 24.6% less time / 1.326× speedup. Recursive stack arguments fell **29 → 6**, force instructions **524 → 341**. That workload measured 15.4× CPython kernel speed and approximately3.93× C time. See [the completed ABI study](2026-11-11-compact-abi.md).
- This wave reran all49 fixed workloads on the current939 baseline: **49 fresh profiles,490 timing processes,245 separate audits,98 warmups and1preflight** all passed. Root independently verified all883 process records, state/mode accounting, medians and frozen identities.
- The fixed38 held-out programs (37 meaningful timings) still selected **zero native calls**. Complete-process speed averaged **0.965119× CPython**, or **3.61% longer time**. Nine tuned workloads averaged **1.253317× CPython**, with four actually native: Barnes, fannkuch, raytrace and SciMark. Their timing runs recorded **2020 AOT calls, zero JIT/fallback**. Two bot/Go additions remain separate,0.987946× CPython / zero native. These are measured baseline results, not measurements of the final new code.
- Removed repeated saved-plan parsing and unused AST/tokenization startup on the common plain path, without changing default selection. Public selector APIs, force/batch rules, source encoding, errors and main/argv/path restoration are covered.
- Proved valid physical list/byte-array slot addresses nonnegative, preserving logical negative indices, bounds checks, nullable tuple sentinels and rollback. Made `len`/truth header accesses consistent so LLVM can reuse their bounds information. No workload-name special case or numeric-contract relaxation.
- Repaired list augmented assignment when its right-hand side resizes/rebinds a list: capture original base/index once, perform arithmetic, then reindex at the setter. Added guards against cached alias contracts losing writeback or reinterpreting data. Lists/byte arrays/dicts/sets validate canonical contracts; object classes and NumPy formats are validated before memo reuse. Matching aliases/cycles remain native; unsupported contracts can safely re-specialize or fall back.
- Rebuilt the guarded C loader only inside the isolated worker. New private capability `LOAD_CONTRACTS_VERSION=1`; older support binaries safely use guarded Python packing. The old measured source and binaries remain unchanged.

Latest full suite: **572 tests and52 subtests passed**,22 known-category warnings,336.93s. The31 safety checks,19 header checks and318 combined checks plus16 subtests also passed. All58 frozen source/test/native input hashes match before/after the final full run. Independent code, guard/API/refcount and evidence reviews are clear. No product/test edits followed the freeze.

Final support binary SHA256: `17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0`. It is copied byte-for-byte into the isolated integration checkout and retained in the checkpoint archive with its source and build receipt. Original user-checkout binaries were not replaced. The monitor binary is unchanged.

## What the latest measured assembly experiment did and did not establish

The first iteration at4116246 was measured separately against current939 and unchanged C, before the final header consistency and safety fixes:

| Warm diagnostic | Current ms | First411 ms | C ms |
|---|---:|---:|---:|
| Barnes |36.3475|36.2738|9.134054|
| Raytrace |3.9311|3.8272|0.604630|

All40 timing processes, four fresh profiles, six full-state audits and four address maps passed.5050 successful timing AOT calls and202 separate audit AOT calls had zero JIT/fallback. Barnes matched all100 numeric/type/alias checkpoints and full vectors; raytrace matched all30000 RGB bytes, types and mutable-array identity.

The ranges overlap: these0.20% /2.64% kernel changes do not establish a firm general speed gain. Raytrace complete-process time increased2.31%, retained honestly. Actual force instructions fell341→339, render1037→999. The matched RGB blocks removed six sign-shift and three conditional-move address adjustments, retaining logical checks/clamps.

The force result exposed a missed optimization: signed `len(list)` versus unsigned checked indexing prevented common-load/bounds elimination. The final two-line header refinement fixes that pattern in actual LLVM fixtures: two header/item loads replace three; the redundant constant-one item-error path disappears; dynamic logical bounds remain. **There is no new selected-workload AOT/C measurement on finala9b yet.** Never present411 timings or assembly as finala9b results.

## Remaining room and practical ceiling

Near-C speed is realistic for suitable stable numeric hot regions. Earlier numeric diagnostics reached about1.14× C time for nbody and1.40× for float; see [the earlier measured comparisons](2026-11-11-fresh-process-reuse.md). That does not establish default whole-program speed or universal support.

The object-rich references still show roughly4× C time for Barnes and6× for raytrace. Larger improvements need changes beyond a few address instructions:

1. Compile larger safe regions and keep state native across repeated calls. Earlier instrumented Barnes runs spent about9.84ms loading and3.59ms writing back per100 advances. Those diagnostic components are separate from headline timing and cannot simply be added/subtracted as guaranteed savings.
2. Eliminate nonescaping temporary object allocations and handle indirection; use more compact/direct layouts where identity, aliases and mutations permit it. C uses inline numeric records and byte buffers; the current heap model carries extra objects, slots and tags.
3. Improve type/range/escape proofs so numeric kind/exactness checks and error bookkeeping can be hoisted or removed safely. C's force routine still has116 static instructions against the measured339, with88B versus280B local stack reservation. Static counts are not cycle ratios.
4. Expand profitable entry-region coverage. Most held-out work remains outside selected native regions, or consists of tiny helpers whose conversion/startup cost exceeds their savings. More native instructions optimized inside already-selected kernels cannot fix that denominator.

There is no honest universal speedup forecast for arbitrary Python. Dynamic dispatch, aliases, exceptions, arbitrary-size integers, Python/library boundaries and IO have observable behavior that sometimes requires real work or fallback. The goal is guarded C-like hot paths wherever proofs permit them. CPU target differences also remain unmeasured: RP AOT is generic while the C references are host-tuned. The ports are reference implementations, not proof of optimal assembly.

## Evidence and exact resume point

The adjacent [checkpoint evidence index](2026-11-12-savepoint-evidence/archive-manifest.json) includes the exact compressed source/native/validation checkpoint, root verification receipts, independent reviews and compact measured reports. The archive has184 captured files plus its manifest; its SHA256 is `11430716ee10e137b2f463bd50ab46f1c7b6755b8c9573cb8e64564e500707f8`. Python fixtures inside the zip retain exact bytes; other source captures use `.py.txt` to avoid test discovery.

Complete raw studies are independently committed locally:

- `wave8-study`: initial current cohort8a082b2b968eaebfc5881064137f7dc02c2bfcef; unused411 preparation note b463c91690c101c106b8e67f59407770ab46b7d8. Initial archive3708 files /24,603,013 bytes. Seven planned AOT artifacts indicate availability; only four workloads actually deployed native code.
- `wave8-native`: first411 native experiment1f952f1dc4138c2d108e0f50ebb15f4dedeb94fb,329 files /4,124,469 bytes, four selected AOT binaries and58 process records.
- Parent `WAVE8-PLAN.md`, `STATUS.md`, `wave8-header-analysis/checkpoint-receipt.json` and the final root receipt retain local paths, hashes and stop state. No matching task-owned test/build/benchmark execution remains. Unrelated work elsewhere on the shared machine was left alone.

On a later explicit resume:

1. Read this checkpoint, parent WAVE8 ledger and the saved572-test outcome. Preserve cleana9b source, new guarded native binary and all measured939/411 snapshots. Do not rerun completed correctness or initial benchmark cohorts without a concrete new issue.
2. Prepare **new** native output `wave8-native/results-final` using `--final <absolute wave8-header-fix path> --final-commit a9b59be60cdf568c8f6b63442e7efa88fd16fdd2`. Run the frozen two-case current/final/C protocol after the root metadata/CPU gate. All four profiles and40 timing children are fresh, with full-state/mode audits; retain all samples and costs.
3. Prepare **new** `wave8-study/results-paired-final` using the same candidate path/hash, then run the fixed49 current/candidate/CPython protocol after a separate gate. Expected1423 records:98 profiles,735 timings,490 audits,98 warmups and2preflights. Do not pool old medians or force default held-out selection.
4. The old `results-paired` manifestcc7718 is **unused metadata only**, with zero executed profiles/timings/audits. Never resume it as the final candidate. Neither new final output directory existed at this savepoint.
5. Archive/verify new actual selected AOT/C code and results, write the final wave8 measurement report, and complete the remaining plan only after those comparisons. Latest code correctness is validated; its final coverage/speed result remains pending.

No new performance run, test, build or probe is authorized to start automatically from this saved note.
