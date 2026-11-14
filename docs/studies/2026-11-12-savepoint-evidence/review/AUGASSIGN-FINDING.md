# Inherited list augmented-assignment defect

Source-level finding against integration93986c89/producta033ca1, heap.py:5874–5878. No reproduction or native execution was run by this reviewer; the implementer is preparing a fail-first native/Python comparison for the coordinated CPU window.

The lowering computes `where = index(base, original_index)` and reads the current value before evaluating the RHS. It then evaluates the RHS and binary operation, and passes the old physical `where` to `set_item`. That is wrong when the RHS changes the list's length or data block. Python saves the original container and original logical index, but performs the eventual store against their state after the RHS/in-place operation.

Concrete supported-shape example: start with `xs = [10]`; a helper appends 99 and returns 5; evaluate `xs[0] += helper(xs)`. A freshly loaded list has capacity equal to length. Append grows its data block, so the native old physical slot is no longer the current list element. Python expects `[15, 99]`; this lowering writes the old allocation and can leave the current list `[10, 99]`. For `xs[-1] += helper(xs)`, Python expects `[10, 15]`: the setter normalizes -1 against the new length. Reusing even a non-relocated old slot is wrong. Shrinking can make the setter raise where the getter was valid.

## Bounded repair

Within the ListT branch of `do_AugAssign` only:

1. Evaluate and capture the base once, before evaluating the index expression. Preserve its actual handle even if later expressions mutate/rebind references.
2. Evaluate and capture the original logical index once. Do not cache only its normalized position. Materialize mutable generated code expressions into temporaries before the RHS.
3. Use the existing checked indexing to read the initial value, including all presence/type/negative-index/bounds checks.
4. Evaluate the RHS and binary operation in the existing order, with existing failure/status behavior.
5. Re-run checked indexing using the captured original base and original logical index, now reading the current list header/data/length, and store the result there.

The existing `index` method can be called twice with captured values; do not evaluate the AST index expression twice. No broad alias analysis or unproved no-resize shortcut is necessary for the correctness repair. A future effect proof could avoid the second lookup for proven nonmutating RHS operations, but that is separate work.

The physical-index annotation proposal remains independently valid: the old allocation is still nonnegative and allocated. Address validity is not logical Python assignment correctness. Keep the repair and annotation separate in tests/description so a speed improvement does not hide this inherited defect.

## Required regressions

Actual native/Python comparisons, both loaders: positive index with forced append relocation; negative index after append with spare capacity as well as relocation; shrink/pop causing post-RHS IndexError; single evaluation of a side-effecting base/index expression; alias identity and exactly-once effects across fallback/growth retry; unchanged scalar RHS behavior. Record red expected native wrong-result/error behavior before fixing, then green with actual compiled-call/mode counters. Preserve nullable tuple and byte-array store controls from LIST-INDEX-PROOF.md.
