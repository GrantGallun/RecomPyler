# S46 compile-scope review (preparation)

Independent reviewer step4_review, read-only, no executions or edits. This is
preparation for the Step2 DESIGN after the ten-region BOUND, not product code or
an accepted direct runtime.

Keep _Program, ObjT, Facts and ScalarReplacer strong during compilation. Persist
primitive source/digest/signature/layout/type-cell graph/reports/flags, weak
runtime dependency IDs and an audited native executable owner. The existing
_prepared encoding grammar is useful; its bound RuntimeProgram is not weak:
_restore rebuilds class-keyed types/maps and its guard closure retains class
snapshots, defaults and closure contents. References(program=...) must remain
compile-scoped too.

Required compatibility obligations:

- latest remains the same persistent record held by programs; preserve cache
  membership/clear/broken/MAX_SIGNATURES and instance/class resolver override
  behavior. _remember_variants currently requires _Program, so update its record
  admission explicitly; _prefix identity must be the record, not a hidden scope.
- Preserve module/run stats/cache counts/cached/ahead_of_time/fast_mixed/reports
  and mutable boundary flags. Explicit members/typed-info inspection may return
  a scoped resolved view, but the record must never cache that strong view.
- profiler's global-state discovery needs scoped resolved namespaces; persisting
  an unrelated reached function's globals dict can back-own application classes.
  Preserve its later digest/run/broken/cached export mapping.
- Ordinary compiled fallback requires a compatible primitive loader or a scoped
  materializer retaining original loader/unloader/status/RNG/array rollback and
  recursion guards. Validate the complete sealed specialization first; never
  re-infer changed code and run an old executable. Release temporary strong
  structures before returning to application observation; no generator, bound
  method, traceback, cache or diagnostic may capture them.
- build_regions consumes overloads, typed entry ABI/constant, strict/wide seeds,
  regenerated source/math checks and pc.capture after the final plan seal.
  Store primitive export templates or materialize an explicit temporary build
  scope. Preserve legacy export and partial-seed fallback. In-memory weak runtime
  dependency IDs must remain distinct from durable global AOT binding recipes;
  local dynamic classes must still compile in memory.
- Fresh generated ModuleType globals are separate from application globals and
  reports are primitive. Prove/test the complete dispatcher/cres/library/env/
  capsule owner graph rather than assuming no backedge from this observation.

Existing-source corrections: _signature is already a repr string; normal cache
keys do not own classes. _EscapeCache already uses weak class and weak init maps
with primitive bool values. Do not rebuild these fixes as new work.

Fail-first cases include successful ordinary/direct dynamic classes (also reached
__class__ closures) collecting with Region/latest/programs/audit alive; dead and
same-name replacement dependencies cannot use old code; code/default/closure/
class mutation invalidates; alternating signatures and override/cache controls
survive; prepared/AOT build works after scope release; expired weak dependencies
are not resurrected and live local classes remain eligible.
