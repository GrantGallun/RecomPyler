# Task 2 preparation: guarded direct numeric reads

Status: PREPARATION ONLY. This document is an implementation proposal, not an implementation or a measured result. No product source, test execution, build, timing, or commit has been performed for this task. All draft tests stay in `inplace/task2-preparation/` until IMPLEMENT. Coordinator owns checkpoint/steering and acceptance gates.

## Binding objective and scope

Implement general direct reads for whole read-only input regions first. Retain existing arena execution as fallback. Exact float, bool, full signed int64 (including noncompact PyLong), homogeneous numeric exact-list cells, and ordinary supported instance fields are first-class inputs. MIXED keeps its current exactness domain; an INT field/list may contain 2**53+1 and both int64 endpoints. A MIXED int outside the existing exact-double domain declines before native execution rather than rounding.

No direct stores are activated. A mutating region can borrow a field/cell only when the transitive effects prove that no alias writes that numeric location and no native observer or topology change can invalidate it. Writes to other locations continue to target the private arena and use existing writeback. This extension follows whole pure readers; it must not substitute for them.

Existing constraints still apply: strict behavior, original identities, strong pins, no copied ABI constants, no persisted addresses, source-only/AOT operation without importing Numba, and preservation of scalar replacement. Bound evidence is `inplace/bounds/BOUND.md`: reads target payload loading and input writeback, not the separately measured preparation or new-output costs. No gain is claimed from the design.

## Compiler pipeline and ownership

Current pipeline is `_Program.settle` -> zero facts -> `EscapeAnalysis` -> `ScalarReplacer.run` -> recursive context/cycle lowering -> source assembly. Preserve this order. Add typed semantic metadata during checked generation, solve effects and identity demand on the stable function graph, let scalar replacement transfer that metadata for virtual fields/clones, and emit live access after scalar replacement. Never replace `_Gen.slot` expressions with opaque helpers before R8 recognizes fields.

Suggested files:

- New `src/recompyler/direct.py`: immutable plans, transitive effect fixed point, identity-demand fixed point, typed lowering and public diagnostic summaries. No Python object memory reads here.
- `heap.py`: collect typed operation metadata; create direct candidate next to ordinary candidate; select/prepare/fallback; numeric token-aware result/writeback and completion counters.
- `scalar.py`: preserve demanded virtual-field tokens and pass-through clone leaves; arithmetic-only clone inputs retain the existing ABI.
- `_heap.c`: ABI facts, guarded context construction, final validation, callback-free dispatch, strong ownership of borrowed values, token materialization.
- New small native adapter emitter shared by JIT and `_pycc/compiler.py`; AOT capsule exposure in the existing module initialization machinery.

The ordinary source and digest remain independently usable. A direct source/descriptor has its own digest containing ABI fingerprint, plan identity, semantic producer policy, and generated source identity. Selection failure must not make a normal program `broken`.

## Concrete Python APIs

Proposed internal contracts (names may adjust during implementation, meanings must not):

```
EffectSummary(
    reads, writes, topology, observers, allocates_private, raises,
    arrays_read, arrays_written, rng, recursive, unknown)
IdentitySummary(parameters, returns, escaping_slots, producers, unsupported)
DirectPlan(abi_version, layout_contracts, effects, identity,
           live_fields, live_list_roots, return_layout, helper_capabilities)
DirectPlan.report() -> dict
analyze(program) -> DirectPlan | DirectDecline
lower(program, plan) -> DirectVariant

_native.direct_abi() -> immutable compiled-source/header/layout ABI fingerprint
_native.direct_bind(capsule, expected_abi, expected_source_digest, owner)
    -> DirectEntry
_native.direct_prepare(plan, arguments, arrays, guards, entry_descriptor)
    -> DirectContext
_native.direct_execute(context) -> completion/status/raw-result descriptor
```

`DirectContext` is a C-owned object, not a user-extensible Python class. Before entry it pins the entry descriptor/library, exact already-bound top-level argument tuple, primitive/weak guard descriptors, arena buffers, and raw token storage. Current global graph values and class dependencies are resolved and pinned inside the fresh C walk; preparation must not retain an old global object across a callback that can detach it. It does not traverse or pin nested graph owners until direct_execute. The fresh C walk then owns required instance/list/dictionary/value references only for the atomic read interval; it releases non-result references before tracked result allocation. Descriptor/buffer allocations happen before the interval. Even this read-only task can delay finalization if a nested pin crosses an observer, so absence of direct stores is not a lifetime proof.

`Region.direct_calls` counts successful complete direct calls, parallel to `compiled_calls`, `jit_calls`, and `aot_calls`; preparation/validation decline/bailout/retry do not count. `Region.direct_declines` and `Region.direct_problem` are useful runtime observability, not test-only flags. `program.direct_report` describes effect coverage, supported producers, live locations, token argument count, and R8 reach. Tests must assert behavior and successful direct execution; generated-source snippets alone cannot prove entry.

## Effect and alias proof

Use a finite lattice keyed by the compiler's existing canonical contracts:

- Record location: `(program.family(cls), field_name)`; family merging happens before analysis.
- List content/storage: canonical `_find(ListT.cell)`; numeric cells share the mutation contract through every field, tuple, argument and call path.
- Global and parameter references use the same canonical location keys after substitution; a different access path never grants a second contract.
- Private allocation origins remain distinct from input-reachable locations when F2 proves they cannot alias inputs. A missing origin proof widens to the whole matching family/cell, not to no effect.

Every checked operation records typed reads/writes; assignments, augmented assignments, list setters, list slice/copy helpers, constructors, callbacks/method calls, arrays, RNG and internal calls are covered explicitly. For each function, union local effects with substituted callee effects; iterate SCCs to a fixed point. Unknown operation/helper has `unknown` and cannot silently be considered pure. A list insertion/deletion/append/reallocation invalidates its storage root; assigning an object link invalidates reachable topology as appropriate. Even if a topology update remains private in this task, avoid borrowing any location whose logical source can change until the analysis proves that source relation.

A candidate live location must be read, have representable exact shape, have no intersecting may-write, and have stable topology. A whole region can still allocate private native arena objects, perform checked arithmetic, recurse with the existing depth check, and fail through native status. These are separate from callbacks/Python observations. Do not equate shape eligibility with callback freedom. Existing field `program.written_set()` and cell mutation bits are conservative starting evidence, not complete effect certificates.

The native helper allow-list names each supported helper's memory effects and callback contract. Unknown calls, Python print/observer exits, unsupported array operations, arbitrary extension calls, and GIL release decline direct selection before entry. Native checked failures return status; Python replay happens only after context release/fresh loading.

## Live representation and loads

Keep logical handles, list headers, tags, private temporary objects, and alias maps. A parallel slot table holds `(physical_cell, owner, pinned_box, numeric_kind, provenance_token)` for live numeric leaves; absent entry means read the arena. `physical_cell` is a header-derived PyObject** address for the current field/list item; the owner and initial box remain pinned throughout the read interval. Repeated live loads dereference that cell, with all pointer validity established by the fresh walk. A cached-box-only first version is sound for proven read-only slots, but must be explicitly replaced by physical-cell lookup before future direct stores can publish replacements. MIXED's payload and tag slots point to the same pinned exact box and one token. Tokens are indices, not pointer-valued user data.

The C execution-envelope traversal assigns the usual canonical handles and topology slots but does not copy eligible numeric payloads into F/I. It validates each value's exact kind/range and pins it. Int64 decoding uses functions/macros compiled against the installed CPython headers; never assume a compact long or a copied digit/tag offset. Floats use the actual header-defined object layout. The runtime context supplies helper addresses and ABI metadata; generated caches contain no process address. The hot path uses inlined LLVM loads/decoders specialized from those validated header facts, rather than an indirect C call for every numeric use. See typed-ir.md for exact layout facts and the Step3 handoff.

After R8, lower typed numeric reads to native helpers/intrinsics that consult this table and otherwise read F/I. Audit every runtime helper that reads or copies numeric slots, including list iteration/slice/copy/fill and result reconstruction. A helper without an established transfer rule causes a computed decline for a reachable candidate; leaving the slot uninitialized while that helper reads F/I is forbidden. Ordinary handle/header accesses retain arena semantics. Do not add noalias: F and I remain views of one allocation.

A simpler universal `F/I` subscript rewrite is not sufficient by itself: I also contains topology and reinterpreted float bits, and list copies can transfer numeric identity. Typed operation metadata distinguishes these cases. Direct and arena branches must read equivalent kinds, with exact INT loads rather than passing through double.

## Numeric identity and demand

Returns, values stored in escaping input/new objects, numeric identity tests if accepted by the compiler, and callee identity requirements are demand roots. Solve backward to a fixed point across assignment/unpack, branch/loop merges, field/item shadow slots, and callee parameter/return summaries. A merge chooses the executed incoming token; equal bits never unify distinct tokens.

Represent numeric checked values with an optional leaf-token sidecar, leaving `_width` and ordinary arithmetic payloads unchanged. One token accompanies a MIXED value, not one per payload/tag component. Tuple and optional flattening uses an explicit numeric-leaf layout. Demand reaching an independently boxable arithmetic producer stops there: request a result token, not tokens for every operand. A callee computing a fresh result therefore need not double all numeric inputs.

Token categories:

1. `Existing`: index of a pinned original exact numeric box from argument, field/item, guarded global/default, or actual `co_consts`. Every alias of that box refers to it.
2. `Deferred`: dynamic producer instance, kind/payload, certified boxing recipe, initially empty materialized-box cell. `force_box` materializes once and caches the reference. Re-executing a producer in a loop creates a fresh dynamic token; a source site is not a token.
3. Forwarding: moves, pass-through calls, branch/loop selection, exact `float(float_value)` and exact numeric unary plus preserve the original token where CPython does. Kind widening for representation preserves it.

Certify independent producers by opcode and exact operand kinds. Float arithmetic produces a new exact float. Integer arithmetic follows CPython's canonical small-int allocation policy; boxing through the matching C constructor reproduces it. Comparisons produce bool singletons. Do not generalize this claim to all conversions/operations: `int(x)` on an exact int, float identity conversions, unary plus, and operations with operand-returning shortcuts need explicit transfer or exact-operation recipes. For an uncertified demanded operation, preserve the necessary operand tokens and defer the exact boxed recipe until raw reads stop, or record the concrete computed arena guard. An in-interval recipe additionally requires bounded work, no pending-call checks, and non-observing allocation; exact builtin operand types alone do not prove that. Demand operands only for the conservative recipe.

Original constants come from the function's real `co_consts` associated by source/bytecode position; a new generated literal is not the same box. Ambiguous demanded constant association declines direct selection with a named reason. Globals/defaults whose values escape have identity guards, not the current equality-only `const` guard.

A demanded arena field/cell has a shadow token slot; stores forward the token and loads retrieve it. Private scalar-replaced objects need the equivalent virtual token field. Scalar clone parameter/return/mutation plumbing includes only demanded numeric leaves. Include `token_parameters` and `demanded_producers` in `direct_report` next to `scalar_report` so broad ABI regressions are visible.

Preserve `_Unloader.made`'s handle-to-original-object semantics, not its retention of every input owner during conversion. The direct interval keeps a raw canonical owner map, then projects only references needed by the return/private output graph before releasing unrelated pins. An existing returned object needs only its own reference; do not recursively retain its children, since an output-time callback may detach them. Token-aware `result/value` use original numeric boxes for Existing tokens and force each Deferred token once. Input identity returns bypass rebuilding. For mixed regions, writeback must honor demanded tokens and skip only pointer-identical numeric replacements; equality-based `_unchanged` cannot erase a replacement with a distinct equal box. This is arena writeback, not direct publication.

## Final entry and adapter

Raw validity must be checked after all preparation immediately before native use. A separate Python `guards_hold()` followed by `program.run()` is unsound: profile/trace callbacks, signals, GC and compilation can run between them. Direct selection must prepare the entry, context, all arrays and tuple/object metadata before final validation.

Preferred common ABI:

```
int direct_invoke_v1(DirectContextABI *ctx,
                     const ArgPackABI *args,
                     ResultPackABI *result);
```

Generate this adapter with the compiler's own internal call-convention lowering. It constructs native arguments from prepared raw buffers, calls the already-compiled entry, and returns checked/raw status without Python unboxing/boxing, exception reconstruction, GIL release, or Python callable invocation. It is not a cast of a Numba internal function address or generic `.ctypes` entry. JIT keeps its compiled library/environment pinned. AOT exposes a named/versioned capsule bound to source digest and ABI fingerprint; source-only artifact lookup does not import Numba. Runtime helper pointers come through `ctx`.

The C `direct_execute` method performs the last callback-free validation and invokes that adapter while holding the GIL. Validate exact classes, MRO/access semantics, supported native slot descriptors, dictionary identity/storage/key set/value identity, list length/storage/items, all canonical alias contracts, numeric exact types/ranges, and callable/global/default identities. CPython-managed dictionaries are read through installed-header inline/dict layouts without materialization; the refined interval below supersedes any broader preparation interpretation. Check runtime/header ABI and reject free-threaded mutable graphs.

The Python-to-C call can itself raise a profile event, which is why final validation belongs inside `direct_execute`, after that event. On any failure, discard all raw mappings and release nested pins inside the envelope; do not use an already-loaded stale arena after a callback may have mutated inputs. Reload the ordinary arena or replay Python as the existing fallback contract requires.

No Python callback, pending-call dispatch, tracked-object allocation, GIL release, dictionary watcher dispatch, or unsupported native observer runs between final validation and the adapter's final raw read. Allocation inside native private arena is preallocated memory. Result boxing is after raw reads stop. Select and retain only the return-owned references and required deferred-recipe operands, then release unrelated nested graph pins before any tracked result allocation or observer. Unexpected native failures return a status; do not reconstruct Python exceptions while raw reads remain possible.

An exact audited AOT PyCFunction invocation could be an intermediate read-only implementation, but only if wrapper/unbox/cleanup behavior is certified and has no pre-native observation point. Exact PyCFunction type alone is not a certificate. The common raw adapter avoids maintaining two safety models and is the planned route.

## Preparation tests and activation order

Draft tests are in this directory and are not collected by the integration suite. They use normal `Region` calls and `direct_calls`; no mocks of arithmetic results or test-only production flags. Before implementation, run only the coordinator-authorized locked fail-first command after it opens IMPLEMENT. Native extension absence is an environmental prerequisite, not a reason for the feature test to silently pass.

1. Pure field/comparison and list-reader direct executions; aliases through record/list/argument paths; returned input list/record is original.
2. Read-only numeric returns preserve exact float and large-int boxes, signed zero/NaN bits, full INT endpoints, and 2**53+1. MIXED payload/tag/identity agree.
3. Forwarding through calls, loops/phis, private fields and scalar clones preserves sharing. Two equal fresh arithmetic definitions remain distinct while one forwarded definition is shared. Arithmetic-only clone parameters acquire no extra tokens.
4. Class descriptor/hook change after preparation declines before entry. A real profile callback at the C envelope entry resizes/reallocates a list or replaces a field/class; final validation rejects the stale map and fallback observes the new state.
5. No extra finalizer/weakref activity for safe borrowed inputs, unsupported finalizer/callback shapes decline, and explicit observer operations never run in a direct interval.
6. Effects exclude written aliases while allowing independent read-only fields; transitive list topology changes defeat borrowing. R8 still removes local allocation sites on a genuinely executed direct call.
7. JIT and saved AOT adapters have identical behavior; import of saved AOT without Numba retains the current product contract. ABI mismatch selects arena without entry.

Implementation sequence after activation: effect/identity analyses and source-only certificates; guarded C context + ABI; common adapter; token-preserving pure readers and runtime counters; full transfer/producer rules plus R8 metadata; non-overlapping reads in arena-mutating regions. Ask coordinator to launch exact locked commands for each red/green stage; never start a second lock waiter independently. Independent guard review precedes timing. Final report must distinguish implemented reach, computed fallback reasons, actual test logs, and unresolved measurement gates.

## Preparation self-review risks

The highest-risk intersections are late observers between load and entry, hidden raw numeric accesses in list helpers, identity loss in scalar clone ABIs, and reusing a prepared arena after a rejected final validation. The tests target all four. C shape validation must recheck class hooks even if old compilation guards still pass; current `guards_hold` does not itself constitute a complete layout certificate. No unsupported producer is silently waived: implement its token transfer/exact recipe or expose a computed whole-region arena decision with its counterexample.



## Installed API check and refined atomic read interval

The coordinator's separate linked-library JIT adapter is supported by the installed Numba 0.68.1 source (read-only inspection, no adapter has been compiled):

- `core/callconv.py:853`, `CPUCallConv.call_function(builder, callee, resty, argtys, args)`, uses the compiler's argument packer and returns `(Status, native_result)`. It allocates native return/exception slots on the stack; it does not itself Python-box the result. The adapter may test `status.is_error` and forward a raw error code. Dynamic native exception buffers require explicit non-observing cleanup or a certificate excluding their creation; simply dropping an exception-info pointer is insufficient.
- `np/arrayobj.py:189`, `populate_array`, fills data, shape, strides, itemsize, nitems, meminfo and parent using the active data model. `meminfo=None` and `parent=None` produce null native fields. Build these borrowed native array structs through `context.make_array(type)(context, builder)` / `context.populate_array`, not by copying a Numba struct layout. C owns the underlying buffers throughout invocation.
- `core/codegen.py:728`, `add_linking_library`, accepts and finalizes the dependency; `add_ir_module` rejects a finalized receiver. Therefore explicitly compile the root signature first, retrieve its `cres`, create a separate adapter library, declare the native entry with `call_conv.get_function_type`, add/link `cres.library`, add the adapter IR, finalize, and obtain the adapter address with `get_pointer_to_function`. Retain both libraries and the environment in the descriptor. Disk-cache libraries without linkable LLVM functions need a named arena fallback or separately emitted adapter artifact, as `_get_module_for_linking` explicitly rejects an empty function module.
- `_pycc/compiler.py:_cull_exports` already has each `cres`, native function name and call convention before library finalization. Generate the same adapter there while the symbol is available. Its module-init path must expose a named typed capsule, not a persisted address. Source/digest and ABI metadata bind the capsule to the expected plan. Capsule construction can be implemented by calling the stable C capsule API from module-init IR or a small audited modulemixin helper.

The installed CPython headers permit non-materializing record access:

- `internal/pycore_object.h` defines `_PyObject_GetManagedDict`, `_PyObject_InlineValues`, and their offset macros. `_PyObject_InlineValues` requires the exact supported flags and uses `tp_basicsize`.
- `internal/pycore_dict.h` defines `PyDictValues.valid/size/capacity/values`, dictionary key kinds, and `DK_ENTRIES` / `DK_UNICODE_ENTRIES`. Use header definitions and the exact heap type's cached keys for valid inline values. For materialized dictionaries use existing split/combined storage directly.
- Ordinary slot fields use validated exact member descriptors and the descriptor's header-defined member metadata. Reject accessors, custom attribute hooks, unsupported storage, non-exact dictionary keys, or any uncertain owner layout.
- `cpython/longintrepr.h` exposes the actual digit type, `PyLong_SHIFT`, sign masks and noncompact representation. A checked C decoder can accumulate magnitude into uint64 and separately apply sign, including INT64_MIN, without first rounding through float. Do not negate INT64_MIN in signed C arithmetic.

Updated interval: `direct_prepare` allocates context/buffer capacity and prepares descriptors but retains no nested input graph nodes. `direct_execute` does the actual fresh graph walk, canonical handle/map construction, strong pinning, final validation, adapter invocation, and release of non-result graph pins in one callback-free C interval. Raw pin/map arrays use malloc/calloc/realloc owned by C, not Python lists/dicts. No `PyObject_GenericGetDict`, tracked bookkeeping allocation, arbitrary attribute lookup, or Python allocator callback may occur after the first nested borrow. Every raw read is reached through live rooted owners in this fresh walk; no cached pointer is dereferenced across a Python observation boundary.

This is stricter than merely revalidating a previously pinned graph: a callback between preparation and validation could add `__del__` to a class and detach a child, causing even guard-failure cleanup of the old pin to finalize it later than Python. Keep only return-owned references when leaving the interval; release unrelated nested pins before tracked result tuple/new-object allocation or any other observer. Returned references remain alive exactly as return construction requires. For the mixed arena-writeback extension, result ownership and callback timing need the same explicit audit; pure readers land first.


## Preparation refinements and build proof

`typed-ir.md` specifies exact CheckedOp/Place/Producer records, finite transitive effects, deterministic source bindings, R8 scalar substitutions, and the final adapter ownership certificate. `test-eligibility.md` separates source-inspected existing declines from required successful direct coverage. The independent-review counterexamples are in `test_direct_read_review.py`, outside the integration suite.

Warm direct selection must bypass the ordinary `_Loader` and its Python object/list bookkeeping before the C walk. Initial schema discovery may still inspect a sample using existing mechanisms, but it must release sample/nested references before entering the direct call and cannot establish live-pointer validity. For managed-inline coverage, warm on one sample and invoke the cached program with a fresh untouched instance; otherwise initial `_seed` dictionary materialization could conceal the layout transition being tested.

Native build exit status is insufficient: setup.py declares optional extensions, so a failed compilation can leave an older .pyd while setup exits successfully. `direct_abi()` must embed a C-source fingerprint injected by setup and expose the actual header-derived layout/version facts. An independent post-build verifier compares the loaded binary with current C-source inputs and requires every direct API before any tests/timing. Missing/stale binaries are failed builds, never a silent optional-feature skip. `native-build-proof.md` specifies the evidence and digest inputs.

Initial positive reach is heap.Region. FFT selected kernels use lift.py/AotLifted; preserve that backend and do not credit heap direct reads with FFT benefit. Shared future direct-store ABI work needs separate lift integration and evidence.
The audit contract is in native-entry-audit.md: actual adapter prologue/epilogue
and completed C cleanup are recorded in raw memory, separately from the
independently observed successful/raising Python attempt. Exceptional finally
paths must retain evidence without masking the original BaseException. Neither
Region counters nor a C-envelope entry alone proves native computation.

class-lifetime.md identifies an additional strict-behavior prerequisite:
ordinary classes can themselves have weakref observers, and existing Program
maps/guards/ObjT/global _ESCAPES caches retain them. Persistent weak DirectPlan
metadata alone is insufficient. The full persistent dependency closure needs
weak IDs/per-call pins and positive class-lifetime tests; custom metaclass
finalizers remain rejected by the existing exact-type guard.

future-step4.md records later C-vectorcall and resumable allocation-safepoint
mechanisms. Those are future design only, not Step2 work or claimed coverage.