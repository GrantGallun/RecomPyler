# Current closure: sealed v3 ready for one planned timing cohort

The same independent diagnostic review is **closed for pre-timing behavior/safety on character-behavior-v3**, within DESIGN.md's explicit trusted installed-stdlib, GIL-held, no PEP669/importtime-instrumentation context and its stated ambient-runtime exclusions. This supersedes the earlier open statuses retained below as review history. It does not accept an unmeasured speed claim or authorize product deployment.

Inspected character-loop-behavior-v3 receipt: exit0;4080 semantic/type/alias/error gates,126 dependency/observer guard misses,6 ownership groups; fresh AOT without Numba executes native routes(6,6,0). Read-only hash verification found zero mismatches across the14 files in complete.json. No executable probes, builds, tests or timings were run by this reviewer.

All concrete findings are handled: configure uses real bindings and a supported builtins accessor; copied-root resolution is corrected; deferred-import callbacks have retained fail-first evidence and finite guarded dependency proof; boxed append reuses the actual stream character; AOT retains its callable in the environment instead of importing before fallback; input alias probes found no mismatch and caused no speculative rewrite. Spec-property and spec-truth red witnesses are retained, and v3 now delegates for their mutations. Descriptor-free spec dictionary inspection, exact ordinary type/class/bases checks, _initializing exactly False, and guarded bootstrap handler/bindings close the cached-import path.

I inspected pinned [CPython3.14.4 import.c](https://github.com/python/cpython/blob/v3.14.4/Python/import.c) and the installed bootstrap. The admitted cached path checks initialization, then reaches the fromlist handler through present __path__; the fixed deque member avoids recursive import/error branches. Importtime output and active frame/monitoring observers are excluded or delegated as documented. Behavior and timing preflight now assert zero PEP669 global/relevant local events; trace/profile delegation is covered in v3.

The planned single alternating three-pair timing cohort is appropriate on these unchanged sealed artifacts. Timing.py links accepted artifact hashes, its own source, and the accepted shlex reference hash before/after, checks native counters and actual full token lengths, and records all individual complete-call samples. Report the resulting combined fresh-wrapper ceiling: borrowed access plus private lexer/StringIO/state and repeated-result-allocation elimination. It is not a pure Unicode-load gain, a general import optimizer, a new held-out native function, or product deployment. Any negative/unresolved small-input crossover remains descriptive evidence rather than a reason to change the profitability gate.

No concrete unresolved counterexample remains in the declared diagnostic scope. Accepting the actual bound still requires the coordinator's one locked cohort receipt, intact seals and correct numerical reporting. No additional scanner variants or reviewer executions are requested.

---
# Independent review: character-loop diagnostic

Reviewer: Codex review_native_sets, 2026-11-14. Scope: S38.3 and S42 diagnostic only, separate from the accepted native-set capability. Read DESIGN.md, char_loop.c, workload.py and installed C:/Python314/Lib/shlex.py. No code, tests, builds or timing were executed. Only this review artifact was written. Behavior/AOT harness review is pending their availability; no bound is accepted yet.

## Concrete findings before measurement

1. **Configuration cannot resolve its deque binding as written.** Installed shlex.__init__ performs a local `from collections import deque`. There is no required shlex-global or builtin deque. configure() nevertheless resolves deque through globals_dict/builtins_dict and raises RuntimeError("missing lexer binding") when absent. Pin a fail-first configuration witness, then guard the actual deferred-import dependency rather than a nonexistent global.

2. **Borrowed constructor omission skips observable import callbacks.** eligible() checks five global/builtin bindings but not __import__, sys.modules['collections'] or the actual collections.deque binding. A counting builtin __import__ hook installed after configure is invoked by the Python wrapper's fresh constructor. Borrowed currently remains eligible and skips that callback. The constructor import can also mutate bindings after the precheck on the boxed route, invalidating a simple pre-construction snapshot proof. Required fail-first witnesses: callback count/order and module/deque replacement. Either establish and guard a trusted inert import context before constructor scalar replacement, or delegate before effects. Exact str and a private lexer do not by themselves make the import inert.

3. **Character identity is not established by recreating codepoints.** Boxed read keeps the actual StringIO.read(1) object in Reader.current, but append() discards that provenance and constructs another character via PyUnicode_FromOrdinal. Borrowed always builds a final Unicode object from the UCS4 buffer. Requested identity witnesses compare whether the token is the original argument for dynamically created one-codepoint strings above Latin1 (U+0100, Greek lambda, emoji), plus cached Latin1, empty, quoted and escaped variants. StringIO's full-buffer paths can matter when the entire input has length1. This is a focused suspected counterexample pending execution, not a reported observed wrong result. Primitive cached-character/input aliasing must not be assumed.

4. **Boxed route has additional character reboxing.** Its StringIO.read already returned the correct boxed operand; PyUnicode_FromOrdinal on each append adds work absent from read_token's assignment/concatenation of nextchar, especially above Latin1. Retaining the actual boxed character would make the comparison faithful and help preserve provenance. Otherwise this extra cost must be named, rather than attributing its removal to borrowed Unicode access.

## Source-level semantic assessment

The C state machine appears to cover the default fresh POSIX constructor's whitespace, comments, quotes, escaping, word/punctuation termination, EOF and two error cases. It is appropriately a complete first-token operation, not all-token shlex.split and not general read_token on a stateful caller-supplied lexer. The discarded pushback/lineno/state writes are private only under the unchanged-constructor/implementation and inert-context proof. Non-POSIX and punctuation modes are outside the wrapper and must not be claimed supported.

The Unicode END sentinel is outside the Unicode scalar/codepoint range; embedded NUL and surrogate codepoints must nevertheless remain explicit behavior cases. Token storage has at most one output codepoint per consumed input character, including double-quote escapes that retain the backslash, so the n-codepoint buffer is sufficient. PyUnicode_FromKindAndData copies the temporary before cleanup; the C-call argument keeps the original text alive for borrowed reads. Success and error cleanup paths release the token/reader/lexer references they own. Configuration/allocation failure handling and module-global state remain diagnostic-only; successful configuration must be sealed before comparison.

The two ValueError messages are taken from the guarded read_token code constants, which can preserve exception-argument object identity if the selected ValueError binding is also the actual trusted builtin. Refcount/error-context and complete exception args still need the planned executed checks. Do not infer them solely from equal rendered messages.

## Scope and evidence requirements

The owned-source statement is that the retained40 files contain no isolated long-character scanner; hexiom's two-character grid parsing and graph allocation is not such a scanner. The authorized stdlib substitute is therefore reasonable, provided the source audit and installed source hashes are recorded. It does not measure a newly supported held-out function or a product deployment.

As DESIGN already acknowledges, borrowed-vs-CPython removes private lexer/StringIO allocation, Python field traffic, stream dispatch and repeated result allocations as well as character access. Boxed also moves lexer-state control into C. Report a combined complete-wrapper ceiling, with exact wrapper/body/source/artifact seals; do not report its entire gain as a Unicode-load gain or automatic reach of scalar replacement in product. The timing input must actually exercise a long scan (record consumed prefix/token length), rather than merely have a long unused suffix after an early first token.

Before any bound timing: close the configuration/import findings with fail-first evidence, resolve character provenance, review the forthcoming harness's result/type/identity/error/evaluation-order oracle and JIT/AOT/fresh-process routes, and ensure guard misses delegate before effects. Include full default grammar and deterministic Unicode fuzzing, long1/2/4-byte inputs, comments with CR/LF, quoted-empty and unmatched quote/escape, NUL/surrogates, success/error refcounts, and binding/code/class/default/GC guard misses. Existing diagnostic exclusions for allocator-failure injection, asynchronous signals, free-threading and subinterpreters must stay explicit and must not turn into product soundness claims.

Status: **pre-measurement review open; no approval**. Concrete blockers and proposed witnesses were sent to the coordinator for locked execution. No reviewer execution or product edit occurred.

## Behavior/JIT/AOT harness continuation (read-only)

Reviewed build.py, behavior.py, bridge.py, fresh.py, config_red.py and context_red.py as part of this same diagnostic review. No reviewer execution occurred. The C configuration/import/character-provenance findings above are deliberately unfixed while the coordinator retains executed red evidence.

**Concrete harness blocker found:** build.py copies bridge.py to matrix/temp/<attempt>/bridge.py, where Path(__file__).parents[2] resolves to the matrix directory rather than the clone root. The resulting matrix/matrix/extension path cannot locate managed.py. The coordinator added an explicit frozen-prefix path witness to queued config_red before fixing it. The original-location bridge root was correct; the copied-location root must be derived from the artifact directory or passed explicitly.

The harness now compares actual result/exception type objects in memory, with JSON names used only for reports. It checks value, input alias, cached Latin1 alias, exception args and ownership of the original error-message constants. Deterministic grammar/Unicode fuzzing, long three-kind inputs, six C/JIT/AOT routes, input ref stability, a fresh output refcount and context event sequences provide useful coverage. Repeated same-wrapper routes make it important to retain exactly the intended input owner for single-character cases.

An original evidence gap was closed by inspection: every ordinary case now asserts the exact native boxed/borrowed counter delta for trusted exact str, or a fallback delta for unsupported input types. Context mutations already require exactly one delegate call and unchanged callback events. Thus an always-delegating route cannot masquerade as native success. Fresh AOT rejects imports of Numba and now asserts both native routes executed six cases with zero fallbacks, in addition to comparing result/type/input identity/errors. The compiled module is a real CC export, not a Python wrapper labeled AOT.

The None fallback witness originally read ambient stdin through shlex(None). It is now isolated by assigning a private empty io.StringIO to sys.stdin in the single-use behavior child, before compile/configure. It therefore tests deterministic EOF without consuming external input.

The bridge's success cleanup balances the temporary callable, argument tuple and result while NRT retains its own result owner. Active exceptions are propagated through the managed bridge's explicit failure path; success/error input ref checks are appropriate. Installed NRT increments the Python owner before allocation, and the bridge undoes that increment on NULL before its ordinary temporary cleanup. Allocation-failure injection remains outside the stated diagnostic scope.

Focused missing witnesses sent to the coordinator: changes to read_token/__init__/punctuation-getter code, StringIO/ValueError bindings, and refcount stability of the reused error-message constants themselves (input refcounts alone do not test those owners). These exercise named dependencies without expanding the tokenizer scope.

**S42 attempt sealing follow-through:** build.py currently seals artifacts and copied source files at the end only; managed.py is imported from its live location and also hashed only at the end. Hash copied inputs and the live managed model before compilation/behavior, compare them after the run, and exclude an attempt that changed. Record the build helper/flags and interpreter identity as part of the seal. The existing unique output directory and complete-only-after-success receipt are good foundations, but an end-only hash cannot prove unchanged-under-measurement.

Status remains pre-measurement and unapproved until the queued red witnesses, corresponding fixes, sealed behavior/AOT results and this same review's follow-up are complete. No additional reviewer or speculative scanner variants are requested.

## Corrected prototype and first full behavior attempt

Read retained config-red-v2 receipts/artifacts and the revised C/bridge/build/behavior sources. Red v1 did not establish semantic behavior because PyFunction_GetBuiltins failed to link; replacing only that access with function.__builtins__ permitted the fresh v2 witness. V2 executed the missing-deque configure failure, copied-root expression failure and, in a separate child with explicitly labeled temporary unused shlex.deque scaffolding, the skipped import callback: reference ['collections'], borrowed []. Source/artifact hashes are retained.

The identity probes in that red child showed **no mismatches** for the requested single-character/quoted/escaped cases. The suspected input-alias rewrite was therefore not made, correctly. This closes the speculative alias concern as a disproved witness family, rather than treating an assumption as a required optimization.

The revised C code resolves the four real global/builtin bindings and captures the actual cached collections module/deque/importer dependency. Boxed append now reuses the actual StringIO.read character object rather than reboxing every codepoint. The copied bridge root is derived from the artifact directory. Build.py now records initial hashes of copied sources, the build helper and live managed model, interpreter identity and /O2 flags; it verifies those hashes after behavior before creating a complete artifact seal. Added dependency-specific code/binding misses and error-message owner ref checks address the earlier harness requests.

**New executed blocker retained by full behavior v1:** receipt character-loop-behavior-v1 is exit1. Boxed/borrowed AOT under the builtin import hook emit an extra wave17_charloop import before the expected collections import, although C eligibility delegates exactly once. Bridge target resolution through py.unserialize(py.serialize_object(target)) occurs before the C guard. This is an actual callback/evaluation-order difference, not an oracle artifact. Retain the failed attempt. The proposed environment add_const/read_const target retention resolves the dependency at module initialization and is the appropriate correction; do not filter the extra callback out of the oracle.

**Further cached-import context witness sent for red execution:** replacing collections.__spec__ with a property-bearing object, or changing the original spec's _initializing to a callback-capable truth value, can make a cached import observable while the initial C guard remains eligible. The installed bootstrap checks spec initialization. An adequate finite proof guards exact ordinary ModuleSpec type/layout/class dictionary/bases and descriptor-free instance state with _initializing exactly False; it also seals the relevant actual frozen bootstrap module, _handle_fromlist code/defaults/kwdefaults and its used global/builtin bindings. For the unchanged constant ('deque',) with present deque, installed _handle_fromlist only reaches isinstance(x,str), x=='*' and hasattr(module,x), then returns the module. Star/missing-member/import/error branches are unreachable. Stable __path__ presence matters; its contents are not traversed on this path. Active Python tracing/profiling can still observe omitted Python/C calls and must be explicitly excluded/guarded in the trusted diagnostic context. The guard itself must inspect the spec without invoking its descriptors or truth callbacks.

The owned-source audit is appropriately descriptive:40 hashed files and413 loop sites, without assuming dynamic receiver types. Inspected hexiom/meteor bodies agree with the limited no-isolated-long-scanner conclusion. It is not a runtime proof about arbitrary receivers or a held-out deployment count.

Timing.py measures complete calls on five routes, alternates forward/reverse order across three pairs, checks actual token length and native-route counters, records individual samples, and verifies artifact/timing-source hashes before and after. Its attribution correctly includes private lexer/StringIO/result-allocation removal rather than claiming a pure character-load bound. One remaining S42 link was sent: compare the currently imported shlex source with the accepted behavior reference hash before and after timing, not only the extension artifacts. No timing or bound acceptance follows from this source review; a fresh green behavior/AOT attempt is still required.


---
# Final numerical closure: one sealed three-pair cohort

The independent diagnostic review is **closed on the measured three-pairs-v1 bound**, within the trusted context stated above. This numerical closure supersedes the pre-timing condition at the top of this file. No additional cohort, executable review probe or scanner variant is requested.

Inspected the locked character-loop-three-pairs-v1 receipt (exit0), three-pairs-v1.json, BOUND.md and the character-loop REPORT section. The JSON is complete and links the accepted v3 behavior seal and current timing source. Read-only verification confirmed those hash links; the retained before/after source, artifact and installed-reference seals are intact. All12 fixtures contain three samples on each of five complete-call routes, with15 per-route counter records per fixture and zero fallback. Independently sorting the samples reproduced every recorded median without mismatch.

At65,536 token characters, CPython / boxed AOT / borrowed AOT medians in milliseconds are:

| Unicode storage | CPython | Boxed AOT | Borrowed AOT |
|---|---:|---:|---:|
|1byte|39.63375|32.07660|0.11645|
|2byte|57.09795|54.06930|0.15600|
|4byte|87.04710|85.95125|0.12530|

Borrowed AOT also wins against CPython and boxed AOT at every measured20-,127- and4,096-character fixture. The evidence establishes no crossover among these measured sizes; inputs below20 remain unmeasured. Three alternating pairs support this descriptive diagnostic comparison without a confidence interval or a general profitability threshold. At65,536 four-byte characters, the small boxed/CPython difference should retain the report's descriptive treatment.

One minor BOUND prose correction was sent to the coordinator: boxed AOT is slower than CPython in all three20-character medians and **one** larger fixture (127 characters,2byte), rather than "several larger cases." The numerical tables and reported long-input values agree with the JSON.

The accepted attribution remains a combined fresh default-POSIX first-token wrapper ceiling: borrowed character access plus elimination of private lexer/StringIO/state and repeated result allocations. It does not isolate Unicode-load cost, demonstrate product scalar replacement, establish behavior outside the declared diagnostic context, or change the production/held-out counts. The bounded experiment converts0 production rows, adds0 held-out native functions and deploys0 product functions. No concrete safety or numerical blocker remains for this diagnostic closure; native Unicode method/result-owner work requires its own capability proof and gates.
