"""RED preparation for the next generic attribute/string batch."""
import sys,types
import pytest
from test_ir_existing_frame import frame_entry


def simple(value):return f'{value}'
def specified(value,spec):return f'{value:{spec}}'
def joined(left,right):return f'<{left}:{right}>'
def converted_s(value):return f'{value!s}'
def converted_r(value):return f'{value!r}'
def converted_a(value):return f'{value!a}'
def explicit_super(cls,owner,value):return super(cls,owner).method(value)
class Base:
    field=object()
    def method(self,value):return self,value
class Derived(Base):
    def call(self,value):return super().method(value)
    def read(self):return super().field


@pytest.mark.parametrize('function',[Derived.call,Derived.read,explicit_super])
def test_generic_super_original_function_closure_and_bound_self(function):
    call=frame_entry(function)[0];owner=Derived();marker=object()
    if function is Derived.read:assert call(owner) is Base.field
    else:
        args=(Derived,owner,marker) if function is explicit_super else (owner,marker)
        result=call(*args);assert result[0] is owner and result[1] is marker


@pytest.mark.parametrize('explicit',[False,True])
def test_shadowed_super_preserves_argument_shape_pc_lookup_and_retirement(explicit):
    fn=explicit_super if explicit else Derived.call
    call=frame_entry(fn)[0]
    def check(target):
        events=[];marker=object();failure=LookupError('super lookup')
        class Proxy:
            def __getattribute__(self,name):
                frame=sys._getframe(1);events.append(('get',name,frame.f_code is fn.__code__,frame.f_lasti))
                raise failure
            def __del__(self):
                frame=sys._getframe(1);events.append(('drop',frame.f_code is fn.__code__,frame.f_lasti))
        def replacement(*args):
            frame=sys._getframe(1);events.append(('super',len(args),frame.f_code is fn.__code__,frame.f_lasti))
            return Proxy()
        namespace=fn.__globals__;old=namespace.get('super');present='super' in namespace;namespace['super']=replacement
        try:
            with pytest.raises(LookupError) as caught:
                target(Derived,Derived(),marker) if explicit else target(Derived(),marker)
            assert caught.value is failure
            failure.__traceback__=None;del caught
        finally:
            if present:namespace['super']=old
            else:namespace.pop('super')
        return events
    assert check(call)==check(fn)


@pytest.mark.parametrize('function',[simple,specified,joined,converted_s,converted_r,converted_a])
def test_generic_formatting_uses_original_hooks_identity_and_errors(function):
    call=frame_entry(function)[0];marker='a deliberately noninterned formatting result '+str(object())
    def check(target):
        events=[]
        class Value:
            def __format__(self,spec):
                frame=sys._getframe(1);events.append(('format',spec,frame.f_code is function.__code__,frame.f_lasti));return marker
            def __str__(self):
                frame=sys._getframe(1);events.append(('str',frame.f_code is function.__code__,frame.f_lasti));return marker
            def __repr__(self):
                frame=sys._getframe(1);events.append(('repr',frame.f_code is function.__code__,frame.f_lasti));return marker
        args=(Value(),'a-spec') if function is specified else (Value(),'right') if function is joined else (Value(),)
        result=target(*args)
        if function in (simple,specified,converted_s,converted_r):assert result is marker
        else:assert result==('<'+marker+':right>' if function is joined else marker)
        return events
    assert check(call)==check(function)


def test_real_dependency_function_reference_format_helper():
    from recompyler.depmap import _function_ref
    call,lowered,status=frame_entry(_function_ref)
    for key in [('module',17),('name',-1),('',0)]:assert call(key)==_function_ref(key)
    assert status.value==1 and lowered.graph.code is _function_ref.__code__


@pytest.mark.parametrize('function',[simple,specified,joined])
def test_format_error_is_original_exception_with_original_source_pc(function):
    call=frame_entry(function)[0]
    def check(target):
        events=[];failure=ValueError('format failed')
        class Value:
            def __format__(self,spec):
                frame=sys._getframe(1)
                events.append((spec,frame.f_code is function.__code__,frame.f_lasti));raise failure
        with pytest.raises(ValueError) as caught:
            target(Value(),'spec') if function in (specified,joined) else target(Value())
        assert caught.value is failure
        failure.__traceback__=None;del caught
        return events
    assert check(call)==check(function)


def format_from_factories(value_factory,spec_factory):return f'{value_factory():{spec_factory()}}'
def join_from_factories(left_factory,right_factory):return f'{left_factory()}{right_factory()}'


@pytest.mark.parametrize('fails',[False,True])
def test_formatting_temporary_spec_value_and_result_release_match_source(fails):
    call=frame_entry(format_from_factories)[0]
    def check(target):
        events=[];failure=ValueError('format failure')
        def note(label):
            frame=sys._getframe(2)
            events.append((label,frame.f_code is format_from_factories.__code__,frame.f_lasti))
        class Text(str):
            def __del__(self):note('drop-text')
        class Spec:
            def __format__(self,spec):note('format-spec');return Text('spec')
            def __del__(self):note('drop-spec')
        class Value:
            def __format__(self,spec):
                note('format-value')
                if fails:raise failure
                return Text('result')
            def __del__(self):note('drop-value')
        if fails:
            with pytest.raises(ValueError) as caught:target(Value,Spec)
            assert caught.value is failure
            failure.__traceback__=None;del caught
        else:
            result=target(Value,Spec);assert type(result) is Text and result=='result';del result
        return events
    assert check(call)==check(format_from_factories)


def test_build_string_retires_format_results_in_reverse_original_stack_order():
    call=frame_entry(join_from_factories)[0]
    def check(target):
        events=[]
        class Text(str):
            def __del__(self):
                frame=sys._getframe(1)
                events.append((str(self),frame.f_code is join_from_factories.__code__,frame.f_lasti))
        class Value:
            def __init__(self,label):self.label=label
            def __format__(self,spec):return Text(self.label)
        assert target(lambda:Value('a'),lambda:Value('b'))=='ab'
        return events
    assert check(call)==check(join_from_factories)
