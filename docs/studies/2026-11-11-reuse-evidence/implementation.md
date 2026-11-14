# Guarded fresh-process region reuse

Implementation owner: `heldout-fixes`, branch `codex/heldout-fixes`. Original checkout and integration worktree were not edited. Integration `dba45a7` had cherry-picked prior worker commits, so fast-forward was impossible; authorized merge `b084ba3` preserved both histories. Product commits: `ee71999` (reuse), `20d53bd` (execution counters and complete function metadata fingerprints), `afd09b0` (exact-type namespace rejection before attribute inspection), `1b570ba` (strict and nullable seed candidates for mixed specializations), `13f3224` (sealed startup dependencies and build-time validation), `0d2c3d3` (validated family topology and incomplete-seeding policy).

## Design and implementation

`_region_seed.py` stores versioned JSON descriptions of ordered class families/fields, function specializations and inferred variables/returns, recursive shared inference cells, and global binding locations. It stores no captured mutable values, executable code, or raw `_Program` objects. Bindings resolve through current entry globals and plain class/module dictionaries, without importing modules. Local/unreachable definitions, closures other than normal `__class__`, and unsupported global holders conservatively retain legacy exact-source exports only.

Both build and deployment reconstruct a new program, validate live functions/classes/constructors, and regenerate source and normal runtime guards. Each specialization now gets independent strict and nullable seed candidates. Strict seeds preserve its original nullability. Nullable seeds retain the `None` case so populated profiling graphs cannot erase empty-startup construction branches. This can generate a different export than the warm profiled program. The original verified export remains available; byte-identical regenerated source shares that export, and duplicate strict/nullable source does not add another native kernel. The build rejects each seeded variant whose entry parameter/return machine format or constant-return contract differs from the verified native signature.

Guarded seed selection is enabled only when every exported original specialization of a function has a valid strict seed. Otherwise the build emits that function's original exact-digest exports with **empty seeds**, marks `seed_policy: legacy-only`, records the reason, and omits its optional normalized exports. This preserves baseline legacy selection for supported but unrepresentable metadata, including generator-expression code constants and unused mutable defaults. It is a whole-function choice made at build time, not an escape into ordinary inference after a guarded seed rejects. Export names use a monotonic counter, so removing optional exports cannot collide with a later function's export names.

Native selection requires the exact regenerated source digest, bound to canonical JSON seed identity, Python version, and the bytes of `heap.py`, `lift.py`, and `_region_seed.py`. Failed speculative seed replay cannot initiate JIT. Default AOT-only plans stop on a rejected seed; explicitly forced/JIT-budgeted plans retain ordinary inference. Runtime loaders still validate current argument/global graphs and preserve their values, identities, aliases and cycles. Class tests and partial attribute checks emit tag clauses in tag order.

Each normalized candidate is additionally sealed with a guard-only dependency manifest: discovered functions and plain Python functions held by code/attribute/own/item guards, plus discovered classes, MROs and constructor bindings. It validates actual code/default fingerprints before replay, then attaches cheap per-call code/default/MRO/constructor/class-cell guards. Keyword-default validation requires a plain dict with plain string keys and distinguishes a deleted key from a saved `None`. Sealed regeneration must produce byte-identical source before native selection; it cannot change the inference seed or function numbering. Newly generated startup code must also pass the existing math-equivalence gate at build time. Runtime AOT hits still precede that gate and do not load the JIT compiler for validation.

`Region.aot_calls` and `jit_calls` increment only after a successful attempt completes result conversion and state writeback, using the actual local program. Prepared-but-unused programs, retries and failed attempts do not count. Normal calls, generator consumers and resumed coroutines share this accounting. Runner reports these counters; ordinary AOT/JIT wrappers derive their mode from the implementation actually installed. Existing total counters and the conservative compatibility boolean remain available.

## Evidence

- Before implementation, a real saved native extension loaded but two calls in a fresh process with empty globals fell back: 0 compiled, 2 fallback. Output remained correct under the previous AOT-only safeguard.
- Native regression builds from a populated polymorphic global graph and executes in two fresh processes with distinct hash seeds and both loaders. It verifies 2 successful AOT calls, no JIT/Numba import, exact mutations, current startup values and preserved returned/global alias identity.
- Additional tests cover shared cycles, seven post-success definition/type changes, before-first-call helper/default/constructor/constants changes, invalid/missing/version-stale type metadata, malformed families, rejected binding hooks, and stable source/seed identities across four processes/hash seeds.
- Reviewer-found hook lookup and nullable-signature defects were reproduced with failing tests before fixes. The latter originally caused an actual native build error by exporting a mixed return as the original integer signature; the seeded variant is now rejected.
- Counter regressions first failed for absent counters, then passed for mixed modes, unused preparation, failed native attempts, generators and coroutines. CLI checks cover native hits, digest/load misses, explicit force and JIT-budgeted controls.
- Final combined focused run before the full suite: **43 passed in 19.33 seconds**.
- Source-only Richards_super probe: 12 classes and 100 original inferred function variants; populated and freshly empty global graphs regenerate identical seeded source and digest without importing Numba. This is a source-generation correctness probe, not a performance measurement.
- First frozen full suite at `20d53bd`: **351 passed, 38 subtests passed, 22 warnings in 226.69 seconds**. Log: `heldout-fixes/.tmp/wave3/full-suite.txt`.
- While that suite ran, review found a remaining malformed global-namespace hook path. Source/tests stayed frozen until completion. Two new regressions then failed (function reference read `__globals__`; module reference was accepted) and passed after exact-type checks. Red/green logs: `.tmp/wave3/namespace-red.txt` and `namespace-green.txt`.
- Final suite on clean frozen **`afd09b0b2b5e868a71b20a04e22907aade64b6a0`**: **353 passed, 38 subtests passed, 10 warnings in 91.94 seconds**, exit 0. Only task-owned caches were reused. Log: `heldout-fixes/.tmp/wave3/full-suite-final.txt`. Source and tests remained unchanged throughout both full-suite runs.
- CPU validation slot released to the coordinator after the final suite. No further worker tests, compilation or measurements are running. The coordinator's real Richards native deployment gate and the final bounded independent review remain separate acceptance steps.

## Limits and measurement handoff

### Mixed-specialization correction after the first freeze

The coordinator found a coverage defect during the first frozen study: when one specialization's nullable seed was rejected for a changed ABI but another signature had a valid seed, default AOT-only execution stopped after all seeds failed to load the former signature. It never considered the still-valid legacy export. Output remained correct through Python fallback, but native coverage was lost. The study was stopped and its owned child processes confirmed exited before this worker changed any source or ran tests.

Commit `1b570ba6f7a23ed56b3b43c6643e2006838abddc` adds guarded strict seeds alongside nullable seeds. It does **not** reopen ordinary inference after seed rejection. The poison control intentionally puts a helper only in the object branch; the unrelated valid `None` seed cannot authorize inspecting the replaced helper.

- Real native mixed-artifact red run: **4 failed, 2 passed**, covering both call orders and both loaders; failing cases had 1 AOT call and 1 fallback instead of 2 AOT calls. Log: `heldout-fixes/.tmp/wave3/mixed-red.txt`.
- Reuse-focused green run: **33 passed in 21.14 seconds**. Both signatures now execute through native exports, without Numba/JIT, and mutations occur once. Poison replacement records no lookup hooks and falls back once. Existing empty-global reuse and ABI rejection remain covered. Log: `.tmp/wave3/strict-wide-focused.txt`.
- Frozen `1b570ba` full suite: **359 passed, 38 subtests passed, 10 warnings in 172.58 seconds**, exit 0. Log `.tmp/wave3/full-suite-strict-wide.txt`. Source/tests were unchanged throughout the run.

### Startup-only dependency and math validation correction

Independent review found that normalization could discover constructors/helpers absent from the original inference seed. Replacing their actual code while keeping the same source filename/line could evade the earlier fingerprint set. The real native regression demonstrated wrong output before the fix: four before-first-call cases returned `8` instead of Python's `16` or `17`; four post-success controls already fell back correctly. Red log: `.tmp/wave3/startup-dependency-red.txt`.

Commit `13f3224dfbc82e7a6f78899d53abc03cbef1e917` adds the sealed manifest described above. Further controls cover deleted `None` keyword defaults after success and hostile keyword-default mappings/string-subclass keys without running hooks. The coordinator also identified that new startup math needs the original compiler's math-equivalence validation. Its deterministic red test stubbed that check to reject `sin` and observed two exports/two seeds; the corrected build retains only the strict export/seed. Red log: `.tmp/wave3/startup-math-red.txt`.

- Final focused native, mode-counter and CLI tests: **64 passed in 36.63 seconds**. Log `.tmp/wave3/sealed-focused.txt`.
- Independent source-only probes clear the startup code/default guards, mixed-signature selection, poisoned branch and build-time math gate. The actual native regression is exercised by the focused and full suites, not by the independent no-build probes.
- Frozen `13f3224` full suite: **372 passed, 38 subtests passed, 10 warnings in 187.77 seconds**, exit 0. Log `.tmp/wave3/full-suite-sealed.txt`. Source/tests remained unchanged throughout the run.
- A fresh whole-branch review subsequently consolidated two further findings: malformed family metadata could form a canonical-root alias cycle before digest rejection, and an unseedable original signature could lose legacy native selection when an unrelated signature had a seed. These were addressed together in the correction below.

### Consolidated family-topology and incomplete-seeding correction

Commit `0d2c3d33215f7c289b89944214d4c7b8eaf9ac89` validates the entire family topology before publishing aliases: unique canonical roots, complete and non-overlapping concrete membership, unique own-root assignments, a canonical root among its member own-roots, and explicit acyclic termination at a canonical family. The canonical root need not itself be concrete, so abstract bases and valid merged unrelated families remain supported.

The incomplete-seeding policy above handles the second finding generally, without broadening fingerprint serialization or allowing rejected guarded metadata to trigger ordinary inference. New native fixtures exercise both generator-expression code constants and an explicitly unused mutable default. A third seedable specialization creates an optional export before the unseedable specialization; a second exported function verifies unique native names after filtering.

- Combined red: **10 failed, 1 passed**. The alias-cycle case was bounded by a child-process timeout; the valid abstract/merged-root control already passed. Log `.tmp/wave3/final-review-red.txt`.
- Targeted green: **11 passed**. Malformed metadata rejects before replay and Python executes once; both unseedable causes retain native calls in both call orders and both loaders, with no Numba/JIT. Log `.tmp/wave3/final-review-green.txt`.
- Full focused native, mode-counter and CLI suite: **75 passed in 48.91 seconds**. Log `.tmp/wave3/combined-final-focused.txt`. Existing guarded poisoned-branch and startup dependency controls remain green.
- Final full suite on clean frozen **`0d2c3d33215f7c289b89944214d4c7b8eaf9ac89`**: **383 passed, 38 subtests passed, 10 warnings in 198.28 seconds**, exit 0. Log `.tmp/wave3/full-suite-combined-final.txt`. Source/tests remained unchanged throughout the run. CPU validation slot released; the coordinator owns scoped re-review, the rebuilt Richards deployment gate and replacement study.

The new nullable export has not inherited the warm program's measured timing. Its build cost and actual default deployment behavior must be measured anew. The coordinator owns the independent actual Richards_super native deployment gate and all timing slots. No performance benchmarks were run by this worker.

Unsupported seeds retain safe fallback/legacy exact-match behavior. This does not promise all programs reuse compiled code or a universal absence of Numba imports: array helper source generation still has the previously documented eager import. No shared Python/package changes or native ABI changes were made.
