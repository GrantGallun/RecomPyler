"""S80 suspended-function admission reports first-suspension native prefixes."""
import gc,weakref
from types import FunctionType
import pytest
from recompyler.ir import compile_function,compilation_info
from recompyler.ir import _entry_native

def suspended(value,events):
    events.append('prefix')
    value=yield value
    events.append('after')
    yield value
async def coroutine(awaitable,events):
    events.append('prefix')
    return await awaitable
async def asyncgen(value,events):
    events.append('prefix')
    yield value

def ordinary(value):return value

def fresh(function):
    return FunctionType(function.__code__.replace(),function.__globals__,function.__name__,function.__defaults__,function.__closure__)

@pytest.mark.parametrize('source',[suspended,coroutine,asyncgen])
def test_public_compile_prepares_labelled_prefix_without_invoking_source(source):
    fn=fresh(source);code=fn.__code__
    assert compile_function(fn,strict=True) is fn and fn.__code__ is code
    info=compilation_info(fn)
    assert info['compiled'] and info['body_address']>0 and not info['installed']
    assert info['native_prefix'] is True and info['compilation_kind']=='native-prefix'
    assert compile_function(fn,strict=True) is fn
    assert compilation_info(fn)['body_address']==info['body_address']

def test_ordinary_body_reports_distinct_native_body_kind():
    fn=fresh(ordinary);compile_function(fn,strict=True);info=compilation_info(fn)
    assert info['native_prefix'] is False and info['compilation_kind']=='native-body'

def test_prefix_executable_owner_does_not_retain_source_function_or_defaults():
    events=[]
    class Value:
        def __del__(self):events.append('drop')
    def template(value=None):yield value
    def prepare():
        marker=Value();fn=fresh(template);fn.__defaults__=(marker,)
        compile_function(fn,strict=True)
        code,owner=_entry_native._compilation_owner(fn)
        return weakref.ref(fn),weakref.ref(code),weakref.ref(marker),owner
    function,code,marker,owner=prepare()
    assert function() is None and code() is None and marker() is None and events==['drop']
    assert owner.body_address>0

def test_code_change_while_lowering_prefix_never_publishes_stale_body(monkeypatch):
    import recompyler.ir.compiler as compiler
    from recompyler.ir.semantics import UnsupportedBytecode
    fn=fresh(suspended);lower=compiler.lower
    def changed(*args,**kwargs):
        result=lower(*args,**kwargs);fn.__code__=ordinary.__code__;return result
    monkeypatch.setattr(compiler,'lower',changed)
    with pytest.raises(UnsupportedBytecode,match='changed during native compilation'):
        compile_function(fn,strict=True)
    assert compilation_info(fn) is None and fn.__code__ is ordinary.__code__


@pytest.mark.slow
@pytest.mark.parametrize('case',['keyword_seed_binding','generator','coroutine','async_generator','real_helper','invalidated_candidate'])
def test_fresh_public_prefix_and_candidate(case):
    import os,subprocess,sys
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    result=subprocess.run([sys.executable,str(root/'tests/native_prefix_cases.py'),case],cwd=root,env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),capture_output=True,text=True,timeout=90,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
