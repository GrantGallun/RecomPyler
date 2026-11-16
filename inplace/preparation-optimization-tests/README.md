# Prepared empty-Virtual lowering tests

Status: authored only; no import, execution, build, or timing. Keep outside `tests/` until the coordinator records BOUND/DESIGN and activates the red run.

The fail-first boundary is deliberate: with empty locals/params/fresh and no clone, `checked_lower` must avoid constructing `Lower`. A patched constructor raises on that path; the original constructor is independently retained as the AST/source oracle. This tests eliminated analysis work without a flaky wall-clock assertion.

Coverage:

- Calls, loops, captured allocations, status/default returns, original defaults, decorators, finally blocks, and fallthrough preserve normalized AST and digest; source AST is not mutated.
- F5 records a proved identity transform; reachable clone validation remains active on fresh and cached facts, with unknown facts on failure.
- Nonempty locals, params, fresh values, and clone context each still construct the full transformer and match its output.
- Full-program source/digest and existing R8 reports match an explicit full-transform oracle for ordinary calls, captured allocations, local field clones, and fresh-return clones.
- Real Region calls must complete natively with counters reconciled; captured references retain alias identity and scalar/fresh optimizations still fire.

The synthetic checked-IR cases do not execute fabricated arithmetic. They exercise compiler internals and compare against the existing full transformer. The native cases use ordinary Python source and actual compilation, with no arithmetic/result mocks.

Suggested activated run (coordinator only, after moving the test into `tests/`):

```
C:\Python314\python.exe inplace/run_locked.py preparation-empty-red C:\Python314\python.exe -m pytest tests/test_empty_virtual_lowering.py -q --tb=short
```

No product implementation is included. No performance or passing-test claim is made.
