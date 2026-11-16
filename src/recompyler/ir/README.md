# Native IR backend contract

This is the direct llvmlite path from CLAUDE-BRIEF-ir.md. It requires release,
GIL-enabled 64-bit CPython 3.14.4. It does not use Numba or NRT. Existing
frontends retain their own admission paths. This scaffold alone does not admit
source functions or establish the M0 performance gate.

## Native entry

    create_callable(original_function, body_address, keepalive, guards=(),
                    *, runner_address=0)

The result is a GC-tracked NativeEntry with a real vectorcall slot and a method
descriptor. keepalive must retain every machine-code module/provider referenced
by the body, runner and guards. The entry retains the original function but does
not retain retired default tuples. CPython function watchers invalidate code,
default and kwdefault replacements. The original function must still have the
standard CPython vectorcall slot. Closure/default contents used generically must
be read live; specialized assumptions need explicit guards.

Body ABI, with the GIL held:

    PyObject *body(PyObject *original, PyObject *const *args,
                   size_t nargsf, PyObject *kwnames);

Original, vectorcall operands and names are borrowed. The result is a NEW
reference, or NULL with a pending Python exception. nargsf retains its offset
flag; borrowed args[-1] may only be changed/restored when that flag permits it.
The body owns binding, operand retirement, error cleanup and source semantics.
Do not expose a raw test body as semantic compilation without those checks.

Each guard is a native int guard(PyObject *original), free of application
effects: 1 enters, 0 vectorcalls the original before any effect, -1 propagates a
pending error. Guards must not retain borrowed inputs. Active tracing, profiling,
monitoring, handled exceptions and custom evaluation hooks take the original
path. The entry checks native recursion limits around the body/runner.

A canonical source-frame barrier uses:

    PyObject *runner(void *body_address, PyObject *original,
                     PyObject *const *args, size_t nargsf, PyObject *kwnames);

The shared source-frame provider owns argument binding, original source slots,
PC/error mapping, traceback materialization and mandatory unwinding. A native C
array is not a source frame. runner_address=0 is useful for isolated ABI tests;
it does not prove arbitrary callback/frame semantics. No new frame model or
second argument binder is introduced here.

## CPython and helper exports

CPythonSymbols.declare(module, name, result_type, argument_types) registers the
actual CPython address with LLVM and returns a checked function declaration.
declare_global(module, name, value_type) declares exported storage, such as the
PyObject* slot PyExc_ValueError; load it to obtain the exception class.

register_external(name, address, keepalive, aot_library=None) shares the same
resolver for native helper DLLs. The registry pins the provider for process
symbol lifetime and rejects conflicting addresses. aot_libraries(names) rejects
helpers lacking declared import linkage. No helper import library is invented.

emit_object(module) verifies and emits a native AOT object. On Windows it selects
codemodel='default' for COFF; llvmlite's jitdefault deliberately emits ELF for
MCJIT. It marks declared exported data as dllimport in the AOT copy. aot_linkage()
returns the actual development include/import-library paths. The tests link and
execute both a function and exported exception storage against python314.lib.
A pure LLVM DLL without a CRT entry point is linked with /NOENTRY.

Local build and checks (from the clone):

    python tools/build_ir_entry.py
    python -m pytest tests/test_ir_entry.py tests/test_ir_symbols.py

The normal optional-extension build also includes the native entry. No global
installation is required.

## Census

The legacy admission count and each function's ir_path are separate. Only
ir.compile_function returning an actual NativeEntry counts as native IR
compilation. Builder graphs never count. No census target body executes, and
all native counts remain admission-only until independent execution/fuzz and
self-host gates pass. Resume requires the exact source population and unchanged
tracked/untracked compiler source.

## Common LLVM lowering and guarded traversal loops

`lower(graph, structure_calls=None, readonly_loops=False)` produces a
`LoweredFunction`; its `keepalive` pins the graph, original constants, engine,
symbols and primitive caches. It is low-level code generation, not semantic
admission. `ir.compile_function` remains absent.

The optional readonly pass recognizes SSA control/data flow for attribute and
mapping traversals without checking function/module names. Guarded attribute
reads must be callback-free; mapping fusion additionally checks the entire
resident key domain and each current key. A miss resumes the original with the
current local before any application effect. Chunks are bounded before returning
to CPython. The fast body borrows the vectorcall inputs for its entire invocation:
this lane must not be combined with owned-CALL local retirement without an
independent external-anchor proof. It is disabled by default.

## Canonical owned-CALL experiment

The same source provider exposes the following optional raw addresses:

    run_owned_vectorcall(body, original, args, nargsf, kwnames, actual_callable)
    PyObject *current_callable(void);  /* borrowed; NULL outside owned runner */
    int claim_call_args(frame, actual_callable, args, nargs);

The six-argument runner uses the existing Boundary and cleanup path. It makes no
automatic ownership claim. The five-argument runner has NULL callable context.

`claim_call_args` requires the active registered canonical frame to own every
argument already. It validates the original interpreter caller's opcode, exact
callee/null-self prefix, argument count and all actual argument words before
replacing consumed words with immortal None and releasing their prior owned
references. A record is single use. Ordinary unbound CALL and specialized
Python-call guard-miss sites are supported; bound-self scalars, expanded/keyword
calls, C API callers and synthetic native source callers are declined. Returns
1 for claimed, 0 for unsupported, -1 with an exception for invalid activation.
The body must not reuse retired raw argument pointers after the claim.

Direct temporary-argument lifetime, source-frame/error and rejected-context tests
cover this narrow experiment. Caller-stack GC/publication and the remaining
entry contexts are still admission obligations; neither calling an original via
C vectorcall nor this primitive establishes general Python-CALL equivalence.

## Existing-frame body ABI

`lower(graph, frame_entry=True)` uses the same generic opcode emitter with:

    _Py_CODEUNIT *body(_PyInterpreterFrame *frame, _PyStackRef *sp,
                      PyThreadState *thread);

`LoweredFunction.abi` is `frame` for this form, `vectorcall` otherwise. The caller
must supply the currently active, already-bound original frame at an empty-stack
function entry. Code identity, active frame and initial stack depth are checked.
Header-derived offsets describe the actual pinned CPython frame/thread objects.
No frame is allocated, linked, rebound, unlinked or popped by this body.

On a return it publishes the original operand stack and returns the original
RETURN_VALUE instruction address. CPython owns result promotion and frame
cleanup. On an error it publishes source PC/stack and returns NULL for the
interpreter's error path. Both exits clear the borrowed current-executor field
as the tier-switch ABI requires. Entry installation, tracing/monitoring guards,
executor keepalives and invalidation remain the entry owner's obligations.

The existing borrowed-loop lane is rejected with frame_entry=True: mutable
owned locals require an independent lifetime proof before borrowed traversal.
This optional ABI has no automatic installation or general semantic admission.

An optional `entry_offset=<original CFG block offset>` starts an existing-frame
body at that block using the frame's current locals. It requires a verified
empty-stack block; unknown/interior offsets, nonempty-stack blocks and use with
the vectorcall ABI decline before code generation. `LoweredFunction.entry_offset`
records the selected block. The caller must already have executed the prefix and
supply the exact frame state for that point; prefix effects are never replayed.
This is an entry contract, not automatic executor attachment or deoptimization.

The common generic emitter uses the header-derived thread event field and mask
at original `RESUME` and interruptible `JUMP_BACKWARD` sites. A relaxed atomic
read guards `_Py_HandlePending`; the stack and source PC are published before
that call so callbacks observe the active original frame and can update locals.
An interrupt/error uses the same original-PC error handoff as other operations.
Non-interruptible backedges retain their original behavior. These checks do not
establish tracing/instrumentation invalidation or general executor admission.


`owned_readonly_loops=True` is a separate opt-in for the existing-frame ABI.
It uses the same callback-free SSA traversal loop as the borrowed-vectorcall
lane. Attribute traversal requires another strong reference to the initial
object; with no callbacks/GIL handoff that reference anchors its reachable graph.
A dictionary traversal instead relies on the unchanged owner local and proved
exact identity-key dictionary to pin keys/values. Missing locals or pending work
at entry continue directly through the generic CFG.

The current original local is published before a guard/chunk transition and on
completion. Cold execution branches to the same frame's generic header/exit,
without replaying the entry or calling the original through another frame.
Each fast backedge checks pending event bits; before servicing events it
materializes the current local/PC and then continues generically, discarding all
borrowed assumptions. The flag is disabled by default. Entry observation guards,
executor installation/invalidation and whole-family speed/admission remain open.



## Attribute and subscript stores

The common emitter lowers `store_attr` and `store_subscr` through
`PyObject_SetAttr`/`PyObject_SetItem`, or the selected shared
`structure.store_attr`/`structure.setitem` primitives. A fallback performs the
protocol operation at the current original STORE instruction with its original
operands; it never replays earlier effects or restarts the function.

Both success and failure publish NULL and close each input stack reference in
CPython order (owner then value; key then container then value), keeping the
original stack depth until all inputs are retired. The same opcode cases serve
the vectorcall diagnostic and existing-frame ABI. Fixed ordinary unprotected
scope remains the admission bound; this adds no entry installation or public
admission by itself.


`LoweredFunction.execution_owner` returns a frozen executable-only owner for
function-watch lifetime management: LLVM module/engine, native provider/library
handles, primitive cache capsules and immutable attribute plans. It retains no
IR graph, original function/code, or mutable adapter/profile object. Its body
pointers borrow original source objects; installed-function watchers must retire
or restore entry before source destruction/code replacement, and active dispatch
must pin the owner while the original frame owns its code. The diagnostic
`LoweredFunction.keepalive` still retains the full graph and is not suitable for
an automatic function-watcher registry.


## Real cells and original-code functions

The bytecode graph splits the original prelude from its first `RESUME`. Ordinary
function entry leaves `MAKE_CELL`/`COPY_FREE_VARS` to CPython; the canonical test
provider already performs that same real-cell initialization. Compiled bodies
start at `RESUME` and reject prelude re-entry or cell initialization later in the
body. The stack base uses the actual code object's `co_nlocalsplus`, including
non-argument cells and free variables, rather than only ordinary locals.

`cell.get/set/delete` operate on the existing `PyCellObject`. Stores consume the
actual operand stackref before replacing the cell value and running old-value
finalizers. Tuple building uses CPython's stackref-stealing constructor.
`MAKE_FUNCTION` calls `PyFunction_New` with the original code and actual frame
globals and sets CPython's function version. Fresh function attributes transfer
defaults/closure ownership directly into their original CPython fields. Returned
functions retain their exact code, globals, names and real shared cells; their
ordinary Python call path supplies argument/default/keyword binding. No code or
cell is cloned, and there is no second binder. Native CALL lowering is a following
slice; this capability compiles the factories and cell operations themselves.

## Container construction

`build_map`, `build_set` and `build_list` use the pinned CPython runtime's
`_PyDict_FromItems`, `_PySet_AddTakeRef` and
`_PyList_FromStackRefStealOnSuccess` paths in the common emitter. Dictionary
construction retains CPython table sizing and collision callbacks. Set inputs
are consumed in forward order, including cleanup after an insertion fails;
this preserves finalizers that affect later hashes. List construction steals
stack references only on success. Original source PC, stack publication and
error cleanup stay with the shared frame machinery. No Numba/NRT owner or
separate container representation is introduced.

## Globals and calls

`global.load` uses `_PyEval_LoadGlobalStackRef` on the original frame globals,
builtins and name, including the NULL call sentinel. Ordinary Python CALL and
CALL_KW transfer their real operand references to `_PyEvalFramePushAndInit`;
CPython binds positional, keyword, variadic and default arguments and executes
the actual child frame. Bound methods expand with original function/self owners.
Other ordinary callables use CPython vectorcall conversion and reverse input
retirement. Pending checks match the non-Python CALL boundary; a returning Python
child adds no check that CPython's inlined dispatch would skip.

Non-Python CALL_KW resumes Tier 1 at that same original instruction, preserving
its adaptive cold/specialized pending behavior. A near-C-stack-limit Python call
also hands off before binding, avoiding an extra recursive evaluator entry. Both
paths retain current stack words and prior effects. The existing-frame ABI
returns that original PC; the canonical diagnostic scope can relinquish its
registered frame to Tier 1. These are native-prefix continuations, not a claim
that the remaining function ran natively. Generic-op coverage has no timing gate
under S78; actual installation still requires exact observer/resume behavior and
an independently measured deployment decision.

Generic `common_constant` reads the running interpreter's actual `common_consts`
table, independently of `dis`'s mutable display list. COPY duplicates the existing
stack reference and SWAP only permutes live words. TO_BOOL calls `PyObject_IsTrue`
and retires its operand before propagating an error. Rich comparisons use
`PyObject_RichCompare(oparg >> 5)`, retire right then left, and honor the boolean
flag by truth-testing and retiring the result once. Original source stacks and
error PCs remain with the same shared emitter. S78 generic coverage requires no
timing gate; preparation is distinct from verified native deployment.


## Generator graphs and ordinary iterator consumption

The shared graph models `RETURN_GENERATOR` and `YIELD_VALUE` as suspension
barriers with explicit resume edges. Their SSA results arrive on resumption;
the verifier rejects using them as ordinary pre-suspension values. Graph
construction keeps the original code and closure cells and never creates or
starts a generator. Native producer/resume lowering remains explicitly declined.

The common emitter handles ordinary `GET_ITER`, `FOR_ITER` and `POP_ITER`
through `PyObject_GetIter` and `PyIter_NextItem`. These consume the original
CPython iterator or generator object, preserve the exhausted edge and original
stack/PC, and retain canonical backedge pending checks. Fused local store/load
captures the loaded reference before releasing the overwritten local, as CPython
does; a finalizer can change that local after the captured value is already safe.


## Protected normal paths

The existing-frame emitter lowers the normal CFG of protected functions and
retains the complete original graph and exception table. An error returns NULL
with the original failing PC and live operand stack; CPython Tier 1 enters the
original exception handler on that same frame. Handler-only blocks remain
interpreted, including exception context, cleanup and reraising. This is native
normal-path preparation with interpreted handler continuations, not a native
handler or whole-function speed claim. The synthetic vectorcall diagnostic lane
continues to decline protected scopes. Branch classification ignores exception
metadata, preserving protected iterator exhaustion and next edges.


## Generic method attributes and unpacking

Method-form `LOAD_ATTR` uses CPython `_Py_LoadAttr_StackRefSteal` on the original
owner word and actual stack slot for self-or-NULL. Ordinary instance, custom
lookup, descriptor, class/static method and failure paths retain CPython's
ownership and CALL protocol; no bound-method adapter or binder is introduced.
`UNPACK_SEQUENCE` and `UNPACK_EX` call `_PyEval_UnpackIterableStackRef` into the
original frame's stack, preserving its reverse output order, partial-result
cleanup and temporary source lifetime. Borrowed inputs become owned before
callbacks can replace a source local. Fused two-local stores publish and retire
each old local separately, so first-local finalizers can affect the second.
These generic operations add coverage without a specialization/timing gate;
installation still follows canonical admission and observation handling.

Generic `common_constant` reads the running interpreter's actual `common_consts`
table, independently of `dis`'s mutable display list. COPY duplicates the existing
stack reference and SWAP only permutes live words. TO_BOOL calls `PyObject_IsTrue`
and retires its operand before propagating an error. Rich comparisons use
`PyObject_RichCompare(oparg >> 5)`, retire right then left, and honor the boolean
flag by truth-testing and retiring the result once. Original source stacks and
error PCs remain with the same shared emitter. S78 generic coverage requires no
timing gate; preparation is distinct from verified native deployment.


Generic `LOAD_SUPER_ATTR` follows the interpreter's vectorcall of the current
`super` binding with the original zero/two-argument bit, retires self/class/super
inputs in order, and reads the attribute before retiring the temporary super
object. Method form retains the original bound attribute plus NULL protocol.
Formatting and conversion use `PyObject_Format`/`Str`/`Repr`/`ASCII`; string
assembly uses `_PyUnicode_JoinArray` with original reverse input retirement.
The shared emitter preserves exact string result identity and subtype, callback
source PC/live locals, and failure cleanup. This generic slice does not claim
native generator producer support or an independently measured installation.


## Local scopes, intrinsics and canonical raise boundaries

LOAD_FAST_AND_CLEAR transfers its actual stackref, including NULL, out of the
original local slot. The matching nullable restore assembles to ordinary
STORE_FAST and uses its existing transfer semantics. DELETE_FAST clears that
slot before retiring its previous value and preserves checked-unbound errors.
Unary operations call CPython's numeric protocol. CALL_INTRINSIC_1/2 use its
exported intrinsic tables; type parameters and lazy aliases remain real runtime
objects. LOAD_SPECIAL uses its special-method table and lookup routine with the
original method/self stack pair and missing-protocol diagnostics. LOAD_BUILD_CLASS
reads the original frame builtins through PyMapping_GetOptionalItem.

RAISE_VARARGS/RERAISE retain their unchanged actual operands and return the
original current PC to Tier 1. CPython's private do_raise remains responsible for
normalization, causes, active exceptions, traceback and monitoring. These are
explicit native-prefix boundaries, not native exception-handler or whole-body
speed claims. No-active-exception reraise has a counted native-prefix check. Active-exception
entries are explicitly guarded to Python by the shared entry observer predicate;
their exact behavior is tested as fallback, without claiming native admission.
Generic global writes use the original frame's live globals dictionary, and
DELETE_GLOBAL preserves the interpreter's NameError name and original offset.
DICT_UPDATE/MERGE use CPython's mapping routines and keyword-error formatter,
retiring the update at the original stack boundary. Expanded CALL_FUNCTION_EX
returns the current original PC to Tier 1: CPython owns tuple consumption and
binding; completed native prefix effects are not replayed. A prepared native body
with this boundary is not evidence that the expanded call ran in native code.

Callback-capable generic operations check for newly enabled tracing, profiling
or monitoring before the next opcode. Iterator exhaustion also performs the
interpreter's StopIteration notification before clearing the exception; observer
continuations publish the actual exhausted/next successor stack separately.


List append steals through a thin export of CPython's own inline helper; list
expansion retains the interpreter's non-iterable TypeError formatting. Set add
and update use the consuming `_PySet_AddTakeRef` and `_PySet_Update` APIs. Attribute
and subscript deletion preserve original callback/error and input retirement.
The shared post-callback observer check covers these operations, fused local
stores, unpacking, super/formatting and iterator entry/advance/retirement. The
exhausted iterator edge publishes no next value and resumes its actual successor.
FOR_ITER observes a raised StopIteration before clearing it, including tracing
enabled inside __next__. The diagnostic frame fixture hands observed returns to
Tier 1, matching the actual executor's ownership of original RETURN_VALUE.
Native producers and unsupported comprehension local scopes remain declined.

The direct `EvalFrameDefault` diagnostic restart has a narrower observer scope:
its previous and next PCs collapse at the first new line. Deletion transitions
are validated on genuine original-function executors instead (two counted native
entries and exact trace events), rather than synthesizing events in the fixture.


## Factories across protected CFG boundaries

Fresh-function attribute proofs follow exact normal-edge stack parameters and
retain every earlier field flag. Unknown producers, cyclic provenance and
repeated fields remain declined. Exception-only paths do not establish native
freshness. MAKE_CELL inside an inlined comprehension now calls PyCell_New on
the actual saved/cleared local and replaces that slot before retiring its old
word; pre-RESUME initialization stays with CPython. Comprehension closures share
their new cell and restore the outer local, with distinct cells on later calls.
Generic power and in-place power use the original numeric protocols with None
as the modulus, preserving arbitrary object results and canonical errors.


Generic BUILD_SLICE keeps the original start/stop/step objects and closes its
input words top to bottom after PySlice_New. BINARY_SLICE/STORE_SLICE use small
canonical provider adapters over the original source stack: bounds are consumed,
SP shrinks during the item protocol, then the slice and container/value retire
at their interpreter sites. python314.dll does not export the internal consuming
slice constructor; PySlice_New uses that same allocator, and the adapter retires
its original bounds in the constructor's start/stop order. No user index
conversion, private slice representation, or whole-function replay is added.


`_entry_native.invalidation_api()` exposes the C capsule ABI declared in
entry_invalidator.h. Dependency watchers validate an exact NativeEntry or
FrameEntryHandle once, then invalidate only its dispatch flag during mutation.
Invalidation neither releases code/dependencies nor calls Python. Frame handles
keep installation ownership separately, so close still restores the original
executor; a running dispatch retains its executable pin. Invalidated prepared
handles cannot supply executable owners for later installation. The private
_compilation_handle(original) snapshot lets subscriptions retain a managed
handle without introducing an owning reference back to the source function.

Prepared-to-installed promotion preserves the same handle object that a watcher
subscription bound. Native installation revalidates its function, code, body,
owner and live flag before seeding and immediately before publication. A stale
or invalidated snapshot cannot create a fresh enabled entry from old assumptions.

## Real generator entry seeding

The low-level installer accepts original ordinary-generator RESUME offsets.
It validates the creation prelude, creates a real PyGenObject with standard
vectorcall, and passes that object's actual frame to CPython's optimizer without
sending to or executing the application body. Post-yield seed stack depth comes
from the verified original CFG; temporary None words and all frame/thread/error
links are restored before discarding the still-created private seed object.
CPython may decline a no-progress trace; the installer preserves that refusal.
Different RESUME offsets have independent handles. Actual next/send/throw/close,
exception state, finalization and suspension remain owned by CPython. Public compilation selects the first original RESUME only and reports these
suspended bodies as native-prefix. YIELD_VALUE/SEND transfers the real source
frame to canonical Tier 1; later native resumes are not publicly installed.
NativeEntry supports weak references so dependency subscriptions need not retain
an entry that already owns its subscription; weak targets clear before the
entry retires its source function and executable owner.
Generic BUILD_SLICE keeps the original start/stop/step objects and closes its
input words top to bottom after PySlice_New. BINARY_SLICE/STORE_SLICE use small
canonical provider adapters over the original source stack: bounds are consumed,
SP shrinks during the item protocol, then the slice and container/value retire
at their interpreter sites. python314.dll does not export the internal consuming
slice constructor; PySlice_New uses that same allocator, and the adapter retires
its original bounds in the constructor's start/stop order. No user index
conversion, private slice representation, or whole-function replay is added.


`_entry_native.invalidation_api()` exposes the C capsule ABI declared in
entry_invalidator.h. Dependency watchers validate an exact NativeEntry or
FrameEntryHandle once, then invalidate only its dispatch flag during mutation.
Invalidation neither releases code/dependencies nor calls Python. Frame handles
keep installation ownership separately, so close still restores the original
executor; a running dispatch retains its executable pin. Invalidated prepared
handles cannot supply executable owners for later installation. The private
_compilation_handle(original) snapshot lets subscriptions retain a managed
handle without introducing an owning reference back to the source function.

Prepared-to-installed promotion preserves the same handle object that a watcher
subscription bound. Native installation revalidates its function, code, body,
owner and live flag before seeding and immediately before publication. A stale
or invalidated snapshot cannot create a fresh enabled entry from old assumptions.

## Async graph and iterator protocol preparation

Coroutine and async-generator graphs retain the original code and explicit
suspension edges. Async stack contracts distinguish a retained GET_ANEXT
iterator from the consumed GET_AITER/GET_AWAITABLE inputs. GET_AITER's canonical
slot call and returned-type validation are separate adapters so the emitter can
retire the source between them. Missing slots, invalid results and callback
exceptions retain interpreter diagnostics and ownership order. This preparation
does not itself admit a suspended producer. S80 targets a native prefix ending
at the first suspension boundary; subsequent execution belongs to CPython.
Native-body preparation and measured deployment remain separate from this graph
and slot-adapter slice.

## Original-frame suspended prefixes

The shared lowerer accepts the first original RESUME offset of a generator,
coroutine or async generator with the existing-frame ABI. It emits the normal
CFG reachable before YIELD_VALUE or SEND; exception handlers and later resume
edges remain in the original graph. Initial parameters come from the real
CPython frame as stackrefs, without a private binder or duplicate owners.

YIELD_VALUE and SEND publish the unchanged pre-operation stack and original
current PC, then return to Tier 1. CPython performs delegation, suspension,
heap-safe result transfer, exception-state linking, throw/close and final
return. GET_YIELD_FROM_ITER, GET_AITER, GET_ANEXT and GET_AWAITABLE use canonical
CPython protocols, preserving operand retirement, callback frames and errors.
Lowering and compile-only seeding never run the application body.

These bodies are native-prefix capabilities and can be counted with that
label without claiming native execution after the first suspension. Explicit
later ordinary-generator slices remain experimental; later async RESUME entry
is declined. No interpreter-wide eval-frame hook or private executor setter is
installed. Measured deployment remains separate from machine-code preparation.

Initial coroutine and async-generator seeding uses exact real PyCoroObject and
PyAsyncGenObject frames. Created coroutine seeds close through CPython's existing
METH_NOARGS implementation before release, including optimizer-refusal paths,
so compilation emits no unawaited-coroutine warning. No await, send or
async-generator first-iteration hook runs during seeding. Runtime object and
frame identities, lifetimes, exception links and continuation remain CPython's.

Compilation_info reports native_prefix and compilation_kind (native-prefix or
native-body). Either kind may include explicit canonical interpreter boundaries;
these labels describe compilation, not speed. Deployment remains separately
measured. Invalidated CPython executors report installed false.
