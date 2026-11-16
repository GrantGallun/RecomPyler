# S35 plain-Numba diagnostic independent review

Read plain_numba.py, the shared run_matrix.py oracle, current catalogue and S35. No workloads were run, and no compiler verdict is inferred from source.

No blocking oracle defect found for the current catalogue. The script passes the unchanged construct function to lazy plain numba.njit, derives dispatch types from the same evaluated fixture arguments and supplied keywords, and compares through the shared result/argument/alias/event/counter/stdout/stderr/exception oracle. nopython_signatures distinguishes a successful compilation whose runtime call raised from failure to obtain a native signature. Numba diagnostics are recorded separately from program stderr. Workers are owned and disposable, with timeout/crash records retained as harness_error rather than incorrectly counted as ordinary compilation declines.

Before the complete cohort, seal catalogue.py, run_matrix.py, plain_numba.py and selected step2-v3.jsonl hashes. Assert that the selected case IDs equal all current 781 decline IDs with no duplicates or missing fixtures. Report the original 655 cohort by intersection with saved baseline decline IDs rather than relying on catalogue position; added rows belong in the expanded count only. Keeping source, fixture expressions, installed Numba version and exact signatures in each row makes the result auditable. Assert completion/counts and repair harness_error rows before presenting exhaustive counts.

The comparison answers behavior for these executed fixtures. It does not prove universal Numba equivalence or that every matched row is immediately profitable through RecomPyler. Expose matches and differences separately; the latter are backend semantic limits to preserve or guard during any future reuse work. Keep unchanged plain njit defaults disclosed (including machine integer semantics and default bounds checking), because changing those would answer a different question.

All current fixtures use independent supplied keyword objects; if a future fixture shares a mutable object between positional and keyword arguments, deepcopy the combined (args, kwargs) pair with one memo, as independent deepcopy calls would lose that input alias. This is not a blocker for today's catalogue.

Only this review file and review-s34-c.md were written.
