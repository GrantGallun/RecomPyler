# Direct-access design refinement

Independent design analysis only. This note changes no product source, tests, builds, or measurements. It refines `DIRECT-DESIGN.md` using the current `heap.py`, `scalar.py`, `lift.py`, installed CPython 3.14 headers, installed Numba wrapper code, and the source references below. Proposals here require implementation and behavioral verification.

## 1. Numeric identity is part of the representation

A pointer table alone is insufficient. The present `_Unloader.result` reboxes numeric values and `_unchanged` can suppress equal-valued replacements. Neither operation is a valid identity rule for direct execution. For example, after `f(c, x): c.x = x; return c.x`, both the stored and returned references must be `x`, even when the previous `c.x` has identical numeric bits. A read-only `return c.x` must return the original box. `_Unloader.made` preserves record/list identity, but does not solve these numeric cases.

Use a backward identity-demand analysis and a small provenance side channel. Keep current arithmetic payloads; add a token only to numeric definitions whose identity can reach an observable use. The demand roots are region returns, stores into escaping objects/containers, numeric `is` if supported, and identity-requiring callee parameters/returns. Unknown calls already require fallback. Propagate demand through assignments, unpacking, selected conditional branches, loop-carried values, call summaries, and loads/stores of identity-demanded fields/items. Compute interprocedural and recursive summaries to a fixed point, similarly to the existing escape summaries. An output object containing numeric fields makes those field values roots too.

Each demanded dynamic definition has a token with one of these meanings:

- `Existing(box)`: an entry argument, live field/item load, guarded global/default, or actual code constant. The token owns a strong reference; multiple appearances of the same box retain the same identity.
- `Deferred(definition_id, kind, payload, recipe)`: a particular executed producer that has not yet needed a Python box. It has an initially empty materialized-box cell.
- A control-flow merge selects the incoming token at run time. It must not replace distinct tokens with one merely because their numeric payloads compare equal.

`force_box(token)` returns a new reference to its existing/materialized box. Materialize a deferred definition once, cache it in that token, and use that same box for every alias. A loop execution creates a new dynamic token when the producer executes; a static AST site is not a token identity. Liveness and single-use analysis can later eliminate token allocation where no alias can survive.

Assignment, extraction, normal parameter passing, and return forwarding preserve tokens. Numeric widening into MIXED preserves the token when it changes only the compiler representation. **Backward demand stops at an independently boxable arithmetic producer:** demand its result token, but do not demand tokens for numeric operands merely because they feed arithmetic. Certify this producer category by opcode and exact operand kinds: its Python result must be a newly created numeric object or the canonical integer/bool singleton selected solely by result kind/value. The result can then be boxed lazily from the existing checked payload without retaining operand boxes. Small-integer canonicalization belongs in the box builder, not in a claim that every arithmetic result has distinct identity.

Keep a separate alias-producing category. Exact `float(x)` on a float and unary plus on an exact int must forward the appropriate operand token; conversions and other operations need explicit identity transfer rules. For an operation not yet certified independently boxable or alias-producing, implement its demanded case with the exact C numeric operation on boxed exact operands, unbox its result, and retain that result token. Only this conservative opcode path demands its operands' provenance. Existing range/overflow checks still apply.

The resulting demand graph follows moves, phis, call pass-through summaries, and arena/field stores until a certified fresh/canonical-result producer or Existing origin. Arithmetic-only vector/scalar clone parameters do not gain provenance arguments. Add hidden token parameters only for numeric leaves that a callee forwards, stores as that same value, returns, or otherwise observes by identity. For a callee that computes and returns a fresh arithmetic result, its return carries a token, but its numeric-only arguments need none. Scalar clone ABI growth is therefore driven by this analysis, rather than doubling every numeric argument. Report token parameters and demanded producer counts alongside scalar-replacement reach to expose an accidental broadening.

Constants need their original identity. Use the original function's `co_consts` and bytecode/source-position association; do not obtain identity from a newly compiled generated literal. For an ambiguous demanded constant mapping, decline the direct version before execution. Globals/defaults contributing an Existing token need identity guards, not an equality-only guard that accepts a replacement equal-valued box.

Implementation points:

1. Add numeric provenance to the checked value IR, not to the global meaning of `_width` immediately. An explicit numeric-leaf token vector can accompany the present `(kind, codes)` during direct-version generation.
2. Extend `_Gen.copy_codes`, `coerce`, `assign`, `var_codes`, `call`, `do_Return`, `slot`, and `store` to transfer tokens. Tuple/optional leaf positions need the same flattening discipline as their payloads. MIXED has one provenance token for its payload/tag pair.
3. Add a shadow token entry per demanded arena numeric location. A store forwards its token; a load reads that token. This includes private local records/lists that later forward a value into a live object or result.
4. Extend `ScalarReplacer.virtual` and scalar clone parameter/return/mutation plumbing with provenance for demanded numeric fields. Otherwise scalar replacement destroys identity even when ordinary `_Gen` is correct. Keep this metadata through scalar lowering, then emit live-access intrinsics after scalar replacement.
5. The C envelope constructs numeric results with `force_box`, and journaled stores publish `force_box`'s reference. Skip a store only when the actual pointers are identical. Never suppress it merely because `_unchanged` reports equal numbers.

A sound initial restriction is available while implementing this analysis: admit a direct region only when every numeric value reaching a store/return is tracked by the above transfer rules, and every demanded producer has an implemented identity rule. This is computed over the whole region and its callees; it does not assume anything about the caller. Arithmetic-only internal values remain unboxed. Read-only numeric returns and direct argument-to-field stores are early useful cases, not exclusions.

Required counterexamples include `t=c.x; c.x=y; return t`, equal-valued distinct inputs, `c.a=x; c.b=x`, `t=x+1; c.a=t; c.b=t`, two distinct large arithmetic results with equal values, loop/phi forwarding, shared defaults, constants from different functions, and a scalar-replaced temporary whose field later escapes. Assert pointer relationships in addition to numerical results.

## 2. Raw replacement of an existing instance-dictionary value

Use a version-specific C helper compiled against the installed headers. Read-only entry must use nonmaterializing managed-inline/split/combined access. A first dictionary-store implementation must handle inline replacement directly or require an already materialized dictionary; it must not force nested __dict__ creation during preparation. Resolve an already-present exact Unicode key to its physical value slot in split or combined storage, retain the dictionary and owner, and record the storage pointers/key/index. Final validation checks exact dictionary/class/access semantics, occupied key, original value identity, storage identity, and zero watcher bits. An owner may alias another input; canonicalize by physical location. Reject insertion, deletion, resize, custom descriptors, and key/topology mutation for this transaction.

Installed headers define watcher bits separately from watched-mutation bits. CPython's existing-value update replaces the value and sends a modification notification; key insertion separately invalidates the key-layout version. Consequently an existing-value replacement must not pretend to be a key-layout mutation or reset unrelated metadata. [CPython dictionary implementation](https://github.com/python/cpython/blob/v3.14.0/Objects/dictobject.c#L1650-L1734)

The first two watcher IDs are reserved for CPython. Its globals watcher invalidates dependent executors, increments the watched-mutation counter, and unwatches the dictionary. Therefore rejecting only user watcher IDs is unsound. Reject every watcher bit, preserve the full tag/counter, and never erase or synthesize its counters. With no watcher and no callback/GIL release during the envelope, no watcher can become installed between validation and replacement. [CPython optimizer analysis](https://github.com/python/cpython/blob/v3.14.0/Python/optimizer_analysis.c#L48-L75)

The raw existing-value helper can then implement the same pointer replacement/refcount effect without a dictionary lookup or notification dispatch. The old and replacement values must both be exact supported numeric objects. Reserve/append the undo record before the pointer changes; the record owns the old reference. Give the destination its new reference and release the displaced destination reference. On rollback, reverse that ownership transfer before any Python return. Numeric objects have no finalizers or weakrefs, so retaining the old numeric reference until commit adds no Python destruction callback. Record owners remain pinned and topology does not change. Do not add a universal dict version increment: for this guarded subset it would not match the ordinary existing-value operation.

Preserve `ma_used`, key pointers/version, split insertion-order metadata, GC tracking state, and watcher tag on both success and rollback. Storing exact untracked numeric values does not introduce a tracked child into an untracked dictionary. Existing CPython attribute caches that retain a slot/index continue to see the new slot value. The watcher guard covers executor dependencies that would cache a value. A dictionary that is also used as some function's globals is eligible only when the same all-watchers guard holds; do not infer safety from its association with an instance.

Use header-provided masks and layouts; `pycore_dict.h` and `pycore_dict_state.h` require a carefully scoped `Py_BUILD_CORE` inclusion and exact ABI/cache fingerprinting. This is intentionally a CPython-build-specific helper, not a stable-ABI extension. Validate against the actual runtime build; the linked 3.14.0 source explains the observed header contract but does not establish compatibility with arbitrary 3.14 patch builds.

The final C validation must happen after all map allocation, dictionary materialization, program preparation, and Python guard execution. None of those preliminary steps makes a saved raw slot stable by itself.

## 3. AOT wrapper invocation versus a raw adapter

The installed vendored `_pycc/compiler.py` exports CPython wrappers and makes their native body internal. `_pycc/modulemixin.c` wraps the C wrapper in a real PyCFunction with its environment closure as `self`. Installed Numba `core/callwrapper.py` performs argument unboxing, an optional GIL release, native execution, cleanup/reflection/NRT decrefs, return boxing, or exception reconstruction. Bypassing Python call dispatch does not bypass these operations.

A useful restricted AOT envelope can invoke an exact audited CPython wrapper directly:

1. Before final validation, obtain and pin the actual exported PyCFunction, its owning module/environment, and its prepared exact argument tuple. Validate the wrapper registration, certificate, source/ABI digest, function flags, and expected signature. Exact PyCFunction type alone is insufficient: arbitrary extension functions share that type.
2. In C, inspect its calling flags and use the corresponding function-pointer type. For the current audited `METH_VARARGS | METH_KEYWORDS` wrapper, call `PyCFunction_GET_FUNCTION(fn)` as `PyCFunctionWithKeywords` with `PyCFunction_GET_SELF(fn)`, the prepared args tuple, and NULL keywords. The closure self is required; the module is not a substitute.
3. Prove all input unboxers read exact trusted types, all reflected/native-owned cleanup is absent or non-observing, `release_gil` is false, and all native exits return through checked status rather than a Python exception reconstruction path.
4. Certify the post-native return path. None and a single ordinary numeric box can avoid tracked allocation. MIXED, tuple, and record returns require separate treatment. In particular a tuple of native result codes is GC-tracked, so its boxing cannot occur while live stores remain speculative.
5. Immediately inspect status and commit/restore inside C, before returning to the interpreter. Raw C function-pointer invocation avoids interpreter-level call dispatch/profile events; an outer `PyObject_Call` is not an equivalent proof.

This route can cover kernels whose entry returns None, but only with a compiler-issued wrapper certificate and inspection of the generated wrapper/cleanup path. It must not become permission to call arbitrary AOT wrappers inside a transaction. Exact numeric inputs still need provenance from the original call; reboxed machine arguments do not replace the original entry box tokens.

The preferred common JIT/AOT design is a small fixed C-ABI adapter:

`int invoke(DirectContext *ctx, const ArgPack *args, ResultPack *result)`

The adapter calls the compiled body using the compiler's own internal call-convention lowering, translates unexpected native exception status to a rollback code without constructing a Python exception, and writes raw results plus provenance tokens into ResultPack. The C trampoline owns all Python references and completes safe result boxing plus commit/rollback before returning. No generated native function address or Numba internal ABI is cast directly to this public signature.

For AOT, emit this adapter in `_pycc/compiler.py` while the native symbol is available and expose a typed/name-versioned capsule from module initialization. For JIT, emit the identical LLVM adapter in the finalized library, obtain that adapter's address, and keep the compiled library/environment strongly alive in the execution descriptor. Neither a Dispatcher object's address nor its generic `.ctypes` property is the native entry contract. Calls occur directly from `_heap.c` under the held GIL; do not call via a ctypes trampoline that may release it.

Bind capsule/descriptor validation to the context ABI version, pointer widths, Python/header fingerprint, generated source digest, and adapter signature. Function pointers for runtime helpers are injected into the per-call context, not serialized as process addresses. Preserve the existing source-only/AOT lookup path: importing a saved AOT artifact must not require Numba.

## Implementation order and invariant

First implement token-preserving pure readers and original-box returns; then typed numeric stores with existing/constant provenance; then demanded arithmetic producer recipes and transitive clone/phi support. The direct entry certificate should enumerate supported producers, live locations, observers, wrapper/adapter ABI, and return materialization. Every rejected capability selects the existing arena version before a live mutation.

The invariant is: at each permitted Python observation boundary, original graph identity/value relationships match the Python execution; during the interval with speculative live stores, no Python observer, GC collection, pending-call dispatch, GIL release, descriptor, dictionary watcher, or exception reconstruction runs. All failure paths restore before observation or replay. Numeric allocation is untracked, but the implementation must still audit allocator/helper behavior; if custom allocation hooks can call Python, use a validated allocator capability or preallocated transaction storage rather than treating untracked allocation alone as that proof.
