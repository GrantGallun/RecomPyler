# Wave8 independent review log

## Before heap implementation

Read wave8-runtime-fix runner.py actual diff and all24 pending startup cases. No concrete source or fixture blocker. Public selectors and forced/legacy behavior remain; plan reads become one consistent per-run snapshot, with next-run replacement tested. Lazy AST construction preserves visitor behavior. Plain byte compilation intentionally follows Python's encoding parser. Tests cover fresh CLI/runner imports, selected source rewrite, path helper APIs, Latin1/BOM/CRLF/CR, syntax/runtime source locations, and interpreter-state restoration for normal/error/SystemExit exits. Execution evidence remains owned by implementer; only initial four-test red/green was reported at this review point.

Read pending test_heap_list_indices.py and test_heap_augassign.py, with heap.py still unchanged. No concrete fixture blocker. Native LLVM test selects the actual fndesc symbol and recursive borrowed dispatcher, requires a logical signed-index comparison and disallows arena-shape use other than recursive forwarding. This meaningfully distinguishes physical normalization from required Python indexing. Semantic fixtures cover both loaders, tuple absence, object identity/types, byte-range errors, alias growth/retry/exhaustion and fresh-process AOT counters/no Numba.

AugAssign tests distinguish positive relocation, negative renormalization without relocation, once-only base/index/RHS evaluation in123 order, original base capture before index/RHS rebinding, and shrink invalidating the later setter with transactional fallback. These are expected-red inherited correctness tests, separate from the annotation's machine-code regression. The tests support the bounded design documented in AUGASSIGN-FINDING.md and LIST-INDEX-PROOF.md; actual heap source and execution validation are still pending.

No compilation, test, profile or timing was run by this reviewer. No final implementation verdict is claimed before inspecting the actual patch and its evidence.

## Actual startup and AugAssign changes

Startup commit 0cbe452 preserves the reviewed source. Independently read startup-compatible/result.json and stdout: exit0, inputs_unchanged true,41 tests plus2 subtests passed in5.82s. No startup source finding.

Read actual AugAssign diff before its separate commit: base is materialized using copy_codes before index AST evaluation; original logical position is materialized before first index normalization. The initial item load remains checked. RHS/binop is evaluated, then result codes are materialized before a second checked index lookup against captured base/position, followed immediately by set_item. copy_codes emits fresh temps and preserves existing zero-fact metadata. No unsigned annotation is included in this correctness change. No actionable source finding.

Independently read augassign-red/result.json/stdout: exit1, inputs_unchanged true,12 expected failures and4 passing base-rebinding controls in7.75s. Failures show wrong visible values and a successful native attempt where post-shrink setter should fail. Read augassign-green/result.json/stdout: exit0, inputs_unchanged true, all16 passed in6.97s. These are worker executions inspected by reviewer, not independent reruns. Cleared the bounded correctness patch for its separate commit; overall final verdict awaits physical-index diff and frozen full-suite evidence.

## Actual physical-index annotation

AugAssign correctness commit is6ae250c1b6155d774121548c53c4d665c155aa90. Read the separate physical-index diff on top: index casts only list header/header+2 physical addresses, preserves signed logical normalization and failure unchanged, and still returns a signed data-plus-position temp. expr_Subscript and AugAssign checked outer item reads opt in through slot(nonnegative=True). set_item gains a conservative defaultFalse keyword; exactly two callers passTrue, both immediate index results. Its ordinary and ArrT stores propagate that explicit proof. TupT recursive payload slot/store code remains unchanged and signed. The five index call sites, including indexed pop, all receive validated ListT/ArrT headers. len/truth and runtime list helpers remain unchanged. No actionable source finding.

Independently read physical RED: four actual LLVM tests fail on arena-shape-dependent signed normalization,13 tests deselected,1.69s. GREEN: all17 passed in10.65s, exit0, inputs_unchanged true. Tests include actual selected dispatcher body inspection and fresh-process AOT both loaders/no Numba. These targeted results support the source proof; final whole-branch verdict still awaits frozen full-suite evidence. No timing gain is inferred from fixture machine-code changes.

## Final whole-branch verdict

**Clear: no actionable newly introduced correctness finding in93986c89a5b512ef82a33af1f101bf6f796ae61f..411624630f818bc548a3183e3a25cecf13116640.** Reviewed all three changes (startup, inherited AugAssign repair, physical-list-address annotation) as separate concerns and together. Worker worktree is clean at4116246. No product/test edits occurred after the freeze.

Independently read combined-focused evidence:158 tests plus16 subtests passed in82.97s, exit0, inputs_unchanged true. Full-suite evidence:522 tests plus52 subtests passed in303.00s,22 warnings, exit0. The warnings are existing Numba GPU occupancy/SSA categories; the suite receipt reports unchanged inputs. The reviewer additionally hashed all56 frozen source/test inputs and verified exact equality with full-suite input manifest and current worker bytes, plus stdout/stderr hashes against the receipt. See final-input-verification.json. Heap hash81e6a9a153a3da3adec8914dbf8e73b734da0d27149314cf2bbccd42aee2e106; runner hashc3fecf59d1ff65b689d4e6157a132efabac620e712c4e5b4dd545e3137235386.

Also inspected the external AOT probe source and retained child output. Existing frozen mutating-RHS fixtures ran under both loaders through counted actual export wrappers:10 native entries,8 successful AOT calls, zero JIT, and2 expected post-shrink setter-error fallbacks. Exact once-only effects/identity and original base/index evaluation controls passed; child asserts no Numba import. Independently verified probe input/artifact hashes and rows against child output. This external probe is additional evidence, not part of the522-test count, and no source/test files changed for it.

No reviewer heavy jobs or duplicate test runs were performed. This verdict covers implementation and validation, not a benchmark speed claim. Current/final workload AOT code and fresh timing comparisons remain separate forthcoming study evidence.
