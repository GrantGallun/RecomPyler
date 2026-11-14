The fresh saved-a9b versus combined578 study has a mixed result: **Barnes improves6.11%kernel time, while raytrace regresses7.05%**. Barnes35.1749 to33.0258ms has nonoverlapping five-process ranges; raytrace3.6208 to3.8761ms is slower in every paired sample, with a small overall range overlap. Whole-process medians fall3.04%forBarnes and0.55%forraytrace; the rayprocess ranges overlap. All correctness/state/mode checks pass. No universal speedup follows from these two explicit forced targets.

Baseline current=a9b59be60cdf568c8f6b63442e7efa88fd16fdd2; candidate final=57835fa8a89d0d846e291abc7f9f6f335aa272a8. Onlyheap.py changes, SHA672ea7eee61ed5768d9e22750f713f0bafafb0a059c17ab4d6c172a8c697d2de to9eb440c9bcbf3683411a78af706f05a1ba44bae2228d484b9df8aaea6bebe4fa. Both retain guarded supportpyd17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0. ManifestSHA256d058c448e449e26f405b9f1d5f508291ab61227500d9e6b9a66e564ea57d2806. All4profiles/builds,40timingchildren,6stateaudits,4warmups and4maps are fresh; no historical profile/latency/artifact reuse or pooling.

|Case|CP kernel ms|C kernel ms|Saved a9b kernel ms|Combined578 kernel ms|Saved/combined process ms|Saved/combined kernel time over C|
|---|---:|---:|---:|---:|---:|---:|
|barnes_hut|514.966200|9.088755|35.174900|33.025800|483.7466/469.0332|3.8702x/3.6337x|
|raytrace|158.051400|0.604391|3.620800|3.876100|399.6874/397.4985|5.9908x/6.4132x|

|Case/source|Five fresh kernel samples, ms|
|---|---|
|barnes_hut current|35.0776, 35.1749, 35.5829, 34.9435, 36.3557|
|barnes_hut final|33.0258, 32.8234, 33.1264, 32.7477, 33.1943|
|raytrace current|3.7948, 3.6151, 3.6208, 3.6102, 3.6481|
|raytrace final|3.8761, 3.7885, 3.9312, 3.9644, 3.8322|

Barnes baseline range34.9435-36.3557ms versus candidate32.7477-33.1943ms; current/candidate speed1.065073x. Ray baseline3.6102-3.7948ms versus candidate3.7885-3.9644ms; current/candidate speed0.934135x. Allfive raypaired differences are retained. No extra repetitions, favorable subsets or reruns were selected. Shared hostload remains uncontrolled; five repetitions do not provide a formal significance or universal workload claim.

Kernel values are medians of five rotating fresh-process bests: Python/RPbest-of5freshstates versus Cbest-of20. Actual timing entrycounts cover all5states perPython/RPchild, not merely the best state. Complete-process Cwork counts differ, so Cprocess-wall ratios are not kernel ratios. Barnes retains200particles/100advances and finalenergy inside its timer but outside the selected region. Raytrace includes freshCanvas/Scene allocation and rendering; Callocates its outputbuffer outside its innerloop. Original absolute drivers, numerictypes, algorithms, Csources/binaries/checksums/flags are unchanged. RP AOT is generic; CClang21.1.6 uses-O3/-march=native/-ffp-contract=off, an unmeasured target difference.

All40timing outputs match finite unchanged oracles. Each source executed2500successful timingAOTBarnesentries plus25raytraceentries:5050total,zeroJIT/fallback. Six separate fullstate audits pass: Barnes all100numeric/type/alias checkpoints and full initial/final1400scalarvectors; raytrace all30000RGBbytes, type/typecode/itemsize/dimensions and original mutablearray identity. Separate202auditAOTentries reconcile exactly to product counters,zeroJIT/fallback/rejected/unknown and noNumbaimport. Internal recursive calls are not added to entrycounts. Cretains its finite checksumoracle, without a new fullbyte observer.

All58records succeeded with0timeout/failure. Costs excluded from headline latency: profiles188.480s; compile-onlywarmups2.723s; stateaudits2.674s; address-onlymaps0.683s. Childwalltotal222.617s. Combined profilecost includes capture/verification/JIT/AOT/startup probes, with no invented isolated buildtimer.

The candidate combines recursive-context packing and proof-bounded native list iteration. This cohort cannot attribute the Barnes gain or ray regression to either patch individually. StaticAOT/Cinspection belongs to the independent reviewer and cannot override measured regression or turn staticinstructioncounts into cycles. The prior full49paireddefault cohort is immutable and remains a different a9b measurement; no new578defaultcoverage/process claim was measured here.

Allsource/runtime/packages/environment/13helpers/shim/originalinput/bytecode/AOT identities passed before/after. SOURCE/driver origins are checked in freshprofiles and audits. Selectedactualexport PE hashes/RVAs are mapped from successfulaudits, not inferred from exports or profilingJIT; fouractualselectedPEs and generatedevidence are copied under selected-aot/results/<program>/<source>. Source/native/C/drivercopies are under inputs/results, indexed by ARCHIVE-INDEX-results.json, with per-source destinationlabels and collisionchecks. ARCHIVE-VERIFICATION-results.json checks58rawstdoutrecordhashes/copies and separately captures all58stderrhashes because the inherited frozen recorder storesstderrbytes without hashfields.

SESSION-VERIFICATION.json confirms coordinator2721exit0, allfrozenchecks/all58valid and no owned measurementPythonprocesses; CPUreleased to root, with no additional cohort/probe/test. An initial broad processinspection matched its own PowerShellwrapper text; constraining to actual Pythonmeasurementprocesses resolved that metadatafalsepositive, with no process/product mutation or benchmarkrerun. Reviewers were notified only after actual audits/maps were available. Allrawsamples,processwalls,counts,statevectors,exits,stdout/stderr,costs,source/runtimehashes and mappings are preserved.
