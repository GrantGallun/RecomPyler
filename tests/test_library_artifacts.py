"""Persistent artifacts must relocate objects and native helpers in fresh processes."""
import importlib
import json
import os
from pathlib import Path
import subprocess
import sys
import pytest


def artifact_api():
    try: return importlib.import_module('recompyler.libraries.artifacts')
    except ModuleNotFoundError: pytest.fail('portable native artifact cache is missing')


@pytest.mark.parametrize('case',['walk','choose','total'])
def test_exported_native_object_runs_in_a_fresh_process_without_recompiling(tmp_path,case):
    api = artifact_api()
    import library_artifact_cases
    walk=getattr(library_artifact_cases,case)
    from recompyler.ir import compile_function
    compile_function(walk,strict=True)
    cache = api.ArtifactCache(tmp_path,compiler_tag='artifact-fixture')
    receipt = cache.store(walk)
    assert receipt['status'] == 'portable-native'
    assert receipt['relocations'] > 0
    code = '''
import sys
import library_artifact_cases
walk=getattr(library_artifact_cases,sys.argv[2])
from recompyler.libraries.artifacts import ArtifactCache
from recompyler.ir import _entry_native,compilation_info
from tools.ir_self_host import CountedBody,install_candidate
cache=ArtifactCache(sys.argv[1],compiler_tag='artifact-fixture')
result=cache.load(walk)
assert result and result['object_cache_hit'], result
code,owner=_entry_native._compilation_owner(walk)
counted=CountedBody(owner)
_entry_native.forget_compilation(walk)
_entry_native.prepare_frame_entry(walk,counted.body_address,counted,code)
class Item:
 def __init__(self,parent=None): self.parent=parent
root=Item(); leaf=Item(Item(root))
def check():
 if sys.argv[2]=='total':
  result=walk([2**80,3,-2**80])
  assert type(result) is int and result==3
  result=walk([-0.0])
  assert type(result) is float and result.hex()=='0x0.0p+0'
  try: walk([1,'x'])
  except TypeError: pass
  else: raise AssertionError('native call swallowed an error')
 elif sys.argv[2]=='choose':
  result=walk(leaf)
  assert result[0] is root and result[1:]==(1000,2000)
 else: assert walk(leaf) is root
for _ in range(32): check()
assert install_candidate(walk)
for _ in range(32): check()
assert counted.calls.value>0, 'cached object body was not executed'
print('relocated-native-ok')
'''
    env=dict(os.environ,PYTHON_JIT='1')
    env['PYTHONPATH']=os.pathsep.join([str(Path.cwd()/'tests'),str(Path.cwd()/'src'),str(Path.cwd())])
    result=subprocess.run([sys.executable,'-c',code,str(tmp_path),case],env=env,capture_output=True,text=True,timeout=60)
    assert result.returncode==0,result.stdout+result.stderr
    assert 'relocated-native-ok' in result.stdout


def test_artifact_invalidates_compiler_code_and_corrupt_object(tmp_path):
    api=artifact_api()
    from library_artifact_cases import total
    from recompyler.ir import compile_function,_entry_native
    compile_function(total,strict=True)
    cache=api.ArtifactCache(tmp_path,compiler_tag='one')
    receipt=cache.store(total)
    assert receipt['status']=='portable-native'
    _entry_native.forget_compilation(total)
    assert api.ArtifactCache(tmp_path,compiler_tag='two').load(total) is None
    original=total.__code__
    try:
        total.__code__=original.replace(co_firstlineno=original.co_firstlineno+1)
        assert cache.load(total) is None
    finally: total.__code__=original
    object_path=tmp_path/(receipt['key']+'.o')
    object_path.write_bytes(b'corrupt object')
    assert cache.load(total) is None



def test_loading_rejects_code_changed_during_cache_read(tmp_path, monkeypatch):
    api=artifact_api()
    from library_artifact_cases import total
    from recompyler.ir import compile_function,_entry_native,compilation_info
    compile_function(total,strict=True)
    cache=api.ArtifactCache(tmp_path,compiler_tag='race')
    cache.store(total)
    _entry_native.forget_compilation(total)
    original=total.__code__
    read=Path.read_text
    def changed(path,*args,**kwargs):
        text=read(path,*args,**kwargs)
        if path.suffix=='.json': total.__code__=original.replace(co_firstlineno=original.co_firstlineno+1)
        return text
    monkeypatch.setattr(Path,'read_text',changed)
    try:
        assert cache.load(total) is None, 'cached body admitted for a different current code object'
        assert compilation_info(total) is None
    finally:
        _entry_native.forget_compilation(total)
        total.__code__=original


def test_two_live_code_objects_relocate_independently_and_are_released(tmp_path):
    api=artifact_api()
    import gc,types,weakref
    from library_artifact_cases import walk
    from recompyler.ir import compile_function,_entry_native
    cache=api.ArtifactCache(tmp_path,compiler_tag='independent')
    copies=[types.FunctionType(walk.__code__.replace(),walk.__globals__) for _ in range(2)]
    references=[]
    for function in copies:
        compile_function(function,strict=True)
        cache.store(function)
        _entry_native.forget_compilation(function)
        assert cache.load(function)['object_cache_hit']
        references.append((weakref.ref(function),weakref.ref(function.__code__)))
    del function
    copies.clear();gc.collect()
    assert all(f() is None and code() is None for f,code in references)


def test_unknown_process_pointer_and_attribute_feedback_are_not_exported(tmp_path):
    api=artifact_api()
    from library_artifact_cases import walk
    from recompyler.ir import compile_function,_entry_native
    from dataclasses import replace
    compile_function(walk,strict=True)
    _,owner=_entry_native._compilation_owner(walk)
    with pytest.raises(api.UnportableBody,match='unrecognised'):
        api._normalise(walk,replace(owner,module='define i8* @body() { ret i8* inttoptr (i64 123456789 to i8*) }'))
    with pytest.raises(api.UnportableBody,match='feedback'):
        api._normalise(walk,replace(owner,module='structure_cached_storage'))


@pytest.mark.parametrize('mutation',['array','relocation','entry_offset'])
def test_corrupt_metadata_cannot_admit_a_cached_body(tmp_path,mutation):
    api=artifact_api()
    from library_artifact_cases import walk
    from recompyler.ir import compile_function,_entry_native,compilation_info
    compile_function(walk,strict=True)
    cache=api.ArtifactCache(tmp_path,compiler_tag='corrupt-metadata')
    receipt=cache.store(walk)
    _entry_native.forget_compilation(walk)
    path=tmp_path/(receipt['key']+'.json')
    metadata=json.loads(path.read_text())
    if mutation=='array': metadata=[]
    elif mutation=='relocation':
        target=next(r for r in metadata['relocations'] if r==['immortal','None'])
        target[1]='True'
    else: metadata['entry_offset']+=2
    path.write_text(json.dumps(metadata))
    try:
        assert cache.load(walk) is None
        assert compilation_info(walk) is None
    finally: _entry_native.forget_compilation(walk)


def test_cached_object_load_runs_no_llvm_ir_or_codegen_pipeline(tmp_path, monkeypatch):
    from recompyler.ir import compile_function, _entry_native, compiler, llvm_semantics
    from recompyler.libraries.artifacts import ArtifactCache
    from llvmlite import binding
    from library_artifact_cases import total
    compile_function(total,strict=True)
    cache=ArtifactCache(tmp_path,compiler_tag='object-only-fixture')
    cache.store(total)
    _entry_native.forget_compilation(total)
    parse=binding.parse_assembly
    def no_work(*args,**kwargs):
        raise AssertionError('cached artifact load entered a compiler pipeline')
    def empty_only(text,*args,**kwargs):
        assert not text.strip(), 'cached native object re-parsed LLVM IR'
        return parse(text,*args,**kwargs)
    monkeypatch.setattr(binding,'parse_assembly',empty_only)
    monkeypatch.setattr(llvm_semantics,'optimize_module',no_work)
    monkeypatch.setattr(binding.TargetMachine,'emit_object',no_work)
    monkeypatch.setattr(compiler,'lower',no_work)
    try:
        loaded=cache.load(total)
        assert loaded is not None and loaded['object_cache_hit']
        assert loaded['_owner'].body_address>0
    finally:
        _entry_native.forget_compilation(total)


def test_frameless_artifact_preserves_the_actual_deployment_abi(tmp_path):
    from recompyler.ir import compile_function, _entry_native
    from recompyler.libraries.artifacts import ArtifactCache
    from library_artifact_cases import peek
    compile_function(peek,strict=True)
    try:
        cache=ArtifactCache(tmp_path,compiler_tag='frameless-fixture')
        receipt=cache.store(peek)
        metadata=json.loads((tmp_path/(receipt['key']+'.json')).read_text())
        assert metadata['abi']=='callback-free-vectorcall', 'frameless deployment was exported as a different frame body'
    finally:
        _entry_native.forget_compilation(peek)


def test_frameless_artifact_loads_without_compiling_or_jit(tmp_path):
    from recompyler.ir import compile_function, _entry_native
    from recompyler.libraries.artifacts import ArtifactCache
    from library_artifact_cases import peek
    compile_function(peek,strict=True)
    artifact=ArtifactCache(tmp_path/'native',compiler_tag='frameless-fixture').store(peek)
    _entry_native.forget_compilation(peek)
    code='''
import gc,sys,weakref
from pathlib import Path
import library_artifact_cases as module
from recompyler.ir import compiler,frameless,compilation_info,_entry_native
from recompyler.libraries import artifacts
from recompyler.libraries.cache import DecisionCache
from recompyler.libraries.hook import enable,disable
from llvmlite import binding
from recompyler.ir import llvm_semantics
assert not sys._jit.is_enabled()
def forbidden(*args,**kwargs):raise AssertionError('cached frameless load compiled code')
parse=binding.parse_assembly
def empty_only(text,*args,**kwargs):
 assert not text.strip(),'cached object parsed source IR'
 return parse(text,*args,**kwargs)
compiler.lower=forbidden;compiler.compile_function=forbidden
import recompyler.ir
recompyler.ir.compile_function=forbidden
frameless.prepare_frameless=forbidden;artifacts._engine=forbidden
llvm_semantics.optimize_module=forbidden;binding.TargetMachine.emit_object=forbidden
binding.parse_assembly=empty_only
cache=DecisionCache(Path(sys.argv[1]),compiler_tag='frameless-fixture')
# Synthetic admission fixture only, never performance evidence.
cache.record(module.peek,calls=100,cpython_ns=10,native_ns=5,verified=True,artifact_digest=sys.argv[2],artifact_manifest_digest=sys.argv[3])
session=enable(packages=(module.__name__,),cache=cache)
function=module.peek
class Owner:pass
owner=Owner();owner.parent=object()
try:
 info=compilation_info(function)
 assert info and info['installed'] and info['abi']=='callback-free-vectorcall',session.report
 assert session.report['installed']==1
 assert function(owner) is owner.parent
 class Cold:
  @property
  def parent(self):return sys._getframe(1).f_code
 assert function(Cold()) is function.__code__
 function_ref,code_ref=weakref.ref(function),weakref.ref(function.__code__)
 del module.peek;del function;gc.collect()
 assert function_ref() is None and code_ref() is None,'cached entry kept source alive'
finally:disable()
print('cached-frameless-ok')
'''
    env=dict(os.environ,PYTHON_JIT='0')
    env['PYTHONPATH']=os.pathsep.join([str(Path.cwd()/'tests'),str(Path.cwd()/'src'),str(Path.cwd())])
    result=subprocess.run([sys.executable,'-c',code,str(tmp_path),artifact['object_digest'],artifact['manifest_digest']],env=env,capture_output=True,text=True,timeout=60)
    assert result.returncode==0,result.stdout+result.stderr
    assert 'cached-frameless-ok' in result.stdout


@pytest.mark.parametrize('jit',['0','1'])
def test_cached_frameless_loop_relocates_cold_frame_plans(tmp_path,jit):
    from recompyler.ir import compile_function, _entry_native
    from recompyler.libraries.artifacts import ArtifactCache
    from library_artifact_cases import walk_retained
    compile_function(walk_retained,strict=True)
    cache=ArtifactCache(tmp_path,compiler_tag='loop-cold-fixture')
    artifact=cache.store(walk_retained)
    metadata=json.loads((tmp_path/(artifact['key']+'.json')).read_text())
    assert [r[0] for r in metadata['relocations']].count('cold_plan')==2
    assert any(r[0]=='cold_state' for r in metadata['relocations'])
    _entry_native.forget_compilation(walk_retained)
    code='''
import gc,sys,weakref
from recompyler.ir import compilation_info,_entry_native,compiler
from recompyler.libraries.artifacts import ArtifactCache
from library_artifact_cases import walk_retained as function
from llvmlite import binding
from recompyler.ir import llvm_semantics
parse=binding.parse_assembly
def empty_only(text,*args,**kwargs):
 assert not text.strip(),'cached loop re-parsed IR'
 return parse(text,*args,**kwargs)
def forbidden(*args,**kwargs):raise AssertionError('cached loop compiled source')
binding.parse_assembly=empty_only;compiler.lower=forbidden;llvm_semantics.optimize_module=forbidden
loaded=ArtifactCache(sys.argv[1],compiler_tag='loop-cold-fixture').load(function)
assert loaded and loaded['abi']=='callback-free-vectorcall'
owner=loaded['_owner']
assert owner.cold_address and owner.cold_state is not None and len(owner.cold_plans)==2
if sys._jit.is_enabled():
 from recompyler.ir.entry import install_frame_entry
 try:install_frame_entry(function,owner.body_address,owner,seed_arguments=(None,),expected_code=function.__code__,expected_prepared=loaded['_prepared'])
 except ValueError:pass
 else:raise AssertionError('frameless artifact accepted a frame ABI install')
candidate=compiler._frameless_candidates[function];candidate.install()
class Node:pass
root=Node();root.parent=None;leaf=Node();leaf.parent=root
seen=[]
class Cold:
 @property
 def parent(self):
  frame=sys._getframe(1)
  seen.append((frame.f_code is function.__code__,frame.f_locals['owner'] is leaf,frame.f_locals['current'] is self))
  _entry_native.forget_compilation(function)
  return None
try:
 assert function(leaf) is root
 tail=Cold();root.parent=tail
 assert function(leaf) is tail
 assert seen==[(True,True,True)]
 assert not candidate.active
finally:candidate.close();_entry_native.forget_compilation(function)
print('cached-loop-cold-ok')
'''
    env=dict(os.environ,PYTHON_JIT=jit)
    env['PYTHONPATH']=os.pathsep.join([str(Path.cwd()/'tests'),str(Path.cwd()/'src'),str(Path.cwd())])
    result=subprocess.run([sys.executable,'-c',code,str(tmp_path)],env=env,capture_output=True,text=True,timeout=60)
    assert result.returncode==0,result.stdout+result.stderr
    assert 'cached-loop-cold-ok' in result.stdout


def test_concurrent_cached_objects_keep_independent_code_relocations(tmp_path):
    code='''
import sys,time,types
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from llvmlite import binding
from recompyler.ir import compile_function,_entry_native
from recompyler.libraries.artifacts import ArtifactCache
from library_artifact_cases import walk
from tools.ir_self_host import CountedBody,install_candidate
cache=ArtifactCache(sys.argv[1],compiler_tag='parallel-load-fixture')
functions=[types.FunctionType(walk.__code__.replace(),walk.__globals__) for _ in range(2)]
for fn in functions:
 compile_function(fn,strict=True);cache.store(fn);_entry_native.forget_compilation(fn)
publish=binding.add_symbol
def yield_publication(name,address):
 publish(name,address)
 if name.startswith('rc_library_object_'):time.sleep(.005)
binding.add_symbol=yield_publication
with ThreadPoolExecutor(max_workers=2) as pool:loaded=list(pool.map(cache.load,functions))
assert all(row and row['object_cache_hit'] for row in loaded)
class Item:
 def __init__(self,parent=None):self.parent=parent
root=Item();leaf=Item(Item(root));counted=[]
for fn,row in zip(functions,loaded):
 assert row['_code'] is fn.__code__
 counter=CountedBody(row['_owner']);counted.append(counter)
 _entry_native.forget_compilation(fn)
 _entry_native.prepare_frame_entry(fn,counter.body_address,counter,fn.__code__)
 for _ in range(32):assert fn(leaf) is root
 assert install_candidate(fn)
for fn in functions:
 for _ in range(32):assert fn(leaf) is root
assert all(counter.calls.value>=32 for counter in counted)
for fn in functions:_entry_native.forget_compilation(fn)
print('concurrent-native-relocations-ok')
'''
    env=dict(os.environ,PYTHON_JIT='1')
    env['PYTHONPATH']=os.pathsep.join([str(Path.cwd()/'tests'),str(Path.cwd()/'src'),str(Path.cwd())])
    result=subprocess.run([sys.executable,'-c',code,str(tmp_path)],env=env,capture_output=True,text=True,timeout=60)
    assert result.returncode==0,result.stdout+result.stderr
    assert 'concurrent-native-relocations-ok' in result.stdout


def test_immortal_relocations_ignore_rebound_builtin_names(monkeypatch):
    import builtins, ctypes
    from recompyler.libraries import artifacts
    canonical_float=float; canonical_error=SystemError
    class OtherFloat(float):pass
    class OtherError(Exception):pass
    monkeypatch.setattr(builtins,'float',OtherFloat)
    monkeypatch.setattr(builtins,'SystemError',OtherError)
    addresses,*_=artifacts._resolve((lambda:None).__code__,
        [['immortal','float_type'],['immortal','SystemError']],None)
    assert addresses==[id(canonical_float),id(canonical_error)]


def test_numeric_artifact_keeps_canonical_types_across_export_and_load(tmp_path,monkeypatch):
    if not sys._jit.is_enabled():
        env=dict(os.environ,PYTHON_JIT='1')
        result=subprocess.run([sys.executable,'-m','pytest','-q',
            str(Path(__file__).resolve())+'::test_numeric_artifact_keeps_canonical_types_across_export_and_load',
            '--basetemp='+str(tmp_path/'jit')],env=env,capture_output=True,text=True,timeout=90)
        assert result.returncode==0,result.stdout+result.stderr
        return
    import builtins,types
    from recompyler.ir import build,_entry_native
    from recompyler.ir.lower_llvm import lower
    from recompyler.ir.numeric_ops import FloatOps
    from library_artifact_cases import numeric_total
    from tools.ir_self_host import CountedBody,install_candidate
    function=types.FunctionType(numeric_total.__code__.replace(),{})
    lowered=lower(build(function),frame_entry=True,numeric_ops=FloatOps())
    _entry_native.prepare_frame_entry(function,lowered.body_address,lowered.execution_owner,function.__code__)
    cache=artifact_api().ArtifactCache(tmp_path,compiler_tag='canonical-numeric-fixture')
    receipt=cache.store(function)
    metadata=json.loads((tmp_path/(receipt['key']+'.json')).read_text())
    assert ['immortal','float_type'] in metadata['relocations']
    assert ['immortal','int_type'] in metadata['relocations']
    _entry_native.forget_compilation(function)
    class OtherFloat(float):
        def __radd__(self,other):return 'subclass-dispatch'
    class OtherError(Exception):pass
    with monkeypatch.context() as patch:
        patch.setattr(builtins,'float',OtherFloat)
        patch.setattr(builtins,'SystemError',OtherError)
        result=cache.load(function)
    assert result and result['object_cache_hit']
    counted=CountedBody(result['_owner'])
    _entry_native.forget_compilation(function)
    _entry_native.prepare_frame_entry(function,counted.body_address,counted,function.__code__)
    try:
        assert install_candidate(function)
        assert function([1.5,2.5])==4.0
        assert function([2**80,-2**80])==0
        assert function([OtherFloat(1)])=='subclass-dispatch'
        assert counted.calls.value>=3
    finally:_entry_native.forget_compilation(function)
