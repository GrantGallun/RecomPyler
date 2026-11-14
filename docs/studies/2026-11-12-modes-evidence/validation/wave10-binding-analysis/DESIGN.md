# Positional binding experiment

Base commit: a5d11d7745da8d324e46e544f929849c0598cddd.
Checkout: wave10-binding, branch codex/wave10-binding. The 65 tracked source,
test and experimental-doc files match wave10-combined byte for byte initially.
Eight copied test files show worktree status from preserved line-ending bytes;
the coordinator reports these statuses have no semantic diff.
Ignored support binaries are copied exactly: _heap SHA256 17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0;
_monitor SHA256 00d6138bbf198ecff79cea44e18de1d122727c3c0e2acacbe9260a603f22e9e5.

Only experimental.py and its test file are owned here. Original measured a5d
artifacts, full-process distributions and source trees remain unchanged.

## Narrow fast path

After the current function-code and binding-metadata guards, use a positional
fast path only when type(args) is tuple, kwargs is None or an exact empty dict,
and the fixed supported function has no keyword-only parameters. Positional-only
parameters count in code.co_argcount exactly as CPython does. No varargs are
eligible in an experimental wrapper.

Read current __defaults__ on each call. Let N be positional parameter count, A
the tuple length and D the defaults count. Reject A>N or N-A>D. For missing
parameters append the final N-A defaults, using tuple base operations so tuple
subclasses cannot add hooks. This also handles D>N by taking the last defaults.
Do not interpret actual inspect.Parameter.empty values as missing; they are real
values and reach the normal type/representation guard. Retain the canonical
tuple directly through guard execution and Region.attempt(_bound_entry=True).
Parameter names, contract guard positions/intervals and loop-stop positions are
precomputed once from the captured code and immutable contract. Keyword/signature
binding continues to produce its values dict, then canonicalizes once to the same
tuple. Numeric mode is read once per attempt rather than once per parameter.

Invalid arity returns the existing checked guard miss, allowing the ordinary
checked wrapper to replay original Python with exact binding errors. Unchecked
rejects with NumericContractError without calling the original body. Exact
keyword dictionaries with contents, keyword-only functions, tuple subclasses and
other direct-attempt arg containers stay on the existing code-Signature path.

## Tests and evidence

Draft RED tests spy on the real _binding_signature helper only after wrapper
construction. Positional calls (including omitted defaults and invalid arity or
values) must allocate no Signature while retaining actual native/guard outcomes.
Keyword and keyword-only calls must still use the existing helper. Additional
cases cover live defaults, oversized defaults tuples, sentinel values, positional
only parameters, arity failures and tuple-subclass hook avoidance. No runtime
code or benchmarks run until the coordinator grants the targeted CPU slot.

After RED/GREEN and a focused suite freeze, the measurement agent owns comparison
against the unchanged a5d cohort. Removing Signature construction is a hypothesis
about complete-call overhead, not a performance claim until that comparison.

## Checked wrapper checks discharged by the existing contract

IntIntervals construction proves all parameter endpoints fit signed int64. After
an exact-int check, membership in such an interval implies int64 representation;
the separate checked wrapper INT_MIN/MAX comparison is redundant. Retain the
ordinary native scalar loader check. For a checked loop the validated literal or
unrebound stop parameter already has max(0,stop)<=1024 by construction and its
entry interval guard, so its second wrapper operational-cap comparison is also
redundant. Negative/out-of-interval/huge integer calls still guard-miss and replay
Python. Unchecked tight bounds are documentary: retain its exact-int/int64 checks
and separate <=1024 operational loop cap unchanged.
