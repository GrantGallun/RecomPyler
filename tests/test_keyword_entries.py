"""Fixed keyword-only entry capture and inert runtime binding regressions."""
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import pytest
from recompyler import profiler
from recompyler.monitor import CallMonitor
from recompyler.heap import _bind_entry, lift_region, build_regions


def numeric(x, /, y=2, *, scale=3, offset):
    return (x+y)*scale+offset


def aliased(items, *, other):
    items.append(7)
    return len(other)


@pytest.mark.parametrize('backend',['python','c'])
def test_monitors_capture_fixed_keyword_only_defaults_and_aliases(backend):
    with CallMonitor([__file__],8,profiler.snapshot,backend=backend,bias=0,yield_bias=0) as monitor:
        assert numeric(2,offset=5)==17
        items=[]
        assert aliased(items,other=items)==1
    samples={k[1]:v.samples for k,v in monitor.samplers.items()}
    assert samples['numeric'][0][0]==(2,2,3,5)
    before,expected,after=samples['aliased'][0]
    assert before[0] is before[1] and before[0]==[]
    assert after[0] is after[1] and after[0]==[7] and expected==1


def test_keyword_only_selection_uses_bound_replay_and_normal_runtime_timing():
    inputs=[((2,2,3,5),17,(2,2,3,5)),((3,4,2,1),15,(3,4,2,1))]
    result=profiler.test_candidate(numeric,inputs,2)
    assert result['status']=='verified',result
    assert result['engine']=='region' and result['compiled_samples']==2
    assert result['_region'](3,y=4,scale=2,offset=1)==15


def test_binding_ignores_signature_wrapped_and_deferred_annotation_hooks():
    events=[]
    def fn(x,/,y=2,*,z=3):return x+y+z
    class Trap:
        def __getattribute__(self,name):events.append(name);raise AssertionError('wrapper hook')
    fn.__wrapped__=Trap();fn.__signature__=Trap()
    def annotate(format):events.append('annotations');raise AssertionError('annotation hook')
    fn.__annotate__=annotate
    assert _bind_entry(fn,(1,),{'z':4})==(1,2,4)
    assert events==[]


@pytest.mark.parametrize('args,kwargs,expected',[
    ((1,),{'offset':5},(1,2,3,5)),
    ((1,4),{'scale':2,'offset':8},(1,4,2,8)),
    ((1,),{},None),((1,2,3),{'offset':4},None),
    ((1,),{'x':9,'offset':4},None),((1,2),{'y':3,'offset':4},None),
    ((),{'x':1,'offset':4},None),((1,),{'offset':4,'unknown':2},None),
])
def test_binding_matrix(args,kwargs,expected):
    assert _bind_entry(numeric,args,kwargs)==expected
    if expected is None:
        with pytest.raises(TypeError):numeric(*args,**kwargs)
    else:assert numeric(*args,**kwargs)==(expected[0]+expected[1])*expected[2]+expected[3]


def test_current_mutable_defaults_preserve_identity():
    def fn(x,*,items=[]):return items
    first=_bind_entry(fn,(1,),{})
    assert first[1] is fn.__kwdefaults__['items']
    replacement=[];fn.__kwdefaults__['items']=replacement
    assert _bind_entry(fn,(1,),{})[1] is replacement
    assert _bind_entry(fn,(replacement,),{'items':replacement})[0] is replacement


def test_metadata_subclasses_and_custom_keys_fall_back_without_hooks():
    events=[]
    class Dict(dict):
        def get(self,*a):events.append('get');raise AssertionError('get hook')
        def __iter__(self):events.append('iter');raise AssertionError('iter hook')
    def fn(x,*,y=2):return x+y
    fn.__kwdefaults__=Dict(y=2)
    assert _bind_entry(fn,(1,),{}) is None
    assert events==[]


def test_keyword_only_aot_fresh_child_and_python_binding_fallback(tmp_path):
    source=tmp_path/'keyword_lib.py';source.write_text('def work(x, /, *, scale=3):\n    return x*scale\n')
    spec=importlib.util.spec_from_file_location('keyword_lib',source);m=importlib.util.module_from_spec(spec);sys.modules[m.__name__]=m;spec.loader.exec_module(m)
    region=lift_region(m.work);assert region(2,scale=4)==8 and region.aot_calls==0 and region.jit_calls==1
    folder=tmp_path/'aot';folder.mkdir();section=build_regions([(('work',1),m.work,region)],folder)
    script=tmp_path/'app.py';script.write_text('from keyword_lib import work\nassert work(2,scale=4)==8\nassert work(2)==6\nwork.__kwdefaults__["scale"]=5\nassert work(2)==10\nwork.__kwdefaults__={"scale":7}\nassert work(2)==14\nassert work(2**80,scale=4)==2**82\ntry:\n    work(2,4)\nexcept TypeError:\n    pass\nelse:\n    raise AssertionError("invalid binding accepted")\n')
    plan=tmp_path/'plan.json';plan.write_text(json.dumps(dict(script=str(script),plan=dict(worth_running=True,aot_regions=section),functions=[dict(file=str(source),function='work',line=1,candidate=dict(status='verified',recommended=True,engine='region'))])))
    probe='import json,sys;from pathlib import Path;from recompyler.runner import run_script;r=run_script(Path(sys.argv[1]),[],Path(sys.argv[2]));assert "numba" not in sys.modules;assert "llvmlite" not in sys.modules;print(json.dumps(r))'
    env=dict(os.environ,PYTHONPATH=os.pathsep.join([str(next(p/'src' for p in Path(__file__).resolve().parents if (p/'src/recompyler').is_dir())),str(tmp_path)]))
    done=subprocess.run([sys.executable,'-B','-c',probe,str(script),str(plan)],env=env,capture_output=True,text=True)
    assert done.returncode==0,done.stderr
    row=json.loads(done.stdout)['functions'][0]
    assert row['aot_calls']>=1 and row['jit_calls']==0 and row['fallback_calls']>=2
    assert row['compiled_calls']+row['fallback_calls']==6

@pytest.mark.parametrize('where',['kwargs','defaults'])
def test_custom_keys_are_declined_before_user_hash_or_equality(where):
    events=[]
    class Key(str):
        def __hash__(self):events.append('hash');return str.__hash__(self)
        def __eq__(self,other):events.append('eq');return str.__eq__(self,other)
    def fn(x,*,y=2):return x+y
    mapping={Key('y'):3};events.clear()
    if where=='defaults':fn.__kwdefaults__=mapping;kwargs={}
    else:kwargs=mapping
    assert _bind_entry(fn,(1,),kwargs) is None
    assert events==[]


@pytest.mark.parametrize('where',['args','defaults'])
def test_tuple_metadata_subclasses_are_declined_without_hooks(where):
    events=[]
    class Tuple(tuple):
        def __len__(self):events.append('len');raise AssertionError('length hook')
        def __bool__(self):events.append('bool');raise AssertionError('truth hook')
        def __iter__(self):events.append('iter');raise AssertionError('iteration hook')
    def fn(x=1,*,y=2):return x+y
    args=Tuple((1,)) if where=='args' else ()
    if where=='defaults':fn.__defaults__=Tuple((1,))
    assert _bind_entry(fn,args,{}) is None
    assert events==[]


class BoundMethod:
    def work(self,x=2,*,scale,offset=1):return x*scale+offset


@pytest.mark.parametrize('backend',['python','c'])
def test_bound_method_capture_includes_required_keyword_and_defaults(backend):
    obj=BoundMethod()
    with CallMonitor([__file__],8,profiler.snapshot,backend=backend,bias=0,yield_bias=0) as monitor:
        assert obj.work(scale=3)==7
    sampler=next(s for k,s in monitor.samplers.items() if k[1]=='work')
    arguments=sampler.samples[0][0]
    assert arguments[1:]==(2,3,1) and type(arguments[0]) is BoundMethod


def test_existing_varargs_order_and_varkw_safe_fallback():
    def fn(a,/,b=2,*rest,c=3):return a,b,rest,c
    assert _bind_entry(fn,(1,4,8,9),{'c':5})==(1,4,5,(8,9))
    assert _bind_entry(fn,(1,),{})==(1,2,3,())
    def varkw(a,**kw):return a+kw.get('b',0)
    assert _bind_entry(varkw,(1,),{'b':2}) is None
    lifted=lift_region(varkw)
    assert lifted(1,b=2)==3 and lifted.fallback_calls==1


def test_shared_positional_and_keyword_defaults_keep_aliases():
    shared=[]
    def fn(items=shared,*,other=shared):return items is other
    bound=_bind_entry(fn,(),{})
    assert bound[0] is shared and bound[1] is shared


def test_selection_times_the_normal_runtime_binder(monkeypatch):
    from recompyler import heap
    seen=[];old=heap._bind_entry
    def binding(*args,**kwargs):seen.append(1);return old(*args,**kwargs)
    monkeypatch.setattr(heap,'_bind_entry',binding)
    inputs=[((2,2,3,5),17,(2,2,3,5))]
    result=profiler.test_candidate(numeric,inputs,2)
    assert result['status']=='verified',result
    assert seen,'Compiled warm/startup timing skipped the normal runtime binder'

def recursive_keyword(n,*,step=2):
    if n:
        return recursive_keyword(n-1,step=step)+step
    return 0


def test_selection_rejects_recursive_default_metadata_without_hooks(monkeypatch):
    events=[]
    class Defaults(dict):
        def __bool__(self):events.append('bool');raise AssertionError('default metadata truth hook')
    monkeypatch.setattr(recursive_keyword,'__kwdefaults__',Defaults(step=2))
    assert recursive_keyword(2,step=3)==6
    result=profiler.test_candidate(recursive_keyword,[((2,3),6,(2,3))],1)
    assert result['status'] in ('skipped','unverified'),result
    assert events==[]


def test_selection_reads_actual_code_without_wrapped_metadata_hooks(monkeypatch):
    events=[]
    class Trap:
        def __getattribute__(self,name):events.append(name);raise AssertionError('wrapped metadata hook')
    monkeypatch.setattr(numeric,'__wrapped__',Trap(),raising=False)
    result=profiler.test_candidate(numeric,[((2,2,3,5),17,(2,2,3,5))],1)
    assert result['status']=='verified',result
    assert events==[]

def keyword_helper_root(n,*,step):
    return recursive_keyword(n,step=step)


def test_selection_rejects_callee_default_metadata_without_hooks(monkeypatch):
    events=[]
    class Defaults(dict):
        def __bool__(self):events.append('bool');raise AssertionError('callee default truth hook')
    monkeypatch.setattr(recursive_keyword,'__kwdefaults__',Defaults(step=2))
    assert keyword_helper_root(2,step=3)==6
    result=profiler.test_candidate(keyword_helper_root,[((2,3),6,(2,3))],1)
    assert result['status']=='skipped',result
    assert events==[]


@pytest.mark.parametrize('backend',['python','c'])
def test_keyword_only_lazy_entries_remain_explicitly_declined(backend):
    with CallMonitor([__file__],8,profiler.snapshot,backend=backend,bias=0,yield_bias=0) as monitor:
        assert list(keyword_generator(scale=2))==[2]
        coroutine=keyword_coroutine(scale=3)
        with pytest.raises(StopIteration) as stopped:coroutine.send(None)
        assert stopped.value.value==3
    for name in ('keyword_generator','keyword_coroutine'):
        key=next(k for k in monitor.skipped if k[1]==name)
        assert 'keyword-only arguments in a generator or coroutine' in monitor.skipped[key]
        assert key not in monitor.samplers


def keyword_generator(*,scale=1):
    yield scale


async def keyword_coroutine(*,scale=1):
    return scale

def ordinary_generator(n):
    for i in range(n):
        yield i


def consuming_keyword_root(n,*,scale):
    total=0
    for item in ordinary_generator(n):
        total+=item*scale
    return total


def test_generator_callee_default_metadata_never_runs_hooks(monkeypatch):
    events=[]
    class Defaults(dict):
        def __bool__(self):events.append('bool');raise AssertionError('generator default truth hook')
    monkeypatch.setattr(ordinary_generator,'__kwdefaults__',Defaults())
    assert consuming_keyword_root(3,scale=2)==6
    result=profiler.test_candidate(consuming_keyword_root,[((3,2),6,(3,2))],1)
    assert result['status']=='skipped',result
    assert events==[]


def test_generator_inline_binding_ignores_signature_metadata(monkeypatch):
    events=[]
    class Trap:
        def __getattribute__(self,name):events.append(name);raise AssertionError('generator signature hook')
    monkeypatch.setattr(ordinary_generator,'__signature__',Trap(),raising=False)
    result=profiler.test_candidate(consuming_keyword_root,[((3,2),6,(3,2))],1)
    assert result['status']=='verified',result
    assert events==[]


class Constructed:
    def __init__(self,x):self.x=x


def constructing_keyword_root(n,*,scale):
    return Constructed(n).x*scale


def test_constructor_analysis_reads_code_without_wrapped_hooks(monkeypatch):
    events=[]
    class Trap:
        def __getattribute__(self,name):events.append(name);raise AssertionError('constructor wrapped hook')
    monkeypatch.setattr(Constructed.__init__,'__wrapped__',Trap(),raising=False)
    result=profiler.test_candidate(constructing_keyword_root,[((3,2),6,(3,2))],1)
    assert result['status']=='verified',result
    assert events==[]


def test_seed_default_metadata_never_calls_metaclass_equality(monkeypatch):
    from recompyler._region_seed import _fingerprint
    from recompyler.lift import Unsupported
    events=[]
    class Meta(type):
        def __eq__(cls,other):events.append('eq');raise AssertionError('default metaclass equality')
    class Opaque(metaclass=Meta):pass
    monkeypatch.setattr(recursive_keyword,'__kwdefaults__',{'step':Opaque()})
    with pytest.raises(Unsupported):_fingerprint(recursive_keyword)
    assert events==[]


def test_seed_binding_labels_do_not_run_module_equality(monkeypatch):
    from recompyler._region_seed import Bindings
    events=[]
    class Trap:
        def __eq__(self,other):events.append('eq');raise AssertionError('module label equality')
    monkeypatch.setattr(recursive_keyword,'__module__',Trap())
    assert Bindings(keyword_helper_root).ref(recursive_keyword)==['recursive_keyword']
    assert events==[]

def test_seed_resolution_rejects_stale_metaclass_without_equality(monkeypatch):
    from recompyler._region_seed import Bindings
    from recompyler.lift import Unsupported
    events=[]
    class Meta(type):
        def __eq__(cls,other):events.append('eq');raise AssertionError('stale binding equality')
    class Stale(metaclass=Meta):pass
    monkeypatch.setitem(keyword_helper_root.__globals__,'stale_binding',Stale())
    with pytest.raises(Unsupported):Bindings(keyword_helper_root).resolve(['stale_binding','member'])
    assert events==[]


def test_seed_binding_module_labels_use_raw_dict_without_getattr(monkeypatch):
    from types import ModuleType
    from recompyler._region_seed import Bindings
    events=[];module=ModuleType('unused');del module.__name__
    def missing(name):events.append(name);raise AssertionError('module metadata getattr')
    module.__getattr__=missing
    monkeypatch.setitem(keyword_helper_root.__globals__,'module_without_name',module)
    assert Bindings(keyword_helper_root).ref(recursive_keyword)==['recursive_keyword']
    assert Bindings(keyword_helper_root).ref(module)==['module_without_name']
    assert events==[]
