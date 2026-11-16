"""Origin widening and importer-local guarded deployment regressions."""
import importlib.util
import json
from pathlib import Path
import runpy
import sys
from types import SimpleNamespace

import pytest

sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'src'))
from recompyler import profiler,runner
from recompyler.monitor import CallMonitor


def module(path,name):
    spec=importlib.util.spec_from_file_location(name,path)
    m=importlib.util.module_from_spec(spec);sys.modules[name]=m;spec.loader.exec_module(m)
    return m


@pytest.mark.parametrize('backend',['python','c'])
def test_library_origin_is_captured_without_changing_library(tmp_path,backend):
    libpath=tmp_path/'lib.py';libpath.write_text('def work(x):\n    return x + 1\n')
    lib=module(libpath,'capture_origin_lib')
    script=tmp_path/'app.py';script.write_text('from capture_origin_lib import work\nassert work(2)==3\n')
    original=lib.work
    with CallMonitor([script],8,profiler.snapshot,backend=backend,all_origins=True) as mon:
        runpy.run_path(str(script))
    key=(str(libpath),'work',1)
    assert mon.samplers[key].samples[0][0]==(2,)
    assert lib.work is original
    assert not any('recompyler' in Path(k[0]).parts for k in mon.stats)


def test_same_name_and_line_are_distinct_selections(tmp_path):
    rows=[dict(file=str(tmp_path/n),function='work',line=1,candidate=dict(status='verified',recommended=True)) for n in ('a.py','b.py')]
    picks=runner._recommended(dict(plan=dict(worth_running=True),functions=rows))
    assert len(picks)==2


def test_library_dispatch_guards_and_never_replaces_imported_object(tmp_path,monkeypatch,capsys):
    libpath=tmp_path/'mathlib.py';libpath.write_text('def work(x):\n    return x + 1\n')
    lib=module(libpath,'capture_dispatch_lib');original=lib.work
    # Calls from the transformed script use a local wrapper. An unrelated importer
    # observes the same function and can pass a different type safely.
    script=tmp_path/'app.py';script.write_text('import capture_dispatch_lib as lib\nfrom capture_dispatch_lib import work\nassert work is lib.work\nassert work(2)==3\nassert lib.work(2.5)==3.5\nassert lib.work is work\n')
    class Lifted:
        compiled_calls=fallback_calls=aot_calls=jit_calls=0
        programs={}
        def __call__(self,x):
            if type(x) is int:self.compiled_calls+=1;self.jit_calls+=1
            else:self.fallback_calls+=1
            return original(x)
    made=[]
    def lift(fn,*args,**kw):
        assert fn is original
        made.append(Lifted());return made[-1]
    import recompyler.heap as heap
    monkeypatch.setattr(heap,'lift_region',lift)
    plan=tmp_path/'plan.json';plan.write_text(json.dumps(dict(plan=dict(worth_running=True),functions=[dict(file=str(libpath),function='work',line=1,candidate=dict(status='verified',recommended=True,engine='region'))])))
    report=runner.run_script(script,[],plan)
    assert lib.work is original
    assert len(made)==1
    assert report['functions'][0]['compiled_calls']==1
    assert report['functions'][0]['fallback_calls']==1
    assert original(4.5)==5.5
    assert not report['not_found']


def test_library_origin_cache_identity_changes_with_file(tmp_path):
    from recompyler._origin import identity
    path=tmp_path/'lib.py';path.write_text('def work(x):\n    return x + 1\n')
    lib=module(path,'capture_identity_lib');first=identity(lib.work)
    path.write_text('def work(x):\n    return x + 2\n')
    assert identity(lib.work)!=first
# New regressions prepared while baseline owns CPU; do not run until it exits.
def test_library_aot_fresh_child_and_unseen_fallback(tmp_path):
    import os
    import subprocess
    from recompyler.heap import lift_region,build_regions
    libpath=tmp_path/'native_lib.py';libpath.write_text('def work(x):\n    return x + 1\n')
    lib=module(libpath,'native_lib')
    region=lift_region(lib.work)
    assert region(2)==3 and region.compiled_calls==1
    (tmp_path/'aot').mkdir()
    section=build_regions([(('work',1),lib.work,region)],tmp_path/'aot')
    assert section and section['functions']
    script=tmp_path/'app.py';script.write_text('import native_lib\nfrom native_lib import work\nassert work is native_lib.work\nassert work(2)==3\nassert work(2**80)==2**80+1\nassert work is native_lib.work\n')
    plan=tmp_path/'plan.json';plan.write_text(json.dumps(dict(script=str(script),plan=dict(worth_running=True,aot_regions=section),functions=[dict(file=str(libpath),function='work',line=1,candidate=dict(status='verified',recommended=True,engine='region'))])))
    probe='from pathlib import Path;import json,sys;from recompyler.runner import run_script;r=run_script(Path(sys.argv[1]),[],Path(sys.argv[2]));assert "numba" not in sys.modules;print(json.dumps(r))'
    env=dict(os.environ,PYTHONPATH=os.pathsep.join([str(Path(__file__).resolve().parents[1]/'src'),str(tmp_path)]))
    done=subprocess.run([sys.executable,'-B','-c',probe,str(script),str(plan)],env=env,capture_output=True,text=True)
    assert done.returncode==0,done.stderr
    result=json.loads(done.stdout);row=result['functions'][0]
    assert row['aot_calls']==1 and row['jit_calls']==0 and row['fallback_calls']==1
    assert not result['not_found']


def test_library_dispatch_evaluates_callee_and_arguments_once_in_order(tmp_path,monkeypatch):
    libpath=tmp_path/'lib.py';libpath.write_text('def work(x):\n    return x + 1\n')
    lib=module(libpath,'capture_order_lib')
    script=tmp_path/'app.py';script.write_text('import capture_order_lib as lib\nevents=[]\ndef getfn():\n    events.append("callee")\n    return lib.work\ndef arg():\n    events.append("arg")\n    return 2\nassert getfn()(arg())==3\nassert events==["callee","arg"]\n')
    class Lifted:
        compiled_calls=fallback_calls=0
        def __call__(self,x):self.compiled_calls+=1;return lib.work(x)
    import importlib
    monkeypatch.setattr(importlib.import_module('recompyler.lift'),'lift',lambda fn:Lifted())
    plan=tmp_path/'plan.json';plan.write_text(json.dumps(dict(plan=dict(worth_running=True),functions=[dict(file=str(libpath),function='work',line=1,candidate=dict(status='verified',recommended=True))])))
    report=runner.run_script(script,[],plan)
    assert report['functions'][0]['compiled_calls']==1

def test_capture_does_not_probe_arbitrary_named_global(tmp_path):
    script=tmp_path/'safe.py';script.write_text('def work(x):\n    return x+1\nalias=work\nclass Trap:\n    def __getattribute__(self,name):\n        if name=="__code__":\n            raise AssertionError("capture ran a user hook")\n        return object.__getattribute__(self,name)\nwork=Trap()\nassert alias(2)==3\n')
    with CallMonitor([script],8,profiler.snapshot,backend='python'):
        runpy.run_path(str(script))


def test_origin_identity_does_not_use_arbitrary_module_metadata(tmp_path):
    from recompyler._origin import identity
    path=tmp_path/'lib.py';path.write_text('def work(x):\n    return x + 1\n')
    lib=module(path,'capture_badmodule_lib')
    class Trap:
        def __getattribute__(self,name):raise AssertionError('metadata hook')
    lib.work.__module__=Trap()
    result=identity(lib.work)
    assert result['module'] is None

def test_library_rows_cannot_fund_local_batch_profitability(tmp_path,monkeypatch):
    script=tmp_path/'app.py';script.write_text('def step(x):\n    return x+1\nassert [step(i) for i in range(3)]==[1,2,3]\n')
    local=dict(function='step',line=1,calls=3,candidate=dict(status='verified',batch_backends={'cpu':2.0},python_us_per_call=1))
    external=dict(file=str(tmp_path/'lib.py'),function='step',line=1,calls=10**9,candidate=dict(status='verified',batch_backends={'cpu':2.0},python_us_per_call=1))
    plan=tmp_path/'plan.json';plan.write_text(json.dumps(dict(plan=dict(worth_running=False,startup_s=1,saving_s=0),functions=[local,external])))
    original=runner.batch_pays
    def check(data,ratios,picks):
        assert all(not row.get('file') for row in data['functions'])
        return original(data,ratios,picks)
    monkeypatch.setattr(runner,'batch_pays',check)
    report=runner.run_script(script,[],plan)
    assert report['functions']==[] and not report['batches']

def test_equal_code_has_equal_origin_despite_marshal_interning(tmp_path):
    import ast
    from types import FunctionType
    from recompyler._origin import identity
    source='SCALE=0.999\ndef step(values,k):\n    for _ in range(50):\n        for i in range(len(values)):\n            values[i]=values[i]*k*SCALE+0.001\n    if k>10.0:\n        raise ValueError("k too large")\n    return len(values)+float(k)\n'
    path=tmp_path/'lib.py';path.write_text(source)
    tree=ast.parse(source,str(path));a=compile(source,str(path),'exec')
    from recompyler.runner import _Mark
    b=compile(_Mark({('step',2)}).visit(tree),str(path),'exec')
    code=lambda value:next(c for c in value.co_consts if type(c) is type(value))
    x,y=code(a),code(b)
    assert x==y
    first=FunctionType(x,{'__name__':'origin_fixture'});second=FunctionType(y,{'__name__':'origin_fixture'})
    assert identity(first)==identity(second)


def test_tiny_script_is_ranked_without_profiler_bootstrap(tmp_path):
    script=tmp_path/'tiny.py';script.write_text('def twice(x):\n    return x+x\ntwice(3)\n')
    report=profiler.profile_script(script,[],10,8,False)
    assert any(row['function']=='twice' for row in report['functions'])

def test_origin_declines_arbitrary_code_constant_without_repr(tmp_path):
    from recompyler._origin import identity
    from recompyler.lift import Unsupported
    path=tmp_path/'lib.py';path.write_text('def work():\n    return 1\n')
    lib=module(path,'capture_constant_lib');calls=[]
    class Trap:
        def __repr__(self):calls.append('repr');raise AssertionError('constant hook')
    lib.work.__code__=lib.work.__code__.replace(co_consts=(None,Trap()))
    with pytest.raises(Unsupported):identity(lib.work)
    assert calls==[]

def test_origin_accepts_exact_slice_constants_and_rejects_hook_bounds(tmp_path):
    from recompyler._origin import identity
    from recompyler.lift import Unsupported
    path=tmp_path/'slice_lib.py';path.write_text('def work(x):\n    return x[1:]\n')
    lib=module(path,'capture_slice_lib')
    assert identity(lib.work)['code_sha256']
    class Trap:
        def __repr__(self):raise AssertionError('slice bound hook')
    lib.work.__code__=lib.work.__code__.replace(co_consts=(None,slice(Trap(),None,None)))
    with pytest.raises(Unsupported):identity(lib.work)

def test_snapshot_rejects_inherited_finalizers_before_copy(tmp_path):
    path=tmp_path/'resource.py';path.write_text('events=[]\nclass Base:\n    def __del__(self):\n        events.append(self.handle)\nclass Resource(Base):\n    def __init__(self,handle):\n        self.handle=handle\n')
    lib=module(path,'capture_resource_lib');original=lib.Resource(37)
    with pytest.raises(ValueError):profiler.snapshot(original)
    assert lib.events==[]
    assert original.handle==37


def test_library_capture_preserves_resource_lifetime(tmp_path):
    path=tmp_path/'resource.py';path.write_text('events=[]\nclass Resource:\n    def __init__(self,handle):\n        self.handle=handle\n    def __del__(self):\n        events.append(self.handle)\ndef read(obj):\n    return obj.handle\n')
    lib=module(path,'capture_resource_monitor_lib');obj=lib.Resource(41)
    script=tmp_path/'app.py';script.write_text('from capture_resource_monitor_lib import read\n')
    with CallMonitor([script],8,profiler.snapshot,all_origins=True) as monitor:
        assert lib.read(obj)==41
    assert not monitor.samplers[(str(path),'read',7)].samples
    assert lib.events==[]

def test_cached_snapshot_and_pickle_recheck_added_finalizer(tmp_path):
    path=tmp_path/'plain.py';path.write_text('class Plain:\n    def __init__(self,value):\n        self.value=value\n')
    lib=module(path,'capture_cached_lifetime_lib');obj=lib.Plain(4)
    profiler.snapshot(obj)
    copier=profiler._Copies((obj,))
    assert copier.blob is not None
    lib.Plain.__del__=None
    try:
        with pytest.raises(ValueError):profiler.snapshot(obj)
        with pytest.raises(ValueError):copier((obj,))
    finally:del lib.Plain.__del__


def test_heap_lifetime_guard_does_not_invoke_added_descriptor(tmp_path):
    from recompyler.heap import lift_region
    path=tmp_path/'plain.py';path.write_text('class Plain:\n    def __init__(self,value):\n        self.value=value\ndef read(obj):\n    return obj.value+1\n')
    lib=module(path,'capture_heap_lifetime_lib');obj=lib.Plain(4);region=lift_region(lib.read)
    assert region(obj)==5 and region.compiled_calls==1
    calls=[]
    class Descriptor:
        def __get__(self,*args):calls.append('get');return None
    lib.Plain.__del__=Descriptor()
    try:
        assert region(obj)==5
        assert region.compiled_calls==1 and region.fallback_calls==1
        assert calls==[]
    finally:del lib.Plain.__del__


def test_random_snapshot_rejects_added_finalizer(monkeypatch):
    import random
    obj=random.Random(3)
    with monkeypatch.context() as patch:
        patch.setattr(random.Random,'__del__',lambda self:None,raising=False)
        with pytest.raises(ValueError):profiler.snapshot(obj)

def test_region_does_not_ignore_custom_allocation(tmp_path):
    from recompyler.heap import lift_region
    path=tmp_path/'allocation.py';path.write_text('events=[]\nclass Special:\n    def __new__(cls,value):\n        events.append(value)\n        return object.__new__(cls)\n    def __init__(self,value):\n        self.value=value\ndef work(value):\n    return Special(value).value\n')
    lib=module(path,'capture_allocation_lib');region=lift_region(lib.work)
    assert region(7)==7
    assert lib.events==[7]
    assert region.compiled_calls==0 and region.fallback_calls==1
