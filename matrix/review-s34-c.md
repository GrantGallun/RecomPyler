# S34 diagnostic C independent review

Read full S34, C-DESIGN.md, guarded.c, build_c.py, run_c.py, captured namedtuple implementation and saved s34-c-build-v1 output. No workloads were run. No product or other wave files were edited.

The saved build succeeds as an ordinary extension with the existing toolchain. That is build evidence, not runtime soundness or a ceiling measurement. The following guard counterexamples must be executed and corrected before accepting fast-route results.

## Blocking guard obligations

1. **sys.maxsize is speculatively read before the first random draw.** dict_loop's fast candidate reads sys.maxsize once before iteration, but the original calls random() first and then reads sys.maxsize on every iteration. sys is not guarded as the exact expected inert module. Rebind the original function's sys global to an object whose maxsize property appends an event and returns the original maxsize object: current fast selection can change lookup count/order. If that property raises, compare Random state: the original has already drawn, while the speculative C lookup has not. A property can also mutate the Random class after its earlier version check.

   Guard sys as the exact expected module with an existing exact maxsize binding using a non-callback lookup before using the fast route. Otherwise enter generic code without invoking the property speculatively; generic lookup must remain after the draw at the original point.

2. **A custom mapping constructor can invalidate the pre-copy builtin guards.** fast tests whether the copied dict is exact, which is normally true even when source is a custom mapping. dict(source) can call Python before the fast loop. For example a mapping with keys=['a'] and __getitem__ rebinding the original globals['str']=float returns {'a':1}; the original then no longer considers its str key eligible for replacement, whereas the current fast loop still uses hardcoded str conversion. It can also rebind isinstance/type.

   Require an exact inert source dict for this fast route, or revalidate post-constructor bindings before selecting it. Do not fall back by calling the whole original after constructor effects have already occurred. The generic body should continue from the newly constructed dict with current bindings.

3. **Type versions do not guard instance dictionary keys.** Exact GVector and Random class/version checks do not prove that looking into their instance dictionaries cannot call user code. Example: assign a GVector.__dict__ containing a str-subclass key K('x') whose __eq__ records an event and returns False. Original x lookup compares once and raises; the fast PyDict_GetItemRef miss followed by PyObject_GetAttr repeats that lookup. Likewise a custom str key 'random' in an exact Random instance dictionary can execute comparisons on each original method lookup, while the cached fast route looks it up once.

   Restrict instance dictionaries to known-inert exact string keys before speculative/direct reads or cached binding, or use generic lookup at each original occurrence. Inspecting keys with PyDict_Next and exact type checks can establish this without invoking equality callbacks. Do not use a speculative GetAttr to decide eligibility when that lookup itself can have effects.

These are specific fail-first witnesses to run, not reported runtime verdicts from this read-only review. The same original 14 cases do not cover guard invalidation; add these guard cases.

## Otherwise sound structural choices

- String attributes are loaded x,y,z in original order and formatting stays PyUnicode_Format. This preserves Python percent-formatting behavior, signed zero/special values and custom conversion errors without locale-sensitive printf substitution.
- Dictionary generic code re-reads random method, sys.maxsize, isinstance/type and type tuple members at their original body positions. The fast dictionary loop updates existing keys only and owns draw/scaled/replacement temporaries.
- Exact Random method pointer/self plus class version are useful guards once instance-lookup purity and sys/source purity are also established.
- HP ssize_t arithmetic checks overflow before addition and sends bigint/custom values to boxed operations. limit<=clamped selects the original maxhp object on a min tie; max's zero tie uses the original zero singleton. Unchanged namedtuple fields receive owned references.
- Namedtuple _replace/_make code and closure identities, type versions and exact layouts support the direct tuple-subtype construction for this captured implementation. The source _make is tuple.__new__ followed by a length check; five fields are constructed exactly. This is not equivalence for arbitrary tuple subclasses.
- The generic HP path retains min lookup before fixed/maxhp evaluation, then max lookup and addition, followed by _replace keyword call. Its owned references unwind through the shared cleanup path.

One guard-error nuance: early name_is checks can raise NameError before the original would access that name. For example a missing str binding on an empty dictionary should not be observed at all, and missing max can follow an earlier state-attribute failure in the original. Treat unavailable speculative names as guard failure/fallback at entry rather than raising them early. A mismatched present binding already falls back before body effects.

## References, ABI and setup scope

The ordinary call cleanup uses owned refs for attrs, tuples, dict, iterators and temporaries, with XDECREF paths on errors. This is a useful structural review; the planned success/error/finalizer gates still need actual execution.

The extension uses PyUnstable_Type_AssignVersionTag and tp_version_tag under an explicit CPython 3.14/GIL-held diagnostic ABI. That limitation must stay in the result; it is not a Stable-ABI product design. [CPython documents the type-version helper as unstable](https://docs.python.org/3.14/c-api/type.html#c.PyUnstable_Type_AssignVersionTag).

configure assumes valid function/type/tuple arguments and single initialization; its static context owns references for module lifetime and has no reconfigure cleanup. Keep it test-only with that precondition, or validate/reset context if repeated configuration is needed. Do not infer leak-free module unloading or subinterpreter support from input-refcount gates. Wrong-arity/keyword binding is also outside the current exact positional test interface.

## Timing validity

Add guard-invalidation tests after timing or use a fresh configured context: mutating/restoring a class attribute invalidates the captured version tag permanently, so otherwise later timings may accidentally measure only generic routes. Record fast/generic/fallback counter deltas for timed samples, not only cumulative counters after behavior tests.

The runner appropriately compares complete CPython, existing object-mode direct entry and handwritten C calls in alternating pairs. Generated LLVM in this runner is the object-mode comparison artifact; do not present it as the handwritten C assembly. Keep C source/build/compiler flags and extension identity as C evidence.

No backend change is implied by this diagnostic extension. Accept a BOUND only after behavior/ownership/guard witnesses pass and counters demonstrate the intended specialization carried the timed calls.

Only matrix/review-s34-c.md was written.


## Corrected guard review: v3 / green3

Read corrected guarded.c, current run_c.py, latest S35 and all four retained *-green3.json files. No workloads were run by this reviewer. The saved green3 records show identical result/error and callback events for sys ordering, mapping rebinding, GVector custom dictionary keys and Random custom dictionary keys. Source now requires an exact source dict for the fast loop, exact string instance dictionary keys before speculative lookup, exact captured sys module with inert keys and an existing unchanged maxsize binding. code_ok rejects non-exact-string global/builtin keys before speculative names; missing names become guard failure. These changes address the four prior specific witnesses.

One further acceptance obligation remains in the generic HP route: retained intermediate references change finalizer order. The original expression hstate.fixed.maxhp releases the temporary fixed object immediately after maxhp extraction. mixed_calls stores fixed until its final cleanup, after hp access, min/max and _replace. This concrete witness needs execution:

```python
events = []
class Fixed:
    @property
    def maxhp(self):
        events.append('maxhp')
        return 63
    def __del__(self):
        events.append('drop-fixed')
class State:
    @property
    def fixed(self):
        events.append('fixed')
        return Fixed()
    @property
    def hp(self):
        events.append('hp')
        return 50
    def _replace(self, *, hp):
        events.append('replace')
        return hp
```

Call original applyHPChange and C mixed_calls separately with fresh State(), -1 and compare events. Predicted original order is fixed/maxhp/drop-fixed/hp/replace; current generic C keeps drop-fixed until after replace. This is a source-derived witness proposal, not a measured verdict. An analogous lifetime gap retains a custom __add__ result rejected by max(0, result) until after _replace, where original releases it before min. These destructors can mutate later attributes or append events, so final input-refcount equality does not establish expression-lifetime equivalence.

Safest bounded correction: after all pure fast-domain guards fail, delegate to the original whole function before body effects. This preserves the diagnostic fast-route measurement and arbitrary-object fallback. Alternatively model individual expression temporary releases and test those boundaries. The existing generic HP path is not ready for a universal equivalence claim until the witness is run and corrected.

The current runner now records per-timed-sample fast/generic/fallback counter deltas, which resolves the earlier timing-route evidence request. Keep the existing test-only configure/ABI limitations and retained-source seals. Whole-call measurements include the implementation's full global/builtin-key scans; a lack of gain from this diagnostic would establish a result for these guards and emitter, not prove that every possible boxed emitter must have the same ceiling.

Latest S35 explicitly reopens backend reuse: direct njit for all current declines, extension-interface reference-managed object JIT/AOT, and installed pycc/PIXIE source status. Earlier unmodified pyobject-signature failures establish only that those unchanged signatures fail. Do not generalize that finding to all typed extension models before S35 evidence.

## Watcher revision review: prepared v4

Read current watcher-backed guarded.c and C-DESIGN.md, saved s34-lifetime-red-v3.stdout and both lifetime JSON records. The actual red evidence confirms equal ordinary result/error but changed temporary-finalizer order in the old generic HP and pre-tuple string paths. Current code removes lowered generic HP/dict routes: failed domain guards call the original function before copying the source or evaluating HP attributes. String now uses reverse acquisition cleanup before tuple creation and clears standalone element references after successful tuple creation. These are appropriate repairs; runtime green evidence is still required.

Watcher design is conservative within its declared configured-once, GIL-held, process-lifetime scope. Initial purity scan precedes watching; mutation of any shared globals/builtins dictionary marks every matching dependent function dirty. The captured exact sys module is watched too. Every event makes invalidation sticky; no mutation counter rollover/revalidation assumption is made. Failed watcher allocation or per-dict registration selects Python. Strong references keep watched dictionaries alive, and the callback performs identity checks/dirty stores without allocating, raising, mutating watched state or invoking arbitrary Python callbacks. All watcher costs belong inside complete-call timing. Reconfiguration/unloading/subinterpreters remain unsupported; static context and watcher registration have no teardown protocol.

One additional invalidation boundary should be probed before making a universal guard claim. dict_loop checks code_ok and hardcoded-name identities, then allocates a bound Random method and PyDict_Copy before entering its fast loop. A tracked allocation can invoke cyclic-GC callbacks/finalizers. A one-shot gc.callbacks start callback that rebinds the original function globals['str'] or ['isinstance'] will mark dirty, but this invocation does not check dirty again and continues hardcoded conversions. Original Python resolves those names after its random draw. Prepare exact source and Random before arming the callback; use an enabled low GC threshold and retain all probe scaffolding outside the measured call. Compare callback events, error/result, random state and fast-route counters. This is a proposed executed witness, not an observed failure. The prior ordinary mapping callback witness is repaired, but dictionary allocation is another Python re-entry boundary; sticky invalidation guarantees the next call, not automatically the remainder of the current one. Record a precise eligibility restriction or handle this boundary if the witness reproduces.

No workloads were run by this reviewer. Current accepted timings must come from the rebuilt watcher revision and preserve timed route deltas; old purity-scan results remain useful historical measurements but cannot substitute for the new implementation.
