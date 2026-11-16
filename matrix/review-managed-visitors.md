# S58 single implementation review: native nested AST visitors

Reviewed the new `_visitors.py`, the optional descendant-iterator transfer in `_managed_recursion.py`, and the small visitor factory/admission/counter/routing changes in `_call_bridge.py` and `managed.py` against `1bb1cd1a`. Shared compiler code was read only as integration context; accepted bridge, format, structure and slice implementations were not re-reviewed. No tests, harnesses, reports, design or evidence were reviewed. Probes were small, serial, and below-normal; no suite was run.

Three concrete executable defects were confirmed. They belong to this single round; regression tests check the fixes without another review.

Shared fixture:

```python
import linecache, sys, types
from recompyler.managed import lift_managed
_index = 0
def fixture(source, **values):
    global _index
    _index += 1
    filename = 'wave17-review-visitor-' + str(_index) + '.py'
    linecache.cache[filename] = (len(source), None, source.splitlines(True), filename)
    m = types.ModuleType('wave17_review_visitor_' + str(_index))
    m.__dict__.update(values)
    exec(compile(source, filename, 'exec', dont_inherit=True), m.__dict__)
    return m, lift_managed(m.f)
```

1. **Native helper recursion ignores the active Python recursion budget.** A bounded graph accepted by the 128-level admission can still exceed the caller's current recursion limit.

```python
source = '''def f(tree):
 result = []
 def walk(node):
  result.append(node)
  for child in node:
   walk(child)
 walk(tree)
 return result
'''
m, c = fixture(source)
tree = []
for _ in range(90): tree = [tree]
previous = sys.getrecursionlimit()
sys.setrecursionlimit(60)
try:
    # m.f(tree) raises RecursionError.
    actual = c(tree)  # actual: returns 91 nodes, native=1, fallback=0
finally:
    sys.setrecursionlimit(previous)
```

2. **Helper seed values from globals bypass graph admission.** Only public `passed` arguments are checked. A root helper call over a global can exceed the 128-level graph bound independently of the first defect. A fixed 512-frame reserve alone does not reject this witness because approximately 546 Python frames remain available at entry.

```python
source = '''def f():
 result = []
 def walk(node):
  result.append(node)
  for child in node:
   walk(child)
 walk(G)
 return result
'''
graph = []
for _ in range(600): graph = [graph]
m, c = fixture(source, G=graph)
previous = sys.getrecursionlimit()
sys.setrecursionlimit(550)
try:
    # m.f() raises RecursionError.
    actual = c()  # actual: returns 601 nodes, native=1, fallback=0
finally:
    sys.setrecursionlimit(previous)
```

Actual helper seeds need a proved relation to admitted graphs, their own admission, or conservative refusal. Public entry argument bounds do not cover globals or newly constructed seed graphs.

3. **The new routing path turns a source decline into an uncaught ValueError.** After catching the original `Unsupported`, `lift_managed` re-runs `bind_source` without converting its failure, even before determining whether a nested definition exists.

```python
from recompyler.lift import Unsupported
m = types.ModuleType('wave17_review_visitor_missing_source')
exec(compile('def f(x):\n return x\n',
             '<wave17-review-visitor-missing-source>', 'exec', dont_inherit=True),
     m.__dict__)
lift_managed(m.f)
# Actual: ValueError('source is not an ordinary local file'), not Unsupported.
```

One nonblocking `KNOWN-GAPS.md` suggestion:

- Owned-capture analysis tracks `Assign` but not for-loop targets, so an initialized builder can later alias borrowed input; conservatively decline such captures until the rebinding is tracked.

No implementation, test, corpus, or other source files were changed by this reviewer. This completes the single visitor implementation review.
