# S41 trivial complete-call cost bound

One diagnostic pass on current WIP53503698, with 128 warmed calls and all exact results/native completion counts: `s41-trivial-components-v1/complete.json`; root receipt exit0. The ordinary alternating complete-call median in the same child is **7.027760 us** versus **0.053884 us Python** (prior accepted Step1 context:7.673212/0.055112us).

The following instrumented exclusive buckets are sorted by cost. Scope/context-manager overhead is retained. Their sum is the **instrumented** call, not a decomposition whose numbers add to the7.03us uninstrumented call; they establish where work runs, not removable causal savings. Nested lifetime/allocation checks performed in the native guard remain inside guards.

| Component | Instrumented us/call |
|---|---:|
| Residual attempt bookkeeping |13.399219|
| Argument/object conversion and loader |6.532031|
| Argument binding/import/code metadata |3.287500|
| Cached program selection envelope |2.586719|
| Control writes |1.927344|
| Staged payload copy |1.635938|
| Wrapper dispatch and outer observer |1.585156|
| Reusable arena retrieval |1.552344|
| Unloader construction |1.508594|
| Guards, including native lifetime/allocation checks |1.475000|
| Result preparation |1.361719|
| Recursion frame scan |1.317969|
| Writeback |1.026563|
| Native call |0.945313|
| Result conversion |0.867188|
| Array snapshot branch |0.595313|
| Arena capacity branch |0.557813|
| RNG export branch (no export occurs) |0.545313|

Warm latest-program selection performs no dictionary search already. The field/comparison trivial input still requires the graph loader until Step2 supplies live layout/token access. Scalar-only graphs can avoid it using all-intermediate primitive types and transitive effects; read-only primitive-result graphs can avoid unloader/writeback, and acyclic graphs can avoid frame scans. No timing here proves the full loader cost removable from a field reader. The existing six-region and kernel tables in bounds/STEP1-BOUND.md retain their original source and observer scope.
