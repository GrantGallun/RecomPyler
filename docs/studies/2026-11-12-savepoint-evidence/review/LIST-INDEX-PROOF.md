# Bounded proposal: prove physical list addresses nonnegative

Read-only independent design review against integration 93986c89/product a033ca1. No product changes, compilation, tests or timing runs were performed for this proposal. The recommendation is a generated-source proof annotation, not a new representation or weakened Python check.

## Exact first patch scope

Use the existing `_Gen.physical_index(where, True)` and `slot/store(..., nonnegative=True)` machinery. Cast the final physical address expression, after signed arithmetic; do not cast logical indices or handle values. Update its documentation to distinguish the existing object proof from the new list proof.

1. `_Gen.index`, heap.py:3999–4016: read length through `I[physical_index(bc[0], True)]`; read data base through `I[physical_index(bc[0] + 2, True)]`. Retain the existing signed `at`, negative-index adjustment, and `fail(at < 0 or at >= size)` byte-for-byte in behavior. The returned temp remains a signed physical slot expression.
2. `expr_Subscript`, around 4168: the `where` returned by `index` certifies the outer item slot, so `slot(kind.elem, where, nonnegative=True)` is valid.
3. `do_AugAssign`, around 5876: the same annotation applies to the initial item load after `index`.
4. `set_item`, 5824–5840: both current callers (5804 and 5878) pass only a checked `index` result. The array('B') INT store and ordinary item store may therefore opt in. Document this precondition or pass an explicit keyword from these two callers; avoid making a generic store default unsigned. Keep the array byte-range check unchanged.

This small scope removes all three adjustments in a normal get/set: list-header length, header data pointer, and final item address. There is no need to change alloc/list_room/list_slice or general container operations in the first patch. Leave `len` at 4709 and ListT truth at 3852 unchanged this wave. Do not widen the patch to strings, dicts, NdT views, tuple payloads, or all raw I/F indexing.

## Proof and its limits

`ListT`/`ArrT` is nonnullable; nullable object and tuple handles are separate representations. Valid list expressions arise from validated loaders or checked list allocation. Python `_Loader.list` (6229 onward) writes a three-slot header `(length, capacity, data)` at a nonnegative arena handle; `_heap.c:168–207` does likewise and checks available capacity. Python-loaded blocks are checked against arena capacity before native entry at heap.py:6816 onward. The arena cap is MAX_SLOTS = 2**27. Generated list constructors check allocation status before exposing a result. Header offsets 0 and 2 therefore fit the arena and signed int64.

For an indexing operation, the existing `fail` exits the generated function immediately on invalid logical indices (3591 onward). Only success reaches the data-base read and item access. After normalization, `0 <= at < length <= capacity`; the current header points at an allocated data block of at least capacity slots. Thus `data + at` is nonnegative, in the arena, and cannot overflow int64. Casting this final expression changes only NumPy's otherwise unnecessary negative physical-index normalization.

The proof concerns an address, not the value stored there. A valid item slot can contain a negative object/tuple handle. `slot`'s TupT recursion deliberately drops the nonnegative annotation for speculative payload loads through a nullable tuple handle (3919 onward). Preserve that drop. The absence flag does not prevent eager payload expression evaluation. Never annotate those nested payloads just because the containing list slot is valid.

Aliased list append can relocate its data block while the header stays stable. Re-read length/base at the same existing points and introduce no cross-call or cross-mutation caching. The proposal does not change evaluation order or fix any inherited augmented-assignment mutation behavior. Allocated arena blocks are not freed mid-attempt, but that is not permission to reuse a stale logical length/base. Existing failed-attempt rollback, growth retry, and Python fallback remain mandatory.

This is a contract of generated code receiving Region-owned validated arenas, not arbitrary callers supplying corrupt F/I/header buffers. No new unsafe external API is proposed.

## Fail-first tests that distinguish this optimization

* A minimal `read(xs, i)` and `write(xs, i, value)` with a dynamic index, actual native LLVM selected by dispatcher symbol, must show the original logical normalization/bounds branch but no signed select/adjustment on the list handle, header+2 address, or checked final address. Before the patch these checks should fail. Do not globally ban signed comparisons: the logical checks are essential. Include a recursive fixture so inspection reaches the borrowed internal body rather than only the public adapter.
* Exercise integer, float, object-reference and tuple list slots, plus array('B') stores. Verify exact returned types, identity where supported, byte-range failures, and ordinary field/tag checks. Nullable tuple elements need an explicit false-presence path, not merely a nullable object-field test.
* With both Python and native loaders, test first/last/negative-valid indices, empty list, `-len-1`, `len`, INT64_MIN and INT64_MAX. Out-of-range calls must preserve exception kind and single visible mutation before fallback; never allow unsigned wrapping to access memory.
* Share one list through two arguments/object fields; grow through one alias, then access through the other. Force arena retry and cap exhaustion. Check result/alias identity, final values, and exactly one visible effect.
* Include compound assignment with an RHS helper that appends/resizes the same aliased list. Source review identified an inherited stale-slot defect; these separate correctness regressions are expected to fail before the repair described in AUGASSIGN-FINDING.md. The nonnegative annotation itself preserves the already-computed physical address and does not repair the setter's logical target. The old allocated slot remains nonnegative.
* Keep existing nullable tuple, missing/unbound object, negative ndarray stride and integer-overflow rollback regressions. These are controls against accidentally propagating unsigned annotation outside its proof.
* Fresh-process AOT reuse must hit the selected generated program under both loaders, with actual AOT/zero JIT counters and no Numba import; cached generated source identity must include the new annotation normally.

Existing negative-index, alias/growth and nullable/signed-path semantic controls should pass before and after the annotation. The machine-code regression is the meaningful fail-first optimization assertion. Newly identified RHS-resize/shrink augmented-assignment regressions are separate expected-red correctness tests and require the bounded semantic repair, not just this annotation. Root must grant the CPU window before running them.

## Actual native evidence motivating the scope

Retained raytrace `Scene.render` AOT: SHA256 ef001c5a6907ee2012dc3bb1d218dc4effc9cc8adedf4f86348d4f4c6c087b6b, selected digest 0ed2b2e934d6be111a7f709c78ab62e052e513796dcf3372079253dc4f72d035, export r0. Independent audit recorded five AOT successes, zero JIT/fallback. Static PE mapping finds wrapper 0x1800028b0 calling native entry 0x180001090. Full provenance and disassembly are adjacent.

In the inlined Canvas.plot red-channel store, 0x18000255a/255e computes the list-header sign correction, 258b–259d computes header+2 correction, and 25a9/25ad computes final physical-slot correction. The separate logical-index block 256e–2585 must remain. Green/blue stores repeat the pattern. This is historical Wave5 code, not a current timing or a new measurement. Current Wave7 compact Barnes AOT independently retains the same list pattern at 0x180002cb6 onward (wave7-instructions/candidate-force.asm), confirming the lowering opportunity survives the ABI work.

C raytrace uses direct byte stores at 0x140001a02, 1a1c and 1a39 after clamping. It also uses a different byte buffer/struct layout and compiler target. The proposed annotation removes redundant physical-address work; it does not turn the heap layout into C's layout, remove Python indexing semantics, or establish a numerical speedup. Static instruction counts are not a cycle tax.
