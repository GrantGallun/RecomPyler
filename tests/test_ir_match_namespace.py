"""Canonical class patterns and mapping-before-global namespace lookup."""
import dis,types
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from test_ir_existing_frame import frame_entry


def class_pattern(make,kind):
    match make():
        case kind(first,other=second):return first,second
        case _:return None


def namespace_template(make):return make()


def namespace_function(namespace=None):
    template=namespace_template.__code__
    code=bytearray(template.co_code)
    offset=next(i.offset for i in dis.get_instructions(template) if i.opname=='RETURN_VALUE')
    code[offset:offset]=bytes((dis.opmap['LOAD_FROM_DICT_OR_GLOBALS'],0))
    return types.FunctionType(template.replace(co_code=bytes(code),co_names=('wave84_lookup',)),globals() if namespace is None else namespace)


def test_match_class_has_exact_stack_contract():
    graph=build(class_pattern)
    operation=next(op for block in graph.blocks.values() for op in block.operations if op.name=='match_class')
    assert len(operation.arguments)==3 and len(operation.results)==1
    assert lower(graph,frame_entry=True).body_address>0


def test_class_pattern_returns_original_positional_and_keyword_values():
    first=object();second=object()
    class Value:
        __match_args__=('first',)
        def __init__(self):self.first=first;self.other=second
    call,_,_=frame_entry(class_pattern)
    result=call(Value,Value)
    assert result[0] is first and result[1] is second
    assert call(object,Value) is None


@pytest.mark.parametrize('mode',['not_type','not_tuple','not_string','duplicate','missing'])
def test_class_pattern_errors_and_missing_attributes_match_python(mode):
    events=[];marker=object()
    class Value:
        __match_args__=('first',)
        @property
        def first(self):events.append('first');return marker
        @property
        def other(self):
            events.append('other')
            if mode=='missing':raise AttributeError('missing other')
            return marker
    kind=Value
    if mode=='not_type':kind=object()
    elif mode=='not_tuple':Value.__match_args__=['first']
    elif mode=='not_string':Value.__match_args__=(42,)
    elif mode=='duplicate':Value.__match_args__=('other',)
    def outcome(function):
        events.clear()
        try:result=function(Value,kind);return ('return',result),events.copy()
        except Exception as error:return ('raise',type(error),str(error)),events.copy()
    expected=outcome(class_pattern);call,_,_=frame_entry(class_pattern)
    assert outcome(call)==expected


def test_class_pattern_callback_keeps_original_frame_and_source_pc():
    import sys
    marker=object();events=[]
    class Meta(type):
        def __instancecheck__(cls,value):
            frame=sys._getframe(1)
            assert frame.f_code is class_pattern.__code__
            assert frame.f_lasti==next(i.offset for i in dis.get_instructions(class_pattern) if i.opname=='MATCH_CLASS')
            events.append('instance');return True
    class Kind(metaclass=Meta):__match_args__=('first',)
    class Subject:
        first=marker;other=marker
        def __del__(self):events.append('drop')
    call,_,_=frame_entry(class_pattern)
    result=call(Subject,Kind)
    assert result[0] is marker and result[1] is marker and events==['instance','drop']


def test_namespace_lookup_uses_mapping_before_global_and_builtin():
    marker=object();global_value=object()
    namespace={'__builtins__':{'wave84_lookup':object()},'wave84_lookup':global_value}
    function=namespace_function(namespace);call,_,_=frame_entry(function)
    assert call(lambda:{'wave84_lookup':marker}) is marker
    assert call(dict) is global_value
    del namespace['wave84_lookup']
    assert call(dict) is namespace['__builtins__']['wave84_lookup']


def test_namespace_source_is_closed_before_global_fallback():
    import sys
    events=[];old=object();new=object()
    namespace={'__builtins__':{},'wave84_lookup':old}
    function=namespace_function(namespace)
    pc=next(i.offset for i in dis.get_instructions(function) if i.opname=='LOAD_FROM_DICT_OR_GLOBALS')
    class Mapping:
        def __getitem__(self,name):
            frame=sys._getframe(1)
            assert frame.f_code is function.__code__ and frame.f_lasti==pc
            events.append(('lookup',name));raise KeyError(name)
        def __del__(self):events.append('drop');namespace['wave84_lookup']=new
    call,_,_=frame_entry(function)
    assert call(Mapping) is new
    assert events==[('lookup','wave84_lookup'),'drop']


@pytest.mark.parametrize('mode',['missing','invalid','error'])
def test_namespace_errors_preserve_message_identity_and_cleanup(mode):
    events=[];original=LookupError('mapping failure')
    namespace={'__builtins__':{}};function=namespace_function(namespace)
    class Mapping:
        def __getitem__(self,name):
            if mode=='error':raise original
            raise KeyError(name)
        def __del__(self):events.append('drop')
    make=(lambda:None) if mode=='invalid' else Mapping
    def outcome(call):
        events.clear()
        try:call(make)
        except Exception as error:return type(error),str(error),error is original,events.copy()
        raise AssertionError('lost lookup error')
    expected=outcome(function);original.__traceback__=None
    call,_,_=frame_entry(function)
    assert outcome(call)==expected
    original.__traceback__=None


@pytest.mark.parametrize('name',['dataclass_slots','config_annotations','traceback_carets','traceback_anchors'])
def test_four_real_stdlib_refusals_prepare_native_bodies(name):
    import configparser,dataclasses,traceback
    functions={'dataclass_slots':dataclasses._get_slots,'config_annotations':vars(configparser._ReadState)['__annotate_func__'],
               'traceback_carets':traceback.StackSummary._should_show_carets,'traceback_anchors':traceback._extract_caret_anchors_from_line_segment}
    function=functions[name]
    from recompyler.ir import compile_function,compilation_info
    code=function.__code__
    assert compile_function(function,strict=True) is function
    result=compilation_info(function)
    assert result['compiled'] and result['body_address']>0 and function.__code__ is code
    assert result['native_prefix']==(name=='dataclass_slots')


@pytest.mark.slow
def test_actual_original_stdlib_entries():
    import os,subprocess,sys
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    result=subprocess.run([sys.executable,str(root/'tests/match_namespace_cases.py')],cwd=root,
        env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),
        capture_output=True,text=True,timeout=120,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(result.stdout,result.stderr)
    assert 'PASS native stdlib entries=4' in result.stdout
