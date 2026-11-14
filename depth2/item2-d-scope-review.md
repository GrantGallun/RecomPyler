# Class-d scope and first-escape independent review

This is a read-only scope/design review after class-c source clearance. It does not close class d, review a materializer implementation, or change any product/snapshot. No workload, native build, or timing was run.

## Classification precision

The current a/b/c/d/e table is a conservative source-site cohort table. It is not a partition of dynamic executions by whether they actually escape, and it is not a proof of a nonescaping path for every site called d.

`EscapeAnalysis.emit` compares a capture node's control ancestry with the creation node only when that allocation node is in the same scanned function. For a returned origin created in another function, it uses the caller capture node's enclosing control. A loop containing both creation and the immediately following store can therefore mark the store conditional even though it runs for every created object.

Independently checked the concrete analyzer-only example:

```python
# maker object-returning checked IR
p = alloc(I, top, st, 1)
return p

# caller checked IR
for i in range(n):
    q = maker()
    I[10] = q
return 0
```

The returned allocation is labeled d/captured. Putting the allocation directly in the caller loop before the same store labels it e/captured. Both shapes store every successfully created instance. This is a precision limitation, not an unsafe existing scalar transformation: current closed-use validation still declines the capture. A future materializer must inspect actual first-capture statements and path/identity dominance; the d label alone cannot prove that any dynamic allocation is avoidable.

Likewise, e means at least one nonconditional/unknown capture context caused the whole site to be conservatively grouped there. It does not mean every execution escapes. Context-specific c clones can remove safe executions of an e site without contradicting its baseline classification.

## Chaos: all 60,000 first stores remain necessary with real d storage

Read `wave11-census/census/inputs/chaos/run_benchmark.py`, particularly GVector.linear_combination and Spline.__call__. Each successfully returned linear-combination result immediately becomes the right-hand side of:

```python
d[index] = d[index].linear_combination(d[index + 1], co1, co2)
```

The surrounding two spline loops decide whether an instance is created; they do not create a distinct post-creation branch that skips this store. The first real storage boundary for that newly created identity is the store into the existing temporary list d. Its ordinary element representation is an arena handle. Subsequent iterations load these handles, and the spline finally returns d[0]. The list is local, but locality does not make its currently materialized element storage virtual.

Therefore a rule that only delays an object's arena allocation until its first escape, while retaining the ordinary d list, must materialize **every one of the 60,000 instances** at that store. It can move the bump from the producer to the store; it cannot eliminate those bumps. Adding fresh field returns followed immediately by materialization risks extra transport/copy work. Do not report 60,000 removable allocations or claim zero-cost escaping paths from the d classification.

Removing these bumps needs an additional proved representation change: virtual/scalar field storage for d, a specialized local list of field records, or an equivalent algorithmic lowering that preserves each element's identity and alias behavior. Such a change must also handle initial d entries aliasing self.points, repeated overwrite/read order, returning d[0], and endpoint returns that alias existing control points. It is broader than conditional-only materialization and requires its own design/review. This does not preclude building and validating the general first-escape rule on genuine conditional cases.

The immutable baseline cohort records f17_linear_combination:t9 = 60,000. The existing post-c others artifact still records those same 60,000 d bumps, consistent with the storage boundary above. These are source-IR bump counts, not native timings.

## Ray: Point d and Vector e have different context boundaries

The baseline ray d site f48___add__:t18 creates 5,333 Points through Ray.pointAtTime. Scene.rayColour obtains p after a hit and passes it to normalAt/colourAt. In SimpleSurface.colourAt, its first child-handle storage occurs when the specular branch constructs Ray(p,...): Ray.__init__ stores p into Ray.point. The Lambert path can also put p into shadow Rays through visibleLights/_lightIsVisible. Read-only baseColourAt, normal and arithmetic consumers are not by themselves escapes.

Those branches are conditional for general surfaces. In the provided default scene, all surfaces retain the default specularCoefficient 0.2, so the specular branch is taken for every successful shade invocation. Under the present representation, even a scalarized Ray carries an ordinary Point handle as its child field. Conditional-only materialization therefore still needs p's handle at that boundary in the default successful path. Eliminating it requires either a real noncapturing surface path or extending the nested virtual-field representation through every Ray consumer. A scalar parent alone does not remove its child allocation.

The baseline e site f21_scale:t7 contains 133,743 Vector executions from several contexts. Ray.__init__ stores normalized results into Ray.vector; those calls cross a child-handle boundary. In contrast, render's xcomp/ycomp values and several normalized/dot/colour consumers can remain virtual. The existing immutable abc counter has 99,648 remaining f21 bumps, 34,095 fewer than baseline, directly illustrating why e must not be described as literally always escaping. The precise safe/captured execution counts come from the selected transformed contexts and dynamic counters, not the site letter.

## Requirements for the next d design

Build the first-escape proof around an individual virtual identity and its actual capture statement, including caller creation/capture order and loop iterations. Materialize once before the first handle-requiring use, preserve all aliases and subsequent mutations, and reuse that same handle at later escapes. Unknown calls or real container/child-handle stores are boundaries until separately proved otherwise. Branch joins must retain whether that identity already has a handle; joining two dynamic instances must decline or use a separately proved representation.

Required concrete cases include a creation followed by optional capture, two aliases captured into two containers, mutation before and after first capture, a later second escape, repeated loop instances with a retained prior alias, and checked failure before/during materialization. Include the cross-function loop example above to prevent treating loop membership as an allocation-saving predicate. Preserve the original handle route for an unsupported or always-materializing context where the proposed split would add work.

For reporting, distinguish may-capture site classification, proved first-escape paths, dynamic materializations, avoided bumps and retained bumps. Chaos's immediate-store 60,000 and default ray's child-handle boundaries are concrete controls for this design, not evidence that class d as a general rule should be closed without implementation.

