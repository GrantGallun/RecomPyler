"""Independent-review counterexamples; run fail-first before their fixes."""
import builtins
import gc
from types import FunctionType,MethodType
import weakref
import pytest
from test_prepared_cache import artifact,row_for,standalone,load_source,SOURCE


def test_bound_method_function_cannot_masquerade_by_names(artifact,monkeypatch):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section,'random_step'),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.random_step),pc.last_miss()
    old=module.random.randrange
    def replacement(self,*args): return 0
    replacement.__module__=old.__func__.__module__
    replacement.__qualname__=old.__func__.__qualname__
    replacement.__name__=old.__func__.__name__
    monkeypatch.setattr(module.random,'randrange',MethodType(replacement,old.__self__))
    assert index.bind(module.random_step)==[]


def test_actual_function_builtins_cannot_hide_behind_globals_entry(artifact):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work)
    namespace=dict(module.__dict__)
    private=dict(vars(builtins)); private['abs']=lambda v:999
    namespace['__builtins__']=private
    helper=FunctionType(module.helper.__code__,namespace,'helper',module.helper.__defaults__)
    namespace['__builtins__']=builtins
    namespace['helper']=helper
    work=FunctionType(module.work.__code__,namespace,'work',module.work.__defaults__)
    work.__kwdefaults__=module.work.__kwdefaults__.copy()
    assert helper.__builtins__ is private and work.__builtins__ is vars(builtins)
    assert index.bind(work)==[]


def test_nested_unsupported_class_value_never_runs_type_hooks(artifact,monkeypatch):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work)
    events=[]
    class Meta(type):
        def __getattribute__(cls,name):
            if name in ('__module__','__name__','__qualname__'): events.append(name)
            return super().__getattribute__(name)
    class Hostile(metaclass=Meta): pass
    monkeypatch.setattr(module.Box,'unused',Hostile(),raising=False)
    assert index.bind(module.work)==[]
    assert events==[]


def test_unsupported_literal_type_metadata_is_not_looked_up():
    from recompyler import _prepared as pc
    events=[]
    class Meta(type):
        def __getattribute__(cls,name):
            if name in ('__module__','__name__','__qualname__'): events.append(name)
            return super().__getattribute__(name)
    class Hostile(metaclass=Meta): pass
    with pytest.raises(pc.PreparedMiss): pc.literal_key(Hostile())
    assert events==[]


def test_unrelated_class_value_destruction_is_not_delayed_by_prepared_program(tmp_path):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'retention_fixture.py'
    source.write_text(SOURCE+'''\nevents=[]
class Sentinel:
    def __del__(self): events.append('destroyed')
Box.unused=[Sentinel()]
''')
    module=load_source(source)
    region=heap.lift_region(module.read)
    assert region(module.Box(10))==10 and region.compiled_calls==1
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None,pc.last_miss()
    fast=heap.lift_region(module.read,index.exports,prepared=index)
    assert fast(module.Box(10))==10 and fast.aot_calls==1
    reference=weakref.ref(module.Box.unused[0])
    module.Box.unused=None
    gc.collect()
    assert reference() is None and module.events==['destroyed']
    assert fast is not None and index is not None


def test_actual_builtin_namespace_alias_is_sealed(artifact):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work)
    namespace=dict(module.__dict__)
    private=dict(vars(builtins))
    namespace['__builtins__']=private
    helper=FunctionType(module.helper.__code__,namespace,'helper',module.helper.__defaults__)
    namespace['__builtins__']=builtins
    namespace['helper']=helper
    work=FunctionType(module.work.__code__,namespace,'work',module.work.__defaults__)
    work.__kwdefaults__=module.work.__kwdefaults__.copy()
    assert helper.__builtins__ is not work.__builtins__
    assert index.bind(work)==[]


def test_first_import_rejects_export_from_other_binary(artifact,tmp_path,monkeypatch):
    import importlib.machinery
    import sys
    pc,heap,module,source,section=artifact
    other_source=tmp_path/'other.py'
    other_source.write_text('def other(x):\n    return x+999\n')
    other=load_source(other_source)
    region=heap.lift_region(other.other)
    assert region(1)==1000 and region.compiled_calls==1
    other_section=heap.build_regions([(('other',1),other.other,region)],tmp_path)
    other_index=pc.open_index(other_section,other_section['functions'][0],plan_snapshot=standalone(other_section))
    assert other_index is not None
    target_name=next(iter(section['functions'][0]['exports'].values()))
    replacement=vars(other_index.module)[target_name]
    monkeypatch.setattr(replacement,'__module__',section['module'])
    old_module=sys.modules.pop(section['module'],None)
    old_verified=pc._VERIFIED_MODULES.pop(section['module'],None)
    old_export=vars(old_module).get(target_name) if old_module else None
    original=importlib.machinery.ExtensionFileLoader.exec_module
    def observer(loader,native):
        original(loader,native)
        if native.__name__==section['module']:
            setattr(native,target_name,replacement)
    monkeypatch.setattr(importlib.machinery.ExtensionFileLoader,'exec_module',observer)
    try:
        assert pc.open_index(section,row_for(section),plan_snapshot=standalone(section)) is None
    finally:
        if old_module is not None:
            setattr(old_module,target_name,old_export)
            sys.modules[section['module']]=old_module
        if old_verified is not None: pc._VERIFIED_MODULES[section['module']]=old_verified


def test_nested_class_payload_is_not_retained(tmp_path):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'nested_retention.py'
    source.write_text(SOURCE+"\nevents=[]\nclass Sentinel:\n    def __del__(self): events.append('destroyed')\nBox.unused=type('Holder',(),{'payload':Sentinel()})\n")
    module=load_source(source)
    region=heap.lift_region(module.read)
    assert region(module.Box(10))==10 and region.compiled_calls==1
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None,pc.last_miss()
    fast=heap.lift_region(module.read,index.exports,prepared=index)
    assert fast(module.Box(10))==10 and fast.aot_calls==1
    reference=weakref.ref(module.Box.unused.payload)
    module.Box.unused=None
    gc.collect()
    assert reference() is None and module.events==['destroyed']


def test_unused_function_payload_is_not_retained(tmp_path):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'function_retention.py'
    source.write_text(SOURCE+"\nevents=[]\nclass Sentinel:\n    def __del__(self): events.append('destroyed')\ndef attach():\n    def unused(): return 1\n    unused.payload=Sentinel()\n    Box.unused=unused\nattach()\n")
    module=load_source(source)
    region=heap.lift_region(module.read)
    assert region(module.Box(10))==10 and region.compiled_calls==1
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None,pc.last_miss()
    fast=heap.lift_region(module.read,index.exports,prepared=index)
    assert fast(module.Box(10))==10 and fast.aot_calls==1
    reference=weakref.ref(module.Box.unused.payload)
    module.Box.unused=None
    gc.collect()
    assert reference() is None and module.events==['destroyed']


@pytest.mark.parametrize('container',['kwdefaults','closure'])
def test_unused_function_mutable_metadata_does_not_pin_late_objects(tmp_path,container):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'late_retention.py'
    source.write_text(SOURCE+"\nevents=[]\nclass Sentinel:\n    def __del__(self): events.append('destroyed')\ndef attach():\n    value=1\n    def unused(*,x=1): return value+x\n    Box.unused=unused\nattach()\n")
    module=load_source(source)
    region=heap.lift_region(module.read)
    assert region(module.Box(10))==10 and region.compiled_calls==1
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None,pc.last_miss()
    fast=heap.lift_region(module.read,index.exports,prepared=index)
    assert fast(module.Box(10))==10 and fast.aot_calls==1
    sentinel=module.Sentinel()
    reference=weakref.ref(sentinel)
    if container=='kwdefaults': module.Box.unused.__kwdefaults__['x']=sentinel
    else: module.Box.unused.__closure__[0].cell_contents=sentinel
    del sentinel
    module.Box.unused=None
    gc.collect()
    assert reference() is None and module.events==['destroyed']


def test_late_keyword_default_keys_never_invoke_user_equality(tmp_path):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'keyword_hooks.py'
    source.write_text(SOURCE+"\ndef unused(*,x=1): return x\nBox.unused=unused\n")
    module=load_source(source)
    region=heap.lift_region(module.read)
    assert region(module.Box(10))==10 and region.compiled_calls==1
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None,pc.last_miss()
    program=index.bind(module.read)[0]
    events=[]
    class EvilKey:
        def __hash__(self): return hash('x')
        def __eq__(self,other): events.append('equal'); return True
    module.unused.__kwdefaults__.clear()
    module.unused.__kwdefaults__[EvilKey()]=1
    events.clear()
    result=program.guards_hold()
    assert events==[]
    assert result is True  # unused method metadata is outside the dependency closure


def test_borrowed_unused_class_closure_does_not_retain_owner(tmp_path):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'owner_retention.py'
    source.write_text(SOURCE+"\nevents=[]\nclass Sentinel:\n    def __del__(self): events.append('destroyed')\nclass Other:\n    def unused(self): return __class__\nOther.unused.payload=Sentinel()\nBox.unused=Other.unused\n")
    module=load_source(source)
    region=heap.lift_region(module.read)
    assert region(module.Box(10))==10 and region.compiled_calls==1
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None,pc.last_miss()
    fast=heap.lift_region(module.read,index.exports,prepared=index)
    assert fast(module.Box(10))==10 and fast.aot_calls==1
    reference=weakref.ref(module.Other.unused.payload)
    module.Box.unused=None
    module.Other=None
    gc.collect()
    assert reference() is None and module.events==['destroyed']


def test_unsupported_type_never_invokes_metaclass_equality():
    from recompyler import _prepared as pc
    events=[]
    class Meta(type):
        def __eq__(self,other): events.append('equal'); return False
        __hash__=type.__hash__
    class Hostile(metaclass=Meta): pass
    with pytest.raises(pc.PreparedMiss): pc.literal_key(Hostile())
    assert events==[]


def test_real_builtin_range_dependency_can_prepare(tmp_path):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'range_fixture.py'
    source.write_text('def work(n):\n    total=0\n    for i in range(n): total+=i\n    return total\n')
    module=load_source(source)
    region=heap.lift_region(module.work)
    assert region(10)==45 and region.compiled_calls==1
    section=heap.build_regions([(('work',1),module.work,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work),pc.last_miss()


def test_used_keyword_default_keys_never_invoke_user_equality(artifact):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    program=index.bind(module.work)[0]
    events=[]
    class EvilKey:
        def __hash__(self): return hash('bias')
        def __eq__(self,other): events.append('equal'); return True
    old=module.work.__kwdefaults__.copy()
    try:
        module.work.__kwdefaults__.clear()
        module.work.__kwdefaults__[EvilKey()]=1
        events.clear()
        assert program.guards_hold() is False
        assert events==[]
    finally:
        module.work.__kwdefaults__.clear();module.work.__kwdefaults__.update(old)
