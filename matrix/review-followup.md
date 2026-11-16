# Independent follow-up review

Reviewed the corrected catalogue, run_matrix.py, run_locked.py, tests/test_matrix_harness.py, and the saved smoke-v2/harness-gate-v1 output. No workloads were run for this review.

## Decision

No remaining safety blocker to starting the full exploratory matrix under run_locked.py. This is approval to collect execution evidence, not acceptance of final compiler verdict totals. Resolve every fixture/oracle anomaly and harness_error row before pinning the regression matrix or claiming product wrong/crash counts.

The recorded smoke contains 11 rows: 5 native, 6 declined, 0 wrong/crash. The recorded observer gate reports 7 passed. Those are saved execution results, not results produced by this review.

The changes address the initial high-risk issues: actual async-iterator execution, semantic descriptor/compile/super projections, shared ordinary result/argument alias comparison, exception suppression, native generator draining, supplied keyword arguments, boundary/order cases, unresolved lifter exception observation, owned worker timeout/recycling, tokenized lock ownership and cleanup, and clone-local temporary caches. The final rejected-candidate branch now records direct replay observations instead of classifying by English reason text. F-string conversions now use an explicit Unicode source escape.

## Residual limitations to resolve before acceptance

1. The rejection replay path marks an unreproduced candidate rejection as harness_error. Keep these outside accepted product defect totals until investigated. An actual compiled unexpected exception may not increment compiled_calls because success counters increment only on return; retain the observed error/phase rather than interpreting zero successful calls as proof that no native execution happened.

2. A worker EOF has a small restart race: child.is_alive() can remain true immediately after pipe closure, and the next connection.send may fail before the parent observes process exit. On EOF, explicitly join/reap the owned child, close its connection, and force restart. Also guard BrokenPipeError/OSError on send and shutdown so a single fatal row cannot abort the remainder. No evidence here suggests external processes are touched; terminate is restricted to ctx.Process instances created by this runner.

3. freeze(Yielded) still starts new memo tables for values and return value. Template interpolation values and slice members do likewise. This does not invalidate the current scalar generator smoke, but a generator yielding an argument list can lose return/argument alias evidence. Pass seen through recursive structural freezes; copy args and kwargs as one graph when adding any cases with cross-positional/keyword aliases.

4. The observer gate does not yet exercise candidate status=rejected, successful recovery after a speculative typing failure, worker EOF/timeout continuation, or tokenized cleanup after an audit error. Add focused harness tests as these paths become relevant; do not invent compiler verdicts for them. The current successful numeric, swallowed-error, mismatch, aliasing, context, and generator gates cover the main measured smoke paths.

5. The inventory still counts AST nodes and keyword spellings in setup helpers. Label that as generated-source inventory rather than evidence that each role executed natively. Individual actual row outcomes remain the source of support claims. Current verdicts are specific to the supplied argument/keyword examples and do not prove unrestricted support.

6. Missing serialized C-call counters cannot be reconstructed from Python-only trace edges. Covering all public methods is a useful superset; report unavailable historical C counts explicitly. Maintain provenance for the hot Python stdlib entries that are available. Held-out associations are historical inclusive time, not measured unlocked time.

7. The generic unsupported projection guard and invalid-fixture detection currently become crash records; only some branches set harness_error. Audit crash rows for observer/fixture failures before product fixes and totals. No missing stable projection should be treated as a compiler defect.

No product files were edited. This follow-up report is the only file written by this review pass.

