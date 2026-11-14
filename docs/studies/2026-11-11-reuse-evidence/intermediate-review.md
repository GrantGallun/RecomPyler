# Wave 3 independent design review: fresh-process native reuse

## Latest final scoped verdict — 13f3224dfbc82e7a6f78899d53abc03cbef1e917

**No remaining actionable finding in the reviewed fresh-process seed reuse, strict/widened specialization handling, dependency guards, execution counts and rejected-metadata paths.** This verdict supersedes the historical open findings below and is conditional on the new frozen full-suite result. It does not preapprove the coordinator's fresh Richards deployment gate, future timings, or broad language compatibility.

Reviewed the strict/widened correction at `1b570ba` and the complete manifest/math delta through `13f3224`; confirmed clean product status at that HEAD. The bounded corrections retain exact source plus metadata digest matching and the existing fail-closed AOT-only policy:

- Both strict and widened candidates retain their own guarded type seeds. Byte-identical generated source may share an export, but differing metadata still has its own bound digest. The valid legacy specialization no longer disappears merely because another signature has a seed.
- The sealed manifest includes functions discovered during normalized generation plus plain-function guard values, constructor bindings, class inheritance and defining-class cell bindings. Their actual code/default fingerprints are validated before replay. Cheap ordinary code/default/MRO/constructor/cell guards protect later calls; the implementation does not hash every dependency per execution.
- Restoring the sealed manifest must regenerate byte-identical normalized source, then pass the existing native parameter/return ABI and constant-return checks. Manifest content and reconstruction-module bytes remain bound to export compatibility.
- Keyword-default fingerprinting rejects custom mappings and nonplain string keys before iteration/sorting. Per-call default guards distinguish a deleted key from a present None value, compare stored values by identity, and reject custom replacements without invoking their hooks.
- Newly emitted normalized source now runs the existing exact-math compatibility check at build time. A startup-only transcendental rejected by that check cannot become a new export merely because source-only generation used a stand-in AOT map. Runtime matching AOT lookup still precedes the math/JIT path.

Independent lightweight verification on the final logic:

- `mixed_selection.py`: both signatures, both call orders and both loaders select guarded exports; an unrelated None seed does not authorize a poisoned object-only helper.
- `startup_code_guard.py`: a source-location-preserving constructor bytecode change is rejected before AOT selection; Python's changed result is 16 and no stale +1 export is accepted.
- `startup_default_guard.py`: removing a None-valued keyword default after a successful program match makes the per-call guards fail.
- `startup_math_guard.py`: a rejected startup-only `sin` now leaves only the original export and strict seed, with the math check observed. Before the fix it emitted the extra export without calling the check.
- Original binding/namespace rejection and malformed-family/ABI checks were independently exercised during this review history. Final focused pure tests: **6 passed, 40 deselected**, covering rejected binding/namespaces, fingerprint exception/cell metadata, and hostile default mapping/key controls.

The selection probes deliberately replace native compilation/exports with test substitutes and invoke actual artifact-selection, restoration, source matching, loader and guard logic. Non-math fake-build probes stub the build-time math self-test to keep them lightweight. They are not evidence of actual native execution or performance. The implementer separately reports **64 focused native/counter/CLI tests passed** at this revision; the new full suite is running. I did not duplicate native fixture builds, run the full suite, benchmark Richards or measure timings. The coordinator must rebuild/recheck Richards against this source revision because compatibility hashes changed.

---


## Final scoped verdict — afd09b0b2b5e868a71b20a04e22907aade64b6a0

**No remaining actionable finding in the reviewed seed-reuse, execution-counter and rejected-metadata paths. All three original findings, including the follow-up global namespace hook variant, are resolved.** This approves the implementation within the stated review scope; it is not an approval of future benchmark results or a claim that arbitrary programs now reuse native code safely or profitably.

The final diff resolves namespace bindings to raw values, requires exact `FunctionType` / `ModuleType`, and only then reads `__globals__` / `vars`. Independent original reproducers now record `function []`, `module []`, and no generic unwrap lookup. Re-running the independent export-selection/rejection probe again confirms the ABI-changing nullable seed is declined while retaining its legacy export, and malformed family metadata declines cleanly under the AOT-only policy. These probes import no Numba and perform no native build.

Independent final regression selection: **4 passed, 23 deselected**, covering plain-binding rejection, both function/module namespace rejection variants, and fingerprint exception/cell metadata. Inspected `20d53bd..afd09b0` and confirmed the worker checkout's HEAD is the reviewed commit with no product changes pending.

Earlier implementation review covered the complete seed diff through `ee71999` and the counter/fingerprint delta at `20d53bd`; the sections below preserve that review history. The implementer reports the final suite at `afd09b0` passed **353 tests plus 38 subtests** (10 warnings, exit 0). I did not duplicate that full suite or the native artifact fixture build. The coordinator's independent actual Richards fresh-process native deployment gate remains separate and is not preapproved by this verdict. No timings or performance claims were produced in this review.

---


Baseline inspected: integration `dba45a7`, together with `WAVE2-AOT-AUDIT.md`. Product files remained read-only. This is a design gate, **not approval of an implementation**; the later patch still requires independent review and cross-process native-execution evidence.

## Recommendation

Retain regeneration of the current function's guarded source and the exact AOT source-digest check. For a bounded first implementation, consider a **versioned, data-only type/layout seed** produced from the verified program, resolved against current live bindings, which helps regeneration converge on the saved layout. Do not restore captured global values or deserialize a Python `_Program` object. If a seed cannot reproduce the original code and compatible ABI safely, fall back under the existing AOT-only policy.

This intermediate design is preferable to directly executing a restored typed program: current generation recreates the assumptions and guards from current code, and exact digest matching remains a final check. It is also more realistic than assuming sorting field names alone will fix the demonstrated mismatch. An equivalent fully canonical regeneration design can be sound, but needs a larger fixed-point treatment than final field sorting.

The implementer was sent this guidance directly before product changes.

## Comparing the endpoints

| Design | Benefit | Main proof obligation |
| --- | --- | --- |
| Persist and directly rebind a typed program | Reuses the profiled ABI without rerunning inference | Reconstruct every live guard and all loader/unloader metadata without accepting changed code, types, constants or bindings |
| Canonicalize final inferred program | Leaves live code discovery and guard generation in the existing path | Canonicalize the full executable/type graph, not only tags and field order; prove all regenerated source and loader metadata use the same canonical layout |
| Data-only seed plus guarded regeneration | Reuses type knowledge while retaining current source/digest checks | Validate/rebind seed safely, preserve cell aliases and metadata, and fail closed when exact compatible regeneration is unavailable |

A directly restored program is not intrinsically impossible, but its minimum implementation surface is substantial: class families/aliases, ordered fields and members, recursive type cells and mutation flags, entry parameter/return widths, global/constant slots, function fallback-site order, array/RNG flags, write-back sets, and all guard forms. Loading Python pickle or recreating instances from captured state would add unsafe hooks and violate the requirement to execute against current state.

## Specific threats to address

1. **Identity is process-local.** Current `guards_hold` checks function code, class attributes, MRO-own attributes, namespace items, builtins and constants. Rebinding a saved function/class to the current object and then blindly setting expected values to that object's current values erases build-time assumptions. Validate build-time fingerprints/structure first, regenerate guards where possible, and keep the new live identity guards for every subsequent call. The same qualified name alone is not a type/code guard.
2. **Resolution must not execute application hooks.** Resolve plain module globals/class dictionaries and known live symbols, not arbitrary imports, `eval`, pickle reducers or descriptor execution from saved paths. Initially decline ambiguous identities, dynamic local classes, unsupported descriptors/closures, or other bindings that cannot be proved. Persist no object addresses, ndarray pointers or mutable graph values.
3. **A preloaded class schema must not bypass current class validation.** `register` returns immediately for a class already present in `class_fields`. If a seed fills that mapping first, explicitly retain `_object_problem`, constructor/MRO/method validation and their guards; otherwise a changed class could escape the checks normally performed by registration.
4. **Code and heap ABI are one unit.** Any persisted schema must bind to the export/digest/compiler/Python version. Preserve numeric/optional widths, container mutation cells, nullable flags, tuple packing, family tags, globals, constants, entry return types, array rollback flags and RNG write-back. Rebuild derived C/Python loader caches from validated metadata, rather than carrying process-specific cached plans. Actual arguments and current globals must still pass the existing loader checks before execution.
5. **Canonicalization must finish before final code and loader plans.** Fields and `members` are only part of the order dependence. `_Function.name` uses discovery order; `specialize` keeps the first `MAX_SPECIALIZATIONS` variants encountered; global/constant slots have insertion order; `where()` encodes the current function-order index; recursive merging uses function order. Canonicalizing metadata after code emission, or retaining stale loader/cache plans, can silently produce a different ABI. If canonicalization changes a type/layout, regenerate until stable with a finite limit, then freeze all dependent metadata together.
6. **Fix unordered source emission separately.** `attr_check` iterates `ObjT.classes` as a frozenset, independently splitting source digests in fresh processes. Sort emitted checks deterministically by a stable assigned tag; audit other source-affecting iteration. This alone does not correct global-state-dependent inference or layout.
7. **Do not trade a mismatch for unsafe execution.** No export-by-name substitution, stripped/normalized layout constants in the digest, or unconditional acceptance of saved code. Wrong loader offsets may produce valid-looking numbers and memory hazards rather than a clean exception. Preserve the runner's default AOT-only budget safeguard and conservative actual-mode reporting.
8. **Current graph state must remain current.** An empty runtime registry should stay empty until the function populates it. Shared references/cycles must travel through one load memo across arguments and globals. Never initialize the runtime from profiling snapshots merely to reproduce the profile's types. Keep rollback before Python fallback, including direct ndarray writes.

## Minimum meaningful regression gate

The main positive test must use a **real compiled export**, not a synthetic callable: build in process A after globals contain a polymorphic graph; run the same script in fresh process B starting with empty globals. Require actual export selection, successful native-call accounting, correct outputs/mutations/identity, and no JIT on the covered non-NumPy case. Repeat in another fresh process to expose set/object-address ordering. Exercise both Python and C loader modes.

Use a small fixture with two or more subclasses sharing a base but differing in fields; include a method/constructor call and a global list or object graph whose initial state is empty/None. Check distinct field values and class identities, not only a scalar total, so swapped tags/offsets cannot accidentally pass. Include a shared child and a cycle either in this fixture or a companion test. Retain a small actual Richards_super deployment probe after this fixture passes; performance measurement is separate.

Negative cases should establish safe fallback **before effects** and exactly-once execution through the wrapper:

- Changed helper or method code, constructor/default, baked global constant, relevant builtin or MRO binding before the first runtime call.
- A relevant method/global/code binding changed after one successful AOT call, proving per-call guards still work.
- An unseen subclass, changed field type/attribute set, or incompatible argument signature.
- Missing, stale or malformed schema/module/version information. Do not invoke reducers/descriptors/custom constructors while rejecting it.
- A compiled guarded failure after a heap mutation, and an array store if arrays are supported by the new path; confirm private-heap effects stay uncommitted and direct writes roll back before fallback.
- Mixed signatures and `--force`: preserve existing JIT-budget policy; do not falsely report all-AOT execution from loaded exports alone.

For NumPy regions, account for the existing `_nd` eager Numba import separately. Reuse correctness and absence of JIT are different assertions from universal absence of imports; do not claim that limitation is fixed unless the implementation actually changes and tests it.

## Current status and next review

No costly AOT builds, full suites or timings were run during this design review. No implementation verdict is available yet. Once the implementation is committed, review its diff against the threats above and independently run the small positive real-export cross-process fixture plus selected guard-negative cases. Any remaining unsupported binding/type shape may conservatively fall back; broad complete-Python coverage is not a condition for this bounded improvement.

## First WIP implementation review

Inspected the first uncommitted seed implementation in `heldout-fixes` (new `_region_seed.py` plus heap/runner changes), after the implementer reported six real-extension regressions passing. No costly/native tests were run independently at this stage. The following concrete findings were sent immediately to the implementer and coordinator; they require resolution before approval.

1. **Changed bindings execute hooks before rejection.** `Bindings.resolve` applies generic `_unwrap(value)` before checking whether the final value is a plain class/function/module. `_unwrap` calls `getattr(value, '__recompyler_original__', value)`. If a saved class or function binding now points to an arbitrary instance, resolving it runs user `__getattribute__`/`__getattr__` before rejection and Python fallback. `review-scratch/wave3/binding_hook.py` confirms an extra `__recompyler_original__` attribute access. Resolve raw values and unwrap only exact plain functions via hook-free dictionary access/type validation; avoid final-value descriptor/metaclass/module hooks.
2. **Nullable widening may change the native signature.** The seed intentionally widens object kinds to nullable and recompiles a separate export, but `build_regions` initially assigns the original overload signature to that new source. For `maybe_numeric(node): if node is None: return 1.5; return 3`, profiling `Node()` produces `INT` return ABI `['i']`; replaying its nullable seed produces `MIXED` return ABI `['f', 'b']` and tuple returns. Reusing the original int64 signature for that source is invalid. Source-only probe `review-scratch/wave3/nullable_signature.py` proves the ABI change without importing Numba. Compare normalized entry parameter/return machine ABIs before reusing a signature and decline incompatible seeded exports, or deliberately derive and validate a separate correct native signature.
3. **Malformed seed structure can escape as an internal exception.** A valid seed for `read(node): return node.x`, with `families=[]`, passes restoration and raises uncaught `KeyError(Node)` during `seeded.compile`. `review-scratch/wave3/malformed_seed.py` reproduces this. Restore's malformed-metadata exception conversion does not cover subsequent seed generation. Validate family/class/member/schema coherence and ensure isolated expected metadata reconstruction/generation failures decline the candidate instead of crashing the user call. This does not execute an unsafe kernel, but fails the graceful malformed-artifact rejection requirement.

Positive observations in the initial WIP: seed identity is incorporated into the digest, `_region_seed.py` bytes are now included in compatibility hashing, normal class registration runs before seed layout replacement, code/default fingerprints are checked, live globals are loaded rather than restored, and the AOT-only adapter remains active. These observations do not supersede the open findings or establish the later cross-process execution gate.

## Implementation re-review at ee71999 / 20d53bd

Reviewed the complete seed implementation diff from `dba45a7` through `ee71999`, then the execution-counter/fingerprint delta committed as `20d53bd`. **Current verdict: changes still required for one remaining rejected-metadata hook path. Do not treat this section as approval to freeze.** The implementer confirmed the issue and will fix it after the currently frozen suite completes.

### Disposition of the three initial findings

- **Nullable native ABI mismatch: resolved.** `build_regions` now compares normalized entry return machine types and parameter machine types before assigning the existing native signature; changed constant-return contracts are also declined. My original source-only probe still demonstrates the intended widening from scalar int to mixed tuple, while `review-scratch/wave3/check_review_fixes.py` invokes the actual export-selection code with a no-op compiler and verifies only the legacy export is retained and no invalid seed export is emitted. No Numba/compiler build was run by this check.
- **Malformed family metadata crash: resolved for the demonstrated case.** Family coverage/overlap validation now rejects the inconsistent schema. Expected metadata/reconstruction failures during isolated seeded generation are caught, and the default AOT-only policy stops instead of falling into ordinary inference. The same independent script verifies `families=[]` cleanly produces no program under `_AotOnlyExports`.
- **Hook-free rejection: partly resolved, one concrete path remains.** The original `binding_hook.py` now records no lookup: `Bindings.resolve` returns raw values and unwraps only exact plain functions via their dictionary. However, the restore-global namespace branch still performs `refs.resolve(path).__globals__` for `location[0]=='function'`, and `vars(refs.resolve(path))` for `'module'`, before checking the resolved object's type. Corrupted JSON can point these paths at an arbitrary live replacement object. My new `review-scratch/wave3/global_binding_hook.py` records `['__globals__']` and `['__dict__']`, respectively. The function variant is eventually rejected, but has already executed a user hook. The module variant can continue with the arbitrary object's dictionary until a later digest miss. Require exact `FunctionType` / `ModuleType` before either namespace access. Add both variants to the rejected-metadata hook regression.

The remaining issue was independently reproduced after the coordinator identified the unchecked namespace accesses. It is a continuation of the original no-hooks rejection finding, not a newly alleged unsafe native execution. No kernel ran during the reproduction.

### Other checked implementation properties

- Source matching now includes canonical JSON seed identity, and compatibility hashing includes `_region_seed.py` bytes as well as heap/lifter bytes and Python version. Thus a changed reconstruction implementation or seed does not silently reuse an old export merely because some emitted field accesses happen to match.
- Normal class registration/constructor validation occurs before seed field/member replacement. Rebound MROs and function/default fingerprints are validated. The final fingerprint also includes exception-table and cell-variable metadata. Live per-call guards are regenerated, rather than replaced with captured global state.
- Type cells are allocated before their contents are restored, preserving shared/cyclic type-cell references. No mutable application values or executable object pickle is in the schema. Runtime loaders still validate current graph values and retain their alias memo. The worker's committed native tests cover shared cycles, both loaders, and post-success changes to constants/helpers/defaults/constructors/MRO/types/fields; I did not duplicate those native builds.
- All object kinds are widened to nullable in the inference seed to preserve initially empty startup branches. A separate export is compiled when that changes source. The new ABI check is essential and present; unsupported/incompatible normalization may safely retain only the original legacy exact export.
- The default runner AOT-only miss policy remains in force. Seed reconstruction attempts do not start JIT; failed seeds under that policy no longer invoke normal inference on a changed binding. Force/JIT-budgeted behavior remains separate.
- `aot_calls` / `jit_calls` increment only after the selected program completes result conversion, heap write-back and RNG state commit. Preparation, retry, guarded failure and Python fallback do not increment these mode counters. Runner ordinary-AOT versus ordinary-JIT attribution uses the actual prepared wrapper. The conservative `ahead_of_time` compatibility boolean remains separate from exact counts. No static counter defect was established.

### Review limits

Only inexpensive source-generation/rejection probes were run independently in this stage. I did not repeat the implementer's 39/43 native/runner checks, build the native fixture, run Richards, run a full suite, or measure performance. The coordinator owns the real Richards fresh-process native gate and the implementer owns the final complete-suite run. After the namespace type-check fix lands, re-run the small hook probe and inspect that exact diff; then this review can provide a final scoped verdict with the corrected commit.


## Strict/widened seed follow-up — 1b570ba6f7a23ed56b3b43c6643e2006838abddc

The correction for mixed strict-only and widened signatures is sound within its bounded delta. Both seeds are independently restored, regenerated and bound by metadata/source digest; native source is shared only when byte-identical, and the existing ABI/constant-return gates remain. Runtime all-candidate rejection still fails closed. Independent `review-scratch/wave3/mixed_selection.py` exercises the actual build selection and runtime loader/guard logic with no-op compiler/test export substitutes: both argument orders and both loaders reuse both signatures, and an unrelated None seed does not authorize a poisoned object-only helper. No Numba was imported. This is a lightweight control-flow check, not a substitute for the implementer's real native regression.

**A newly established guard-dependency finding prevents a final approval of this revision:** the widened export may contain functions first discovered during normalization, but the saved seed's function fingerprints come only from the original profiled program. A profile-populated object graph can fold away startup construction, leaving the constructor out of the original `program.functions`. Widening to nullable reintroduces that branch and emits constructor code without adding its build-time fingerprint to the saved seed.

Source-only reproducer: `review-scratch/wave3/startup_code_guard.py`.

```python
class Node:
    def __init__(self, value):
        self.value = value + 1
# STATE.root is populated while preparing the original program.
def step(value):
    if STATE.root is None:
        STATE.root = Node(value)
    return STATE.root.value
```

Both saved seed function lists contain only `$entry`. After export selection, replace `Node.__init__.__code__` with `old.replace(co_code=changed_init.__code__.co_code, co_consts=changed_init.__code__.co_consts)`, where `changed_init` adds 9. Keeping the original filename/first line deliberately leaves the source text readable by `inspect` unchanged. With `STATE.root=None`, actual Python returns `16` for `step(7)`, but seeded source generation still accepts the old AOT digest and its generated constructor adds 1. The probe observes `program.ahead_of_time=True` and the stale generated code; it does not execute or build a native kernel. A real execution of that generated constructor would disagree with the current Python code.

Required correction: bind and validate all code dependencies of the **normalized export**, including functions discovered solely through widened startup branches. A saved dependency manifest or a validated normalization/capture fixed point could address this; merely retaining the original function list does not. Validation must occur before treating current object identities as fresh guards, must avoid user hooks, and must participate in seed/export compatibility. Include a source-preserving bytecode-change regression for a startup-only constructor/helper, since changing it to a lambda with unrelated source already fails for other reasons and does not cover this gap.

The finding and exact probe were sent immediately to coordinator and implementer. The previous scoped verdicts remain historical; this new evidence requires a follow-up before freezing the corrected study source.
