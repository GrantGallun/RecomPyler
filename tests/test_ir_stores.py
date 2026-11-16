"""Shared IR stores preserve original opcode retirement and source state."""
import sys,weakref
import pytest
from recompyler import heap,_structure_ops_native as provider,_source_frames_native as frames
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.structure_lowerings import StructureCalls,select_structure_calls
from recompyler.ir.symbols import CPythonSymbols
from test_ir_existing_frame import frame_entry


def native(function,selected):
    calls=StructureCalls(CPythonSymbols(),provider) if selected else None
    graph=select_structure_calls(build(function),{'store_attr','setitem'}) if selected else build(function)
    return frame_entry(function,graph=graph,structure_calls=calls)[0]


def assign_attribute(owner,value):
    owner.value=value
    return value


def assign_item(owner,key,value):
    owner[key]=value
    return value


@pytest.mark.parametrize('selected',[False,True])
def test_real_compiler_string_type_initializer(selected):
    call=native(heap.StrT.__init__,selected)
    owner=object.__new__(heap.StrT);marker=object()
    assert call(owner,marker) is None
    assert owner.nullable is marker and frames.active_depth()==0


@pytest.mark.parametrize('selected',[False,True])
def test_store_descriptor_uses_original_frame_and_live_local_writes(selected):
    call=native(assign_attribute,selected);events=[];marker=object();replacement=object()
    class Owner:
        def __setattr__(self,name,value):
            frame=sys._getframe(1)
            events.append((frame.f_code is assign_attribute.__code__,frame.f_locals['owner'] is self,value is marker,frame.f_lasti))
            frame.f_locals['value']=replacement
            object.__setattr__(self,name,value)
    reference=Owner();assert assign_attribute(reference,marker) is replacement
    expected=list(events);events.clear();actual=Owner()
    assert call(actual,marker) is replacement and actual.value is marker
    assert events==expected and frames.active_depth()==0


@pytest.mark.parametrize('selected',[False,True])
def test_store_item_uses_original_frame_and_live_local_writes(selected):
    call=native(assign_item,selected);events=[];marker=object();replacement=object();key=object()
    class Owner:
        def __setitem__(self,actual_key,value):
            frame=sys._getframe(1)
            events.append((frame.f_code is assign_item.__code__,frame.f_locals['owner'] is self,actual_key is key,value is marker,frame.f_lasti))
            frame.f_locals['value']=replacement
    assert assign_item(Owner(),key,marker) is replacement
    expected=list(events);events.clear()
    assert call(Owner(),key,marker) is replacement
    assert events==expected and frames.active_depth()==0


def store_attribute_temporaries(owner_source,value_source):
    (owner_source+0).value=value_source+0
    return None


def store_item_temporaries(owner_source,key_source,value_source):
    (owner_source+0)[key_source+0]=value_source+0
    return None


@pytest.mark.parametrize('selected',[False,True])
@pytest.mark.parametrize('item',[False,True])
@pytest.mark.parametrize('fails',[False,True])
def test_store_retires_fresh_operands_in_original_order_on_success_and_error(selected,item,fails):
    function=store_item_temporaries if item else store_attribute_temporaries
    call=native(function,selected)
    def check(target):
        events=[];references=[];failure=ValueError('store failed')
        class Operand:
            def __init__(self,label):
                object.__setattr__(self,'label',label)
                references.append(weakref.ref(self))
            def __setattr__(self,name,value):
                events.append(('set',name))
                if fails:raise failure
            def __setitem__(self,key,value):
                events.append(('setitem',key.label))
                if fails:raise failure
            def __del__(self):
                frame=sys._getframe(1)
                events.append(('drop',self.label,frame.f_code is function.__code__,frame.f_lasti))
        class Source:
            def __init__(self,label):self.label=label
            def __add__(self,unused):return Operand(self.label)
        args=(Source('owner'),Source('key'),Source('value')) if item else (Source('owner'),Source('value'))
        if fails:
            with pytest.raises(ValueError) as caught:target(*args)
            assert caught.value is failure
            failure.__traceback__=None
            del caught
        else:assert target(*args) is None
        assert all(reference() is None for reference in references)
        return events
    assert check(call)==check(function)
    assert frames.active_depth()==0
