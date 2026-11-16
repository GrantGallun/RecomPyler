# RecomPyler optimization rules catalogue

Shared by every run. One row per rule. A rule is a rewrite the compiler may
apply to generated code, and it always has the same four parts:

- **Fact**: what must be true for the rewrite to preserve Python behaviour.
- **Source of the fact**: proven from the code (costs nothing at run time),
  or guarded once at region entry (the checked version runs if it fails).
- **Emitted form**: the cheaper representation or operation.
- **Evidence**: the measured bound (unsound hack or hand-written ceiling)
  and, once built, the achieved gain and how many sites it fires on across
  the 49 workloads.

Rules of the catalogue:

1. Nothing enters "built" without a measured gain and a reach count.
2. A rule with a bound but no sound implementation is "open", never
   "rejected because Python requires it". Rejection needs a measured reason.
3. Memory safety facts are proven or guarded, never deferred to rollback.
4. Strict Python results are the default. A rule that changes results for
   some valid input is listed under "opt-in" with its bound.
5. Every run that builds, bounds or rejects a rule updates its row in its
   own copy and reports the change in its RESULT checkpoint; the
   orchestrator merges accepted changes here.

Status values: `built` (in an accepted source), `open` (bound measured,
not built or built below bound), `candidate` (known technique, no bound
yet), `rejected` (measured no gain, with the evidence), `opt-in`.

## 1. Facts (the shared analysis layer)

| Fact | Meaning | Have today | Missing |
|---|---|---|---|
| F1 range | Interval of an integer value relative to constants and stable lengths | Shared guarded affine/geometric and dependent-stride analysis; stable extents and permutation content (wave15) | Carry-dependent bitreverse j/k; arbitrary joins/products and shrinking geometric loops |
| F2 non-escape | An object or list is never observed outside the region or by identity | Shared Facts API; monotone instance origin/capture/identity/return/mutation summaries across calls and recursive groups; immutable per-analysis structural caches (wave16) | Conditional first-escape materialization and virtual receiving containers/child slots |
| F3 dead-before-rebind | The old value of a name is unused when the site executes again | Shared existing F2/F3 dominating-owner/iterator/captured-method facts; per-copy equal-owner certificate (wave15) | General liveness outside admitted private stable-buffer copies |
| F4 kind stability | A value is always int or always float on every path | Shared real-tag guarded function versions, checked miss bodies, defining-use boolean proof and immutable conversion headers (wave15) | Fixed layout/ABI through all joins; general mutable/unknown field effects |
| F5 effect summary | What a callee may read, write, raise or observe | Typed checked-IR lifetime/field mutation/return summaries, cached scalar clone validation (wave15), and conservative no-Virtual scalar identity certificate (wave16); census57hold/1703unknown remains separate | General unknown-call effects and virtual container summaries |
| F6 sole owner | No other reference to an object exists at entry | Census: 0 hold, 201 fail, 59 unknown | Entry guard design (reference count or allocation-site proof) |
| F7 stable layout | A Python object's class, field set and container storage do not change during the region | Loader validates types per call by copying | In-place guard and invalidation (wave 13 IN-PLACE-DESIGN.md) |
| F8 distinct elements / loop independence | Iterations do not interfere | Census: 2 hold, 233 fail | Needed only for batching and vector rules |
| F9 failure-free | The operation or region cannot raise or take a fallback exit | Shared guarded per-copy physical kind/extent proof, safe after earlier unrelated status failure (wave15 R4) | Whole-region failure freedom and unknown callee effects |

## 2. Rules from RecomPyler's own measurements

Bounds are from wave13-depth ladders (ms saved on the kernel; conditional on
ladder order) unless noted.

| Id | Rule | Fact | Emitted form | Bound | Achieved | Reach | Status |
|---|---|---|---|---|---|---|---|
| R1 | Unsigned physical index | F1 (local) | Unsigned compare, no wrap handling after normalization | FFT 0.75 ms | FFT 0.49 ms (17.7%) | lift backend | built (wave15 step0 4d5ef903; reproduced) |
| R2 | Dead local list buffer reuse | F2, F3 | Copy into existing buffer, no allocation | fannkuch 7.4 ms | 5.4 ms | 1 site in 49 workloads | built (wave15 step0 4d5ef903; reproduced) |
| R3 | Borrowed copy without owner rebind | F2, F3 | Void copy helper | fannkuch 2.4 ms owner work | about 2% (unresolved) | same site | open |
| R4 | Stable local owners with one release on each exit | F1 + F2 + F3 + copy-site F9 | Void copy under equal physical kind/extent proof; ordinary allocation/exit cleanup retained | Fresh current replay14.5481 ->leaking12.5340ms:2.0141ms; old1.8862ms | Fann paired1.82905ms/12.46%,95%[1.77255,1.91060],90.81%fresh bound; fast-loop NRTsites6 ->0 | 1site/1Pythonfunction/1of49workloads; two exits retain4decrefs each, fallback6loop sites | built accepted wave15 item4; no NRT suppression |
| R5 | Raw arithmetic under range proof | F1 | Plain bounded arithmetic under shared entry guards | FFT 0.4354 ms; multiply alone 18.6% (overlapping) | R5+R6 FFT 0.6919 ms / 33.02%; fannkuch 3.3132 ms / 18.55% | 44 AST sites, 5 functions, 2 of fixed 49 workloads; 1 site constant-folded already | built wave15; combined gain, not separately attributed (flag form remains rejected) |
| R6 | Logical bounds and negative-index removal | F1 | Raw indexing / prefix reversal / rotation under shared guards | FFT 0.2634 ms; part of fannkuch 3.6375 ms | R5+R6 FFT 0.6919 ms (99.0% numeric+bounds sum); fannkuch 3.3132 ms (91.1% checked-control rung) | 30 sites, 4 functions, 2 of fixed 49 workloads | built wave15; checked fallback retained |
| R7 | Guarded fixed numeric function bodies for MIXED | F1 + F4 + F5 | Float-only body under entry kind/range certificate, original checked miss; direct implied fixed callees | Historical 0.8883 ms native whole-graph fixed-FLOAT before R8 is unavailable at this stage: 4399585 -> 431538 predicates for ~0.17 ms development, 0.25585 ms accepted paired saving | Ray paired 0.25585 ms / 8.07%, 95% [0.21160,0.35140]; 28.80% historical rung; no resolved slower control | 49 saved selections: 2 workloads, 37 emitted contexts / 16 Python functions; ray17 entered fixed contexts / 10 Python functions; 7 ray / 3 Barnes direct MIXED fields retained | built accepted (wave15 item3); full MIXED storage and ABI remain; fresh remaining fixedFLOAT/layout/ABI diagnostic0.4432ms after tuple batching (0.3923msstandalone), no new productgain; branch prediction unmeasured |
| R8 | Scalar replacement of non-escaping instances | F2 lifetime + F5 | Local/field-passing/fresh-return scalar clones; original handle path at escape | raytrace 0.7422 ms on modelled temporaries | ray3.7069 ->3.1182ms:0.5887ms/15.88%,79.32%of conditional bound; controls unresolved | 10Python allocation sites/9Pythonfunctions/2of49selected workloads (13typed sites/12inference functions): ray9Python sites/451466bumps,Barnes1/100;chaos source-only5000 | built wave15 item2; reviewed797tests+131subtests,120fresh cells; d separate candidate |
| R8d | Conditional first-escape materialization | F2 lifetime, F5, virtual container/child-slot proof | Scalar fields plus a once-materialized handle | zero avoidable bumps on current chaos60,000/ray5,333 paths | not built per S26 | zero current native workload reach | candidate: pays when receiving local container/child slots also remain scalar; real handle stores materialize every instance |
| R19 | Immutable preparation structure and no-op scalar certificate | F2/F5 unchanged; immutable checked AST; no representable Virtual seed | Per-analysis nodes/parents/text caches; original checked IR when R8 is provably identity | Richards F2 90.699-96.001ms; scalar approx234.131ms, separate compile-only budgets | F2 140.667->41.4085ms; scalar248.116->11.3395ms(final combined context); total513.907->160.9996ms | Measured Richards55functions/220F2scans; general per-analysis rule, not a49-program reach census | built wave16 integration;949tests/131subtests; whole-kernel no resolved regression; ordinary smoke2deployments |
| R9 | In-place access to Python objects | F7 + typed transitive effects, numeric identity and ownership (+ journal for writes) | Live numeric reads/stores under fresh C validation and strong pins, arena fallback | Step1 tables in inplace/bounds/STEP1-BOUND.md; warm Barnes load93.62625us, ray load117.375us/writeback439.575us; historical causal FFT0.5772ms/ray1.1271ms | No measured gain; proof/adapter foundation only, no live Region activation | zero direct/journal entries or new deployment | open wave16 Step2:foundation retained under S41; Step4a current union1342tests/131subtests passes, monitor isolation3/3 each Step0/current; fresh C walk, identity/R8 lowering, weak persistent descriptors, JIT/AOT binding and journal remain unbuilt |
| R22 | Effect-proven fixed-cost boundaries and retained wrapper variants | Settled checked types/transitive effects; exact live guards and current cache membership | Primitive-only scalar entry; acyclic depth scan elimination; readonly primitive result conversion without unloader/writeback; unused RNG export elimination; bounded weak retained-variant lookup | Diagnostic S41-BOUND/S43-BOUND scopes are observer-retaining, not additive causal savings | Initial frozen three-pair field7.059526->5.806244us(-17.8%), scalar4.710888->1.964356us(-58.3%); below1us target unmet | Two complete-call development examples; current33-program selection pending; zero direct/journal reach | Partial Step4a under S43.5: reviewed,1342tests/131subtests pass; native vectorcall Step4b and full Step4 acceptance remain open |
| R10 | Status in SSA / removal when failure-free | F9 | No status cell traffic | FFT 0.08 ms (7%) | - | - | open, low priority |
| R11 | Direct typed internal calls | F9 | Drop status and helper arguments | FFT 0.09 ms | - | - | open, low priority |
| R12 | No-overlap metadata on F/I views | - | noalias | under noise on 3 of 4 kernels | - | - | rejected (also unsound: F and I views do alias) |
| R13 | Forced inlining of helpers | - | - | none measured | - | - | rejected |
| R14 | Counted outer loop induction | F1 | - | none measured on FFT | - | - | rejected |
| R15 | Checked integer modes (wave 10) | - | Unchecked ints | about 3% | - | - | opt-in, low value |
| R16 | Recursive context packing (wave 9) | - | 2 stack arguments instead of 6 | - | 8.1% Barnes | heap backend | built, integrated |
| R17 | Larger regions rooted at hot callers | F5 | One native entry for the loop that holds the time | wave 14: 44 of 52 verified regions too small to win; 8 large ones lose only to boundary | - | - | open (coverage track) |
| R18 | Pipeline: host target, strict-FP SLP, grouped calls | - | - | FFT 0.21 ms, raytrace 0.19 ms (6% to 12% of gap) | - | - | candidate |
| R21 (wave15 R19) | Virtual private record list and consuming-loop fusion | F1 + F2 virtual-container/identity + F5 effects + F9 failure order | Scalar records or ordered streaming accumulator, with checked fallback | Fresh ray FLOAT/batchedtuple1.2374 ->stream0.8620ms:0.3754ms (paired0.3784), conditional group not pure tuple cost | not built; diagnostic only, all122120record payloads plus15265lists removed | one original comprehension/consumer in ray; zero deployed new-rule sites | open: preserve general effects, comparisons, aliases, identity and failure ordering |
| R20 | Constant-selector recursive group split / partial edge inline | F1 selector + F5 checked calls | Separate selector bodies, preserve full ABI/status, inline nonself edge | Fresh ray matched replay0.8641 ->inline0.8748ms; paired-0.0172ms with reversing signs | no resolved gain for tested partial call/dispatch/ABI ablation | one default ray SCC, colourAtedge eliminated, one recursive rayColouredge remains; zero product firing | rejected for this measured partial form; residual recursive-call/ABI cost unclosed |

## 3. Known techniques from other systems

From a literature survey on 2026-11-13 (a Sonnet worker, web only). "Read"
means the worker opened the source; "lead" means it comes from a search
snippet or background knowledge and must be checked before relying on it.
Each technique is mapped to our facts and to an existing rule or a new
candidate row (K-numbers). No K row has a bound yet.

### 3a. Techniques that map onto rules we already have

| Published technique | System | Our rule | What to borrow | Source status |
|---|---|---|---|---|
| Allocation removal by partial evaluation ("virtuals"); materialize where the object escapes | PyPy | R8 | Materialize at the escape point instead of rejecting the whole object | lead (PEPM'11, DOI 10.1145/1929501.1929508) |
| Partial escape analysis: scalar-replace on non-escaping branches only | Graal | R8 | Control-flow-sensitive form; avoids all-or-nothing escape | lead (Stadler et al., CGO'14) |
| Allocation sinking with stores recreated at side exits | LuaJIT | R8 | Rebuild the object from a snapshot on the fallback path | lead |
| `intbounds`: integer ranges from earlier guards and constants | PyPy | R5, R6, F1 | Ranges learned from guards already executed, not only from loop bounds | read (rpython.readthedocs.io/en/latest/jit/optimizer.html) |
| ABCD demand-driven bounds-check elimination on SSA | research | R6, F1 | Inequality-graph proof of `i < len`; reported about 45% of dynamic checks removed | lead (Bodik et al., PLDI'00) |
| Scalar-evolution bounds-check elimination | LuaJIT | R6 | Induction-variable form | read (names only) |
| `boundscheck=False`, `wraparound=False`, `cdivision=True`, `initializedcheck=False` | Cython | R1, R6, K7 | The exact list of per-access checks a Python compiler pays; `cdivision` reported up to 35% | read (cython.readthedocs.io, compilation page) |
| List strategies (int / float / object) and V8 elements kinds | PyPy, V8 | R7, F4 | Kind chosen per container, one-way transition on violation | read (V8 blog); PyPy int/float strategies are a lead |
| NRT reference-count pruning (per-block, diamond, fanout patterns) | Numba | R3, R4 | Know which patterns Numba already removes so R4 targets what is left | read (numba-runtime developer docs) |
| Ownership analysis: one owner, the rest borrow | Lobster | R4, F6 | Functions specialized by ownership; author reports about 95% of count operations removed | read (aardappel.github.io/lobster/memory_management.html) |
| Reuse analysis / in-place update when unique | Koka (Perceus) | R2, F6 | Generalizes buffer reuse from "dead local" to "unique reference" | lead (paper unreadable to the worker) |
| Shadow frames; virtualizable frames | Cinder, PyPy | R9 | Materialize host-visible state only on demand | read |
| mapdict / hidden classes: shared shape, values in a flat list | PyPy, V8 | R9, F7 | The layout guard is one shape identity check | read |
| Loop peeling: optimize the loop with facts from one peeled iteration | PyPy | F1, F4, K1 | A way to obtain "holds after first iteration" facts cheaply | read |
| Inlining, then re-running simplification | Cinder | R17 | Larger regions first, then local rules | read |
| Type stability and function barriers | Julia | F4, R17 | Split a region at the point where a kind becomes stable | read |

### 3b. New candidate rows

| Id | Candidate rule | Fact | Where it comes from | Why it may matter here | Status |
|---|---|---|---|---|---|
| K1 | Loop versioning: fast loop under a pre-loop guard, checked loop otherwise | F1, F9 | LLVM, PyPy peeling | The general mechanism behind R5/R6 when the proof needs a run-time bound | candidate |
| K2 | Heap load/store forwarding across calls with known effects | F5 | PyPy `heap` pass | Was the suspected cause of the remark counts; R12 measured little, so low prior | candidate, low |
| K3 | Elidable (pure) call folding and CSE | F5 | PyPy `pure` pass | Repeated pure calls in library code | candidate |
| K4 | Globals and builtins as guarded constants with invalidation | F7 | CPython tier 2, Cinder, PyPy quasi-immutables | Removes the "non-numeric global" decline (22 held-out rows) | candidate |
| K5 | Guarded devirtualization of method calls by class shape | F7 | V8, HotSpot, PyPy method cache | Method-heavy held-out programs (richards, deltablue, go) | candidate |
| K6 | Dict specializations: shape-keyed and homogeneous-key dicts, constant-key perfect hashing | F4, F7 | PyPy dict strategies | Dicts are 14% of held-out argument occurrences | candidate |
| K7 | Division and modulo without sign fix-up or zero check | F1 | Cython `cdivision` | Cheap once ranges exist | candidate |
| K8 | Comprehension and generator fusion into the consuming loop | F2, F5 | stream fusion, Pythran | Generators hold about 9% of held-out Python time | candidate |
| K9 | Expression-template style fusion of elementwise list expressions | F2 | Pythran | Removes temporary lists | candidate |
| K10 | Array-of-objects to struct-of-arrays for homogeneous instance lists | F2, F4, F7 | classic; no Python compiler found doing it | Barnes and raytrace scenes; also enables vectorization | candidate, novel |
| K11 | Vectorization enabling: unit stride, no early exit, known trip count | F1, F9 | LLVM, Numba | FFT wrapper vectorized only under the exit hack | candidate |
| K12 | Deoptimization with resume-in-place instead of rerun-from-start | - | all JITs | Lets guards sit mid-region; removes rollback constraints on R5/R6 | candidate, large |
| K13 | Tagged or narrowed integers where range allows 32 bits | F1 | LuaJIT narrowing, V8 Smi | Hand-written fannkuch matched C with 64-bit, so low prior | candidate, low |
| K14 | Strings: interning, known-length, byte-kind specialization | F4 | PyPy | Strings and bytes are the largest uncompiled value kinds on held-out | candidate (coverage) |
| K15 | Cross-call unboxing: pass raw values between compiled functions | F4 | noted as absent in CPython tier 2 and Cinder | We already do this inside a region; extend across region entries | candidate |

### 3c. Reported "Python matches C" cases

All are on restricted or annotated Python, and all figures are the
authors' own:

- Codon: "typically on par with C/C++" through whole-program typing,
  monomorphization and library inlining; disallows some dynamism.
- LPython: 2.2x to 6.0x faster than C++ on a Dijkstra benchmark, 1.7x to
  4.2x slower on Floyd-Warshall.
- Pythran: "as efficient as annotated Cython", no figures.
- Numba: equals vectorized NumPy on a loop; no direct C ratio in its docs.
- mypyc and Static Python report ratios to CPython only.

None of them takes unannotated, unrestricted Python.

### 3d. Not found in any system (the worker's assessment, unverified as a claim of absence)

- A compiler that profiles its own generated representation choices and
  recompiles them (per-site numeric kind, container element kind).
  Existing mechanisms (V8 elements kinds, PyPy strategies) react at run
  time; none is a measured ahead-of-time choice.
- Automatic array-of-objects to struct-of-arrays for Python objects (K10).
- Profile-guided escape analysis for an ahead-of-time compiler.
- Interprocedural range proofs from profile-observed bounds, checked once
  at entry with interpreter fallback (this is K1 with our guard model).
- Unique-reference reuse for Python lists and dicts.

## 4. Discovery procedure (how a row gets here)

1. For a compiled region far from C: write the hand-written typed version
   through the same pipeline (the ceiling).
2. Build the ladder from generated source to hand-written source, timing
   each representation change in one cohort with output checks.
3. Each rung over about 6% is matched to a rule here, or becomes a new row
   with its fact.
4. Build the fact if missing, then the rule, with fail-first tests,
   independent review, the full suite and a paired measurement.
5. Record achieved against bound and the reach count. Investigate any rule
   that reaches less than half its bound before moving on.

## Wave17 measured coverage ceiling (diagnostic, not built)

| Id | Fact | Emitted form | Bound | Reach | Status |
|---|---|---|---|---|---|
| W17-BYTES | Exact immutable bytes, stable helper/module/cache bindings, GIL-held trusted context | Managed objects with boxed CPython APIs or borrowed byte span loops | S32 bytes3-pair complete calls:1MiB a85decode109.8762ms CPython,54.0973ms boxedAOT,0.8699ms borrowedAOT; b32decode76.5699/71.3691/1.2648ms; encode helpers41.4286/32.5859/1.1026ms and43.6849/32.6772/1.0706ms |3 complete bodies from1 program;0 new product-native rows; leave-base64-out historical bytes association0.000510s | open; S36 remaining-time<=2x criterion selects borrowed buffers for all four bodies, boxed guard-miss fallback; product backend choice pending |

See matrix/ceilings/BYTES-BOUND.md for all input sizes,1614 behavior gates, exact flags and soundness limits; this row is not a universal base64 replacement or measured unlocked held-out time.

| Id | Fact | Emitted form | Bound | Reach | Status |
|---|---|---|---|---|---|
| W17-UNICODE | Exact immutable str, pinned input owner, PEP393 kind/data/length, trusted helper context | Complete boxed CPython API or borrowed Unicode dedent scans through managed AOT | Three real SQLAlchemy docstrings CPython/boxedAOT/borrowedAOT us4.0322/6.6740/5.5732,3.0010/5.0336/4.5394,2.7574/4.8140/3.3658 |1 stdlib body/3 source operands;0 product-native rows; historical dedent envelope0.001078s not assigned to operands | open shared Unicode kind; standalone dedent specialization not deployed because measured slower |

Unicode evidence: matrix/ceilings/UNICODE-BOUND.md,unicode-seal.json and independent review;2328behavior gates,6ownership groups,63exact timing routes. Shared bytes/str owner/selection/result-allocation design is in SPAN-DESIGN.md. S36 remaining-time criterion and unchanged profitability gate apply; no rejection of the general Unicode analysis/capability follows from this standalone control.


## Wave17 Step 3 non-escaping sets

| Id | Fact | Emitted form | Bound | Reach | Status |
|---|---|---|---|---|---|
| W17-SET | Positive typed uses never observe set order or owners; exact signed-int64 inert inputs; no Set-bearing escape/store/unknown call/traversal | Detached input Set and private native Set operations with scalar outputs |27 plain-Numba candidate set matches; coverage correctness gate per S38.1, no speed claim | 7 set-comparison rows plus1 tuple-chain row converted;243/1016 total native; observed59/375 whole functions unchanged | open optimization rule (no speed bound); coverage slice accepted under S38.1, managed escaping owner pending S38.4 parity |

## wave18-lift candidates under S49/S51/S54

| Id | Capability | Required fact | Emitted form | Coverage evidence | Accepted reach | Status |
|---|---|---|---|---|---|---|
| W18-L1 | Non-escaping direct local numeric calls | Exact numeric type/value; shared provenance for nonnumeric owners | Eager argument snapshots and local body adaptation | Four matching backend rows; initial three-row prototype result is superseded by owner counterexamples | 0 new accepted rows/functions | candidate; numeric-only plan/red tests prepared, priority superseded by census/fallback (S51/S54) |
| W18-R1 | First-class range values | Checked signed bounds/count; no range escape; numeric-only or inert numeric-container region kinds | Existing native range iteration from flat bounds | Ten fail-first held-out forms:8native/2declined; focused109, union2576; matrix251/775/0/0; fresh60/375 includes inherited+1 | 8new rows accepted,0new whole functions caused | open optimization rule (no speed bound); guarded range coverage accepted, repeated controls/S50 retain disturbance flags |

| W18-CLOCK | Exact original C clock entry/flags plus module/alias identity guards; CPython clock API available; no callbacks | Native raw clock plus CPython double conversion, guarded failure/replay | Focused9, full2747/131subtests/2xfails;27native/173declined fuzz cases,0wrong | Actual SparseCompRow_matmult native1/fallback0; scimark whole20-loop8.20x vs PyPy11.91x | accepted coverage; no additional clock speed gain attributed |
| W18-GENELSE | Exhaustion stays in loop else; early-exit stop propagates through both loop arms; generated flags do not shadow source names | Inlined generator body and else plus stop propagation | Focused12; full2759/131subtests/2xfails;55native/220declined fuzz0wrong | Nqueens now reaches tuple(range),whole20-loop0.97x vs PyPy1.67x | accepted coverage; no whole-program gain |

### Wave16 S83 immortal stack words (open speed rules)

| Rule | Fact and emitted form | Reach | Measured complete-call evidence | Status |
|---|---|---|---|---|
| Immortal constants | Installed-header immortality predicate; emit the same tagged stack word as CPython; mortal NEWREF stays canonical | Original contract constant sites; no new installed functions | Counted C-boundary CP/plain/constants 752/2257/2234 ns, portable warm PyPy145 ns; unresolved | open; correctness locally validated6f10a590 |
| Literal tagged CLOSE | Literal i64 with installed-header refcount tag makes XCLOSE a no-op; omit only that call | 42 original contract helper sites | Counted C-boundary constants/close2234/2214 ns; unresolved, NRT0/totalallocunknown | open; focused71/fuzz2439000, warmfast4037pass129sub5xf259slow0fail |
| Local tagged-word construction | OR preserves a proved tag bit; SELECT requires both choices tagged; other words/PHIs keep canonical helpers. Omit only no-op CLOSE/DUP | Contract168vs42 close sites; no new installed functions | Source CP/plain/candidate902/2588/2366ns, portablewarmPyPy204ns; development8.6percent, still2.62xCP | open;91affected+16runtime/2439750fuzz,warmfast4049pass129sub5xf261slow0fail |
