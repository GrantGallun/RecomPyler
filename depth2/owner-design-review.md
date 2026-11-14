# Independent design review: owner reuse and heap prerequisites

Reviewer: independent Codex subagent `range_review`, 2026-11-13.
Scope: proposed item 4 direct void copy-into rule, and proof sufficiency for items 2 and 3. Read current `lift.py`, `facts.py`, constructor checks and float-observability checks in `heap.py`, and the earlier scalar-replacement design. This is an independent design review, not evidence that any of these items is implemented, deployed or faster. Only source generation and short AST/Python reference checks were used. No native build, full suite, timing cohort, product edit or allocation benchmark was run.

## Item 4: conditional approval of the narrow owner rule

The proposed transformation is sound within a restricted, explicitly guarded domain: an existing copy-reuse site whose target has a dominating live private owner; the old target is dead as a Python list; no live iterator or captured method refers to the old identity; source and target have stable, equal exact lengths; and their construction/content provenance fixes the same native element kind. Under these conditions replacing `if copy_fits: copy_into else: target=copy(source)` with a void `copy_into(target,source)` removes an unreachable rebind branch. It retains the ordinary initial allocations and Numba's ordinary ownership cleanup rather than suppressing releases.

The proof obligations belong to the particular copy site. Having names in global `array_extents` or `permutations` is not sufficient without the existing definite-assignment and reuse eligibility checks and the FunctionFacts guards. Both source and target must be initialized on the executing path, and the target's earlier unconditional initialization must dominate this site. Preserve the iterator exclusion. Keep `_rc_copy_into`'s exact same-dimensionality and dtype overload condition: equal numeric categories alone would be insufficient.

For the current narrow closure, permutation provenance is useful beyond range information. Step-one `list(range(...))` seeds int64 storage, full copies preserve that kind, and admitted rotations/reversals preserve elements and length. The source and target therefore cannot silently switch between float and integer buffers. This excludes a broader optimization of arbitrary equal-length private lists, which would require a separate kind proof. If this rule is catalogued as R4, its declared requirements should include F1 as well as F2 and F3, because equal stable extents are an essential premise.

### Concrete hidden-owner blocker found and resolved

The initial current implementation admitted this example:

```python
def f():
    p = list(range(2))
    q = list(range(2))
    ins = p.insert
    pop = p.pop
    p = q[:]
    ins(0, pop(1))
    return p[0]
```

Python returns `0`: the captured bound methods mutate the previous list, while the newly rebound `p` stays `[0,1]`. Full `_Unit.define` source generation originally admitted it, erased the method assignments, copied into the existing `p` and emitted rotation of the current `p`, yielding `1` by inspection. This was an existing copy-reuse/provenance hole, not a new consequence of removing a branch.

The ordinary `_Rewriter.method_alias` rejection did not initially save this case: fixed-array aliases returned `Pass` earlier in `visit_Assign` and bypassed it. The implementer has now added a `_fixed_lists` exclusion for captured-method bases with more than one store. I independently reran the exact full source-generation example after that edit: it now declines with `'ins' refers to a method of 'p', which is rebound`. This blocker is resolved in the reviewed source. Preserve that exclusion in the proposed owner rule.

### Earlier checked failures and malformed shape cases

Unchecked void copying must be safe even if an earlier helper has set status; deferred replay is not a bounds proof. Within the restricted current permutation closure, I found no remaining admitted constructor-failure example after the item 1 fixes: constructor bound arithmetic is checked transitively for int64 safety, exact local lengths require bounded nonnegative extents under entry guards, only step-one ranges seed permutation provenance, and copies preserve valid physical extents. An unrelated prior failure does not resize these buffers. A checked rotation either declines before changing contents or preserves size. An admitted prefix reversal likewise preserves size; the earlier parameter-prefix and negative-prefix holes are excluded.

These exclusions must be tested directly when implementing the rule:

- Negative extents, an empty descending range, unsafe constructor-bound arithmetic, or a zero-step range: retain checks or fail the fast guard; never infer a valid larger buffer from a failure sentinel.
- Float/list-repeat initialization, a foreign element store, arbitrary self-slice assignment, or a copy from an invalidated source: retain the old copy path when kind or shape provenance is lost.
- Branch-only initialization and a read before initialization: do not create a reusable owner from global metadata.
- A loop iterating the old target, captured method aliases across rebind, an escaped list or an unknown call receiving the list: decline reuse unless that hidden reference has independently been proved dead.
- Self-copy of a private unobserved list is safe as an in-place no-op; observing the newly allocated identity must remain excluded by F2.
- Ordinary return, break, checked fallback and native error exits: keep normal ownership cleanup, with no leak or double release.

No unresolved concrete design blocker remains for this narrow rule after the captured-method correction. Implementation still needs source/native validation that no array-return/rebind ownership operations remain at the targeted sites. This one rewrite does not prove that every owner operation disappears from every hot loop: range/full reinitialization helpers and other owner-returning sites need their own accounting. Report that granularity and achieved time against the owner rung rather than relabelling this subset as complete liveness.

## Item 2: constructor-only F2 is insufficient for lifetime scalar replacement

The currently recorded F2 answer is explicitly `constructor-only`. It concerns publication of `self` while fields are initialized. It does not prove that an instance created later in the region never escapes, remains unaliased, has no observable identity, or can cross a call without being materialized.

For example, a class with only `self.x=x` in its constructor satisfies that constructor check, but `c=Cell(1); return [c,c]` exposes both the object and its shared identity. Another example is `c=Cell(1); alias=identity_helper(c); alias.x=2; return c.x`: a virtual representation must propagate the alias through the helper and make the update visible. Constructors with identical pure initialization can also produce objects placed into surviving records, returned through recursive calls, compared with `is`, or passed to code with unknown effects. Constructor-only F2 cannot distinguish any of these from a field-only temporary.

A sound restricted first pass is possible without conditional materialization: prove all uses local and supported, then decline the entire allocation candidate if any call, escape, uncertain merge or identity-sensitive operation is encountered. That is additional allocation/use analysis, not a consequence of current constructor F2. Fully inlining a bounded call graph before that analysis could substitute for summaries on those inlined calls, but the existing merged/recursive region graph is not generally reduced to that case.

The brief's cross-call and recursive temporary coverage requires a lifetime/alias fixed point or equivalent summaries, stable virtual identities and field phis, and either materialization at escaping uses or an explicit conservative decline of those whole candidates. The current constructor fact alone cannot justify removing arena allocations, object headers or growth checks. The earlier scalar-replacement design identifies these missing proofs accurately. A report may describe this as unbuilt with the missing proof named; it must not claim constructor F2 has already established nonescape for whole lifetimes.

## Item 3: floats_unseen is insufficient for fixed-kind specialization

`floats_unseen` is an observability fact for the existing optimization. It asks whether a float/mixed result or mutated aggregate is handed back to Python and whether mixed kind is used internally. It does not prove that a particular value is always float, that all instances sharing a class field have one kind, or that integer intermediates stay exact after conversion.

The existing `fast_mixed` path still checks every relevant result against the exact-integer threshold and still handles division and error behavior. Those checks are part of its correctness argument. Removing tags and those checks needs a stronger range/kind proof, not just the same observability answer.

A small counterexample to treating hidden integer values as unchecked float values is:

```python
def f(flag):
    x = 9007199254740993
    if flag:
        x = 0.0
    return x == 9007199254740992
```

The integer path returns false; rounding that path to float before comparison can return true, even though the observable result is only a boolean. Profiling the float branch does not prove the other branch's kind, and a guard on the boolean input's type alone would not select a safe branch. The entry guard must establish the actual kind/value conditions that determine the specialized path, or the integer path must retain its exact representation and checks.

Likewise, a single class may have one allocation initialized with an integer field and another with a float field; a class-wide joined MIXED field is not evidence that either allocation's accesses can lose their tag. Later writes, aliases and call results must preserve the specialized kind. Signed zero, int-to-float conversion, nonzero divisors, overflow/error exits and exact expression order require independent treatment. The existing float-observability query does not answer those questions.

A sound narrow specialization may use existing definite FLOAT kinds, or guard the concrete determining inputs/fields and prove every subsequent defining write and use. Merely observing a field as float at entry is insufficient if an admitted later write can change its kind. Allocation/use-sensitive kinds or an equivalent conservative dataflow proof are needed for the broad MIXED-to-fixed rule. No item 3 product rule is established by the current F4 wrapper alone.

## Review outcome

The proposed restricted item 4 copy rewrite has a defensible proof after the captured-method exclusion, conditional on preserving all listed premises and normal cleanup. Items 2 and 3 cannot be justified solely by the current constructor-only F2 and float-observability F4 facts. They need the additional lifetime/alias and numeric kind/range analyses described above, or a clearly narrower decline-only subset with its reach measured. This review provides no timing, native deployment or scalar-replacement implementation claim.

## Refreshed item4 design/test review

Read depth2/item4-owner-design.md and tests/test_owner_liveness.py. The narrow direct-void-copy design remains conditionally sound under the earlier owner review's premises: per-site F1 exact equal stable physical extents, F2 private fixed same-kind arrays, F3 dominating initialized owner/dead old identity, and a copy-site F9 no-allocation/no-failure certificate. The source and target must match the overload's exact one-dimensional dtype condition, not merely both be numeric. Global permutation/extent membership is insufficient: source and target state must be valid at the actual copy statement. Keep all method-alias, iterator, escaped identity, arbitrary slice/reinitialization and uncertain-control exclusions.

The current _rc_copy_into helper ignores st, and register() supplies no generic status gate. An earlier informal reviewer message assumed otherwise; that assumption is explicitly corrected here. Shape/physical-buffer validity must therefore still hold when a previous checked helper has already set status. The old unrelated divide-before-copy test is useful because its already constructed arrays remain valid, but it is not proof that a failed bound-producing constructor or invalidated shape is safe. Preserve all transitive constructor/raw-emission prerequisites from item1. Do not bypass copy_fits for a malformed or failed source simply because a final symbolic name has an extent.

The proposed source assertions appropriately require a void call, no fits test, no owner rebind, and one R4 deployment report with F1/F2/F3/F9 declared. Unequal extent, foreign kind and branch-only initialization should retain conservative behavior; captured-method alias rebinding must continue to decline. Equal-length self-copy is safe only inside the same private/unobserved identity closure. Partial overlapping views or external array owners are not admitted by this proof.

The cleanup test covers ordinary return, early return, an error before copying and empty-index failure. Its listed n=0 cases do not demonstrate an actual nonnegative-extent guard miss. Requested n=-1/rounds0 as a small real miss, and optionally negative extent with a later index error; avoid a huge upper-bound allocation merely to test a miss. Keep existing invalid-constructor/range, iterator, slice-provenance and alias regressions in the focused union. The two NRT allocation balances are useful, while fast-loop native/LLVM evidence is still required to establish whether owner traffic actually disappears. A source void call alone does not prove every compiler refcount is eliminated.

**Design clearance remains conditional on these explicit premises; no item4 implementation is reviewed by this addendum.** Initial allocations and ordinary all-exit Numba cleanup must remain. F9 is copy-site failure freedom, not region failure freedom. No source change, native test, memory-stat loop or timing was performed by this reviewer for item4.
