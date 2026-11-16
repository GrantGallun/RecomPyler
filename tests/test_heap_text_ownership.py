"""Heap text must not publish owners chosen by value equality."""
from recompyler.heap import lift_region

def constant_text():return 'non interned constant owner'
def selected_text(text):return text
def pair_text(a,b):return a,b
def numeric_control(x):return x+1

def test_heap_text_constant_is_exact_or_declined():
    fn=lift_region(constant_text)
    assert fn() is constant_text()

def test_heap_distinct_equal_text_owners_are_not_merged():
    a=''.join(['equal ','owner']);b=(' '+a)[1:]
    assert a==b and a is not b
    fn=lift_region(pair_text);got=fn(a,b)
    assert got[0] is a and got[1] is b and got[0] is not got[1]

def test_heap_selected_text_is_exact_or_declined():
    text=''.join(['wide ','\u03a9 owner'])
    fn=lift_region(selected_text)
    assert fn(text) is text

def test_plain_numeric_heap_control_stays_native():
    fn=lift_region(numeric_control)
    assert fn(3)==4 and fn.compiled_calls==1

def test_heap_deep_numeric_tuple_global_declines_without_classifier_crash():
    import types
    ns=types.ModuleType('wave17_deep_tuple');exec('def f():\n    return len(G)\n',ns.__dict__)
    value=0
    for _ in range(600):value=(value,)
    ns.G=value
    assert ns.f()==1
    fn=lift_region(ns.f)
    assert fn()==1

def compare_text(a,b):return a==b

def test_heap_scalar_text_comparison_keeps_exact_bool_native():
    a=''.join(['equal ','owner']);b=(' '+a)[1:]
    fn=lift_region(compare_text)
    assert fn(a,b) is True and fn.compiled_calls==1

class NumericRecord:
    def __init__(self,value):self.value=value

def numeric_record_add(left,right):
    if not isinstance(right,NumericRecord):
        raise ValueError('not a NumericRecord: '+str(type(right)))
    return NumericRecord(left.value+right.value)

def optional_text_length(record,text):
    if text is not None:record.value+=len(text)

def test_unreachable_string_error_arm_keeps_numeric_record_native():
    fn=lift_region(numeric_record_add)
    result=fn(NumericRecord(3),NumericRecord(4))
    assert type(result) is NumericRecord and result.value==7
    assert fn.compiled_calls==1,fn.problem

def test_nullable_text_identity_against_none_keeps_numeric_effect_native():
    fn=lift_region(optional_text_length);record=NumericRecord(3)
    text=''.join(['wide ','\u03bb'])
    assert fn(record,text) is None and record.value==3+len(text)
    assert fn.compiled_calls==1,fn.problem
