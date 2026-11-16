# Held-out acceptance harness implementation plan

> For agentic workers: execute only when the coordinator authorizes acceptance work. Use the existing external timing-lock wrapper. Preparation starts no workload.

**Goal:** Preserve the exact 33-program eligibility and ordinary twenty-iteration selection, with byte-exact application behavior and independently audited deployment counts.

**Architecture:** One reusable script snapshots owned product source/current native extensions, helpers and original inputs into a new stage. It exposes separate prepare, smoke/full selection, six-region diagnostic replay, and trivial complete-call commands. Execution requires an existing correctly labeled lock and rejects competing jobs; it never acquires or waits for a lock.

**Tech stack:** Python standard library plus existing S23 profile adapter, application-output boundary, exact mode auditor, compile-only bytecode warmer, native import preflight, owned adaptation of the historical phase child, and wave16 trivial benchmark.

**Spec:** CLAUDE-BRIEF-inplace.md acceptance; CLAUDE-TIMING-LOCK.md; inplace/bounds/BOUND.md.

## Constraints and decisions

- Only this preparation directory is edited. Every eventual stage, input, source snapshot, pycache, temporary file, compiler/JIT artifact and report is owned beneath stages/<new-name>.
- Snapshot current src after its native extension build and before changing source for the next rule. Source snapshots omit caches and include already-built pyd files. The harness never builds the product extension.
- The historical s19-realistic-length3 completion hash and exact eligible set of 33 are frozen. Inputs are copied from the original manifest with byte hashes, never edited in place. Only the owned shim20 changes LOOPS = 2 to LOOPS = 20. The separate owned shim2 retains the historical six-region replay protocol.
- Freeze source/helper/input/interpreter/package identities. Allow bytecode writes only through owned PYTHONPYCACHEPREFIX, remove inherited PYTHONDONTWRITEBYTECODE, and copy no historical startup-cache scalar. Recover effective PYTHONWARNINGS=ignore plus every stdio/locale policy key from actual historical plain/profile/saved/audit invocation evidence, rather than the incomplete stage environment whitelist. Freeze and assert this policy for every child, including the pipe-codec/warning-options probe.
- Run native import preflight and chaos/richards_super smoke before the remaining 31. A valid ordinary gate selecting nothing remains a valid result; do not force the historic two deployments.
- Each program gets one unchanged ordinary profile/select, one direct saved CLI verification and one separate mode audit. No --force, recommendation rewrite, gate relaxation or automatic whole-program timing repetitions. Verification wall times are marked timing_eligible=false and are not headline speedups. Kernel ten-pair acceptance is handled separately.
- Exact application stdout/stderr/exit behavior is mandatory across plain/profile/saved/audit. Strip only the exact frozen print_run AST suffix from saved stderr, under a probe of the actual child pipe codec/errors and host newline policy. Never compare only stderr classes.
- P12 counts captured, verified, actually deployed functions separately; region-only counts and per-function AOT/JIT/fallback modes are also retained. Deployed means observed native execution whose per-function identities/backend/AOT/JIT counts agree with the independent audit. The auditor observes actual native entry plus successful completion, and ordinary Python fallback through code-entry observation, without reading product compiled/aot/jit counters. Runner line numbers absent from its schema are labeled as a unique canonical file/qualified-name plan match, never claimed as emitted runner fields; ambiguous identities fail.
- The exact six are Chaosgame.transform_point, create_cycle, create_gc_cycles, Hex.link_nodes, DeviceTask.fn and Task.qpkt. Match canonical source file, qualified name and source line; short candidate method names are never compared with qualified runner names. The owned phase_child.py preserves the historical targeted candidate/phase protocol and adds explicit behavior/provenance gates. Its targeted monitor/recommendation suppression is diagnostic and never feeds ordinary selection.
- Existing ordinary test_region candidate timings plus saved/audit native evidence are reused when they cover a six-region nominee. Only uncovered nominees use the owned phase child, with an owned per-program manifest/metadata tree. Both the full two-loop plain/profile application bytes and each copied sample's Python/uninstrumented AOT/instrumented AOT stdout/stderr/results/mutations must agree exactly. Its actual AOT-only replay establishes execution mode and behavior. Candidate timings are separate from instrumented phase partitions and must not be added/subtracted. A missing/unverified nominee blocks the six aggregate; do not silently increase capture limits to make create_gc_cycles appear.
- Reuse trivial_bench.py with the same function and alternating complete-call loop. Prepare distinct before/after source stages around each of Steps 2, 3 and 4; each stage gets one trivial result.
- Any incomplete child, behavior mismatch, identity/count mismatch, changed source/input/runtime/artifact, unknown native mode, unaudited batch or missing nominee marks FAILED.json and excludes the entire stage from aggregate acceptance. Preserve failed stages. Do not resume/refill incomplete evidence. Only sealed complete smoke rows are reused for full selection.
- Pprint remains a named row and can be reported separately without changing the full denominator. Do not pool these twenty-iteration observations with historical two-iteration timing.

## Review focus

1. Native extension import paths must point into the snapshot src directory.
2. Exact stderr footer removal must preserve all preceding application bytes.
3. Counter reconciliation must cover actual saved children, not merely exported functions.
4. Partial stages must never be treated as complete aggregates, including when an older complete selection file exists but a subsequent diagnostic fails.
5. Startup measurements must use populated owned bytecode and no inherited startup scalar.

## Authoring tasks

- [x] Read realistic_length_run3.py, frozen manifests/completion, phase_child.py and existing wave16 helpers.
- [x] Write only PLAN.md and heldout.py under this preparation directory.
- [x] Parse heldout.py with ast.parse only; the harness and product were not imported or invoked.
- [ ] Independent static re-review of the prepared script and owned audit/identity/replay helpers after the five review blockers are addressed.
- [ ] After explicit acceptance authorization, prepare and execute the stages below.
- [ ] Compare all33 selection/P12, all6 complete-call/Python and trivial before/after; investigate less than half the Step1 bound before advancing.


## Source/native provenance and future rule claims

- New/updated owned helpers are inplace/heldout_identity.py, inplace/capture_audit.py and heldout-preparation/phase_child.py. Old helpers, inputs and results remain read only.
- Replay seals actual loaded product Python/native paths against source snapshot hashes, loaded native dependency hashes, AOT section and module hashes before load and after replay, executed export names/program digests, and exact generated source files/hashes. All new artifacts must be stage owned.
- Each replay sample has random pipe boundaries around Python, original uninstrumented AOT and instrumented AOT calls. The caller asserts byte equality for both streams; instrumented phase counters are not accepted merely because returned values match.
- Preparation accepts repeated --rule-counter NAME options. Names must denote nonnegative integer successful-complete-call counters. A per-call delta must be 0 or 1 and never occur on an unsuccessful attempt; aggregate deltas reconcile with actual successful completions.
- Step2's interface is Region.direct_calls and program.direct_report (computed effects, identity, live locations and R8 reach/decline). Step3 additionally uses Region.journal_calls for successful completed transactions; abort/rollback is not success. A zero counter does not establish eligibility: keep the actual computed report/decline alongside it. An ordinary/Lift backend without the interface is explicitly unimplemented.
- A baseline source without a feature uses no --rule-counter and makes no current-rule claim. A later stage can be prepared with --rule-counter direct_calls (and --rule-counter journal_calls when available). Step4 counter names/semantics must be settled before claiming that rule.
- Raw direct adapters can bypass the Python program.run callable. No trusted raw C ABI-entry observation exists yet. Such a successful call with no independent native entry becomes unknown/unobserved and fails aggregate reconciliation, even if product direct_calls/aot_calls increase. Do not insert a Python callback into the atomic direct interval; adapt the auditor to a trusted typed-capsule/digest entry counter after the actual interface exists and before timing.

## Future commands (not executed)

From wave16-inplace, prepare source only with bytecode writes disabled in the preparation interpreter:

    python -B inplace/heldout-preparation/heldout.py prepare --name step2-before --source .

Run every following command body through inplace/run_locked.py using the exact same label supplied to --lock-label. Example wrapper:

    python inplace/run_locked.py heldout-step2-before-smoke python -B inplace/heldout-preparation/heldout.py select --stage step2-before --scope smoke --lock-label heldout-step2-before-smoke

Subsequent bodies, each with a separate lock acquisition:

    python -B inplace/heldout-preparation/heldout.py select --stage step2-before --scope full --lock-label heldout-step2-before-full
    python -B inplace/heldout-preparation/heldout.py six --stage step2-before --lock-label heldout-step2-before-six
    python -B inplace/heldout-preparation/heldout.py trivial --stage step2-before --lock-label heldout-step2-before-trivial

Repeat with step2-after after changes/build/review and fresh step3/step4 stages at the required acceptance points. A source snapshot is immutable even when the live clone later changes.

Read selection-summary.json only if all33 are sealed and FAILED.json is absent. Compare programs_deploying against the frozen historical value 2, plus actual deployed regions/functions and capture/verification reasons. Read six-summary.json only if all6 are present/valid and FAILED.json is absent; ordinary selection status remains separate from diagnostic AOT execution. Read trivial.json for complete compiled/Python call cost. No new headline process ratios are computed by this script.

The prepared script has not been invoked. AST-only syntax checks are permitted without importing the harness, helpers or product; this does not validate runtime behavior. No preparation stage, test, build, profile, lock waiter, replay, trivial benchmark or timing cohort was run during authoring. Independent static review is still required before first execution.




Independent baseline preactivation review APPROVED (2026-11-14): prepared_review checked loaded snapshot native paths and hashes, byte-exact stderr suffix handling, independently observed backend native entry/success counts and canonical identities, failed/incomplete stage exclusion, and owned checked-hash bytecode/stdio/cache provenance. No additional blockers found. No workloads or edits by reviewer. This approves baseline activation only; future raw direct adapter observation must be implemented and separately reviewed before direct timing.
