# S58 single implementation review: original function/cell and visitor family

Reviewed the whole `_functions.py` function/default/cell capability, `_managed_cells.py`, visitor changes since `e150`, current public routing/admission deltas, and only the new `borrow_root` constructor beyond the previously reviewed canonical ABI. Included the final visitor use of the existing canonical `concat_object` for ordinary Add. Shared wave16 operation implementations and earlier canonical/bridge/format/slice implementations were outside the review; their interfaces were read only as needed. No tests, harnesses, reports or evidence were reviewed. Probes were small, serial, and below-normal.

Two concrete finalizer-order differences were confirmed. Both run natively as `FunctionRegion` and need fixes or conservative refusal. They are this review's only fix requirements; regression tests check fixes without re-review.

Shared setup (`PYTHONPATH=src`):

```python
import linecache, types
from recompyler.managed import lift_managed
_index = 0
def fixture(source):
    global _index
    _index += 1
    filename = 'wave17-review-family-' + str(_index) + '.py'
    linecache.cache[filename] = (len(source), None, source.splitlines(True), filename)
    m = types.ModuleType('wave17_review_family_' + str(_index))
    exec(compile(source, filename, 'exec', dont_inherit=True), m.__dict__)
    return m.f, lift_managed(m.f)

events = []
class Item:
    def __init__(self, name): self.name = name
    def __del__(self): events.append(self.name)
```

1. **Ordinary local cleanup follows mapping insertion order rather than CPython's fast-local cleanup order.** Alternate control paths expose the difference; the false branch happened to match and the true branch does not.

```python
original, compiled = fixture('''def f(factory, flag):
 if flag:
  a = factory("a")
  b = factory("b")
 else:
  b = factory("b")
  a = factory("a")
 def inner():
  return 0
 return 0
''')
original(Item, True)
expected = list(events)
events.clear()
compiled(Item, True)
actual = list(events)
assert expected == ['b', 'a']
assert actual == expected  # actual: ['a', 'b'], native=1, fallback=0
```

The original variable order is `('factory', 'flag', 'a', 'b', 'inner')`. This case has no cell/free variables, so the immediate implementation path uses a plain private dictionary rather than `_Frame`.

2. **Mixed captured-cell and ordinary-local owners are released in the wrong relative order.** This exercises `_Frame` itself. Keeping cell references separately and allowing the ordinary local dictionary to release first changes visible finalizer order.

```python
events.clear()
original, compiled = fixture('''def f(factory):
 a = factory("a")
 b = factory("b")
 def inner():
  return a
 return 0
''')
original(Item)
expected = list(events)
events.clear()
compiled(Item)
actual = list(events)
assert expected == ['a', 'b']
assert actual == expected  # actual: ['b', 'a'], native=1, fallback=0
```

Here `co_varnames == ('factory', 'b', 'inner')` and `co_cellvars == ('a',)`. A cleanup fix must release the private frame's references in the original order while preserving escaped closure cells and their contents. The generic factory protocol routes this witness to FunctionRegion; no claim is made that native visitors admit this particular factory.

No additional concrete wrong result, crash or retained owner leak was found in the reviewed cell/default creation, visitor helper binding, ordinary native Add consumption, or `borrow_root` constructor. A proposed builtins-rebinding counterexample matched CPython and is not a finding; a protected empty-cell exception probe declined cleanly. No implementation, tests or corpus files were changed. This completes the single review round.
