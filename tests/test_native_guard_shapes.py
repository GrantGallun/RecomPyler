"""Measured native guard shapes, owner lifetime and audited fallback."""
import gc
import math
import subprocess
import sys
import textwrap
import types
import weakref
import pytest
from recompyler import _heap as native, lift

def helper(value=1.0):
    return math.sqrt(value)

def root(value):
    return helper() + math.sqrt(value)

def holder(owner):
    return native.GuardAttribute(owner)

def lift_checks(space, name, value):
    return ([(space,name,value,None)],[],[])

def test_actual_lift_default_and_math_guards_take_native_path():
    unit=lift._Unit();unit.function(root)
    assert unit.guards_hold() is True
    attributes=[row[0] for row in unit.guards if type(row[0]) is not dict]
    assert attributes and all(type(space) is native.GuardAttribute for space in attributes)
    assert native.check_lift_guards(unit._fast_guards,vars(math)) is True


def test_mro_guard_is_live_and_data_descriptor_wins_shadow():
    class Base:pass
    class Other:pass
    class Record(Base):pass
    saved=Record.__mro__;guards={0:('attr',Record,'__mro__',saved)}
    assert native.check_heap_guards(guards) is True
    Record.__bases__=(Other,)
    assert native.check_heap_guards(guards) is False
    class Shadow:
        __mro__=('shadow',)
    assert native.check_heap_guards({0:('attr',Shadow,'__mro__',type.__dict__['__mro__'].__get__(Shadow,type))}) is True


def test_custom_metaclass_mro_stays_unobserved():
    events=[]
    class Meta(type):
        def __getattribute__(cls,name):events.append(name);return super().__getattribute__(name)
    class Record(metaclass=Meta):pass
    saved=Record.__mro__;events.clear()
    assert native.check_heap_guards({0:('attr',Record,'__mro__',saved)}) is None
    assert events==[]


def test_holder_owner_rebind_delete_none_and_uninitialized():
    a=types.ModuleType('a');b=types.ModuleType('b');a.value=1;b.value=2
    value=holder(a)
    assert value.owner is a and value.get('value')==1
    checks=lift_checks(value,'value',1)
    assert native.check_lift_guards(checks,{}) is True
    value.owner=b
    assert value.get('value')==2 and native.check_lift_guards(checks,{}) is None
    value.owner=None
    assert value.get('absent') is None
    assert native.check_lift_guards(lift_checks(value,'absent',None),{}) is None
    del value.owner
    with pytest.raises(AttributeError):value.get('value')
    assert native.check_lift_guards(checks,{}) is None
    empty=native.GuardAttribute.__new__(native.GuardAttribute)
    with pytest.raises(AttributeError):empty.get('value')


def test_holder_type_is_immutable_and_not_subclassable():
    value=holder(math)
    with pytest.raises(TypeError):native.GuardAttribute.get=lambda *args:None
    with pytest.raises(TypeError):type('Child',(native.GuardAttribute,),{})
    original=native.GuardAttribute
    try:
        native.GuardAttribute=type('Fake',(),{})
        assert native.check_lift_guards(lift_checks(value,'sqrt',math.sqrt),{}) is True
    finally:native.GuardAttribute=original


def test_holder_preserves_owner_gc_cycles_and_finalization():
    events=[]
    class Owner:
        def __del__(self):events.append('owner')
    owner=Owner();watch=weakref.ref(owner);value=holder(owner);owner.guard=value
    assert gc.is_tracked(value)
    del value,owner
    gc.collect()
    assert watch() is None and events==['owner']


@pytest.mark.parametrize('name',['__dict__','__class__'])
def test_module_data_descriptor_shadow_is_not_a_raw_dict_value(name):
    module=types.ModuleType('spoof');sentinel=object();vars(module)[name]=sentinel
    value=holder(module)
    assert native.check_lift_guards(lift_checks(value,name,sentinel),{}) is None
    assert value.get(name) is getattr(module,name) and value.get(name) is not sentinel


def test_missing_module_attribute_replays_late_hook_and_exceptions():
    module=types.ModuleType('late');events=[];value=holder(module);sentinel=object()
    module.__getattr__=lambda name:(events.append(name),sentinel)[1]
    assert native.check_lift_guards(lift_checks(value,'missing',sentinel),{}) is None
    assert events==[]
    assert value.get('missing') is sentinel and events==['missing']
    class Stop(BaseException):pass
    marker=Stop('same')
    def fail(name):raise marker
    module.__getattr__=fail
    with pytest.raises(Stop) as caught:value.get('missing')
    assert caught.value is marker
    def absent(name):raise AttributeError(name)
    module.__getattr__=absent
    assert value.get('missing') is None


AUDIT_SOURCE=r"""
import json,sys,types
from recompyler import _heap as native,lift
mode=sys.argv[1]
def target(value=1):return value
saved=target.__defaults__;wrapper=lift._Attribute(target)
unit=object.__new__(lift._Unit);unit._fast_guards=([(wrapper,'__defaults__',saved,None)],[],[])
unit.records=types.SimpleNamespace(infos={});unit.guards=[(wrapper,'__defaults__',saved,None)];unit.builtin_guards={};unit.math_guards=set()
trace=[]
class Stop(BaseException):pass
marker=Stop('audit holder')
def hook(event,args):
 if event=='object.__getattr__' and args[0] is target and args[1]=='__defaults__':
  trace.append(args[1])
  if mode=='raise':raise marker
  if mode=='mutate':target.__defaults__=(99,)
sys.addaudithook(hook)
assert native.check_lift_guards(unit._fast_guards,{}) is None and trace==[]
fast=lift._NATIVE_GUARDS;results=[]
for enabled in (False,True):
 target.__defaults__=saved;trace.clear();lift._NATIVE_GUARDS=fast if enabled else None
 try:outcome=('return',unit.guards_hold())
 except BaseException as error:outcome=('raise',error is marker,type(error).__name__,str(error))
 results.append((outcome,list(trace)))
assert results[0]==results[1] and results[0][1],results
print(json.dumps(dict(mode=mode,matched=True)))
"""

@pytest.mark.parametrize('mode',['log','raise','mutate'])
def test_native_holder_preserves_audited_fallback(mode):
    child=subprocess.run([sys.executable,'-c',textwrap.dedent(AUDIT_SOURCE),mode],capture_output=True,text=True,timeout=30)
    assert child.returncode==0,(child.stdout,child.stderr)


def test_holder_deep_owner_chain_releases_without_c_stack_overflow():
    source="from recompyler import _heap as n; chain=None\nfor i in range(100000): chain=n.GuardAttribute(chain)\ndel chain\nprint('released')"
    child=subprocess.run([sys.executable,'-c',source],capture_output=True,text=True,timeout=30)
    assert child.returncode==0,(child.returncode,child.stdout,child.stderr)
    assert child.stdout.strip()=='released'
