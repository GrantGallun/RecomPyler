# Held-out runtime overhead and repeated native address work

User intent: rerun the full held-out population against CPython on the latest compiler, measure successful native deployment, and fix the largest evidenced slowdowns. Compare actual native assembly with C to identify reusable redundant-work patterns while preserving Python behavior. Direct execution and agent collaboration are authorized by the ongoing request.

Current baseline is integration93986c89a5b512ef82a33af1f101bf6f796ae61f/producta033ca14. Initial study uses a separate exact-byte clean clone; the user's dirty checkout and all historical evidence remain untouched. Full-population denominators and workload configuration are unchanged. The parent WAVE8-PLAN.md records measurement phases, ownership and CPU gating.

The earlier broad held-out population executed no selected native work. All38plans had no recommendation or accepted batch site. That does not establish the new outcome; fresh profiles and actual-mode audits must measure it. Native assembly costs and unselected startup costs require separate attribution.

## Bounded runtime change

The runner currently parses the same saved plan twice on an unselected run and four times on a selected run. It imports AST/tokenization/decorator support even when no rewrite will occur. Use one parsed plan snapshot per run, private data-based selection helpers and compatible public path-based recommended/regional helpers. Delay rewrite-only imports until that path is used. Compile original source bytes on the plain path, letting Python handle encoding cookies, BOM and newline decoding. Retain main-module/argv/path restoration, SystemExit handling, report shape, default selection, force/batch rules and AOT budget safeguards. No global plan cache.

Alternative approaches considered: CLI exec handoff would change process/report behavior; globally caching plans would introduce invalidation/state concerns; lowering selection thresholds would deploy known slower tiny methods. The coordinator chooses the bounded per-run cleanup because it removes demonstrably unnecessary work without changing eligibility or the Python program. Its time contribution is not assumed to explain all historical overhead.

Meaningful controls: fresh process denying unused imports, exactly one plan read for both plain and selected paths, public helper compatibility, encoded-source output/filename/line behavior, SystemExit and global-state restoration, rejected batch sites, ordinary/region counters and AOT-only/force behavior. Malformed encoding follows Python's compiler error surface; do not promise the prior tokenizer's exact error wording.

## Native-address investigation

Retained raytrace and current Barnes code contain repeated signed normalization for list header/data physical addresses. Extend the existing object-field nonnegative-index proof only to `_Gen.index` header loads and its checked final element slot at subscript reads, augmented loads and the two `set_item` callers. Logical Python index normalization and bounds checks stay. Validated nonnullable ListT/ArrT headers and their finite allocated payloads prove these physical addresses nonnegative under the Region loader/allocation invariants. Cast final expressions after signed arithmetic. Tuple payload recursion deliberately drops the proof because a stored nullable tuple handle can still be -1. Do not change len/truth, strings, dicts, external NdT views or general runtime helpers. Exact independent proof is retained in the parent `wave8-assembly-analysis/LIST-INDEX-PROOF.md`; native code-generation regressions must fail before implementation.

The proof review exposed an inherited list augmented-assignment defect: a physical slot captured before the RHS can be stale after resizing. Capture the original base and original logical index once, check/load the initial value, evaluate RHS and arithmetic, then re-run checked indexing on that captured base/index before storing. Python's setter normalizes a negative index against the post-RHS length. Preserve evaluation order, original-base identity across rebinding, exceptions and transactional rollback. Use no speculative no-mutation shortcut. Keep this correctness repair distinct from the address annotation and verify expected native wrong-results/missing errors before changing it.

Required native controls include both loaders, int/float/object/tuple/nullable-tuple slots, byte-array overflow, negative/extreme/out-of-range indices, empty lists, alias growth/retry/cap exhaustion, positive and negative RHS resize, shrink-to-invalid exactly-once fallback and fresh AOT reuse. No FFT loop/status rewrite is included.

## Refinement from the first actual-AOT experiment

The first implementation at4116246 passed522tests+52subtests and its separate40-process native/C study. That study showed overlapping small kernel changes. Actual Barnes force code shrank341to339instruction lines: signed `len(list)` header addressing and unsigned checked indexing prevented LLVM from combining their loads and bounds reasoning. Ray rendering shrank1037to999lines; its whole-process time did not improve in that cohort. Preserve this measured source and all evidence.

Apply the identical validated-header proof at just two additional code-generation sites: `_Gen.truth`'s existing ListT branch and `builtin_plain`'s existing ListT `len` branch. ArrT inherits ListT. Emit the same header read through `physical_index(handle, True)` at its existing evaluation point. Add no caching, alias claims or motion across calls/mutations. Logical truth/length values and all other kinds remain unchanged. Strings, dictionaries, sets, NdT and runtime list helpers stay outside this extension.

Use a new exact-byte clone from411, fail-first native fixtures for length/truth followed by dynamic indexing, and both-loader controls for empty/negative/extreme/byte-array inputs and mutations between condition and access. Revalidate fresh AOT and the full suite on new frozen source. The prepared411paired manifest has no executed measurements and remains explicitly unused; the refined candidate receives new native/full-paired output directories and fresh comparisons. Never alter a completed measured source or retarget its manifest.

## Evidence required

Fail-first regressions, focused native/CLI checks, full suite on frozen product, fresh-process reuse and independent review precede final comparison. Initial full current/CPython measurements and a separate matched current/fixed cohort retain all raw failures, outputs, modes, profile costs and source/runtime/input/bytecode hashes. Native/C static counts are scoped to actual selected artifacts; they never substitute for runtime or cycle measurements. Final claims separate default coverage, process time, warm native time and cold preparation.
