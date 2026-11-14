# Item 2 build design (supersedes the earlier open-only note)

EscapeAnalysis computes finite monotone origin/effect summaries over typed, checked heap IR before recursion merging. Each flattened object-parameter leaf has an origin; constructors record object allocation temp/class metadata. Aliases, fresh returns and parameter returns flow through the complete call graph until a fixed point, including recursive groups. Unknown object-return aliases conservatively include incoming object arguments. Per-parameter summaries record capture, conditional capture, returned alias, identity observations, mutation slots and forwarded callee parameters. The analysis is shared F2/F5 evidence, not a profile assumption.

Independent review found and closed hidden tuple-parameter aliases, unknown-return alias loss and an accidental constructor-name substring filter. Regressions also cover arithmetic/cast aliases, tuple binding, recursive mutation and path-relative capture. Every scalar emitter additionally validates a closed generated-IR use grammar and domination; the summary's allocation-site token alone does not identify overlapping dynamic instances.

## Allocation classes before emission

Numbers are `source sites / dynamic successful bumps` in the stated hot root. Source logical counters reconcile raytrace to **734,941**, with the exact prior high water 3,730,723 slots and full original pixel bytes. Counters are not timing results, Python constructor events or malloc counts. Barnes is 100 advances with every final particle byte checked; float is 100,000 points; chaos is its default create-image call. `other` is container/helper bumps outside instance scalar replacement.

| Program | a local | b safe calls | c fresh return | d possible path escape | e captured / conservative escape | other bumps |
|---|---:|---:|---:|---:|---:|---:|
| raytrace | 1 / 1 | 3 / 98,171 | 7 / 319,199 | 1 / 5,333 | 1 / 133,743 | 178,494 |
| Barnes | 0 / 0 | 1 / 100 | 0 / 0 | 0 / 0 | 10 / 43,832 | 31,416 |
| chaos | 0 / 0 | 1 / 1 | 2 / 10,000 | 1 / 60,000 | 0 / 0 | 20,520 |
| float | 0 / 0 | 0 / 0 | 0 / 0 | 0 / 0 | 1 / 100,000 | 4 |
| go | 0 | 0 | 0 | 0 | 7 unknown-constructor source sites / 769 Python constructors | not native counts |
| nbody | 0 | 0 | 0 | 0 | 0 | no instance constructors |

Go's native root declines because Board.__init__ uses its new receiver before all attributes are set; unknown constructor/callee effects conservatively escape. Its 769 count is a separately labelled Python constructor count with profiler on/off identical result; it is never pooled with native bump totals. Nbody's candidate root declines for a power other than **2, but its source has no instance constructors, so R8 has no instance sites there. The six-program source/typed boundary is explicit, not hidden as zero native deployment.

Raytrace a+b cover 98,172/734,941 = 13.36% of all generated bumps (17.64% of 556,447 instance bumps). Class c covers 43.43% of all bumps; d 0.73%; e 18.20%; containers 24.29%. Thus class a alone is not expected to realize half the 0.7422 ms typed-geometry bound. The first class is still built/tested in order; b and c are the meaningful allocation scopes. The Barnes 5.2134 ms native representation ceiling is a compound ceiling, not a bound assignable to its 100 root-object bumps.

## Scalar and clone form

Keep one scalar variable per admitted F/I field slot, preserving complete MIXED payload/tag representation. All arithmetic and existing status/failure checks stay unchanged. A private local owner and its aliases map to one virtual field set; closed-use and single-definition dominance checks reject previous-iteration aliases, mixed identities and unknown pointer use. Preserve the F/I overlap model by replacing only exact typed field-slot accesses; reject mismatched memory-space/offset uses and polymorphic layouts.

For a safe callee, keep the original handle function and add a field-passing clone. Multiple parameters aliasing the same virtual object share one field set in the clone. Return updated fields alongside the original scalar return, including checked failure paths, so mutations remain visible to every caller alias. Exact returned parameter aliases may propagate the same virtual identity. Fresh object returns need class c's separate return clone; conditional capture needs materialization and remains in the arena until that step.

Clone metadata joins the existing recursive group/context machinery rather than inventing a second recursive ABI. Class a is enabled first; its independent review, native tests, count removal and three-pair check precede enabling b. One full suite and ten-pair acceptance are reserved for the completed item2 implementation. Evidence: allocation-class-table-v2.json, immutable allocation-classes-ray-v1.json / allocation-classes-others-v1.json / allocation-classes-go-v1.json, escape-review.md and tests/test_escape_facts.py / test_scalar_fields.py.

Class a/b field representation uses complete native field slots, including unchanged child/object/container handles. Numeric payload and tag slots retain their checked operations; retaining a child handle does not imply that the child allocation is virtual. S24 combines a/b acceptance and requires c before closure.
