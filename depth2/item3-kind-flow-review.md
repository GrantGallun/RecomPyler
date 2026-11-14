# Item 3 kind-flow/table independent review

Read the implemented tag-shadow capture, KindFlow, ConstantFlow, final/reviewed table analyzers, complete table JSON and filtered actual shadow sources. This is an analysis/prospective-specialization review. No product code, native build, timing cohort or workload was run or changed.

## Current outcome

**The original 30/70 table does not support S22.5 STOP.** Six additional applicable input-range candidates were omitted: f58_baseColourAt loads CheckerboardSurface.otherColour[0:3], then checks each integer component against both exactness bounds before converting it. A guard that each component is an int within the proposed F1 interval [-2**24,2**24], together with the no-write proof below, discharges all six comparisons. This is the same permitted input-range reasoning already credited for Barnes width/height. It raises the prospective ray count to 36/70, above half. The implementer acknowledged this and is proceeding with the guarded R7 path rather than closing on the incomplete candidate set.

## Verified implementation evidence

The analysis follows tag-preserving checked definitions rather than recovering kinds from fast-mixed literal True flags. Values, tag cells, call formals and returned components join monotonically; aliases and recursive calls are traversed. Allocation/input field origins are separated where the existing metadata permits, while compatible unresolved roots are conservatively unioned. Successful fixed-float decisions require one arithmetic operand's logical tag to be always False, not merely its native F representation. Integer constant evidence uses arbitrary Python integers and is separate from logical-kind flow.

Independently ran all six focused analyzer tests: separate sites/alias stores, recursive mutation, unknown-call invalidation, loop/call joins, 2**53+1 constants and signature isolation passed. Independently rebuilt the reviewed flow in memory from the stored shadow: ray has 70 unique nonempty comparison rows; each Barnes seed has 26. Aggregate statuses reconcile to 6 fixed-float / 24 range / 40 kept and 0 fixed-float / 12 range / 14 kept respectively, before the additional otherColour guards. Actual graphs report no unknown object-effect call. Normalizing only the shadow's additional virtual MIXED I-flag argument slots, every reachable accepted-fast context shape has a corresponding reachable shadow context shape. Emitted-but-unreachable originals and intentional guard-miss fallback are excluded from the fast-context proof requirement.

## Corrections found during review

1. The first analyzer classified every non-fabs predicate as an integer conversion, overriding the matched kind-flow evidence for Barnes's 14 arithmetic-result comparisons. This did not change these actual decisions: independently evaluating their shadow operations gives both integer and float possibilities in every reached context. The reviewed analyzer now identifies MIXED result checks from the matched operation result and retains actual L/R kind evidence, instead of reporting those rows as None-valued conversions.
2. Direct input object roots initially used observed distinct tokens, while child roots already joined compatible classes. In a general two-argument case, p.x=integer followed by a q.x read could falsely retain a float fact when runtime p is q and both entry type guards pass. The reviewed analyzer now unions compatible direct input roots too. The actual ray root classes are distinct Scene/Canvas and Barnes enters through a particle list, so the prior hole did not establish a changed actual table count; fixing the contract is still necessary.
3. The six otherColour conversions were genuine integer inputs but were not inherently unbounded: the candidate generator considered scalar entry parameters and missed determining field/tuple range guards. An arbitrary-int kept row is not a completed bound search when an applicable guarded input range can be stated and proved stable. This omission changes the S22 stopping decision.

## otherColour stability and guarded lowering

The actual captured f58 source loads an integer triple through the Surface field at offset 6; all six predicates check these direct loaded components. In the reviewed shadow flow, the input CheckerboardSurface binding cell at offset 6 has no store definitions, and the graph has no unknown object-effect call. The tuple's integer leaves are immutable. A typed store/call audit should record the family-normalized otherColour field as unwritten and exclude constructors that could reinitialize incoming Surface identities.

`written_set()` alone is insufficient for that last step: by definition it excludes direct self writes inside constructors, and an explicit call to an existing object's __init__ could change its field. In this actual graph the included constructors create Point/Vector/Ray objects, not Surface objects. Preserve that typed call/store audit as evidence, rather than relying on name matching or observed object identities. Guard every potentially reached CheckerboardSurface instance; do not assume list-contained objects are nonaliased.

A guard at the typed f58 function's entry is a sound scoped alternative to a once-per-render graph guard. Validate the existing native handle/type/nullable premises before guard loads; test the three integer bounds before either body executes; then select the fast body or the unchanged checked body. No already executed prefix may be replayed on guard miss. Keep the field/tuple stable through the selected fast body. Report per-function invocation frequency/cost rather than describing this as one root guard. Existing typed representation guarantees must cover the integer types; introducing an unsupported dynamic tuple kind must select ordinary eligibility/fallback.

## Scope of clearance

The corrected kind/constant-flow table is meaningful evidence, not a replacement for product specialization. Genuine joined integer/float producers may legitimately retain checks; unimplemented transfer functions may not be relabeled as genuine producers. The actual audited graph has no reported unknown object-effect calls, and the Barnes result predicates now expose their real mixed producers.

Generic extensions still need stronger tests/contracts: all potentially aliased direct/child inputs, new object shapes under a reused signature, unsupported casts/augmented definitions in constant analysis, and transitive effects of unknown calls. These prototypes must not silently become a general F4 emitter certificate outside their audited grammar. There is currently no deployed R7 gain, and none is claimed here.

**Required next step:** include the six field/tuple guards in the actual prospective table and implement/review the resulting guarded R7 subset, with full numeric-bit, threshold, failure and guard-miss tests. Do not invoke the fewer-than-half stop on the superseded 30/70 count. This review does not assert a timing benefit or acceptance result.


## S27 executed-weight addendum

Read S27, count_kind_comparisons.py and its log, the saved comparison weights, all-input-tag analyzer and weighted table. **S27's permitted stop is now supported for the reviewed prospective rule.** This supersedes the earlier static 36/70 build recommendation: the user's later steering expressly replaces the source-count halfway test with executed weight. No item-3 specialization or gain is deployed or claimed.

Independently reconstructed counter mapping from the immutable accepted-fast source and the corrected table. All 70 baseline comparison IDs are unique by `(original function, normalized predicate)`. All 151 static context labels are unique and match that saved accepted-fast source exactly. Every executed counter label belongs to this mapping; aggregating the 92 executed contexts yields each saved baseline row weight and the exact total 4,399,585. There is no unmapped predicate, missing baseline row or duplicate context label in this evidence.

| Prospective decision | Source comparisons | Executed comparisons |
|---|---:|---:|
| Fixed-float removable |6|75,999|
| Range-discharged, including otherColour guards |30|135,732|
| Kept |34|4,187,854|
| Total |70|4,399,585|

The corrected removable set is therefore 211,731 / 4,399,585 = **4.81252209% by executed weight**, well below S27's half threshold. This includes all six otherColour bounds candidates found in the prior review; omitting those no longer drives the stopping decision. The six fixed-float comparisons remain supported when every input MIXED tag is seeded with both integer and float possibilities, so this structural subset does not rely on the observed input-tag candidates still carried as advisory metadata.

### Counter and source equivalence

The transformer wraps each original Compare expression in a counter call returning the comparison's actual result. Normal Python short-circuiting therefore still determines whether each bound comparison executes; it does not increment both halves of a predicate eagerly. The hook evaluates the original comparison once and then increments its context counter when enabled. No arithmetic/check predicate is removed or replaced.

The off and on executions use separate deep copies of the same input. Both execute the same wrapped checked source, with counting disabled/enabled, require status zero, write results back through the normal unloader and compare complete pixel bytes against each other and an independent original Python render. The saved gate passes and both high-water marks equal 1,414,615 slots. The source/log show the shared lock acquisition/release for this existing run. I did not rerun the render or create another cohort.

The counter captures post-scalar, pre-recursion-merge checked sources; original-source identities are preserved through scalar_origin. Source wrappers/merging do not substitute an unrelated baseline body in this run. I also checked `git diff d86f4e3 -- src/recompyler/heap.py src/recompyler/scalar.py`: no difference. Thus these counts concern the accepted item-2 source with prospective item-3 decisions, not a silently specialized product. They count logical checked-IR predicate evaluations, not retired native instructions, machine time or comparisons surviving LLVM constant folding.

### Kept causes and limits

Independently summed the retained grouping:

- Field/call/constructor/accumulator joins: 28 comparisons, 4,141,855 evaluations. These include subtraction/cross/dot/intersection/reflection and Lambert accumulation. Actual integer producers include entry Point/Vector coordinate fields permitted by the MIXED signature, int-initialized constructor paths, integer operands and accumulators initialized at 0; float constructors/results also reach their shared handle/call contexts.
- Plot/colour scaling with a genuine integer possibility and no all-intermediate range certificate: 6 comparisons, 45,999 evaluations.
- Unfollowed call/container or observable-kind-only reasons: no rows credited to these causes in the actual graph; actual unknown object-effect calls remain empty.

Creation-site separation distinguishes int- and float-producing allocations. It does not prove that every occurrence in an existing shared consumer clone is float: retained handle children and formal/call joins still combine these origins, including input Points and freshly computed Points. The current table conservatively keeps a logical comparison when any reached consumer context retains the integer possibility. This is an analysis/representation scope limit, not a claim that Python forces every hot arithmetic operation to remain MIXED. Kind-context clones or integer-conditional range certificates are valid future candidates and would need a new proof/coverage table.

The stop applies to this measured workload and the completed conservative subset under S27. It is not a global upper bound on possible R7 gains, and 4.81% of source-level evaluated predicates is not a timing prediction. No separate Barnes timing cohort is justified for its entry-dimension conversions when ray's rule is stopped; this follows S27.4. Record zero deployed R7 reach/gain, retain the checked implementation and preserve the prospective table/counter evidence for a later, more precise rule.

## S29 supersedes the stopping decision

S29 arrived after the S27 weighted review above and replaces that stopping direction. The earlier S27 stop clearance is therefore **superseded, not the current instruction**. Its mapping/count/output-gate audit remains valid evidence, but item3 must continue with the requested observed-kind and per-entry guard-coverage investigation before any new closure decision.

The next evidence must count the actual logical operand tags for retained numeric operations even when the original integer-tag guard skips their exactness comparisons, and report the all-relevant-fields-float share at eligible function entry. Runtime observation can select a proposed guarded version; it is not itself a proof that entry fields determine every internal value or that a guard can safely read an allocation/call-produced value before it exists. No further instrument or product implementation is independently cleared by this note.


## S29 observed-kind and guarded-version design review

Read count_observed_kinds.py, its saved JSON/log, item3-observed-bound.md and item3-version-design.md. Independently summed all context observations: each of the28 baseline rows matches its prior operation weight, totaling4,141,855 operations. Counts reconcile to3,259,374 all-float,3,955,920 any-float and185,935 integer-only executions (78.69358%,95.51083%,4.48917%). On/off/reference full pixels and arena highwater match. No workload was rerun here.

The operation hook is inserted after the checked payload assignment and samples the already defined original operand tags before the tag-dependent exactness branch. It therefore includes float executions skipped by the full-tag integer-only guard. Mapping uses semantic source-operation keys, not fast-mixed temporary names, and asserts exactly one matched operation and a found payload assignment per selected context. This is appropriate observation evidence for deciding which guarded versions to build.

Entry statistics require explicit scope labels. The sr17 colourAt context has no eligible entry tag expressions: its100% is vacuous, not proof about its callees or internal values. Dot uses three unique tags in its shared-alias clone and six in the other/original contexts; aggregate72.54% is valid, but six is not every clone's guard width. Intersection85.55% is a direct radius-tag statistic and does not establish nested subtraction/dot kinds. The bound document already distinguishes direct from transitive dependencies; retain these qualifications in the RESULT.

The proposed full-tag-then-scalar-then-version architecture is defensible. Existing fast-mixed fabricated tags must not seed guards. Keep ordinary MIXED bodies and ABI, selecting a float body before executing either body; guard miss executes the original checked body once. Replacing only certified input tags with False and folding only proved boolean branches preserves expression order and leaves genuine internal int-only producers checked. Writes/returns from a fixed-float path must carry False tags, including scalar field updates, without changing failure/status return widths.

Concrete obligations raised before implementation clearance:

1. **Mutable scalar parameters.** A MIXED value parameter is not inherently an immutable SSA definition in generated code. `def f(x): x=0; return x`, entered with a float, can assign its generated tag variable True in the body. Replacing every later Load of that same variable with False would return a float instead of an int. Substitute only parameters with no Store, or use reaching definitions/SSA entry facts that stop at rebinding. The float entry guard alone does not justify later reads after an integer assignment.
2. **Constructor receiver provenance.** A constructor called with a fresh arg0 can still execute `self=donor; self.x=0`. Syntactic self writes are excluded from written_set even after such rebinding. Inspect every constructor field-store receiver through aliases/rebindings, or decline that constructor/candidate. A fresh initial receiver is not a complete proof that every constructor write targets a fresh distinct object. Ordinary child/donor writes must also be checked. Explicit reinitialization of an incoming object remains excluded.
3. **Header dereference safety.** Every link in a guard's object/field address must be valid and nonnullable, with the attribute present for every permitted class, before reading the tag. A nonnullable outer parameter does not prove an optional child exists or that a polymorphic class has the field. A proportionate first implementation can limit guards to direct constant-offset MIXED fields of nonnullable, layout-certified parameters and immutable scalar tag arguments. Decline nullable/nested/internal requirements until a pure validated prologue is explicitly supported. Do not move an observable exception ahead of the original body.
4. **Direct fixed-call implication.** Reuse caller guards only after pure alias substitution proves every callee requirement, and only while those fields/SSA definitions remain stable. A recursive callee needs the same finite version identity and full checked ABI. An arbitrary numeric expression or freshly loaded unproved field is not a forwarding alias. Keep guarded ordinary entry when implication is unknown.

For the first implementation, the region-wide canonical MIXED-field write exclusion plus audited fresh-constructor stores is a safe conservative policy. Check family-normalized fields, unknown effects and every constructor receiver/store path; do not infer nonalias from observed identity. Preserve full tags on all checked paths participating in this region so fallback and downstream callees can inspect real kinds. The extra tag/guard transport cost requires the planned native measurement; observation percentages alone are not a gain estimate.

Fail-first source/native tests should include float entry plus integer parameter rebinding, int field guard miss,2**53+1 input, signed-zero/NaN/Inf bits, int-only result type, divide/domain/failure followed by a successful call, later alias field writes, explicit incoming __init__, fresh constructor with receiver rebinding, nullable/missing-class-field header reads, repeated direct fixed-call implication and signature/clone-cache isolation. An attempted source-only reproducer probe was deferred while heap.py temporarily imported the not-yet-created numeric_versions module; no product file was changed.

This clears the design direction conditional on these explicit obligations; it does **not** clear an implementation or a closure decision. S29's observed-kind/build direction remains active. The prior static-proof stopping discussion is historical only.
