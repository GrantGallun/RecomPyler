# Flat-first native selector result

Committed f8a2177f after shared fuzzer merge fd596b71. Private JIT only; default routing, AOT and deployment selection remain unchanged.

| Whole program, 20 loops | Current Lifted s, median3 | Flat s, median3 | Change |
|---|---:|---:|---:|
| spectral_norm | 0.5567295 | 0.3445062 | -38.1% |
| FFT | 0.0287759 | 0.0249037 | -13.5% |

One alternating three-pair development cohort, raw output `inplace/s56-native-shape-three-pair.txt`. Peer correctness/build/profile workloads overlapped and samples are used as measured. These are candidate measurements, not default deployment gains. All unchanged original 20-loop boundary traces matched exact result types/bits and array bytes (104,000 spectral and 2,000 FFT calls); all measured wrappers completed native with zero fallback.

| Complete call | Python us | Current us, median3 | Flat us, median3 |
|---|---:|---:|---:|
| part_A_times_u | 11.35266 | 5.12846 | 3.24708 |
| part_At_times_u | 11.63882 | 5.05316 | 3.18808 |
| FFT_transform | 1708.7380 | 13.3490 | 10.1420 |
| FFT_inverse | 1752.3965 | 14.1115 | 10.7165 |
| Synthetic one-list-item read | 0.05618 | 3.91630 | 3.16694 |

Instrumented argument/shape costs are 0.252/0.198/0.245/0.244us for those four real functions, compared with 1.1-2.1us in the preceding prototype cohort. Other instrumented costs are retained: lookup 0.137-0.172us, holder 0.358-0.439us, audit/accounting 0.666-0.889us. Dispatch/guard/native/cleanup/boxing envelopes are 2.474/2.009/9.210/10.469us, including full-buffer undo where relevant; not isolated native-body figures. The synthetic floor remains much slower than its Python call. Real target calls are below Python, allowing the bounded member increment under S56.4.

Validation: `python inplace/run_low.py s56-shape-full-suite.txt python -m pytest tests -q`, with PROVENANCE_CORPUS=tests/provenance_cases: 2668 passed, 131 subtests, 2 expected xfails, exit0. Focused protocol/shape55 passed. Accepted shared oracle ten-minute seed5614 run:159270 checked cases=30097 native+129173 declined, zero wrong/unchecked (`inplace/s56-shape-fuzz10m-v3.txt`). One independent implementation review found no concrete defect. A separate fresh-import imposter regression was observed red then green. No seals/receipts/re-review.

Default-route counts below were measured after f28c7bb2; this private selector does not execute on that route. Next bounded increment: ordinary instance scalar reads and one exact array-d member, followed by original SOR helpers when shared S57 binding is accepted. List-reference stores, field-reference stores, result containers and default/AOT activation remain open.

---

# Preceding flat prototype result

Committed f28c7bb2; shared proof-corpus merge 7bac2452. Private JIT only: no default Region/AOT/deployment change. S58 supersedes the earlier seal/review workflow.

| Whole program,20 loops | Current Lifted s, median3 | Flat s, median3 | Flat change |
|---|---:|---:|---:|
| spectral_norm | 0.5221753 | 0.5896047 | +12.9% |
| FFT | 0.0262140 | 0.0281379 | +7.3% |

No overall gain. One alternating three-pair development cohort; other runs' tests were alive (raw snapshots), and individual samples are noisy. FFT flat range0.02261?0.04158s overlaps current0.02608?0.02918s. Do not infer a stable FFT regression or gain from its median. The unchanged original20-loop bodies matched every boundary result/type/bits and mutated array bytes:104,000spectral calls and2,000FFT calls. All measured wrapper calls completed native with0fallback.

| Complete call | Python us | Current us, median3 | Flat us, median3 |
|---|---:|---:|---:|
| part_A_times_u | 11.84052 | 5.43224 | 4.88584 |
| part_At_times_u | 10.73244 | 5.09076 | 5.34682 |
| FFT_transform | 1561.01750 | 13.24300 | 13.45450 |
| FFT_inverse | 1620.40650 | 13.44250 | 13.26950 |
| Synthetic one-list-item read | 0.05776 | 3.64334 | 4.03438 |

The synthetic flat samples span3.64?30.04us (one unexplained outlier); no submicrosecond-entry claim. Real target entries are below their Python calls, satisfying the measured-floor question, but this first implementation does not improve whole-program time against today.

Instrumented flat costs (us/sample; timer/observer overhead retained):

| Call | Argument/shape | Variant lookup | Holder | Dispatch/guard/native/cleanup/boxing envelope | Audit/accounting |
|---|---:|---:|---:|---:|---:|
| part_A | 1.7621 | 0.1569 | 0.3930 | 2.3782 | 0.7397 |
| part_At | 2.1162 | 0.1544 | 0.3704 | 2.0050 | 0.6674 |
| FFT_transform | 1.1166 | 0.1673 | 0.3716 | 11.3999 | 0.7774 |
| FFT_inverse | 1.1052 | 0.1742 | 0.3760 | 11.4627 | 0.7884 |

The envelope is not isolated machine-body time. It retains the full-buffer undo copy. The next small flat change is an exact C argument-shape scan to remove Python recursive construction before object-graph machinery.

Validation: `python -m pytest tests -q` with PROVENANCE_CORPUS=tests/provenance_cases:2619passed/131subtests/2expected xfails. Focused protocol35passed; real original targets2passed. Shared exact differential oracle plus local exact-array adapter: seed5614,10minutes,176813cases=31118native+145695declined,0wrong/unchecked. Three observer failures and an exception-context leak were reproduced before fixes; direct CPython comparison corrected a false test expectation about Python3.14's division message.

Remaining: fields/array members/SOR/LU, list stores, result-list construction, default routing/AOT and4b are not built. See KNOWN-GAPS.md. Evidence is the commit, commands/pass counts and raw timing `inplace/s56-flat-three-pair-v2.txt`; no new seals or receipts.

Post-commit default-route reporting:243/773/0/0matrix and194captured/60complete-native of375held-out definitions; privateflat stays inactive, deployment selection not rerun, no gain attributed. See S56-DEFAULT-COUNTS.md.
