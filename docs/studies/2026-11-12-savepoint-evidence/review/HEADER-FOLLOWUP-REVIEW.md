# Independent review: consistent validated list-header reads

New follow-up from frozen4116246 in wave8-header-fix. Preserve the prior411 implementation/evidence and native cohort. This is not a change to the earlier report's measured facts.

## Design verdict before implementation

The two exact sites are `_Gen.truth`'s `isinstance(kind, ListT)` branch (heap.py:3852) and `builtin_plain`'s len/ListT branch (4710 after the prior annotation). Both currently load `I[handle]` through signed physical indexing. Replace only that physical address with `physical_index(handle, True)` using the same validated-header proof already applied in index(). ArrT inherits ListT and shares the three-slot header. Keep result type/boolean comparison, temp emission and evaluation point unchanged.

No new representation, nullable handling, loop/effect analysis, noalias assertion, status removal, field/numeric relaxation or header cache is required. Headers are nonnegative complete allocations from the validated loaders/checked constructors, and length lives in offset0. Other truth/len implementations (objects, strings, dicts/sets, NdT, optional values) keep their existing paths. The helper changes only the address annotation, not the stored signed length value.

The actual411 Barnes binary proves the missed consistency opportunity: len uses an adjusted signed address, while subsequent checked indexing uses the direct unsigned address. LLVM cannot reuse the first predicate to eliminate the second bounds check. Giving the same proven address to both reads can enable ordinary backend sharing. A call/mutation between reads must still invalidate any stale value through the existing aliasing/effect model; this change must introduce no frontend caching or invalid alias metadata.

## Meaningful checks

* Actual compiled len==1→[0] and truth→[0] bodies should lose physical shape normalization and the redundant subscript-failure path. This directly covers the observed Barnes pattern; dynamic-index-only fixtures do not prove that sharing.
* Dynamic index after len/truth must retain necessary logical bounds and negative-index normalization when the predicate does not prove the requested position safe.
* Mutate/pop/append through an alias between predicate and indexing; observe the current header, including shrink-to-invalid transactional fallback. Both loaders and empty lists; ArrT len/truth/read controls; preserved string/dict/set/NdT behavior.
* Fresh-process actual AOT selects the new body without JIT/Numba; new source/test freeze and full suite precede the new native cohort.

Source/proof design has no blocker. Actual diff and execution evidence pending. Reviewer has performed only read-only source and evidence inspection.

## Actual two-line diff and newly exposed independent issue

Read the actual two-line diff: only the stated ListT truth and len header addresses are annotated; emission/evaluation points and all other branches remain unchanged. No source finding in these annotations. Worker reports the constant-index LLVM fixture loses a redundant error path and both fixtures lose header shape normalization; full19-case validation is not green because the fresh-AOT mutating-alias test exposes an inherited loader/writeback defect. Do not change that training fixture to hide the failure or report19 passing cases.

Independently inspected Python `_Loader.list`, native `load_list`/`known`, `_seed`, `_Unloader.write_back` and retained baseline411 reproduction. An object reached through two previously distinct ListT contracts can become one live list on reuse. Both loaders return the known handle before validating the second contract. Only the first list-kind record reaches writeback, which skips unmutated cells. The native result sees the append but Python's caller list stays stale if the first contract is read-only and the second mutates. The baseline411 JSON records this on both loaders; it predates these header casts.

This is also a contract-validation boundary. Simply OR-ing mutation flags or writing every loaded list back is not established safe: warm distinct int/float list contracts can later alias, and the second known-handle shortcut can bypass its required element-layout validation. That incompatible-layout example is source-derived here, not a reviewer-executed reproduction.

Recommended bounded policy for coordinator consideration: reject the cached/seeded native program before entry when the same live list identity is visited under different canonical `_find(kind.cell)` contracts. Preserve same-contract alias/cycle reuse; let ordinary reseeding or Python fallback handle changed contracts. Do not mutate the frozen compiler's cell graph or re-encode an already-loaded block. Guard both Python and native recursive loaders; a top-level-only check misses aliases inside object fields/nested lists. The native c_kind descriptor already includes the canonical cell token at index3. An efficient per-load contract map is preferable to repeatedly scanning loader.lists; any native extension call/interface change must handle an older built extension conservatively.

Required additional evidence for such a remedy: warm distinct then aliased, and reverse ordering; first contract read-only versus mutating; incompatible int/float and tuple/object layouts; compatible same-root aliases and cycles remain native; both loaders and actual AOT; native-entry counting proves rejection happens before unsafe code; exact once-only state/effects on fallback. No loader remedy is approved or implemented by this review note; coordinator owns scope and a separate frozen validation round.

## Final source review at the requested savepoint

The subsequently authorized safety repair is separate commit0a8b1768324af2092bd973baabae1409a1c01521, reviewed in ALIAS-CONTRACT-REVIEW.md. The two-line header change is separate commita9b59be60cdf568c8f6b63442e7efa88fd16fdd2 on top. Read the actual committed diff: exactly the two previously reviewed ListT/ArrT header reads opt into physical_index; no further emitter/runtime/container broadening. No actionable newly introduced source finding.

Read final19-case header result:19 passed in9.43s, exit0, unchanged inputs. Read combined controls:318 tests and16 subtests passed in202.71s, exit0, unchanged inputs. Corrected AOT expectations preserve the demonstrated guard behavior: a new incompatible live alias rejects the old specialization before native entry; same-contract aliases retain native execution. The original failing artifact/receipt remains preserved.

Actual JIT fixture captures bind to final source hash672ea7eee61ed5768d9e22750f713f0bafafb0a059c17ab4d6c172a8c697d2de. len==1→constant[0] loses the extra header load and item-error store (3→2 i64 loads,1→0 item-error stores); truth→dynamic index also has2 loads while retaining its signed logical comparison and item-error store. Both have no physical arena-shape normalization. These are fixture results, not final Barnes/raytrace AOT evidence or timings.

Independent read-only hashing verifies all58 frozen source/test/native-extension inputs, the completed header/combined receipt log hashes, and final fixture capture files. See header-savepoint-verification.json. Worktree is clean at a9b59be; _heap.pyd remains17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0. At this savepoint entry, the already-started full suite has no completion receipt; full validation is pending. No additional tests, builds, native/C study or performance jobs will be started tonight by reviewer.

## Completed full-suite receipt and final verdict

The pending suite subsequently completed: **572 tests plus52 subtests passed in336.93s,22 warnings, exit0**, with unchanged inputs. Independently read the raw completion output/receipt and verified its stdout/stderr hashes, full-suite input hashes and all58 frozen/current inputs using read-only file hashing. header-savepoint-verification.json now records the completed receipt hashb27373a09a194ee999a93427d2b608d56a999207f4d8cfb86f02102c1cfca0d3 and stdout hash39ead4c4d9809d45db5c0416229de29f1c0e55196107d338c87868b68c5b45f6.

**Final verdict: clear for4116246..a9b59be, including separately reviewed safety commit0a8b176 and the two header annotations.** No actionable newly introduced source finding remains. This is implementation/validation clearance, not a performance claim. No final-source native/C study, paired held-out performance rerun or further product/test execution was started. Savepoint complete; stop per user request.
