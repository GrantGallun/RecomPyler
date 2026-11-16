# S58 independent source-callback / heap text-admission review

Reviewed the new `provenance._source_lines` reader, eager `_Unit.define` certificate construction, and heap text classifiers/refusal hooks only. The earlier Unicode implementation, tests, harnesses, reports and evidence were outside this review. Tiny serial probes ran below-normal without JIT compilation. This is the sole review round; fixes are checked by their new regression tests.

Two concrete findings require fixes.

## 1. A declined borrowed-text graph still executes a lazy source loader

The public heap frontend only recognizes direct strings/bytes and tuples containing them. A list containing text reaches `_Program` source acquisition, which still calls `inspect.getsource`, before the new post-settle `text_ownership_problem` refusal. The declined attempt consequently adds an application callback that CPython does not perform.

Executable witness with `PYTHONPATH=src`:

```python
import linecache
import types
from recompyler.heap import lift_region

source = 'def f(items):\n    return len(items)\n'
filename = 'wave17-review-list-text-loader.py'
linecache.cache[filename] = (
    len(source), None, source.splitlines(True), filename)
m = types.ModuleType('wave17_review_list_text_loader')
exec(compile(source, filename, 'exec', dont_inherit=True), m.__dict__)
region = lift_region(m.f)
events = []
def loader():
    events.append('source loader')
    return source
linecache.cache[filename] = (loader,)
assert m.f(['text']) == 1
assert events == []
assert region(['text']) == 1
assert events == []  # FAIL: ['source loader']
```

Observed: native calls 0, fallback calls 1, problem `heap converted str/bytes graph ownership is not proved`. The refusal must occur without first invoking that loader, or heap source acquisition must itself use the inert path.

## 2. New recursive text classification crashes construction on a numeric tuple graph

`_known_text_source` recursively traverses referenced global tuples using `_direct_text`, with no depth bound or decline handling. This adds an uncaught construction-time `RecursionError` for an otherwise ordinary numeric function.

```python
import types
from recompyler.heap import lift_region

m = types.ModuleType('wave17_review_deep_global')
exec('def f():\n    return len(G)\n', m.__dict__)
g = 0
for _ in range(600):
    g = (g,)
m.G = g
assert m.f() == 1
region = lift_region(m.f)  # FAIL: RecursionError in _direct_text
```

Conservative refusal is sufficient; the classifier need not accept arbitrarily deep graphs.

No other concrete wrong result or crash was found in the scoped source reader/eager-certificate paths. No implementation, test, corpus, report or evidence files were changed by this reviewer.
