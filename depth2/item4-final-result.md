# Item 4 accepted owner rule

Frozen owner-v1 passes813tests/131subtests in502.66s and120fresh exact-output/exact-AOT/noJIT/noFallback cells. No source or test hash changed after freeze. The independent source review and36focusedunion tests cover equal physical extents, actual F2/F3 certificates, kind/alias/iterator/captured-method/dominance exclusions, same-iteration earlier status failure and later IndexError. Eight cleanup paths each execute40actual native attempts with valid compiled signatures; native allocation and meminfo balances remain equal on normal, early, real guard-miss and error exits.

| Kernel | Numeric baseline ms | Owner ms | C ms | Median paired saving ms | Paired bootstrap95% ms |
|---|---:|---:|---:|---:|---|
| fannkuch | 14.67965 | 12.84420 | 12.31885 | 1.82905 | 1.77255, 1.91060 |
| scimark | 1.41710 | 1.42020 | 0.42772 | -0.00640 | -0.03280, 0.02090 |
| barnes_hut | 33.83610 | 33.83625 | 9.15825 | -0.27240 | -0.63325, 0.44620 |
| raytrace | 2.86415 | 2.89865 | 0.60570 | -0.00080 | -0.09005, 0.10815 |

Acceptance: median paired fann saving1.82905ms/12.4578%,95%[1.77255,1.91060],all tenpositive,90.81%of fresh2.0141msbound (96.97%of historical1.8862ms). No control is resolved slower. The paired statistic differs from the difference of separate medians; neither statistic is pooled with the three-pair bound/development cohort.

R4 queries existing private fixed-list and dominating-initial-owner facts, proves equal stable nonnegative permutation extents and int64 kinds at the actual full-copy site, then emits void copy_into only under shared guards. Initial owners and ordinary cleanup remain. The selected native fast-loop CFG has six to zero NRT incref/decref sites; its only remaining cyclic calls are llvm.smin/smax/memmove. Two noncyclic cleanup blocks retain four decrefs each (three private arrays plus status), and checked-fallback cycles retain six NRT sites. This is complete hot-loop owner elimination for the selected fann kernel, not global NRT suppression. True native cleanup tests cover failure/replay and exit paths separately.

Fixed49saved selections: actual R4 reach is one site/one Python function/one workload (fannkuch); all four native controls are measured, the other45have no selected region. RULES.md marks R4built and F3/F9usable for this site-specific contract; region-wide failure freedom remains unknown.

A source-only reach-unit normalization also corrects R8 terminology without changing gains: thirteen typed allocation contexts/twelve inference-function contexts correspond to ten distinct original Python allocation sites/nine Python functions over ray+Barnes. Ray has twelve typed contexts but nine original sites/eight Python functions: four typed Vector.scale contexts share one constructor callsite; Scene.render has two distinct Ray sites. Accepted ray451466/Barnes100removals and two-workload reach are unchanged. Existing prior reports remain intact; scalar-reach-python-normalization.json and independent accepted-evidence-review.md explain the corrected units.

Evidence: item4-accept-summary.json, item4-accept-analysis.json,raw/item4-accept; item4-final-full-suite.stdout,owner-final-suite-ok.json,owner-v1-source-test-manifest.json; owner-loop-llvm-audit.json,owner_loop_audit.py; owner-current-bound-summary.json,owner-current-bound-decision.json; owner-current-implementation-review.md,accepted-evidence-review.md; item4-selected-reach-49.json and owner-current-green3.log. All code is strict; no manual NRT removal enters product.
