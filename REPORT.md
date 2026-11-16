# Wave17 current result

| Ordinary pipeline | Result |
|---|---|
| Language matrix | 1026 rows:254 native,772 declined,0 wrong/crash |
| Held-out complete functions | 60/375 native;196 captured,60 verified,0 deployed |
| Combined correctness gate | 3430 passed,131 subtests,4 existing expected xfails |

Default coverage is unchanged. Canonical shared borrowed references and ordered local/cell ownership are validated; the function/visitor prototype9419f8ec remains **unaccepted**. Three real source-frame lifetime/code obligations are strict expected failures. Native activation availability currently refuses unproved callables. Every measured family case remains slower than CPython; no deployment was enabled.

The one model review and one family review are complete; concrete post-gate ownership/context/callback corrections have focused passes. Final owned complement48passed/3strict frame expected failures. See [the detailed result](matrix/MANAGED-FUNCTION-FAMILY-RESULT.md), [source-frame design and steering request](matrix/SOURCE-FRAME-ACTIVATION-DESIGN.md), and [fresh first-failure rows](matrix/native-family-first-failures.json). Source/test work is committed in the run clone, with no push.

The following material is retained historical evidence.

# wave16-inplace status report

Current S64 inference source `b3db6900` is accepted and integrated at shared `62224c0f`, merged locally as `4b0c03bf`: combined3,273 passed/131 subtests/four expected xfails/zero skips,47focused and fresh six-helper checks with no whole-function fallback. Unchanged `_Program.__init__`, `merge`, `written_set`, `unify`, `widen_cell` and `canon` execute6compiled entries/59managed calls/0whole-function fallbacks (initializer1/26/0,merge1/13/0,written_set1/4/0,unify1/8/0,widen_cell1/8/0,canon1/0/0). Own prior full3,241passed and ten-minute seed6116=759280native/0wrong/unchecked; one review's scope correction is fixed. Shared original slice owners, active-exception entry decline and import handling are retained. Raw own logs: `inplace/s64-inference-{full,fuzz10m,canonical-focused,actual-helpers}.txt` and `s64-exception-context-fixed.txt`.

Layout source `21e4d57a` is validated: corrected full suite3,283passed/131subtests/four expected xfails/zero skips,45focused (9layout tests), ten-minute seed6416=587752native/0wrong/unchecked, SINGLE independent review50nativecalls/0wrong/fallback. Exact stateful condition-context truth is preserved separately from value-context re-testing. Actual mono/polymorphic layout runs2compiled/20managed/0whole-function-fallback. Named visitor/layout joint integration remains pending. Raw logs: `inplace/s64-layout-corrected-full*.txt`, `s64-layout-corrected-focused.txt`, `s64-layout-fuzz10m-v3.txt`, `s64-review-layout-1.txt` and `s65-layout-actual-helpers.txt`. A separate list/dict-comprehension prototype has7focused passes for unchanged `constant_strings`/`load_plan` and unrelated scope/alias/order tests; it remains outside product source. Public managed entries are experimental, with no automatic deployment or speed claim.

Current S63 self-compilation batch is accepted and integrated as `66eed8b4` in wave18: combined suite3169passed/131subtests/4xfail/2optional skips; concrete corrections85focused passes; all five real helpers pass fresh-process checks with every provider inside the same clone. Corrected structure source `4d748e9b` compiles unchanged `_Cell.__init__` (1compiled/3managed calls/0whole-function fallback), `_find` (3/0/0), and `_Program.widen` (2/9/0), alongside AST `_target_names` and library `_source_digest`. Managed field/iterator protocols still use CPython objects; these counts do not claim Python-free native arithmetic. `heap.lift_structures(fn)` and `heap.lift_region(fn, backend='managed')` are experimental; ordinary automatic profile/run deployment is unchanged. No speed claim. Next inference/layout prototypes remain separate until their own acceptance.

The numerical deployment figures below are historical accepted results.

**Merged accepted wave19 whole-region support as02a02882 and guarded field/array-member primitive as62d80170. Combined full suite:2812passed,131subtests,2expected xfails.**

| Whole process,20 loops | CPython median s | RecomPyler median s | Observed speedup | Recorded PyPy speedup |
|---|---:|---:|---:|---:|
| scimark | 10.4727483 | 1.1875787 | 8.82x | 11.91x |
| spectral_norm | 1.9313585 | 0.6807206 | 2.84x | 3.40x |

Fresh cache/profile, one alternating three-pair cohort, identical stdout and zero selected-function fallback/JIT; all executed selected calls are AOT. Concurrent peer test workloads were recorded and the disturbed samples are retained underS58. scimark executes20each SOR/MonteCarlo/LU and1000each FFT transform/inverse; spectral executes400eval_AtA_times_u calls. Empty benchmark stdout is not an independent numeric correctness certificate; the full union and exact numeric/array regressions provide separate behavioral evidence. [Raw cohort](inplace/s59-merge-programs.txt), [program summaries](inplace/S59-MEMBER-MERGE-RESULT.md), recorded PyPy figures from root pypy-compare/JOINED.md (not rerun).

These program gains come from wave19, including accepted guarded ranges, callable/class values and typed arrays. PerS59, spectral/SOR/LU/MonteCarlo are no longer in-place targets. Field-only member access is still a private JIT primitive: exact ordinary scalar reads and one array-d buffer with raw byte undo, no application classes in compiler metadata, no methods/reference stores/default deployment attribution. Its67focused tests and ten-minute164799-case shared-oracle run pass with zero wrong/unchecked; one independent implementation review found no concrete defect.

Next: consume newly accepted wave17 Unicode/source guards and add saved flat AOT access for remaining boundary targets, first FFT. Fail-first saved-entry tests already show4missing-API failures. The current private flat argument cohort remains historical evidence below, not a spectral target to rebuild: [S56 complete-call result](inplace/S56-FLAT-RESULT.md). Array/member/flat default routing, general record/reference journals and native vectorcall4b remain open.

## Historical default-route comparison

The last complete ten-pair whole-call kernel comparison is checkpoint49, carried forward explicitly under S37.3. These are the recorded depth/control and integrated sources from that cohort, not a new Step2 result:

| Kernel | Depth/control ms | Integrated ms | Change |
|---|---:|---:|---:|
| barnes_hut | 32.50365 | 33.33150 | +2.547% |
| fannkuch | 12.81935 | 12.79390 | -0.199% |
| scimark | 1.38415 | 1.40535 | +1.532% |
| raytrace | 2.83640 | 2.83450 | -0.067% |

Source: [checkpoint49 paired analysis](inplace/step0-final-ten-v1/paired-analysis.json). Barnes +2.5% and FFT +1.5% remain the named Step4 lifetime/allocation guard targets. Fannkuch and raytrace paired changes were unresolved. Default Region direct access remains inactive; the private flat result above is separate. The complete partial-Step4a33-program normal20-loop selection reports2022captured/100verified/2deployed regions and2/33programs deploying, unchanged from2baseline;40savedAOT completions pass independent audits and exact behavior checks. This is current selection evidence, not final direct-access acceptance. See [complete receipt](inplace/s43-selection-full33-v1/complete.json) and [summary](inplace/S43-SELECTION.json).

## Resume verification after S49

The accepted native integer-set capability90567278 is merged as4b777eaf. Its source-sealed union completed2457tests/131subtests with2expected xfails; the unchanged source/test/helper manifests were reverified on resume.

The revised numeric contract requires exact builtin int/float/complex type/value, including float bits, and exempts numeric-box identity only. The original sixteen int/float value cases pass on frozen0ef65037 and merged source, strengthened to require an actual successful CPUDispatcher call on every first/warm call and no fallback. Source/test/helper seals and independent review are in [resume review](inplace/S49-RESUME-REVIEW.md) and [native baseline receipt](inplace/correctness/s49-native-baseline-v2/gate.json).

A new independent-review witness exposed incorrect mixed numeric/dict-or-set identity: `0 is {1:2}` compiled asTrue by comparing the payload to arena handle0. The precise typed correction emits the proven type result after evaluating operands; numeric-vs-numeric identity observations remain declined. Expanded fail-first gate16failed/37passed becomes69focused passes including exact numeric values, BOOL/None/subclass identity, MIXED/special floats, effects/exceptions and chains. Complex controls verify interface type/component bits, with no native-complex claim. Full changed-source union passes2526tests/131subtests with2expected xfails; source/tests/harness seals are unchanged. The five-line correction has independent final review and is accepted as a correctness fix, with no performance claim.

Direct-access preparation is rebased in [S46 resume preparation](inplace/S46-RESUME-PREPARATION.md). Its new ordinary local-class witnesses distinguish persistent cache retention after successful compilation from a reached `__class__` closure's initial eligibility refusal. One separate actual-executable lifetime control passes for a simple reader, without certifying every native owner graph. None of these results is a direct-call, journal or performance gain. S46's fresh ten-region pass and its one required disturbed repeat both complete,160successful observed calls. The descriptive component ranges and every named other phase are in [S46 bound](inplace/S46-TEN-BOUND.md); observer overhead, dispatcher/boxing and peer correctness disturbance remain explicit.

## Recovery and accepted steps

- Protective WIP commit `066589e4` preserves the entire prior uncommitted tree. The interrupted checkpoint60 union is excluded and its directory is not reused.
- Accepted Step0 commit `fd154095`: fresh union 1257 tests/131 subtests, one three-pair native-shape remeasure. Barnes differences -2.1540/-0.0084/-1.6204 ms consistently recover over half the earlier regression, so native shapes stay by S37.2. FFT differences +0.0341/+0.0126/+0.0008 ms remain adverse. No further guard variant or remeasure.
- Step0 startup evidence remains checkpoint43: integrated/coverage 0.97480 chaos and 0.95574 Richards, 20 AOT calls each, no regeneration, as S37 directs.
- Step1 commit `8128c4da`: complete per-region bound, named other components, warm/cold separation, observer-on/off exact behavior, and dominance checks. See [the full component tables](inplace/bounds/STEP1-BOUND.md). Trivial complete call 7.673212 us versus Python 0.055112 us.

## Component status

| Component / scope | Before | After Steps2?4 | Status |
|---|---:|---:|---|
| Barnes warm load | 93.62625 us/call | not measured | live direct access inactive |
| Barnes warm writeback | 32.09075 us/call | not measured | journal inactive |
| raytrace warm load | 117.375 us/call | not measured | live direct access inactive |
| raytrace warm writeback | 439.575 us/call | not measured | journal inactive |
| transform_point first lookup | 3504 us (later 3.6?4.2) | not measured | preparation target |
| create_gc_cycles result conversion | 9040.75 us/instrumented attempt | not measured | new-output allocation/observation target |
| Trivial complete compiled call | 7.673212 us | not measured | target below Python 0.055112 us |

The held-out largest comparable buckets are create_gc_cycles result 9040.75 us, Task.qpkt lookup 2701.8125 us and DeviceTask.fn lookup 1033.85 us. Input direct access does not remove creation of a new output graph. Cold raytrace lookup and FFT observer bookkeeping are not removable production-cost estimates. Before values come from their explicitly separate frozen contexts; they cannot be added to independently timed complete calls.

## S41 fixed-cost progress (checkpoints69?74)

The earlier fixed-cost snapshot has one complete three-pair development comparison, with exact results/types, zero fallback, real compiled dispatchers and a separate untimed three-entry dispatch audit in each child. Source/helper manifests and all child-receipt hashes remain unchanged. This snapshot predates retained alternating-variant lookup and is not final acceptance.

| Complete warmed call | Before us | Initial rules us | Change | Python us (after) |
|---|---:|---:|---:|---:|
| One field read/comparison | 7.059526 | 5.806244 | -17.8% | 0.029102 |
| Scalar arithmetic | 4.710888 | 1.964356 | -58.3% | 0.024444 |

Evidence: [development receipt](inplace/logs/s41-fixed-development-v1.receipt.json), [raw pairs/source manifests](inplace/s41-fixed-development-v1/complete.json). Both miss the well-under1us target and remain much slower than Python. No kernel recovery or new deployment count is claimed.

Rules remove graph loading for primitive-only acyclic checked graphs, frame scans for acyclic graphs, unloader/writeback for proven readonly primitive results, and RNG export when no generated operation uses it. Missing proof stays conservative in authenticated prepared restoration. The reviewed retained-variant rule reuses already retained Programs with fresh load and live guards, current dictionary membership, bounded weak references, and ordinary resolver behavior for overrides or misses. It does not remove first-ever preparation or output-graph reconstruction.

The initial full union passes1329tests/131subtests. Retained-variant focused compatibility passes152tests; identity/checked-overflow controls pass12tests. The final exact-source union passes1342tests/131subtests; its fresh four-kernel build completes in165.469s with source/artifact manifests pinned. Independent review and fail-first evidence: [review](inplace/S41-REVIEW.md), [design](inplace/S41-FIXED-COSTS.md). Invalid/incomplete directories are excluded and never reused.

S41.6 is answered: the unchanged monitor assertion passes alone three times on accepted Step0 and three times on current source. Under the steering rule, the earlier failure is pre-existing timing sensitivity; no assertion/threshold changed. The final current-source union passes1342tests/131subtests; source/tests/harness manifests remain unchanged. Final whole-Step4 trivial/six-region/four-kernel/33-program acceptance remains pending.

## S43 native-entry direction and partial Step4a

S43 requests one remaining scalar/field component pass and a genuine C vectorcall entry if the floor is Python wrapper work. [The one pass](inplace/S43-BOUND.md) finds ordinary scalar2.295726us and field6.087000us in its own diagnostic context; scalar attempt1.957836us, helper1.709802us, dispatcher-call envelope0.378582us and guards-only0.128622us are separate descriptive envelopes. All128 observed calls in each case reconcile exact native status0/JIT/outer completions. Scope overhead is retained and cannot be added/subtracted from ordinary latency.

The native public callable, raw JIT/AOT entry and independent C completion audit require more than about3hours of implementation. S43.5 therefore directs a commit of the reviewed current fixed-cost rules as **partial Step4a**, followed by unchanged33-program deployment selection before building **Step4b native entry**. This accepts the bounded current mechanisms; it does not accept the whole Step4 or waive its sub1us/kernel/deployment criteria. Field input conversion is explicitly Step2 underS43.4. Accepted partial Step4a commit is0ef65037. Both smoke rows complete, and the full33cohort finishes with2programs/2regions deploying: chaos and richards_super,20AOT each. S46 therefore reorders Steps2/3 beforeStep4b: even subtracting5us from all98verified-but-not-deployed complete calls predicts no extra region faster than Python. This subtraction is a model, not a measured direct-access gain; the ten named larger object-graph regions must receive a component bound and complete-call acceptance.

## Step2 foundation, still open

The implementation now includes primitive effect summaries, recursive union fixed points, canonical aliases, conservative topology invalidation, backward numeric identity demand, and a conservative bridge from real compiler types. A shared no-NRT LLVM adapter actually invokes native code through owned test buffers, returns checked/static error statuses before Python boxing, preserves F/I aliasing, retains linked environments, and rejects unaudited intrinsics/dynamic globals. Global constructor escape facts are weak on class and init dependencies.

One independent review supplied fail-first topology, identity-cycle, constructor, primitive-ownership and environment counterexamples. Final focused result: 169 passed, including existing R7/R8/escape controls and the unchanged monitor file. The full union attempt is excluded: 1304 passed/131 subtests passed, one existing monitor timing-ratio assertion failed (library 0.001462103 s versus required 5*self 0.002405220 s). Its later focused pass does not replace a passing full union, and the full attempt predates the final metadata validation. No full-suite pass on the final foundation is claimed. This does not establish a live object certificate. See [review and limits](inplace/step2-foundation-review.md).

Still required: typed checked-op/source/CFG identity binding through R8 and calls; complete weak persistent descriptors; installed-header fresh C walk and strong-pin lifecycle; direct load lowering; token-aware original box materialization; actual native/cleanup accounting; saved-AOT capsules and no-Numba restoration. No direct counters, reach, half-bound achievement or performance gain are claimed. Step3 cannot publish speculative stores without that callback-free native interval and token-aware journal. Step4 has reviewed fixed-cost rules and a measured initial gain, with acceptance still pending as described above.

At checkpoints67?68 the run requests costed scope/order steering under S37.4 rather than extending a no-gain subproblem indefinitely. [The request](inplace/STEP2-STEERING-REQUEST.md) names measured test cost and remaining implementation. Union verification and preservation continue independently while direction is pending. A final report must replace these pending fields and add DONE only when the authorized closure is actually reached.

## Remaining steps and named soundness work

Step3 is open, not rejected. The typed undo journal needs slot identity and alias-canonical first-store records; original references must survive until commit, restoration must run before Python error/replay, and unrelated pins must be released before observable allocation. Overflow, bounds, exception, allocation and recursion exits must exercise real partial stores. Without the Step2 C interval and identity/token lowering, a Python finally block would allow observers to see speculative state and cannot implement this contract. No such substitute was installed.

Step4 source inspection finds that `_Gen.call` reads `top[2]` only on checked recursive edges, while `Region.attempt` scans every Python frame on every call. A complete acyclic graph can therefore justify removing that scan; its source proof and regression cases still need implementation/review/timing under the chosen order. Other controls must follow actual emitted uses, not a blanket zeroing-removal assumption. The prepared runtime cache is already accepted startup work and does not prove that per-context Task.qpkt preparation has disappeared.

For create_gc_cycles, native output allocation needs source-ordered observation/safepoints and an exact continuation after visible progress. Bulk graph reconstruction at the end changes allocation/GC observation and cannot be relabelled direct output. The detailed route and counterexamples are in `inplace/task2-preparation/future-step4.md`; no source-ordered allocation or continuation engine has been built. The 9 ms result bucket remains an explicit target, not an achieved saving.

## S46 continuation and open counterexamples

The required90567278 integration and union are complete. The complete ten-region diagnostic is S46-TEN-BOUND.md; the subsequent S55 cost table supersedes any conversion-only implementation projection. Step2/3 acceptance adds allten complete-call times and one33-program selection against2regions/2programs; final ten-pair four-kernel recovery remains.

[Reviewed native-entry preparation](inplace/S43-NATIVE-ENTRY-PLAN.md) is parked for afterSteps2/3. The fail-first identity file exposes12failures/3passes on4a, including returned numeric input/constant boxes and a mixed-origin branch; callable controls expose2expected missing-entry failures/12passes including raw adapter controls. They are preserved in inplace/step4b-preparation with the locked red receipts, excluded from passing-suite claims, and remain open correctness obligations for identity/token handling and final acceptance. No native C-entry product code has been written.

## Completed S46 capability integration

Accepted90567278 and ancestry are merged as4b777eaf after the2457-test/131-subtest union and independent review. Its effective runtime changes are lift.py/profiler.py and set regressions; no direct path activated. The later reviewed identity correction939570e4 passes2526tests. The current provenance integration passes2577tests/131subtests with2expected xfails on frozen source/tests/harness and an11-file immutable corpus; all seals independently verify.


## Completed shared provenance integration

Accepted shared source analysis0b8ffc2d is integrated for Steps2/3 consumption. The module supplies conservative original-source owner/escape facts and returns unknown where proof is absent; it activates no direct path. Its51focused tests and122corpus queries (17proved/105refused in peer acceptance) are verified separately from product execution. Current integration union:2577passed,131subtests,2expected xfails; source/tests/harness and the selected11-file corpus all retain their frozen hashes. Physical cell roots, layout validity, observer-safe journals and R8 transfer certificates remain consumer work. See inplace/S46-RESUME-PREPARATION.md.


## S55 design budget and unresolved work

The [per-region budget](inplace/S55-ENTRY-BUDGET.md) estimates the conversion-only design after granting zero load/write-back and excluding observer bookkeeping while retaining every other observed component. None of ten estimates is below its prior Python time: Task.qpkt127.63?162.19us against59.54us, HandlerTask.fn122.37?129.19us against12.81us. These are conservative provisional estimates with retained timers, not measured savings or a lower-bound proof. No cost is invented for the unbuilt C runtime.

The [revised direct design](inplace/S46-DIRECT-DESIGN.md) specifies demand-based first-touch guards, shallow variant selection and returned-owner mapping instead of full reachable-graph entry work. Existing Task.qpkt/Task.runTask samples try1to4loads/guards; the single-attempt DeviceTask.fn still has9us of lookup, so repeated variants do not explain all of other. S55.3 requires a steering request with this table before product edits; the request asks to bound the demand-based entry/result-owner prototype and revise projections before activation. Step4b alone cannot remove the remaining large controls.

Shared provenance consumption exposes a concrete prerequisite: eight original method bodies fail source binding on the accepted layer. The actual Task.qpkt comparison differs only in CPython3.14 CO_METHOD; six executed positive method queries fail and a central-owner request is in root REQUESTS.md. Current corpus collectors do not execute class-method metadata automatically, so the separate red tests are the executed evidence. This does not invalidate conservative layer refusal or authorize a private solver.

S53 adds exact array.array d member buffer export/pin/release and scimark SOR20-loop acceptance after object-field work. Reused installed-Numba borrowing passes; seven product prerequisites remain red and the Python resize-callback control passes. No product buffer or native-rollback success is claimed. S54's future interpreter calls require commit/release before callbacks and fresh first-touch validation after; effectful post-call misses need continuation deopt, never replay of committed effects.

Direct execution, journal/rollback, buffer runtime/SOR acceptance, Step4b, ten-region retiming, the next33-program selection and final ten-pair kernel acceptance all remain open. No new deployment or kernel speedup is reported.


## Merged range report history

# wave18-lift range values under S49

The guarded range coverage slice is accepted after fail-first tests, independent review, exact CPython comparisons, fresh prepared-AOT reload, full matrix/held-out/union and the repeated four-kernel control. Commit identity is recorded in the root ledger; the range source seal remains the measurement identity. S49 exempts only exact int/float/complex identity; exact types and values remain required. Singleton and all other object identity remain binding, and numeric identity observers stay Python.

The flat signed-int64 range representation supports assignment, reuse, exact-range arguments, direct internal parameters/results, iteration, len, int/bool indexing and int/bool membership. Bounds/count overflow, zero/INT_MIN step, unrepresentable domains, unsupported queries and every public range escape fall back to Python. Newly enabled regions conservatively refuse nonnumeric object-containing shapes pending the shared provenance consumer. No backend changes or general load/write-back changes were made.

Frozen-source evidence: [design](lift-evidence/S49-RANGE-DESIGN.md), [independent final review](lift-evidence/review-range-final.md), [source seal](lift-evidence/range-s49-source-seal-v1.json). Focused/prepared-AOT gate: **109 passed**. Project union: **2576 passed, 2 xfailed, 131 subtests**. Full matrix: **251 native / 775 declined / 0 wrong / 0 crash**, up eight held-out-form rows; all original1016 verdicts are unchanged. Raw matrix and complete receipt are [retained](lift-evidence/range-s49-matrix-v1.complete.json). Bare-pytest union-v1 was excluded after duplicate fixture collection; union-v2 uses the established `pytest -q tests` scope. Incomplete attempts are never acceptance evidence.

Whole functions: captured194, verified60, fully native**60/375 (16%)**, native with fallback**0/375 (0 sites)**, collector-deployed0 because no selection ran. Historical59 becomes60 through `richards_super.fn` line284; the frozen pre-range merged source also verifies this function, so **range caused zero whole-function gain**. Fresh and attribution receipts: [held-out](lift-evidence/range-s49-heldout-v1/complete.json), [pre-range Richards](lift-evidence/range-s49-richards-original-v1/complete.json). Of25functions first stopped by range,0became native:14now stop on C/library calls,3tuple(range),2list(range),2range slices,2generator for-else,1aggregate/global range and1range/list join. No fallback-time share or deployment gain is claimed.

Kernel candidate/base median ratios on the repeated three-pair cohort are Barnes1.02773,fannkuch0.99005,scimark1.00540,raytrace1.01641. Both cohorts recorded test activity and show no detected material regression; differences below about6% remain unresolved. One repeat was completed underS47, with both receipts retained. There is no clean-timing or range speed claim. [Repeated control](matrix/range-s49-kernel-control-v2/complete.json).

S50 unmodified selection, three alternating fresh-process pairs, whole-process wall including startup, specified20-loop shim: scimark Python7.454360s / RecomPyler4.408065s (1.6911x), spectral_norm1.593662s /1.369898s (1.1633x). Test activity was recorded during the cohort. These are observed contextual ratios, not a range-attributed improvement or a PyPy rerun. scimark executes2000AOT calls and spectral_norm104000AOT calls per process, with0JIT/0fallback; both deploy2functions. Source/shim/plan/artifact hashes, exact stdout-byte comparison and command receipts are in [S50 completion](lift-evidence/range-s49-s50-long-v1/complete.json) and [timing limits](lift-evidence/range-s49-s50-long-v1/timing.complete.json). The benchmarks' empty stdout is not an independent numerical correctness certificate; the separate exact correctness gates supply semantics evidence.

## Current ten largest first-failure groups

| Current reason family | Functions | Programs |
|---|---:|---:|
| as a region: a '<name>' object with attributes its __init__ does not set | 26 | 8 |
| as a region: a call of '<name>' at line N of '<name>' | 21 | 11 |
| as a region: '<name>' is not a plain method at line N of '<name>' | 18 | 2 |
| as a region: '<name>' declares globals or defines functions inside itself | 7 | 5 |
| as a region: '<name>' uses the new object before setting all its attributes | 6 | 3 |
| as a region: a call of '<name>' that relies on a default that is _ZeroSentinel at line N of '<name>' | 6 | 2 |
| as a region: '<name>' takes **kwargs | 5 | 3 |
| as a region: name '<name>' used as a value at line N of '<name>' | 4 | 4 |
| as a region: a list holds both ints and floats, or floats and None | 3 | 1 |
| as a region: tuple() on range at line N of '<name>' | 3 | 2 |

These are observed first failures, not completion predictions. S51 requires the all-blockers census before another capability; S54 then requests opaque managed references and safe interpreter fallback at individual constructs. Shared accepted provenance0b8ffc2d merges at the next range boundary. Its current source does not expose a product managed-call representation; precise lifetime/callback/replay interface requests are appended in root `provenance-cases/REQUESTS.md`. No private provenance or second managed representation is being built.

The unaccepted local prototype remains preserved in `lift-evidence/parked-local-functions`; its old matrix and identity-certificate evidence is superseded. S49 numeric-only corpus cases are marked exempt, while every nonnumeric ownership counterexample remains binding. The prepared scalar-local design and red tests are preparation only; S51/S54 replace their fixed priority. This report is not DONE.

## Every original in-scope row at this handoff

All 102 original rows retain their initial verdicts (8 previously native, 94 declined); no superseded prototype conversion is counted. The following baseline table preserves each exact reason. The ten additional range witnesses are listed separately above.

| Row | Blocker | Baseline verdict | Reason |
|---|---|---|---|
| statement.assert_error | exception paths and numeric kind changes | declined | Assert at line 2; runtime guard at ('construct', 10) |
| statement.raise | exception paths and numeric kind changes | declined | runtime guard at ('construct', 10) |
| statement.nonlocal | local functions and closures | declined | as a region: 'construct' declares globals or defines functions inside itself |
| statement.del_item | list operations and aliasing | declined | as a region: del of an item of list[int] at line 3 of 'construct' |
| statement.function_def | local functions and closures | declined | as a region: 'construct' declares globals or defines functions inside itself |
| statement.annotated_assign | local annotation statements | declined | as a region: AnnAssign at line 2 of 'construct' |
| statement.annotation_only | local annotation statements | declined | as a region: AnnAssign at line 2 of 'construct' |
| statement.lambda | local functions and closures | declined | as a region: 'construct' declares globals or defines functions inside itself |
| pattern.value | match statement recognition | declined | as a region: Match at line 2 of 'construct' |
| pattern.singleton | match statement recognition | declined | as a region: Match at line 2 of 'construct' |
| pattern.or | match statement recognition | declined | as a region: Match at line 2 of 'construct' |
| pattern.wildcard | match statement recognition | declined | as a region: Match at line 2 of 'construct' |
| pattern.guard | match statement recognition | declined | as a region: Match at line 2 of 'construct' |
| operator.int.compare6 | identity provenance | declined | as a region: this comparison at line 2 of 'construct' |
| operator.int.compare7 | identity provenance | declined | as a region: this comparison at line 2 of 'construct' |
| operator.int.and | selected-value provenance | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' |
| operator.int.or | selected-value provenance | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' |
| operator.float.compare6 | identity provenance | declined | as a region: this comparison at line 2 of 'construct' |
| operator.float.compare7 | identity provenance | declined | as a region: this comparison at line 2 of 'construct' |
| operator.float.and | selected-value provenance | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' |
| operator.float.or | selected-value provenance | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' |
| operator.bool.binary3 | exception paths and numeric kind changes | declined | runtime guard at ('construct', 3) |
| operator.bool.augmented3 | exception paths and numeric kind changes | declined | one value can be bool or float |
| operator.bool.compare6 | identity provenance | declined | as a region: this comparison at line 2 of 'construct' |
| operator.bool.compare7 | identity provenance | declined | as a region: this comparison at line 2 of 'construct' |
| operator.complex.binary0 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.augmented0 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.binary1 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.augmented1 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.binary2 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.augmented2 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.binary3 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.augmented3 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.binary6 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.augmented6 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.compare0 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.compare1 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.compare6 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.compare7 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.unary0 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.unary1 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.unary3 | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.chain | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.and | complex scalar representation | declined | as a region: an argument of type complex |
| operator.complex.or | complex scalar representation | declined | as a region: an argument of type complex |
| operator.list.binary0 | list operations and aliasing | declined | as a region: arithmetic on list[int] at line 2 of 'construct' |
| operator.list.augmented0 | list operations and aliasing | declined | as a region: arithmetic on list[int] at line 2 of 'construct' |
| operator.list.compare0 | list operations and aliasing | declined | as a region: comparing lists at line 2 of 'construct' |
| operator.list.compare1 | list operations and aliasing | declined | as a region: comparing lists at line 2 of 'construct' |
| operator.list.compare2 | list operations and aliasing | declined | as a region: arithmetic on list[int] at line 2 of 'construct' |
| operator.list.compare3 | list operations and aliasing | declined | as a region: arithmetic on list[int] at line 2 of 'construct' |
| operator.list.compare4 | list operations and aliasing | declined | as a region: arithmetic on list[int] at line 2 of 'construct' |
| operator.list.compare5 | list operations and aliasing | declined | as a region: arithmetic on list[int] at line 2 of 'construct' |
| operator.list.chain | list operations and aliasing | declined | as a region: comparing lists at line 2 of 'construct' |
| operator.list.and | selected-value provenance | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' |
| operator.list.or | selected-value provenance | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' |
| operator.tuple.compare6 | identity provenance | declined | as a region: this comparison at line 2 of 'construct' |
| operator.tuple.compare7 | identity provenance | declined | as a region: this comparison at line 2 of 'construct' |
| operator.tuple.chain | tuple operations | native |  |
| operator.set.binary1 | set result ownership | declined | as a region: operator Sub on set[int] and set[int] at line 2 of 'construct' |
| operator.set.augmented1 | set result ownership | declined | as a region: operator Sub on set[int] and set[int] at line 2 of 'construct' |
| operator.set.binary9 | set result ownership | declined | as a region: operator BitAnd on set[int] and set[int] at line 2 of 'construct' |
| operator.set.augmented9 | set result ownership | declined | as a region: operator BitAnd on set[int] and set[int] at line 2 of 'construct' |
| operator.set.binary10 | set result ownership | declined | as a region: operator BitOr on set[int] and set[int] at line 2 of 'construct' |
| operator.set.augmented10 | set result ownership | declined | as a region: operator BitOr on set[int] and set[int] at line 2 of 'construct' |
| operator.set.binary11 | set result ownership | declined | as a region: operator BitXor on set[int] and set[int] at line 2 of 'construct' |
| operator.set.augmented11 | set result ownership | declined | as a region: operator BitXor on set[int] and set[int] at line 2 of 'construct' |
| operator.set.compare0 | set result ownership | native |  |
| operator.set.compare1 | set result ownership | native |  |
| operator.set.compare2 | set result ownership | native |  |
| operator.set.compare3 | set result ownership | native |  |
| operator.set.compare4 | set result ownership | native |  |
| operator.set.compare5 | set result ownership | native |  |
| operator.set.chain | set result ownership | native |  |
| operator.set.and | selected-value provenance | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' |
| operator.set.or | selected-value provenance | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' |
| literal.int64 | integer power | declined | as a region: a power other than ** 2 at line 2 of 'construct' |
| literal.complex | complex scalar representation | declined | as a region: constant 3j at line 2 of 'construct' |
| literal.list_star | list operations and aliasing | declined | as a region: Starred at line 2 of 'construct' |
| literal.tuple_star | tuple operations | declined | as a region: Starred at line 2 of 'construct' |
| literal.set_star | set result ownership | declined | as a region: Starred at line 2 of 'construct' |
| call.varargs | variadic binding and tuple reduction | declined | 'construct' has a closure, keyword-only arguments, *args or is a generator; sum() on (int, int, int) at line 2 of 'construct' |
| call.closure | local functions and closures | declined | as a region: 'construct' declares globals or defines functions inside itself |
| builtin.bool | builtin.bool | declined | as a region: bool() on int at line 2 of 'construct' |
| builtin.complex | complex scalar representation | declined | as a region: complex() on int, int at line 2 of 'construct' |
| builtin.divmod | builtin.divmod | declined | as a region: divmod() on int, int at line 2 of 'construct' |
| builtin.filter | iterator builtin recognition | declined | as a region: filter() on None, list[int] at line 2 of 'construct' |
| builtin.hash | builtin.hash | declined | as a region: hash() on (int, int) at line 2 of 'construct' |
| builtin.isinstance | builtin.isinstance | declined | as a region: isinstance() with something other than one class at line 2 of 'construct' |
| builtin.iter | iterator builtin recognition | declined | as a region: iter() on list[int] at line 2 of 'construct' |
| builtin.map | callable values | declined | as a region: name 'abs' used as a value at line 2 of 'construct' |
| builtin.next | iterator builtin recognition | declined | as a region: iter() on list[int] at line 2 of 'construct' |
| builtin.pow | integer power | declined | as a region: pow() on int, int at line 2 of 'construct' |
| builtin.round | builtin.round | declined | as a region: round() on float, int at line 2 of 'construct' |
| builtin.sorted | builtin.sorted | declined | as a region: sorted() on list[int] at line 2 of 'construct' |
| builtin.zip | iterator builtin recognition | declined | as a region: zip() on list[int], list[int] at line 2 of 'construct' |
| stdlib.math.frexp | stdlib.math.frexp | declined | as a region: math.frexp at line 2 of 'construct' |
| stdlib.math.gcd | stdlib.math.gcd | declined | as a region: math.gcd at line 2 of 'construct' |
| statement.bare_except | exception paths and numeric kind changes | declined | as a region: a check at construct line 4 sent it back to Python |
| boundary.divide_zero | exception paths and numeric kind changes | declined | runtime guard at ('construct', 3) |
| review.mixed1.gt | mixed numeric exact comparison | declined | as a region: a check at construct line 3 sent it back to Python |
| review.mixed1.le | mixed numeric exact comparison | declined | as a region: a check at construct line 3 sent it back to Python |

---

# Preserved wave17 and trunk reports

| Matrix population | Native | Declined | Wrong | Crash |
|---|---:|---:|---:|---:|
| Original 1,000, base 7e3b688 | 221 | 655 | 4 | 120 |
| Same original 1,000, accepted b724f6d | 232 | 768 | 0 | 0 |
| Original 1,000 after native sets | 240 | 760 | 0 | 0 |
| Expanded current 1,016 | 243 | 773 | 0 | 0 |

This progress report records completed Steps 1-2 and the independently reviewed S33-S35 backend/reuse experiments. **Step 3 is in progress on the user-authorized Extend Numba route (S38). The native non-escaping set capability is accepted; Step 3 remains in progress. The run is not marked DONE.** Every matrix verdict is from actual construct execution through capture/verify/compile/replay, with native counters; the prototype reach estimate is kept separate.

## Step 3: accepted non-escaping native sets

Exact signed-int64 sets now work as private native values for pure algebra/comparisons, length/truth, recognized pure methods and local mutation. Inputs are copied; a positive typed-use certificate rejects Set-bearing returns (including Optional, records and nested containers), stores, unknown calls, traversal, pop and reflected input mutation. Selected owner identity and CPython table history are preserved by Python for escaping sets. No0..7 domain, CPython table-version guard or256-subset product test remains. Managed owners are the designed escaping representation after S38.4 parity.

The final matrix is243 native/773 declined/0 wrong/0 crash:seven set-comparison rows and one integer-tuple chain converted; no native loss. The remaining37 plain-Numba differences stay guarded/declined. Final focused/AOT tests:42 passed,2 strict expected-fails for future managed escaping/mutable ownership. Real ordinary capture/verification and AOT build/reload pass, including a fresh process without Numba. Union:2,064 tests and131 subtests passed,2 expected-fails. Independent review findings include actual order, Optional identity and future-mutation wrongs; all are retained as passing regressions and their raw red receipts remain. Final acceptance sources/hashes/receipts are in matrix/native-set-acceptance.json and review-native-sets.md.

The35-program before/after cohort completed with capture-monitor on/off behavior identical. Captured194, verified59 and observed native whole functions59 are unchanged;59/375=15.73% of all own definitions.365 definitions are in non-network program sources, while10 excluded network definitions remain in the fixed375 denominator. New whole functions native:0. No runner deployment was performed;deployed0 here describes collector activity, not unmodified selection. Largest native contributor is richards_super22; leave it out:37/336=11.01%. All per-program counts and next captured first failures are in matrix/SET-REACH.md and sets-heldout-v1/summary.json. Two pre-existing richards candidate rejections remain rejected in both sources; they are excluded from native coverage, not hidden as successes.

There is no speed claim for this correctness capability. Remaining set methods return escaping sets in their fixtures and await the managed owner; unsupported ordered-source update/reducers remain recognizer work. Next is the accepted fd154095 trunk merge under S39, then the largest remaining methods group under S40, with the character-loop ceiling before string scans. Load, write-back, start-up and prepared-cache code were not edited by this capability.

## S39 accepted trunk integration

Only the accepted wave16 commit fd15409571be940d966ccd1ca7dd48aa7227ba30 and its history were fetched read-only. Product changes merged automatically; the add/add report conflict retains this wave17 report. Step2 fixes and the accepted private-set rule remain. No uncommitted or later wave16 source was read into the merge.

The post-merge matrix preserves every one of the1,016 per-ID verdicts:243 native/773 declined/0 wrong/0 crash. The combined union passes2,372 tests and131 subtests, with the same2 managed-set expected failures; logs/merge-fd154095-union-v1.receipt.json records exit0. Accepted merged C helpers were rebuilt in a fresh directory with their version probes. Complete source snapshots, fresh four-kernel artifacts and the single three-pair exact-output/native-count control pass. No JIT, fallback, missing or batch activity occurs. Pre/post median ms are Barnes33.9272/34.9997, fannkuch14.0028/12.7729, FFT1.4312/1.4912 and raytrace3.0875/2.8724; these short noisy controls make no speed or neutrality claim. Evidence: matrix/merge-fd154095-kernel-check/summary.json and companion process/count receipts; all six locked S39 receipts exit0, and live product hashes equal the frozen post-merge snapshot.

## What was built and accepted

The isolated clone is based on wave16-inplace 7e3b688c00111a9f4bb7378718aabc4e210d9c72, branch codex/wave17-matrix. Accepted commits are b3aa9cd (executed inventory/pinned matrix gate) and b724f6d (Step 2 soundness/native-compatibility fixes). No other wave clone was edited; product changes touch only lift.py and profiler.py. Load/write-back/start-up paths, profitability policy, permissions and system settings were not changed. No push/global install/network tests were performed.

The installed CPython 3.14.4 inventory covers all requested concrete AST families and keyword/soft-keyword tokens, all public builtin callables/types, all public methods of the ten requested kinds, operator kinds/call forms/effects/exception/async/generator fixtures, and retained hot stdlib entry points. matrix/MATRIX.md and matrix/matrix.json contain per-group and per-row results, reasons, sources, inputs, reference/compiled observations and evidence provenance. Verdicts are input-specific. Native means an observed native entry and identical tested behavior; it does not mean ordinary deployment.

Step 2 binds generated module/record cache keys to stable semantic helper recipes; emits named declines at unsupported typed operations; preserves singleton-only selected Boolean values while compiling truth-only numeric conditions; checks list bounds; represents constant None batch columns; protects mixed int/float precision and shared-NaN tuple comparisons; and retains native chained-comparison evaluation order without introduced walrus inference failures. Five original native rows now decline conservatively (int/float selected and/or and tuple chains). Fifteen prior crashing rows and one prior wrong row become native; the remaining unsafe domains decline.

The four original wrong rows are reported precisely in matrix/STEP2-REACHABILITY.md. Tuple and/or passed existing value verification but lost selected-object identity through direct public lift execution; the tiny fixtures failed profitability and no ordinarily deployed wrong region was observed. Reverse/sort reused a warmed pop binding and were rejected by verification before deployment; direct native replay still demonstrated their wrong results. All four are sound in the current executed matrix.

Independent review: matrix/review-initial.md, review-step2.md, review-step2-final.md and review-step2-third.md. Fail-first and intermediate failures remain raw evidence rather than being erased. The accepted full union passed **2,022 tests and 131 subtests**; matrix/logs/step2-union-v4.* retains output/receipt/audit. The pinned matrix test remains in tests/test_language_matrix.py.

The exact-source four-kernel check used three alternating pairs, fresh saved/AOT processes and five iterations per process; outputs match the reference bit-for-bit, native/AOT counters match the expected multiplicity, and no JIT/fallback/not-found/batch activity occurs. Median base/candidate ms: Barnes 33.796/34.652; fannkuch 14.584/14.189; FFT 1.480/1.430; raytrace 3.147/3.315. The short cohort is a correctness/control check; no speed gain or statistically resolved neutrality is claimed. Raw noisy raytrace samples remain visible. Evidence: matrix/step2-kernel-check/summary.json and companion files.

## Direct-call and reuse question: actual result

**Extending Numba works:** a custom typed NRT-owned PyObject model with CPython-API intrinsics compiles through nopython and the unchanged vendored AOT builder. Its fresh AOT extension runs without importing Numba. Unchanged types.pyobject remains unsupported, while generic forceobj works JIT-only here. This supersedes the broad initial S33 feasibility conclusion; it does not implement an automatic product backend.

All figures below are complete-call microsecond medians from the same three alternating pairs under audited TIMING.lock (`s35-combined-pairs-v2`). All compiler/error-rendering setup precedes C guard capture. Explicit route counters prove zero Python fallback in nominal timed C calls.

| Complete function | CPython us | Object-mode direct entry us | Handwritten C us | Managed-object AOT us |
|---|---:|---:|---:|---:|
| chaos.GVector.__str__ |0.228190|0.242605|0.223495|0.371820|
| json_loads.mutate_dict |18.936600|27.542600|13.063400|not prototyped|
| mdp.applyHPChange |0.514405|0.751975|0.207320|not prototyped|

The string C difference is unresolved (about2%); dict/HP diagnostics show1.45x/2.48x ceilings for guarded exact domains. All14 C behavior cases pass with identity, mutation/Random state,10000 success/error-refcount calls, weakrefs/finalizers, six extra guard/unwind witnesses and16 GC invalidation probe pairs. Counterexamples and superseded cohorts remain raw evidence. The extension model passes the same four string cases, output ownership, success/error refs, child and reverse-operand finalizers in both JIT and AOT; its tiny string call is slower than CPython. See matrix/direct_calls/COMBINED-BOUND.md for specializations, exact guards, limits, raw timing/route counters and sized choices. Scope remains diagnostic, not universal arbitrary-object semantics.

Plain installed numba.njit executed all781 current declined rows with unchanged source/fixture arguments: **170 compile and match,37 compile but differ,574 do not compile,zero unresolved oracle errors**. The original655 subset is153/23/479 by ID. Largest matching groups:55 methods,34 comparisons,14 builtins,12 boolean,11 operators,11 augmented,9 statements. All row IDs and product blockers are in matrix/PLAIN-NUMBA.md. Existing Numba support is therefore substantial; strict identity, bigint, mixed precision, public result types and error behavior still need guarded product integration. Five typed-dict returns are differences despite equal contents; dedicated scalar identity rows differ. This is fixture coverage, not a claim of complete construct support.

These prototypes make **zero production matrix rows newly native**. Earlier548/655 object-route reach is still an explicit overlapping syntactic estimate, never measured new coverage. The153/655 direct-njit matches are measured and are not added to548. Current product whole functions remain0/3 native in this diagnostic selection. The375 held-out source-definition denominator below has no inferred native share.

Recommended next choice is to reuse native Numba support plus managed-object intrinsics (estimated800-1500 shared adapter/guard/ownership lines, then300-800 for a first primitive slice). A whole-function C emitter remains a1500-3000-line alternative; native-kinds-only first is600-1200 lines. These are sized designs, not accepted implementation. The user chose Extend Numba on 2026-11-14; S38 authorizes implementation. Per S34.3, borrowed string/bytes ceilings can proceed independently while that decision is pending.

Installed Numba0.68.1 still marks pycc pending deprecation; the vendored builder replaces its wrapper/build layer and retains Numba compiler/runtime dependencies. PIXIE has a0.0.1.dev0 development release, incompatible LLVM dependencies and documented Linux/macOS targets; it is not a Windows drop-in replacement here. Primary-source evidence and exact scope are in matrix/extension/AOT-STATUS.md.

## Remaining work, with time and ordinary-source weights

matrix/STATIC-FREQUENCY.md and static-frequency.json give top-40 matrix rows and grouped features, own/stdlib counts, exact source/matrix hashes, all 1,016 mappings, zero skipped files and the source manifest. There are 375 function definitions in 40 available held-out-owned files and 340 total own/possible-imported-stdlib files. Shim code is excluded. Receiver types, computed boundary predicates, binding/shadowing and dynamic imports are not inferred; overlapping syntactic counts are not additive or runtime support proofs. A future capability must execute/join whole-function before/after native counts to this denominator, with unexercised definitions explicit. The first Step3 before/after measurement is now in SET-REACH.md; the static mappings remain historical syntactic evidence.

Historical wave14 capture/verification/deployment are not current wave17 results: at two iterations final other37 has 2,483 captured / 177 verified / 0 native reached, with pprint 47 / 2 / 0 separately; at twenty iterations two of 33 programs actually reached native regions. The current non-network owned-function cohort is separate from those historical figures and is reported above. Subsequent capabilities must retain the same captured/verified/native/deployment distinctions and next-first-failure reporting.

| Remaining capability / route | Historical hot complete-call candidates (overlapping seconds; not additive) | First usable slice and estimated size |
|---|---|---|
| Dict/set plus graph eligibility | pprint._safe_repr 3.773; Battle.evaluate 1.954; meteor.solve 0.135 | Guarded boxed objects or finite-universe set masks; 1.5-3k lines for first container/control slice; capture and callbacks are separate blockers |
| Closures/callable values | SymPy cache wrapper 0.953; MDP topoSort 0.703; Fraction.forward 0.304 | Owned guarded environment/call entry; 1-2k shared call/environment lines plus nested-body lowering; aggregated closure instances cannot be ranked individually from retained data |
| Immutable bytes | a85decode 0.936; _85encode 0.570; _b32decode 0.346 | Borrowed immutable buffer + checked scans, allocate result once; 1-2k lines for first read/codec primitives; base64 concentration must be reported |
| C builtins/methods and keyword/variadic binding | Decimal pi 0.366; factorial 0.329; regex block1 0.012 | Boxed direct calls with exact binding/ownership/guards; 1-2k shared lines, or whole-function emitter route above; no float Decimal surrogate |
| Unicode strings and formatting | textwrap.dedent 0.00108 explicit string-method control; ordinary-source f-strings and formatting counted separately | Borrowed Unicode kind/data or boxed CPython operations, then formatting; 1-2k first slice plus format parser/semantic work |
| Generators, async and larger statement forms | Retained generator/waiting envelopes are not simple compute bounds | Explicit continuation/frame/exception design required; several thousand lines per major subsystem; no implementation or weight fraction credited yet |

These are plans/sizes, not completed capabilities or timed ceilings. S32-ceiling-selection-review.md supplies exact source/input recipes and weight caveats. S32 requires the three-version hottest-function ceilings before each representation DESIGN; native string/bytes ceiling experiments can proceed while product implementation awaits the S33 backend choice. Existing bytes first-decline own-time association is 1.255295 s, of which base64 is 1.254785 s; leaving it out gives 0.000510 s. The failed fastapi busy-wait is excluded from aggregates/rankings. Primary-entry inclusive envelopes overlap and are never summed as unlocked time. C builtin/method individual counts were not serialized by wave14; all public methods are tested, with unavailable counts recorded unknown.

## Open soundness limits and run status

The clean matrix is finite execution evidence, not a proof of all Python values or alias graphs. General scalar argument/return identity outside the witnessed and/or domains, arbitrary object graphs/hooks, NaN payload details, unexercised signatures, and new callback/ownership rules remain explicit wider limits. Non-numeric chains and some otherwise-safe large integer chains conservatively decline. The named-decline policy must remain strict; unexpected backend failures are not relabeled as unsupported merely to clear tests.

No Step 3 item has been closed as "missing analysis." The missing backend/analyses are sized above and remain work to implement after the explicit S33 decision. Per S33.1, implementation is awaiting that decision; there is no CHECKPOINT DONE yet. TIMING.lock is released after every measured job, and audit receipts include before/after atomic-acquisition no-competing-workload checks. The only stopped process was this run's verified idle waiter to resolve mutual coordinator waiting; no other process was touched.

Accepted diagnostic commits: b83836e (backend/reuse), f804668 (bytes), cbee527 (S36 route correction). S32 bytes ceiling is independently reviewed in matrix/ceilings/BYTES-BOUND.md and matrix/review-s32-bytes-final.md. All1614 behavior gates,18 ownership groups,24 three-pair timing cells and fresh-process AOT pass with zero timed fallback. At1MiB raw input CPython/boxed-AOT/borrowed-AOT ms: a85decode109.8762/54.0973/0.8699; b32decode76.5699/71.3691/1.2648; a85encode helper41.4286/32.5859/1.1026; b85encode helper43.6849/32.6772/1.0706. The superseded S32 arithmetic gave boxed a85decode0.511 of absolute best direct-C saving; S36 withdraws that rule and selects borrowed buffers for all four bodies by remaining time<=2x of best. Tiny-call boundary regressions remain gated. This is a base64-concentrated diagnostic with default decoder flags, explicit trusted/GIL/ambient-finalizer limitations, no product capability or new native rows. Unicode control follows independently; backend decision still pending and no DONE.

S36 supersedes the earlier half-time-saving selection: all four byte bodies use borrowed buffers as primary (boxed/original for guard misses), because remaining time must be within2x of the best measured route. Small20/127-byte winners and sparse measured crossover intervals are now in BYTES-BOUND.md; no new timing was required. Shared bytes/Unicode pinned-owner representation will be stated with the Unicode bound.

The Unicode control is independently accepted in matrix/ceilings/UNICODE-BOUND.md and matrix/review-s32-unicode-final.md: 2,328 all-identical value/type/input-alias/exception/event gates, every one of CPython's29 whitespace code points, six1,000-call ownership groups and fresh AOT without Numba. Session.commit / Session.flush / Query.all docstring complete-call CPython/boxed-AOT/borrowed-AOT us are4.0322/6.6740/5.5732,3.0010/5.0336/4.5394,2.7574/4.8140/3.3658. Borrowed direct C improves only Query.all by6.6%, and that gain disappears at the existing pipeline boundary. Both AOT variants fall within S36's2x remaining-time bound but are slower than CPython, so standalone dedent remains in Python under the unchanged profitability gate. These are actual uncleaned SQLAlchemy source docstrings selected by its real helper recipe, not serialized historical arguments or a whole-program unlock claim.

The shared future mechanism is in matrix/ceilings/SPAN-DESIGN.md: exact-type/context guards, pinned buffer owner, data/length plus Unicode kind, checked indexing and one Python-result construction. It reuses installed Numba model/lowering support where strict semantics match, while keeping selected-object provenance distinct from buffer ownership, accounting for native-to-Python result copies and forbidding rerun-from-entry after effects. No product implementation is started until the explicit S34.3/S36.4 backend choice; the matrix remains235native/781declined/0wrong/0crash. Dict/set and call/closure ceilings remain next subsystem experiments rather than closed steps.

---

# wave16-inplace status report

**Run open at the S55.3 steering-request boundary: partial Step4a is committed; Steps2/3 and Step4b remain unimplemented. The conversion-only budget projects none of the ten regions below Python, so Step2/3 product activation awaits the required revised-entry steering. This is a progress report, not DONE.**

The last complete ten-pair whole-call kernel comparison is checkpoint49, carried forward explicitly under S37.3. These are the recorded depth/control and integrated sources from that cohort, not a new Step2 result:

| Kernel | Depth/control ms | Integrated ms | Change |
|---|---:|---:|---:|
| barnes_hut | 32.50365 | 33.33150 | +2.547% |
| fannkuch | 12.81935 | 12.79390 | -0.199% |
| scimark | 1.38415 | 1.40535 | +1.532% |
| raytrace | 2.83640 | 2.83450 | -0.067% |

Source: [checkpoint49 paired analysis](inplace/step0-final-ten-v1/paired-analysis.json). Barnes +2.5% and FFT +1.5% remain the named Step4 lifetime/allocation guard targets. Fannkuch and raytrace paired changes were unresolved. No live direct-access result exists yet. The complete partial-Step4a33-program normal20-loop selection reports2022captured/100verified/2deployed regions and2/33programs deploying, unchanged from2baseline;40savedAOT completions pass independent audits and exact behavior checks. This is current selection evidence, not final direct-access acceptance. See [complete receipt](inplace/s43-selection-full33-v1/complete.json) and [summary](inplace/S43-SELECTION.json).

## Resume verification after S49

The accepted native integer-set capability90567278 is merged as4b777eaf. Its source-sealed union completed2457tests/131subtests with2expected xfails; the unchanged source/test/helper manifests were reverified on resume.

The revised numeric contract requires exact builtin int/float/complex type/value, including float bits, and exempts numeric-box identity only. The original sixteen int/float value cases pass on frozen0ef65037 and merged source, strengthened to require an actual successful CPUDispatcher call on every first/warm call and no fallback. Source/test/helper seals and independent review are in [resume review](inplace/S49-RESUME-REVIEW.md) and [native baseline receipt](inplace/correctness/s49-native-baseline-v2/gate.json).

A new independent-review witness exposed incorrect mixed numeric/dict-or-set identity: `0 is {1:2}` compiled asTrue by comparing the payload to arena handle0. The precise typed correction emits the proven type result after evaluating operands; numeric-vs-numeric identity observations remain declined. Expanded fail-first gate16failed/37passed becomes69focused passes including exact numeric values, BOOL/None/subclass identity, MIXED/special floats, effects/exceptions and chains. Complex controls verify interface type/component bits, with no native-complex claim. Full changed-source union passes2526tests/131subtests with2expected xfails; source/tests/harness seals are unchanged. The five-line correction has independent final review and is accepted as a correctness fix, with no performance claim.

Direct-access preparation is rebased in [S46 resume preparation](inplace/S46-RESUME-PREPARATION.md). Its new ordinary local-class witnesses distinguish persistent cache retention after successful compilation from a reached `__class__` closure's initial eligibility refusal. One separate actual-executable lifetime control passes for a simple reader, without certifying every native owner graph. None of these results is a direct-call, journal or performance gain. S46's fresh ten-region pass and its one required disturbed repeat both complete,160successful observed calls. The descriptive component ranges and every named other phase are in [S46 bound](inplace/S46-TEN-BOUND.md); observer overhead, dispatcher/boxing and peer correctness disturbance remain explicit.

## Recovery and accepted steps

- Protective WIP commit `066589e4` preserves the entire prior uncommitted tree. The interrupted checkpoint60 union is excluded and its directory is not reused.
- Accepted Step0 commit `fd154095`: fresh union 1257 tests/131 subtests, one three-pair native-shape remeasure. Barnes differences -2.1540/-0.0084/-1.6204 ms consistently recover over half the earlier regression, so native shapes stay by S37.2. FFT differences +0.0341/+0.0126/+0.0008 ms remain adverse. No further guard variant or remeasure.
- Step0 startup evidence remains checkpoint43: integrated/coverage 0.97480 chaos and 0.95574 Richards, 20 AOT calls each, no regeneration, as S37 directs.
- Step1 commit `8128c4da`: complete per-region bound, named other components, warm/cold separation, observer-on/off exact behavior, and dominance checks. See [the full component tables](inplace/bounds/STEP1-BOUND.md). Trivial complete call 7.673212 us versus Python 0.055112 us.

## Component status

| Component / scope | Before | After Steps2?4 | Status |
|---|---:|---:|---|
| Barnes warm load | 93.62625 us/call | not measured | live direct access inactive |
| Barnes warm writeback | 32.09075 us/call | not measured | journal inactive |
| raytrace warm load | 117.375 us/call | not measured | live direct access inactive |
| raytrace warm writeback | 439.575 us/call | not measured | journal inactive |
| transform_point first lookup | 3504 us (later 3.6?4.2) | not measured | preparation target |
| create_gc_cycles result conversion | 9040.75 us/instrumented attempt | not measured | new-output allocation/observation target |
| Trivial complete compiled call | 7.673212 us | not measured | target below Python 0.055112 us |

The held-out largest comparable buckets are create_gc_cycles result 9040.75 us, Task.qpkt lookup 2701.8125 us and DeviceTask.fn lookup 1033.85 us. Input direct access does not remove creation of a new output graph. Cold raytrace lookup and FFT observer bookkeeping are not removable production-cost estimates. Before values come from their explicitly separate frozen contexts; they cannot be added to independently timed complete calls.

## S41 fixed-cost progress (checkpoints69?74)

The earlier fixed-cost snapshot has one complete three-pair development comparison, with exact results/types, zero fallback, real compiled dispatchers and a separate untimed three-entry dispatch audit in each child. Source/helper manifests and all child-receipt hashes remain unchanged. This snapshot predates retained alternating-variant lookup and is not final acceptance.

| Complete warmed call | Before us | Initial rules us | Change | Python us (after) |
|---|---:|---:|---:|---:|
| One field read/comparison | 7.059526 | 5.806244 | -17.8% | 0.029102 |
| Scalar arithmetic | 4.710888 | 1.964356 | -58.3% | 0.024444 |

Evidence: [development receipt](inplace/logs/s41-fixed-development-v1.receipt.json), [raw pairs/source manifests](inplace/s41-fixed-development-v1/complete.json). Both miss the well-under1us target and remain much slower than Python. No kernel recovery or new deployment count is claimed.

Rules remove graph loading for primitive-only acyclic checked graphs, frame scans for acyclic graphs, unloader/writeback for proven readonly primitive results, and RNG export when no generated operation uses it. Missing proof stays conservative in authenticated prepared restoration. The reviewed retained-variant rule reuses already retained Programs with fresh load and live guards, current dictionary membership, bounded weak references, and ordinary resolver behavior for overrides or misses. It does not remove first-ever preparation or output-graph reconstruction.

The initial full union passes1329tests/131subtests. Retained-variant focused compatibility passes152tests; identity/checked-overflow controls pass12tests. The final exact-source union passes1342tests/131subtests; its fresh four-kernel build completes in165.469s with source/artifact manifests pinned. Independent review and fail-first evidence: [review](inplace/S41-REVIEW.md), [design](inplace/S41-FIXED-COSTS.md). Invalid/incomplete directories are excluded and never reused.

S41.6 is answered: the unchanged monitor assertion passes alone three times on accepted Step0 and three times on current source. Under the steering rule, the earlier failure is pre-existing timing sensitivity; no assertion/threshold changed. The final current-source union passes1342tests/131subtests; source/tests/harness manifests remain unchanged. Final whole-Step4 trivial/six-region/four-kernel/33-program acceptance remains pending.

## S43 native-entry direction and partial Step4a

S43 requests one remaining scalar/field component pass and a genuine C vectorcall entry if the floor is Python wrapper work. [The one pass](inplace/S43-BOUND.md) finds ordinary scalar2.295726us and field6.087000us in its own diagnostic context; scalar attempt1.957836us, helper1.709802us, dispatcher-call envelope0.378582us and guards-only0.128622us are separate descriptive envelopes. All128 observed calls in each case reconcile exact native status0/JIT/outer completions. Scope overhead is retained and cannot be added/subtracted from ordinary latency.

The native public callable, raw JIT/AOT entry and independent C completion audit require more than about3hours of implementation. S43.5 therefore directs a commit of the reviewed current fixed-cost rules as **partial Step4a**, followed by unchanged33-program deployment selection before building **Step4b native entry**. This accepts the bounded current mechanisms; it does not accept the whole Step4 or waive its sub1us/kernel/deployment criteria. Field input conversion is explicitly Step2 underS43.4. Accepted partial Step4a commit is0ef65037. Both smoke rows complete, and the full33cohort finishes with2programs/2regions deploying: chaos and richards_super,20AOT each. S46 therefore reorders Steps2/3 beforeStep4b: even subtracting5us from all98verified-but-not-deployed complete calls predicts no extra region faster than Python. This subtraction is a model, not a measured direct-access gain; the ten named larger object-graph regions must receive a component bound and complete-call acceptance.

## Step2 foundation, still open

The implementation now includes primitive effect summaries, recursive union fixed points, canonical aliases, conservative topology invalidation, backward numeric identity demand, and a conservative bridge from real compiler types. A shared no-NRT LLVM adapter actually invokes native code through owned test buffers, returns checked/static error statuses before Python boxing, preserves F/I aliasing, retains linked environments, and rejects unaudited intrinsics/dynamic globals. Global constructor escape facts are weak on class and init dependencies.

One independent review supplied fail-first topology, identity-cycle, constructor, primitive-ownership and environment counterexamples. Final focused result: 169 passed, including existing R7/R8/escape controls and the unchanged monitor file. The full union attempt is excluded: 1304 passed/131 subtests passed, one existing monitor timing-ratio assertion failed (library 0.001462103 s versus required 5*self 0.002405220 s). Its later focused pass does not replace a passing full union, and the full attempt predates the final metadata validation. No full-suite pass on the final foundation is claimed. This does not establish a live object certificate. See [review and limits](inplace/step2-foundation-review.md).

Still required: typed checked-op/source/CFG identity binding through R8 and calls; complete weak persistent descriptors; installed-header fresh C walk and strong-pin lifecycle; direct load lowering; token-aware original box materialization; actual native/cleanup accounting; saved-AOT capsules and no-Numba restoration. No direct counters, reach, half-bound achievement or performance gain are claimed. Step3 cannot publish speculative stores without that callback-free native interval and token-aware journal. Step4 has reviewed fixed-cost rules and a measured initial gain, with acceptance still pending as described above.

At checkpoints67?68 the run requests costed scope/order steering under S37.4 rather than extending a no-gain subproblem indefinitely. [The request](inplace/STEP2-STEERING-REQUEST.md) names measured test cost and remaining implementation. Union verification and preservation continue independently while direction is pending. A final report must replace these pending fields and add DONE only when the authorized closure is actually reached.

## Remaining steps and named soundness work

Step3 is open, not rejected. The typed undo journal needs slot identity and alias-canonical first-store records; original references must survive until commit, restoration must run before Python error/replay, and unrelated pins must be released before observable allocation. Overflow, bounds, exception, allocation and recursion exits must exercise real partial stores. Without the Step2 C interval and identity/token lowering, a Python finally block would allow observers to see speculative state and cannot implement this contract. No such substitute was installed.

Step4 source inspection finds that `_Gen.call` reads `top[2]` only on checked recursive edges, while `Region.attempt` scans every Python frame on every call. A complete acyclic graph can therefore justify removing that scan; its source proof and regression cases still need implementation/review/timing under the chosen order. Other controls must follow actual emitted uses, not a blanket zeroing-removal assumption. The prepared runtime cache is already accepted startup work and does not prove that per-context Task.qpkt preparation has disappeared.

For create_gc_cycles, native output allocation needs source-ordered observation/safepoints and an exact continuation after visible progress. Bulk graph reconstruction at the end changes allocation/GC observation and cannot be relabelled direct output. The detailed route and counterexamples are in `inplace/task2-preparation/future-step4.md`; no source-ordered allocation or continuation engine has been built. The 9 ms result bucket remains an explicit target, not an achieved saving.

## S46 continuation and open counterexamples

The required90567278 integration and union are complete. The complete ten-region diagnostic is S46-TEN-BOUND.md; the subsequent S55 cost table supersedes any conversion-only implementation projection. Step2/3 acceptance adds allten complete-call times and one33-program selection against2regions/2programs; final ten-pair four-kernel recovery remains.

[Reviewed native-entry preparation](inplace/S43-NATIVE-ENTRY-PLAN.md) is parked for afterSteps2/3. The fail-first identity file exposes12failures/3passes on4a, including returned numeric input/constant boxes and a mixed-origin branch; callable controls expose2expected missing-entry failures/12passes including raw adapter controls. They are preserved in inplace/step4b-preparation with the locked red receipts, excluded from passing-suite claims, and remain open correctness obligations for identity/token handling and final acceptance. No native C-entry product code has been written.

## Completed S46 capability integration

Accepted90567278 and ancestry are merged as4b777eaf after the2457-test/131-subtest union and independent review. Its effective runtime changes are lift.py/profiler.py and set regressions; no direct path activated. The later reviewed identity correction939570e4 passes2526tests. The current provenance integration passes2577tests/131subtests with2expected xfails on frozen source/tests/harness and an11-file immutable corpus; all seals independently verify.


## Completed shared provenance integration

Accepted shared source analysis0b8ffc2d is integrated for Steps2/3 consumption. The module supplies conservative original-source owner/escape facts and returns unknown where proof is absent; it activates no direct path. Its51focused tests and122corpus queries (17proved/105refused in peer acceptance) are verified separately from product execution. Current integration union:2577passed,131subtests,2expected xfails; source/tests/harness and the selected11-file corpus all retain their frozen hashes. Physical cell roots, layout validity, observer-safe journals and R8 transfer certificates remain consumer work. See inplace/S46-RESUME-PREPARATION.md.


## S55 design budget and unresolved work

The [per-region budget](inplace/S55-ENTRY-BUDGET.md) estimates the conversion-only design after granting zero load/write-back and excluding observer bookkeeping while retaining every other observed component. None of ten estimates is below its prior Python time: Task.qpkt127.63?162.19us against59.54us, HandlerTask.fn122.37?129.19us against12.81us. These are conservative provisional estimates with retained timers, not measured savings or a lower-bound proof. No cost is invented for the unbuilt C runtime.

The [revised direct design](inplace/S46-DIRECT-DESIGN.md) specifies demand-based first-touch guards, shallow variant selection and returned-owner mapping instead of full reachable-graph entry work. Existing Task.qpkt/Task.runTask samples try1to4loads/guards; the single-attempt DeviceTask.fn still has9us of lookup, so repeated variants do not explain all of other. S55.3 requires a steering request with this table before product edits; the request asks to bound the demand-based entry/result-owner prototype and revise projections before activation. Step4b alone cannot remove the remaining large controls.

Shared provenance consumption exposes a concrete prerequisite: eight original method bodies fail source binding on the accepted layer. The actual Task.qpkt comparison differs only in CPython3.14 CO_METHOD; six executed positive method queries fail and a central-owner request is in root REQUESTS.md. Current corpus collectors do not execute class-method metadata automatically, so the separate red tests are the executed evidence. This does not invalidate conservative layer refusal or authorize a private solver.

S53 adds exact array.array d member buffer export/pin/release and scimark SOR20-loop acceptance after object-field work. Reused installed-Numba borrowing passes; seven product prerequisites remain red and the Python resize-callback control passes. No product buffer or native-rollback success is claimed. S54's future interpreter calls require commit/release before callbacks and fresh first-touch validation after; effectful post-call misses need continuation deopt, never replay of committed effects.

Direct execution, journal/rollback, buffer runtime/SOR acceptance, Step4b, ten-region retiming, the next33-program selection and final ten-pair kernel acceptance all remain open. No new deployment or kernel speedup is reported.

## S51 partial census and integration boundary

The range commit is `2d3f0e26`; trunk/shared-provenance integration is `1c603d8a`. The integrated `python -m pytest -q tests` run passed **2696 tests and 131 subtests**, with **2 expected failures**. Range measurements above retain their original measurement context.

The [bounded all-blockers census](lift-evidence/ALL-BLOCKERS.md) covers all 135 historical targets across 31 programs: 134 analysed, one already native, zero failed program collections. It finds 118 observed reason families; C/library calls appear in 56 functions/20 programs, and object-entry acceptance is the only observed family in 24 functions. All 134 analysed roots retain unknown remainder, so **no reliable completion forecast** is claimed. The report includes optimistic conditional choices, 115 existing inclusive weights/20 missing, 20 timing wrappers, top contributors and recomputed leave-one-out sequences. Diagnostic/report tests: **33 passed**.

Counts remain **60/375 fully native**, **0/375 native with fallback (0 sites)**; no fallback native/Python time share applies and no census deployment gain is claimed. [Known gaps](KNOWN-GAPS.md) retain the diagnostic limits. [The steering request](lift-evidence/S54-STEERING-REQUEST.md) asks to accept the partial census and choose a sound first S54 scope: decline sites with possible post-effect replay, or authorize a new continuation mechanism. Existing product code continues to decline those calls. S58 replaces earlier review/evidence requirements for subsequent work.

## S59 scalar clock calls

Guarded exact built-in `time.perf_counter` calls (including aliases and pyperf reexports) now compile through CPython's performance-clock API and seconds conversion. Binding changes and unsupported call shapes retain Python replay. A pre-import replacement C builtin is distinguished by its actual C entry and flags, not copied metadata. Fresh prepared AOT reload does not import Numba.

Focused clock/tool tests: 38 passed. Full suite `python lift-evidence/full_suite.py s59-clock-union`: 2747 passed, 2 xfailed, 131 subtests passed over four below-normal workers. The single independent review found one executable replacement-builtin counterexample; its fail-first regression now passes. Ten-minute bounded differential mode checked 27 native and 173 declined clock cases, with 56 resource-filtered and zero differences/errors.

Actual SparseCompRow_matmult executes natively with zero fallback and exact output [20.0,60.0,120.0] in the small correctness probe (`lift-evidence/s59-scimark-clock-probe.log`). Returned durations remain nondeterministic; this does not weaken the exact profiler verifier or promise that timing wrappers deploy. Whole scimark at 20 loops: merged baseline 7.75x, clock build 8.20x, PyPy recorded 11.91x. Raw outputs: `lift-evidence/s59-merge-bench.log` and `lift-evidence/s59-clock-bench.log`; both include concurrent correctness work, so no additional clock speed gain is attributed.

No fresh 375-function census is claimed (historical reference60/375 fully native,0 native-with-fallback); S59 closes census extension and prioritizes whole-program progress. Nqueens next stops at generator loop-else, then tuple(range); those capabilities remain separate work.

## S59 generator loop-else

Generator consumers now preserve for/while `else` exhaustion, generator breaks/returns and consumer early exit. Generated stop flags avoid all application AST names. Focused12passed; one independent review found a global-shadowing wrong result, added as a red regression and fixed. Bounded fuzz sampled55native/220declined/109filtered,0differences/errors.

Full suite `python lift-evidence/full_suite.py s59-generator-union` (three workers alongside the committed-clock matrix report):2759passed,2xfails,131subtests. Fresh-cache nqueens20-loop three-pair medians1.919s plain/1.969s compiled=0.97x, identical output,no deployed functions; PyPy1.67x. This is no whole-program gain: nqueens now stops at tuple(range), then sequence constructs, which remain separate work. Raw output is `lift-evidence/s59-generator-bench.log`.

Post-clock committed-source matrix:253native/773declined/0wrong/0crash over1026rows, including inherited wave19 changes. Historical375-function reference remains60native/0with-fallback; no fresh total or completion forecast is implied.

