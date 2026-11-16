# S59 execution

Use the supplied clone and the S59 order without additional approval or steering waits. The earlier census is closed. S58 replaces all earlier multi-round review and evidence requirements.

1. Merge wave19 1eb3ac55; run `python -m pytest -q --basetemp=lift-evidence/temp/s59-merge tests` at below-normal priority, then commit the merge without unrelated files.
2. Scalar clock calls: tests first for direct/module/reexport bindings, invalid call effects, conversion mutation, and fresh prepared AOT. Recognize only the original builtin `time.perf_counter`, with existing binding guards. Use the CPython raw performance-clock API and CPython seconds conversion through Numba's intrinsic extension; unknown API availability declines. Arbitrary C/library calls retain their existing exact adapters or decline. This avoids introducing arbitrary interpreter effects or a second object representation.
3. Run focused tests, ten-minute wave17 difffuzz on deterministic clock-surrounds-work cases, one implementation review, then full suite once and commit. Time scimark with a fresh cache and three alternating pairs at 20 loops, under TIMING.lock; compare with PyPy 11.91x. A nondeterministic returned duration may remain unverifiable by the exact profiler; report this rather than weakening equality.
4. Probe nqueens' hot consumer with lift_region, build its next actual blocker with fail-first tests, and repeat through tuple(iterable), private sets from generators, slicing/list concatenation, reversed range and loop-else as needed. Then meteor_contest, go, hexiom, generators. General fallback remains after these.

Only source/tests in this clone, the root ledger, the timing lock, and this run's shared corpus prefixes/REQUESTS append are writable. No push, global installation, permission changes or foreign process operations.
