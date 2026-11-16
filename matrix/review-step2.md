# Step 2 independent soundness review

Reviewed STEP2-DESIGN.md, the current lift.py/profiler.py diff (including the new comparison operand guards), test_matrix_soundness.py, and saved focused output step2-green-v2.stdout. No constructs, suites, builds, profiles, or timing workloads were run for this review. Counterexamples below are proposed execution tests, not source-derived product verdicts.

The saved focused result is 21 passed. The coordinator's full matrix rerun was active during review; preserve its frozen source identity and make subsequent changes in a new cohort.

## Assessment

The main direction is sound: semantic helper bindings belong in generated identities; named type-domain declines belong where a helper recognizes its unsupported domain; list reads should flag invalid bounds before backend exceptions; tuple-valued Boolean selection must preserve identity or decline; None batch arguments should remain constants rather than numeric columns. No product loading/write-back/start-up path is edited.

Approval of this step remains conditional on the execution counterexamples and identity completeness below, followed by the required matrix/union/kernel checks. The focused tests establish representative corrected rows but do not yet prove preservation of existing native coverage.

## Required follow-ups

1. **Complete semantic record identity as well as module identity.** _module_file includes sorted(self._unit.names.items()), but _name_records still hashes only generated source, constants, and described fields/kinds. This falls short of design item 1. _RecordInfo.name_types reuses importable namedtuple classes by the stem, and _RECORD_TYPES/_COLUMN_TYPES map those classes to the most recently created info. Consequently semantic variants can still share record/column identities even after their generated module files differ. Add the same stable named-binding recipe to the record stem. Test two same-structure builds on the same source class whose differently named attributes/methods yield different behavior, in both warm-cache orders and in a fresh process.

2. **Literal numeric-list indexing still bypasses the new checked reader.** pick_getitem now chooses defaults[kind(dtype)] for numeric lists, but pick_index (used by AST constant subscripts) continues to emit direct target[position] for types.List. Execute return [1,2][3], return [1,2][-3], and an empty typed numeric list indexed by a literal. Also include a private argument mutation before an invalid literal read, checking the original state and exactly one Python exception. Select the same checked numeric reader for literal list/array indices, retaining heterogeneous tuple literal handling and valid supported reads. No verdict is asserted here without those executions.

3. **Comparison operand admissibility does not prove pairwise comparison semantics.** comparison_operand independently accepts int, bool, float, and nested tuples. Mixed Python int/float comparison can require exact arithmetic that a backend float cast loses. Execute equality and ordered variants with:
   - a=2**53+1, b=float(2**53);
   - a=2**63-1, b=float(2**63);
   - their negative counterparts and infinities/NaNs.
   Use exact result/type comparison and observe whether native execution happened. The typed helpers currently return operands unchanged and contain no pairwise precision guard. If these expose a wrong row, implement the pairwise rule or make this domain a named decline; do not infer safety from numeric input kinds.

4. **Tuple comparisons need an identity-sensitive NaN witness.** Create n=float('nan'), a=(n,), b=(n,). CPython tuple equality treats the identical element as equal even though n==n is false. Compare the shared-element case against two independently allocated NaNs, including nested tuples and ordering with equal prefixes. The unboxed representation loses float object identity. The present tuple allowlist therefore needs an execution test and either a guard/proof or a named decline where identity can change the result.

## Retyping, literal retry, and compatibility

The new checked overload wrapper preserves picker signatures and prefer_literal. _prepare explicitly catches Unsupported and checks _retype before declining, which retains the intended rebuild route when fill_for has recorded a _RETYPE request. This is a useful structural check, not execution proof of successful recovery. Add a record-column constructor whose initial float columns must retype to integer/bool, and confirm a second call and fresh-cache process remain native and correct. The new Unsupported recovery branch does not save the retype verdict like the older compile-error branch; that is primarily a cache/compile-work difference, but verify it does not create a repeated rejection/rebuild path.

Raising Unsupported rather than returning None can stop Numba's alternative/literal typing attempts. _rc_index is prefer_literal=True, but valid heterogeneous tuple literal indexing, constant numeric list indexing, field/method helpers, and record retyping must retain their supported path. A native-or-declined assertion alone cannot detect a broad coverage regression. Pin actual observed native expectations for representative previously native arithmetic, bitwise bool/bool and bool/int result types, heterogeneous tuple constants, local list reads, record fields/calls, and required kernel paths.

Scalar Boolean value guards preserve evaluation count and short circuit because each operand remains one identity helper call inside ast.BoolOp. They correctly exclude represented tuple/list results whose identity cannot be reconstructed by value. Test mixed int/float/bool operands, signed zero, NaN, None, and a short-circuited raising operand; the existing stability analysis must continue to reject value/type-changing unification. The new not helper uses length for represented inert sequences, which is the correct list/tuple truth rule. Direct if/while/conditional-expression tests remain on the older path, so do not claim their coverage was expanded by this patch.

The comparison rewrite preserves ast.Compare and does not duplicate middle operands, so Python chain evaluation/short circuit is retained structurally. Selecting the ordered helper for an entire mixed chain is conservative: it may decline a None operand participating only in an equality segment. Treat such a loss as a coverage cost, not a soundness defect, and inspect native-count changes.

None batch handling omits N columns and emits literal None, with an explicit all-None shape check. Add nested tuple rows with interleaved None/scalars, repeated batches, and one changed non-None row to confirm rejection rather than column misalignment. The code shape is consistent with that rule; no batch workload was run here.

## Acceptance evidence still needed

Finish the full matrix on its frozen source; repair every observed wrong/crash; apply the reviewed follow-ups; rerun the affected rows and the accepted matrix gate; then run the union suite and required four-kernel check under the shared lock. Report before/after verdict counts, retained/lost native rows, and any unresolved soundness domain explicitly. A named decline is acceptable for Step 2 only when its Python result, exception, side effects and evaluation order actually match.

Only this review file was written; no product or other wave files were edited.

