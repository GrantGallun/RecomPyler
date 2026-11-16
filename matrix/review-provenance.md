# Shared provenance independent review

Status: final independent neutral-source review approved at the hash below. Historical findings and corrections follow. Unicode capability acceptance remains pending.

Scope: S47 shared layer and S49 numeric exemption. The reviewer read the
neutral design, shared requests, corpus inventory, and existing text adapter.
The layer exposes conservative compile-scoped source facts; runtime layout,
callbacks, rooting, and durable AOT identity remain separate obligations.

## Required review checks

1. Original-source binding must include the analyzed AST itself. Existing
   analyze(fn, node) rebuilds the function source but accepts a separate node.
   Verifying fn then analyzing another node is unsound. Prefer owning parsing
   inside the binder and rejecting foreign sites. Decorators, dedent offsets,
   missing positions, nested code, and folded constants need evidence or
   decline. Constant origins use original code-index paths, never equality.
   Complex fingerprints need IEEE bytes for both components; repr loses NaNs.

2. Unknown means possibly aliasing every relevant external/unknown origin,
   not merely no equal descriptor. Overloaded operators may return an operand.
   Operation origins do not imply freshness. Assignment chains share an
   origin; two allocation sites outside loops may be distinct, but repeated
   execution of one loop site does not establish one dynamic instance.

3. Joins retain every incoming possibility, including implicit fallthrough,
   zero iterations, for targets, continue/break exits, skipped loop else.
   Unsupported try/finally, with, walrus, closures, and generators must not
   leave an apparently valid whole-function summary. Inner scope returns
   and stores must not accidentally become outer scope facts.

4. Escape is recursive through structural children of returned, stored,
   yielded, or call-passed aggregates. Unknown calls can retain every reachable
   object. Calls nested in expressions invalidate facts before subsequent
   siblings evaluate. External arguments/paths may alias until guards prove
   otherwise. Attribute paths do not prove descriptor-free reads or stable
   physical cells. Direct-store roots/topology/retirement stay with consumers.

5. Summary fields recursively contain only inert primitives/descriptors:
   no AST/function/namespace/class/default/closure object graph. Primitive
   IDs are not ownership witnesses after objects die: fresh resolution must
   pin a witnessed ancestor or otherwise reject recycled IDs. Formal
   substitution recurses through path bases, children, unions. Virtual field
   transfers remain unknown without a consumer-proven transfer.

6. Exact builtin int/float/complex identity is exempt. bool/subclasses are
   not exempt. Numeric value tests check type and IEEE bits for both complex
   components, signed zero and NaN payloads. In-region possible numeric
   identity observations decline, including transitive calls. Comparison
   against a proved singleton is allowed. Source alone cannot prove exact types.

## Concrete cases

Added provenance-cases/wave17-matrix-review.py with 22 functions documenting
alias/escape/CFG/identity obligations: dynamic allocation sites, shared and
distinct lists, external alias stores, callback invalidation between tuple
siblings, descriptors, overloaded operations, nested escape, S49 observations,
loop else, for targets, unsupported finally/walrus/closure, folded constants.
Each needs a sound answer or explicit decline in the frozen corpus receipt.
Source/AST mismatch and dependency-ID recycling need API-level tests.

## Existing adapter migration concerns

_text_owners.py retains namespace/builtin dicts and constant objects, assigns
numeric/counter producer tokens, and has a separate source dataflow. Namespace
retention and heuristics must not survive in neutral summaries. Per-call
materialization may resolve/pin current owners under guards. S49 removes
numeric tokens, while tuple/str/bytes and every other nonexempt result keep
exact selected/allocated identity obligations.

## Acceptance pending

Need implementation diff, fail-first output, focused tests covering every
shared corpus function, correction of review findings, and complete
frozen-source receipts before approving the standalone layer commit.


## Implementation review: blocking findings (first revision)

A single-process below-normal API probe against the first implementation
confirmed these six issues. This diagnostic is not a frozen acceptance receipt.
The corpus now has 26 reviewer functions, including four new direct witnesses.

1. joined_aggregate_escape returned valid=True, may_escape(argument(1))=False,
   may_escape(argument(2))=False. join drops both aggregate children, so neither
   returned child escapes according to the query. Preserve union child escape
   reachability without pretending the children have correlated indexes.
2. indirect_numeric_observation with callback FunctionType and x int returned
   identity_safe=True. Unknown callback can inspect the exact numeric child
   inside the tuple. Recursively inspect reachable actual descendants, and
   treat unknown descendant kinds as unsafe.
3. overloaded_add_selects_left returned may_escape(False) for both operands.
   Overloaded arithmetic can retain/return either operand or inspect identity.
   Operation descriptors are not fresh, but callback escape/effect/observation
   obligations are still unrecorded. Attribute/subscript and rich comparison
   operations need the same careful callback treatment or explicit decline.
4. annotation_without_value returned singleton None instead of argument(0).
   A local annotation without a value performs no assignment. This is a
   definite incorrect source fact, independent of runtime type policy.
5. mutable_children_after_call still returned child argument(1). The callback
   can mutate the list. Mutable structural facts must be invalidated, including
   aliases/nested mutable children, or summary use must explicitly decline.
6. repeated_while_observation returned identity_safe=True for FunctionType/int.
   The test is analyzed only before widening. On a later iteration the callback
   receives the numeric argument. Model repeated tests under widened state,
   or refuse this CFG before giving a whole-function identity certificate.

Current test_corpus_all_facts_or_decline asserts only valid OR reason. It does
not check any case's documented identity/escape/type facts and passes all six
wrong positive answers. Add explicit regressions and a corpus contract mapping
that distinguishes a proved fact from an unresolved answer; valid source parse
alone is not a passed provenance case.

Review result: blocked pending corrections and their independent re-review.

Second below-normal probe confirmed four additional positive-fact defects:

7. selected_structural_child_escape returns (a,)[0] but may_escape(a)=False.
   Element provenance loses structural child reachability. A path must preserve
   possible selected-child origins or conservatively escape/unknown them.
8. raised_argument_escape raises its argument to the caller, but may_escape
   for that argument is False. Exception propagation is an escape root too.
9. mutable_children_after_store certifies child a after value[0]=b. Invalidation
   is required for direct stores as well as arbitrary calls.
10. varargs_origin is misclassified as global args if that global exists.
    Bind variadic/keyword dictionaries correctly or explicitly refuse those
    signatures. The corpus also contains kwargs_origin for the paired case.

The reviewer corpus now has 31 functions. Conservative explicit declines are
acceptable for these shapes. Wrong facts are not made safe by absent consumer
integration. Additional binder hardening should include co_flags and verified
position correspondence, so a code.replace generator/coroutine or linetable
change cannot silently reuse a certificate for different execution behavior.

## Re-review of first corrections

The first corrections address union reachability, direct expression operators,
recursive aggregate observations, source flags/positions, annotations, and
variadic signatures. No acceptance yet: three more API probes failed:

11. subscript_key_observation(container, key) reports may_escape(key)=False
    and identity_safe=True for a custom container type and exact int key.
    __getitem__ may retain/return/observe key. Observe and escape index/slice
    operands as well as the receiver, unless a consumer supplies a typed proof.
12. augmented_operator_escape reports neither operand escaped and identity
    safe=True for custom left/exact-int right. AugAssign bypasses the ordinary
    BinOp bookkeeping; __iadd__ has arbitrary callback/selection behavior.
13. substitute(argument(0), {0: aggregate_actual}) discards actual children and
    contained reachability. Direct formal returns and path parent transfers
    must preserve actual descendants conservatively, not just root origins.

The corpus now contains 34 reviewer functions. Additional callback sites to
cover or explicitly decline include truth conversion, iteration/unpacking,
set/dict hashing and starred aggregate expansion. While test allocations are
repeated dynamic sites too; body-only loop_depth cannot certify them as
single-execution allocations. The current corpus smoke test still does not
check documented case facts: its valid-or-reason predicate alone is not a
shared corpus acceptance gate.

## Re-review of stable green-v5 source

The previous 13 confirmed issues are corrected or conservatively narrowed.
The explicit pure_sites API is acceptable as a conditional proof mechanism:
assumptions are exposed, unknown defaults remain conservative, foreign sites
are refused, and each consumer must independently guard every assumed original
site's exact types, effects and dependencies before using its facts.

Acceptance remains blocked by these independently reproduced cases:

14. dictionary_hash_callback and set_hash_callback report identity_safe=True
    although custom hashing/equality invokes arbitrary application callbacks.
15. starred_iteration_callback reports identity_safe=True although iteration
    during expansion is arbitrary, and fixed child cardinality is unproved.
16. raised_class_callback reports identity_safe=True although raise may
    instantiate an exception class with arbitrary constructors.
17. A custom metaclass __eq__ can make identity_observable(...,
    exact_type=NonNumber) return False, incorrectly granting numeric exemption
    and executing application equality in the guard. Use identity-only type
    comparisons. identity_safe must also avoid hashing arbitrary class tokens
    with custom metaclass __hash__.

Four protocol witnesses are now in the corpus (38 reviewer functions total).
The safe constant fingerprint change was independently probed: a custom
co_consts object declined with no __repr__ call. Add co_exceptiontable to the
source fingerprint too: exception control flow can change independently of
opcode bytes/flags/positions/constants. The reviewer did not execute malformed
bytecode as a probe.

## Final structural re-review before standalone acceptance

Protocol and metaclass guard corrections now address findings 14-17. Frozen
corpus-v2 is complete/unchanged and reports 41 passed, with explicit per-case
proved or declined contracts. The initial smoke test is no longer the sole gate.
The reviewer has not approved the layer because one further concrete transfer
class is unsound:

18. Destructuring trusts structural children of Set/Dict as ordered iteration
    members. Exact CPython set_unpack_order(2,1) returns (1,2); the summary
    certifies argument(0),argument(1), i.e. (2,1). dict_unpack_members certifies
    a key/value pair even though one-key dict iteration raises ValueError.
    Only unstarred Tuple/List sequences support this positional transfer.
19. Starred displays also lack fixed child positions. For
    [*prefix, middle, *suffix], prefix=(),middle=9,suffix=(1,2), destructuring
    produces (9,1,2), but three AST children falsely place middle second.
    Preserve reachable children as contained facts, never positional children.
20. Dict **mapping protocol runs before later sibling expressions. Account for
    that callback when visiting the expansion so later global facts cannot
    retain a pre-callback owner certificate. Default refusal alone must not
    license a wrong per-point fact for a future consumer.

Four additional corpus functions cover these issues; the reviewer corpus now
contains 42 functions. A consumer proof that hashing/iteration is pure cannot
repair the unordered/expanded positional transfer: those facts need correction
in the shared layer itself before its standalone commit.

21. Dependency guards truth-test defaults/kwdefaults/closure. A confirmed API
    probe assigned an empty tuple subclass with application __bool__ to
    fn.__defaults__: dependencies_match returned True and ran the callback.
    Use identity checks against None to refuse such dependencies before any
    truth conversion (or an explicit exact inert container check).


## Final independent source signoff

Approved for the standalone neutral layer at SHA256
9e9f189919b2fddbc1244f5061646d49dfc0c7a121888ad4c3f7dad7b8c71b3e.
No unresolved source soundness blocker was found in the final correction pass.
Findings 1-21 above are corrected or conservatively declined. The later
formatting and keyword-expansion witnesses are included in
wave17-matrix-followups.py and their retained red/green regression sequence.
The reviewer corpus file has 43 functions; the full frozen corpus has 122.

Verified evidence: matrix/provenance-final-aot-v3/complete.json is complete,
exit_code=0, unchanged=true. Its stdout reports exactly 318 passed, 2 xfailed,
24 warnings. The per-function corpus receipt reports 17 proved and 105 declined
with explicit obligations; declined cases are not counted as proved support.
Current provenance.py and _text_owners.py SHA256 values match that receipt.
The adapter hash is
8eb0b3f935f40e3c46bcde5c0561e224e92c2a607cdeb0105fb3383fdbe3c574.

The neutral layer retains weak dependency witnesses and primitive descriptors;
expired/nonweak/default/closure dependencies decline without application truth
or equality callbacks. Code scopes prevent cross-function constant/allocation
collisions. Formal substitution preserves existing actual owners and declines
callee allocation producers without a dynamic invocation proof. Source binding
covers executable constant recipes, opcode/flag/stack/exception metadata and
normalized instruction positions. Unknown protocols record effects, recursive
escape and identity refusal, including formatting and expansion order.

The pure_sites mechanism is a conditional proof API. The Unicode adapter uses
shared dataflow and supplies assumptions under its existing exact argument,
namespace/dependency, receiver, observer and native type-stability guards.
Numeric owner exemption depends on the existing _unstable exact-kind/overflow
gate running before safe(); safe() alone is not a numeric fidelity verifier.
The suspected mixed int/float probe was independently tested at lift's public
boundary and correctly declined on first and warm calls; it is not an open
value defect. bool/None/str/bytes/tuple identity remain nonexempt.

This source signoff does not accept the Unicode capability or any speed/coverage
claim. That still requires its pinned union/matrix/held-out accounting and any
required deployment/timing evidence. Copying the corpus for self-contained
clone tests requires one final completed unchanged layer gate before the
separate layer commit; any product source change invalidates this hash signoff.

## S52 positive consumer corpus independent review (v1)

Status: pending evaluator/corpus corrections; the current2/38 result is
provisional. No shared-layer or Unicode product change is requested by this
review. Missing real-consumer facts should be reported, not made to pass by
masking source flags/positions or simplifying the original functions.

The corpus contains38 queries from14 actual functions in8 embedded complete
modules. Independently verified all8 current original raw files against their
retained sha256 values, and all8 embedded logical texts against text_sha256.
For shlex, the raw/logical hash difference is newline normalization. Real
classes, nested closures, loops and unsupported constructs are retained. The
parked wave18 borrowed-list example is explicitly auxiliary and is correctly
excluded from38. The report's32 source/bytecode-binding blockers honestly name
an earlier gate than the desired downstream ownership mechanisms.

Required corrections before positive-corpus signoff:

1. Four origin cases have expected_kind=None, making the proved predicate
   impossible regardless of future correct facts. Define their actual useful
   contracts: chaos.25 is the fresh per-invocation list allocated by the line99
   comprehension, initially containing borrowed self.points elements rooted
   at self; do not claim final members unchanged after loop stores.
   regex_effbot.30 selects return strings at line93, preserving the same list
   allocated at line65 and recursive escaped accumulated str/bytes owners.
   .31 is an attribute receiver/closure-cell fact: both strings.append sites
   use that same outer list, not the same bound-method object across lookups.
   .32 is inner append formal0, not outer gen_string_table n argument0; require
   the original inner lexical scope and formal-to-actual substitution, with
   the optional encode call's result ownership separate. A missing nested-scope
   query API is an honest missing fact; an outer argument0 assertion is wrong.

2. ast.walk order plus unparse is not a consumer-site selector. It often picks
   Store targets absent from expression facts, or a similarly spelled earlier
   load. Pin original source coordinates/context/statement operation and verify
   selected source text. gc_collect.27 currently proves initial current=node
   at line24, though its consumer claims final link_next(node) at line30.
   Other mismatches: schedule.15 initial Store370 versus task call380;
   basepoint.23 Store187; d.25 Store99; current.29 initial Store24 versus link
   updates27/30; strings.30 Store65 versus return Load93; seq.33 Store174 versus
   first re.sub actual Load174; nextchar.36 Store136 versus read-call result.
   Journal d.pending.9 needs the intended Store270/273, and virtual h.device_in
   .12 needs Store305 rather than earlier Load301. State before/after timing
   explicitly for destination/store queries.

3. Kind plus membership of an argument in reachable roots is too weak for a
   proved useful origin contract. It accepts unrelated field/global paths or
   extra unallowed roots. Validate the full allowed root set and exact field,
   element/site/scope descriptors. Current schedule.13 must be taskList rooted
   specifically at global taskWorkArea; final-call node.27 must select arg0.
   Keep exact type/layout, callbacks, dependency pins and runtime resolution
   listed as consumer obligations; source-path facts do not authorize a load.

4. Correct downstream attribution: Task.qpkt's t.addPacket(pkt,self) returns
   an existing self/old-selected task. addPacket and Packet.append_to allocate
   no task/packet, so the missing fact is callee selected-return transfer, not
   callee allocation tags. Also distinguish an absent/unknown/widened queried
   source value from a later physical/journal/virtual/callee API obligation.
   Current valid summaries simply copy the desired label even when the selected
   Store-site lookup is UNKNOWN; that is not an earliest-actual-blocker ranking.
   Desired capabilities can remain a separate explicit mapping.

5. The evaluator validates embedded text hashes but not original raw hashes.
   The reviewer independently checked them for this attempt; keep that source
   validation or add an available-source raw/logical verification gate. Its
   clone-local corpus fallback still imports pyperf through an external root
   wave14-capture shim that is neither embedded nor sealed. Copy/seal that test
   dependency or state and validate it explicitly before claiming standalone
   reproducibility. No installation or application source rewrite is needed.

The two current positive answers are source-query facts, not extra native
functions, physical root proofs or usable call/journal transfers. The missing
count is useful evidence of practical gaps, subject to the contract and selector
corrections above. This work should not delay scalar Unicode or trigger an
unreviewed provenance extension; rerun only its evaluator/tests and bind the
corrected report to complete frozen-source evidence.

## S52 corrected positives and snapshot diagnostic signoff (v6)

Approved as an honest diagnostic/coverage-gap report, with no new provenance
capability claimed. Verified matrix/provenance-positive-v6/complete.json:
complete=true,exit_code=0,unchanged=true; stdout reports72 passed,25 warnings.
The evaluator SHA256 is
3b441c13a324bc05b489e99d383fee1b3f1c60b0c88ccb18cdcd1842de16d4d2;
snapshot helper SHA256 is
4b6b479a1fda49b700f5bb25e830692bdf509696b3ceae885f8bcd5369339df3.
Current files match those receipt hashes. Product provenance remains the
previously reviewed9e9f1899...71b3e source; no layer API was weakened or extended.

The corrected report is2/38 useful source queries proved,32 blocked first by
original source/bytecode binding, and4 by an absent/widened queried source owner.
Desired downstream gaps are separately mapped; they are not mislabeled as
reached blockers. Explicit original source sites/context now select the actual
consumer operations, including final link_next(node). Exact root sets, field
chains, element sites and original-code scopes are checked. Argument/singleton
origins alone may be unscoped; producer/global/path facts cannot use scope0 or
a foreign code scope. Negative checker tests reject wrong field/root/extra root
and scope answers. The two dynamic member contracts remain explicitly missing
API, rather than being certified by nonempty children or an arbitrary count21.
The comprehension's desired borrowed members correctly name self/points roots.
Nested append formal/closure facts are distinguished from the outer n argument.
qpkt's desired gap is selected-return transfer, not nonexistent allocations.

All8 retained original raw-source hashes were independently rechecked against
the current originals; logical embedded hashes and frozen pyperf support are
validated by the evaluator. Embedded support removes the external shim import
dependency and restores the exact prior sys.modules binding, including None.
The auxiliary parked borrowed-list fixture remains outside38. The general
counterexample corpus has134 declared cases:17 proved,117 explicitly declined;
this includes the two declared MethodBindingTask methods rather than silently
omitting class members. Positive source proofs retain exact type/layout,
effect/dependency and runtime resolution obligations; no native/physical root,
journal, virtual-field or callee-transfer result is inferred from the2 proofs.

Both active correctness runners copy and seal the corpus per attempt, pass its
path through PROVENANCE_CORPUS, and verify the consumed copy afterwards. All
three test/evaluator consumers honor that explicit snapshot; missing explicit
inputs fail closed. Live additions no longer alter a running attempt's corpus,
while snapshot tampering invalidates it. Focused tests cover live mutation and
addition versus frozen-copy mutation. Future root additions belong to the next
snapshot and must be reported with that later receipt, not credited retroactively.

No blocking diagnostic/reporting defect remains in this reviewed revision.
This signoff permits final correctness/accounting gates to proceed; it neither
accepts the missing consumer capabilities nor delays scalar Unicode for an
unrequested speculative provenance implementation.
