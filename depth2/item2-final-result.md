# Item 2 accepted result

Classes a+b+c are built, independently reviewed, and accepted. Class d remains an unbuilt candidate under S26 because current receiving list/child slots require a handle on every execution. This supersedes the premature open-only item2-result.md closure.

797 tests and131subtests pass in509.28s. The frozen scalar-abc-v1 source passes120fresh cells:10rotating pairs against item1-final plus matched C on all four kernels. Every cell matches reference outputs, exact native entry counts and zero JIT/fallback calls.

| Kernel | Item1 ms | a+b+c ms | C ms | Change |
|---|---:|---:|---:|---:|
| fannkuch | 14.7336 | 14.7289 | 12.3159 | -0.03% |
| scimark | 1.4279 | 1.4334 | 0.4271 | +0.39% |
| barnes_hut | 34.7337 | 34.3549 | 9.1733 | -1.09% |
| raytrace | 3.7069 | 3.1182 | 0.6090 | -15.88% |

Raytrace saves0.5887ms (15.88%),79.32%of the conditional0.7422ms scalar rung. Barnes differs by1.09%, FFT by+0.39%, fannkuch by-0.03%: these controls have no resolved effect under the6%noise convention. In particular the Barnes point difference is not credited against the5.2134ms native-representation opportunity: removing100root bumps cannot explain that opportunity.

| Program | Baseline bumps | Final bumps | Removed | Native deployment |
|---|---:|---:|---:|---|
| raytrace |734941|283475|451466 (61.43%)| existing selected region |
| Barnes (100steps) |75348|75248|100 (0.13%)| existing selected regions |
| chaos |90521|85521|5000 (5.52%)| source-only counter, no new selection |
| float |100004|100004|0| no selected region |
| go |typed root declined|unchanged|0| no selected region |
| nbody |typed root declined|unchanged|0| no selected region |

The178494remaining ray non-instance bumps are20598list-storage/header blocks,35776list-growth blocks and122120intersection tuple blocks; numeric payloads/tags are inline, with no separate boxed-number allocation site. The other104981remaining bumps are99648Vectors from f21_scale and5333Points from f48___add__.

Across the fixed49selections, R8 changes existing native source in2workloads, at13original instance sites in12functions (ray12sites/11functions, Barnes1/1). Ray has11fully removed sites and one partially removed source cohort, not12fully eliminated sites. The emitted ray report separately contains4local source sites,29fired fresh-call contexts and12fresh-return clones; these are different units and are not added as original allocation-site reach. Direct source analysis in chaos/float/go/nbody is not new deployed coverage.

Complete ray pixels and every final Barnes particle byte match Python in the logical counter. d/e are conservative source may-capture cohorts, not literal per-execution escape probabilities. Remaining blockers include real container/child-handle stores, pointer joins, unknown returned aliases, and unsupported root typing.

RULES.md updates F2/F5 to usable lifetime/effect summaries and marks R8 built with accepted gain/reach. R8d stays candidate with the scalar receiving-container/child-slot payoff condition. Evidence: item2-accept-summary.json, raw/item2-accept, item2-final-suite.stdout, allocation-classes-ray-scalar-abc-v1.json, allocation-classes-others-scalar-c-v1.json, item2-current-reach-final.json, scalar-review.md, escape-review.md and item2-d-scope-review.md.
