# Item 3 executed-weight bound

S27 supersedes the static halfway interpretation in CHECKPOINT35. The corrected source table is36/70ray:6fixed-float+24constant-range+6guarded input otherColour conversions. Barnes remains12/26prospective under its dimension guards. No R7 rewrite is deployed.

One instrumented checked-IR render evaluates all70baseline rows across151emitted contexts: 4,399,585comparisons. Instrumentation off/on/reference renders match every pixel and arena highwater; short-circuit predicate order is preserved by wrapping individual Compare nodes. This is source-IR execution weight, not machine instructions or measured check time.

The removable set evaluates 211,731times (4.8125%):75,999fixed-float and135,732range cases. Retained checks evaluate4,187,854times (95.1875%). Under S27.1/S27.3 the removable weighted share is belowhalf, so item3 can stop after review without a guarded emitter or unchanged-source timing cohort.

| Retained cause | Source rows | Executions | Concrete definitions |
|---|---:|---:|---|
| Field/call/accumulator int/float joins |28|4141855| Point/Vector coordinate integer inputs, unit-vector literals, Sphere.radius integer2 and float0.4, field constructor/store/call results, lambert accumulator0 |
| Integer colour operand without all-definition range |6|45999| Returned integer black/base colours and scale/plot integer multipliers before conversion/clamp |
| Analysis does not follow a call/container |0|0| All actual checked calls and applicable field/cell stores followed; no unknown object-effect call |
| Observable return/print kind alone |0|0| Not the reason for any retained ray comparison; existing F4 observability proof holds |

The old40kept rows comprise these34retained rows plus six immutable input tuple conversions now guarded candidates (11,736evaluations). The family-canonical field audit records only Scene.recursionDepth writes, no Surface constructor in the typed call graph, and immutable integer tuple leaves for otherColour. A sound prospective guard covers each reached typed f58 invocation before its body and selects the existing checked body on miss; this is per-call cost, not once per render.

Allocation separation: locally allocated float Points/Vectors and integer-initialized input coordinates are distinguished by the points-to/tag-cell analysis. Shared Ray child handles, generic coordinate methods and recursive call parameters rejoin their origins, and each retained row includes a real possible integer producer. Existing a+b+c clones distinguish virtual argument shape/identity, not every numeric kind context; a creation-site float fact cannot be applied to an entire shared consumer. More kind-context cloning or F1 ranges conditioned on integer-producing fields may unlock these checks. No claim that the hot executions are all integer or that further proof is impossible is made.

Top contributors: dot2,549,350(57.94%), Point subtraction833,595(18.95%), intersection717,828(16.32%). Leaving out dot leaves1,850,235evaluations, with the same211,731removable(11.44%); the decision is not reversed by removing the largest contributor. No static/execution share is converted into a millisecond bound;0.8883ms remains the historical conditional fixed-kind counterfactual.

Full per-comparison rows, each weight, all clone contexts, tag-cell/SSA reaching definitions and guard candidates follow in kind-flow-table-weighted.json. Raw counts/process scope and the complete-output gate are kind-comparison-weights-ray.json/log and count_kind_comparisons.py. Independent review: item3-kind-flow-review.md; focused analysis tests: kind-flow-red.log/green.log.

| Baseline comparison | Decision | Executions | Cause |
|---|---|---:|---|
|f2___sub__:1|kept|277865|genuine field/call/accumulator kind join|
|f2___sub__:2|kept|277865|genuine field/call/accumulator kind join|
|f2___sub__:3|kept|277865|genuine field/call/accumulator kind join|
|f24_cross:1|kept|2|genuine field/call/accumulator kind join|
|f24_cross:2|kept|2|genuine field/call/accumulator kind join|
|f24_cross:3|kept|2|genuine field/call/accumulator kind join|
|f24_cross:4|kept|2|genuine field/call/accumulator kind join|
|f24_cross:5|kept|2|genuine field/call/accumulator kind join|
|f24_cross:6|kept|2|genuine field/call/accumulator kind join|
|f24_cross:7|kept|2|genuine field/call/accumulator kind join|
|f24_cross:8|kept|2|genuine field/call/accumulator kind join|
|f24_cross:9|kept|2|genuine field/call/accumulator kind join|
|f27___add__:1|removed|20000|prospective removed|
|f27___add__:2|removed|20000|prospective removed|
|f27___add__:3|removed|20000|prospective removed|
|f30_rayColour:1|range-discharged|68|prospective range-discharged|
|f30_rayColour:2|range-discharged|68|prospective range-discharged|
|f30_rayColour:3|range-discharged|68|prospective range-discharged|
|f30_rayColour:4|range-discharged|68|prospective range-discharged|
|f30_rayColour:5|range-discharged|68|prospective range-discharged|
|f30_rayColour:6|range-discharged|68|prospective range-discharged|
|f30_rayColour:7|range-discharged|9932|prospective range-discharged|
|f30_rayColour:8|range-discharged|9932|prospective range-discharged|
|f30_rayColour:9|range-discharged|9932|prospective range-discharged|
|f30_rayColour:10|range-discharged|9932|prospective range-discharged|
|f30_rayColour:11|range-discharged|9932|prospective range-discharged|
|f30_rayColour:12|range-discharged|9932|prospective range-discharged|
|f71_plot:1|kept|10000|unbounded integer colour operand|
|f71_plot:2|kept|10000|unbounded integer colour operand|
|f71_plot:3|kept|10000|unbounded integer colour operand|
|f32_intersectionTime:1|kept|179457|genuine field/call/accumulator kind join|
|f32_intersectionTime:2|kept|179457|genuine field/call/accumulator kind join|
|f32_intersectionTime:3|kept|179457|genuine field/call/accumulator kind join|
|f32_intersectionTime:4|kept|179457|genuine field/call/accumulator kind join|
|f54_colourAt:1|range-discharged|5333|prospective range-discharged|
|f54_colourAt:2|range-discharged|5333|prospective range-discharged|
|f54_colourAt:3|range-discharged|5333|prospective range-discharged|
|f54_colourAt:4|range-discharged|5333|prospective range-discharged|
|f54_colourAt:5|range-discharged|5333|prospective range-discharged|
|f54_colourAt:6|range-discharged|5333|prospective range-discharged|
|f54_colourAt:7|kept|9066|genuine field/call/accumulator kind join|
|f18_dot:1|kept|509870|genuine field/call/accumulator kind join|
|f18_dot:2|kept|509870|genuine field/call/accumulator kind join|
|f18_dot:3|kept|509870|genuine field/call/accumulator kind join|
|f18_dot:4|kept|509870|genuine field/call/accumulator kind join|
|f18_dot:5|kept|509870|genuine field/call/accumulator kind join|
|f48___add__:1|removed|5333|prospective removed|
|f48___add__:2|removed|5333|prospective removed|
|f48___add__:3|removed|5333|prospective removed|
|f58_baseColourAt:1|range-discharged|1956|prospective range-discharged|
|f58_baseColourAt:2|range-discharged|1956|prospective range-discharged|
|f58_baseColourAt:3|range-discharged|1956|prospective range-discharged|
|f58_baseColourAt:4|range-discharged|1956|prospective range-discharged|
|f58_baseColourAt:5|range-discharged|1956|prospective range-discharged|
|f58_baseColourAt:6|range-discharged|1956|prospective range-discharged|
|f64_scale:1|kept|5333|genuine field/call/accumulator kind join|
|f64_scale:2|kept|5333|genuine field/call/accumulator kind join|
|f64_scale:3|kept|5333|genuine field/call/accumulator kind join|
|f68_scale:1|kept|5333|unbounded integer colour operand|
|f68_scale:2|kept|5333|unbounded integer colour operand|
|f68_scale:3|kept|5333|unbounded integer colour operand|
|f68_scale:4|range-discharged|5333|prospective range-discharged|
|f68_scale:5|range-discharged|5333|prospective range-discharged|
|f68_scale:6|range-discharged|5333|prospective range-discharged|
|f68_scale:7|range-discharged|5333|prospective range-discharged|
|f68_scale:8|range-discharged|5333|prospective range-discharged|
|f68_scale:9|range-discharged|5333|prospective range-discharged|
|f70___sub__:1|kept|5333|genuine field/call/accumulator kind join|
|f70___sub__:2|kept|5333|genuine field/call/accumulator kind join|
|f70___sub__:3|kept|5333|genuine field/call/accumulator kind join|
