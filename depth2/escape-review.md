# Independent review of escape summaries and heap metadata

Reviewer: independent Codex subagent `range_review`, 2026-11-13.
Scope: new `src/recompyler/escape.py`, generator-recorded object-allocation metadata and object-parameter integration in `heap.py`. Scalar lowering is not implemented in the reviewed change. This review does not establish any allocation elimination, deployment or performance result.

Only source inspection, short synthetic AST cases, two small `_Program.settle()` source-generation examples and the focused escape test module were used. No native compiler, full suite, timing job or product edit was run. Dynamic reference definitions used a temporary in-process `inspect.getsource` mapping to generate checked IR; the mapping was restored before the process exited. This review file is the only filesystem edit by this reviewer for this task.

## Two concrete checked-IR blockers found and corrected

### Hidden object leaves in tuple arguments

The initial integration marked object parameters only when the original Python parameter kind was directly `ObjT`. Generated tuple parameters are flattened into ABI values, so this omitted object-bearing tuple leaves.

The actual checked heap generator admitted:

```python
class Cell:
    def __init__(self, x):
        self.x = x

def extract(pair):
    return pair[0]

def f():
    p = Cell(1.0)
    q = extract((p,))
    return [q]
```

The generated `extract` received a single flattened `v_pair` handle and returned it, but its `object_params` metadata was empty. Its summary therefore reported `return_unknown=True`, with no returned parameter alias. In the caller, the result origin became `?`; `emit()` discarded that origin, so storing `q` into the returned list did not capture the original `p`. The allocation was incorrectly classified **b**, `captured=False`, even though it escapes to Python. This would make scalar elimination unsafe.

The implementer added `_object_leaf_codes`, recursively extracting object-bearing ABI codes from `ObjT`, `TupT` and `OptT`, and changed the integration to seed those parameter leaves. Unknown object returns now conservatively preserve possible argument origins as well as `?`, so an unresolved return cannot erase a known argument alias.

Independent final recheck using actual generated checked IR: the example's allocation is now **e**, `captured=True`. This blocker is resolved in the inspected source.

### Constructor-name substring exemption

The initial allocation classifier removed every passed edge whose detail contained `__init__`. An ordinary function named `my__init__read` was therefore treated as though it were an ignorable constructor call:

```python
def my__init__read(p):
    return p.x

def f():
    p = Cell(1.0)
    return my__init__read(p)
```

Actual checked source generation and analysis classified `p` as **a**, despite the explicit interprocedural use. The generated mangled name retained the substring, so this was not limited to synthetic IR. A class-a scalar lowering that did not construct the required field-passing callee could read a nonexistent object from the original arena.

The implementer removed this textual exemption. Independent final recheck: the example is now **b**, and `passed_to` includes both the constructor and the ordinary reader edges. Including constructors is conservative; it may reduce the class-a count, but avoids a name-based proof. Any future constructor exemption should use generator-recorded callable/edge identity and preserve the constructor's effects, not substring matching.

## Fixed point, effects and joins

The analysis uses a finite origin domain of parameter positions and generator-recorded allocation sites. Local aliases are unions over all definitions, so a branch join does not silently select only the last syntactic assignment. Known-callee parameter effects are projected back to actual argument origins. Returned parameter aliases and fresh allocation origins propagate through known calls, including recursive groups. Unknown calls capture their object arguments. Stores of tracked object handles into the arena or an attribute are conservatively capturing, and non-sentinel direct object comparisons observe identity.

Those choices are conservative for the reviewed checked-IR shapes. The existing recursive alias/mutation test exercises a fixed point rather than relying on function naming or a one-pass call order. No additional successful checked-IR counterexample to the currently seeded returned-parameter alias propagation was established in this review after the tuple fix.

The `conditional` bit is syntactic control context, not a proof that a nonescaping execution exists. An always-true branch or loop can still make every capture syntactically conditional. Thus class d is a description for future path-sensitive handling; it must not itself authorize eliminating a materialization. The proposed first lowering should continue to leave classes c/d/e outside its eliminated set.

## Important analysis-to-emitter contract

The current origin function intentionally does not propagate taint through arbitrary arithmetic, casts, memory loads or tuple-target assignment. This avoids treating numeric field values as pointers, but it means `EscapeAnalysis` is not a sound arbitrary-Python-AST escape engine without a checked-IR contract.

Verified standalone FunctionIR examples still demonstrate this boundary:

```python
p = alloc(I, top, st, 1)
q = p + 0
return q
```

With `object_return=True`, this can mark `p` class a while the returned object alias becomes unknown. Likewise `q=np.uint64(p); I[10]=q` and `q,r=(p,0); I[10]=q` lose the tracked origin and can mark p class a. The current checked heap generator generally avoids these object-value forms: physical `np.uint64` casts are used as indices, ordinary object copies use plain names, and generated bindings are scalar assignments. The tuple-parameter bug above illustrates why that convention needs explicit verification rather than an assumption.

Before these facts authorize elimination, the consumer must either validate the accepted checked-IR object-use grammar and decline every unexpected object-bearing use, or extend origin propagation with typed address/value distinctions. An unknown load that could contain a handle must remain unknown; do not relabel it numeric merely because the payload is represented by int64. Preserve the distinction between physical address casts in array indices and pointer values being stored or returned. Record-bearing aggregate arguments and results need leaf-aware metadata throughout.

This is a concrete prerequisite for emission, not a request for another broad profiling instrument. A small eligibility/use validator around the selected a/b candidates is sufficient for the first lowering if it declines unsupported shapes.

## Scalar-lowering constraints implied by this review

- Allocation-site origin tokens are not unique dynamic object identities. A site inside a loop or recursion can create several live objects. A local alias retaining the previous iteration's instance must not be overwritten when the next instance at the same site is scalarized. Track the SSA instances/phis, or decline overlapping dynamic lifetimes.
- Class b means a tracked object crosses a call boundary without a known capture or identity observation. It does not by itself implement field passing. Every affected constructor/callee/recursive edge needs a compatible clone or must retain the original allocation. Returned aliases must identify which virtual instance is returned.
- Multiple parameters may alias the same virtual object. A clone cannot treat their field arguments as independent copies. For example, a callee mutating `a.x` and then reading `b.x` must observe the update when the caller passed the same instance twice. Preserve alias relationships, return updated scalar fields, or decline that clone pattern.
- Two distinct objects with equal fields must remain distinct when an admitted operation can observe identity. The current identity flag is an eligibility restriction; field equality cannot replace object identity.
- Numeric-only fields still require their complete native representation. MIXED fields carry a payload and tag; nullable or polymorphic layouts also have checks/header information. Scalarization must preserve those values and checks, or decline the kind/layout. Constructor-only F2 is not a replacement for the new lifetime result.
- Keep the original checked arithmetic, exactness tests, division/error rules and status exits. Preserve capacity/growth handling for all materialized allocations. Removing a fully virtual allocation is different from suppressing a failure for an allocation that remains in the arena.
- F and I are overlapping views of the arena. No analysis or generated clone may assume they are disjoint. Field access rewriting must account for every admitted read/write/alias of the virtual object, including callee effects, rather than treating an unrecognized access as irrelevant.
- Recompute summaries when generated checked source or parameter/allocation metadata changes. Do not reuse an F2 answer from an earlier generated program or a different clone ABI.

## Metadata lifecycle and cache inspection

Allocation metadata is recorded at the object-construction `alloc` result, rather than inferred from arbitrary arena allocations. `_Gen.peek()` saves and restores the allocation map along with its existing temporary-generation state, preventing speculative type peeks from leaving phantom allocation sites. `_Gen.run()` publishes the allocation map alongside its final checked source. Metadata-only `_Gen(...).var_codes` calls do not run code generation or replace that published map.

The compile path builds escape summaries after type settling and the zero-result pass, before cycle/source merging. Facts are cleared at the start of compilation, and lifetime summaries are then recorded through the shared F2 interface. Cache keys and AOT/source digests include `escape.py`; this module is not omitted from the new cache identity. These integration points appeared consistent in the reviewed source.

## Independent verification and outcome

After the corrections, independently reran both actual checked-source examples: hidden tuple alias is class e/captured, and the ordinary reader with `__init__` in its name is class b. Independently ran `test_escape_facts` through unittest: **11 tests passed**.

The two demonstrated checked-IR classification blockers are resolved. No generated scalar lowering has been reviewed or accepted here. The next a/b emitter must enforce the explicit object-use grammar and preserve dynamic identities, aliasing and clone effects described above; summary labels alone do not discharge those lowering obligations. Native correctness, allocation-removal counts, reach and performance remain future acceptance work.
