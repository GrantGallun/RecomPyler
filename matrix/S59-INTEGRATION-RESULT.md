# S59 integration measurements

Merged source combines wave19 `1eb3ac55` with the Unicode ownership frontend. Three alternating whole-process pairs at 20 loops used `claude/bench.py --reps 3 spectral_norm scimark`, fresh caches and the ordinary profile/deployment path. Outputs matched and every deployed call stayed native. Raw command output: `claude/s59-programs.log`.

| Program | CPython median s | RecomPyler median s | Speedup | PyPy 20-loop speedup |
|---|---:|---:|---:|---:|
| spectral_norm | 1.479 | 0.450 | 3.29x | 3.40x |
| scimark | 10.496 | 1.365 | 7.69x | 11.91x |

The timing lock was held for this development cohort. Concurrent correctness jobs were alive; these are the observed figures, used without a disturbance rerun under S58. PyPy figures come from `../pypy-compare/JOINED.md`.

Two ten-minute-mode differential runs exhausted their inventories: 12 dedicated S59 subjects (117 native trials, 749 checked declines, 286 resource exclusions) and 23 extracted region tests (125 native trials, 1,357 checked declines, 519 resource exclusions, 17 unchecked). Both found zero mismatches and zero worker errors. Extension-array arguments remain outside the generic graph oracle; the executable region tests cover those inputs. No new implementation review is required for this merge.

Unicode's separate committed-source reports confirm matrix 244 native / 772 declined / 0 wrong / 0 crash and held-out 194 captured / 57 verified and native / 0 deployed. The preceding cohort was 59 native; two conservative text guards withdrew chaos.GVector.__add__ and sqlite_synth.AvgLength.step. Both scalar positive regressions now pass: ordinary str/bytes class names no longer imply runtime text production, and identity against None does not merge text owners. Actual text-to-text identity and converted graphs remain refused.

Validation: the one merge union finished 3,005 passed / 29 failed / 4 xfailed / 131 subtests. Its two changed pins were updated from actual executions; the runner now exports absolute PYTHONPATH to children, and the builtin isinstance collision is corrected. The 29 failed cases plus heap text admission pass in one focused follow-up (37 passed); all original union failures are cleared. Catalogue-sibling discovery and safe time imports have two fail-first regressions and 31 passing fuzzer tests. Final text fuzz: 96 subjects, 1,287 native trials, 7,294 exact declines, 13 construction declines, 11 resource exclusions, zero mismatches or worker errors. Current executed pins are 254 native / 772 declined across 1,026 rows.
