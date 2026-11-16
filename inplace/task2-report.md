# Task 2 preparation report

Status: PREPARED; implementation remains gated by coordinator IMPLEMENT.

## Artifacts and execution status

All artifacts are inside wave16-inplace:

- inplace/task2-preparation/design.md: guarded direct-read architecture/API,
  effect/alias proof, identity demand, atomic C entry and lifetime protocol.
- inplace/task2-preparation/typed-ir.md: exact CheckedOp/Place/Producer schema,
  finite effect substitution, emitted bindings, R8 scalar substitutions,
  adapter ownership certificate and header-derived inline-load ABI.
- inplace/task2-preparation/lowering-notes.md: concrete compiler hooks, recursive
  context ABI, dynamic token rules and activation sequence.
- inplace/task2-preparation/test_direct_reads.py: 38 test definitions, with
  additional numeric/type/control-flow parameterization.
- inplace/task2-preparation/test_direct_read_review.py: 10 test definitions,
  with additional capacity/checked-failure/folded-expression parameterization.
- inplace/task2-preparation/test-eligibility.md: source-inspected current
  rejection/lowering versus required successful new direct execution, and
  disposition of the independent review counterexamples.
- inplace/task2-preparation/native-build-proof.md: compiled C/header fingerprint
  and independent post-build stale-.pyd verification contract.

The 56 test definitions are uncollected drafts. None has been imported,
syntax-checked or executed. No product source changed. No tests, builds,
profiles, timing, commits, installations, old-clone edits or subagents were
performed. Only read-only source/header inspection and preparation-file writes
used reviewed require_escalated commands with the ordinary user token.

## Concrete architecture

Retain logical handles, F/I topology/private temporaries, canonical alias
contracts and the original output-object identity mapping. Add a parallel live numeric slot
map. Typed transitive effects determine eligible readonly fields/list cells;
shape fit, alias stability, callback freedom and ownership remain separate
proofs. Whole readonly heap regions are the first positive target. Direct stores
are not activated; independent readonly fields in arena-mutating regions follow
with their own writeback/lifetime proof.

Use header-derived physical PyObject** cells with pinned owners/boxes and a
single kind/token for each numeric leaf. Emit inlined LLVM float/int64 decoding
after R8, without an out-of-line C boundary on every numeric use. Full int64
uses unsigned digit accumulation and checked sign conversion, including
INT64_MIN. MIXED payload/tag come from one loaded exact box. A readonly
cached-box implementation would need explicit replacement/refresh before
future direct stores; physical cells provide the intended handoff.

Demand numeric identity backward from returns/escaping stores through moves,
phis, calls and virtual fields. Existing boxes retain their reference; Deferred
producer IDs are per dynamic execution and materialize once. Certified
independent producers stop operand demand, keeping arithmetic-only scalar-clone
argument token counts zero. Source AST arithmetic can actually be a folded
original LOAD_CONST: bytecode-position association must precede producer
classification so the actual co_consts box survives. Synthesized globals and
defaults retain separate origins and identity guards.

Typed metadata survives parse/unparse through validated source bindings plus
explicit R8 memory-to-scalar, formal/actual, return and mutation substitutions.
Unknown helpers/operations or lost demanded origins produce named computed
direct declines, not guessed purity or numeric identity. Exact builtin numeric
C operations also need bounded-work, pending-call and allocator proofs;
conservative boxed recipes should run after raw reads stop.

## Atomic entry, adapters and native proof

Preparation retains top-level arguments/descriptors and raw capacity, with no
nested graph traversal/pinning. The C execution envelope performs a fresh
non-materializing graph walk, canonical map construction, final validation,
raw adapter call and unrelated nested-pin release without any observer.
It bypasses the ordinary loader's Python/GC bookkeeping. Only references actually required by the return/private output graph and
necessary deferred-recipe operands survive into tracked result
allocation. This addresses late __del__/weakref detach and post-native output
GC, including guard-failure cleanup timing.

Installed Numba source supports a separate linked JIT adapter library using the
compiler's actual call convention and array data model. AOT can emit the same
adapter while each cres exists and expose it through a typed capsule. The
certificate enumerates native result ownership, NRT calls/results, static and
dynamic exception ownership, helper effects, GIL and pending-call behavior.
Unaudited dynamic exception buffers must be excluded or raw-freed; never
silently leaked or reconstructed as Python exceptions inside the interval.

The proposed production binder is native.direct_bind(capsule, expected_abi,
expected_source_digest, owner). It validates version, source/plan identity and
compiled header/source ABI. Runtime pointers are never persisted. Current
setup.py declares extensions optional=True, so setup exit zero is insufficient:
a fresh post-build process must require all direct APIs and independently
compare current source/header hashes with constants embedded in the actually
loaded .pyd. The report must include that binary's path/file hash. Missing or
stale extension is a failed native build, not a test skip.

## Required evidence and current reach

Positive drafts require public results and Region.direct_calls successful-call
increments. The suite covers pure field/list readers; aliases and original
numeric/object return identity; int64/2**53+1, signed zero/NaN and MIXED; calls,
loops, scalar/private fields; shared/distinct arithmetic origins; R8 preservation;
original constants/globals/defaults; independent readonly fields with arena
writes; descriptor/hooks/list mutations; and late finalizer/weakref observers.

The review file adds fresh managed-inline instance -> replaced __dict__ calls,
entire dictionary replacement at the actual profile c_call boundary, immediate
weakref-only detach, post-native output GC releasing unrelated owners,
capacity growth/exhaustion, recursion/checked-failure cleanup, ABI mismatch,
saved AOT in a fresh process rejecting Numba, and folded arithmetic/unary
constant identity. The GC callback must demonstrably run; scheduling/phase
still needs activation evidence and may require an equivalent real trigger.
No production test-only hook is proposed.

Source inspection already shows rejection of >int64 inputs, unsupported
finalizer/allocation/attribute hooks, mixed numeric list contracts, and numeric
is observations. These are distinguished from positive direct cases rather
than credited as new coverage. Late descriptors require a new complete layout
guard; ordinary warm guards are not assumed sufficient.

Initial positive backend reach is heap.Region. FFT selected kernels use
lift.py/AotLifted, so heap direct reads cannot be credited with FFT gains.
Preserve existing behavior and report reach separately for each backend;
future shared direct-store ABI needs explicit lift integration.

## Activation and remaining gates

After IMPLEMENT, move the four staged test files into tests/ and ask the coordinator
to launch the first locked fail-first command, or a concrete stage subset:

```
C:\Python314\python.exe inplace/run_locked.py task2-direct-red C:\Python314\python.exe -m pytest tests/test_direct_reads.py tests/test_direct_read_review.py tests/test_direct_audit.py tests/test_direct_class_lifetime.py -q --tb=short
```

All builds/tests remain coordinator-scheduled through the clone-local lock
runner. No independent lock waiter is started. Native build fingerprint proof,
red/green execution, independent guard review, integration suite and eventual
coordinator timing are outstanding. This report makes no implemented reach,
passing-test, acceptance or speedup claim.

## Additional preparation: native audit and class lifetime

New notes: native-entry-audit.md, class-lifetime.md and future-step4.md.
New staged tests: test_direct_audit.py (5 definitions) and
test_direct_class_lifetime.py (3 definitions plus parameterization). Total is
56 definitions across four uncollected files; none has been imported or run.

The actual audit/held-out sources were inspected. Current capture_audit fails
closed for direct adapters bypassing program.run, correctly. Its attempt
wrapper also drops already-observed entry bookkeeping when original raises;
the separate harness-review agent owns the staged existing-helper fix. No live
audit or held-out helper was edited by this agent.

Proposed direct proof uses sealed canonical region/backend/binding identities,
compiled source/header/ABI fingerprints, and actual LLVM adapter prologue and
epilogue counters. C validation, native status exits, native errors and cleanup
have separate records. Independent wrapper outcome determines complete-call
success; native_ok followed by a Python exception is not a completed call.
Exceptional finally recording preserves entry evidence and the same original
BaseException even if secondary audit bookkeeping fails. Raw counter writes
allocate nothing, retain no user objects and invoke no Python callback.

The class lifetime case is a substantive prerequisite, not an optional direct
restriction: existing Program/ObjT/fact/signature caches and global _ESCAPES
strongly retain ordinary classes. Persistent metadata must use weak dependency
IDs/per-call pins across the full retained closure. Class weakrefs must fire
after removing the binding and last instance while Region/audit remains alive.
Custom metaclass finalizers already decline and need regression coverage.

Future Step4 notes preserve a shared C descriptor for a possible vectorcall
fast entry while retaining Region identity/API/override behavior. They also
describe general native output allocation with certified observer safepoints,
fresh mappings and exact continuations after observable progress. Whole-entry
replay or bulk final-graph reconstruction is insufficient once GC observers
have seen a partial graph. Input-mutating extensions need committed-prefix and
journal/continuation proof. These are later mechanisms to build, not Step2
implementation, acceptance, timing or a workload-specific shortcut.
## Allocator and compile-scope follow-up

allocator-capability.md records installed-header and static DLL inspection.
_PyMem_GetCurrentAllocatorName is exported and compares standard/debug domain
tables against recognized defaults; its mutex contention path may detach the
GIL. PyObject_GetArenaAllocator has the same limitation, and the recognized
name omits the separate arena tuple. Both getters belong before all graph
borrowing. The default arena callback symbols are declared in installed
pycore_pymem_init.h but are not exported by the inspected DLL. Positive arena
identity, external setter concurrency and preallocation/free observation remain
explicit proof obligations. No Python interpreter/DLL function was invoked,
no allocator was changed, and no current allocator setting was queried.

class-lifetime.md also records the coordinator's lower-churn alternative:
make full Program/ObjT state compile-scoped, seal weak/primitive C descriptors,
replace retained latest/programs with compatible diagnostic views, lazily
reconstruct on decline, and audit Dispatcher/cres/library closures. Global
_ESCAPES needs weak class AND weak init dependencies to avoid __class__ closure
cycles. This remains preparation, with the same 56 unexecuted test definitions.