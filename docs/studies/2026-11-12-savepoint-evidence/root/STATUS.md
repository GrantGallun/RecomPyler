# RecomPyler integration and measurement status

## Paused at user savepoint: full held-out and list-address work

User explicitly stopped work for the night. Latest sourcea9b59be60cdf568c8f6b63442e7efa88fd16fdd2 is reviewed, locally integrated and frozen:572tests+52subtests passed336.93s,22warnings,all58source/test/nativeinputsunmodified. Guarded nativebinary17e2e43.../capability1 copied into isolatedintegration; olderbinaries safely usePythonpacking. All team-owned executions ended; no further tests/builds/profiles/timings/probes queued. Read `integration/docs/studies/2026-11-12-savepoint.md` and `WAVE8-PLAN.md` on laterexplicitresume. Final latest-sourceperformance NOTRUN; newnative/results-final andstudy/results-paired-final absent. Work is paused, not a completed finalmeasurementclaim.

Earlier milestones in this wave follow; the paused state above takes precedence over historical scheduling notes.

Wave8 initial full current-vs-CPython cohort is complete:49freshprofiles/490timings/245audits/98warmups/1preflight allpass,883records independently verified. Fixed38heldout (37meaningful) remains0native, processspeed0.965119xCP (3.61%longer);9tuned1.253317x,4nativeprograms/2020AOT0JIT/fallback. Separate2additions0.987946x/0native. Initialrawstudy cleancommit8a082b2, reportwave8-study/RESULTS-current.md, no historicallatencypooling.

Product411624630f818bc548a3183e3a25cecf13116640 contains three separate reviewed changes: one-plan/lazy plain startup; correct list AugAssign reindex after RHS effects; proved nonnegative physical list headers/itemslots while preserving logicalnegativeindices/bounds and signednullabletuplepayloads. Frozen full522tests+52subtestspass303s/22warnings; separateAOTrepairprobe8success+2expectederrorfallbacks,0JIT/noNumba,bothloaders. Integrated into isolatedbranch162ef01 (currentdocsHEAD0c29f190),55trackedsource/testbytes and56frozeninputs exactlymatchworker after3newtestnewlinealignments. Source/testbytes frozen; no new product changes needed.

First411native/C cohort is COMPLETE/archived1f952f1:40fresh timings/4profiles/allstates+maps pass,5050timingAOT0JIT/fallback. Barnes36.3475→36.2738ms;ray3.9311→3.8272ms,overlappingranges/no firmgain;raywholeprocessregressionretained. Actualforce341→339 only: signedlen-header vsunsignedgetitem breaksCSE. Newwave8-header-fix's2-site SAMEPROOF ListT/ArrT len/truthcastsfixactualLLVMshapeuses/CSE, but19newcases18pass/1inheritedfreshalias-writebackFAIL. Reproduced411bothloaders; no falseGREEN. Rootauthorizedseparatelistcanonical-contractguardbothPython/Crecursive loaders+newCcapability/oldpydsafePythonpackingfallback; workerCPUownsdiagnostics/build/tests/newfullsuite. ObjectclassguardreorderonlyifconcreteRED/review. Old411/source/binary/cohortsimmutable. Existingpairedcc7718 UNUSEDmetadataonly/0processes,notfinal. Futurefinalsource+newpydrequiresNEWnative/results-final andstudy/results-paired-final allfreshcohortsafterfreeze/gate. Userdirtycheckout/ref939stilluntouched. WAVE8-PLAN.md is liveledger. No pushes/current-branch merges.

## Latest complete: compact recursive calling convention

Final integration is `93986c89a5b5` with production `a033ca14c40afed052a6266a0a575f6cc11559ea`; independent raw study `f087533ec047216fd4f7dccea0286e03f45c1628`. Recursive heap-region internal calls now borrow four typed pointers plus length, while the public adapter and Python contracts remain. Full suite recorded 465 tests plus 52 subtests passed; final actual-recursive fixture assertion refinement passed separately with unchanged product. Independent code/data/assembly reviews clear.

Fresh unchanged Barnes medians: current 47.4918 to candidate 35.8288 ms (24.56% less, 1.326x); C 9.115458 ms, gap 5.210x to 3.931x. Candidate 15.41x CPython. Whole-process 559.6180 to 511.8625 ms (8.53% less). Twenty timing processes/5000 AOT calls, 1200 phase AOT, 200 state AOT and 48 generality-control AOT; zero JIT/fallback. All 100-step numeric/type/alias checkpoints and full vectors match. Force assembly 524 to 341 static instructions; 29 to 6 outgoing stack slots; local reservation 488 to 280 bytes (C116/0/88). Remaining kind/exactness checks, status/depth, handle layout, boundaries and generic CPU policy documented without cycle attribution. Cold preparation increased; no universal C-parity claim.

Report `integration/docs/studies/2026-11-11-compact-abi.md`; 463 exact evidence captures plus manifest, all committed hashes independently verified. Entire 392-file raw study is included. Final 52 source/test files match frozen worker bytes exactly, zero newline adjustments; integration clean. Both local integration refs updated to the final commit. Original current branch, HEAD, index and working changes verified unchanged; nothing pushed or merged into that branch. `wave7-completion-verification.json`, `wave7-final-integration.json`, `wave7-final-source-check.json` and WAVE7-PLAN.md retain receipts. No owned jobs remain. Do not rerun completed studies absent a concrete new issue.

## Latest complete: native-cost experiments and zero-integer proof

Final integration is5d0fe52 with production9ff4908. Full441tests+52subtestspassed; independentreviewclear. Manual controlled six cases reduced46.5740→29.7802ms (36.1%lesstime, still3.274xC) with float-type contract plus grouping4; this is not shipped semantics-equivalence or default-deployment evidence. Actual production rule proves zero-only integer cases from code and removes8of14force exactness references, preservesflags/layout/ABI, but paired unchanged-workload performance showedNOgain47.2972→47.4359ms (overlapping), walls530.8935→540.1634ms. All60timings,16250timingAOTcalls,3900phaseAOTcalls and650stateAOTcalls passed with0JIT/fallback; checkpointnumeric/types/aliasesvalidated. New reportintegration/docs/studies/2026-11-11-native-costs.md;101hash-verifiedarchivedfiles. Independentrawstudycommits1205c60/187f331. Actualassemblyidentifies29outgoingstackargumentsforrecursiveheapcalls asnextunquantifiedcosthypothesis; Cnarrowinterface/theta0.5andnativeCPUvsRPgenericdifferencesdocumented. Originalcheckoutpreserved, localintegrationrefupdated, no push. No jobsremain. WAVE6-PLAN.md COMPLETE; do not rerun finished studies.

## Latest complete: nonnegative object-field indexing and development tools

Final integrated branch is0aeb157, with e35dce1product and bc8db62+dc4c9f9tools. Complete compiler405tests+38subtests and18tooltests pass; independentreviewclear. All9matchedworkloads,18freshprofiles,300timings42audits andboth600-AOTphasespassed. Barnes49.0671→47.4893ms ordinarykernel (3.22%lesstime), nativeentrydiagnostic31.4393→27.4435ms; still5.21xCtime. Raytrace/floatmodestgains, basicRichardsregressionretained, unchangednbody/mixedFFTcontrolslabelled. Nativefrontendcoverageunchanged; inheritedtupleidentitylimitationdisclosed. Tools diff/asm/c/phases/caseshaveactualfile/AOT/casesmokes. Fullreportin integration/docs/studies/2026-11-11-heap-index.md with92hash-verifiedarchivedfiles; independentrawstudycommit57e8000. Integrationclean, sourcebytesmatchtestedworker, originallocalintegrationrefupdatedwithbranch/HEAD/index/workingchangespreserved. No ownedjobsremain. `WAVE5-PLAN.md` is COMPLETE; do not rerun historicalstudies. Nothingpushedormergedintousercurrentbranch.

## Latest: fresh-process reuse and complete rerun

Final product source is `0d2c3d33215f7c289b89944214d4c7b8eaf9ac89` on `codex/integrated-coverage`. The complete suite passed **383 tests plus 38 subtests**, with ten warnings and no failures/skips. Broad and scoped independent reviews cleared the fixes; the rebuilt real Richards native gate passed four clean processes and both loaders.

The new fixed study compared a fresh `dba45a7` baseline with the candidate: all 98 profiles, 735 latency processes and 490 separate audits succeeded. Short held-out native deployment remains zero; speed is 0.958756x CPython versus 0.959742x before. Tuned nine measured 1.294033x CPython versus 1.289856x, with 2,020 candidate AOT calls and zero JIT calls.

The predeclared longer Richards_super diagnostic now records **100 AOT calls, zero JIT and zero fallbacks**, versus 100 Python fallbacks before. Median complete-process time is **0.382138 s**, versus Python 0.689172 s and prior plugin 0.974361 s: **1.80346x Python and 2.54976x the prior plugin**. Profiling/building is separate and remains substantial. Chaos did not improve.

Fresh matched C comparisons for both sources and 42 mode audits are complete, with all check values matching. Candidate warm kernels take 1.14x C time for nbody, 1.40x for float and 1.92x for fannkuch. Object-rich kernels retain larger gaps; fallback rows remain labelled Python. The basic Richards explicit warm diagnostic still uses JIT, distinct from the default held-out Richards_super AOT result.

Reports and compact evidence are committed as `3f0370d5fe5c358b4a0b3fd8e1ea10a2f22f87bf` in integration/docs/studies/2026-11-11-fresh-process-reuse.md and its adjacent reuse-evidence directory. Both repositories' integration branch refs point to that revision; the integration checkout is clean. Product bytes match measured/tested source0d and all 40 committed archive hashes verified. All measurements are finished; no benchmark/test/compilation jobs remain. The first afd09b0 attempt remains immutable stopped partial evidence. The original current branch, HEAD, index and working changes were compared before/after the safe ref update and preserved. Nothing was pushed or merged into the user's current branch.

## Earlier integration wave

The continuation is complete on local branch `codex/integrated-coverage`. Full feature snapshots and correctness fixes are combined; cross-drive AOT build failures are resolved. Final runtime source is `ee03841`, identical in source/tests to independently reviewed worker `43836db`: **323 tests and 38 subtests passed**, no failures or skips.

The corrected study completed 49 profiles and 735 fresh timing processes at `dc02b95`. Held-out fixed population remains 38, with 37 meaningful timing pairs: CPython/baseline 0.901x and CPython/integration 0.974x. Mean largest verified opportunity increased 0.487% to 3.192%, while default held-out native calls remained zero. The nine tuned programs measured 1.176x CPython overall. Baseline profiles were reused with validated provenance; latency measurements were fresh.

Native C diagnostics, warm-bytecode controls and the predeclared longer-workload cohort are complete. Fresh-process AOT layout instability was diagnosed; the final runner reports execution mode honestly and avoids unbudgeted JIT on default AOT-only misses. These runner changes were validated separately after the full study, not hidden under its revision.

The final report and compact evidence are in [integration/docs/studies/2026-11-11-integration.md](integration/docs/studies/2026-11-11-integration.md). Raw evidence remains in `wave2-study` and `native-study`. The original working checkout and its uncommitted files remain untouched; the integration branch is available in the original repository. Nothing was pushed or merged into the user's current branch.

The historical first-wave record follows.

# First-wave record

Three workers ran in parallel, with a coordinator and an independent reviewer. Work is isolated under this directory. Original RecomPyler checkouts, earlier coverage worktrees, and shared Python installations were not edited by this team.

| Track | First-wave result | Commits | Verification |
| --- | --- | --- | --- |
| Containers and calls | Empty dict/set membership preserves hashability errors and executes preceding effects once; updated obsolete string-coverage expectation | 2582070, 05e6d46 | 95 relevant tests and 16 subtests passed; corrected CLI test passed |
| Generators | Failed generator calls and uncopyable yielded values are discarded instead of saved as successful partial verification samples | 14127e3 | 36 monitor tests passed; full suite 192 passed, 2 inherited failures, 1 skipped |
| Runtime and hardware | Rejected batch plans execute original source without unused readiness checks; confirmed CPU and CUDA availability | 94e898f | 55 relevant tests passed, 1 skipped; full suite 188 passed, 2 inherited failures, 1 skipped |
| Coordinator: dataflow + NumPy/random | Imported existing boundary commits into the dataflow copy; fixed repeated array effects on fallback and heap-growth retries | f2dcefe, 48fdfca, cbf5bde | 30 boundary/array tests passed; full suite 224 passed, 2 inherited failures, 1 skipped |

The runtime example produced identical results while readiness calls dropped from three to zero. No timing speedup is inferred from that structural check. NumPy rollback currently copies writable inputs for kernels that emit stores; this preserves semantics at additional cost. Read-only kernels avoid these snapshots.

The two recurring failures are existing ahead-of-time build errors caused by cross-drive source paths in distutils, which attempt to create directories outside the workspace. Moving temporary files locally reproduced the same bug at a different path. No shared compiler/package change was made. Full suites are not claimed clean. Containers initially had an additional stale CLI assertion; it was corrected and passed in a focused rerun.

Independent review completed with no actionable findings in the four small deltas. Six additional NumPy probes passed across both loaders, checking reversed strides, zero-stride overlap and cross-dtype aliases. Broader inherited feature implementations and performance remain outside that verdict.

## Evidence

- [Shared requirements and ownership](COORDINATION.md)
- [Containers report](REPORT-containers.md)
- [Generator report](REPORT-generators.md)
- [Runtime and CPU/GPU report](REPORT-runtime.md)
- [Coordinator report](REPORT-integration.md)
- [Independent review](REVIEW.md)

Each named directory is a standalone Git snapshot with the inherited uncommitted feature work preserved. The numbered commits above contain this wave's deltas. Original source revisions and file hashes are recorded in the `*-snapshot.json` manifests. Review packets are in `REVIEW-*.txt`.

## Next work, in order

1. Combine inherited container, generator, boundary and runtime support incrementally. A trial container import into the boundary/dataflow copy exposed broad overlapping changes and was aborted; no unresolved merge remains.
2. Resolve the existing AOT cross-drive source/build path bug without changing shared Python packages.
3. Rerun the same held-out programs against a fixed baseline, recording verified runtime share, actual end-to-end time, Python fallback cost, and output/effect equivalence. Retain the tuned nine as regression guards.
4. Address remaining language blockers using that evidence, prioritizing generator/argument/container support over optimizations that ordinary programs cannot reach.
5. Measure CPU/GPU batch dispatch, packing and transfer costs on independent numeric workloads. Available hardware: Ryzen 7 9800X3D (16 logical CPUs) and RTX 5080 with usable CUDA. Hardware availability alone establishes no performance gain.

This wave improves correctness and rejects avoidable runtime work. It does not establish new aggregate held-out coverage, near-C performance, complete Python coverage, or performance neutrality for all programs.
