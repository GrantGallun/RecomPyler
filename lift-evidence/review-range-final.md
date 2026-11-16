# Independent final S49 RangeT review

Reviewed 2026-11-14 against HEAD `85838ba1527373443b037a0bae53bb4408d132b7` plus the uncommitted three-file source diff. Disposition: **no remaining concrete correctness, security, ABI or regression blocker found in the reviewed RangeT change**. This closes this independent source-review gate; it does not stand in for the remaining matrix, held-out, union or acceptance-control gates.

## Scope and contract

Read the root lift brief, steering S42/S44/S45/S47/S49, the S47 timing revision, `S49-RANGE-DESIGN.md`, `review-range-s49-resume.md`, all of `git diff -- src`, and all three `tests/test_range_values*.py` files. Traced the adjacent kind join, signatures, scalar-entry classification, call/return packing, comparison, heap loading/unloading, and prepared/legacy metadata paths. Saved the inspected diff as `review-range-final-source.diff`.

Applied the amended S49 contract: only exact int/float/complex identity is exempt. Their type and value remain exact, including float bits. None/bool singleton identity and all other object ownership remain binding; numeric identity observers must decline. No numeric-identity-only complaint is a finding in this report. No Numba/backend changes or wave16 init-entry changes are present in the reviewed source diff.

I edited only review evidence. I did not modify source/tests, install packages, terminate processes, take a timing lock, or launch additional workers. Runtime evidence below is the parent's completed, source-sealed run, which I independently read and matched to the current files; I did not rerun it during this review.

## Prior blockers and final implementation

1. **Repeated-range escape:** `repeated` now refuses RangeT elements before list-fill allocation. The settle-time supported-kind check recursively forbids RangeT under list/dict/optional kinds, and tuple construction rejects it. `_slots`, generated `slot`/`store`/`box`, C-kind conversion, and public unloader paths add refusal defenses. The two repeated-range regressions assert fallback and preserve the shared range object inside the resulting list.
2. **Temporary-range ownership bypass:** `range_values_used` is set when a first-class constructor is emitted, even when no RangeT survives in a local or result kind. The extra settling pass applies whole-region nonnumeric refusal in this case. The temporary-only tuple-owner regression asserts the original tuple is returned through Python.
3. **Old direct-loop overflow:** direct range loops now pass their evaluated arguments through `range_value(..., first_class=False)` before iteration. This adds the signed-domain checks to both source orders of mixed old/new loops. `first_class=False` avoids unnecessarily imposing the new ownership restriction on the previously supported direct-loop kernels. Both directions of the INT_MIN/INT_MAX immediate-break regression are covered.

The flat range ABI is internally consistent: three signed integer machine values, width three, inert dummy `(0,0,1)`, and existing width-based coercion/call/return packing. Entry packing accepts only exact builtin ranges and checks current bounds using unbounded Python arithmetic before narrowing. Constructor lowering snapshots arguments eagerly, checks step zero/INT_MIN, and checks subtraction overflow plus INT_MIN span. Thus admitted Numba count arithmetic has signed magnitude at most INT_MAX. Fresh iterator construction on every loop preserves repeated iteration; its unused terminal addition cannot escape. Index normalization and bounds checks precede checked multiplication/addition; membership bounds checks precede checked subtraction/remainder. Unsupported operations and public range results are conservatively refused.

Prepared capture/restore uses the positive zero-payload `range` tag and `validate_core` checks its shape. The fresh-AOT test uses actual heap regions and prepared reload, verifies changed live range bounds, prepared hits and AOT counters, zero JIT calls and absence of a Numba import in the child. This is the relevant ABI evidence, unlike the historical scalar AOT test recipe.

The earlier optional legacy-seed recommendation remains nonblocking: `_region_seed.restore` accepts trailing parts on the new range tag, as the historical random tag does. I found no demonstrated correctness or security consequence on the sealed artifact path, and do not elevate this shape-hardening suggestion into an acceptance blocker.

## Verification inspected

`logs/range-s49-focused-final-v1.receipt.json` is complete: exit 0, `source_unchanged=true`, below-normal priority, maximum four workers. Its command runs exactly `test_range_values.py`, `test_range_values_review.py`, and `test_range_values_aot.py`. The associated stdout records **109 passed**. All six reviewed implementation/test files match both the before and after hashes in that receipt. Earlier green receipts describe earlier source versions and are not substituted for this final receipt.

No additional counterexample was found that requires a new parent-run probe. Broader integration results and performance remain outside this report; source edits after the following hashes require a new review of the delta.

## SHA-256 inputs

| File | SHA-256 |
|---|---|
| `src/recompyler/heap.py` | `a8cf5ff944267de51cf9641f792a1a89b09e82829570b0a75f593c09a1ee0372` |
| `src/recompyler/_prepared.py` | `01ef65c8b732da90442bef765c940f9f5e5e88e737cc3bde4d3d7bc416d8d480` |
| `src/recompyler/_region_seed.py` | `781fffaff6d4ab12ced702617458c92d777222ec33e4e924b30421d612cb2253` |
| `tests/test_range_values.py` | `15253133342cc4c3cde6d51b43d0583597698b131fb61001afd2cc938e836695` |
| `tests/test_range_values_aot.py` | `7ee6020a6b92ae018a1d7684a34b24fa0a6792c1470d1734270d888c9ffa341b` |
| `tests/test_range_values_review.py` | `cf000ebb8cee183779213184f1902ca33885e8b15df229c4c61b6f33dbbc720c` |
| `logs/range-s49-focused-final-v1.receipt.json` | `8bc55e047569f93fd86947148d55fa5673157417ca89c0d1a2031ceb1181c35c` |
| `logs/range-s49-focused-final-v1.stdout` | `fc0d7e9058da38209f4594c16c87b3b2ecb6e4413beef74a7f701af12c0769d5` |
| `review-range-final-source.diff` | `692fc88b2b890c3565fac531806c55f8ca32ba6b20580b57348128b3788cd071` |
