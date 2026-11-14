# Final report accuracy check

The study agent independently compared WAVE3-RESULTS.md and WAVE3-NATIVE-RESULTS.md with the frozen fixed/long summaries and the 26-row native comparison. It verified denominators, process medians/geometric means, time-versus-speed ratios, profile costs, actual-mode evidence and the distinction between basic Richards JIT and held-out Richards_super AOT.

One rounding correction was identified and applied: the basic Richards warm Python/candidate ratio is 20.9549392240, displayed as 20.95x. No other concrete numerical or interpretation correction was found. Baseline latency mode uncertainty remains explicit; separate audits are not relabeled as those latency processes.

This was a read-only report review. No source edits, tests, builds or timings were performed. It is separate from the compiler review, final 383-test suite, rebuilt native deployment gate and measured benchmark evidence.
