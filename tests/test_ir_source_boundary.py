"""Real CPython source-frame boundary for the IR's raw vectorcall ABI."""
import ctypes
import dis
import sys
import pytest
from llvmlite import ir, binding
from recompyler import _source_frames_native as native


def source(callback, owner):
    callback(owner)
    return owner


def raising(owner):
    raise ValueError('source boundary')


def compile_body(function, *, fail=False):
    addresses=native.addresses()
    assert 'run_vectorcall' in addresses
    assert 'leave_raw' in addresses
    binding.initialize_native_target()
    binding.initialize_native_asmprinter()
    for name,address in addresses.items():binding.add_symbol('test_source_'+name,address)
    for name in ('PyObject_CallOneArg','Py_DecRef','PyErr_SetString'):
        binding.add_symbol(name,ctypes.cast(getattr(ctypes.pythonapi,name),ctypes.c_void_p).value)
    module=ir.Module(name='source_boundary')
    module.triple=binding.get_process_triple()
    p=ir.IntType(8).as_pointer();n=ir.IntType(64);i32=ir.IntType(32)
    body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),n,p]),name='body')
    original,args,nargs,kwnames=body.args
    b=ir.IRBuilder(body.append_basic_block('entry'))
    def call(name,result,values):
        callee=module.globals.get(name)
        if callee is None:callee=ir.Function(module,ir.FunctionType(result,[v.type for v in values]),name=name)
        return b.call(callee,values)
    pc=next(i.offset for i in dis.get_instructions(function) if i.opname=='RESUME')
    end=next(i.offset for i in dis.get_instructions(function) if i.opname==('RAISE_VARARGS' if fail else 'RETURN_VALUE'))
    def ptr(value):return ir.Constant(n,id(value)).inttoptr(p)
    frame=call('test_source_enter',p,[original,ptr(function.__code__),args,nargs,ir.Constant(n,pc)])
    null=ir.Constant(p,None)
    with b.if_then(b.icmp_unsigned('==',frame,null)):
        b.ret(null)
    if fail:
        message=ir.GlobalVariable(module,ir.ArrayType(ir.IntType(8),16),name='message')
        message.global_constant=True;message.initializer=ir.Constant(message.type.pointee,bytearray(b'source boundary\0'))
        call('test_source_mark',i32,[frame,ir.Constant(n,end)])
        call('PyErr_SetString',ir.VoidType(),[ptr(ValueError),b.bitcast(message,p)])
        call('test_source_leave_raw',i32,[frame,ir.Constant(i32,0),ir.Constant(n,end)])
        b.ret(null)
    else:
        callback=call('test_source_load',p,[frame,ir.Constant(n,0)])
        owner=call('test_source_load',p,[frame,ir.Constant(n,1)])
        site=next(i.offset for i in dis.get_instructions(function) if i.opname=='CALL')
        call('test_source_mark',i32,[frame,ir.Constant(n,site)])
        result=call('PyObject_CallOneArg',p,[callback,owner])
        call('Py_DecRef',ir.VoidType(),[callback]);call('Py_DecRef',ir.VoidType(),[owner])
        with b.if_then(b.icmp_unsigned('==',result,null)):
            call('test_source_leave_raw',i32,[frame,ir.Constant(i32,0),ir.Constant(n,site)])
            b.ret(null)
        call('Py_DecRef',ir.VoidType(),[result])
        value=call('test_source_load',p,[frame,ir.Constant(n,1)])
        call('test_source_leave_raw',i32,[frame,ir.Constant(i32,1),ir.Constant(n,end)])
        b.ret(value)
    machine=binding.Target.from_default_triple().create_target_machine()
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),machine)
    parsed=binding.parse_assembly(str(module));parsed.verify();engine.add_module(parsed);engine.finalize_object()
    run=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.c_void_p,ctypes.c_void_p,ctypes.POINTER(ctypes.c_void_p),ctypes.c_size_t,ctypes.c_void_p)(addresses['run_vectorcall'])
    decref=ctypes.PYFUNCTYPE(None,ctypes.c_void_p)(('Py_DecRef',ctypes.pythonapi))
    def invoke(*values):
        pointers=(ctypes.c_void_p*len(values))(*(id(v) for v in values))
        result=run(engine.get_function_address('body'),id(function),pointers,len(values),None)
        value=ctypes.cast(result,ctypes.py_object).value
        decref(result)
        return value
    return invoke


def test_raw_body_has_original_source_frame_and_live_locals():
    run=compile_body(source)
    owner=object();replacement=object();seen=[]
    def callback(value):
        frame=sys._getframe(1)
        seen.append(frame)
        assert frame.f_code is source.__code__
        assert frame.f_locals['owner'] is owner
        frame.f_locals['owner']=replacement
    assert run(callback,owner) is replacement
    assert seen[0].f_code is source.__code__
    assert seen[0].f_locals['owner'] is replacement
    assert native.active_depth()==0


def test_raw_failure_keeps_original_traceback_frame():
    run=compile_body(raising,fail=True);owner=object()
    with pytest.raises(ValueError,match='source boundary') as caught:run(owner)
    tb=caught.value.__traceback__
    while tb.tb_next:tb=tb.tb_next
    assert tb.tb_frame.f_code is raising.__code__
    assert tb.tb_frame.f_locals['owner'] is owner
    assert tb.tb_lasti==next(i.offset for i in dis.get_instructions(raising) if i.opname=='RAISE_VARARGS')
    assert native.active_depth()==0


def test_raw_callback_exception_unwinds_source_boundary():
    run=compile_body(source);owner=object()
    def callback(value):raise LookupError(value)
    with pytest.raises(LookupError) as caught:run(callback,owner)
    frames=[];tb=caught.value.__traceback__
    while tb:frames.append(tb.tb_frame.f_code);tb=tb.tb_next
    assert frames.count(source.__code__)==1
    assert native.active_depth()==0


def test_source_stackref_helpers_preserve_cpython_ownership_tags():
    import gc,weakref
    layout=native.layout()
    addresses=native.addresses()
    word=ctypes.c_size_t
    new=ctypes.PYFUNCTYPE(word,ctypes.c_void_p)(addresses['word_newref'])
    duplicate=ctypes.PYFUNCTYPE(word,word)(addresses['word_dup'])
    close=ctypes.PYFUNCTYPE(None,word)(addresses['word_close'])
    class Owner:pass
    owner=Owner();reference=weakref.ref(owner)
    owned=new(id(owner))
    assert owned & layout['tag_refcnt']==0
    copied=duplicate(owned)
    del owner;gc.collect()
    assert reference() is not None
    close(copied);gc.collect()
    assert reference() is not None
    close(owned);gc.collect()
    assert reference() is None
    owner=Owner();reference=weakref.ref(owner)
    borrowed=id(owner)|layout['tag_refcnt']
    assert duplicate(borrowed)==borrowed
    close(borrowed);close(layout['null_bits'])
    assert reference() is owner
    del owner;gc.collect()
    assert reference() is None
    assert layout['locals_offset']>layout['instrptr_offset']
