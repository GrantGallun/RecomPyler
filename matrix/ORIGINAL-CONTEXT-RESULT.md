# Original module-context provenance binding

Bind source to its complete original module without executing that module. Require exact recursive code metadata, flags, constants, line tables and instruction positions. Ordinary captured closures remain declined; class-cell reads remain unknown. Assert transfers conservatively record possible escape through truth conversion and the failure message.

Useful original-source queries rise from 2/38 to 14/38; original binding failures fall from 32 to zero. All six wave16 method queries pass. Remaining limits concern queried owners, unsupported control flow/closures and runtime ownership facts.

Validation: fail-first original-context, nested-position and Assert tests; 92 focused passes; 275 Unicode/owner/AOT passes and 2 expected failures. `C:/Python314/python.exe matrix/run_context_suite.py` executes the full `tests` tree once partitioned by file over four below-normal workers: 3,058 passed, 4 xfailed, 131 subtests. One implementation review: `matrix/review-original-context.md`, no concrete wrong result or crash. Ten-minute-mode differential run seed73101 exhausted96 text subjects:1,287 native and7,294 exact declines,0mismatches/errors (`matrix/difffuzz-original-context.log`).

Three alternating whole-process20-loop scimark pairs: CPython6.794s, RecomPyler0.891s,7.63x, exact output,0fallback; PyPy11.91x (`../pypy-compare/JOINED.md`). Raw output: `claude/s57-programs.log`. Concurrent correctness suites were active; use the observed cohort per S58. Prior wave19 integration was7.69x; no speed improvement is claimed for source binding. Matrix and held-out reports follow the commit.
