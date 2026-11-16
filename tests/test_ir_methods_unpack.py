"""Generic method lookup and unpacking preserve CPython ownership and callbacks."""
import dis,gc,sys,weakref
import pytest
from test_ir_existing_frame import frame_entry


def invoke(owner,value):return owner.method(value)
def invoke_keyword(owner,value):return owner.method(named=value)
def read_attribute(owner):return owner.field
def unpack_pair(seq):
    first,second=seq
    return first,second
def unpack_star(seq):
    first,*middle,last=seq
    return first,middle,last
def unpack_empty(seq):
    []=seq
    return None
def unpack_from_factory(factory):
    first,second=factory()
    return first,second


@pytest.mark.parametrize('function',[invoke,invoke_keyword])
def test_method_lookup_uses_original_descriptor_and_live_instance_dictionary(function):
    call=frame_entry(function)[0];marker=object()
    class Owner:
        def method(self,value=None,*,named=None):return self,value if named is None else named
    owner=Owner()
    for target in (function,call):
        result=target(owner,marker);assert result[0] is owner and result[1] is marker
    owner.method=lambda value=None,*,named=None:marker
    assert call(owner,marker) is marker
    del owner.method
    assert call(owner,marker)[0] is owner


def test_method_property_custom_lookup_and_builtin_descriptor_forms():
    call=frame_entry(invoke)[0];marker=object()
    class Property:
        @property
        def method(self):return lambda value:value
    class Custom:
        def __getattribute__(self,name):return lambda value:value
    class Static:
        method=staticmethod(lambda value:value)
    class Class:
        @classmethod
        def method(cls,value):return cls,value
    for owner in (Property(),Custom(),Static()):assert call(owner,marker) is marker
    result=call(Class(),marker);assert result[0] is Class and result[1] is marker
    class Builtin:
        method=dict.get
    owner=Builtin()
    with pytest.raises(TypeError) as expected:invoke(owner,marker)
    with pytest.raises(TypeError) as actual:call(owner,marker)
    assert str(actual.value)==str(expected.value)


@pytest.mark.parametrize('method',[False,True])
def test_attribute_callbacks_see_original_pc_live_locals_and_exact_failure(method):
    function=invoke if method else read_attribute;call=frame_entry(function)[0]
    def check(target):
        events=[];failure=LookupError('lookup failed')
        class Owner:
            def __getattribute__(self,name):
                frame=sys._getframe(1)
                events.append((name,frame.f_code is function.__code__,frame.f_lasti))
                frame.f_locals['owner']=None
                raise failure
        with pytest.raises(LookupError) as caught:
            target(Owner(),None) if method else target(Owner())
        assert caught.value is failure
        failure.__traceback__=None;del caught
        return events
    assert check(call)==check(function)


@pytest.mark.parametrize('function',[unpack_pair,unpack_star,unpack_empty])
def test_unpack_generic_sequences_and_exact_result_identity(function):
    call=frame_entry(function)[0];a=object();b=object();c=object()
    inputs=[[],(),iter(())] if function is unpack_empty else [([a,b]),(a,b)]
    if function is unpack_star:inputs.extend([[a,c,b],(a,c,c,b)])
    for source in inputs:
        result=call(source)
        if function is unpack_empty:assert result is None
        elif function is unpack_pair:assert result[0] is a and result[1] is b
        else:
            assert result[0] is a and result[-1] is b
            assert len(result[1])==len(source)-2 and all(item is c for item in result[1])
    for source in ([a], [a,b,c], 42) if function is unpack_pair else ([a],42) if function is unpack_star else ([a],42):
        with pytest.raises((TypeError,ValueError)) as expected:function(source)
        with pytest.raises(type(expected.value)) as actual:call(source)
        assert str(actual.value)==str(expected.value)


@pytest.mark.parametrize('fails',[False,True])
def test_unpack_partial_results_and_source_retire_in_original_order(fails):
    call=frame_entry(unpack_from_factory)[0]
    def check(target):
        events=[];refs=[];failure=RuntimeError('iterator failed')
        def note(label):
            frame=sys._getframe(2)
            events.append((label,frame.f_code is unpack_from_factory.__code__,frame.f_lasti))
        class Item:
            def __init__(self,label):self.label=label;refs.append(weakref.ref(self))
            def __del__(self):note('item-'+self.label)
        class Source:
            n=0
            def __iter__(self):note('iter');return self
            def __next__(self):
                note('next');self.n+=1
                if self.n==2 and fails:raise failure
                if self.n>2:raise StopIteration
                return Item(str(self.n))
            def __del__(self):note('source')
        if fails:
            with pytest.raises(RuntimeError) as caught:target(Source)
            assert caught.value is failure
            failure.__traceback__=None;del caught
        else:
            result=target(Source);assert len(result)==2;del result
        gc.collect();assert all(ref() is None for ref in refs)
        return events
    assert check(call)==check(unpack_from_factory)


def test_fused_store_store_keeps_second_local_live_until_first_finalizer_returns():
    def assign(seq,first,second):
        first,second=seq
        return first,second
    assert any(i.opname=='STORE_FAST_STORE_FAST' for i in dis.get_instructions(assign))
    call=frame_entry(assign)[0]
    def check(target):
        events=[];a=object();b=object()
        class Previous:
            def __init__(self,name):self.name=name
            def __del__(self):
                frame=sys._getframe(1)
                if frame.f_code is assign.__code__:
                    events.append((self.name,frame.f_lasti,frame.f_locals['first'] is a))
                    if self.name=='first':frame.f_locals['second']='replacement'
        result=target([a,b],Previous('first'),Previous('second'))
        assert result[0] is a and result[1] is b
        return events
    assert check(call)==check(assign)


def test_unpack_borrowed_source_survives_callback_replacing_its_local():
    call=frame_entry(unpack_pair)[0]
    def check(target):
        events=[];a=object();b=object()
        class Source:
            def __iter__(self):
                frame=sys._getframe(1);frame.f_locals['seq']=None
                events.append('iter');return iter((a,b))
            def __del__(self):events.append('drop')
        result=target(Source());assert result[0] is a and result[1] is b
        return events
    assert check(call)==check(unpack_pair)==['iter','drop']


def test_nested_unpack_inside_native_iteration_keeps_iterator_stack_prefix():
    def pairs(values):
        answer=None
        for first,(second,third) in values:answer=first,second,third
        return answer
    call=frame_entry(pairs)[0];a=object();b=object();c=object()
    result=call([(None,(None,None)),(a,(b,c))])
    assert result[0] is a and result[1] is b and result[2] is c
    assert call([]) is None


def test_real_visitor_admit_entry_calls_original_compiler_method_once():
    from recompyler._visitors import VisitorRegion
    from types import SimpleNamespace
    fn=VisitorRegion.admit_entry;call,lowered,status=frame_entry(fn)
    marker=object();passed=(object(),);events=[]
    class Compiler:
        def entry_guard(self,arguments):
            frame=sys._getframe(1)
            events.append((arguments is passed,frame.f_code is fn.__code__,frame.f_lasti))
            return marker
    owner=SimpleNamespace(compiler=Compiler())
    assert fn(owner,passed) is marker and call(owner,passed) is marker
    assert len(events)==2 and events[0]==events[1]
    assert status.value==1 and lowered.graph.code is fn.__code__
