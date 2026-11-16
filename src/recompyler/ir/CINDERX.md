# CinderX-derived IR components

Reference: facebookincubator/cinderx at f3dc0e8, read-only in the sibling reference directory. Adapted files carry Meta's copyright and the complete MIT notice. No CinderX build or execution is required.

## Watch dependencies

`watch_dependencies(dicts=(), types=())` installs conservative dict/type watchers. Create the subscription **before** reading the objects that compilation will specialize. Mutation permanently invalidates it. Types are weak dependencies: class destruction invalidates without extending its lifetime. Dictionaries must be the original function's already-owned globals/builtins, not an extra root to application containers.

After creating the native entry, call `subscription.bind(entry, _entry_native.invalidation_api())` before publishing it. Keep the subscription in the entry's existing execution keepalive. The target is weak, and native weakref callback tokens do not own their subscription. A failed bind is not admission. `close()` disables the entry before releasing dependencies. Entry invalidation never releases executable memory during a callback; the existing entry still owns active execution.

This invalidates future dispatch. A specialization that can execute arbitrary code needs a subsequent explicit guard/deopt edge before reusing its assumptions. Watchers alone do not prove that an active body can retain stale constants across callbacks.

## Deopt state and reification

`deopt.py` defines `LiveValue`, `RefKind`, `ValueKind`, `FrameState`, `Snapshot`, `Guard`, and `DeoptMetadata`. One live table can describe multiple conceptual frames. Frame maps use live-table indices; -1 is an unbound local or a proved CALL self/NULL sentinel. Byte offsets identify real instructions; native code-unit indices are exposed separately. Stack heights are verified against bytecode CFG and exception-handler entries.

`prepare(metadata, frame_index=0)` builds a cold native plan. `_deopt_native.addresses()['reify']` has ABI:

```c
int reify(_PyInterpreterFrame *frame, PyObject *plan,
          const uint64_t *spill_words, Py_ssize_t word_count);
```

The frame must already be the matching, published, active original frame. Object words are borrowed pointers; integers/doubles are raw 64-bit values. Each distinct live value is boxed once per plan, then each destination gets its own stackref. The caller releases its native owned references after successful reconstruction. Existing source owners must either match the reconstructed owner or already have been retired at their original source boundary: the runtime refuses stale owners rather than moving finalizer timing to deopt. Cell/free slots require real cells. It preserves an existing pending exception and publishes its cause PC; ordinary continuations publish the next PC.

For canonical registered ordinary frames, the existing `resume_python(frame)` relinquishes the activation and calls `_PyEval_EvalFrameDefault`. For real executor frames, return the reified next PC, or NULL with a pending exception, to the original interpreter. The interpreter owns handler dispatch and frame cleanup. No replacement binder or frame engine is introduced.

`emit_guard` is an optional cold-edge codegen helper for vectorcall bodies. It emits a conditional branch; reification/resume/error callbacks emit code only in the failure block. Frame-ABI users return the interpreter PC instead. For a proved callback-free native lane, `emit_lazy_guard` creates its canonical frame only inside the failure block; successful guards perform no frame helper call or spill allocation. This does not certify entry binding or argument ownership. Real-generator tests also reify the existing generator frame, enter an original exception handler, yield, and resume with the original exception linkage. CPython owns suspension and exc_info throughout; this helper does not fabricate a new generator. Automatic inlined frame-chain reconstruction is not implied by the metadata model.

## Reference insertion plan

`plan_refcounts(graph, effects)` returns `RefcountPlan` keyed by `(block_offset, operation_index)`, plus `(source_block, edge_index)` actions before phi renaming. `Effects` explicitly declares every output, borrow support, stolen operand, ordered retired operand, memory write and possible arbitrary execution. Unknown effects and exception/suspension ownership fail closed. Borrow support uses strings for memory regions and integers for owned SSA values.

Owned values stay live until explicit original-source retirement or transfer. SSA last-use does not retire source locals. Memory/owner invalidation promotes live borrows before the invalidation; decref may run arbitrary finalizers. Joins reconcile ownership on individual edges and union borrow support; loops iterate to a fixed point. The current STACKREF emitter does not consume this plan automatically. Wave16 owns the consumer and validates its complete effects table and retirement semantics before activation.

## Borrowed CPython internals

`python tools/generate_borrowed.py` extracts only the declared functions from checked-in CPython **v3.14.4** source. It never loads or executes source code. The template and generator follow CinderX's UpstreamBorrow directive design. Generated identifiers are namespaced and the portability header rejects every other runtime ABI. The initial generated file supplies the consuming slice constructor needed by the generic slice path. Native addresses come from `_borrowed_native.addresses()`; its consuming constructor takes two owned object references, including on allocation failure.

The exact upstream source and PSF license are under `tools/borrowed/cpython-3.14.4`. Generation is deterministic and tested against the checked-in result. This focused extractor handles functions, not conditional declarations or a transitive dependency graph; new internal helpers must supply all dependencies and pass a local native build before consumers use them.

## Optional global preloading

`preload_function(fn)` installs watchers before reading LOAD_GLOBAL dependencies. It accepts exact function globals/builtins dictionaries whose keys are exact strings, using a native callback-free lookup. Each binding records its bytecode offset, origin and identity without owning the cached application value. The metadata holds the function weakly and refuses code replacement or dependency mutation. `resolve(binding)` checks the subscription and identity again; compilation must still guard after arbitrary runtime callbacks.

Use the context manager or `close()` while preparing a candidate. `detach_dependencies()` transfers the subscription to an accepted entry's execution keepalive, where it must be bound before publication. Reading metadata alone does not activate specialization, invoke target code or admit a function. Descriptors and callees are not yet resolved by this focused global preloader.

## Optional M2 planning and proof queries

`inlining.map_call_args(code, positional_count, keyword_names, positional_defaults=...)` maps vectorcall operand indices to positional/keyword-only parameters, surplus `*args` and ordered `**kwargs`. It never captures operand/default objects. Missing positional defaults are guarded tuple indices, including CPython's right alignment when defaults outnumber parameters. Keywords must be an exact tuple of exact strings. Duplicate/unknown names, positional-only keywords and missing keyword parameters decline to canonical binding. No new call binder is installed.

`plan_inlining` reserves an opcode-count budget, ranks smaller callees first with stable discovery ties, and refuses recursion, depth, cold calls and suspending scopes. This is the mapper/cost-model portion of the inliner. A graph consumer must still supply callee identity/code/default guards, original pre-call Snapshot, per-inline FrameState, exact source retirement and reconstruction of every observable frame. No graph splicing or inline frame-chain runtime has been enabled by this batch.

`type_lattice.TypeSet` is a finite bit-set lattice with union, intersection, conservative subtraction and subtype queries. Exact builtins, all other objects, NULL and native signed/unsigned integers/doubles/bools are disjoint atoms. Exact numeric literals preserve float/complex bit patterns; numeric identity is not assumed. Application subclasses conservatively occupy OTHER_OBJECT without owning class/instance objects or invoking metaclass protocols. Dynamic subclass specialization, mortality and native pointer literals have no proof representation yet. Unsupported operations fail closed. This new lattice is optional and does not replace the existing shared `types.py` vocabulary.

`simplify` answers type-guard, numeric/None constant-truth and proved tuple-index queries without invoking application protocols. Callers must retain the facts that justify a result, original error PC, owner retirement and deopt state. The queries do not themselves delete operations or change the emitter. `SIMPLIFY-CATALOGUE.md` records the larger upstream checklist as candidates, without performance or deployment claims.
