The fresh final paired study completed all49workloads and1423childrecords with no failure or timeout. The saved a9b source has **no native coverage expansion**: both sources execute native code in4tuned programs and0of38held-out programs. Final held-out process speed is0.967146xCPython (3.40%longer time); compared with the simultaneous current939baseline it improves0.74%. Tuned9is0.53%slower than current; the separate2additions take1.17%more time. These small five-repetition differences do not establish a broad speed gain.

This is the NEW paired-final cohort only: current93986c89a5b512ef82a33af1f101bf6f796ae61f vs candidatea9b59be60cdf568c8f6b63442e7efa88fd16fdd2. ManifestSHA256 92d2cbf74740bad09c91feb84a391928e9cef31a580df5b8af5e08e97d8a72b6. All98profiles,735timings,490separateaudits,98compile-onlywarmups and2nativepreflights are fresh. No old initial939/first411profile, latency or nativeartifact reuse. Source/runtime/package/helper/input/shim/bytecode/AOT identities passed final verification.

|Group|Fixed programs|Meaningful timing pairs|Current vs CP speed|Final vs CP speed|Final vs current speed|Actual native current/final|
|---|---:|---:|---:|---:|---:|---:|
|heldout|38|37|0.960013x|0.967146x|1.007429x|0/0|
|tuned|9|9|1.253378x|1.246752x|0.994713x|4/4|
|addition|2|2|0.979286x|0.967993x|0.988468x|0/0|

Metrics are geometric means of identical meaningful workload pairs, each using its five-process median. Python_startup remains within38profile/mode accounting but is excluded from meaningful timing because the shim does no benchmark work. Original49order/arguments/loop2/limit40/samples8/repetitions5/audits5/180stimeout/defaultunforced policy and26historicalexclusions are preserved. Sourceprofileorder is current then candidate; ordinary plain/current/candidate timings rotate order, and audit sourceorder alternates.

Only four default-runner workloads enter native code:

|Program|CP median s|Current median s|Final median s|Final speed vs CP|Timing AOT current/final|
|---|---:|---:|---:|---:|---:|
|barnes_hut|1.263710|0.391112|0.397296|3.180778x|1000/1000|
|fannkuch|0.543773|0.277128|0.280694|1.937246x|10/10|
|raytrace|0.461134|0.406718|0.406306|1.134942x|10/10|
|scimark|0.791100|0.597968|0.590359|1.340031x|1000/1000|

Both sources have2020successful timingAOTentries each,4040total,zeroJIT/fallback/batch/unknownmodes. Separate490auditprocesses independently observe2020AOTentries per source,4040total; these are separate evidence and not added to timing counts. All49programs reconcile product counters, actual modes and output/exits for both sources. Other45programs report no_selected_wrappers; zero wrapperfallback does not mean zero Pythonwork. Actual native/AOT program counts per auditrepetition remain heldout0,tuned4,additions0. Internal recursive calls and native/library work fromdependencies are outside these RecomPylerentrycounts.

Held-out recommendation reach remains0for bothsources. Largest verified candidate reach is an opportunity proxy, not dynamic native-time coverage or an overlapping-region union. Current/final held-out means are2.1269%/3.9553%, but no corresponding nativecalls deployed. Candidate-specific profiling/rejection metrics and full rankings are retained in ANALYSIS.json; they do not justify a capability or coverage improvement claim.

Largest candidate-minus-current whole-process median differences (all raw distributions retained):

|Workload|Current s|Final s|Final-current ms|
|---|---:|---:|---:|
|fastapi|10.711644|10.804572|92.928|
|mdp|1.697864|1.713669|15.805|
|decimal_pi|0.504635|0.519480|14.845|
|float|0.214464|0.226208|11.744|
|poker_selfplay|0.570143|0.576783|6.639|
|asyncio_tcp|1.121445|1.054477|-66.968|
|pprint|2.955730|2.914104|-41.626|
|yaml|0.180531|0.163199|-17.332|
|sqlalchemy_declarative|0.512867|0.502714|-10.153|
|decimal_factorial|0.472734|0.463324|-9.411|

Costs excluded from latency: fresh current/final capture-verification-JIT-AOT-startup profiles530.648/462.536s; compile-onlywarmups70.878s; separateaudits338.932s. All1423children total1905.506s wall, finishing over32.932minutes. Build-only cost is not separately invented. No failed process was retried.

The external bot tree gained one additional src_now.py, so original preparation stopped before any benchmark execution. Root approved NEW path-routing helpercopies and exact143-file archival snapshot for poker cwd/profileinclude/POKER_BOT/model/sys.path. CP/current/candidate share that same immutable snapshot; all143originalbytes, driverbytes/deals/seed and all other48paths are unchanged. Original external tree and frozen earlierhelpers/manifests remain untouched. A fresh launcher PATH tempentry differs from the initialcohort; allother PATHentries and runtime/packages match. The newmanifest freezes it and comparisons never pool cohorts. FINAL-METADATA-GATE.json/ROUTING-PROVENANCE.json/PATH-ONLY-DIFF.patch preserve every routing difference.

Only poker prints observable resultoutput; the other48entries produce empty stdout. Exact stdout/exit agreement is finite evidence, not a full numerical/object-state proof. Captured8call verification remains finite; the separate572-test saved correctness run and selected-native fullstate diagnostics provide additional evidence without changing this population. The saved native/C diagnostic separately measured Barnes36.6776 to36.3892ms vs C9.161472ms, raytrace3.9225 to3.8704ms vs C0.607729ms; its fullstate/mode checks pass. Those explicit forced kernels and their timing distributions are not pooled with this default-process cohort.

Heavy jobs were serialized. Root permitted independent bounded standard-library sourceinspection/assertions, metadata/hash/archivalI/O only during paired execution; no concurrent task-owned native/tests/builds/benchmarks. Unrelated hostload remains uncontrolled and five repetitions give no formal significance claim. CPU was released directly to recursive_context only after coordinator exit0 and FINAL-SESSION-VERIFICATION.json proved1423status0/rawstreamhashes,all49audits/frozeninventories and no owned matching process; coordinatorPID34548 was gone.

Raw plans/counters/allstdout-stderr/exits/hashes/samples/independent mode evidence and summaries are under results-paired-final. Exact source/native/compiler/input copies are indexed by ARCHIVE-INDEX-results-paired-final.json. Planned-AOT artifacts are availability evidence only: all15fresh binaries (7current/8candidate) are archived by source label to prevent same-basename collisions (observed for fannkuch/nbody); only4programs/source actually deploy nativecode. Original one-source archivalhelper was preserved and not used for this pairedcopy. FINAL-ARCHIVE-PATH-FINDING.json documents the pre-copy diagnosis. Final-only archive preparation and verification scripts preserve old evidence unchanged.
