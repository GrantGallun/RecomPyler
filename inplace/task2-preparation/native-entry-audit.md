# Direct adapter entry audit: preparation contract

Preparation only. This reviews current inplace/capture_audit.py,
inplace/heldout_identity.py, heldout-preparation/PLAN.md, heldout.py and
phase_child.py. No helper/product edits or executions have been performed.

## Current evidence and concrete gaps

capture_audit wraps program.run after Region.load and combines observed calls
with a successful Region.attempt result. Raw direct adapters bypass both
ordinary loader and run wrapper, so the current unknown/unobserved-success
failure is correct and must remain until the C evidence exists. Reading
Region.direct_calls or trusting program.ahead_of_time does not fill that gap.

There is an exceptional-path defect in wrap_attempt: its finally resets the
ContextVar, but row creation, native-entry accounting and rule reconciliation
come after finally. If original raises, those statements never execute. Actual
entry evidence already appended to events disappears. phase_child has the same
normal-return assumption for several rec/baseline fields; exception evidence
must survive even though the entire replay is invalidated.

Auditor binding caches use id(native), rows use id(region). A reclaimed object
can reuse an address in a long process. Direct audit uses monotone opaque
binding/attempt IDs rather than a raw pointer as durable identity. Canonical
report grouping remains exactly heldout_identity.key plus backend/kind.

## Identity and ABI proof

An immutable audit binding descriptor contains only strings, integer IDs and
hashes; it owns no argument, result, class, bound method or exception:

    BindingIdentity(
        binding_id, canonical_file, qualname, firstlineno, backend='heap',
        ordinary_program_digest, direct_variant_digest, direct_plan_digest,
        original_source_sha256, generated_source_sha256, adapter_ir_sha256,
        abi_digest, compiled_c_sha256, compiled_headers_sha256,
        mode, loaded_module_path, loaded_module_sha256, export_or_capsule_name)

Use the exact canonical normcase(resolve(file))/qualified-name/first-line
scheme already used by heldout_identity; the descriptor is checked against the
actual root function at bind time. Multiple Region instances aggregate by that
identity but keep separate process-local binding IDs. Do not use an unqualified
method name, latest's possibly changed digest, numeric code equality or a
process address as the persistent identity. Retry records name their actual
binding, never whichever program happens to be latest after a callback.

The typed capsule seals its adapter signature, source/plan digest, ABI and mode.
AOT metadata originates in module initialization and names the loaded export;
binding resolves the adapter address to its actual loaded module and verifies
that module's identity. Hashing the loaded .pyd and stage-owned artifact remains
an independent auditor action outside the raw interval. JIT mode binds the
actual linked adapter/native libraries and their generated IR/source identities;
it cannot be inferred merely by failing to find a DLL path. No Numba import is
needed to bind/audit a saved AOT capsule. Native-build-proof.md is prerequisite.

An adapter certificate contains the emitted audit protocol version and proves
that all normal/status exit blocks reach the epilogue. This is a trusted
compiler/C instrumentation proof, not an adversarial security boundary against
a malicious extension. It is independent of product Python success counters.

## Counter and per-invocation record schema

Keep raw fixed-width integers in a C-owned bank. Aggregate counters are updated
by C/LLVM sites and cannot be set through Python. Optional per-invocation audit
records live in a preallocated raw buffer. Snapshot/drain allocates Python data
only after the atomic interval and unrelated pin release. Never call a Python
observer, use a ContextVar, hash a Python object, format a string, create a Python
int, read a clock or append to a Python list from a counter site.

Suggested production diagnostic interfaces, finalized during implementation:

    native.direct_audit_open(capacity) -> DirectAuditSession
    native.direct_audit_enter(session, canonical_identity) -> DirectAuditScope
    native.direct_audit_leave(scope) -> immutable plain snapshot
    native.direct_audit_close(session) -> immutable plain snapshot

The Auditor lifecycle opens this session when starting its observations and
closes it during restore; start_profile must arrange both existing profile
observation and the new raw session for the staged integration tests.
These are opt-in runtime diagnostics, not ad-hoc behavior/test flags. A scope is
entered outside Region.attempt, before preparation; the matching leave is in
its finally. C TLS holds an integer scope ID/raw session pointer so a new bound
adapter created during that attempt is covered. Nested attempts get distinct
scope IDs and unwind in order. Recursive calls within one compiled root are
one root invocation, not additional complete calls. A session owns no Region or
user-class reference; auditors retain canonical strings and opaque IDs only.

Per raw invocation:

    NativeRecord(
        scope_id, attempt_id, binding_id, retry_index,
        envelope_entered, validation_outcome,
        adapter_entered, adapter_returned,
        numba_status, checked_status, exit_reason,
        raw_cleanup_complete, nonresult_pin_count_after_cleanup,
        result_ownership_selected, native_outcome)

Counter meanings and insertion sites:

- envelope_entries: first C envelope entry, after Python c_call observers. This
  alone is NOT proof of compiled/native entry.
- preentry_declines: final layout/ABI/capacity validation failed before adapter
  invocation. It must not increment adapter_entries or native_ok.
- adapter_entries: emitted in the actual typed LLVM adapter's first basic block,
  not immediately before calling its pointer in C or from a Python wrapper.
- adapter_returns: emitted in its common epilogue after the lowered native
  function returns a status/result. The certificate guarantees the body was
  invoked rather than bypassed. Inlining does not change this semantic proof.
- native_ok: both Numba status and generated checked-status indicate success.
  It means successful native computation, NOT a completed Region call.
- checked_exits: native returned with overflow/bounds/division/depth/capacity
  status. Classify reason, including retryable capacity versus final decline.
- native_errors: native exception/internal-status return; retain raw code only.
  Dynamic exception data requires the ownership cleanup certificate.
- cleanup_completed: C has released raw maps, unrelated pins and all failed-call
  owned buffers, or transferred only required return references. Counter writes
  occur after the operations they attest. No Python exception reconstruction
  happens before this state.

One raw record is stored in each invocation context even when the optional
session buffer is full. A full buffer sets dropped-record/lost-evidence flags
and preserves available aggregate counters; it must not allocate or change
application results/selection inside the interval. Counter overflow saturates
with an explicit lost-evidence flag, never wraps into plausible counts. Any
loss fails held-out acceptance. A process crash/non-return yields an incomplete
child, never a fabricated cleanup record; the harness preserves FAILED.json.

GIL-held mutable-graph mode serializes raw updates; choose an explicit volatile
or suitable atomic-store protocol so LLVM cannot remove/move the prologue or
publish completion ahead of cleanup. It uses header-derived field offsets.
Free-threaded mutable graphs remain unsupported. Instrumentation adds only
per-entry/exit memory operations, never per-numeric-load calls.

## Whole-call success and exception accounting

No C counter can prove that a subsequent Python wrapper returned successfully:
a profiler or allocation can raise after C returns. The auditor therefore joins
C evidence with independently observed Region.attempt outcome. It increments a
successful direct/aot/jit call only when all these conditions hold:

1. The wrapper actually returned (True, value).
2. Exactly one final native_ok record for that completion has matching sealed
   binding identity and completed cleanup; earlier checked retry records may
   also exist but are not successes.
3. No Python fallback was observed for that completion and no record/ABI/source
   identity is missing. The direct rule delta is independently reconciled,
   never used as entry evidence.

A native_ok followed by output conversion failure, a profile exception, or any
other Python exception is a native success but zero completed calls. Keep that
record and classify postnative_python_errors; don't rewrite it as a checked
native exit. No separate C 'complete' bit is allowed to override the actual
wrapper outcome. A status failure followed by ordinary replay similarly has
zero direct success, even when Python eventually returns a valid answer.

wrap_attempt must use a result sentinel and a raised flag, then do snapshot,
entry/exit bookkeeping, rule validation and ContextVar unwind in finally. Do
not inspect result[0] when the sentinel remains. A BaseException must propagate
unchanged; do not replace it with a secondary auditor assertion. Copy exception
type identity only, never retain the exception or traceback/arguments in rows.
If audit snapshot/reconciliation itself fails while an exception is active,
mark the audit invalid and preserve the original exception. If profiling is
disabled by a raising profile callback, record observer_lost and preserve prior
C records; the stage fails closed rather than hiding the original failure.

Suggested row extension:

    raised_attempts, postnative_python_errors,
    direct_native={envelope_entries, preentry_declines, adapter_entries,
                   adapter_returns, native_ok, checked_exits, native_errors,
                   cleanup_completed, dropped_records},
    audit_errors=[], audit_valid=True

Rows keep existing aot_calls/jit_calls/unknown_native_calls success semantics.
Record rejected/raising attempts and their binding/native events under programs,
not only successful attempts. Preserve every attempt's identity, statuses and
cleanup outcome in untimed audit evidence. In a bounded summary, loss must be
explicit; do not silently replace event history with the last event.

## Required harness integration after activation

capture_audit wraps ordinary program.run as today and uses direct C snapshots
for direct entries. It must not double count an adapter also exposed through a
wrapper. It records events in exceptional finally paths and reconciles against
product counts only after computing independent outcomes.

heldout.py must require zero missing/lost/unobserved entries, audit_valid, full
ABI/source/binary proof, and canonical per-function/backend/mode reconciliation.
It must carry computed direct_report/decline even for zero feature counts. Saved
and audit process counts must still agree exactly. Existing baseline stages
without direct APIs remain baseline-only; later stages requiring direct_calls
cannot quietly label a missing observer optional.

phase_child must snapshot C counters around both uninstrumented and
instrumented calls. Raw-adapter entry cannot be inferred from native_ns=0 or
product AOT counters. Existing Python phase wrappers miss the C envelope and
must not relabel its complete time as pure native. Initially report the C
interval as one separately named unpartitioned envelope scope and mark old
load/guards/native/result phase attribution unavailable. Any later internal
phase timestamps require separate instrumentation and behavioral validation;
never insert Python timer callbacks into the interval. Candidate uninstrumented
complete-call timings remain distinct from instrumented diagnostics.

## Staged test matrix

- Genuine direct JIT and saved AOT success: actual adapter entry/return/native_ok
  and cleanup each one, one completed call, matching canonical/ABI/source proof.
- Preentry descriptor/ABI/layout decline: C envelope may be entered but adapter
  entry is zero; no invented direct success.
- Capacity retry: two actual adapter entries may yield one checked exit and one
  native_ok, but exactly one completed direct call. Exhaustion gives none.
- Overflow/bounds/depth/division status: warm direct success first, then actual
  failed native entry plus cleanup, zero complete direct count and correct replay.
- Raising attempt after genuine C execution: actual entry/native_ok/cleanup
  remain visible, raised_attempts=1, postnative_python_errors=1, direct/aot/jit
  complete counts zero. The exact BaseException propagates unchanged.
- Synthetic raising wrapper unit test: bookkeeping appends an entry then raises;
  finally preserves it. This tests recorder control flow only, not C provenance.
- Raising snapshot/reconciliation/observer-loss paths: invalidate audit while
  preserving original exception and already captured raw evidence.
- Repeated/nested attempts and two Region wrappers for one function: records
  disambiguate scope/binding IDs while canonical aggregation remains exact.
- Copied/mismatched capsule, stale extension fingerprint, record overflow or
  unmatched successful outcome: fail closed. Never infer AOT from product flags.
- Numeric float/int box identity and immediate nested-owner weakrefs remain the
  same with audit enabled. Dropping unbound ordinary classes with Region/audit
  alive also works; session/counter records own no class or result reference.

Draft exception/lifetime tests are outside tests/. No runtime claim is made.
