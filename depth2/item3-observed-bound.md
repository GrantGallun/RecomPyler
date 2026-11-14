# S29 observed logical-kind bound

A tag-preserving checked-IR render counts each arithmetic operation after its payload is computed, before its flag/exactness branch. Thus float executions are counted even when the checked integer-only predicate is skipped. On/off/reference full pixels and arena highwater match.28retained rows execute4,141,855times, exactly reconciling their prior execution weights.

All operands are float in3,259,374executions(78.6936%); at least one operand is float in3,955,920(95.5108%); both operands are integer in185,935(4.4892%). This supports building guarded float-kind versions rather than stopping on the static4.8%proof set. Integer paths remain required, especially initial coordinate differences and dot products of integer-initialized components.

| Baseline row | Operations | All float | Any float | Integer only |
|---|---:|---:|---:|---:|
|f18_dot:1|509870|96.077%|98.039%|10001|
|f18_dot:2|509870|100.000%|100.000%|0|
|f18_dot:3|509870|98.039%|100.000%|0|
|f18_dot:4|509870|72.542%|86.271%|70001|
|f18_dot:5|509870|86.271%|100.000%|0|
|f24_cross:1|2|50.000%|100.000%|0|
|f24_cross:2|2|50.000%|100.000%|0|
|f24_cross:3|2|100.000%|100.000%|0|
|f24_cross:4|2|50.000%|100.000%|0|
|f24_cross:5|2|50.000%|100.000%|0|
|f24_cross:6|2|100.000%|100.000%|0|
|f24_cross:7|2|50.000%|100.000%|0|
|f24_cross:8|2|50.000%|100.000%|0|
|f24_cross:9|2|100.000%|100.000%|0|
|f2___sub__:1|277865|33.795%|96.401%|10001|
|f2___sub__:2|277865|55.388%|100.000%|0|
|f2___sub__:3|277865|0.000%|74.808%|70001|
|f32_intersectionTime:1|179457|85.550%|85.550%|25931|
|f32_intersectionTime:2|179457|100.000%|100.000%|0|
|f32_intersectionTime:3|179457|100.000%|100.000%|0|
|f32_intersectionTime:4|179457|85.550%|100.000%|0|
|f54_colourAt:7|9066|46.812%|100.000%|0|
|f64_scale:1|5333|100.000%|100.000%|0|
|f64_scale:2|5333|100.000%|100.000%|0|
|f64_scale:3|5333|100.000%|100.000%|0|
|f70___sub__:1|5333|100.000%|100.000%|0|
|f70___sub__:2|5333|100.000%|100.000%|0|
|f70___sub__:3|5333|100.000%|100.000%|0|

| Function | Calls | All direct read/input tags float on entry |
|---|---:|---:|
|f2___sub__|277865|0.000%|
|f18_dot|509870|72.542%|
|f24_cross|2|50.000%|
|f32_intersectionTime|179457|85.550%|
|f54_colourAt|5333|100.000%|
|f64_scale|5333|100.000%|
|f70___sub__|5333|100.000%|

These entry sets cover directly read MIXED fields and scalar MIXED input tags, not arbitrary fields read in transitive callees; the JSON lists each exact guard expression and unresolved/internal dependencies. Dot has six field tags and72.542%all-float calls; the intersection entry statistic primarily reflects the radius tag, so it is not proof all nested subtraction/dot inputs are float. A body may drop a check only for an input kind established by its own guard or a proven fixed-kind callee edge; internal integer-only producers retain integer semantics.

Integer definitions include input Point coordinates, Vector unit literals, integer Sphere.radius2, and integer accumulators0. They account for real integer-only operations, but only4.49%of these hot operations overall, so the MIXED version is a necessary fallback rather than a reason to stop.

Next: general per-function guarded numeric versions over tag-preserving IR after scalar replacement. Guard actual field/scalar tags before either body, preserve all expression/status/error order and ordinary MIXED miss behavior, reject mutable/unknown input-field effects, and direct-call a fixed callee only when caller guard/SSA facts establish its guard. No timing or native-specialization gain is claimed from these counts.
