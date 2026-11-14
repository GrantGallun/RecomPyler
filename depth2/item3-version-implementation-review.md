# Guarded numeric versions: independent implementation review

Reviewed numeric_versions.py, heap.py generation/cache hooks, Facts R7 declaration and focused tests after the parameter-lattice fix. **No unresolved concrete soundness blocker was found in the current reviewed implementation.** Source-level clearance supports freezing for the implementer's complete-output, native/AOT and development timing gates. It does not establish performance or final acceptance.

## Concrete blocker found and resolved

The first boolean folder omitted the entry definitions of parameters assigned later in the body. For `def f(flag): if flag:return 1; flag=True; return 2`, it could infer flag always True from the assignment and change the earlier input-dependent branch. This affects ordinary boolean parameters, independently of guarded MIXED tag substitution. Reported this blocker; the implementer now initializes every formal parameter as UNKNOWN and keeps that entry definition in the all-definitions meet. The added late_boolean regression exercises guarded field arithmetic with a later assignment to an ordinary bool parameter.

Independently rechecked the pure folder: the false-entry branch returns 2, a boolean expression containing a side-effecting call preserves that call, and a branch-assigned local joins both definitions. The implementation evaluates only boolean constants, names, not, and/or in this proof. Calls, subscripts, comparisons and numeric operations remain unknown to this folder; no floating-point algebra is performed. Only singleton boolean facts replace expressions or select branches.

## Guard and constructor contract

Actual generator metadata identifies MIXED tag reads and flattened scalar MIXED argument tags before scalar replacement. Speculative peek saves/restores that metadata. The eligibility hook retains real tags before scalar lowering when numeric versions may use them; existing observability-only fabricated True flags are explicitly rejected by the numeric-version pass.

Guard resolution accepts immutable formal tags or pure single-definition aliases. A scalar parameter with a Store is not substituted as an entry constant. Direct object tag guards require a nonnullable object formal, an attribute common to every permitted class, the exact canonical MIXED tag offset, field-readonly status, and no input mutation/identity effect. Nested child dereferences, unknown/internal values, nullable roots, missing-class attributes and unsupported expressions cannot become header field loads through this grammar. Thus guards execute before either body without dereferencing an unvalidated internal object or moving a throwing numeric computation ahead of the original function.

Field stability is conservative: a canonical MIXED field write blocks object-field versions. Constructor safety is checked separately because written_set excludes direct self writes in constructors. Raw constructor receiver rebinding is rejected; formal origins are propagated over the checked call graph, including base-constructor forwarding, and every constructor receiver must resolve to recorded allocations rather than an external/unknown receiver. Ordinary donor/child field writes remain visible to typed write tracking. The newly conservative Unsupported for explicit incoming-object reinitialization preserves Python behavior through replay and closes the reported prior native-writeback hole; it is not an unsafe numerical assumption.

A direct root constructor probe was admitted with x/y in written_set, so direct entry construction does not silently lose those writeback fields in the inspected case. Actual incoming-object constructor calls inside another function decline under the new provenance check. This distinguishes a safe entry writeback path from the reported excluded constructor-call shape.

## Fixed bodies and call graph

A version preserves the original machine ABI, return widths, checked arithmetic sequence and failure/status exits. Only certified input-tag uses become False; genuine internal integer-only definitions retain their flags and checks. Pure boolean propagation then eliminates exactness/zero-canonicalization branches only when their flag is proved False. Stored and returned float values retain False tags, and parameter-field update slots remain in their existing order. Integer guard misses execute the original checked body once; a previously executed body prefix is not replayed.

Forwarded guards are substituted through pure aliases, revalidated in the caller and compared with the caller's established requirement set. A fixed callee is called directly only when all its requirements are implied. Unknown producer expressions or rebound formals retain ordinary guarded entry. Function metadata is copied for fixed bodies, calls are rebuilt and recursive flags recomputed before the existing merge/context pass. Independently generated source resolves every _kf_ call to an emitted function.

Guard expressions are sorted in emitted wrappers and Facts answers; source/callee names remain deterministic. Both the heap runtime key and source digest include numeric_versions.py bytes, and generated wrapper/fixed bodies enter the source hash. The R7 declaration accurately requires F4 plus F5. No previous native module can be selected solely on a source identity that omits this new policy module.

## Independent lightweight evidence

Without a native build or timing cohort, independently checked:

- Three pure-folder cases covering the fixed parameter issue, side-effect retention and local branch joins.
- SourceOnly product and magnitude programs emit versions and closed direct-call graphs.
- Rebound scalar tags are not treated as immutable entry certificates.
- A later integer field store yields no version; input reinitialization declines to Python.
- The final possible() eligibility refinement preserves the existing local-only Triple path: fast_mixed remains true, no numeric versions are emitted and the three-payload fresh ABI is retained.

The implementer reports seven focused native tests and 38 tests in the focused union; those native results were not rerun by this reviewer. Full pixel/reference smoke, strict generic AOT and timed controls remain separate gates. Full-tag transport and same-width version ABI can affect performance even when the arithmetic proof is correct; no native gain is inferred from the observed tag percentages or this source clearance.


## Short-circuit folder follow-up

Reviewed the subsequent left-to-right short-circuit refinement. It returns a decisive constant only after all evaluated prefix operands have proved pure boolean facts; an unknown prefix stops evaluation before a later constant can erase it. Thus leading False-and-unknown and True-or-unknown simplify, while unknown-and-False and unknown-or-True retain the unknown expression and its effects. Formal parameter UNKNOWN seeding remains intact.

Independently executed six pure value/call-trace comparisons between original and folded functions, covering both leading decisive constants, both unknown-prefix cases, and True-and/False-or forwarding. All matched. No native compilation or heavy job was run. **This narrow follow-up is source-clear and introduces no remaining concrete blocker.** The implementer's eight reported native/pure passes are separate evidence.

## Decorator serialization follow-up

Reviewed the narrow serializer repair after the exact-header policy defect was reported. NumericVersions now saves the original source prefix before replacing the function body, clears the copied AST decorator_list, and prepends the identical prefix to both the guarded wrapper and fixed function. This preserves the exact _INLINED/_DECORATOR string contract used by _borrow_heap_context and _plain, and avoids duplicate decorators from ast.unparse. The original checked function metadata is not replaced before its prefix is read.

Independently generated product and magnitude programs with SourceOnly (no native compilation). Across five wrapper/fixed version pairs, both headers were canonical and identical, each parsed function had exactly one decorator, exact startswith recognition succeeded, and _plain converted every emitted header to the canonical ordinary decorator. This narrow serialization repair is source-clear; no remaining concrete blocker was found. The implementer's nine reported focused passes and the pending v3/base/tag-only/v2 performance ablation remain separate evidence; this review makes no timing or performance claim.

## Dominating boolean-load annihilator follow-up

Reviewed pure_bound_boolean and its use in the left-to-right BoolOp lattice. In the checked generated IR, the accepted Compare produces a primitive boolean. Its unique defining Assign must precede the enclosing use statement in the same body, orelse or finalbody list; parameters, multiply assigned names, unknown calls, forward reads and definitions confined to another branch do not receive this proof. The defining comparison remains in the output, so its effects/failures are not removed. Only the subsequent inert, already-bound boolean load may participate as {False, True}, allowing a later decisive False/True operand to fix the expression. An unproved prefix still stops evaluation.

This clearance relies on the existing checked primitive IR contract, not arbitrary Python rich-comparison results. Generated for targets use distinct fresh loop temporaries and explicit local Assigns; unbound source-local reads retain separate checked binding guards. No new generic Python comparison-purity claim is needed.

Independently ran the supplied pure regression and eleven primitive-IR cases: and/or positives, same-list orelse/finalbody positives, branch-only and forward-definition negatives, a formal parameter, ordinary rebinding, a cross-block use, a call prefix, and an effectful defining comparison. Values, exception classes and call traces matched before/after folding for both inputs in every case. No native compilation or heavy job was run. This narrow refinement is source-clear with no concrete remaining blocker found; the implementer's ten focused passes and any v4 performance confirmation remain separate gates.

## Immutable scalar conversion-certificate follow-up (CHECKPOINT 43)

Reviewed the shared entry-conversion extension, exact bound grammar, status-check collection, parameter resolution, inherited guards and updated F1/F4/F5 reporting. The new header copies the existing comparison against plus/minus 2**53; the fixed body substitutes that same resolved comparison only under a header establishing it False. It does not replace integer arithmetic with float arithmetic or infer an internal result kind. Multiple copied checks may therefore be removed without a stronger algebraic range claim. Rebound formals and unknown expressions decline; arena/status buffer formals are excluded explicitly.

Allowing scalar-only certificates in a mutating function is sound under this immutable primitive ABI: the argument comparison is inert and stable across arena writes. The header has no writes, and a miss executes the original body once, retaining its earlier mutation and checked failure order. Object-field guards continue to require global field stability, readonly effects and validated nonnullable offsets; constructors, generators and coroutines stay excluded. Forwarded fixed edges still require exact caller guard implication. Existing exact decorator preservation is retained.

Independently checked SourceOnly repeated_conversion: the wrapper guards both limits, its fixed body preserves the original field mutation and divisions while removing all three repeated bound-check pairs, and rebound_conversion emits no range version. Checked the accepted comparison operators/constants and rejected equality, another threshold, chained comparisons, nonconstants and booleans. Then executed the generated original checked body and generated guarded wrapper directly as ordinary Python, without Numba helpers/builds, at 0, 4, both +/-2**53 limits and both adjacent out-of-range integers. Return bits, full F/I arena bytes, status and top arrays matched in all six cases, including the mutation-before-failure misses.

No concrete remaining soundness blocker was found in this narrow extension; source-clear for freezing and the separate native/AOT/output/development gates. The implementer's 42 focused passes were reported separately and were not rerun by this reviewer. No native compilation or timing cohort was run here, and no performance claim follows from this review.

## Recursive numeric-wrapper return ABI correctness follow-up

Reviewed the required wrapper dispatch correction against the unchanged _merge_cycles/_Rewrite return packer. The width computation matches that packer's NONE/BOTTOM special case and _width(ret), including flattened payload/tag tuples. A void fixed call is now an Expr followed by bare Return, so rewriting a width-zero Return can no longer discard the call and its effects. A single-slot result keeps the existing Return(call) form. A multi-slot call executes once in tuple-unpacking Assign, then an explicit flat Tuple Return exposes every result slot to _Rewrite.visit_Return instead of nesting one tuple-valued call into a single packed slot. Locals are renamed by the existing Store-name scan during merging; the result-prefix collision loop avoids existing generated names. All failure/status state remains in the shared arrays and neither dispatch path inserts a second call or a status reset.

Independently generated the recursive mutating-void and recursive_nonzero four-slot fixtures with SourceOnly and captured the actual pre/post-merge sources. Every guarded fast dispatch contained exactly one fixed call, with the required Expr/Return or tuple-Assign/flat-Return shape. Executed their merged checked IR as ordinary Python with decorators removed and a valid positive recursion limit: the mutating fixture applied every recursive update (x=1 to x=4 for n=3), returned None and left clean status; recursive_nonzero returned the flat (2.5, False, 2.5, False) payload/tag ABI with clean status. The first local smoke setup used a zero recursion allowance and correctly triggered the existing depth failure; correcting the fixture allowance yielded the stated passes. No native compilation or timing job was run.

This targeted ABI repair is source-clear; no remaining concrete blocker was found in the reviewed change. The prior full suite failure is not treated as a passing final-source suite, and the implementer's native regressions/final acceptance remain separate gates. This is a correctness closure, not further R7 performance development.
