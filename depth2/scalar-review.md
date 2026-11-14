# Independent review of scalar fields and field-passing clones

Reviewer: independent Codex subagent `range_review`, 2026-11-13.
Scope: `src/recompyler/scalar.py`, its current heap compile hook and metadata/cache integration, and relevant escape-summary refinements. Only class a is enabled in the product hook reviewed here. Class b was exercised separately through source-only construction; that did not enable it in the product. This review makes no timing or native deployment claim.

No native compilation, AOT build, full suite, timing job or product edit was performed. Independently ran the scalar source-test class, small generated-source checks and plain-Python interpretation of one transformed checked-IR example. This review file is the only filesystem edit for this delegated task.

## Class-a conclusion

**No concrete admitted class-a semantic blocker was found.** Source-level review clears the current class-a implementation to proceed to its RESULT using the implementer's separate native correctness, full-pixel, allocation-removal and measurement evidence. Those results were not rerun by this reviewer.

The pass does more than trust an allocation label. It maps a selected allocation and its aliases to one virtual field set, rejects mixed/unknown origins, verifies single-definition dominance for every tracked alias, and rejects every remaining pointer Name use outside the admitted grammar. Unsupported arithmetic aliases, aggregate bindings, unknown pointer calls and addresses outside the exact field-slot grammar therefore decline rather than silently losing identity.

The dominance restriction is conservative: an alias defined inside an iteration cannot be used before that definition on the next iteration or after leaving its defining block. It blocks the previously raised previous-instance/loop-overlap case. Parameters may not be rebound in clones. Allocation-site tokens alone are not used as permission to overwrite a live previous dynamic instance.

Exact memory-space/offset matching is the appropriate F/I boundary. A virtual slot is rewritten only when the source access matches that slot's declared space and offset; mismatched F/I accesses, polymorphic headers and unknown offsets decline. This does not introduce a noalias promise between the arena's F and I views.

Construction becomes scalar initialization followed by a constructor field-passing clone. Existing checked arithmetic, type/exactness checks, status tests and failure returns remain in source. Child allocations and all unselected allocations retain ordinary arena operations. No manual reference-count suppression is introduced.

## Field representation clarification

`virtual()` intentionally permits complete one-slot handle fields as unchanged integer arena handles, alongside numeric fields. The Ray eye object has such Point/Vector fields. Removing the outer object's slots need not remove or alter the children's identities: the scalar field still carries the original child's handle, and subsequent accesses/mutations of that child use the ordinary arena machinery. I found no concrete unsafe admitted handle kind from this choice.

The design should therefore say **complete native field slots, including unchanged child handles**, rather than numeric-only fields. This is not scalar replacement of the child object. MIXED fields preserve both their F payload and I tag; optional numeric representations and unsupported multi-slot fields decline. Polymorphic record layouts decline. Tests should retain a parent-with-shared-child case so future expansion does not confuse carrying a handle with virtualizing its referent.

## Field-passing clone and alias review

The caller identifies every tracked virtual argument, groups identical virtual identities, and passes one field set for an aliased group. Formal parameters belonging to the same group map to the same `Virtual`, so mutation through one formal is visible when reading another. Distinct virtual identities obtain distinct groups. The clone returns its original scalar result followed by all updated field slots, and the caller writes those updates into the original virtual field variables.

An exact returned-parameter alias is supported only when all possible returned aliases refer to the same tracked group and the successful result is nonnullable. Fresh, unknown, nullable and ambiguous returned object origins decline. A returned alias is not reconstructed as an independent field copy. This is a defensible conservative boundary for a/b development; it does not establish class c materialization.

Failure paths return the same original dummy/result ABI plus the current field updates, with the original status flag still governing replay. Fully virtual fields are initialized before entering a clone, so an early failure does not require reading an uninitialized update value. The source keeps checks after calls and original recursion depth/status handling.

No concrete admitted clone semantic blocker was found in the inspected paths. The disabled-b machinery is source-review ready for native development tests; this is not acceptance of class b's native results or permission to treat a/b counts as deployed allocation removal.

## Independent source checks

1. Ran `test_scalar_fields.ScalarSourceTests`: **2 passed, 1 skipped**. The skipped test is the deliberately disabled class-b source test. The tests confirm local aliases use scalar fields while identity observation, conditional escape and failure-related escaping objects retain handles.

2. Built a small checked program without invoking `compile()` or Numba, selected class b manually in the in-process source transformer, and verified each clone's emitted arguments equal `heap._params(info)`. The program passes the same object as both parameters of a mutating reader, then returns a parameter alias through recursive calls. Constructor, reader and recursive clones have consistent result/update widths.

3. Built a mutually recursive exact-alias version. Interpreted the unmerged transformed checked Python with ordinary integer helper stand-ins and no native compiler. Shared-argument mutation plus three recursive updates returned **11**, matching the original Python result **11**, with status clear. Then ran the existing SCC merger and shared heap-context source transformer; the two SCC groups and all resulting context functions parsed successfully. This checks source wiring and ordinary arithmetic only; the helper stand-ins do not constitute overflow, floating-point or native ABI validation.

The standalone examples used temporary in-process source mappings for dynamic reference functions and restored `inspect.getsource` afterward. They did not create product files or alter the enabled class set.

## Metadata, recursion and cache integration

Clones are added beside original handle functions. The pass emits only clones reachable from accepted transformed bodies, rejects failed reachable clones, rebuilds call edges over originals plus clones, and recomputes recursive membership. Clone parameter kinds and result widths are represented in the existing metadata shape used by the SCC merger and heap-context machinery. The source checks above exercised both exact alias returns and mutual recursion through that shared path.

`scalar.py` is included in heap runtime and source/AOT cache digests. Escape summaries are constructed from final checked generation before rewriting; the scalar consumer applies its own use validation rather than assuming that summary classification validates every use. A later compile starts by clearing facts and regenerating checked sources, so summaries/clones are not reused as if they described a different original ABI.

The constructor flag is currently based on `info.fn.__name__ == '__init__'`. A module-level function literally named `__init__` could consequently be counted as a constructor edge in allocation classes. The scalar emitter still clones any affected call and validates effects, so I did not establish a semantic failure from this naming issue; classification/reporting should eventually use actual constructor-role metadata rather than the name alone.

## Remaining acceptance checks and limits

- Before enabling b for accepted results, run native shared-alias mutation, two distinct virtual objects, exact returned aliases and recursive/mutual-recursive cases; inspect actual AOT/merged ABI rather than relying on source parse alone.
- Exercise checked overflow, division/bounds failure after scalar writes, recursion-limit replay and materialized allocation growth. Test complete outputs and preserved Python replay/error behavior.
- Exercise complete MIXED payload/tag behavior, signed zero/NaN and a parent holding shared child handles. Do not infer bit identity from the plain-Python integer example.
- Count removal in the emitted reachable program. A clone is built from the original checked callee source, so local sites eliminated in the original handle function need not also be eliminated in that clone. Static `removed_sites` entries alone do not establish dynamic bump removal.
- Preserve the distinction between a/b eligibility, accepted rewritten sites, dynamically removed allocations and measured gain. The reported ray class-a one-bump reduction is a narrow result; source inspection does not turn it into a resolved speedup.

No unresolved concrete class-a blocker remains from this review. Class-b source wiring passed the targeted independent checks, with native acceptance work still required. Fresh-return and path-escape materialization remain separate unreviewed implementations.

## a+b enablement addendum

The product hook has subsequently enabled `classes=('a','b')`, and clone metadata now includes `scalar_origin` for mapping retained allocation sites back to their original checked function. I inspected these follow-up edits. The provenance attribute does not alter the emitted clone ABI or field semantics. It supports the required reachable-source allocation accounting; it is not itself proof of dynamic removal.

Independently reran the current `ScalarSourceTests` after enablement: **3 tests passed, none skipped**. The source checks now require a shared-parameter clone as well as local scalarization and escape/identity exclusions. The implementer has also strengthened the native test to require actual selected removal sites for local aliases, shared arguments, distinct objects and recursive aliases; the reported native 18-test result was not rerun by this reviewer.

**Independent source-level a+b review is clear: no unresolved concrete soundness blocker was found in the reviewed implementation.** This supersedes the earlier disabled-b scope statements. The earlier plain-Python execution and recursive/SCC/ABI checks remain applicable. Product acceptance still requires the implementer's actual allocation-removal/full-output and native behavior gates. Class c fresh-return cloning and materialization are not covered by this clearance and require a separate design and implementation review.

## Disjoint fresh/nonvirtual handle-return addendum

Reviewed the subsequent narrow clone-return change. An object-returning clone now preserves the original handle result when its returned-parameter aliases are disjoint from the actual virtual parameter positions and its return is not unknown. Only a result that aliases an actual virtual parameter uses the existing exact-alias stripping path; mixed fresh/virtual and ambiguous virtual returns still decline.

**No concrete soundness blocker was found for this change.** Every actual argument aliasing a tracked virtual input is included in the virtual parameter mapping, so a returned nonvirtual parameter cannot silently be that same virtual identity. A fresh result that captures the virtual input is excluded by the parameter capture effect. Fresh results containing unchanged child handles are compatible with preserving those children's ordinary arena identity. Unknown returned origins still decline. Fresh/nullable handles and checked failure `-1` values retain the ordinary original handle ABI, with updated virtual fields appended.

Independently generated the `fresh_reader`/`fresh_while_passing` source through the SourceOnly path. The reader clone retains its `alloc`, constructor call and every checked status exit. Successful return is `(fresh_handle, updated_field)` and failed return is `(-1, updated_field)`; emitted arguments match `_params(info)` and tuple widths match clone result metadata. Reran the lightweight scalar source-test class: **3 passed**. No native compile or allocation benchmark was run.

This clears the narrow a/b consumer improvement at source-review level. It does **not** enable or review class-c allocation removal: the fresh result in the inspected clone remains arena allocated. The implementer's new native regression and full-output/removal gates remain separate evidence.

## S25 source-only check and ABI audit

Compared immutable premerge originals in `depth2/escape-sources-v4/Scene-render/` with the actually measured `depth2/product-artifacts-v2/raytrace/scalar-ab-v2/r0.generated.py`. For recursive clones, compared the selected merged body (selector 2 for `sr1`, selector 3 for `sr5`), not just the small wrapper. Normalization removed SCC local-name prefixes, mapped Ray field loads to the corresponding scalar field names, and normalized known clone/borrowed call names.

**The six clone bodies preserve the exact original If-condition multisets.** There are no additional or missing exactness, tag, domain or status If tests in this comparison. Counts below are static source observations, not execution counts or timings.

| Clone / original | User machine arguments, original -> clone | Borrowed context arguments | Original -> clone If tests | Exactness If tests | Direct F/I stores, original -> clone | Original scalar result width -> clone result plus updates |
|---|---:|---:|---:|---:|---:|---:|
| sr0 / f10 Ray initializer | 3 -> 4 | 1 | 1 -> 1 | 0 -> 0 | 2 -> 0 | 0 -> 2 |
| sr1 / f30 rayColour | 2 -> 3 | 6 | 28 -> 28 | 6 -> 6 | 8 -> 8 | 6 -> 8 |
| sr2 / f32 sphere intersectionTime | 2 -> 3 | 1 | 9 -> 9 | 4 -> 4 | 0 -> 0 | 2 -> 4 |
| sr3 / f34 plane intersectionTime | 2 -> 3 | 1 | 3 -> 3 | 0 -> 0 | 0 -> 0 | 2 -> 4 |
| sr4 / f38 pointAtTime | 3 -> 4 | 1 | 2 -> 2 | 0 -> 0 | 0 -> 0 | 1 -> 3 |
| sr5 / f54 colourAt | 5 -> 6 | 6 | 25 -> 25 | 4 -> 4 | 0 -> 0 | 6 -> 8 |

A context count of 1 is `_heap_ctx`; 6 means that pointer plus the four raw arena/status pointers and heap length. These are explicit source ABI parameters; register assignment and actual stack spilling cannot be inferred from the table. The measured scalar-ab-v2 artifact directory contains source/rules/plan and a pyd, but no native assembly/LLVM dump, so actual spills were not independently established here. The diagnostic builds are collecting that separate evidence.

The scalarized Ray contributes **two unchanged child handles**, replacing one Ray handle. It does not expand a MIXED Ray field into payload/tag pairs. MIXED colour results already use six machine values; the clones append two Ray fields to those results. The transformed recursive group contains both original f30/f54 and sr1/sr5, with packed result widths 6+6+8+8=28 instead of the original pair's 6+6. That is a real source ABI/code-size expansion; it is not evidence by itself that it causes the regression.

The small original intersection/pointAtTime/initializer functions have `inline='always'` in the premerge source, while the corresponding newly emitted clones use plain `@njit(error_model='numpy')`. The scalar pass also resets transformed original bodies to that plain decorator. In the borrowed source this can change whether raw pointers are passed through an always-inlined helper or unpacked from context. Lost inlining, extra result packing and the larger recursive group are concrete hypotheses to test with the orchestrator's timed ablations; this review does not assign milliseconds or declare a cause.

Before/after examples from the measured source preserve arithmetic guards:

```python
# f32 sphere intersection, original
 t12 = t8 * t10
 if math.fabs(t12) >= 9007199254740992.0:
     st[0] = 1
     top[3] = 15000004
     return (0.0, False)

# sr2, same arithmetic/check; field updates appended to failure ABI
 t12 = t8 * t10
 if math.fabs(t12) >= 9007199254740992.0:
     st[0] = 1
     top[3] = 15000004
     return (0.0, False, v_sr0_I0, v_sr0_I1)
```

Ray field reads become scalar variables without redoing a new tag/exactness test:

```python
# original
 t2 = I[np.uint64(v_ray + 0)]
 t6 = I[np.uint64(v_ray + 1)]
# clone
 t2 = v_sr0_I0
 t6 = v_sr0_I1
```

The clone initializer writes its two scalar handle slots rather than the Ray's arena slots, but still calls `normalized`; the normalized Vector allocation remains materialized. `sr1` still has eight direct writes to scene/container bookkeeping, and both recursive clone bodies retain their own other arena allocations. Thus 'Ray fields are scalar' does not imply 'clone does no arena work'. Both original and cloned functions are emitted and there are handle and scalar call routes in the recursive group; an individual call selects one route, rather than executing both full bodies for the same call. Source presence alone does not prove both routes' dynamic proportions or the amount of native code surviving inlining.

S25's measured <=3.68 ms gate remains required before class-c implementation. The source audit answers the check-duplication question but cannot replace that timed shortfall investigation.

## Class-c fresh-return design review (not implementation clearance)

Read `depth2/item2-c-design.md`. The proposed caller-selected return clones and retained handle route have a defensible design. No fundamental defeating counterexample was found for the stated restricted design, provided the following are enforced in code and fail-first tests. Class c remains unimplemented/unreviewed at this checkpoint and paused behind S25.

1. A returned fresh instance needs a separate virtual identity for each producing call execution. Allocation-site origins are summary facts, not dynamic identities. Two equal-field calls must not share storage; an alias to a previous loop iteration must either retain the correct SSA instance or make that candidate decline. Forwarding the same fresh object through several return levels must preserve its identity rather than minting a new independent copy at each level.

2. All success and failure returns require one fixed complete field-slot ABI. A failure before construction must return explicitly typed inert slots rather than reading undefined fields; the status check must remain before every caller use. Keep current virtual-input updates separate from the fresh result slots, and preserve checked arithmetic, error order and all non-eliminated allocations/capacity checks. A nonzero status must not be converted into a successful all-zero object.

3. Recursive fresh-return chains need a finite clone key and a type/identity fixed point. The existing a/b exact-returned-parameter path does not establish fresh-return correctness. Reject nullable, polymorphic, unknown or mixed alias/fresh returns until explicitly implemented. A recursive consumer calling a nonrecursive fresh-return helper is a different case from forwarding a fresh object around a recursive return SCC; test both.

4. Choose the original handle call before emission when the caller may return/store/capture the result. Do not call the scalar return clone and then eagerly materialize/copy it on that path. The untouched handle route is a sound way to avoid adding materialization work, but it must retain the same operations and checked allocation order as the current accepted a/b route. Context-specific mandatory/optional clone candidates must be rolled back completely when validation fails, with no failed clone reachable from accepted source.

5. The site's global class does not establish every caller's context. The seven class-c counts are a useful scope map, while f21's globally escaping result may have some noncapturing caller contexts. Any such context-specific removal needs its own complete closed-use proof and actual dynamic accounting; do not credit every execution of that source site.

6. The f21 Vector returned through normalized and stored into Ray.direction is a real nesting boundary. The current scalar Ray still stores **a child arena handle**. Eliminating the Ray allocation does not remove the Vector. To remove that Vector while retaining the current representation, a caller must keep it independently virtual and pass scalar child fields all the way through every consumer; storing a virtual child into a real or handle-slot parent is an escape requiring the original handle route or a separately reviewed nested representation/materialization rule. The design correctly does not silently credit those 133,743 Vector allocations as removed.

The design's site table distinguishes the two-level reflectThrough forwarding chain from single-level consumers and from general rayColour recursion, and its seven dynamic counts sum to 319,199. These are baseline bump counts, not promised removal or time. Repeat-call identities, loop overlap, recursive factories, container/field escapes and arithmetic failure before return are necessary tests. Full pixels, actual reachable allocation removal and timed acceptance remain later work.

## cp28 a/b ABI and recursive-context rebuild review

Reviewed the current mutation-only clone result ABI, preserved decorator prefixes, complete-selection second lowering pass, and the subsequent conservative-decline fixes. Class c remains unimplemented and outside this clearance.

The mutation-only optimization initially exposed a concrete mismatch between the admitted address grammars: scalar lowering accepted `I[np.int64(p + 1)] = 7`, while escape mutation collection recorded offset zero. In a generated Pair/change/caller source experiment with only the setter's index casts changed in memory from unsigned to signed, the caller returned **2 instead of 7**, with status zero, after scalar replacement. This was an analyzer/emitter contract counterexample; it did not establish that the current heap generator emits that signed form for the measured program.

That blocker is closed in the reviewed source. Both address parsers now unwrap transparent `np.int64` and `np.uint64` casts before reading the offset. The regression covers signed and nested unsigned/signed forms at offset one. In addition, `Lower.lower` verifies that every rewritten parameter-field store belongs to the clone's returned update set. Its final Name(Store) scan includes tuple targets synthesized by nested clone calls, so an omitted OUTER mutation summary cannot silently drop a child's returned mutation. The deliberately corrupted nested summary regression now declines the candidate.

Aliased formal parameters contribute the union of their mutated slots to one shared virtual field set. Read-only slots remain clone inputs and are no longer appended as unchanged results; the readonly regression checks that its result metadata is only the ordinary integer result. Complete MIXED payload/tag slots and unchanged child handles retain their existing representation. Every return, including checked failure returns, uses the same reduced update ABI. Preserving the original generated decorator prefix for both originals and clones restores their existing inline policy without moving arithmetic or status checks.

The second pass rebuilds selected original bodies using the complete accepted-local map and independently validates candidate local removal in each clone context. This closes the specific recursive-consumer case in which an originally selected local allocation was reintroduced inside its clone and routed back through the handle SCC. Clone-local selection is conditional on the closed-use/dominance checks in that context; it is not assumed solely from the original function's acceptance.

A `CannotScalar` during the later rebuild now restores all original function sources, original order, the original call map, and original recursive flags. The rejected transformation reports no removed sites or emitted field clones. The source-only forced-second-phase-decline test compares the final checked source byte for byte against scalar replacement disabled and checks that no clone remains in program order. Inspection of `mark_recursive` confirms that its only per-function mutation is the saved recursive flag.

Independently reran only `test_scalar_fields.ScalarSourceTests` and `test_escape_facts` after these fixes: **22 tests passed in 0.091 s**. This includes nested missing-mutation decline, second-pass rollback, readonly return width, preserved inline policy, recursive clone-local removal, alias groups, and signed offset mutation collection. No native build, benchmark, timing cohort, or heavy job was run by this reviewer. The implementer's separate native/floating-edge/failure tests and allocation/full-pixel gates remain separate evidence.

**Independent source-level clearance: no unresolved concrete a/b soundness blocker was found in the current cp28 implementation.** This clears freezing the reviewed fix for its allocation and timed gates; it does not establish that the <=3.68 ms S25 gate passes or authorize class-c implementation before that gate.

## Class-c implementation independent review

Reviewed the first class-c implementation in `scalar.py` and its `heap.py` enablement after cp29. This review covers fresh-return field clones, not class-d materialization. The prior class-c design conditions above remain the review checklist.

**No unresolved concrete soundness blocker was found in the reviewed implementation.** The source-level implementation is clear for the implementer's AOT, actual-removal, full-output and timed gates. This is not a claim that those gates already pass.

Fresh-result identity is distinct per caller assignment target (`@call:function:variable`), rather than inherited from the callee's allocation-site summary. The local alias fixed point is recomputed using these Virtual instances and the current clone's formal groups. A variable joining two identities or a handle with a virtual identity declines. Single-definition and control-block dominance checks still prevent a previous loop iteration's object from being reused as the current virtual object. Separate calls with equal fields therefore have independent field sets, while direct aliases and exact parameter-alias returns continue to use one shared set.

The clone cache adds a finite fresh-return flag to the existing function/alias-shape/class key. A recursive request can refer to a building clone without inventing a new dynamic clone key; metadata, result slots and update ABI are established before lowering its body. Local return-producing allocations and forwarding calls are mandatory candidates in fresh-return clones. Optional nonescaping fresh calls are tried conservatively. A failed required producer makes that clone unavailable, so its caller retains the original handle form or the complete region transformation declines through the existing rollback path. Only reachable successful clones are emitted.

`fresh_class` requires an object return, one concrete returned class, no nullable result, no returned parameter aliases, no unknown returned origin, and at least one known fresh origin. Polymorphic and unsupported slot representations also decline in `virtual`. Successful fresh returns emit the complete ordered native field slots; checked `-1` failure returns emit explicitly typed zeros. Existing status checks are retained before caller use. Parameter-field updates remain appended separately and are checked by the direct and synthesized-store coverage validation. Complete MIXED payload/tag slots and unchanged child handles retain their ordinary meaning.

Fresh and original handle functions coexist. A caller whose result is returned/stored/captured or whose uses do not satisfy the closed grammar does not acquire a fresh virtual result; its original handle call remains. There is no post-hoc materialization or eager extra copy on that route. Keeping a child handle inside a scalarized parent does not virtualize that child: attempting to store a separately virtual child in an ordinary arena slot remains an unsupported pointer use and selects the handle route. This preserves the reviewed f21 normalized Vector/Ray.direction boundary.

Independently ran the source-only scalar/fresh test classes plus escape tests: **23 tests passed in 0.186 s**. Additionally generated checked source in memory for (1) a producer doing `Cell(1//x)`, (2) mutation of a virtual argument plus an unrelated fresh result, (3) a producer returning a direct alias followed by two independent caller results, and (4) mutually recursive fresh factories. All generated fresh clones successfully. The producer-failure clone retains its division/status check and returns `np.int64(0)` before initialization on failure, with another status check before successful field use. The mutual factory case emits two finite fresh clones. No files or product source were modified for these extra probes.

The initial existing `fresh_error` test divided in the caller before the producer call and did not cover failure slots inside a fresh-return clone. Raised this coverage gap to the implementer. They added producer-internal divide and overflow regressions, including replay followed by a successful compiled call; their reported native passes are separate evidence and were not rerun by this reviewer. No native build, timing cohort or heavy job was run here.

Static `removed_sites` remains the selected a/b allocation list; class-c scope is exposed by `fresh_return_clones`. Actual dynamic class-c removal must therefore come from the requested reachable source/counter measurement, not from assuming every globally fresh allocation site is eliminated in every caller context. Full pixels, identity/error behavior and the item acceptance timing remain required evidence.

## Fast-mixed unused-tag ABI proposal review

Reviewed the narrow proposed change to omit virtual MIXED I-flag slots only when `program.fast_mixed` is already true. **The proposal is sound at source-design level within that condition.** It relies on the existing accepted F4 proof and regenerated checked IR; it does not introduce a new claim that numeric kinds are unobservable.

In the existing fast-mixed generator, `slot(MIXED)` emits the F payload plus literal `True`, `store(MIXED)` emits only the F payload, and mixed arithmetic retains its exactness/status checks. F4 rejects observed kinds, including mixed list indices, and observable floating results/writeback. The proposed virtual ABI change therefore removes unused state that is already absent from the admitted checked field accesses. Actual I-tag loads/stores must still decline through the missing-slot closed memory grammar or cloned-write coverage.

This clearance requires preserving original arena/layout offsets and ordinary nonvirtual MIXED argument/result representation. It applies only to virtual field slots and their derived field-passing/fresh-result ABI, under `fast_mixed=True`. With `fast_mixed=False`, complete payload/tag slots remain mandatory. Requested a true-path three-MIXED-field result-width assertion, preservation of the existing false-path signed-zero/NaN/tag tests, and the F4 index exclusion case. Applied implementation and test evidence will be checked separately before freeze.

## Applied fast-mixed ABI and F5 cache addendum

Reviewed the applied one-line virtual-slot narrowing and the new `checked_lower` F5 cache. **No unresolved concrete soundness blocker was found in these changes.** The prior source-level a/b/c clearance remains applicable; allocation/output/timing gates remain separate.

The applied MIXED branch omits only its virtual I flag when `p.fast_mixed` is true. Original field offsets, arena layout and nonvirtual machine-value representation are unchanged. Missing-slot accesses still decline through the existing closed grammar. The new `triple_sum` source regression actually establishes fast-mixed generation, checks that all three fields are MIXED, and checks a three-field fresh result ABI. The observable mixed-value native regression now explicitly asserts fast-mixed is false before checking tag/type and signed-zero/NaN behavior.

The cache is sound under the current compiler lifecycle: checked original trees, summaries, field layouts and fast-mixed mode are fixed for one ScalarReplacer engine, and program generation clears Facts before creating that engine. Within an epoch, clone identities are never renumbered or deleted. The key distinguishes original versus clone context, selected local allocation tokens, formal alias groups/classes, and selected fresh-call targets. Those inputs determine the slot names and maps in this implementation. When the complete-local second pass resets clone identities, it also switches from epoch zero to epoch one and resets reporting state. A future lifecycle that reuses these F5 answers across new engines without clearing Facts would need a generation identifier; that is not the current path.

Cached successful answers contain immutable unparsed source strings rather than mutable ASTs. Each use reparses a fresh FunctionDef and rechecks reachable clone closure; unknown results conservatively decline. Building recursive clone references are completed/validated before reachable emission. The final accepted body is lowered again after clone-local selection so its fresh-site report corresponds to that body. Fired/blocked fresh-site reporting is metadata and does not replace dynamic removal accounting.

Independently ran the lightweight scalar/fresh source tests plus escape tests: **24 passed in 0.264 s**. Additional in-memory probes of shared alias mutation, true fast-mixed Triple fresh returns and recursive fresh factories exercised **17 cached F5 hits**. Both epochs were present, every proven value was a parseable source string, and every sr-prefixed call in complete emitted source resolved to an emitted function, including borrowed-context wrappers. No native build, full render, benchmark or timing cohort was run by this reviewer.

## Nested field offsets and discarded clone-result closure

Reviewed the two subsequent generated-shape fixes. **Both are source-clear; no unresolved concrete soundness blocker was found.** These changes close conservative/incorrect field-address handling and an unsupported discarded-result shape without changing the underlying numeric or failure semantics.

Both field-address decoders now accumulate each right-hand integer constant in a left-associated Add chain, unwrapping the same signed/unsigned transparent casts between additions. Thus the real tag address `np.uint64(v_self + 2 + 1)` consistently denotes offset three, rather than escape analysis recording offset one while scalar lowering declines its remaining base expression. Only a final simple Name base can be scalarized, and the resulting memory space/offset must exactly exist in that class's virtual slot map. Variable offsets, multiplication and a right-hand expression tree remain outside scalar's address grammar. Existing final rewritten-store coverage remains active. The strengthened fast-mixed-false regression now requires actual removal, so its complete payload/tag native checks cannot pass merely because scalar replacement declined.

An unused ordinary clone result is now bound to throwaway generated variables before appended mutation updates. The clone call still executes once; all ordinary result slots and update slots are destructured in the original order, and existing subsequent status checks remain in place. These new names begin `_sr_discard_`, disjoint from original generated user locals/arguments (`v_*`), temporaries (`t*`) and virtual field prefixes. They are never treated as object aliases or field storage. Ignoring a returned arena handle does not newly virtualize that object, and exact returned-virtual-parameter aliases continue through their existing stripped-result path.

Independently reran the lightweight scalar/fresh source and escape union: **26 tests passed in 0.276 s**. Added a separate in-memory generated-shape probe that turns the unused `mutate_and_read` assignment in `distinct_call` into a bare Expr. It scalarizes successfully and emits `(dummy_result, updated_field) = clone(...)`, retaining the mutation despite discarding the ordinary result. Also independently confirmed actual selected removal with fast-mixed false, both nested cast/constant forms resolving to offset three, and rejection of variable-offset, multiplied-base and right-add-tree expressions. No product/test file was edited and no native build or timing was run by this reviewer.
