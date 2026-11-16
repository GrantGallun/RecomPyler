> SUPERSEDED: S31 / CHECKPOINT18 reopened Step0. This is verified candidate evidence; acceptance requires matched frozen-coverage comparison, prepared-AOT cache if regressed, newly authorized depth commits, and final gates.

# Accepted integration evidence

Final-source gates complete; coordinator commits this step before Step1. Source variant: integration-cache.

Inputs: exact depth history through d86f4e3cc1f630497c376e2773faa0782730d10c and frozen coverage stages/item1-s23-final2 on087c0dd. No later depth commits or live coverage edits were imported. integration-inputs.json seals the mechanical merge.

Union suite:949 passed,131 subtests,10 warnings in336.76s; final command exit0. The initial merged suite had908 tests/131subtests; added origin3, scalar-identity18 and structural-cache20 cases explain the41-test increase. Existing tests were retained.

Final ten alternating fresh-process pairs, whole-kernel ms (each child reports minimum of five full resets):

| Kernel | Depth | Integrated | Median difference |
|---|---:|---:|---:|
| barnes_hut | 33.373700 | 34.137950 | +2.29% |
| fannkuch | 14.587800 | 14.651700 | +0.44% |
| scimark | 1.394900 | 1.406000 | +0.80% |
| raytrace | 3.107800 | 3.086900 | -0.67% |

No resolved regression is established by paired distributions; this is not proof of equivalence. Raytrace?s scattered three-pair medians are superseded by the unchanged-source ten-pair follow-up. Full paired samples/bootstrap intervals/exact sign-flip probabilities are in integration-kernel-pairs-v5-ten/paired-analysis.json, with assumptions stated. All exact checksums and expected AOT counts match, zero JIT/fallback/not-found/batches. Generated native source is byte-identical to depth for every kernel/export; no native speed gain is attributed to preparation changes.

Ordinary unmodified twenty-iteration smoke:

| Program | Captured | Verified | Deployed | Actual AOT calls | Plain ms | Saved ms | Plain/saved |
|---|---:|---:|---:|---:|---:|---:|---:|
| chaos | 60 | 12 | 1 | 20 | 856.914 | 714.219 | 1.200x |
| richards_super | 81 | 18 | 1 | 20 | 690.146 | 595.013 | 1.160x |

Application stdout/stderr/exit behavior is byte-exact for plain/profile/saved/audit; independent per-function actual native entries and modes reconcile with all saved children. These fresh process ratios are not a causal comparison with historical wave14 ratios from different cohorts. Both accepted coverage deployments remain available.

Integration corrections:

- AOT origin seal hashes the same unwrapped callee used for emission, retaining ordinary wrapper/code and underlying-code guards;3 fail-first regression tests.
- Conservative R8 no-Virtual identity proof retains original checked IR, call/recursion graph, F2 and decline reasons; any representable local/fresh seed keeps the full pass.18 focused tests and independent review. Richards scalar component248.116->7.841ms against approximate234.131ms budget.
- Per-analysis immutable F2 ordered nodes/parents/unparse caches retain full summary-dependent dataflow. Red1failed19passed; focused69passed; independent AST-diff review. F2 component140.667->41.4085ms against90.699-96.001ms counterfactual budget. Final combined scalar time is11.3395ms in the later cohort; total Richards compile-only preparation513.907->253.551->160.9996ms. These are separately instrumented preparation contexts, not native or process gains.

Excluded/preliminary evidence is preserved: first kernel cohort silently JITted FFT before seal correction; smoke1 disabled bytecode caching; smoke2 lost Richards deployment; smoke3 deployed but Richards saved821.934ms>plain686.170ms. None enters accepted aggregates. Kernel v2/v3 are prior-source diagnostics; v4 three-pair is preliminary, v5-ten final. No seed scheduling/live-graph probe was implemented.

Fresh final artifacts:artifacts/integration-cache; source/binary hashes:bases/integration-cache/source-manifest.json; acceptance receipts:logs/integration-*.receipt.json. Raw failed and successful evidence remains owned under inplace/.
