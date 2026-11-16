# Independent S49 range resume review

Static design review on 2026-11-14, initial HEAD 85838ba1527373443b037a0bae53bb4408d132b7. Read RANGE-DESIGN.md, S49-RANGE-DESIGN.md, next-range tests/AOT tests, previous review-range reports, heap/lift boundary/type paths, _region_seed/_prepared metadata, and installed Numba range implementation. No timing or locks. Findings were sent to the parent immediately. Initial disposition: implement conservative flat RangeT, with the following corrections; no demonstrated backend gap.

## Important: ordinary tuple ownership remains binding under S49

Static counterexamples to general admission:

```python
def selected_tuple(r, owner):
    count = len(r)
    return owner
# owner=(int('10000'),): CPython result is owner.

def tuple_in_mutated_list(r, values):
    count = len(r)
    values.append((9,))
    return None
# values=[owner]: CPython leaves values[0] is owner.
```

_Loader.argument flattens TupT; _Unloader.result creates tuple(out), losing selected tuple identity. _Loader.tuple retains no tuple owner map, and mutated list write-back reconstructs tuple elements. _unchanged accepts only exact numeric kinds, so a previously existing tuple can be replaced. These are static counterexamples, not executed wrong-result receipts. Parent will add them to the authorized shared corpus. Equal distinct strings likewise share the value-keyed loader.strings map.

Smallest sound path: recursively and cycle-safely refuse tuple/string/object-containing newly enabled RangeT regions, including borrowed input graphs, outputs and writes, pending wave17's layer. This is conservative kind-level representation refusal, not private provenance. Numeric/None/bool results and otherwise sound numeric containers can proceed. S49 removes only numeric-leaf identity obligations; no C-long iterator-owner guard remains necessary.

## Important: historical AOT gate uses scalar APIs

next-range-aot-tests.py and the initially copied active AOT gate use candidate['_lifted'], aot.build and aot.AotLifted. Heap success returns engine='region', _lifted=None, _region=region. These scalar APIs do not certify RangeT metadata. Use profiler.test_region explicitly for captured verification, then heap.build_regions([((fn.__qualname__,line),fn,region)], folder).

True prepared reload recipe (tests/test_fixed_costs_aot.py and test_prepared_cache.py):

```python
snapshot={'mode':'standalone','functions':[], 'plan':{'aot_regions':section}}
index=pc.open_index(section,row,plan_snapshot=snapshot)
assert index is not None,pc.last_miss()
wrapped=heap.lift_region(fn,index.exports,prepared=index)
```

Let open_index load/verify the extension itself; calling aot.load first creates an unverified preloaded module which open_index rejects. Fresh child must assert prepared_hits, aot_calls/compiled_calls>0, jit_calls==0 and no Numba import; change valid live bounds, then exercise invalid-bound fallback and public-range escape refusal. Legacy exports+seeds coverage is additional, not a substitute for prepared metadata.

## Minimal architecture integration

RangeT needs explicit description/equality/join, width=3, machine types iii, inert dummy (0,0,1), code/coercion/recursive-call flattening and signatures. Refuse RangeT/None joins and every heap/public placement; _slots, slot/store/box/check_item, c_kind/_c_ok and result/unloader default paths must not reinterpret bounds as handles. Direct internal returns remain flat while public returns decline.

Exact-range _seed and _Loader.argument triple packing are necessary range ABI additions, as are positive kind tags in _region_seed and _prepared capture/validate/restore. S45.3's wave16 load/write-back/start-up restriction applies to the later init-entry item. Additive range-only branches preserve existing loading/write-back/native startup behavior and require coordination, not a new approval gate. No _heap.c changes are needed.

Constructor arguments must become once-only eager temporaries before zero-step and domain checks at construction. Bounds must fit signed int64, step excludes zero/INT_MIN, mathematical signed difference is in [-INT_MAX,INT_MAX]. Entry checks use unbounded Python arithmetic; emitted construction checks subtraction overflow before consuming a wrapped result. Force signed bounds for bool/literal/default forms. Use guarded Numba count/iteration; its unused terminal add may wrap without affecting yielded values because count controls iteration and iterators cannot escape. Index checks/normalization precede checked multiplication/addition. Membership bounds/direction checks precede checked difference/remainder. Unknown/custom/subclass/NumPy/float/complex operations replay Python.

Historical numeric-owner tests now need exact type/value rather than numeric identity or mandatory fallback. Keep numeric is/is-not/id refusal, including helper observers and numeric subclasses. Native helper top-level equality alone hides nested bool/int type differences and float signed-zero/NaN-payload differences; use recursive exact comparisons for admitted outputs. Check actual constructor bailout evidence for warmed int64-span rollback cases. Retain pending extreme-count/step, empty-loop/for-else, live builtin/default/callee, internal return/multiple ABI argument, and recursive escape tests from the earlier reviews.

Initial inspected hashes: heap.py 12d6e38cada4ad151906656c18eb615205aa5a8f22dfc840729e07b50f18c999; lift.py 8c51d27ae252a9075971872cd205ba1e2fcfdd5892b751afea54ae37ccea92a9; S49-RANGE-DESIGN.md 08a27f093b2e38b2c02d86df649d546c8352887a28fe5c7fc72e3efbef0fae9b. These hashes describe the design-review inputs, not subsequently edited implementation.

## Concrete implementation review addendum (before fixes)

Reviewed the uncommitted RangeT diff in heap.py, _region_seed.py and _prepared.py after the initial 101-pass focused run. Wrote authorized independent tests to lift-evidence/range-s49-review-tests.py and executed one serial below-normal correctness run, no timing lock. Receipt logs/range-s49-independent-review-red-v1.receipt.json is complete, exit 1, source_unchanged=true. Seven tests failed. These are acceptance blockers.

### P1: Repeated list display bypasses range heap refusal

Both `return [range(n)] * 2` and `r=range(n); return [r] * 2` reach native list_fill with the first range code treated as a scalar slot. The public unloader then crashes with AttributeError: RangeT has no attribute elem. _Gen.repeated bypasses widen_cell/store, and the post-settle supported(ListT) recursively accepts RangeT instead of enforcing its top-level-only position. Refuse RangeT elements before repeated allocation, and centrally refuse range inside every list/dict reachable kind. Add explicit unloader/result/box defenses so an unrecognized kind never silently reaches generic handle reconstruction. This is a range escape/identity counterexample; parent was notified for corpus registration.

### P1: New regions can still take the unsafe old direct-loop lowering

Four executed cases use a valid `r=range(1)` and a direct `for item in range(start,stop,step)` with an immediate break. Range creation appears either before or after the direct loop. At (INT_MIN,INT_MAX,1), CPython yields INT_MIN; compiled code returns the initial sentinel 99. Reversed endpoints with step -1 return sentinel 99 instead of INT_MAX. Existing direct-call syntax in for_loop bypasses RangeT construction/domain checks and Numba's wrapped stop-start makes these nonempty loops empty. S49 does not exempt numeric value errors.

Keep old direct syntax only after applying the same count-domain check, or conservatively refuse mixed regions with unguarded direct loops. Guarding the old path need not mark it as new RangeT use and thereby impose the new ownership restrictions on all previously admitted kernels; separate numeric-domain validation from new-value admission tracking. Both source orders need tests because a flag set while emitting later statements cannot retroactively protect earlier emitted loops.

### P1: Temporary-only construction skips the conservative ownership gate

Executed `len(range(n)); return owner` with tuple owner returns a different tuple object. The post-settle check only scans info.vars and info.ret for RangeT. Track newly emitted range-value use independently of whether a RangeT remains in a local or result kind, then run the whole-region nonnumeric restriction. Parent had independently identified this flag need. Test also requires explicit fallback, preserving owner exactly.

The new constructor span guard uses checked sub_i, checks status, then rejects INT_MIN; with each bound int64 and step neither zero nor INT_MIN this establishes the signed count domain reviewed earlier. Membership bounds-checking precedes subtraction/remainder, and index normalization is within signed range before the checked multiplication/addition. No new arithmetic defect was found in these guarded paths by static review.

_Global_ builtin argument snapshot changes in the diff affect every builtin, outside the minimum range adapter; limiting this change to the range constructor reduces unrelated semantic churn. Existing internal call_args/call_keywords do not snapshot arbitrary returned code expressions. Current supported forms usually produce temporaries for effectful loads, and no executed internal-call counterexample is claimed here; keep focused eager-evaluation controls rather than claiming a newly proved general call-binding property.

Prepared metadata adds an exact zero-payload ['range'] tag and validate_core rejects payloads, which is appropriate. Legacy _region_seed.restore currently ignores trailing parts for range like the historical random tag; a positive range shape check would avoid accepting malformed new tags. This is a metadata-hardening recommendation, not an observed wrong result on sealed artifacts.

After all seven regressions pass on a fresh source-sealed receipt, independently review the resulting changes and run the corrected true heap AOT gate. This addendum makes no acceptance, coverage or performance claim.
