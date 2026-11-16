"""Original-code function/default/live-cell creation, including real settle target."""
import importlib,types
import pytest
from recompyler import heap


def captured_pair(value):
    def read(default=value,/):return value,default
    def write(new):
        nonlocal value
        value=new
        return read()
    value=[]
    return read,write


def external_free_factory(value):
    def make():
        def read():return value
        return read
    return make


def default_value(events,label,value):events.append(label);return value


def decorate(events,label):
    events.append('evaluate '+label)
    def apply(function):events.append('apply '+label);return function
    return apply


def ordered_creation(events,value):
    @decorate(events,'first')
    @decorate(events,'second')
    def read(first=default_value(events,'positional',value),*,tail=default_value(events,'keyword',value)):
        return first,tail
    return read


def captured_builtin_context(action,value):
    action()
    def read():return len(value)
    return read


def early_empty_cell(action):
    def read():return value
    result=action(read)
    value='later'
    return result


def test_real_settle_function_definition_is_compilable():
    def scalar(value):return value+1
    program=heap._Program(scalar)
    program.entry.vars['value']=heap.INT
    fast=heap.lift_structures(heap._Program.settle)
    assert fast.run is not None,fast.problem
    assert fast(program) is None and program.entry.ret==heap.INT
    assert fast.compiled_calls==1 and fast.fallback_calls==0


def test_actual_code_defaults_and_shared_live_cells():
    value=object()
    fast=heap.lift_structures(captured_pair)
    assert fast.run is not None,fast.problem
    read,write=fast(value)
    expected={code.co_name:code for code in captured_pair.__code__.co_consts if type(code) is types.CodeType}
    assert read.__code__ is expected['read'] and write.__code__ is expected['write']
    assert read.__globals__ is captured_pair.__globals__
    assert read.__defaults__[0] is value
    changed=object()
    result=write(changed)
    assert result[0] is changed and result[1] is value
    assert read.__closure__[0] is write.__closure__[1]
    assert fast.compiled_calls==1 and fast.fallback_calls==0


def test_existing_external_free_cells_remain_the_actual_cells():
    original=external_free_factory(object());fast=heap.lift_structures(original)
    assert fast.run is not None,fast.problem
    result=fast()
    assert result.__closure__[0] is original.__closure__[0]
    assert result() is original()()
    assert fast.compiled_calls==1 and fast.fallback_calls==0


def test_decorators_and_defaults_use_original_order_and_owners():
    value=object();events=[];fast=heap.lift_structures(ordered_creation)
    assert fast.run is not None,fast.problem
    result=fast(events,value)
    assert events==['evaluate first','evaluate second','positional','keyword','apply second','apply first']
    assert result()[0] is value and result()[1] is value
    assert result.__kwdefaults__['tail'] is value
    assert fast.compiled_calls==1 and fast.fallback_calls==0


def test_definition_keeps_original_frame_builtins_after_callback_rebinding():
    fast=heap.lift_structures(captured_builtin_context)
    assert fast.run is not None,fast.problem
    namespace=captured_builtin_context.__globals__;previous=namespace['__builtins__']
    def action():namespace['__builtins__']={'len':lambda value:999}
    try:
        result=fast(action,[1,2])
        assert result.__builtins__ is namespace['__builtins__']
        assert result()==999
        assert fast.compiled_calls==1 and fast.fallback_calls==0
    finally:namespace['__builtins__']=previous


def test_empty_captured_cell_raises_original_nameerror_once():
    fast=heap.lift_structures(early_empty_cell)
    assert fast.run is not None,fast.problem
    events=[]
    def action(function):events.append('once');return function()
    with pytest.raises(NameError,match="free variable 'value'"):fast(action)
    assert events==['once'] and fast.compiled_calls==1 and fast.fallback_calls==0


def external_reader(value):
    def read():return value
    return read


def test_empty_external_cell_preserves_exception_metadata():
    original=external_reader(object());fast=heap.lift_structures(original)
    assert fast.run is not None,fast.problem
    del original.__closure__[0].cell_contents
    def outcome(call):
        try:call()
        except NameError as error:return(type(error),str(error),error.name,error.__cause__,error.__context__,error.__suppress_context__)
    assert outcome(fast)==outcome(original)
    assert fast.compiled_calls==1 and fast.fallback_calls==0


def constant_defaults():
    def read(value=(1,2),flag=True):return value,flag
    return read


def keyword_owner():
    def read(*,token=None):return token
    return read


class SecretDefaults:
    def maker(self):
        def read(*,__secret=self):return __secret
        return read


def test_constant_default_tuple_is_the_original_code_owner():
    fast=heap.lift_structures(constant_defaults)
    assert fast.run is not None,fast.problem
    assert fast().__defaults__ is constant_defaults().__defaults__


def test_keyword_default_key_is_the_original_parent_constant_owner():
    original=next(value for value in keyword_owner.__code__.co_consts if type(value) is str and value=='token')
    replacement=('token'+'extra')[:-5]
    assert replacement==original and replacement is not original
    code=keyword_owner.__code__.replace(co_consts=tuple(replacement if value is original else value for value in keyword_owner.__code__.co_consts))
    function=types.FunctionType(code,keyword_owner.__globals__)
    fast=heap.lift_structures(function)
    assert fast.run is not None,fast.problem
    expected=function();actual=fast()
    original_key=next(value for value in function.__code__.co_consts if type(value) is str and value=='token')
    assert next(iter(expected.__kwdefaults__)) is original_key
    assert next(iter(actual.__kwdefaults__)) is original_key


def test_class_mangled_keyword_default_name_matches_original():
    obj=SecretDefaults();fast=heap.lift_structures(SecretDefaults.maker)
    assert fast.run is not None,fast.problem
    expected=obj.maker();actual=fast(obj)
    assert actual.__kwdefaults__.keys()==expected.__kwdefaults__.keys()
    assert actual() is obj


def ordered_plain_locals(factory,flag):
    if flag:
        a=factory('a');b=factory('b')
    else:
        b=factory('b');a=factory('a')
    def inner():return 0
    return 0


@pytest.mark.parametrize('flag',[False,True])
def test_function_frame_clears_source_locals_in_original_slot_order(flag):
    events=[]
    class Item:
        def __init__(self,name):self.name=name
        def __del__(self):events.append(self.name)
    expected=ordered_plain_locals(Item,flag);reference=list(events);events.clear()
    fast=heap.lift_structures(ordered_plain_locals)
    assert fast(Item,flag)==expected
    assert events==reference==['b','a']
    assert fast.compiled_calls==1 and fast.fallback_calls==0


def ordered_cell_locals(factory):
    a=factory('a');b=factory('b')
    def inner():return a
    return 0


def test_function_frame_clears_cells_and_fast_locals_in_original_slot_order():
    events=[]
    class Item:
        def __init__(self,name):self.name=name
        def __del__(self):events.append(self.name)
    expected=ordered_cell_locals(Item);reference=list(events);events.clear()
    fast=heap.lift_structures(ordered_cell_locals)
    assert fast(Item)==expected
    assert events==reference==['a','b']
    assert fast.compiled_calls==1 and fast.fallback_calls==0
