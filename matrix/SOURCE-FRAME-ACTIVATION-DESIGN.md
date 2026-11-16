# Shared source-frame activation: steering request

The current canonical reference and ordered-owner layers are usable. Native control flow with arbitrary Python callbacks is not an exact CPython replacement. Three executable cases in `tests/test_managed_frame_owners.py` remain strict expected failures: child locals die before an error traceback is released; a successful callback can retain its caller through a saved traceback; and callback `f_back.f_code` identifies the wrapper instead of the original source function. The raw three-failure run is `s68-source-frames-red.log`. An error-only owner tuple would fix neither the successful capture nor source-frame identity, so it is not the proposed acceptance boundary.

## Delivered slice

`_managed_native` has one canonical `(meminfo, data)` model. MemInfo is the sole ordinary owner; immutable-pool borrows share that owner without allocating a new one, and synchronous root adapters may borrow externally pinned roots through `borrow_root`. Generic unboxing remains owning. The one model review and one family review cover these interfaces; the full gate passed 3430 tests plus 131 subtests and four existing expected failures.

`_managed_frames.Frame`, commit `37a46e91`, is the dependency-light source owner requested by the bridge run. It holds real cells and ordinary locals, releases its references in reverse original localsplus order, and preserves escaped cell contents. Its `native_data` is an execution view, not the lifetime owner. Function and visitor frontends reuse this implementation; a Python carrier must retain the owner through any captured traceback. This fixes source-slot lifetime and cleanup ordering, but does not create a PyFrameObject or link an executing source activation.

All five audit variants compile their parent control flow. Three use native local children; two still call managed iteration/helper bodies. This is a construct-family count, not a measured fraction of held-out time. No default coverage or deployment gain is inferred from it. The one locked six-case timing remains 3.68x to 61.76x slower than CPython; two_helpers has zero dispatcher calls but is 19.35x slower. Native AST child iteration and native Multiply/InPlaceAdd are still open.

## Proposed shared mechanism

CPython keeps an activation record with locals, cells, evaluation stack and execution metadata; an observed frame can outlive its call. See the installed-version [frame design](https://raw.githubusercontent.com/python/cpython/v3.14.4/InternalDocs/frames.md). The proposed C provider follows that lifetime rather than storing owners in an unrelated persistent cache.

Use one version-guarded, GIL-only CPython 3.14.4 provider, provisionally `_managed_frames_native.c`, consumed by all frontends. Proposed operations are `enter(original_function, bound_arguments, closure)`, source-slot load/store, original-instruction-position update, and normal/error exit. These are activation operations, not a second representation for application values. Normal managed values continue using the canonical reference type. Borrowed values may reference active slots only when the slot or operand-stack owner demonstrably survives every use; unrestricted Numba values keep ordinary ownership.

The provider must initialize the actual original function/code/builtin context, real closure cells and original localsplus layout. Slot stores publish before releasing the previous owner. Callback boundaries must expose original source code, names, values and line position. Capturing a source frame moves or preserves its storage until the last frame/traceback reference disappears. Error exit must preserve the same source owners, exception identity/context, and cleanup order. Reentry and threads use separate activations and must restore the prior thread-state frame on every exit.

The private entry/clear protocol consumes owner references and unlinks frames before clearing them; see [the actual evaluation implementation](https://raw.githubusercontent.com/python/cpython/v3.14.4/Python/ceval.c). Availability of the necessary Windows symbols, stack-reference representation, and header/runtime layout is a first bound, not an assumed ABI. Unsupported layouts must decline before application effects.

A standalone `PyFrame_New(code, globals, locals)` is insufficient as an acceptance argument: the [legacy implementation](https://raw.githubusercontent.com/python/cpython/v3.14.4/Objects/frameobject.c) creates a new function with empty defaults/closure metadata. More importantly, an unattached frame does not itself establish the correct live caller chain. That is an inference from the implementation and the directed callback test, not an implemented solution.

The Python wrapper may remain an implementation carrier initially, but observable caller chains and propagated tracebacks must exclude its synthetic identity. A direct C entry may replace that carrier only once the actual source frame owns all required references; the existing no-carrier experiment is not a valid lifetime shortcut. The bridge owner owns that boundary.

## Order, size and acceptance

First prove one fixed-signature, non-suspended root/child pair: all three literal failures must become exact passes, including release after traceback clearing and successful captured-frame lifetime. Then add original closure-cell/default handling, protected handlers, recursion limits, reentry/threads, and locals snapshot order. Original instruction offsets must be mapped from bound source/bytecode positions; ambiguous mappings decline. Enabling observers inside a callback requires a correct continuation policy, not replay from function entry.

Estimate: 500-900 C lines for versioned activation ownership/linking and 300-600 Python/frontend lines for slot/site emission and bridge/chain hooks, before broader continuation support. The existing SSA and reference model remain shared. Native AST field iteration follows this owner boundary so a faster traversal does not bypass captured-frame lifetime.

Steering request: make real source activation the next named joint capability, with wave17 owning the canonical frame/owner provider, wave18 owning root entry and carrier/return/exception plumbing, and wave16 consuming child hooks. Prioritize the three recorded frame obligations before further operation-kind growth. Keep callback-sensitive control paths unaccepted and opt-in until that gate passes. This request changes the next subsystem boundary; it is not a request to relax identity, hide callbacks, count whole original helpers as native, or approve slower deployment.

## Coordination update

The canonical availability query is published as `cdad39c8`; it currently returns False without observing application objects. Consumers must make the native/interpreter decision before child effects. A positive proof cannot be replaced by helper-name matching or absence of callback observations. The bridge has consumed the ordered Frame and context-name hooks; the exact source activation remains a separate gate.

Wave18 reports a seven-case actual-C-activation feasibility witness, including nested caller chains and f_locals replacement. Its additional concrete PC obligations are relevant to this design: POP_TOP must be marked before dropping a discarded callback result, and the original return opcode must be marked before exit. These are peer-reported feasibility results, not this run's general provider or acceptance evidence. Reuse the one canonical provider once generalized; do not introduce a parallel runtime value model.
