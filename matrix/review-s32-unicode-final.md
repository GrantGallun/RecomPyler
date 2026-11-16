# S32/S36 Unicode control final independent review

Accepted as bounded diagnostic evidence. No concrete source, ownership, provenance or arithmetic blocker remains within the stated domain. The supported decision is to retain standalone CPython dedent for these operands. This does not accept a product capability/backend change or establish that Unicode representations cannot help other regions. No workloads were executed by this reviewer; only this review file was written.

## Verified evidence

Read UNICODE-BOUND.md, unicode-green-v3.json, unicode-seal.json, final C/bridge/runner/mutation/fresh-process sources and SPAN-DESIGN.md. Every source, design/license, JSON, helper/bridge binary, receipt and audit hash in unicode-seal.json matches current bytes. Independently verified both SQLAlchemy source files against each fixture's source hash and recomputed all three selected input hashes. AST function/class/line assertions and clean=False extraction follow the actual _dedent_docstring first-line selection rule. The operands remain static real-source controls, not serialized historical dynamic arguments.

The final receipt exits 0 and its pre/post atomic-acquisition audit has zero competing blockers. Independently recounted 2,328 identical behavior/type/input-alias/event/exception gates, zero mismatches, six success/error ownership groups, three timing cells and 63 route records. All timing variants have three samples; every recorded route has the expected 500 boxed/borrowed calls or zero CPython counters and zero fallback. Recorded all-whitespace inventory has 29 code points, exercised twice each, alongside NUL, lone surrogate, Latin-1/BMP/astral content, prefixes, CR, blank/trailing/empty lines, subclass and non-string cases. Fresh AOT exits 0 and confirms success/error/identity without importing Numba.

The original GC guard mistakes were actually executed red and corrected, rather than inferred away: deleted callbacks produced an extra exception, and a gc module subclass added a callback. Current guard reads pure exact module/dictionary/captured-list state and delegates before effects. Newline counts now use Py_ssize_t and line-relative bounds; the report correctly calls these structural bound corrections rather than claiming a giant-string test.

## Measurement and S36 decision

Complete-call microsecond medians are consistent across raw results and bound:

| Operand | CPython | Boxed AOT | Borrowed AOT |
|---|---:|---:|---:|
| Session.commit | 4.0322 | 6.6740 | 5.5732 |
| Session.flush | 3.0010 | 5.0336 | 4.5394 |
| Query.all | 2.7574 | 4.8140 | 3.3658 |

Both managed AOT routes are slower than CPython on every operand. Direct boxed C is also slower. Direct borrowed C is slower for commit/flush and reduces Query.all elapsed time by approximately 6.6% (2.7574 to 2.5742us); that advantage is absent after the managed boundary. No product speedup or broad 'all work is inherently C' conclusion follows.

S36's remaining-time ratios in the report are correct: boxed/borrowed AOT versus the best measured route are 1.655/1.382, 1.677/1.513 and 1.870/1.308. Being within 2x does not override the existing profitability gate. Keeping CPython for these standalone calls is the supported choice. Strong large-byte results independently support the shared span mechanism, while this Unicode control supplies no independent standalone dedent speed case.

## Shared design and limits

SPAN-DESIGN incorporates the requested distinctions: pinned buffer ownership versus selected-Python-object provenance; view/materialization rules through branches and operations; direct Python-result construction versus native-storage-plus-box copies; and boxed continuation when guards fail after effects. Installed Numba representation reuse is accurately described as source evidence, with standard boxing recreation distinguished from strict identity preservation. The shared first slice is exact type/context, pinned owner, logical length/data plus Unicode kind, checked reads/read-only loops and owned results, followed by executed capability gates. The 1,100-2,100-line estimate remains planning, not completed analysis or coverage.

Retain the explicit CPython 3.14/GIL/trusted-initial-context assumptions, exact-str native restriction, original fallback for unsupported inputs/context and private ABI limitations. Ambient cyclic finalizers, async/concurrent mutation, OOM injection, free-threading/subinterpreters and hostile import-time state are unproved. Selected-object identity tests are finite evidence, not a general escape proof.

The SQLAlchemy source license and fixtures are retained, the historical 273-call textwrap envelope is not assigned to these three static calls, and no unlocked-time or new whole-function/native/deployed count is credited. Product implementation still waits for the user backend decision. Earlier preparation counterexamples and failed attempts remain historical evidence; final green-v3 is the accepted cohort.
