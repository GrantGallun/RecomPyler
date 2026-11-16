# Persistent class lifetime: preparation counterexamples

Preparation only. This extends the existing instance/finalizer tests to the
ordinary heap CLASS itself. A weakref callback can observe a class remaining
alive after its module binding and last instance are gone, even if the class
has no __del__ and every numeric field is exact.

## Existing retention is a real prerequisite

Static inspection finds strong class references in ObjT.cls/classes, Program
fields/class_fields/members/alias/guards, constructor F2 fact keys, cached
_load_plans and _c_kinds, signature keys and potentially reached function-owner
records. The module-level _ESCAPES dictionary also stores (cls, init) keys.
Deleting only a DirectPlan reference or even the Region can therefore fail to
release the class. Reached methods with a __class__ closure can indirectly keep
it alive. This is not solved by declaring DirectPlan weak while leaving the
rest of the persistent compiler graph unchanged.

The new draft compares a Python control with a successful ordinary compiled
Region and a required successful direct Region. Remove the module binding and
last instance, keep Region alive, force ordinary cyclic collection and require
the class weakref callback. The compiled case intentionally exposes existing
retention; it is not allowed to become a skip/xfail or an unsupported-class
excuse for the requested general rule. A second direct case leaves the audit
session/report alive to catch additional persistent diagnostic retention.

Custom metaclasses are different: lift._record_problem already rejects any
class whose exact metaclass is not type. A metaclass with __del__ must continue
to decline direct compilation before layout use. The draft requires Python
fallback and observes the class finalizer/weakref after its binding/instance
are dropped. Do not claim that existing rejection solves ordinary type-class
weakref lifetime.

## Required persistent dependency design

Assign deterministic ClassDependencyId/FunctionDependencyId numbers during
checked generation. Persistent plans/reports use these IDs and primitive
layout/source facts, not live classes, method owners, class-keyed dictionaries
or non-root function closures. Keep no-callback weakrefs for revocable class
and reached-function dependencies; invalidate lazily when resolving the next
call. No weakref callback should execute arbitrary recompilation or allocate
new Python bookkeeping while a class is being collected.

The original Region callable is deliberately kept as the wrapper's source
callable; dependencies naturally reachable from it remain naturally reachable.
Do not infer that every reached constructor/method/class has that same root.
A class created dynamically and only passed as an instance is the key case.
WeakKeyDictionary alone is insufficient if a value points back to its key via
ObjT, a method __class__ closure or a nested schema. The whole retained value
closure must be checked. Global _ESCAPES needs weak dependency storage too.

Compilation may temporarily pin dependencies, but strong compile structures
must be released/converted before returning to a user observation boundary.
Avoid resolving all weak dependencies to a persistent Python tuple just before
direct_execute: that could itself delay collection across the C-entry profile
callback. Inside the fresh callback-free C walk, resolve and pin only currently
needed classes from live rooted owners and weak dependencies. Use installed
weakref APIs/layout only with a proven no-callback operation. Missing/replaced
dependency invalidates that cached specialization; never compare a recycled
raw address as proof of class identity.

A cached ordinary fallback needs the same no-retention representation or must
be rebuilt from the current live arguments after a direct decline. Saving the
old strong Program merely as a fallback defeats the lifetime test. Any source
rewrite should preserve ordinary execution behavior while closing this proven
retention defect. Saved AOT metadata remains primitive; source-only restore
also creates only temporary per-call class pins.

The direct audit bank stores canonical strings/IDs/digests, never a class,
Region, argument/result, bound method, exception, traceback or Python frame.
Only compiled library/module/environment ownership is persistent, and that
closure must also be checked for incidental class captures. Snapshotting a
record must not turn weak dependencies into retained objects.

The full fix and real positive tests remain required after IMPLEMENT. There
have been no product edits, test executions or runtime observations here.

## Lower-churn compile-scoped Program route

The coordinator proposes an alternative to rewriting every ObjT/analysis map:
retain strong types only while compiling, then seal a primitive/weak-dependency
C descriptor and release the full Program from Region.latest/programs and any
other cache. Warm direct entry uses the descriptor and fresh walk, never the
ordinary Program/_Loader. A guard failure lazily reconstructs a candidate from
current live inputs or replays Python; it does not retain the old strong
Program as a fallback. This is a coherent route if the following closure audit
passes:

- Region signature keys, latest, programs and _prefix must not keep Program,
  classes or class-bearing kinds indirectly. A primitive diagnostic proxy can
  preserve source/digest/scalar_report/direct_report; weak dependency resolution
  for explicit introspection must not become a persistent strong cache.
- JIT Dispatcher/cres/library/environment ownership must be inspected. Generated
  heap functions use numeric handles and may contain no Python class constants,
  but that is a source/dataflow proposition to verify, not an assumption about
  every compiler object reachable from the adapter owner.
- AOT build/seeds and current tests sometimes consume Program internals. Build
  operations can reconstruct a temporary compile scope from live weak
  dependencies; an expired dependency must not be resurrected from a retained
  class. Public latest diagnostics/API expectations require compatibility tests.
- _ESCAPES must use weak class -> weak init-key data with primitive values. A
  weak-class dictionary whose strong init value closes over __class__ still
  retains its key; both dependency directions need the weak/no-backedge rule.
- Other global facts, constructor caches, failure records and audit bindings
  receive the same closure check. Clearing only latest is insufficient.

This route can preserve existing analysis internals as compile-scoped objects
while making the persistent direct path weakly bound. It still has to pass the
positive class weakref tests and fresh AOT/recompile/fallback cases. It is design
only; no Program/ObjT/cache mutation has been performed.