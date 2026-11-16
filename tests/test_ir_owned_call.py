"""Narrow canonical CALL handoff; unsupported caller shapes remain unclaimed."""
import ctypes,dis,gc,sys,weakref
from llvmlite import ir,binding
from recompyler import _source_frames_native as frames
from recompyler.ir.entry import create_callable
from recompyler.ir.symbols import CPythonSymbols


def source(value,callback):
    value=None
    return callback()


def owned_entry(*,actual_hook=False):
    addresses=frames.addresses()
    assert 'claim_call_args' in addresses
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    symbols=CPythonSymbols()
    for name,address in addresses.items():symbols.register_external('owned_test_'+name,address,frames)
    p=ir.IntType(8).as_pointer();n=ir.IntType(64);i=ir.IntType(32)
    module=ir.Module();module.triple=binding.get_process_triple()
    body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),n,p]),'body')
    original,args,nargs,names=body.args;b=ir.IRBuilder(body.append_basic_block('entry'))
    target=ctypes.c_void_p();claimed=ctypes.c_int(-99)
    def number(value):return ir.Constant(n,value)
    def pointer(value):return number(id(value)).inttoptr(p)
    def call(name,result,values):return b.call(symbols.declare(module,name,result,[v.type for v in values]),values)
    instructions=list(dis.get_instructions(source));pc=lambda name:next(op.offset for op in instructions if op.opname==name)
    count=b.and_(nargs,number((1<<63)-1));null=ir.Constant(p,None)
    frame=call('owned_test_enter',p,[original,pointer(source.__code__),args,count,number(pc('RESUME'))])
    with b.if_then(b.icmp_unsigned('==',frame,null)):b.ret(null)
    actual=(call('owned_test_current_callable',p,[]) if actual_hook else
            b.load(number(ctypes.addressof(target)).inttoptr(p.as_pointer())))
    result=call('owned_test_claim_call_args',i,[frame,actual,args,count])
    b.store(result,number(ctypes.addressof(claimed)).inttoptr(i.as_pointer()))
    with b.if_then(b.icmp_signed('<',result,ir.Constant(i,0))):
        call('owned_test_leave_raw',i,[frame,ir.Constant(i,0),number(pc('RESUME'))]);b.ret(null)
    # Idempotency must reject a second claim, including all-immortal inputs.
    again=call('owned_test_claim_call_args',i,[frame,actual,args,count])
    with b.if_then(b.icmp_signed('!=',again,ir.Constant(i,0))):b.ret(null)
    call('owned_test_mark',i,[frame,number(pc('STORE_FAST'))])
    call('owned_test_store',i,[frame,number(0),pointer(None)])
    callback=call('owned_test_load',p,[frame,number(1)])
    call('owned_test_mark',i,[frame,number(pc('CALL'))])
    value=call('PyObject_CallNoArgs',p,[callback]);call('Py_DecRef',ir.VoidType(),[callback])
    success=b.zext(b.icmp_unsigned('!=',value,null),i)
    site=b.select(b.icmp_unsigned('!=',value,null),number(pc('RETURN_VALUE')),number(pc('CALL')))
    call('owned_test_leave_raw',i,[frame,success,site]);b.ret(value)
    machine=binding.Target.from_default_triple().create_target_machine()
    parsed=binding.parse_assembly(str(module));parsed.verify()
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),machine);engine.add_module(parsed);engine.finalize_object()
    hook={'owned_runner_address':addresses['run_owned_vectorcall']} if actual_hook else {'runner_address':addresses['run_vectorcall']}
    entry=create_callable(source,engine.get_function_address('body'),(engine,symbols,target,claimed),**hook)
    target.value=id(entry)
    return entry,claimed


def events_for(call):
    events=[];references=[]
    class Value:
        def __init__(self):references.append(weakref.ref(self,lambda _:events.append('weakref')))
        def __del__(self):
            caller=sys._getframe(1)
            assert caller.f_code is source.__code__ and caller.f_locals['value'] is None
            events.append('drop')
    def observe():
        frame=sys._getframe(1)
        assert frame.f_code is source.__code__ and frame.f_locals['value'] is None
        gc.collect();events.append('observe');return 37
    result=call(Value(),observe)
    events.append('after')
    assert all(ref() is None for ref in references)
    return result,events


def test_direct_owned_call_matches_destructor_weakref_and_source_frame():
    entry,claimed=owned_entry()
    assert events_for(entry)==events_for(source)==(37,['drop','weakref','observe','after'])
    assert claimed.value==1 and frames.active_depth()==0


def test_expanded_tuple_call_declines_without_releasing_tuple_roots():
    entry,claimed=owned_entry();owner=object();seen=[]
    def observe():seen.append('observe');return owner
    arguments=(owner,observe)
    result=entry(*arguments)
    assert result is owner and arguments[0] is owner
    assert claimed.value==0 and seen==['observe'] and frames.active_depth()==0


def test_capi_call_declines_without_modifying_borrowed_inputs():
    entry,claimed=owned_entry();owner=object()
    callback=lambda:owner
    values=(ctypes.c_void_p*2)(id(owner),id(callback))
    invoke=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.c_void_p,ctypes.POINTER(ctypes.c_void_p),ctypes.c_size_t,ctypes.c_void_p)(('PyObject_Vectorcall',ctypes.pythonapi))
    address=invoke(id(entry),values,2,None)
    actual=ctypes.cast(address,ctypes.py_object).value
    ctypes.PYFUNCTYPE(None,ctypes.c_void_p)(('Py_DecRef',ctypes.pythonapi))(address)
    assert actual is owner and values[0]==id(owner) and values[1]==id(callback)
    assert claimed.value==0 and frames.active_depth()==0


def test_owned_call_error_retains_original_source_site_and_owners():
    import pytest
    entry,claimed=owned_entry();events=[]
    class Value:
        def __del__(self):events.append('drop')
    def observe():events.append('observe');raise LookupError('failure')
    with pytest.raises(LookupError,match='failure') as caught:entry(Value(),observe)
    assert claimed.value==1 and events==['drop','observe']
    tb=caught.value.__traceback__
    while tb and tb.tb_frame.f_code is not source.__code__:tb=tb.tb_next
    assert tb is not None and tb.tb_frame.f_locals['value'] is None
    assert tb.tb_lasti==next(op.offset for op in dis.get_instructions(source) if op.opname=='CALL')
    assert frames.active_depth()==0


def test_warm_adaptive_calls_claim_once_per_activation():
    entry,claimed=owned_entry()
    # Warm the very same call site with a Python function first. A subsequent
    # native guard miss can retain CALL_PY_EXACT_ARGS in caller.instr_ptr.
    for _ in range(12):events_for(source)
    for _ in range(40):
        actual=events_for(entry)
        assert actual==(37,['drop','weakref','observe','after'])
        assert claimed.value==1 and frames.active_depth()==0


def test_bound_method_self_is_not_claimed_as_an_argument_word():
    import types
    entry,claimed=owned_entry();owner=object()
    bound=types.MethodType(entry,owner)
    assert bound(lambda:owner) is owner
    assert claimed.value==0 and frames.active_depth()==0


def test_claim_with_no_registered_source_activation_rejects_stale_handle():
    import pytest
    addresses=frames.addresses()
    claim=ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p,ctypes.c_void_p,ctypes.POINTER(ctypes.c_void_p),ctypes.c_ssize_t)(addresses['claim_call_args'])
    with pytest.raises(RuntimeError,match='inactive source activation'):
        claim(None,None,None,0)
    assert frames.active_depth()==0


def test_owned_runner_callable_context_is_scoped_and_legacy_runner_has_none():
    addresses=frames.addresses()
    assert 'run_owned_vectorcall' in addresses and 'current_callable' in addresses
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    symbols=CPythonSymbols()
    symbols.register_external('owned_context_current',addresses['current_callable'],frames)
    p=ir.IntType(8).as_pointer();n=ir.IntType(64)
    module=ir.Module();body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),n,p]),'context_body')
    b=ir.IRBuilder(body.append_basic_block('entry'))
    current=b.call(symbols.declare(module,'owned_context_current',p,[]),[])
    value=b.select(b.icmp_unsigned('==',current,ir.Constant(p,None)),ir.Constant(n,id(None)).inttoptr(p),current)
    b.ret(b.call(symbols.declare(module,'Py_NewRef',p,[p]),[value]))
    machine=binding.Target.from_default_triple().create_target_machine()
    parsed=binding.parse_assembly(str(module));parsed.verify()
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),machine);engine.add_module(parsed);engine.finalize_object()
    raw_args=ctypes.POINTER(ctypes.c_void_p)
    owned=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.c_void_p,ctypes.c_void_p,raw_args,ctypes.c_size_t,ctypes.c_void_p,ctypes.c_void_p)(addresses['run_owned_vectorcall'])
    legacy=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.c_void_p,ctypes.c_void_p,raw_args,ctypes.c_size_t,ctypes.c_void_p)(addresses['run_vectorcall'])
    current_call=ctypes.PYFUNCTYPE(ctypes.c_void_p)(addresses['current_callable'])
    decref=ctypes.PYFUNCTYPE(None,ctypes.c_void_p)(('Py_DecRef',ctypes.pythonapi))
    marker=object();body_address=engine.get_function_address('context_body')
    assert current_call() is None
    result=owned(body_address,id(source),None,0,None,id(marker))
    assert ctypes.cast(result,ctypes.py_object).value is marker;decref(result)
    assert current_call() is None
    result=legacy(body_address,id(source),None,0,None)
    assert ctypes.cast(result,ctypes.py_object).value is None;decref(result)
    assert current_call() is None and frames.active_depth()==0
