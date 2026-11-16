"""An owned-call runner receives the actual callable without replacing the binder."""
import ctypes,gc,weakref
from types import FunctionType
import pytest
from llvmlite import ir,binding
from recompyler.ir.entry import create_callable
from recompyler.ir.symbols import CPythonSymbols


def source(value=None):return value


class RunnerBody:
    def __init__(self,mode='actual'):
        symbols=CPythonSymbols();p=ir.IntType(8).as_pointer();n=ir.IntType(64)
        module=ir.Module(name='owned_entry_runner')
        bodytype=ir.FunctionType(p,[p,p.as_pointer(),n,p])
        body=ir.Function(module,bodytype,'body')
        b=ir.IRBuilder(body.append_basic_block('entry'))
        value=b.load(body.args[1]);inc=symbols.declare(module,'Py_IncRef',ir.VoidType(),[p]);b.call(inc,[value]);b.ret(value)
        runner=ir.Function(module,ir.FunctionType(p,[p,p,p.as_pointer(),n,p,p]),'runner')
        b=ir.IRBuilder(runner.append_basic_block('entry'))
        address,original,args,nargsf,names,actual=runner.args
        if mode=='actual':
            b.call(inc,[actual]);b.ret(actual)
        elif mode=='body':
            b.ret(b.call(b.bitcast(address,bodytype.as_pointer()),[original,args,nargsf,names]))
        else:
            call=symbols.declare(module,'PyObject_Vectorcall',p,[p,p.as_pointer(),n,p])
            b.ret(b.call(call,[original,args,nargsf,names]))
        binding.initialize_native_target();binding.initialize_native_asmprinter()
        self.engine=binding.create_mcjit_compiler(binding.parse_assembly(str(module)),binding.Target.from_default_triple().create_target_machine())
        self.engine.finalize_object();self.body=self.engine.get_function_address('body');self.runner=self.engine.get_function_address('runner')


def make(body,function=source):
    return create_callable(function,body.body,body,owned_runner_address=body.runner)


def test_owned_runner_gets_actual_entry_on_nested_and_bound_calls():
    body=RunnerBody();first=make(body);second=make(body)
    assert first(object()) is first
    assert second(object()) is second
    assert first(second(object())) is first
    class Owner:method=first
    assert Owner().method() is first


def test_owned_runner_forwards_original_arguments_and_keywords():
    body=RunnerBody('forward');entry=make(body);marker=object()
    assert entry(marker) is marker
    assert entry(value=marker) is marker
    with pytest.raises(TypeError) as actual:entry(unknown=marker)
    with pytest.raises(TypeError) as expected:source(unknown=marker)
    assert str(actual.value)==str(expected.value)


def test_owned_runner_gets_actual_machine_body_pointer():
    body=RunnerBody('body');entry=make(body);marker=object()
    assert entry(marker) is marker


def test_legacy_and_owned_runner_hooks_are_mutually_exclusive():
    body=RunnerBody()
    with pytest.raises(ValueError,match='runner'):
        create_callable(source,body.body,body,runner_address=body.runner,owned_runner_address=body.runner)


def test_owned_runner_machine_code_lifetime_and_invalidation():
    body=RunnerBody();reference=weakref.ref(body)
    function=FunctionType(source.__code__,globals())
    entry=make(body,function);del body;gc.collect()
    assert reference() is not None
    assert entry(object()) is entry
    def changed(value):return 'changed',value
    function.__code__=changed.__code__
    marker=object();assert entry(marker)==('changed',marker)
    del entry,function;gc.collect();assert reference() is None
