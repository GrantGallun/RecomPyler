"""Exact builtin type CALL specialization keeps Python fallback and ownership."""
import dis,gc,weakref
import pytest
from test_ir_existing_frame import frame_entry


def type_of(value):return type(value)
def dynamic_type_of(value):return type(value)
def make_type(make):return type(make())


def native(function):return frame_entry(function,lowering_options={'builtin_calls':True})


def test_actual_compiler_type_call_has_a_guarded_native_path():
    from recompyler.ir.types import ValueType
    entry,lowered,_=native(ValueType.__eq__)
    assert 'rc_ir_frame_type_call_owned' in str(lowered.native_module)
    cases=[ValueType(),ValueType('int',int),ValueType('int',bool),ValueType(maybe_unbound=True)]
    for left in cases:
        for right in [*cases,object(),None,1]:assert entry(left,right) is ValueType.__eq__(left,right)


def test_type_is_exact_and_never_reads_spoofed_class():
    events=[]
    class Foreign:
        @property
        def __class__(self):events.append('wrong');return int
    entry,_,_=native(type_of)
    for value in [None,True,7,-0.0,complex(1,2),'x',b'x',[],{},Foreign()]:assert entry(value) is type_of(value)
    assert events==[]


def test_rebound_global_type_uses_original_call_without_extra_protocols():
    events=[]
    def replacement(value):events.append(value);return marker
    marker=object();entry,_,_=native(dynamic_type_of)
    dynamic_type_of.__globals__['type']=replacement
    try:assert entry(marker) is marker and events==[marker]
    finally:del dynamic_type_of.__globals__['type']


def test_temporary_finalizer_and_heap_type_lifetime_match_original_call():
    def check(call):
        events=[];refs=[]
        def make():
            class Marker:
                def __del__(self):
                    import sys
                    frame=sys._getframe(1)
                    events.append((frame.f_code is make_type.__code__,frame.f_lasti))
            refs.append(weakref.ref(Marker));return Marker()
        result=call(make)
        assert refs[0]() is result
        assert events==[(True,next(i.offset for i in dis.get_instructions(make_type) if i.opname=='CALL' and i.arg==1))]
        del result;gc.collect();assert refs[0]() is None
        return events
    entry,_,_=native(make_type)
    assert check(entry)==check(make_type)


def test_wrong_arity_and_keyword_type_calls_keep_canonical_errors():
    def none():return type()
    def keyword(value):return type(object=value)
    def three():return type('Created',(),{})
    for function,args in [(none,()),(keyword,(1,))]:
        entry,lowered,_=native(function)
        assert 'rc_ir_frame_type_call_owned' not in str(lowered.native_module)
        with pytest.raises(TypeError) as expected:function(*args)
        with pytest.raises(TypeError) as actual:entry(*args)
        assert str(actual.value)==str(expected.value)
    entry,lowered,_=native(three)
    assert 'rc_ir_frame_type_call_owned' not in str(lowered.native_module)
    assert entry().__name__=='Created'


def test_profile_observations_stay_on_the_original_call_instruction():
    import sys
    def check(call):
        events=[]
        def profile(frame,event,arg):
            if frame.f_code is type_of.__code__:events.append((event,frame.f_lasti))
        sys.setprofile(profile)
        try:assert call(1) is int
        finally:sys.setprofile(None)
        return events
    entry,_,_=native(type_of)
    assert check(entry)==check(type_of)


def test_type_call_path_can_be_disabled_without_emitting_its_helper():
    entry,lowered,_=frame_entry(type_of,lowering_options={'builtin_calls':False})
    assert 'rc_ir_frame_type_call_owned' not in str(lowered.native_module)
    assert entry(None) is type(None)


def type_then_read(make,marker):
    result=type(make())
    return marker.value


@pytest.mark.parametrize('enabled',[False,True])
def test_warm_type_call_does_not_add_a_pending_callback_boundary(enabled):
    # A native capsule destructor schedules work without another Python CALL
    # that could itself consume the pending event before type() returns.
    import ctypes
    from llvmlite import ir,binding
    marker=ctypes.c_int();pointer=ir.IntType(8).as_pointer();i32=ir.IntType(32);word=ir.IntType(64)
    module=ir.Module();module.triple=binding.get_process_triple()
    callback=ir.Function(module,ir.FunctionType(i32,[pointer]),'pending_type_callback')
    b=ir.IRBuilder(callback.append_basic_block('entry'))
    b.store(ir.Constant(i32,1),ir.Constant(word,ctypes.addressof(marker)).inttoptr(i32.as_pointer()));b.ret(ir.Constant(i32,0))
    destructor=ir.Function(module,ir.FunctionType(ir.VoidType(),[pointer]),'schedule_type_callback')
    b=ir.IRBuilder(destructor.append_basic_block('entry'))
    add=ctypes.cast(ctypes.pythonapi.Py_AddPendingCall,ctypes.c_void_p).value
    function=b.inttoptr(ir.Constant(word,add),ir.FunctionType(i32,[pointer,pointer]).as_pointer())
    b.call(function,[b.bitcast(callback,pointer),ir.Constant(pointer,None)]);b.ret_void()
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    engine=binding.create_mcjit_compiler(binding.parse_assembly(str(module)),binding.Target.from_default_triple().create_target_machine())
    engine.finalize_object()
    create=ctypes.pythonapi.PyCapsule_New;create.argtypes=[ctypes.c_void_p,ctypes.c_char_p,ctypes.c_void_p];create.restype=ctypes.py_object
    address=engine.get_function_address('schedule_type_callback')
    def make():return create(1,None,address)
    for _ in range(100):
        type_then_read(make,marker);ctypes.pythonapi.Py_MakePendingCalls()
    assert any(i.opname=='CALL_TYPE_1' for i in dis.get_instructions(type_then_read,adaptive=True))
    marker.value=0;assert type_then_read(make,marker)==0;ctypes.pythonapi.Py_MakePendingCalls()
    entry,_,_=frame_entry(type_then_read,lowering_options={'builtin_calls':enabled})
    marker.value=0
    try:assert entry(make,marker)==0
    finally:ctypes.pythonapi.Py_MakePendingCalls()
