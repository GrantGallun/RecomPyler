# Item 3 accepted result (S30)

Frozen numeric-final-v2 passes 810 tests and 131 subtests in 521.00 s, with source/test manifest unchanged. Independent source review covers guards, true MIXED tags, effects/constructor provenance, exact integer results, 2**53+1, signed zero, division/errors, later writes, boolean dominance, exact decorator serialization and the required recursive wrapper ABI repair. The final cohort has 120 fresh validated cells, ten actual alternating baseline/after pairs per kernel plus rotating C placement. Every output and exact selected AOT-count map matches, with no JIT/fallback/missing selection/batch.

| Kernel | Scalar baseline ms | Numeric ms | C ms | Median paired saving ms | Paired bootstrap 95% ms |
|---|---:|---:|---:|---:|---|
| fannkuch | 15.01070 | 14.79225 | 12.32874 | 0.21190 | -0.11185, 0.73555 |
| scimark | 1.43925 | 1.45290 | 0.42868 | -0.02525 | -0.07820, 0.05315 |
| barnes_hut | 35.39400 | 35.07380 | 9.17757 | 0.01085 | -2.52720, 2.45995 |
| raytrace | 3.15320 | 2.87755 | 0.60582 | 0.25585 | 0.21160, 0.35140 |

Predeclared median-paired bootstrap criterion accepts: ray 0.25585 ms (8.0677%), 95% [0.21160, 0.35140], all ten pairs positive (descriptive exact sign-test p=0.001953). The difference of separate medians is 0.27565 ms; it is not the primary paired statistic. All three controls have intervals crossing zero. No further R7 optimization is authorized or performed.

The 0.8883 ms historical rung is not available after scalar replacement in the same form. Wave13 compared original arena/MIXED native-only code with an entire graph regenerated as fixed-FLOAT, before R8; current R7 versions guarded function bodies after R8 while preserving MIXED arena tags, checked miss bodies and same-width payload/tag ABI across joins. Logical predicates fall 4,399,585 to 431,538 (90.19%) for development savings around 0.17 ms and final accepted paired savings 0.25585 ms, 28.80% of that historical conditional rung. Well-predicted branches are a hypothesis, not measured evidence. Remaining tag storage/transport and call/representation work will be retimed in S30's current-source ladder.

Reach uses explicit units: fixed 49 saved selections have four native workloads; R7 emits versions in raytrace and Barnes only, with no new selection in the other 45. Ray emits 31 typed/clone contexts (16 generated inference functions mapping to 13 actual Python functions), Barnes three versions in each of two seeds (three actual Python functions), total 37 emitted contexts / 16 Python functions / two workloads. Separately gated checked-IR counts enter 17 ray fixed contexts in ten Python functions, 769,259 fixed entries. Barnes inner-version entry weights are not measured. Fann/FFT use the lift backend and contain no MIXED fields; seven direct ray and three Barnes MIXED fields plus nested colour channels remain stored as MIXED.

RULES.md F4 is now usable guarded-kind analysis; R7 is built with F1/F4/F5, accepted paired gain, corrected bound and the reach units above. Evidence: item3-accept-summary.json, item3-accept-analysis.json, raw/item3-accept; item3-s30-full-suite.stdout, numeric-s30-suite-ok.json, numeric-final-v2-source-test-manifest.json; item3-version-implementation-review.md; numeric-numeric-final-v2-remaining-counter.json; item3-final2-selected-reach-49.json and item3-live-reach-units.json. Prior failed/intermediate results remain intact and superseded, not pooled.
