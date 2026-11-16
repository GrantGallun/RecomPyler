"""Fail-first equivalence and hook-domain checks for native live guards."""
import math
import struct
from types import FunctionType
import pytest
from recompyler import _heap as native


def fn(value=1):
    return value


def heap_check(*guards):
    return native.check_heap_guards(dict(enumerate(guards)))


@pytest.mark.parametrize('tag', ['code','item','builtin','const','attr','own','lifetime','kwdefaults'])
def test_heap_guard_checks_live_rebinding(tag):
    def target(value=1, *, option=2): return value + option
    class Record:
        def __init__(self, value): self.value = value
        def read(self): return self.value
    namespace = {'value': target}
    if tag == 'code':
        guard = ('code', target, target.__code__)
        mutate = lambda: setattr(target, '__code__', fn.__code__)
    elif tag == 'item':
        guard = ('item', namespace, 'value', target)
        mutate = lambda: namespace.update(value=fn)
    elif tag == 'builtin':
        namespace = {}; lookup = {'len': len}
        guard = ('builtin', namespace, 'len', lookup, len)
        mutate = lambda: namespace.update(len=len)
    elif tag == 'const':
        namespace = {'value': 1.25}; guard = ('const', namespace, 'value', 1.25)
        mutate = lambda: namespace.update(value=-1.25)
    elif tag == 'attr':
        guard = ('attr', target, '__defaults__', target.__defaults__)
        mutate = lambda: setattr(target, '__defaults__', (3,))
    elif tag == 'own':
        guard = ('own', Record, 'read', Record.read)
        mutate = lambda: setattr(Record, 'read', fn)
    elif tag == 'lifetime':
        guard = ('lifetime', Record)
        mutate = lambda: setattr(Record, '__del__', lambda self: None)
    else:
        guard = ('kwdefaults', target, target.__kwdefaults__, tuple(target.__kwdefaults__.items()))
        mutate = lambda: target.__kwdefaults__.update(option=3)
    assert heap_check(guard) is True
    mutate()
    assert heap_check(guard) is False


@pytest.mark.parametrize('value', [None, True, False, 0, 2**63-1, -2**63, 1.25, 'text', b'bytes'])
def test_exact_primitive_constants_keep_equal_value_semantics(value):
    space = {'value': value}
    assert heap_check(('const', space, 'value', value)) is True


@pytest.mark.parametrize('saved,current,expected', [(0.,-0.,False),(-0.,0.,False),(float('nan'),float('nan'),False),(float('inf'),float('inf'),True)])
def test_float_constant_repr_distinctions(saved,current,expected):
    assert heap_check(('const', {'x':current}, 'x', saved)) is expected


def test_missing_dictionary_item_matches_none_but_builtin_shadow_does_not():
    assert heap_check(('item', {}, 'missing', None)) is True
    assert heap_check(('builtin', {'len':None}, 'len', {'len':len}, len)) is False
    assert heap_check(('builtin', {}, 'len', {}, None)) is True


def test_inherited_class_attribute_and_own_dictionary_differ():
    class Base:
        def __init__(self): pass
        def read(self): return 1
    class Child(Base): pass
    assert heap_check(('attr', Child, 'read', Base.read), ('own', Child, 'read', None), ('lifetime', Child)) is True
    Base.__new__ = staticmethod(lambda cls: object.__new__(cls))
    assert heap_check(('lifetime', Child)) is False


def test_late_mro_change_rechecks_inherited_lifetime():
    class Base: pass
    class Other:
        def __del__(self): pass
    class Child(Base): pass
    assert heap_check(('lifetime', Child)) is True
    Child.__bases__ = (Other,)
    assert heap_check(('lifetime', Child)) is False


@pytest.mark.parametrize('shape', ['dictionary-subclass','key-subclass','foreign-key','unknown-tag','malformed'])
def test_unsupported_metadata_returns_none_without_hooks(shape):
    events=[]
    class Mapping(dict):
        def get(self,*args): events.append('get');return None
        def __contains__(self,*args): events.append('contains');return False
    class Key(str):
        def __hash__(self):events.append('hash');return super().__hash__()
        def __eq__(self,other):events.append('equal');return super().__eq__(other)
    class Foreign:
        def __hash__(self):return hash('value')
        def __eq__(self,other):events.append('equal');return False
    if shape=='dictionary-subclass': guard=('item',Mapping(value=fn),'value',fn)
    elif shape=='key-subclass': guard=('item',{Key('value'):fn},'value',fn)
    elif shape=='foreign-key': guard=('item',{Foreign():fn},'value',fn)
    elif shape=='unknown-tag': guard=('future-guard',object())
    else:guard=('code',)
    events.clear()
    assert heap_check(guard) is None
    assert events==[]


def test_custom_class_descriptor_returns_none_without_invoking_get():
    events=[]
    class Descriptor:
        def __get__(self,*args):events.append('get');return fn
    class Record:
        read=Descriptor()
    assert heap_check(('attr',Record,'read',fn)) is None
    assert events==[]


def test_heap_guard_mapping_is_read_live_each_call():
    guards={1:('code',fn,fn.__code__)}
    assert native.check_heap_guards(guards) is True
    guards[1]=('item',{},'fn',fn)
    assert native.check_heap_guards(guards) is False


def test_lift_identity_miss_falls_back_to_existing_full_equivalence():
    current=struct.unpack('d',struct.pack('d',1.25))[0]
    expected=struct.unpack('d',struct.pack('d',1.25))[0]
    assert current is not expected and current==expected
    checks=([({'value':current},'value',expected,None)],[],[])
    assert native.check_lift_guards(checks,vars(math)) is None


def test_lift_checks_function_code_builtin_and_math_live():
    def original(value):return value
    namespace={'original':original}; builtins={};lookup={'len':len};maths={'sqrt':math.sqrt}
    checks=([(namespace,'original',original,original.__code__)],[(builtins,'len',lookup,len)],[('sqrt',math.sqrt)])
    assert native.check_lift_guards(checks,maths) is True
    maths['sqrt']=abs
    assert native.check_lift_guards(checks,maths) is False
    maths['sqrt']=math.sqrt;lookup['len']=abs
    assert native.check_lift_guards(checks,maths) is False
    lookup['len']=len;original.__code__=fn.__code__
    assert native.check_lift_guards(checks,maths) is False


def test_lift_builtin_namespace_override_retains_lookup_order():
    namespace={'len':len};lookup={'len':abs}
    assert native.check_lift_guards(([],[(namespace,'len',lookup,len)],[]),{}) is True
    namespace.clear()
    assert native.check_lift_guards(([],[(namespace,'len',lookup,len)],[]),{}) is False


def test_function_default_and_keyword_default_identity_changes():
    def target(value=1,*,option=2):return value+option
    defaults=target.__defaults__;kwdefaults=target.__kwdefaults__
    guards=(('attr',target,'__defaults__',defaults),('attr',target,'__kwdefaults__',kwdefaults))
    assert heap_check(*guards) is True
    target.__kwdefaults__=dict(kwdefaults)
    assert heap_check(*guards) is False


def test_same_nan_object_is_still_an_invalid_constant():
    value=float('nan')
    assert heap_check(('const',{'x':value},'x',value)) is False


def test_staticmethod_attribute_and_canonical_allocator_unwrap():
    class Record:
        __new__=staticmethod(object.__new__)
        read=staticmethod(fn)
    assert heap_check(('lifetime',Record),('attr',Record,'read',fn)) is True
    Record.__new__=staticmethod(lambda cls: object.__new__(cls))
    assert heap_check(('lifetime',Record)) is False


def test_uninitialized_staticmethod_matches_python_or_declines():
    class Record:
        empty=staticmethod.__new__(staticmethod)
    try:
        expected=getattr(Record,'empty',None) is None
    except (AttributeError,RuntimeError):
        expected=None
    answer=heap_check(('attr',Record,'empty',None))
    assert answer is None or answer is expected


def test_unsupported_descriptor_keeps_order_before_later_false_guard():
    from recompyler import heap
    events=[]
    class Descriptor:
        def __get__(self,*args):events.append('get');return fn
    class Record:read=Descriptor()
    guards={0:('attr',Record,'read',fn),1:('item',{},'missing',fn)}
    assert native.check_heap_guards(guards) is None
    assert events==[]
    program=heap._Program(fn);program.guards=guards
    assert program.guards_hold() is False
    assert events==['get']


def test_custom_metaclass_is_not_invoked_by_native_preflight():
    events=[]
    class Meta(type):
        def __getattribute__(self,name):events.append(name);return super().__getattribute__(name)
    class Record(metaclass=Meta):pass
    events.clear()
    assert heap_check(('lifetime',Record)) is None
    assert events==[]


def test_class_missing_attribute_and_metatype_data_descriptor():
    class Record:pass
    assert heap_check(('attr',Record,'missing',None)) is True
    assert heap_check(('attr',Record,'__mro__',Record.__mro__)) is True


def test_dictionary_domain_cache_never_skips_later_hostile_keys():
    events=[]
    class Key:
        def __hash__(self):return hash('value')
        def __eq__(self,other):events.append('equal');return False
    guards={i:('item',{'value':fn},'value',fn) for i in range(128)}
    guards[128]=('item',{Key():None},'value',fn)
    events.clear()
    assert native.check_heap_guards(guards) is None
    assert events==[]


def test_metatype_nondata_fallback_is_not_treated_as_missing():
    from recompyler import heap
    class Record:pass
    guard=('attr',Record,'mro',None)
    assert heap_check(guard) is None
    program=heap._Program(fn);program.guards={0:guard}
    assert program.guards_hold() is False
    Record.mro=fn
    assert heap_check(('attr',Record,'mro',fn)) is True
    program.guards={0:('attr',Record,'mro',fn)}
    assert program.guards_hold() is True


def test_inherited_metatype_data_descriptor_falls_back():
    class Record:pass
    assert heap_check(('attr',Record,'__class__',type)) is None
