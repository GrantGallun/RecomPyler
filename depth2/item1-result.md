# Item 1 acceptance: shared guarded ranges

The accepted rule replaces checked integer operations and logical indexing only where the shared FunctionFacts certificate supplies every intermediate range and stable extent. Per-function entry guards select a fast body; the existing checked body remains the fallback. Guards constrain signed integer domains, positive/even/power-of-two extents, array rank/length and direction as needed. No profile observation alone authorizes a rewrite.

The FFT butterfly relation is `b <= n-2*dual`, `a <= dual-1`, with `dual` doubling from one and dividing guarded power-of-two `n`. Substitution from inner symbols outward proves `2*(b+a+dual)+1 <= 2*n-1`. The inspected exact logarithm summary is source based, not a function-name special case. The first geometric implementation supports admitted doubling/left-shift forms; shrinking induction and arbitrary factors remain unknown.

Fannkuch content is proved from private `list(range(n))`, full copy, prefix reversal and rotation. Other writes or resizing invalidate the certificate. Its endpoint-tested unit induction establishes `1 <= r <= n`. Every unchecked access has a nonnegative logical-index proof; rollback never substitutes for memory safety.

## Measurements and limits

`item1-accept-summary.json`: 10 rotating fresh processes per step0/item1-dev2/C row, all four kernels, 120 valid cells. Original best-of-five Python resets and best-of-twenty C drivers are unchanged. Exact per-function AOT maps, output checks, no JIT/fallback/missing selection are required per cell.

- FFT: 2.095700 -> 1.403800 ms; save 0.691900 ms / 33.02%. This is 99.0% of the historical conditional 0.4354+0.2634 ms numeric/bounds sum. The separate multiply 18.6% bound overlaps; it is not added again.
- Fannkuch: 17.863400 -> 14.550250 ms; save 3.313150 ms / 18.55%, 91.1% of the historical 3.6375 ms checked-control rung.
- Heap controls have no resolved effect. In the short ablation Barnes step0/item1/noheap medians are 33.2435/32.9494/32.6370 ms; raytrace 3.4185/3.5187/3.4520 ms. These are below the established 5–6% floor, with byte-identical native heap modules, not evidence of proven neutrality or a regression.

The full acceptance measured frozen `product-sources-v2/item1-dev2`. The later lazy heap Facts property preserves the old execution-program attribute layout and native heap source. The later captured-bound-method rebind exclusion closes an independently found existing eligibility defect; it declines rather than retargeting a hidden owner. The final-source suite and S20 three-pair four-kernel confirmation are recorded separately, never pooled with acceptance samples.

## Reach and remaining checks

`item1-selected-reach-49.json` enumerates all 49 fixed saved selections: four programs deploy native entries, and R5/R6 fire in two of them. The other 45 have no selected native region, not new rule deployment. No coverage-selection change is made here. The static inventory has candidates in 22 workloads; that number is potential applicability only.

Native generated reports: R5 has 44 AST sites in five functions (FFT 38, fannkuch 6); one unary constant site was already constant-folded, so 43 sites represent possible dynamic work. R6 has 30 sites in four functions (FFT 21, fannkuch 9). Leaving out FFT leaves six R5 and nine R6 sites. These are compile-site counts, not executed machine instructions or timing attribution. `item1-reach.json` records every contributing function.

`item1-remaining-checks.json` lists every unique retained helper expression. FFT bitreverse j/k carry arithmetic and dependent j accesses remain checked; their relation to the outer counter is unknown. The butterfly removes all 16 indexed AST sites; typed float arithmetic already lowered raw and is not claimed as new gain. Fannkuch retains flips_count increment and count-element decrement checks because no value-growth/content range is proved. Status polls, general range helpers, entry checks and the checked fallback remain. No separate R5-versus-R6 causal timing claim is made.

## Validation and review

- Step0 integrated commit 4d5ef903 reproduced with 733 tests and 131 subtests.
- Reviewed range implementation: 27 analyzer tests, five native product tests including full FFT byte arrays, signed zero, invalid extent/power/direction, fannkuch sizes, unsafe intermediate cancellation and multiple guarded helpers.
- Item1-dev2 full suite: 765 tests and 131 subtests. See `item1-full-suite.log`.
- Every independent counterexample was first retained as RED evidence and then corrected; rejected draft1 stopped before any timing. See `item1-independent-review.md`.
- Captured method rebind regression is RED in `owner-alias-red.log`, GREEN in `owner-alias-green.log`, independently source-reviewed in `owner-design-review.md`.
- Final-source validation is in `item1-final-full-suite.log` and `item1-final-summary.json`; the RESULT checkpoint records their completed outcome.

Final-source completion: `item1-final-full-suite.log` passes **766 tests and 131 subtests**. S20 final-source three-pair four-kernel medians (step0/final/C ms): fannkuch 17.8315/14.4599/12.116909; FFT 2.0603/1.4202/0.428200; Barnes 33.5789/32.6836/9.090424; raytrace 3.4683/3.4316/0.602961. FFT/fann final medians differ from the ten-pair acceptance candidate by +1.17%/-0.62%, below 6%, so no second ten-pair cohort is needed. Generated FFT/fann source is byte-identical between dev2/final; both heap module bodies remain byte-identical by construction and source identity checks. No control neutrality claim is made.
