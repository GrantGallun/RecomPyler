# Preparation test eligibility and review disposition

These are source-inspected classifications, not executed results. Both draft
files remain outside `tests/`. The current product has no `direct_calls` or
direct adapter; every positive direct assertion is intentionally fail-first.

## Current compiler versus required direct behavior

| Cases / draft functions | What current source establishes | Required new direct behavior |
|---|---|---|
| Pure `field_comparison`, `field_value`, `list_total`, `list_first/last`, supported slots | _Gen has ordinary typed field/list/comparison lowering; loader checks exact numeric kinds | Must execute direct and increment direct_calls; preserve values and original numeric boxes |
| INT64 endpoints, 2**53+1 in INT fields/lists | _seed and loaders allow full signed int64; INT uses I rather than double | Must execute direct without compact-long assumption or rounding |
| INT input 2**63 | _seed raises Unsupported for an int outside int64 | Existing Python fallback, direct_calls remains zero; do not call this a new direct reach gain |
| FLOAT signed zero/NaN | Exact floats are representable by loader; direct bit identity not present | Must execute direct and preserve original box/bits |
| MIXED record field chosen from int/float records | Class-field joining uses MIXED; loader accepts int only in its exact-double domain | Must execute direct for the tested domain with one box/token for payload and tag |
| Numeric mixed list | widen_cell explicitly rejects MIXED/optional list element joins | Outside the draft positive list tests; retain current fallback, not a claimed direct implementation gap closed by pretending a list is homogeneous |
| Returned input record/list; aliases through fields/list/argument | _Unloader.made retains original handle objects; canonical list contracts exist | Must execute direct and preserve this map/identity behavior |
| Numeric returns through calls/phis/loops/private fields/lists | Those constructs are lowered, but _Unloader.result/value rebuild numeric boxes | Must execute direct with provenance, including scalar-replaced fields |
| One shared versus two equal arithmetic definitions; dynamic loop producer | Arithmetic payloads are lowered; no per-dynamic-definition identity representation exists | Must execute direct and preserve sharing/distinctness |
| Unary plus, float(float), positive int abs, min/max ties | builtin_plain and unary lowering support them; min/max already chooses the first equal payload | Must execute direct with original-box forwarding/exact recipes, not new-box reconstruction |
| Numeric `is` inside compiled function | compare rejects Is/IsNot for numeric values (except None/reference cases) | Not required by these tests; preserve current decline until identity-op coverage is explicitly added |
| Globals/defaults/code constants, folded arithmetic and folded unary | Existing source lowering accepts the payload; const guard may compare equality rather than identity; source AST is used despite original bytecode folding | Must execute direct for supported origins; use real co_consts/default/global reference and identity guards |
| Known finalizer class | lift._record_problem rejects a class whose MRO defines __del__; register adds lifetime guard | Existing Python fallback with no extra finalization; zero direct calls |
| Known custom __getattribute__/allocation | _record_problem rejects hooks/custom allocation during registration | Existing rejection stays; late mutation still needs final C protection |
| Descriptor/property installed after cached preparation | Current lifetime guard covers finalizer/allocation, not a complete field-descriptor layout guard; native loader may read dictionary values directly | New final C/layout guard must reject direct before any getter callback, then Python behavior calls getter exactly once |
| Class hook installed after cached preparation | New registration rejects hooks, but warm loader/guards alone are not the new atomic layout certificate | New direct guard must decline before hook execution; Python behavior exactly once |
| Entire __dict__ replacement / list reallocation between calls | Current ordinary loader traverses current input; no saved live-pointer contract exists | Must execute a new direct call from fresh storage, never reuse stale pointers |
| Dict/field/list mutation in profile c_call at direct_execute | No direct envelope exists now | Test must reach actual C boundary; fresh safe walk or clean replay must see current state |
| Weakref detach / late __del__+detach at C entry | Existing ordinary loader holds graph refs in Python/C bookkeeping | No nested pin may exist across this observation boundary; callback must occur inside the detach operation |
| Output GC detaches non-result child | _Unloader.made currently holds all input objects during result construction | New direct path must release unrelated pins before any tracked output allocation; weakref callback fires immediately in GC callback |
| Independent readonly field with private-arena mutation | Existing compiler performs arena mutation/writeback | Positive direct execution required for the independent field; no direct stores, equal numeric replacements retain requested identity |
| Same-field transitive alias write; aliased list append/resize | Current lowering supports mutation and canonical list contracts | Direct plan must not borrow affected locations; whole candidate may choose arena; no stale reads |
| Private list capacity growth/exhaustion | Existing list helpers set capacity status and Region retries/replays under slots/MAX_SLOTS | Warm direct call required, then successful retry or clean replay as parameterized; no retained pins and no success count for failed attempts |
| Recursion exit | Existing top depth check uses MAX_DEPTH and replay | Warm direct recursion required; forced lower runtime depth exits and replays without pin retention |
| Overflow/bounds/division failure | Existing checked arithmetic/indexing sets status then Python replay | Warm direct success required; failed attempt leaves inputs unchanged, does not count direct success, and next good call remains direct |
| ABI mismatch | No direct binder/capsule exists today | Actual binding attempted; C rejects mismatch before entry; ordinary compiled arena fallback still works |
| Saved AOT in fresh process without Numba | Existing build_regions and loader have source-only AOT test coverage; no direct capsule/adapter contract yet | Must actually execute direct AOT, exact original numeric box, aot_calls=1, jit_calls=0, no Numba module import |

## Review tests added

`test_direct_read_review.py` adds ten test functions with parameterized
capacity, checked-exit and folded-expression cases. They cover dictionary
replacement between calls and at C entry; weakref-only detach; real output-time
GC; capacity/recursion/checked-failure cleanup; ABI mismatch; and saved AOT in a
fresh process with a rejecting Numba import hook.

The managed-inline test warms on a different sample, then sends a fresh untouched
instance through the cached direct path before replacing its entire dictionary.
Initial schema discovery must not accidentally materialize the instance being
used to prove inline storage coverage.

The output-GC test warms the program, disables GC for setup, then arms a low
threshold in the real profile c_call for the exact C envelope. Its 24-element
output tuple avoids the installed header's PyTuple_MAXSAVESIZE=20 freelist.
Collection scheduling still needs activation evidence; a header allocation
declaration alone does not prove the callback phase. The GC start callback changes the
read field and detaches an unrelated owner. Returned values must reflect the
completed native reads, while the unrelated weakref callback must occur
immediately between detach markers. The test asserts the GC callback actually
ran. Any environment-specific trigger adjustment must retain this non-vacuous
condition and must not add a production test hook.

Failure tests change existing MAX_SLOTS/MAX_DEPTH controls, not a new test-only
production flag. Native status/cleanup diagnostic deltas may be added during
implementation if needed to prove an exact exit was reached, but normal results
and direct execution counters remain the behavioral assertions.

The ABI mismatch test specifies a new production binding API
`_native.direct_bind(capsule, expected_abi, expected_source_digest, owner)`.
It perturbs the expected ABI at that boundary and requires the ordinary compiled
variant to remain available. Capsule validation must also validate owner/source,
not only the integer version.

## Independent-review rulings

- Accept the managed-inline/dictionary replacement, weakref detach, output-GC,
  saved-AOT, ABI and failure counterexamples; all are now concrete draft tests.
- Accept explicit native return/NRT/exception ownership certification.
  `typed-ir.md` enumerates the certificate fields and initial rejection of
  unaudited dynamic exception ownership.
- Accept that exact numeric C operations are not automatically callback-free:
  pending-call checks, bounded work and allocator behavior require separate
  proofs. Deferred exact recipes should run after raw reads stop unless fully
  certified.
- Preserve backend accounting: this step's initial positive reach is heap.Region.
  FFT selected lift.py/AotLifted kernels are not evidence of heap direct reach.

## Current uncertainty

No claim is made that a test already passes or fails numerically, that the GC
trigger has been exercised, or that the proposed metadata schema compiles.
The preparation gate forbids those executions. Existing source tells us which
constructs have explicit rejection/lowering paths; activation will establish
actual red/green behavior under the coordinator's lock.


The build-integrity gate is specified separately in native-build-proof.md.
Current setup.py explicitly declares _heap optional, so a zero build exit is
not accepted as proof that the new native APIs/source were compiled. No build
integrity test or verifier is claimed to have run during preparation.
## Additional audit and class-lifetime cases

The preparation now includes test_direct_audit.py (five definitions) and
test_direct_class_lifetime.py (three definitions, with Python/compiled/direct
parameterization). These have not been imported or executed.

Current capture_audit.wrap_attempt loses bookkeeping after an exception because
recording occurs after its finally; the synthetic recorder test exposes that
control-flow defect but is not evidence of genuine C execution. The other audit
cases require real direct entry, success/status and cleanup records. A raised
post-native BaseException yields zero complete calls while retaining evidence;
a secondary audit error must preserve the original exception and invalidate
the audit. Independent native proof remains unavailable until the new protocol
exists; it is never inferred from direct_calls.

An ordinary dynamic class with exact metaclass type is currently accepted by
registration, but source inspection shows strong Program/ObjT/signature/fact
and global _ESCAPES retention. The compiled class-lifetime test intentionally
exposes this existing defect, and required positive direct/audited-direct tests
must fix it rather than turn it into an unsupported-class decline. Python
control supplies the expected collection behavior with the module binding and
last instance removed while Region remains alive.

A custom metaclass with __del__ is already rejected by type(cls) is not type.
That regression is an existing-rejection control, with zero compiled/direct
calls and real class finalizer/weakref collection. Positive direct tests in the
other files still require the new direct_calls interface; this control alone
permits its absence in the current baseline.