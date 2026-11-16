# S58 independent implementation review: tools/difffuzz

Reviewed only `tools/difffuzz/*.py`. Ran small serial oracle/recipe probes at below-normal priority, without importing the product compiler or running suites. This is the sole capability review; fixes are checked by their regression tests, without re-review.

Six concrete findings require fixes. In the first five cases below, `compare` incorrectly returned `{'status': 'native', 'native_calls': 2, ...}`. These are executable oracle defects, independent of whether the current compiler happens to produce the corresponding wrong implementation.

Shared setup for cases 1–5 (run with `PYTHONPATH=tools`):

```python
import types
from difffuzz.core import compare, clone

class Wrong:
    compiled_calls = 0
    def __init__(self, call):
        self.call = call
    def __call__(self, *args, **kwargs):
        self.compiled_calls += 1
        return self.call(*args, **kwargs)

def module(source):
    answer = types.ModuleType('probe')
    exec(source, answer.__dict__)
    return answer
```

1. **New global bindings contaminate the compiled replay.** `compare.run` updates saved bindings but does not clear bindings created by the preceding reference call. The compiled implementation below fails to create `CREATED`, yet sees the reference side's binding and passes.

```python
m = module("def f():\n globals()['CREATED'] = 1\n return 0\n")
print(compare(m.f, Wrong(lambda: 0), (), {}, m))  # incorrectly native
```

2. **Actual types collide by module/qualified name.** `Graph.freeze` records an instance's type using `typekey(cls)` only. Two distinct existing classes with the same names become indistinguishable, violating the exact-type contract.

```python
m = module('class C: pass\ndef f(): return C()\n')
Other = type('C', (), {'__module__': 'probe'})
assert Other is not m.C
print(compare(m.f, Wrong(Other), (), {}, m))  # incorrectly native
```

3. **Reachable class mutations are silently unobserved and shared between replays.** Classes, functions and modules are cloned atomically, and their reachable attributes are absent from graph snapshots. This concrete class argument contains a reachable mutable list; modifying it passes and leaks out of the comparison. Declining such unsupported graphs is sufficient.

```python
m = module('class C:\n items = []\ndef f(c): return 0\n')
def bad_class(c):
    c.items.append('bad')
    return 0
print(compare(m.f, Wrong(bad_class), (m.C,), {}, m))  # incorrectly native
assert m.C.items == ['bad', 'bad']
```

4. **Instance-dictionary aliases are destroyed by cloning.** `clone` copies the dictionary into a newly allocated instance dictionary with `update`, but memoizes the separate copied dictionary. An explicit argument alias to `obj.__dict__` then refers to the separate dictionary. The oracle compares a different argument graph from the supplied one and accepts an incorrect result.

```python
m = module('class Box: pass\ndef f(obj, d): return d is obj.__dict__\n')
obj = m.Box()
obj.x = 1
d = obj.__dict__
assert m.f(obj, d) is True
copied = clone((obj, d))
assert copied[1] is not copied[0].__dict__
print(compare(m.f, Wrong(lambda obj, d: False), (obj, d), {}, m))  # incorrectly native
```

5. **An exceptional generator loses all preceding yielded observations.** `drive` accumulates yielded values, but a subsequent exception discards that accumulation. Equal terminal exceptions consequently hide different yields.

```python
m = module('def f():\n yield 1\n raise ValueError("boom")\n')
def bad_generator():
    yield 2
    raise ValueError('boom')
print(compare(m.f, Wrong(bad_generator), (), {}, m))  # incorrectly native
```

6. **Non-finite frozenset members crash portable replay generation.** `recipe` uses `repr(tuple(value))` for frozensets instead of its bit-exact scalar emitter. Infinity produces an unbound `inf` name and NaN an unbound `nan` name. The worker's recipe validation does not catch `NameError`, so an actual finding with such input turns into a worker error.

```python
from difffuzz.recipe import recipe
text = recipe((frozenset([float('inf')]),), {})
exec(text, {})  # NameError: name 'inf' is not defined
```

Other observations for `KNOWN-GAPS.md`, one line each:

- The first `arguments` baseline independently clones positional and keyword roots, so an alias shared between them is lost; later variants clone the combined roots.
- Portable string literals can merge two distinct equal strings; the existing reproduction validation refuses a recipe when this changes the finding.

No test, report, evidence, harness, or merge review was performed. No implementation, tests, or corpus files were changed by this reviewer.
