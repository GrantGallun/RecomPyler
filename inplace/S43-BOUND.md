# S43 remaining-floor bound

One pass, using checkpoint70's exclusive scope clock, completes in4.032s under the lock. Source and helper hashes are pinned;128 observed calls in each case have exactly128 compiled/JIT completions, zero AOT/fallback, one actual compiled dispatcher entry and status0. Direct helper probes are separately labelled and their aggregate counters are not confused with ordinary wrapper completions.

| Ordinary direct call | Python us | Region us |
|---|---:|---:|
| Field/comparison |0.048700|6.087000|
| Scalar arithmetic |0.049004|2.295726|

These are a new diagnostic context, not a replacement for checkpoint74's three-pair7.059526->5.806244us and4.710888->1.964356us comparison. The scalar descriptive envelopes are attempt1.957836us, scalar helper1.709802us, dispatcher call envelope0.378582us, guards-only0.128622us. The dispatcher envelope includes its lambda, attribute lookup and star-argument packing. None of these envelopes can be summed/subtracted as causal savings or credited as a valid deployed replacement.

Exclusive diagnostic scopes (us, sorted; all observer costs retained):

| Scope | Scalar | Field |
|---|---:|---:|
| Scalar helper residual |5.205469|0|
| Attempt residual Python work |3.484375|14.122656|
| Binding |2.502344|3.621875|
| Argument packing and fixed-kind validation |1.512500|included in load|
| Result preparation |1.378906|1.615625|
| Wrapper bytecode/counter dispatch |1.306250|1.797656|
| Outer observer/call packing envelope |1.181250|1.612500|
| Program/descriptor lookup envelope |1.052344|2.996875|
| Native dispatcher and return boxing |0.952344|1.203125|
| Live guards |0.821094|1.834375|
| Primitive result conversion |0.726563|0.803125|
| Control writes |0.676563|1.553125|
| Reused buffer access |0.625781|1.784375|
| Graph load/validation/staging |0|7.859375|
| Staged payload copy |0|1.869531|

The scalar helper performs Python argument-list creation and exact-kind/range checks, metadata reads, guards, buffer/control access, dispatcher invocation, numeric-result codes list/conversion and completion bookkeeping; __call__/attempt add binding/packing and dispatch frames. Source inspection plus the small dispatcher envelope support a predominantly Python wrapper/check/packing floor. Instrumented scopes exceed the ordinary2.30us and are not an additive decomposition of it. Native return boxing remains inside native_ns; argument tuple/dict packing before observed Python method entry remains in the outer observer envelope. No separate C-boxing or packed-argument nanosecond claim is made.

Decision under S43.3: build an actual C-level vectorcall callable, keeping exact guards, raw native status/boxing and existing-wrapper fallback, with full API/observer/AOT/audit proof. Field input conversion stays Step2 underS43.4. The implementation estimate exceeds3hours: native public Region type/override compatibility, no-NRT raw JIT+sealed AOT entry, and C-native outcome/independent audit are each substantial mechanisms (roughly1-2hours each, not measurements). UnderS43.5 first measure unchanged33-program selection and commit the reviewed/tested current fixed-cost rules as partialStep4a, then implement native entry asStep4b. Final whole-Step4 acceptance still requires all original measurements; no target or missing proof is waived.

Raw evidence: s43-remaining-components-v1/complete.json, logs/s43-remaining-components-v1.receipt.json; independent instrument review in S41-REVIEW.md.
