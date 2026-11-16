# Native Scalar Entry Implementation Plan (Step4b preparation)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Give proven scalar heap.Region calls a real C vectorcall entry with no Python bytecode on a hit, and the existing reference wrapper on a miss.

**Architecture:** Preserve public Region and its Python __call__/attempt behavior by deriving it from a small C storage base and enabling that class's vectorcall slot after its definition. An immutable C descriptor weakly names the retained Program and binds a no-NRT nine-pointer native adapter; guards/status/boxing/counters execute in C. JIT and sealed AOT share the existing _direct_adapter emitter, with no Numba import on saved restoration.

**Tech Stack:** Installed CPython3.14.4 headers/ABI, existing _heap.c/_guards.h, Numba/llvmlite no-NRT compilation, pycc, existing prepared artifact seals and independent capture_audit.

**Spec:** CLAUDE-STEERING.md S41/S42/S43; inplace/S43-BOUND.md; inplace/task2-preparation/future-step4.md. This is preparation while the required Step4a33-program cohort runs, not an activated feature or final DESIGN checkpoint. Product implementation starts only after S43.5's deployment count is known, a DESIGN checkpoint/interval, fail-first tests and a second steering read.

## Global constraints

- Product edits/builds only in wave16-inplace; root ledger/TIMING.lock are coordination exceptions. Ordinary-token reviewed escalation, no ACL/system/global-install/push/foreign-process action.
- Every suite/build/profile/timing uses run_locked and its no-other-heavy-process check. Never reuse an incomplete attempt. Source/artifact/helper pins exclude mutations during measurement.
- Fixed exact primitive kinds only, acyclic/no object/global/array/RNG/private-allocation/unknown effects, live guards and checked status unchanged. Missing proof/ABI/owner/overflow/recursion selects the reference path.
- No new native guard variant underS37: reuse check_heap_guards and its exact installed-build/audit capability. Unsupported/free-threaded configurations decline.
- Public type, counters, kwargs/defaults, subclass/instance/class method overrides, generator/coroutine behavior and diagnostic hooks remain meaningful. Field input conversion is Step2 underS43.4.
- Final acceptance remains complete trivial scalar+field calls, six regions, one10-pair four-kernel comparison and unchanged20-loop33 selection. Step4a commit0ef65037 is partial, not whole-Step4 acceptance.

## Review focus

1. Instance/class/subclass overrides of attempt/__call__/program_for/load, including restoration and module reload: invoke the dynamic reference behavior.
2. Numeric identity outside the function: existing input/constant boxes, folded bytecode constants, unary plus/float(float), branch/loop joins, equal fresh results and canonical small ints.
3. Actual C entry/audit observation: a success bypassing attempt/program.run cannot be credited by those Python wrappers or by product counters alone.
4. Weak ownership after latest/programs clearing, original rebinding, ephemeral classes/closures and dispatcher collection; no hidden descriptor/library backedge retains application objects.
5. Native errors/boxing failure/reentrancy/profile mutation, ABI/owner/source tampering and no-Numba saved startup: exact replay/exception and zero false completion.

## File map and interfaces

- Create src/recompyler/_scalar_entry.h, included by _heap.c after existing guard definitions: C storage base, descriptor, raw-call/guard/box/counter core and audit snapshot. _heap.c registers types/functions.
- Create src/recompyler/_scalar_entry.py: compiler-side admission/result provenance, JIT adapter binding and saved descriptor hookup. Compiler-only imports stay in JIT branches.
- Modify heap.py: Region inherits optional _native.RegionEntryBase, initializes vectorcall storage and enables the public type, binds only settled successful Programs, and preserves the Python reference call/attempt implementation. Native-missing builds keep Python behavior.
- Modify _direct_adapter.py only if emitter needs an AOT integration seam; reuse nine-pointer ABI, strict native helper verification and complete executable/environment ownership.
- Modify _pycc/cc.py and compiler.py: per-export no-NRT scalar emission, raw adapter and native capsule factory, all linked into the existing artifact. No second compiler/backend.
- Modify _prepared.py/_prepared_keys.py/_origin.py as required: exact new compiler/header keys, sealed factory/ABI/kind/provenance metadata and native-origin checks; never persist process addresses.
- Modify inplace/capture_audit.py and its owning tests: C-native bank + independent outer outcome observer; keep ordinary engine accounting. Audit must run the same actual C entry as deployment, with no Python callback inside raw execution.
- Tests: tests/test_native_scalar_entry.py, tests/test_native_scalar_entry_aot.py, tests/test_native_scalar_identity.py, existing prepared/audit/Region controls.

Proposed native interfaces (final names travel together):

- _native.RegionEntryBase: storage for a vectorcallfunc only, no new application reference ownership; public Python Region remains exact type(region) is heap.Region.
- _native.init_region_entry(region) -> None; initializes the C slot, including inherited construction.
- _native.enable_region_type(region_type, reference_call) -> bool; verifies the storage base and current Python reference __call__, then enables vectorcall/tp_call. CPython clears vectorcall when __call__ is reassigned.
- _native.bind_scalar_entry(region, program, capsule, owner, arg_kinds, result_recipe, expected_methods, mode, digest) -> bool; immutable C descriptor, weak Program/function/type dependencies, strong executable/environment owner only, no raw Python integer used as an execution capability at runtime.
- _native.scalar_entry_snapshot(region) -> dict; actual slot/ABI/provenance plus independent raw entries/status exits/public outcomes per digest/mode, not fabricated from compiled/aot/jit counters. Counter exhaustion fails closed.
- _scalar_entry.maybe_bind(region, program) -> bool; deferred compiler-side JIT/AOT selection, no repeated failed compilation per unchanged Program.

## Task1: Proven scalar result and C callable contract

- [ ] Write fail-first tests for actual warm no-Python-frame execution and C slot/counter evidence, plus exact type/identity/exception and overridden reference methods. Capture original method code objects for profile assertions; patching attempt to forbidden must invoke that override, not be used to claim no-bytecode.
- [ ] Write first-call and warm external identity tests: return input large int/float; return folded code constant; unary plus; two separately computed equal fresh numeric values across calls; signed zero/NaN. Keep unsupported/mixed-provenance cases explicit.
- [ ] Under a fresh lock label, observe intended failures on Step4a before implementing.
- [ ] Implement a closed result-origin certificate from original guarded bytecode/checked operations. A single final numeric result can be Existing(input), Existing(co_const), or a proven fresh producer with CPython canonical-box recipe. Joins with one identical origin remain that origin; all proven fresh/canonical origins may box once. Unknown/mixed origin requires tokens or a conservative Python-original replay, never guessed numeric equality. Prove operator forwarding/freshness against actual CPython, including folded constants; source AST alone does not encode bytecode folding.
- [ ] Preserve original-box conversion in the reference scalar path too, so bootstrap/guard misses match exact CPython tests. Do not silently lose existing compilation reach; report/repair any new decline with its proof and tests.
- [ ] Implement C base/slot and ordinary wrapper fallback. Prototype type-slot behavior only after33 count: class reassignment, object/subclass construction, __getattribute__/__setattr__, explicit tp_call and vectorcall parity. A special-method fallback must bypass instance __getattribute__ exactly as Python calling does; do not just getattr(self,'__call__').
- [ ] Run focused identity/override/Region controls; independent same-step review before claiming the contract.

## Task2: Actual no-NRT JIT entry

- [ ] Fail first on raw-entry count, no Python frame hit, exact checked overflow/reset and live code invalidation. Include discarded latest/program membership, mutated run/proof metadata and dynamic method overrides.
- [ ] Build from authenticated generated source using no-NRT compilation; verify helper graph with _direct_adapter and keep complete code/environment owners. Use fixed bounded C stack buffers for the four unused heap/control arrays and numeric args/results, preserving F/I aliasing; scalar proof excludes every F/I load/call path needing them.
- [ ] Bind immutable native kind/provenance/ABI/source metadata. Warm entry validates exact public class/default attribute machinery and dynamic reference-method identities, current latest/nonbroken Program/run/proof, exact argument count/types/ranges, live existing guards, then invokes raw ABI with no allocation/callback/GIL release inside the interval.
- [ ] Guard misses/unsupported keyword/default binding and checked failures call the existing wrapper. Only status0 plus successful scalar result materialization increments native completion/product jit/aot/compiled counts. A native status failure may be reattempted by the reference wrapper but must never count a completion.
- [ ] Get an independently reviewed source-pinned three-pair scalar development gain, not an acceptance claim. This is the first measured Step4b slice; the three-hour no-gain rule remains active until a real gain or accepted commit.

## Task3: Shared sealed AOT capsule

- [ ] Fail first on real saved scalar C entry in a fresh process rejecting Numba import; mutated/missing ABI/factory/owner/source/kind/provenance/seal; real source invalidation and exact existing/fresh boxes.
- [ ] Extend pycc export metadata to compile eligible exports with NRT disabled and emit _direct_adapter into the same linked library before finalization. Other exports retain existing behavior. Validate per-export machine ABI from actual cres, not a sample.
- [ ] Emit a built-in native capsule factory alongside ordinary module methods. The capsule describes a same-artifact raw entry and static ABI/kinds/digest; pointer addresses are created on load only. AOT runtime authenticates factory builtin origin/module/binary and the existing artifact/plan/compiler seal before capsule binding.
- [ ] Add optional sealed runtime metadata; absent facts retain reference/AOT fallback. Extend exact compiler key coverage for new Python/C/header/emitter files. Do not import Numba or regenerate analysis on a valid saved hit.
- [ ] Run real prepared/dependency/lifetime/seal regression controls and review concrete ownership/restore paths.

## Task4: Independent audit and acceptance

- [ ] Fail first when raw C execution bypasses attempt/program.run: old audit must mark it unknown, not succeed from product counters. Also test native status0 followed by boxing error, rejected attempt, original exception, two wrappers sharing an export and mixed C/arena calls.
- [ ] Record trusted C-bank entry/status and separate public outcome at the actual raw boundary. Keep finite preallocated rows/counters, no audit callback in native interval and no input/class retention. Product counters are only reconciled afterward.
- [ ] Add an independent outer observer that invokes the actual unchanged C callable. A class monkeypatch disabling vectorcall cannot be credited as auditing that path. An audit-only outer proxy/factory observer can preserve the real Region underneath; ordinary saved AOT calls can be observed via real C-call events, with checked status and Python fallback observation. Retain generator/coroutine/ordinary-engine audit behavior and non-vacuous tests.
- [ ] Independent source review; then exact full suite once final concerns close, source/tests frozen, fresh artifacts. One final complete trivial before/after + six-region complete wrapper calls, ten alternating pairs/all4kernels against completed depth-tip-v1, unchanged20-loop33 selection with captured/verified/deployed/native counts and behavior/artifact seals.
- [ ] Investigate achieved/bound shortfalls and unresolved regressions before next step. Commit accepted Step4b/wholeStep4 only with evidence; return to Steps2/3 from preserved53503698 foundation. REPORT/DONE only at actual authorized closure.

## Primary API references

Installed headers are authoritative for offsets. CPython documents vectorcall/tp_call parity and disabling vectorcall on __call__ reassignment at https://docs.python.org/3.14/c-api/call.html ; type layout and inherited slots at https://docs.python.org/3.14/c-api/typeobj.html ; type creation/relative storage at https://docs.python.org/3.14/c-api/type.html . No offsets are copied from docs or assumptions. _PyObject_LookupSpecial is declared in installed internal/pycore_object.h; prefer a public/raw-MRO special-binding implementation or positively prove the exact installed export before using that private API. Numeric fresh/forwarding rules need direct CPython tests/source proof rather than recollection.

## Preparation self-review

All S43 numbered items map to bound76, partial commit77/current33 prerequisite, tasks1-4 or the explicit field-toStep2 boundary. No native code has been written yet. The design's highest-risk points are result identity/provenance, mutable Python type slot behavior, source-authenticated raw capability and actual C-path audit; those are task deliverables, not assumed existing facts. No new guard variant or per-workload admission is proposed.

## Independent-review requirements (preparation, 2026-11-14)

- **Ownership:** The C base stores only its vectorcall function pointer. The immutable GC-aware descriptor and bank live in Region's existing GC-traversed instance dictionary. Descriptor tp_traverse/tp_clear/tp_dealloc cover every owned object; a weak-Program callback retires the raw address and releases executable/environment owners when the Program dies. Replacing a descriptor or clearing latest/programs must not retain the old Program, application function, closure, class or globals. A callback cycle must be GC-visible. Inspect the complete generated native environment globals/constants and prove a closed owner graph; empty sample constants alone are no lifetime proof. Counter history stores primitive identity/digest data and weak references only.
- **Two statuses:** _direct_adapter.emit normalizes the Numba call-convention result separately from heap st[0]. Success requires adapter_status == 0 AND st[0] == 0, with fresh controls before every entry. Never read/box a dummy result or credit completion after a checked exit. Fail first on integer overflow with raw adapter status0/st[0]!=0 and the following successful reset.
- **Authenticated provenance:** Bind raw capsule, executable owner, ABI, digest, machine kinds and result-origin certificate together. A valid Program B capsule combined with Program A's otherwise plausible Existing recipe must reject. Existing(input) selects current bound arguments; Existing(co_const) selects the guarded live code constant. Never select an identity from equal numeric bits.
- **Mutation:** Expected method function identity is insufficient: same-function __code__, defaults and closure changes must invalidate as applicable. Include Region __call__/attempt/_scalar_attempt/load and all actual proof dependencies, instance/class descriptors, reassign/restore, module reload, object.__new__, skipped initialization and null vectorcall storage.
- **Guard equivalence:** RuntimeProgram.guards_hold includes registered wrappers, function/class snapshots and binding identities beyond check_heap_guards. Native admission must prove/support that complete guard set or decline the unsupported record to the reference path. Reusing the C heap scanner does not prove prepared guard equivalence.
- **First native slice:** Fully supplied exact positional primitive arguments first; kwargs/default/general binding, subclasses, custom attributes, unsupported provenance and unrepresented prepared guards use reference dispatch. Preserve visible Python integer counter assignment/__dict__/override behavior with ordinary C updates after successful boxing; do not virtualize counters speculatively. Bound every stack extent from the authenticated ABI and preserve F/I aliasing. This does not narrow the required final JIT/AOT proof; later tasks must supply prepared guard equivalence and saved raw entry.
- **Actual-path audit:** A generic vectorcall object does not emit PyCFunction profile events. Keep the underlying exact Region and its class unchanged; use an independent audit-only outer factory/proxy to observe actual public return/exception/fallback, matched to raw C bank invocation/wrapper/digest/mode. Prove this wrapper does not switch runner engines or disable vectorcall. Existing attempt/program.run monkeypatches cannot be credited as observation of C dispatch.

These requirements are open proof/test obligations, not approval of an implemented C path. Independent reviewer performed no builds, suites, profiles or timing runs.

### Ownership revision following independent review

Prefer the simpler live-owner rule over the weak-callback scheme above: the existing Program exclusively owns its native Entry/capsule and complete executable/environment owner graph. The immutable C descriptor persistently owns only weak Program/owner references and primitive ABI/provenance/method snapshots. On a hit it resolves and strongly pins the live Program and its exact still-installed owner before using any address; release occurs after outcome handling. Current latest and exact programs membership, current owner identity and native capability are revalidated. This avoids a descriptor->environment->mutable globals->Program backedge defeating weak retirement: no descriptor ever roots that graph, even if generated globals are mutated later. All descriptor references remain GC-visible. Bound owner lifetime and generation are part of the raw capability, never an independently trusted integer address. Fail-first clear-latest/programs, owner replacement/deletion, dispatcher collection and mutated environment backedge lifetime tests still apply.
