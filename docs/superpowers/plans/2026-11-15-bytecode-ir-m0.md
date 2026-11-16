# Shared bytecode SSA IR M0 implementation plan

> For agentic workers: execute inline with superpowers:executing-plans. User S58 overrides repeated review/approval gates; one concrete implementation review per capability.

**Goal:** Build the S73 bytecode IR and generic llvmlite path, measuring the approved M0 family against CPython before further growth.
**Architecture:** Abstractly interpret CPython 3.14.4 instructions into basic blocks and stack SSA, retaining explicit observable frame slots and exception ranges. Generic operations use interpreter C routines and CPython ownership order; wave18 supplies symbol resolution and vectorcall entry.
**Tech Stack:** Python 3.14.4, dis, llvmlite 0.50, pinned CPython C ABI.
**Spec:** ../../../../CLAUDE-BRIEF-ir.md and steering S73.

## Global constraints
Existing front ends stay working and untouched during M0 to M3. No Numba on this path. Generic lowering is exact interpreter behavior. Each milestone requires fuzzer/full suite and CPython/RecomPyler/warm PyPy times. If M0 misses CPython, record DEVIATION before building more. S49 numeric identity exemption only.

## Review focus
- Stack joins/backedges must have matching depth and typed SSA parameters.
- NULL call sentinel must never be treated as a Python reference.
- Exceptions retain handler depth/lasti and source PCs.
- Reentrant destructors see CPython publication/operand retirement order.
- Unsupported/version-mismatched bytecode refuses before execution.

## Task 1: core graph and verifier
Files: src/recompyler/ir/{__init__,types,ops,builder,verifier,passes}.py; tests/test_ir_core.py.
Interface: build(function)->FunctionIR; verify(graph)->None raising VerificationError; PassManager.run(graph)->FunctionIR. Blocks carry entry stack SSA parameters; outgoing Edge arguments bind these parameters. Operations retain original instruction/offset and explicit result ownership; exception regions retain depth/lasti.
- [x] Tests first: branches, loops, call sentinel, unbound slots, exception ranges, malformed edge/use/dominance, no source availability dependency.
- [x] Confirm red, implement graph + builder + verifier, confirm focused green. Core20 tests plus23raw-frame and24backend checks pass after the sole review and post-gate corrections. One combined full completed3581passes/131subtests/5xfail plus a stale resolver failure corrected directly.

## Task 2: generic LLVM lowering and native entry
Files: ir/lower_llvm.py and operation lowerings; wave18-owned ir/entry.py and symbol resolver.
Interface: compile generic FunctionIR to native vectorcall ABI; original function/code kept alive, error returns NULL. Agree native entry/argument binding API in REQUESTS before wiring.
- [ ] Tests first for exact operations, callbacks, lifetime/error order, original behavior.
- [ ] Implement generic interpreter C calls with ordered ownership; no speculative post-effect guard.
- [ ] Focused red-to-green and bounded differential fuzz.

## Task 3: M0 acceptance
Subjects: approved S66 visitor family, heap._find, heap._Program.canon.
- [ ] One implementation review, correct only concrete wrong/crash cases.
- [ ] One combined full suite, publish small accepted commit.
- [ ] One timing lock: CPython/generic IR/warm PyPy, allocations per entry and IR census count. Stop with DEVIATION if floor misses; otherwise proceed M1.

Status: S73 M0 gate failed at root ledger CHECKPOINT75. Matrix-only _find/canon probes are1.195x-2.454xCPython and expose an owner-count mismatch3vs1. No public compile_function or native IR census admission. Further milestone growth stops; foundation validation/commits only.

## S74-S76 continuation
S74 exempts raw sys.getrefcount / gc.get_referrers cardinality values while retaining exact lifetime, finalizer, weakref, frame and cycle behavior. S75 requests the reference fast loop shape plus LLVM/assembly differences. S76 supersedes the old stop/testing cadence: affected tests per edit, persistent-cache fast tier per commit, slow/full and ten-minute fuzz only in joint integration. Continue diagnostics after deviations.

- [x] Common lower(graph, structure_calls=...) over the shared IR; fixed ordinary unprotected scope, generic and selected primitives share PC/operand/error retirement. Six focused checks pass; no public admission.
- [x] Replace raw count assertions with exact weakref/lifetime checks, retaining NRT allocation balance checks.
- [x] Sole lowerer review: no confirmed concrete wrong result/crash/leak; performed parallel with first fast gate.
- [x] Export selected/generic LLVM and assembly plus unchanged reference listing and static comparison under matrix/s75-codegen.
- [ ] Finish accepted integration merge a1c039f1 after first S76 fast gate and concrete shared-corpus correction check.
- [ ] Fetch/merge wave16 accepted borrowed attribute and dictionary-domain proof primitives when published.
- [ ] Add general graph effect/lifetime proofs and callback-free borrowed loop lowering with current-state fallback in this same common lowerer.
- [ ] Resolve actual temporary CALL argument retirement with wave18 entry plumbing before public semantic admission.
- [ ] Validate M0.5 with bounded 1-2 minute dev fuzz; report matched CPython/plain/native/warm-PyPy timings and allocations under TIMING.lock. Native IR census stays0 until admission passes.

S76 continuation validated: optional graph-derived attribute/mapping traversal lane (9tests), canonical claim_call_args and six-argument owned runner/current_callable context (8tests), accepted wave16 guard merge6e388aecd292ea04e1ade1a15955e9a71ff66252. Affected56PASS; one review each0concrete; bounded60s7835094native0wrong. Fast3480PASS129subtests5xfail185slow deselected401.59s3workers. Locked3pair component readonly ns find0/4=51.35/68.00,canon0/4=60.06/117.90 vsCPython66.58/121.66/70.19/200.99, zero NRT; PyPy2million warmup. PublicIR0, default readonly disabled; no M0 visitor-family or general CALL-lifetime admission. Next integrate owner18 actual-callable hook and owner16 immutable offsets through git; diagnose standard-vectorcall post-frame entry for bound-self exactness.


S76 existing-frame continuation: accepted995478d9 adds the canonical existing
frame ABI and accepteda7fb49a6 adds explicit empty-stack CFG entry, merging
integratione468207c and descriptor correction58cd2447. Next pending-work RED
was confirmed (callback after original source frame popped);5focused cases and
50affected now pass with guarded CPython event polling, fast gate in flight.
Next ownership proof will use the same traversal loop/emitter and same generic
cold CFG: callback-free attribute traversal requires a stable external anchor;
mapping traversal can use the unchanged owner/dictionary graph. Before any
callback/pending-work/cold transition publish the current original local.
No second binder, frontend or original-function replay; public IR stays0.

S77 continuation: M0 accepted by the user; no further M0 gate. Original-frame
entry711c7d72 consumed by git. M1 real cells and tuple/original-code function
creation13fail-first checks/104affected pass; actual header localsplus and
firstRESUME entry preserve CPython prelude ownership. Warm fast3570PASS,
129subtests/5xfail/194slow deselected,440.894s3workers; sole review0concrete;
60s56,950,039native entries/179,371lifetime/44,843empty errors,0wrong.
Next consume7996f2f1 containers for keyword-only defaults, then generic globals
and closure/local calls with canonical CPython argument transfer. Shared census
82/1827 real IR bodies (0installed); new M1 whole-entry speed unmeasured.

S78 read in full: breadth before further call depth or timing. Current batch
consumes7996f2f1 containers by git and adds live globals/canonical closure CALL,
keyword-only defaults and lazy annotations.18new checks/114affectedGREEN;
fast3598PASS129subtests/5xfail/194slow deselected312.608s3workers,sole review0;
60s143,967,377native-prefix entries/52,517lifetime/210,065errors0wrong, with
28,740,959explicit keyword Tier1 continuations separately counted.12next-op
REDs already recorded: common constants/copy/swap/truth/comparison. Next merge
public18c35, implement these generic ops and retain owner18 observer correction.

S78 generic breadth validated:20checks140affectedGREEN; public18c35 consumed
by git and own entry rebuilt; fast3627PASS129subtests/5xfail/198slow deselected,
337.152s3workers; sole review0concrete;60s91,078,572native/11,950,993errors0wrong.
Next protected normal-path scope7RED already prepared; use actual Tier1 original
exception-table dispatch on native error, with explicit handler continuation
reporting, while preserving owner18 observer correction and owner16 iteration.
