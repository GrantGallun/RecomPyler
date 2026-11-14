# Explicit experimental integer modes

Ordinary `lift_region` and `lift_numeric(function)` retain the current strict
Python behavior. These experiments require an explicit import and mode:

```python
from recompyler.experimental import IntIntervals, lift_numeric

def mul_add(x, y, z):
    return x * y + z

contract = IntIntervals(x=(-2**20, 2**20), y=(-2**20, 2**20), z=(-2**20, 2**20))
checked = lift_numeric(mul_add, mode="checked", contract=contract)
wrapping = lift_numeric(mul_add, mode="unchecked-int64", contract=contract)
```

`IntIntervals` is an immutable mapping of inclusive exact-Python-int bounds.
Explicit numeric modes require an exact `IntIntervals` instance; subclasses with
custom mapping behavior are rejected so proof and runtime guards share identical
immutable bounds. Parameter names must be exact Python strings.
Every parameter must be named exactly once. Invalid configuration raises
`TypeError` or `ValueError`; bounds must be ordered and fit signed int64.

Checked mode guards exact Python `int` type and each parameter's interval before
native execution. A miss calls the original function with the original
arguments, preserving arbitrary-size integers, bools, subclasses, floats,
binding errors and result types. The compiler proves every intermediate +,-,*
using arbitrary-precision interval arithmetic. Only certified exact-int sites
omit their overflow helper and its status test. An unprovable intermediate or
unsupported region raises `UnsupportedNumericRegion` at construction; a small
final result does not excuse an overflowing intermediate.

Unchecked mode deliberately gives each +,-,* signed two's-complement modulo
2**64 semantics. It always requires exact Python ints representable in signed
int64; invalid types/representations raise `NumericContractError` before native
execution. The tighter declared intervals are documentary, so:

```python
assert checked(2**40, 2**40, 1) == 2**80 + 1  # original Python replay
assert wrapping(2**40, 2**40, 1) == 1          # explicit modulo arithmetic
```

The intrinsic LLVM operations carry no `nsw`/`nuw` promise. Unchecked mode does
not silently replay Python when a native guard, compilation or execution fails:
it raises `NumericContractError`, because replay would change its arithmetic.
Invalid Python argument binding raises `NumericContractError` before any body
can run. All indexing, capacity, loader and other memory-safety checks remain;
this pilot does not admit heap/array operations at all.

## Supported pilot

Source-backed, plain synchronous functions with fixed positional-only,
positional-or-keyword and keyword-only parameters. Current defaults are bound on
every call without evaluating annotations or custom signature/wrapper metadata.
Custom `__signature__`/`__wrapped__` metadata is rejected for explicit modes.
Arithmetic is scalar Name/int-literal +,-,* with name assignments, parallel
scalar tuple assignments, name augmented assignments and one terminal scalar
return. Globals, closures, arbitrary calls, branching, division, dynamic unary
operations, recursion, generators and heap operations are excluded.

One nonnested `for i in range(stop)` loop is supported. `range` must be the
builtin; `stop` must be an integer literal or an entry parameter never rebound
in the function. The body uses the same arithmetic/assignment grammar, without
break, continue, else or return. Checked proof enumerates abstract states up to
the contract's maximum trip count, proves every reached intermediate, unions
certificates per source site, and joins all possible exit states including zero
trips. Names read afterward must be definitely bound on every such exit.
The runtime remains a loop. Proof work is capped at 1024 trips. Unchecked calls
retain an independent operational guard of at most 1024 trips; negative stops
produce zero trips. That guard is separate from the documentary tight interval.

```python
def fibonacci(n):
    a, b = 0, 1
    for i in range(n):
        a, b = b, a + b
    return a

fib = lift_numeric(fibonacci, mode="checked", contract=IntIntervals(n=(0, 80)))
```

The pilot uses the existing heap compiler, native ABI, loader and executor.
`mode`, `contract`, `identity` and immutable `proof_certificates` describe the
selection. `contract_native_calls`, `guard_misses`, `representation_rejections`,
`loop_limit_rejections` and `native_failures` distinguish outcomes. Existing
`compiled_calls`, `jit_calls`, `aot_calls` and `fallback_calls` retain their
meaning: only completed native execution increments JIT/AOT counters. Direct
`attempt` calls perform the same entry guards.

Ordinary positional calls without keyword-only parameters bind directly from the
captured parameter order and current defaults. Keyword calls and keyword-only
functions use the general binder. Both paths retain the same policy guards:

| Wrapper guard | Checked | Unchecked-int64 |
| --- | --- | --- |
| Exact Python `int` type | Required | Required |
| Tight interval | Required; miss replays Python | Documentary |
| Separate int64 representation comparison | Implied by the validated tight interval | Required |
| Separate 1024-trip loop cap | Implied by the guarded stop interval or validated literal | Required |

The native scalar loader's representation check and all other native checks
remain in place. Checked huge integers, negative or out-of-contract loop stops,
and changed defaults still follow the original Python call when guards miss.

## Explicit saved native artifacts

```python
from recompyler.experimental import build_numeric, load_numeric

checked(3, 4, 5)  # complete one actual native specialization first
manifest = build_numeric(checked, "saved_numeric")
restored = load_numeric(mul_add, manifest, mode="checked", contract=contract)
assert restored(3, 4, 5) == 17
```

The separate manifest seals mode, contract, proof/schema versions, originating
source/bytecode, numeric implementation/intrinsics, native loader ABI, generated
source digest, Python runtime and native binary hash. Loading checks all these
before importing the extension and does not import Numba. A changed mode,
contract, source, implementation, runtime or binary is rejected with
`NumericContractError`. Saved artifacts never restore interval proofs from
type-only strict inference seeds. The normal strict runner builder ignores
experimental wrappers; it cannot automatically discover a wrapping export.

This is an experimental semantic/assembly pilot. Tiny scalar calls can lose time
to Python binding, guards and the existing loader boundary. No speedup follows
merely from removing arithmetic checks. Compare complete calls and actual
selected native code separately, and use contract-matched C references.
