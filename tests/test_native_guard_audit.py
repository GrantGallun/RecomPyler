"""Audit hooks are isolated in children because they cannot be uninstalled."""
import subprocess
import sys
import textwrap
import pytest

SOURCE=r'''
import json,sys
from types import SimpleNamespace
from recompyler import heap,lift,_heap as native
path,mode=sys.argv[1:]
def target(value=1,*,option=2):return value+option
def spare(value=1,*,option=2):return value-option
code=target.__code__;defaults=target.__defaults__;kwdefaults=target.__kwdefaults__
if path=='heap-code':guard=('code',target,code)
elif path=='heap-defaults':guard=('attr',target,'__defaults__',defaults)
elif path=='heap-kwdefaults-attr':guard=('attr',target,'__kwdefaults__',kwdefaults)
else:guard=('kwdefaults',target,kwdefaults,tuple(kwdefaults.items()))
program=object.__new__(heap._Program);program.guards={0:guard}
checks=([({'target':target},'target',target,code)],[],[])
unit=object.__new__(lift._Unit);unit._fast_guards=checks;unit.records=SimpleNamespace(infos={});unit.guards=checks[0];unit.builtin_guards={};unit.math_guards=set()
trace=[];sentinel=RuntimeError('audit observer')
def hook(event,args):
 if event!='object.__getattr__' or args[0] is not target:return
 name=args[1];trace.append(name)
 if mode=='raise':raise sentinel
 if mode=='mutate':
  if name=='__code__':target.__code__=spare.__code__
  elif name=='__defaults__':target.__defaults__=(99,)
  elif name=='__kwdefaults__':target.__kwdefaults__={'option':99}
sys.addaudithook(hook)
# Every native entry declines before generating an observed event.
answer=native.check_lift_guards(checks,{}) if path=='lift-code' else native.check_heap_guards(program.guards)
assert answer is None,(path,mode,'native skipped audit fallback',answer)
assert trace==[]
old_native=lift._NATIVE_GUARDS
results=[]
for fast in (False,True):
 target.__code__=code;target.__defaults__=defaults;target.__kwdefaults__=kwdefaults
 trace.clear();heap.NATIVE=fast;lift._NATIVE_GUARDS=old_native if fast else None
 try:
  value=unit.guards_hold() if path=='lift-code' else program.guards_hold()
  outcome=('return',value)
 except BaseException as error:outcome=('raise',type(error).__name__,str(error),error is sentinel)
 results.append((outcome,list(trace)))
assert results[0]==results[1],(path,mode,results)
assert results[0][1],(path,mode,'vacuous audit trace')
print(json.dumps(dict(path=path,mode=mode,matched=True,result=results[0])))
'''

@pytest.mark.parametrize('path',['heap-code','heap-defaults','heap-kwdefaults-attr','heap-kwdefaults','lift-code'])
@pytest.mark.parametrize('mode',['log','raise','mutate'])
def test_audit_getter_events_exceptions_and_mutations_match_python(path,mode):
    child=subprocess.run([sys.executable,'-c',textwrap.dedent(SOURCE),path,mode],capture_output=True,text=True,timeout=30)
    assert child.returncode==0,(child.stdout,child.stderr)

C_HOOK_SOURCE=r'''
import ctypes,json,os,sys,traceback
from recompyler import heap,_heap as native
def target(value=1):return value
code=target.__code__;events=[]
program=object.__new__(heap._Program);program.guards={0:('code',target,code)}
CALLBACK=ctypes.CFUNCTYPE(ctypes.c_int,ctypes.c_char_p,ctypes.py_object,ctypes.c_void_p)
def observer(event,args,data):
 if event==b'object.__getattr__' and args[0] is target:events.append(args[1])
 return 0
callback=CALLBACK(observer)
api=ctypes.pythonapi.PySys_AddAuditHook;api.argtypes=[CALLBACK,ctypes.c_void_p];api.restype=ctypes.c_int
assert api(callback,None)==0
try:
 assert native.check_heap_guards(program.guards) is None
 assert events==[]
 outcomes=[]
 for fast in (False,True):
  events.clear();heap.NATIVE=fast
  outcomes.append((program.guards_hold(),list(events)))
 assert outcomes==[(True,['__code__']),(True,['__code__'])],outcomes
 print(json.dumps(dict(global_c_hook=True,matched=True)),flush=True)
except BaseException:
 traceback.print_exc();sys.stderr.flush();os._exit(1)
os._exit(0)
'''


def test_global_native_audit_hook_declines_and_preserves_python_events():
    child=subprocess.run([sys.executable,'-c',textwrap.dedent(C_HOOK_SOURCE)],capture_output=True,text=True,timeout=30)
    assert child.returncode==0,(child.stdout,child.stderr)


@pytest.fixture(scope='module')
def native_guard_probe(tmp_path_factory):
    import hashlib,json,os
    from pathlib import Path
    from recompyler import heap
    root=Path(heap.__file__).resolve().parents[2]
    folder=tmp_path_factory.mktemp('native-guard-probe')
    command=[sys.executable,str(root/'inplace/native_guards_probe_setup.py'),'build_ext','--force','--build-lib',str(folder/'lib'),'--build-temp',str(folder/'temp')]
    child=subprocess.run(command,cwd=folder,capture_output=True,text=True,timeout=60)
    assert child.returncode==0,(child.stdout,child.stderr)
    binaries=list((folder/'lib').glob('_guard_probe*.pyd'))
    assert len(binaries)==1
    (folder/'complete.json').write_text(json.dumps(dict(complete=True,command=command,exit_code=0,binary_sha256=hashlib.sha256(binaries[0].read_bytes()).hexdigest())))
    return folder/'lib'


def test_busy_mutex_and_all_worker_return_paths_release(native_guard_probe):
    source=r'''
import json,sys
sys.path.insert(0,sys.argv[1])
import _guard_probe as probe
from recompyler import _heap as native
assert probe.available() is True
assert probe.exercise(native.check_heap_guards,0) is True
assert probe.available() is True
for guards,expected in (({},True),({0:('item',{},'x',object())},False),({0:('future',)},None)):
 assert native.check_heap_guards(guards) is expected
 assert probe.available() is True
assert probe.exercise(native.check_heap_guards,1) is True
assert probe.available() is True
assert native.check_heap_guards({}) is True
print(json.dumps(dict(nonblocking_busy=True,true_false_none_error_cleanup=True)))
'''
    child=subprocess.run([sys.executable,'-c',textwrap.dedent(source),str(native_guard_probe)],capture_output=True,text=True,timeout=30)
    assert child.returncode==0,(child.stdout,child.stderr)
