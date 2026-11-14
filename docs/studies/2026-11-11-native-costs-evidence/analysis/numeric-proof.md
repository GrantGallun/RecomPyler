# Numeric proof opportunity: integer-zero-or-float results

Initial read-only product investigation against integration `0aeb157e8d272e0b1d4787a173f5b66f75d81b01`. No benchmark artifact was imported, executed, built, profiled or timed in that investigation. The subsequently authorized isolated implementation is recorded in the addendum below; the design estimates in the main analysis are not a verified implementation size.

## Recommendation

Start with a proof-only fact for numeric locals and function-result leaves: **if this value is a Python integer, it is zero, represented internally by canonical positive zero**. Preserve existing `MIXED` storage, flags, argument/result widths and inference seed types. Where both operands have this fact, mixed `+`, `-` and `*` need neither an integer magnitude test nor integer-zero normalization: their integer case is respectively `0+0`, `0-0` or `0*0`.

The recursive force result/accumulator cone satisfies this property from code alone. It does not require coordinate assumptions, input-value guards, heap alias analysis or allocation-site layouts. This is a smaller first compiler change than splitting every Point allocation or enabling a global floating representation. It targets real remaining native instructions while retaining externally visible numeric types.

The stronger follow-ups are separate: prove that component flags are unobservable along a closed set of uses and specialize an internal recursive result to two doubles; add guarded zero-only facts to mixed input fields; or refine float access paths using alias/effect facts. None is required for the first patch.

## Why this work exists now

Current `heap.py` has one field-type dictionary per class family (`_Program.fields`, lines 481–483; `register`, 601–625; `field`, 3795–3805). `ObjT` distinguishes class sets and nullability, but not allocation sites or receiver access paths (135–144). `_seed` joins every input instance into the family's same field types (6432–6442). Constructors and later stores also widen those types (5625–5639).

Consequently, position, velocity, acceleration and private center Point coordinates share `MIXED` fields. Integer constructor/reset zeros contaminate float-heavy reads. This is type imprecision, not evidence that the source is allowed to expose floats in place of integers.

`MIXED` currently means a double payload plus an integer-kind flag (`_width` and `_slots`, 336–351). Its `+/-/*` lowering combines flags, conditionally checks the integer exactness bound, and adds positive zero for the integer case (3580–3630). The current threshold policy is conservative around `2**53`; do not weaken its unknown-integer cases.

Existing `fast_mixed` is unsuitable as this patch. `floats_unseen` is a whole-region observability check (934–1008); Barnes writes observable numeric fields, so it fails that check. When enabled, the existing path intentionally substitutes `True` flags for mixed values and checks every resulting magnitude (3614–3620, 3728–3732). It is not a proof that a particular value is always a Python float, and simply activating it would not eliminate all range checks.

Actual selected candidate AOT force assembly still has the field flag/range chain at `0x180003d35–3d77`, with further dx/dy square/sum checks through `3df4`. After the first recursive call at `4101`, `4146–415a` masks/compares a returned component against the exactness bound, and `4160–416b` records failure. Another child's accumulation combines tags at `4414–441e`, compares at `4420–4434`, and has a range-failure exit at `4436–4441`. These are from `../wave5-instructions/candidate-force.asm`, not profiling-JIT code. Addresses are preferred-image addresses in an already audited binary, not future output expectations.

## The code-only proof

In the frozen driver, `calculate_force` has these successful returns:

1. Empty/skip branches return literal `(0, 0)`.
2. The approximation branch returns `fx, fy` computed by true division. Existing lowering already gives these expressions `FLOAT`, irrespective of the integer/float tags of earlier coordinates. An earlier overflow/domain/division failure still takes the existing bailout path.
3. The recursive branch starts `fx, fy = 0, 0` and adds child components in the existing order. By induction on any finite successful recursive call tree, each child component is either integer zero or a float. If both accumulator and child are integers, both are zero and the sum is integer zero; otherwise the sum is a float.

This proves each returned component and accumulator is integer-zero-or-float. The proof makes no claim that all coordinates or arithmetic intermediates have that property. NaN, infinity, signed float zero and arbitrarily large floating magnitudes may still be floats; they must not acquire an integer magnitude check.

The proposed implementation should be named for this value property, not any benchmark, class, method, attribute name or float constant.

## Bounded implementation using the existing generator

A conservative first version appears feasible at roughly **150–200 product lines**, with separate regression tests, by preserving the `(kind, codes)` expression interface and adding proof side tables. This is a design estimate; if implementation needs broad special cases to fit it, keep the conservative subset and accept missed optimizations.

Suggested private interfaces, with final names left to the implementer:

- `_Program.prove_zero_int_results()`: runs after ordinary type settlement and existing `fast_mixed` selection, before final source assembly/digest/compilation. Initially skip `fast_mixed` programs and generator/coroutine functions. Snapshot the reachable function/type shape.
- A candidate table keyed by the actual `_Function` plus a numeric local/result leaf, for example `(info, "var", name, leaf)` or `(info, "ret", leaf)`. Candidates mean **every possible integer value for this leaf is canonical zero**. `FLOAT` satisfies this vacuously; unknown numeric arguments and heap reads do not.
- `_Gen.zero_fact(kind, codes)` and `_Gen.remember_zero(kind, codes, facts)`: query/store per-value facts in an ephemeral generator table. For tuple values, traverse numeric leaves using existing `_width` offsets. Unsupported/nullable/non-numeric shapes return unknown. Facts are attached to exact code-value groups, not guessed by expression text or function names.
- `_Gen.copy_codes(kind, codes)`: preserve the fact when tuple construction or chained assignment copies values into fresh temporaries. This avoids changing all expression return signatures.
- A small drop/meet helper: intersect candidate facts with every observed assignment or successful return; a candidate can only be removed during analysis.

Use **candidate elimination**, not optimistic code emission:

1. First settle ordinary kinds and produce the unoptimized call graph as today. Initialize candidate facts for numeric local/result leaves. Parameters remain unknown unless already typed `FLOAT`; no numeric argument-value specialization is needed in this version.
2. Rerun `_Gen` over the already reachable functions with this optimization **off**. Seed local code-value facts from the candidate table. Every assignment and return meets its producer facts into the destination candidates. Scalar parameters/fields of integer or mixed kind, unknown calls and unsupported producers remove their dependent candidates.
3. Repeat until no candidate drops. Start from possible certificates, then monotonically invalidate them. A base `return 1`, a return from an unknown integer parameter, or `acc += unknown_integer` breaks the certificate and invalidation propagates through recursive callers. Local numeric assignments are immutable values; heap writes cannot mutate a captured numeric local. No heap field facts are inferred here.
4. Once stable, regenerate with optimization on and certificates immutable. If the reachable function set or ordinary kind shape changes, or a certificate would drop, discard the proof and regenerate normally before compiling. Proof analysis must not make an otherwise eligible program fail solely because a new iteration budget was exhausted.

This verifies recursive components without a new IR or SCC algorithm: the existing specialized callees and generator traversal already supply the relevant graph. The finite successful call-tree induction justifies retained recursive certificates; never assume a return is zero merely because recursion was observed in samples.

Limit proof iterations by candidate count plus a fixed-point check, or use a tiny worklist. Do not reuse the existing 60-pass type limit in a way that introduces new unsupported programs when the proof has many candidate drops. Failure to prove means ordinary code, not Python fallback.

Concrete generator hooks:

| Existing site | Proof-only change |
|---|---|
| `assign`, 3507–3512 | Meet producer facts into the local's all-definitions certificate; record facts for its `var_codes`. |
| `coerce`, 3478–3505 | Preserve leaf facts when codes change representation, including int-zero to mixed and tuple element coercions. A wrapper around the existing coercion body avoids editing every return branch. |
| `expr_Tuple`, 4079–4083; chained assignment, 5573–5578 | Preserve facts across the existing temporary copies. |
| `call`, 4413–4459 | Record facts from the **actual specialized callee** return on the new result codes. Unknown/polymorphic joins may conservatively lose facts in the first version. |
| `do_Return`, 5193–5206 | Meet each actual producer into the corresponding return certificate before ordinary coercion. Bailout dummy returns are not successful Python results. |
| `binop`, 3580–3630 | Propagate the certificate through supported numeric `+/-/*`; after certification omit only the mixed integer range/normalization block when both operands satisfy it. Retain the computed integer-kind flag. |
| `peek`, 3461–3467 | Save/restore ephemeral code facts as well as emitted lines/depth/counter. It reuses temporary numbers after discarding speculative code; retaining temporary facts would be unsound. |

The minimum transfer rules are: exact literal integer zero is certified; known `FLOAT` is certified; local/callee-result certificates propagate; a tuple carries element certificates; supported `+/-/*` preserves the integer-zero case if both operands are certified; all other integer/mixed producers are unknown unless a separate rule is justified. Existing float result typing handles true division. Nonzero/unknown integer producers must not be treated as zero because their magnitude happened to be small in captured inputs.

Initially leave unary mixed negation's current integer-zero normalization intact (`4001–4023`). Unary minus of a canonical double positive zero produces negative zero, while Python integer `-0` is integer zero. Removing the current branch requires another explicit rule, even though the result's integer value is still zero.

The first patch changes no loader, `_width`, `_slots`, object layout, `_signature`, seed encoding, public result conversion or recursive result ABI. Its generated source changes normally alter the existing source digest, so actual AOT must be rebuilt for validation. Proof facts come from code and existing guarded kinds, not new input samples, so no new seed-value guard is necessary.

## Expected native removal and its limits

For certified recursive component additions, remove the integer exactness comparisons, associated cold range-failure status/location stores, and positive-zero correction that exists solely for a possible nonzero integer result. Keep component flags, result tuple fields, child tests, recursion-depth/status checks and order of additions.

The dx/dy and square/sum range checks at `3d35–3df4` remain in this first patch: their mixed input fields are unknown. The broad recursive array ABI and large frame need not shrink. Static instruction reduction is an acceptance signal, not a timing forecast. Neither this analysis nor the proposal establishes C parity or how much of 5.21x comes from these checks.

Use a small recursive fixture where only the result/accumulator can be mixed to check generated LLVM removal of the exact-integer bound; checking the entire Barnes function for absence of that constant would be wrong because other legitimate checks remain. Then inspect the newly selected **actual AOT** helper against its successful export/digest/artifact audit, using the repository evidence tools.

## What requires stronger assumptions

| Candidate | Evidence/proof required |
|---|---|
| Recursive result/accumulator integer-zero-or-float | Code-only fixed-point certificate above. No new input guard or alias proof. |
| Private fresh `total_mass` integer case is zero | Constructor zero plus all later assignments from `old_mass + particle.mass`; existing selected program guards `particle.mass` as float. Fresh-only origin must be established if applying this to a field rather than all instances. |
| Class-family Point integer case is zero | All current integer inputs are zero and all stores produce zero/float in this driver, but current MIXED loaders accept any exact integer. Requires new guards on every loaded relevant integer field and proof transfer through all stores. Facts must enter inference identity/AOT reuse metadata; both native and Python loaders must enforce them. |
| Position x/y is definitely float at a force read | Requires a guarded input access path and a valid write/alias/effect proof through the insertion/force phases, or a dominating runtime type check. Point's class name does not establish this. One definite-float operand would let existing `binop` skip both tags and exactness work. |
| Private center Point can be scalar-replaced/embedded | Needs allocation-origin, escape, identity and alias analysis through its methods. `_ESCAPES` at 1406–1470 only checks incomplete constructor initialization; it is not an escape/lifetime certificate. |
| Internal force tuple can carry only two doubles | Needs a separate use/observability proof. In the selected region, components are only recursively added or divided by float mass, which is promising. A direct region entry returning the tuple must keep integer-zero versus float-zero types. Reject stores, escapes, unknown consumers, type observations and unsupported operations. |
| All coordinates/forces may be floats unconditionally | This changes the contract without the proofs/guards above. Reject as a general compiler transformation. A manual counterfactual may quantify it only if explicitly labelled as a changed contract. |

Private/non-escaping alone does not authorize arbitrary float conversion: an integer intermediate can exceed exact double range or influence the eventual floating rounding; a zero can acquire a sign under multiplication/negation; a later division may raise. Likewise `total_mass != 0` does not prove the center is float: negative or NaN accumulated masses can leave the initialized center unchanged because the update condition is `total_mass_new > 0`.

## Regression and evidence scope

The first patch should have focused meaningful tests before expanding to fields or flag erasure:

1. A generic recursive tuple fold with literal integer-zero base returns, float leaf results and repeated additions. Direct entry must return integer zeros on all-integer-zero paths and floats on float paths; assert exact types, not equality alone. Check zero/float facts for different specializations do not leak.
2. Positive/negative float zero through leaves, recursive sums, subtraction and multiplication; compare float hex/sign and public types. Include mixed int-zero plus negative float zero, and int-zero times negative float/infinity. Do not reassociate operations.
3. Large floats beyond `2**53`, infinity and NaN remain floating results; this proof must not force them through new integer guards or replace NaN with zero. Compare NaN classification and existing payload policy where applicable.
4. One nonzero integer return/assignment, an unknown integer parameter, an unknown/mixed field read, tuple unpacking, chained assignments and a temporary-number rewind through `peek`. Unknown/nonzero cases must clear the certificate and retain existing guards. Include existing large-integer fallback controls around and above the exactness bound.
5. A conditional local reassignment and a loop-carried unknown integer must invalidate the all-definitions certificate. Exception/recursion-limit bailout and exactly-once object effects remain unchanged; use the existing regressions as controls.
6. Both loaders and fresh-process AOT reuse still preserve exposed tuple/field types and signed zero. Existing `test_int_or_float_kept_exact_where_it_shows`, `test_int_or_float_as_plain_floats_where_unseen`, nullable mixed-field, rollback and recursion tests are relevant regression controls, not evidence that new field guards already exist.
7. Native-code test on the isolated recursive fixture: bound checks disappear only for certified additions, while an otherwise similar nonzero/unknown integer fixture retains them. A separate actual-AOT audit verifies the real selected Barnes helper and unchanged execution mode.

For a later internal two-double ABI, add use-negative tests: return the tuple to Python; store a component in an input field or list; consume it with integer-sensitive arithmetic before conversion; or change a guarded method to inspect/store its arguments. Such variants must retain tagged lowering or decline the specialization. Preserve division by zero, sqrt domain handling, recursion limits and transaction rollback.

## Approved implementation addendum

The coordinator authorized Stage A in a new independent clone at `../wave6-zero-facts`, branch `codex/zero-integer-facts`, based on `0aeb157`. Integration was not edited. The two native support binaries were copied exactly; six checkout newline differences were aligned to the integration bytes after verifying newline-only equivalence.

The initial patch adds approximately 120 product lines and a separate focused test file. `_zero_parts` describes numeric leaves with tuple paths, so facts remain stable when existing numeric coercions change machine widths. `_Program` owns per-specialization local/return candidate sets; `_Gen` queries all-definitions local facts and keeps facts for immutable temporary code groups separately. Unknown heap reads and integer parameters receive no certificate. Analysis emits no optimized code. Final regeneration verifies no certificate, type or reachable-function change before accepting its generated source; otherwise the ordinary path is regenerated. Existing tags/layout/ABI/seed kinds remain unchanged. Known-zero int-to-mixed conversion also omits its redundant magnitude check, preserving the actual value conversion.

The initial patch explicitly resets proof state before each `compile` and skips proof work when no mixed arithmetic was observed, for existing `fast_mixed` programs, and for generator/coroutine graphs. An extra generation pass on fresh AOT reconstruction can affect startup even when the kernel improves; that cost must be reported separately rather than attributed to native arithmetic.

Test-first evidence is in `zero-facts-red.txt`: six generation-only tests completed in 0.037 seconds, with two expected failures because recursive/zero-operation guard removal was absent. The other conservative controls passed. After implementation and a repeat-compile control, seven generation-only tests passed in 0.045 seconds, with explicit checks that Numba was absent before and after (`zero-facts-frontend-green.txt`). This is frontend source-generation evidence only. Seven further native/LLVM/fresh-process-AOT tests were written but remained unexecuted while the causal study held the CPU gate. Native semantics and speed were not claimed from these frontend tests.

After the coordinator explicitly granted the CPU gate, the complete focused file passed **14 tests and 14 subtests in 10.34 seconds**. This includes actual LLVM absence/presence controls, exact native types/bits, signed zero, large floats, NaN/infinity, unknown integer fallback, branch/loop/conditional/polymorphic merge controls, alias/exception rollback, recursion limits and fresh-process AOT reuse. The fresh process completed five AOT calls per loader, zero JIT/fallback, with no Numba import. The full repository suite then passed **441 tests and 52 subtests in 253.03 seconds**, with 22 known-category GPU occupancy/Numba SSA warnings and no failures. No product edits occurred between or after those runs. No benchmark timings were run by this worker.

The reviewed two-file patch is committed as `9ff4908fdc58613d72287f71cfc6b70aa5e693ff` on `codex/zero-integer-facts`. Actual product change: 118 inserted and seven removed lines in `heap.py`; focused test file: 297 lines. A tracked-source/test index renormalization produced an empty staged diff, clearing the six newline-only status entries without changing tested bytes. The candidate worktree is clean and frozen for the coordinated actual-AOT/benchmark study.

Validation logs and a hash/package/commit manifest are under `../wave6-zero-facts/build/zero-facts-validation/`. Frozen heap SHA-256 is `e7ee3bb1fb2b8c42a6848383388ef28ed3eaf79e6a1f50e0fc53b210570e5109`; focused test SHA-256 is `f51ae8b8c331e2931b135cca54354f151e29e3df1eee9b59211ce96bc9424ec2`. This establishes correctness-test evidence and the intended machine-code removal in the generic fixture. A performance claim and confirmation of the particular Barnes actual-AOT instruction changes remain the separate study's responsibility.

## Inputs and provenance

- Original product `heap.py` SHA-256: `3bdbb2e20b5544bd60ad8c4100d37c5a1146a2d859ad0adf59201e2c99383279`.
- Frozen driver `../wave5-study/results/drivers/barnes_hut.py` SHA-256: `75c2550e69a0b565a8fdf1651a723f51e7f63333eb960fc778163722844bf7fa`.
- Existing `../wave5-instructions/candidate-force.asm` SHA-256: `8061902f7f4f273ad5d61186aa3d730d9f077eb2492778aca215ae15806c878d`.
- Existing selected candidate artifact SHA-256, from the instruction report: `226403d22c98758ad52a79d49d3daf4641f9e2cdd6b1cad9c6e23a11e5f7bc9e`; export `r0`; source/seed digest `a0f9dde9c40c4c638a5a799fba1be65e7c353ab533d9f75c68334174b1f19c1f`.
- Also inspected `integration/tools/README.md`, `integration/docs/studies/2026-11-11-heap-index.md`, `../wave5-instructions/REPORT.md`, the older explicitly labelled `../wave4-instructions/region/actual-r0-source.py` and layout report, and current heap regression sources. No old generated source was presented as the current AOT artifact.
