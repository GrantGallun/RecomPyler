"""Default delivery accepts measurements only for the exact persistent native object."""
import os
from pathlib import Path
import subprocess
import sys
import pytest


def test_exact_artifact_evidence_controls_opt_in_installation(tmp_path):
    code='''
import sys,weakref,gc
from pathlib import Path
import library_artifact_cases as module
from recompyler.ir import compile_function,compilation_info,_entry_native
from recompyler.libraries.cache import DecisionCache
from recompyler.libraries.artifacts import ArtifactCache
from recompyler.libraries.hook import enable,disable
function=module.walk
compile_function(function,strict=True)
cache=DecisionCache(Path(sys.argv[1]),compiler_tag='fixture')
artifacts=ArtifactCache(cache.directory/'native',compiler_tag='fixture')
artifact=artifacts.store(function)
_entry_native.forget_compilation(function)
class Item:
 def __init__(self,parent=None): self.parent=parent
root=Item(); leaf=Item(Item(root))
for _ in range(32): assert function(leaf) is root
cache.record(function,calls=100,cpython_ns=10,native_ns=5,verified=True,artifact_digest='f'*64,artifact_manifest_digest=artifact['manifest_digest'])
session=enable(packages=('library_artifact_cases',),cache=cache)
assert not compilation_info(function)['installed']
disable();_entry_native.forget_compilation(function)
cache.record(function,calls=100,cpython_ns=10,native_ns=5,verified=True,artifact_digest=artifact['object_digest'],artifact_manifest_digest=artifact['manifest_digest'])
session=enable(packages=('library_artifact_cases',),cache=cache)
try:
 assert compilation_info(function)['installed'],session.report
 for _ in range(32): assert function(leaf) is root
 function_ref=weakref.ref(function);code_ref=weakref.ref(function.__code__)
 del module.walk;del function;gc.collect()
 assert function_ref() is None and code_ref() is None,'installed cache body retained application source'
finally: disable()
'''
    env=dict(os.environ,PYTHON_JIT='1')
    env['PYTHONPATH']=os.pathsep.join([str(Path.cwd()/'tests'),str(Path.cwd()/'src'),str(Path.cwd())])
    result=subprocess.run([sys.executable,'-c',code,str(tmp_path)],env=env,capture_output=True,text=True,timeout=60)
    assert result.returncode==0,result.stdout+result.stderr


@pytest.mark.parametrize('mode',['receipt','owner'])
def test_admission_rejects_stale_eligibility_and_replaced_native_owner(tmp_path,mode):
    code='''
import sys
from pathlib import Path
import library_artifact_cases as module
from recompyler.ir import compile_function,compilation_info,_entry_native
from recompyler.libraries.cache import DecisionCache
from recompyler.libraries.artifacts import ArtifactCache
from recompyler.libraries.hook import enable,disable
function=module.walk
compile_function(function,strict=True)
cache=DecisionCache(Path(sys.argv[1])/sys.argv[2],compiler_tag='fixture')
artifacts=ArtifactCache(cache.directory/'native',compiler_tag='fixture')
artifact=artifacts.store(function)
_entry_native.forget_compilation(function)
class Item:
 def __init__(self,parent=None): self.parent=parent
root=Item();leaf=Item(root)
for _ in range(32): assert function(leaf) is root
cache.record(function,calls=100,cpython_ns=10,native_ns=5,verified=True,artifact_digest=artifact['object_digest'],artifact_manifest_digest=artifact['manifest_digest'])
if sys.argv[2]=='receipt':
 cache.record(function,calls=0,cpython_ns=10,native_ns=50,verified=False,artifact_digest=artifact['object_digest'],artifact_manifest_digest=artifact['manifest_digest'])
 cache.eligible=lambda target: True
else:
 original=ArtifactCache.load
 retained=[]
 def replaced(self,target):
  loaded=original(self,target)
  if loaded:
   retained.append(_entry_native._compilation_owner(target)[1])
   _entry_native.forget_compilation(target)
   compile_function(target,strict=True)
  return loaded
 ArtifactCache.load=replaced
session=enable(packages=('library_artifact_cases',),cache=cache)
try: assert not (compilation_info(function) or {}).get('installed'),session.report
finally: disable()
'''
    env=dict(os.environ,PYTHON_JIT='1')
    env['PYTHONPATH']=os.pathsep.join([str(Path.cwd()/'tests'),str(Path.cwd()/'src'),str(Path.cwd())])
    result=subprocess.run([sys.executable,'-c',code,str(tmp_path),mode],env=env,capture_output=True,text=True,timeout=60)
    assert result.returncode==0,mode+': '+result.stdout+result.stderr


def test_installed_artifact_releases_source_before_the_next_receipt_io(tmp_path):
    code='''
import sys,weakref,gc
from pathlib import Path
import library_artifact_cases as module
from recompyler.ir import compile_function,_entry_native
from recompyler.libraries.cache import DecisionCache
from recompyler.libraries.artifacts import ArtifactCache
from recompyler.libraries.hook import enable,disable
class WatchingCache(DecisionCache):
 def receipt(self,function):
  if function.__name__=='total':
   del module.walk;gc.collect()
   observed.append((function_ref() is None,code_ref() is None))
  return super().receipt(function)
cache=WatchingCache(Path(sys.argv[1]),compiler_tag='lifetime')
compile_function(module.walk,strict=True)
artifact=ArtifactCache(cache.directory/'native',compiler_tag='lifetime').store(module.walk)
_entry_native.forget_compilation(module.walk)
class Item:
 def __init__(self,parent=None): self.parent=parent
root=Item();leaf=Item(root)
for _ in range(32): assert module.walk(leaf) is root
cache.record(module.walk,calls=100,cpython_ns=10,native_ns=5,verified=True,artifact_digest=artifact['object_digest'],artifact_manifest_digest=artifact['manifest_digest'])
function_ref=weakref.ref(module.walk);code_ref=weakref.ref(module.walk.__code__);observed=[]
session=enable(packages=('library_artifact_cases',),cache=cache)
try: assert observed==[(True,True)],observed
finally: disable()
'''
    env=dict(os.environ,PYTHON_JIT='1')
    env['PYTHONPATH']=os.pathsep.join([str(Path.cwd()/'tests'),str(Path.cwd()/'src'),str(Path.cwd())])
    result=subprocess.run([sys.executable,'-c',code,str(tmp_path)],env=env,capture_output=True,text=True,timeout=60)
    assert result.returncode==0,result.stdout+result.stderr


def test_equal_native_bytes_cannot_authorize_different_compile_options(tmp_path):
    import json,types
    from recompyler.ir import compile_function,compilation_info,_entry_native
    from recompyler.libraries.cache import DecisionCache
    from recompyler.libraries.artifacts import ArtifactCache,_manifest_digest
    from recompyler.libraries.hook import LibrarySession
    module=types.ModuleType('fixture_options_changed')
    exec('def total(a,b):return a+b',module.__dict__)
    function=module.total
    cache=DecisionCache(tmp_path,compiler_tag='options-fixture')
    artifacts=ArtifactCache(tmp_path/'native',compiler_tag='options-fixture')
    compile_function(function,strict=True)
    try:artifact=artifacts.store(function)
    finally:_entry_native.forget_compilation(function)
    cache.record(function,calls=100,cpython_ns=10,native_ns=5,verified=True,
                 artifact_digest=artifact['object_digest'],artifact_manifest_digest=artifact['manifest_digest'])
    path=artifacts.directory/(artifact['key']+'.json')
    metadata=json.loads(path.read_text())
    assert metadata['provenance']['compile_options']['constant_words'] is True
    metadata['provenance']['compile_options']['constant_words']=False
    metadata['manifest_digest']=_manifest_digest(metadata)
    path.write_text(json.dumps(metadata))
    session=LibrarySession((module.__name__,),cache,False)
    try:
        session.process_module(module)
        assert not (compilation_info(function) or {}).get('installed')
        assert session.report['installed']==0
        assert any('provenance' in row['reason'] for row in session.report['declined'])
    finally:session.close();_entry_native.forget_compilation(function)
