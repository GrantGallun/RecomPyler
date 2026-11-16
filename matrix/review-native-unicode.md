# Independent review: scalar native Unicode

Status: **open; not accepted**. One continuous capability review under CHECKPOINT43, S38.6 and S42. Reviewer: review_native_sets, 2026-11-14. This review covers the Unicode changes in lift.py, _unicode_native.py, _text_owners.py, tests/test_native_unicode*.py and UNICODE-DESIGN.md, with read-only inspection of existing AOT/guard machinery and the installed Numba Unicode model. No tests, builds, probes, profiles or timings were executed by this reviewer. The shared lock is occupied; queued tests are not passing evidence. Only this review file was written.

## Concrete findings requiring fail-first evidence and correction

1. **Loop else is treated as unconditional, restoring the wrong selected owner.** _text_owners.py:162 analyzes the else environment as the sole post-loop environment. With distinct exact strings, the following Python function returns s but its certificate selects argument t; materialize() then replaces the native result with t:

   ```python
   def selected(s, t):
       y = s
       for unused in range(1):
           break
       else:
           y = t
       return y
   ```

   The same issue exists for while/break. Equal-content distinct strings expose identity loss even when equality passes; unequal strings expose an actual value difference. The coordinator added both families to the queued red analyzer witness and public result tests. Any correction must account for break exits after body stores, and for else blocks that return: joining only the initial environment with the else environment is insufficient. Example: assign y=t before break, put y=s in else, and return y. Conservative unknown provenance is an acceptable initial slice.

2. **Equal global rebinding preserves value but invalidates the selected owner certificate.** lift.py:2114 permits structural equivalence after an identity guard miss. _text_owners caches the old global owner and materialize() returns that object. Warm a function returning GLOBAL_TEXT, GLOBAL_NUMBER and its text argument; replace both globals with equal-content distinct exact str/int objects. Python selects the new objects, while the existing certificate selects the old ones. The coordinator queued step3-unicode-rebinding-red-v1 before correction. All selected numeric children matter, not just Unicode leaves. Exact identity of all unit guards before preparation and on warm calls is an appropriate conservative text-only rule. A selected root default is filled from current full arguments and therefore has a different owner path; the default rebinding test is a coverage gate rather than a proven wrong root-default result.

3. **Warm text calls introduce import callbacks.** lift.py:3859 and3930 execute `from . import _text_owners` on every text call. A counting builtin __import__ hook installed after warming observes these imports; the pure original `return s.isupper(), s` performs none. The fact that the module is cached does not remove the builtin import callback. Retain a filtered hook red witness before fixing this; bind the helper at supported module initialization so both preflight and materialization avoid per-call imports. New observer checks must avoid introducing the same callback themselves.

4. **Active observers can observe omitted original events; no text-only guard exists yet.** For `return s.isupper(), s`, a profile callback filtered to c_call of isupper on that exact input sees one call in CPython and zero in the native body. Python tracing and PEP669 monitoring can observe the original function's omitted code/call/return/line events as well. Add fail-first cold and warm observer cases, then delegate before preparation when relevant observers are active. Check global and local PEP669 events for all tool slots, not only installed callbacks or global masks. This is a concrete behavior requirement for the newly admitted text slice; the generic lifter's existing observer policy is not evidence that the new slice preserves these events.

5. **Known counter proof omits For-target stores.** The coordinator identified this before dispatching review. The current counter test inspects Assign/AnnAssign/AugAssign writes but not For targets. `n=0; for n in values: ... n+=1; return n,s` can retain a selected noncached input integer on a path without addition, while receiving a fresh/canonical counter certificate. The queued fail-first analyzer and public owner tests must execute before correction. A proof must cover every store, including outer and nested loop targets, rather than only syntactically recognized additions.

These are product semantic issues, not requests to expand representation scope. Each needs retained executed red evidence and a focused green result before capability acceptance.

## Safety assessment of the intended limited slice

Exact str packing plus recursive inert scalar/tuple argument preflight is the right boundary for preparation purity. Selected arguments are recovered by parameter provenance; original code constants are located through LOAD_CONST positions after source/bytecode recipe comparison; tuple and fresh-scalar alias plans use a per-call memo. This avoids value-equality owner inference. Ambiguous selected joins and new string builders correctly remain declined/strict expected failures in this slice. A false decline is preferable to repairing a result with an unproved owner.

I inspected the installed UnicodeModel, unboxer, boxer and _get_str_slice_view. Unboxing pins the original Python owner in MemInfo and sets parent to it. A character view keeps MemInfo, adjusts the data pointer, and explicitly sets parent=NULL. Consequently _identifier reconstructs a checked temporary for a character view rather than testing its whole input owner. The initial suspicion that a view of 'A1' would test the entire parent is closed by this source invariant; no speculative parent rewrite is requested. Other admitted view-producing paths must retain that invariant. Ordinary Unicode boxing recreates a result, so public selected owners still require the separate positive plan.

No concrete algorithmic defect was found in the inspected current-Unicode predicate or native search code. Property calls use this interpreter's symbols rather than Numba's copied database; lower/upper/title track cased and preceding-cased state. Search normalization avoids adding positive lengths to nonnegative extreme bounds, clamps negative bounds before differences, and advances empty-needle count searches to termination. This source assessment does not prove exported-symbol linking, native/AOT execution, current-UCD parity or search-error parity; those remain executable gates.

Unsupported operands must delegate before application effects. The proposed all-unit exact guard check belongs before any preparation probe. Unknown calls/stores remain declined; input callbacks must occur exactly once through the original function. Preserve named decline reasons for missing owner/type/read-only proofs and compile errors rather than presenting them as native coverage. No changes are requested to protected startup/load/write-back paths or other waves.

## Focused verification and evidence gates

- Execute and retain the already queued counter, for/while-else and global-rebinding reds, plus import-hook and observer reds, before their corresponding fixes. Include loop body stores before break and an else-return continuation case.
- Compare actual Python types, selected argument/code/global owners, fresh scalar aliases, fresh tuple aliases and nested shared children. Include noncached integers/floats and equal-content distinct strings. For characters, distinguish two independent noncached reads `(s[0],s[0])` from one assigned character reused as `(c,c)`; include Latin-1 characters inside two/four-byte inputs, surrogates and repeated loop iterations.
- Exercise identifier on native-only character views, such as the characters of 'A1', as well as unchanged original parents. Include CPython-new Unicode points, categories, mixed-case/title sequences, NUL, surrogates, empty strings and all storage kinds. Require exact bool, not merely truth equality.
- Execute exhaustive small and extreme search-bound cases with empty/missing needles, None/bool/int bounds, oversized Python integers that must delegate, and errors. Compare exception type, arguments and evaluation/callback order; do not suppress a wrong path by accepting equality alone.
- Run actual capture/verification and real AOT exports, then a fresh process that never imports Numba. Current tests cover selected/nested/literal/count/search/all_predicates; add fresh scalar_alias, character-view identifier and extreme/None-bound search witnesses so the exported native-only paths are exercised. Assert per-case native/fallback counter deltas.
- Bind successful evidence to the exact product sources, generated source and actual artifacts. The new _rc_text_semantics literal incorporates both helper files into generated source/AOT digests without importing Numba in a fresh AOT wrapper; the runtime key also includes it. The changed-semantics rejection test is a useful gate, but actual fresh artifact execution and before/after seals are still required.
- Before acceptance, retain the final matrix, combined union and complete held-out native-function/share accounting required by steering. State the row improvement and whole-function movement honestly. The earlier hand-written character ceiling does not establish this product's gain, reach or deployment.

## Reviewed source identities

SHA256 at this initial review checkpoint (later corrections require updated evidence):

| Source | SHA256 |
|---|---|
|src/recompyler/lift.py|b481538c9697b4bd0bf0cab7fce1f5d461de7a1db864ff65918546606d2f4b4c|
|src/recompyler/_unicode_native.py|98d911ae7cee455eaa038b40fb0d5d49d986c13c7fbdcce2421667e841137593|
|src/recompyler/_text_owners.py|9a1a91cf938fa77e8c40d555e93e370e23249d13619928636a0262566cd9e8ca|
|matrix/UNICODE-DESIGN.md|50cc9ac950fe80c06f37270bed275a0473f72c649f1ebfb8785176487be90fb9|

No capability acceptance or passing-test claim follows from this initial source review. Follow-up corrections and retained results will close findings in this same review artifact.

---
## Follow-up: retained red-v2 and corrected source (same review)

Inspected matrix/temp/unicode-focused-red-v2/complete.json and its stdout: exit1, unchanged=true, **16 failed,236 passed,2 xfailed**. The seal's lift.py and both helper hashes match the initial reviewed implementation. This is executed fail-first evidence, not a green result. The failures include both skipped-else substitutions, actual noncached loop-target identity loss, equal-global rebinding, all four profile/trace/local-monitor/import observations, and char_count/AOT declines. The initial n=0 analyzer test had accidentally missed the counter bug because LOAD_SMALL_INT was not mapped; using the canonical global COUNTER_ZERO exposed owner.kind='counter'. That masking issue is retained plainly rather than counted as a successful protection. The unknown-callback test failure was an existing early Unsupported outcome; accepting that safe decline avoids an unrelated recognizer expansion.

The corrected source addresses each reviewed mechanism appropriately, pending executed green evidence:

- LOAD_SMALL_INT joins LOAD_CONST in original-owner mapping. The positive counter proof now examines every Store node and excludes the outer loop target; nested For targets also fail the permitted AugAssign-target test.
- All body stores are widened before loop exit. A possibly breaking loop merges that widened environment with its else continuation, retaining the break continuation even when else returns. Counting nested breaks conservatively can decline extra cases but does not justify an unsound owner substitution.
- text_ready() checks inert namespace keys and exact identity of unit globals/default/code guards on warm calls, including numeric selected globals, before preparation. The cached owner plan therefore cannot survive an equal-value owner replacement.
- The pure owner helper is imported at lift module initialization; text entry and materialization no longer import it per call. Trace/profile/PEP669 query functions are retained once. Text entry delegates for active trace/profile, any global event mask, or relevant local code events across all six tools before certificate preparation. This directly addresses the omitted-event witnesses without relying on generic lifter behavior.
- Nested packed Unicode shapes are also checked before any native preparation. Mutable/list/record inputs are not admitted merely because packing can now find Unicode inside them. The broader existing packing machinery is unchanged and is not newly certified by this review.

No new concrete algorithmic or ownership defect was found in these corrections. The revised break merge, store certificate and exact guard rule satisfy the conservative constraints sent during initial review. This closes the source-design objections, **not their executable acceptance**. Focused green-v1 is queued behind the shared lock and has not been reviewed as passing evidence.

Additional focused gates sent to the coordinator: a store to y before break with a conflicting else assignment; a skipped else-return followed by an outer return; a nested For target reusing a canonical counter; cold observer delegation, global PEP669 events and tool5 local events; a late non-str namespace key that must delegate without equality callbacks. These are concrete missing coverage cases, not claimed new failures.

The expanded real/fresh AOT test now exports ten functions and exercises scalar aliases, independent versus shared character results, character-view isidentifier, current predicates and None/extreme search bounds across one/two/four-byte strings. It asserts per-case native-call increments and no Numba import in the fresh child; helper-semantic mismatch must reject the artifact. Those are appropriate gates, still pending execution. The Unicode source-bound runner captures product/helper/test sources, the exact command and artifacts, rejects changes under execution, and retains failed directories; no artifact from a failed attempt establishes acceptance.

Corrected source SHA256 inspected at this follow-up: lift.py `80185ee83b3880d9985f2c629145f07da3fb3d65622db3bc30c659e2beab6b6b`; _text_owners.py `d7d5a6f0f1137e265c521258279ba1d616b79cdd97aa54d03652e60af1477dcb`. _unicode_native.py remains the initial reviewed helper.

Status remains **open pending focused/AOT green, final combined union/matrix and complete375-function/top-ten held-out accounting**. S45 limits this capability to finishing and committing the scalar slice, then managed calls ahead of borrowed bytes; no string builder expansion is requested. No executions or product/test edits were performed by this reviewer.

Coordinator follow-up: all five additional gate families above were added before the queued green-v1 begins, including cold/warm observers, global/local monitoring through tool5 and the colliding late namespace key. Their executed outcome remains pending. The held-out first-failure report and optional sealed post-merge comparison are planned accounting evidence; this source review does not treat the baseline59/375 or proposed final counts as a measured Unicode gain.

## Matrix harness observer follow-up (independent review)

The full matrix currently installs sys.settrace around every run_case through
observe_failures. The Unicode product correctly delegates while tracing is
active, so those rows cannot measure ordinary observer-free eligibility.
The correction belongs in the harness. Product observer and entry guards must
remain unchanged, and observers_clear must not be mocked or bypassed.

The proposed temporary wrappers around Lifted._run and profiler verification
functions are an appropriate observer-free collection mechanism, with one
required addition: try/except around profiler.test_lifted and _test_region alone
cannot see their internally caught exceptions. Both functions catch verification
exceptions and return status=rejected with reason 'a captured call raised TYPE
when replayed'. The wrappers must inspect that returned exception outcome too,
or instrument the relevant comparison helpers before their internal catch.
Otherwise the earlier None-verification TypeError becomes invisible again.
Normal wrong-result rejection must still use direct replay and preserve verdict
wrong; a rejected-exception outcome is a verifier failure, not a safe decline.

Recommended collector behavior:

- Capture and re-raise actual exceptions leaving Lifted._run before _prepare
  swallows backend compilation failures. Keep owner and phase information.
- Capture escaped verifier exceptions and returned rejected-exception outcomes.
  Existing public rejection replays still distinguish native wrong results from
  fallback failures and verifier-only crashes.
- Preserve named Unsupported and generator control exceptions as their existing
  non-backend outcomes. Do not install trace, profile or monitoring callbacks.
- Save the exact current callables on entry and restore them in finally, even
  if fixture/candidate execution raises. This stays in isolated serial workers.
- Consider recording compiled_calls at failure and requiring a later increment
  to count recovery; a success before a warm failure must not hide that failure.

Required retained gates after the active frozen runs finish: existing injected
backend error, wrong/fallback, alias and generator tests; a swallowed verifier
TypeError on a None-containing fixture yielding crash plus verification
internal_errors; a legitimate named Unsupported decline; unchanged sys.gettrace
through the collector; restoration of exact callables after exceptional exit;
and a real scalar str predicate row becoming native without active observers.
The existing product tests for true trace/profile/PEP669 delegation must still
pass. The no-trace native-text test must fail against the current trace collector
before the harness correction. No source/test/corpus changes were made during
this design review, and no capability acceptance follows from this plan alone.

## Observer-free matrix collector implementation signoff

Reviewed the concrete run_matrix.py and test_matrix_harness.py changes. Approved
at harness SHA256
99760d303ed7fe3b4e6ac388a0256e220cd040a84728ae667d72fc5f484c98e6
and test SHA256
abc2d41f19060175cf9fa35ce41b6b3aab7448cc23cb3dcd122b15085d8dc975.
Both current hashes match matrix/unicode-harness-green-v1/complete.json, which
is complete, exit0, unchanged=true. Its stdout reports 79 passed,38 warnings.
The retained red-v1 receipt is complete,exit1,unchanged=true with 6 failed,8
passed; it exposes tracing interference, hidden verifier outcomes, warm failure
masking, and NaN-payload collapse before the correction. The red Unsupported
row expectation was corrected because the alternate region engine can still
compile the row legitimately; the direct collector Unsupported exclusion gate
remains explicit.

The new scoped ordinary-call wrappers record/re-raise actual _run exceptions
before _prepare can swallow them, and handle both escaped verifier exceptions
and the exact rejected-exception schemas emitted by current test_lifted and
_test_region catches. Existing direct replay still classifies actual native
wrong results as wrong and fallback errors as crashes. Exact saved callables
are restored in finally. No tracing/profiling/monitoring callback is installed,
and no product observer guard is bypassed. Failure-time compiled_calls prevents
an earlier success from erasing a later unrecovered compilation failure.
No blocking coverage or error-detection loss was found in this concrete change.

The union expectation corrections are justified: uses_string computes
len('abc')+x, now supported by this capability, and its replacement test checks
results through verify plus positive native execution over int/float inputs.
The owner-liveness helper now selects the first generated FunctionDef rather
than the preceding semantic metadata assignment; its original copy/liveness
assertions remain intact. Neither change relaxes a wrong-result expectation.
Float freezing now preserves all IEEE bits, including NaN payloads and signed
zero, strengthening the S49 oracle; complex components use the same projection.

This approves the harness correction and reviewed expectation updates. It does
not substitute for the still-required complete observer-free matrix, combined
union, held-out counts/first failures, or capability acceptance evidence.

## Unicode lazy-source-loader correctness correction: design review

The actual public-consumer witness in matrix/binding/probe_unicode_loader.py
blocks Unicode acceptance: after lift(predicate), replacing its concrete
linecache entry with a lazy loader makes the first compiled call execute the
application loader, whereas the original predicate executes no loader. Native
result equality and compiled_calls=1 do not make that extra callback acceptable.
This finding requires retained fail-first evidence, a correction and fresh final
S42 gates; the already-running frozen union cannot certify changed sources.

The proposed smallest correction is approved in principle: obtain source only
from inert concrete cached lines or an encoding-aware raw local source file,
locate the original function span, and perform the existing isolated code and
position checks. Refuse lazy/custom entries rather than invoking inspect or
linecache source-provider machinery. Do not activate full-context method binding
as part of this correctness repair; S57 remains the next separately reviewed
capability after Unicode acceptance.

Required safety details for the concrete diff:

- Do not call linecache.getlines/updatecache/lazycache or an application loader,
  get_source, module import, decorator, default or module body to obtain text.
- Validate cache/container/key/entry/line shapes using exact inert types before
  truth conversion, iteration, lookup or join. A custom cache key colliding with
  the filename can invoke equality during dict lookup, so validate keys before
  looking up an exact str filename. Tuple/list subclasses and lazy callables
  must be refused without invoking their hooks.
- Locate the original source span by original code metadata and source line
  (including decorator starts), not mutable function display attributes. Require
  a unique valid span. Preserve original AST/pure-site checks and unchanged
  constant/flag/exception/position comparison; stale text never becomes proof.
- Keep rebuilt source/AST/code transient and original constants resolved solely
  from original guarded code. Missing or malformed sources produce a named safe
  decline and execute the original function exactly once with no source hook.
- Review file/compile callback boundaries as well as lazy loaders if source
  analysis stays inside the first compiled call. Eager source-only certificate
  construction during explicit lift/load setup is an alternative worth testing;
  this note does not authorize a broad unrelated entry redesign or claim all
  compiler/audit activity has already been verified observer-free.

Required regressions include the actual cold public-loader witness, malformed
and subclassed concrete cache entries, colliding non-str cache keys, no lazy
loader calls on decline, ordinary real-file/cached-source controls, stale text,
original owner/observer/AOT behavior, and source-only before/after2/38 accounting.
Independent concrete-diff review and completed unchanged focused/union/matrix/
held-out evidence remain necessary before the Unicode capability can be accepted.

### Eager Unicode certificate construction: concrete placement review

The proposed minimal addition is approved in design. The owner source assignment is in `_Unit.define`; calling `owner_info(mangled)` immediately after that assignment captures the original source certificate before returning from explicit lift construction. The AST copy predates rewriting, and certificate analysis only needs that original node and function, so appending generated definitions afterward is sufficient. `AotLifted` reconstructs through the same `_Unit.function`/`define` path and receives the same eager protection. Existing `source()` guards pin the original function code object; eager construction does not excuse later code, dependency, namespace, receiver-type, or observer guard checks.

Invalid certificates must also remain cached, so a first public call cannot retry source acquisition. Retain fail-first cases for both a lazy loader installed after lift and a cache-cleared file-backed function whose raw reader is then instrumented, with cold and warm calls. A public call must perform no provenance source read/recompile. The direct neutral API must separately reject custom/lazy linecache entries and hostile non-string cache keys before any dictionary lookup, iteration hook, join, or loader call. Preserve the existing exact isolated bytecode/position match and semantic refusals; full-context matching remains S57. This approves the design only; source review and new frozen-source receipts remain necessary after the confirmed callback defect.
S58 supersedes the earlier receipt/freeze/re-review requirements in this file. The single implementation review's executable findings have regression coverage; the final source/heap-admission review is in review-text-admission.md.
