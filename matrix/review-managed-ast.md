# S60 single implementation review: managed AST slice

Reviewed the new `_managed_native.py`, `managed.py`, and the `provenance.py` changes against `04156f9b`. No prior S57 implementation, tests, harnesses, reports, design, or evidence were re-reviewed. Small serial probes compiled only the listed managed functions at below-normal priority; no suite was run. No implementation files were edited.

The following ten executable defects were confirmed. They belong to this one review round; the fixes need regression tests, without re-review. Conservative refusal is sufficient for forms the first slice cannot implement correctly.

Common setup (`PYTHONPATH=src`):

```python
import gc, linecache, sys, types
from recompyler.managed import lift_managed
_index = 0
def fixture(source, **values):
    global _index
    _index += 1
    filename = 'wave17-review-managed-' + str(_index) + '.py'
    linecache.cache[filename] = (len(source), None, source.splitlines(True), filename)
    m = types.ModuleType('wave17_review_managed_' + str(_index))
    m.__dict__.update(values)
    exec(compile(source, filename, 'exec', dont_inherit=True), m.__dict__)
    return m, lift_managed(m.f)
```

1. **Default f-string conversion calls the wrong protocol.** `_str` implements `str(value)`, while an unconverted formatted value requires `value.__format__('')`.

```python
class Formatted:
    def __format__(self, spec): return 'FORMAT'
    def __str__(self): return 'STR'
m, c = fixture('def f(x):\n return f"{x}"\n')
x = Formatted()
assert m.f(x) == 'FORMAT'
assert c(x) == 'FORMAT'  # actual: 'STR', native
```

2. **A folded tuple literal loses its original owner.** The tuple expression emitter allocates despite the original constant binding being available.

```python
m, c = fixture('def f():\n return ("left", "right")\n')
assert c() is m.f()  # fails: equal new tuple, native
```

3. **Comprehension targets overwrite outer locals.** The emitter shares one local-name map between the comprehension and enclosing scope.

```python
m, c = fixture('def f(items, x):\n values = [x for x in items]\n return x\n')
a, b = object(), object()
assert m.f([a], b) is b
assert c([a], b) is b  # actual: a, native
```

4. **A later assignment does not establish lexical local scope for earlier reads.** A read before assignment is captured from globals instead of raising `UnboundLocalError`.

```python
old, arg = object(), object()
m, c = fixture('def f(x):\n y = G\n G = x\n return y\n', G=old)
# m.f(arg) raises UnboundLocalError.
c(arg)  # actual: returns old, native
```

5. **A newly inserted global can shadow a captured builtin without invalidating its guard.** The dependency records the builtin dictionary entry, but not absence from the function's globals.

```python
m, c = fixture('def f(x):\n if isinstance(x, int):\n  return "yes"\n return "no"\n')
m.isinstance = lambda *args: False
assert m.f(1) == 'no'
assert c(1) == 'no'  # actual: 'yes', native
```

6. **In-place keyword-default rebinding is missed.** The signature freezes values while the guard only compares the defaults dictionary's identity.

```python
a, b = object(), object()
m, c = fixture('def f(*, x=OLD):\n return x\n', OLD=a)
m.f.__kwdefaults__['x'] = b
assert m.f() is b
assert c() is b  # actual: a, native
```

7. **A predicate used as a value escapes as an uncaught compiler error.** `isinstance` produces native bool, but the fixed entry result ABI requires managed ownership.

```python
fixture('def f(x):\n return isinstance(x, int)\n')
# Actual construction: numba TypingError, no bool -> ManagedPyObject conversion.
```

8. **Exceptional propagation leaks live managed temporaries.** The raw exception return from `_propagate` bypasses local NRT cleanup. The following retains one list/object reference per failed call.

```python
m, c = fixture('def f(obj):\n values = [obj]\n answer = obj.missing\n return [values, answer]\n')
obj = object()
gc.collect()
before = sys.getrefcount(obj)
for _ in range(5):
    try: c(obj)
    except AttributeError: pass
gc.collect()
assert sys.getrefcount(obj) == before  # actual: 2 -> 7
```

9. **A callback can rebind a global after entry guards pass.** Allowed truth hooks run Python, but later global reads still use captured pool values.

```python
old, new = object(), object()
m, c = fixture('def f(x):\n if x:\n  return G\n return G\n', G=old, NEW=new)
class Truth:
    def __bool__(self):
        m.G = m.NEW
        return True
assert m.f(Truth()) is new
m.G = old
assert c(Truth()) is new  # actual: old, native
```

10. **Explicit raise treats a tuple message as multiple constructor arguments.** `PyErr_SetObject(E, message)` is not equivalent to constructing `E(message)` with one argument.

```python
m, c = fixture('class E(Exception):\n def __init__(self, message):\n  super().__init__(message)\ndef f(x):\n raise E(x)\n')
# m.f((1, 2)) raises E, args=((1, 2),).
c((1, 2))
# Actual: TypeError: E.__init__() takes 2 positional arguments but 3 were given.
```

No additional hypothetical requirements are raised by this review.
