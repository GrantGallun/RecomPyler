"""Native region artifacts must survive a fresh process without replaying values."""
import json
import os
from pathlib import Path
import subprocess
import sys

import pytest


SOURCE = '''class Node:
    def __init__(self, value, next):
        self.value = value
        self.next = next
    def score(self):
        return self.value
class Left(Node):
    def score(self):
        return self.value + 1
class Right(Node):
    def score(self):
        return self.value + 2
class Other(Node):
    pass
class State:
    def __init__(self):
        self.root = None
        self.calls = 0
STATE = State()
OFFSET = 3
def helper(value=2):
    return value + OFFSET
def step(value):
    STATE.calls += 1
    if STATE.root is None:
        STATE.root = Left(value, Right(value + 1, None))
    STATE.root.value += helper()
    return STATE.root
'''


def process(folder, code, *args, seed="11", timeout=240):
    env = dict(os.environ, PYTHONPATH=str(Path(__file__).resolve().parents[1] / "src"),
               PYTHONHASHSEED=seed, RECOMPYLER_CACHE=str(folder / "cache"),
               NUMBA_CACHE_DIR=str(folder / "numba"), PYTHONWARNINGS="ignore")
    run = subprocess.run([sys.executable, "-c", code, *map(str, args)], cwd=folder,
                         env=env, capture_output=True, text=True, timeout=timeout)
    assert run.returncode == 0, run.stderr[-6000:]
    return json.loads(run.stdout.splitlines()[-1])


@pytest.fixture(scope="module")
def native_artifact(tmp_path_factory):
    folder = tmp_path_factory.mktemp("native-reuse")
    (folder / "work.py").write_text(SOURCE, encoding="utf-8")
    section = process(folder, '''import json, work
from recompyler import heap
work.STATE.root = work.Right(100, work.Left(200, None))
region = heap.lift_region(work.step)
region(7)
assert region.compiled_calls == 1, region.problem
print(json.dumps(heap.build_regions([(('step', 1), work.step, region)], '.')))
''')
    (folder / "artifact.json").write_text(json.dumps(section))
    return folder


@pytest.mark.parametrize("native,seed", [(True, "17"), (False, "29")])
def test_native_reuse_empty_globals(native_artifact, native, seed):
    result = process(native_artifact, '''import json, sys, work
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
heap.NATIVE = sys.argv[1] == 'True'
section = json.load(open('artifact.json'))
entry = section['functions'][0]
module = aot.load(section)
exports = _AotOnlyExports({d: getattr(module, e) for d,e in entry['exports'].items()})
region = heap.lift_region(work.step, exports, **({'seeds': entry['seeds']} if 'seeds' in entry else {}))
alias = work.STATE
first = region(7)
second = region(9)
print(json.dumps(dict(compiled=region.compiled_calls, fallback=region.fallback_calls,
    aot=region.aot_calls, jit=region.jit_calls,
    numba='numba' in sys.modules, value=second.value, child=second.next.value,
    identity=first is second is alias.root, calls=alias.calls, problem=region.problem)))
''', native, seed=seed)
    assert result == dict(compiled=2, fallback=0, aot=2, jit=0, numba=False, value=17, child=8,
                          identity=True, calls=2, problem=None)


@pytest.mark.parametrize("change", ["constant", "helper", "defaults", "constructor"])
def test_native_reuse_guard_miss_once(native_artifact, change):
    result = process(native_artifact, '''import json, sys, work
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
section = json.load(open('artifact.json')); entry=section['functions'][0]
module = aot.load(section)
exports = _AotOnlyExports({d:getattr(module,e) for d,e in entry['exports'].items()})
if sys.argv[1] == 'constant': work.OFFSET=4
if sys.argv[1] == 'helper': work.helper.__code__=(lambda value=2: value+10).__code__
if sys.argv[1] == 'defaults': work.helper.__defaults__=(3,)
if sys.argv[1] == 'constructor': work.Left.__init__=lambda self,value,next: work.Node.__init__(self,value+1,next)
region=heap.lift_region(work.step,exports,**({'seeds': entry['seeds']} if 'seeds' in entry else {}))
value=region(7)
print(json.dumps(dict(compiled=region.compiled_calls,fallback=region.fallback_calls,
    calls=work.STATE.calls,numba='numba' in sys.modules,value=value.value)))
''', change)
    assert result["compiled"] == 0
    assert result["fallback"] == result["calls"] == 1
    assert result["numba"] is False
    assert result["value"] == {"constant":13,"helper":19,"defaults":13,"constructor":13}[change]


@pytest.mark.parametrize("change", ["constant", "helper", "defaults", "constructor", "mro", "unseen", "field"])
def test_reuse_guards_after_success(native_artifact, change):
    result = process(native_artifact, '''import json, sys, work
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
section=json.load(open('artifact.json')); entry=section['functions'][0]; module=aot.load(section)
region=heap.lift_region(work.step,_AotOnlyExports({d:getattr(module,e) for d,e in entry['exports'].items()}),
                        seeds=entry.get('seeds'))
first=region(7)
assert region.compiled_calls==1, region.problem
if sys.argv[1]=='constant': work.OFFSET=4
if sys.argv[1]=='helper': work.helper.__code__=(lambda value=2:value+10).__code__
if sys.argv[1]=='defaults': work.helper.__defaults__=(3,)
if sys.argv[1]=='constructor': work.Left.__init__=lambda self,value,next: work.Node.__init__(self,value+1,next)
if sys.argv[1]=='mro': work.Left.__bases__=(work.Other,)
if sys.argv[1]=='unseen': work.STATE.root=work.Other(12,first.next)
if sys.argv[1]=='field': first.value=12.5
alias=work.STATE.root
second=region(9)
print(json.dumps(dict(compiled=region.compiled_calls,fallback=region.fallback_calls,
    calls=work.STATE.calls,numba='numba' in sys.modules,identity=second is alias,value=second.value)))
''', change)
    assert result == dict(compiled=1, fallback=1, calls=2, numba=False, identity=True,
                          value={"constant":18, "helper":24, "defaults":18, "constructor":17,
                                 "mro":17, "unseen":17, "field":17.5}[change])


@pytest.mark.parametrize("native", [True, False])
def test_native_reuse_shared_cycle(native_artifact, native):
    result = process(native_artifact, '''import json, sys, work
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
heap.NATIVE=sys.argv[1]=='True'
section=json.load(open('artifact.json')); entry=section['functions'][0]; module=aot.load(section)
region=heap.lift_region(work.step,_AotOnlyExports({d:getattr(module,e) for d,e in entry['exports'].items()}),
                        seeds=entry.get('seeds'))
root=work.Left(8,None);root.next=root;work.STATE.root=root
aliases=[root,root.next]
out=region(10)
print(json.dumps(dict(compiled=region.compiled_calls,fallback=region.fallback_calls,value=out.value,
    alias=out is root is aliases[0] is aliases[1] is root.next,numba='numba' in sys.modules)))
''', native)
    assert result == dict(compiled=1, fallback=0, value=13, alias=True, numba=False)


@pytest.mark.parametrize("change", ["version", "malformed", "missing", "types", "families"])
def test_seed_incompatibility_fails_closed(native_artifact, change):
    result = process(native_artifact, '''import json, sys, work
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
section=json.load(open('artifact.json')); entry=section['functions'][0]; module=aot.load(section)
seeds=entry.get('seeds',{})
for digest,seed in list(seeds.items()):
    if sys.argv[1]=='version': seed['version']=-1
    if sys.argv[1]=='malformed': seeds[digest]={'version':1}
    if sys.argv[1]=='types': seed['cells']=[['invalid',False]]
    if sys.argv[1]=='families': seed['families']=[]
if sys.argv[1]=='missing': seeds=None
region=heap.lift_region(work.step,_AotOnlyExports({d:getattr(module,e) for d,e in entry['exports'].items()}),seeds=seeds)
out=region(7)
print(json.dumps(dict(compiled=region.compiled_calls,fallback=region.fallback_calls,value=out.value,
    calls=work.STATE.calls,numba='numba' in sys.modules)))
''', change)
    assert result == dict(compiled=0, fallback=1, value=12, calls=1, numba=False)


def test_source_and_seed_stable_across_processes(tmp_path):
    (tmp_path / "kinds.py").write_text('''class Base:
    def __init__(self):
        self.n = 1
class Left(Base):
    def __init__(self):
        self.n = 1
        self.extra = 2
class Leaf(Left):
    pass
class Right(Base):
    pass
def subset(nodes):
    total = 0
    for node in nodes:
        if isinstance(node, Left):
            total += node.n
        total += node.extra
    return total
''')
    code = '''import json, kinds
from recompyler import heap
from recompyler._region_seed import capture, identity
class SourceOnly(dict):
    def __bool__(self): return True
    def get(self,key,default=None): return True
r=heap.lift_region(kinds.subset,SourceOnly())
p=r.program_for(([kinds.Left(),kinds.Leaf(),kinds.Right()],))
assert p is not None,r.problem
print(json.dumps([p.digest,identity(capture(p))]))
'''
    results = [process(tmp_path, code, seed=str(seed)) for seed in (2, 7, 23, 53)]
    assert all(result == results[0] for result in results)


def test_seed_binding_rejection_does_not_run_hooks():
    from recompyler._region_seed import Bindings
    calls = []
    class Poison:
        def __getattribute__(self, name):
            calls.append(name)
            return object.__getattribute__(self, name)
    def entry():
        pass
    entry.__globals__["_seed_poison_test"] = Poison()
    try:
        assert Bindings(entry).resolve(["_seed_poison_test"]) is entry.__globals__["_seed_poison_test"]
        assert calls == []
    finally:
        del entry.__globals__["_seed_poison_test"]


def test_seed_fingerprint_includes_exception_and_cell_metadata():
    from recompyler._region_seed import _fingerprint
    def target():
        return 3
    code = target.__code__
    original = _fingerprint(target)
    if hasattr(code, "co_exceptiontable"):
        target.__code__ = code.replace(co_exceptiontable=b"\x80")
        assert _fingerprint(target) != original
    target.__code__ = code.replace(co_cellvars=("unused",))
    assert _fingerprint(target) != original


@pytest.mark.parametrize("namespace_kind", ["function", "module"])
def test_seed_namespace_rejection_does_not_run_hooks(namespace_kind):
    from recompyler import heap
    from recompyler._region_seed import capture, restore
    from recompyler.lift import Unsupported
    calls = []
    class Poison:
        def __getattribute__(self, name):
            calls.append(name)
            return object.__getattribute__(self, name)
    def entry():
        return 1
    seed = capture(heap._Program(entry))
    seed["globals"] = [[[namespace_kind, ["_seed_namespace_poison"]], "missing", "i"]]
    entry.__globals__["_seed_namespace_poison"] = Poison()
    try:
        with pytest.raises(Unsupported):
            restore(entry, seed)
        assert calls == []
    finally:
        del entry.__globals__["_seed_namespace_poison"]


def test_nullable_seed_does_not_reuse_different_native_signature(tmp_path):
    (tmp_path / "nullable.py").write_text('''class Node:
    pass
def maybe(node):
    if node is None:
        return 1.5
    return 3
''')
    result = process(tmp_path, '''import json,nullable
from recompyler import heap
r=heap.lift_region(nullable.maybe)
assert r(nullable.Node())==3
s=heap.build_regions([(('maybe',3),nullable.maybe,r)],'.')
assert s
entry=s['functions'][0]
seeds=entry['seeds']
print(json.dumps(dict(seed_count=len(seeds),export_count=len(set(entry['exports'].values())),
                     nullable=next(iter(seeds.values()))['functions'][0]['vars'][0][1][2])))
''')
    assert result == dict(seed_count=1, export_count=1, nullable=False)


def test_replaced_binding_has_no_preflight_hooks(native_artifact):
    result = process(native_artifact, '''import json,work
from recompyler import heap,aot
from recompyler.runner import _AotOnlyExports
section=json.load(open('artifact.json'));entry=section['functions'][0];module=aot.load(section)
effects=[]
class Replacement:
    def __getattribute__(self,name):
        effects.append(name)
        return object.__getattribute__(self,name)
    def __call__(self):
        return 5
work.helper=Replacement()
region=heap.lift_region(work.step,_AotOnlyExports({d:getattr(module,e) for d,e in entry['exports'].items()}),
                        seeds=entry['seeds'])
out=region(7)
print(json.dumps(dict(effects=effects,calls=work.STATE.calls,value=out.value,
                     compiled=region.compiled_calls,fallback=region.fallback_calls)))
''')
    assert result == dict(effects=[], calls=1, value=12, compiled=0, fallback=1)


@pytest.fixture(scope="module")
def mixed_native_artifact(tmp_path_factory):
    folder = tmp_path_factory.mktemp("mixed-native-reuse")
    (folder / "mixed.py").write_text('''class Node:
    def __init__(self, value):
        self.value = value
CALLS = [0]
def helper(node):
    node.value += 1
    return node.value
def choose(node):
    CALLS[0] += 1
    if node is None:
        return 1.5
    else:
        return helper(node)
''')
    section = process(folder, '''import json,mixed
from recompyler import heap
r=heap.lift_region(mixed.choose)
assert r(mixed.Node(3))==4
assert r(None)==1.5
assert r.compiled_calls==2 and len(r.programs)==2,r.problem
print(json.dumps(heap.build_regions([(('choose',8),mixed.choose,r)],'.')))
''')
    (folder / "artifact.json").write_text(json.dumps(section))
    return folder


@pytest.mark.parametrize("native", [True, False])
@pytest.mark.parametrize("none_first", [True, False])
def test_mixed_signatures_reuse_strict_native_export(mixed_native_artifact, native, none_first):
    result = process(mixed_native_artifact, '''import json,sys,mixed
from recompyler import heap,aot
from recompyler.runner import _AotOnlyExports
heap.NATIVE=sys.argv[1]=='True'
s=json.load(open('artifact.json'));e=s['functions'][0];m=aot.load(s)
r=heap.lift_region(mixed.choose,_AotOnlyExports({d:getattr(m,n) for d,n in e['exports'].items()}),seeds=e['seeds'])
node=mixed.Node(10)
args=[None,node] if sys.argv[2]=='True' else [node,None]
values=[r(arg) for arg in args]
print(json.dumps(dict(values=values,value=node.value,calls=mixed.CALLS[0],aot=r.aot_calls,jit=r.jit_calls,
                     compiled=r.compiled_calls,fallback=r.fallback_calls,numba='numba' in sys.modules)))
''', native, none_first)
    assert result == dict(values=[1.5, 11] if none_first else [11, 1.5], value=11, calls=2,
                          aot=2, jit=0, compiled=2, fallback=0, numba=False)


@pytest.mark.parametrize("native", [True, False])
def test_unrelated_seed_does_not_authorize_poisoned_branch(mixed_native_artifact, native):
    result = process(mixed_native_artifact, '''import json,sys,mixed
from recompyler import heap,aot
from recompyler.runner import _AotOnlyExports
heap.NATIVE=sys.argv[1]=='True'
s=json.load(open('artifact.json'));e=s['functions'][0];m=aot.load(s)
effects=[]
class Replacement:
    def __getattribute__(self,name):
        effects.append(name)
        return object.__getattribute__(self,name)
    def __call__(self,node):
        node.value+=10
        return node.value
mixed.helper=Replacement()
r=heap.lift_region(mixed.choose,_AotOnlyExports({d:getattr(m,n) for d,n in e['exports'].items()}),seeds=e['seeds'])
assert r(None)==1.5
node=mixed.Node(10)
out=r(node)
print(json.dumps(dict(effects=effects,value=out,calls=mixed.CALLS[0],aot=r.aot_calls,jit=r.jit_calls,
                     compiled=r.compiled_calls,fallback=r.fallback_calls,numba='numba' in sys.modules)))
''', native)
    assert result == dict(effects=[], value=20, calls=2, aot=1, jit=0,
                          compiled=1, fallback=1, numba=False)


@pytest.fixture(scope="module")
def startup_native_artifact(tmp_path_factory):
    folder = tmp_path_factory.mktemp("startup-dependencies")
    (folder / "startup.py").write_text('''class Node:
    def __init__(self, value):
        self.value = value + 1
class State:
    def __init__(self):
        self.root = None
        self.calls = 0
STATE = State()
def make_node(value, *, sentinel=None):
    return Node(value)
def step(value):
    STATE.calls += 1
    if STATE.root is None:
        STATE.root = make_node(value)
    return STATE.root
''')
    section = process(folder, '''import json,startup
from recompyler import heap
startup.STATE.root=startup.Node(100)
r=heap.lift_region(startup.step)
assert r(7) is startup.STATE.root
assert r.compiled_calls==1,r.problem
print(json.dumps(heap.build_regions([(('step',11),startup.step,r)],'.')))
''')
    (folder / "artifact.json").write_text(json.dumps(section))
    return folder


@pytest.mark.parametrize("native", [True, False])
@pytest.mark.parametrize("after_success", [True, False])
@pytest.mark.parametrize("dependency", ["constructor", "helper"])
def test_startup_dependencies_guard_actual_code(startup_native_artifact, native, after_success, dependency):
    result = process(startup_native_artifact, '''import json,sys,startup
from recompyler import heap,aot
from recompyler.runner import _AotOnlyExports
heap.NATIVE=sys.argv[1]=='True'
s=json.load(open('artifact.json'));e=s['functions'][0];m=aot.load(s)
r=heap.lift_region(startup.step,_AotOnlyExports({d:getattr(m,n) for d,n in e['exports'].items()}),seeds=e['seeds'])
after=sys.argv[2]=='True'
if after:
    first=r(7)
    assert first.value==8 and r.aot_calls==1,r.problem
    startup.STATE.root=None
def altered_init(self,value):
    self.value=value+9
def altered_helper(value):
    return Node(value+9)
target=startup.Node.__init__ if sys.argv[3]=='constructor' else startup.make_node
replacement=altered_init if sys.argv[3]=='constructor' else altered_helper
old=target.__code__
target.__code__=old.replace(co_code=replacement.__code__.co_code,
                          co_consts=replacement.__code__.co_consts,
                          co_stacksize=replacement.__code__.co_stacksize)
assert target.__code__.co_filename==old.co_filename and target.__code__.co_firstlineno==old.co_firstlineno
out=r(7)
print(json.dumps(dict(value=out.value,identity=out is startup.STATE.root,calls=startup.STATE.calls,
    aot=r.aot_calls,jit=r.jit_calls,compiled=r.compiled_calls,fallback=r.fallback_calls,
    numba='numba' in sys.modules)))
''', native, after_success, dependency)
    assert result == dict(value=16 if dependency == "constructor" else 17, identity=True,
                          calls=2 if after_success else 1, aot=int(after_success), jit=0,
                          compiled=int(after_success), fallback=1, numba=False)


@pytest.mark.parametrize("native", [True, False])
def test_startup_dependency_missing_none_default_is_guarded(startup_native_artifact, native):
    result = process(startup_native_artifact, '''import json,sys,startup
from recompyler import heap,aot
from recompyler.runner import _AotOnlyExports
heap.NATIVE=sys.argv[1]=='True'
s=json.load(open('artifact.json'));e=s['functions'][0];m=aot.load(s)
r=heap.lift_region(startup.step,_AotOnlyExports({d:getattr(m,n) for d,n in e['exports'].items()}),seeds=e['seeds'])
assert r(7).value==8 and r.aot_calls==1,r.problem
startup.STATE.root=None
del startup.make_node.__kwdefaults__['sentinel']
try:
    r(7)
except TypeError:
    raised=True
else:
    raised=False
print(json.dumps(dict(raised=raised,calls=startup.STATE.calls,empty=startup.STATE.root is None,
                     aot=r.aot_calls,jit=r.jit_calls,fallback=r.fallback_calls,numba='numba' in sys.modules)))
''', native)
    assert result == dict(raised=True, calls=2, empty=True, aot=1, jit=0, fallback=1, numba=False)


@pytest.mark.parametrize("kind", ["mapping", "key"])
def test_dependency_defaults_reject_custom_hooks(kind):
    from recompyler._region_seed import _fingerprint
    from recompyler.lift import Unsupported
    calls = []
    class Mapping(dict):
        def items(self):
            calls.append("items")
            return super().items()
        def __iter__(self):
            calls.append("iter")
            return super().__iter__()
        def __bool__(self):
            calls.append("bool")
            return True
    class Key(str):
        def __lt__(self, other):
            calls.append("compare")
            return super().__lt__(other)
    def target(*, option=None):
        return option
    target.__kwdefaults__ = Mapping(option=None) if kind == "mapping" else {Key("z"): None, Key("a"): None}
    with pytest.raises(Unsupported):
        _fingerprint(target)
    assert calls == []


def test_new_startup_math_must_pass_existing_build_validation(tmp_path):
    (tmp_path / "startup_math.py").write_text('''import math
class Node:
    def __init__(self, value):
        self.value = value
class State:
    def __init__(self):
        self.root = None
STATE = State()
def run(value):
    if STATE.root is None:
        STATE.root = Node(math.sin(value))
    return STATE.root.value
''')
    result = process(tmp_path, '''import json,startup_math
from recompyler import heap,_pycc
startup_math.STATE.root=startup_math.Node(2.0)
r=heap.lift_region(startup_math.run)
assert r(1.0)==2.0 and r.compiled_calls==1,r.problem
assert not any('sin' in getattr(info,'math_used',()) for info in r.latest.order)
heap._math_agrees=lambda:set()
exports=[]
class ObservedBuild(_pycc.CC):
    def export(self,name,signature):
        if name!='_prepared_seal': exports.append(name)
        return super().export(name,signature)
_pycc.CC=ObservedBuild
section=heap.build_regions([(('run',9),startup_math.run,r)],'.')
print(json.dumps(dict(exports=len(exports),seeds=len(section['functions'][0]['seeds']))))
''')
    assert result == dict(exports=1, seeds=1)


FAMILY_SOURCE = '''class BaseA:
    pass
class A(BaseA):
    def __init__(self, value):
        self.x = value
class C(A):
    pass
class BaseB:
    pass
class B(BaseB):
    def __init__(self, value):
        self.x = value
        self.y = value
CALLS = [0]
def read(a, b, c):
    CALLS[0] += 1
    return a.x + b.y + c.x
def merged(values):
    total = 0
    for value in values:
        total += value.x
    return total
'''


@pytest.mark.parametrize("malformation", ["cycle", "conflicting_own_root"])
def test_invalid_family_topology_rejects_before_replay(tmp_path, malformation):
    (tmp_path / "families.py").write_text(FAMILY_SOURCE)
    result = process(tmp_path, '''import json,sys,families as f
from recompyler import heap
from recompyler._region_seed import capture,seal,restore
from recompyler.runner import _AotOnlyExports
from recompyler.lift import Unsupported
class SourceOnly(dict):
    def __bool__(self): return True
    def get(self,*args): return lambda *args:None
args=(f.A(1),f.B(2),f.C(3))
p=heap.lift_region(f.read,SourceOnly()).program_for(args)
s=json.loads(json.dumps(seal(capture(p,widen_objects=False),p)))
rows={row[0][-1]:row for row in s['families']}
if sys.argv[1]=='cycle':
    rows['BaseA'][0],rows['BaseB'][0]=rows['BaseB'][0],rows['BaseA'][0]
else:
    rows['BaseA'][1].remove(['C'])
    rows['BaseB'][1].append(['C'])
try:
    restore(f.read,s)
except Unsupported:
    rejected=True
else:
    rejected=False
r=heap.lift_region(f.read,_AotOnlyExports({'missing-digest':object()}),seeds={'missing-digest':s})
out=r(*args)
print(json.dumps(dict(rejected=rejected,out=out,calls=f.CALLS[0],fallback=r.fallback_calls,
                     compiled=r.compiled_calls,numba='numba' in sys.modules)))
''', malformation, timeout=5)
    assert result == dict(rejected=True, out=6, calls=1, fallback=1, compiled=0, numba=False)


def test_valid_abstract_and_merged_family_roots_restore(tmp_path):
    (tmp_path / "families.py").write_text(FAMILY_SOURCE)
    result = process(tmp_path, '''import json,families as f
from recompyler import heap
from recompyler._region_seed import capture,seal,restore
class SourceOnly(dict):
    def __bool__(self): return True
    def get(self,*args): return lambda *args:None
out=[]
for fn,args in [(f.read,(f.A(1),f.B(2),f.C(3))),(f.merged,([f.A(1),f.B(2)],))]:
    r=heap.lift_region(fn,SourceOnly());p=r.program_for(args)
    q=restore(fn,json.loads(json.dumps(seal(capture(p,widen_objects=False),p))))
    q.compile(SourceOnly());r.load(q,args)
    out.append(dict(source=q.source==p.source,abstract=all(root not in q.class_fields for root in q.members),
                    merged=q.family(f.A) is q.family(f.B)))
print(json.dumps(out))
''')
    assert result == [dict(source=True, abstract=True, merged=False),
                      dict(source=True, abstract=True, merged=True)]


@pytest.fixture(scope="module", params=["generator", "mutable_default"])
def partial_native_artifact(tmp_path_factory, request):
    folder = tmp_path_factory.mktemp("partial-native")
    helper = ("def helper(node, unused=0):\n    node.value += 1\n    return sum(i for i in [node.value])\n"
              if request.param == "generator" else
              "def helper(node, unused=[]):\n    node.value += 1\n    return node.value\n")
    (folder / "partial.py").write_text('''class Node:
    def __init__(self, value):
        self.value = value
class Plain:
    def __init__(self, value):
        self.value = value
CALLS = [0]
''' + helper + '''def choose(node):
    CALLS[0] += 1
    if node is None:
        return 1.5
    elif isinstance(node, Node):
        return helper(node, 0)
    else:
        node.value += 1.0
        return node.value
def other(value):
    return value + 2
''')
    section = process(folder, '''import json,partial as p
from recompyler import heap
r=heap.lift_region(p.choose)
assert r(p.Plain(2.0))==3.0
assert r(p.Node(3))==4 and r(None)==1.5
assert r.compiled_calls==3,r.problem
other=heap.lift_region(p.other)
assert other(3)==5 and other.compiled_calls==1,other.problem
print(json.dumps(heap.build_regions([(('choose',1),p.choose,r),(('other',1),p.other,other)],'.')))
''')
    (folder / "artifact.json").write_text(json.dumps(section))
    return folder


@pytest.mark.parametrize("native", [True, False])
@pytest.mark.parametrize("none_first", [True, False])
def test_partial_seeding_preserves_legacy_native_coverage(partial_native_artifact, native, none_first):
    result = process(partial_native_artifact, '''import json,sys,partial as p
from recompyler import heap,aot
from recompyler.runner import _AotOnlyExports
heap.NATIVE=sys.argv[1]=='True'
s=json.load(open('artifact.json'));e,other=s['functions'];m=aot.load(s)
assert set(e['exports'].values()).isdisjoint(other['exports'].values())
r=heap.lift_region(p.choose,_AotOnlyExports({d:getattr(m,n) for d,n in e['exports'].items()}),seeds=e['seeds'])
node=p.Node(10)
values=[r(arg) for arg in ([None,node] if sys.argv[2]=='True' else [node,None])]
second=heap.lift_region(p.other,_AotOnlyExports({d:getattr(m,n) for d,n in other['exports'].items()}),seeds=other['seeds'])
assert second(10)==12 and second.aot_calls==1 and second.fallback_calls==0,second.problem
print(json.dumps(dict(values=values,value=node.value,calls=p.CALLS[0],aot=r.aot_calls,jit=r.jit_calls,
    fallback=r.fallback_calls,numba='numba' in sys.modules,seeds=len(e['seeds']),
    policy=e.get('seed_policy'),other_policy=other.get('seed_policy'))))
''', native, none_first)
    assert result == dict(values=[1.5,11] if none_first else [11,1.5], value=11, calls=2,
                          aot=2, jit=0, fallback=0, numba=False, seeds=0,
                          policy="legacy-only", other_policy="guarded")
