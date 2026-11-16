from array import array
import importlib.util,json,struct,subprocess,sys
from pathlib import Path
import pytest


def work(tmp_path):
 path=tmp_path/'flat_aot_work.py'
 path.write_text("def first(data):\n    return data[0]\n\ndef update(data,index,divisor):\n    data[0] += 1.0\n    return data[index] / divisor\n",encoding='utf-8')
 spec=importlib.util.spec_from_file_location('flat_aot_work',path);module=importlib.util.module_from_spec(spec)
 sys.modules[spec.name]=module;spec.loader.exec_module(module);return module


def prepared(fn,rows,tmp_path):
 from recompyler._flat_aot import build_flat
 from recompyler._flat_runtime import FlatAot
 entry=build_flat(fn,rows,tmp_path)
 assert entry is not None,'flat export was declined'
 json.dumps(entry)
 return entry,FlatAot(fn,entry)


def bits(value):return struct.pack('!d',value)


def test_saved_flat_first_warm_numeric_type_and_bits(tmp_path):
 m=work(tmp_path)
 nan=struct.unpack('!d',bytes.fromhex('7ff8000000000042'))[0]
 entry,w=prepared(m.first,[([1.25],),([1000003],)],tmp_path)
 for value in (-0.0,nan,1.25,1000003,-2**63):
  for _ in range(2):
   got=w([value]);assert type(got) is type(value)
   assert bits(got)==bits(value) if type(value) is float else got==value
 assert w.flat_calls==10 and w.fallback_calls==0
 assert w.last_audit['commits']==1 and w.last_audit['active']==0


def test_saved_flat_partial_store_rolls_back_before_exact_python_error(tmp_path):
 m=work(tmp_path);entry,w=prepared(m.update,[(array('d',[4.5,-0.0]),0,2.0)],tmp_path)
 data=array('d',[4.5,-0.0]);assert w(data,0,2.0)==2.75 and w.flat_calls==1
 for index,divisor in ((9,2.0),(0,0.0)):
  expected=array('d',data)
  try:m.update(expected,index,divisor)
  except Exception as exc:kind,message=type(exc),str(exc)
  with pytest.raises(kind) as caught:w(data,index,divisor)
  assert str(caught.value)==message and caught.value.__context__ is None
  assert data.tobytes()==expected.tobytes()
  assert w.last_audit['rollbacks']==1 and w.last_audit['active']==0
 data.append(8.0);assert w.flat_calls==1 and w.fallback_calls==2


def test_saved_flat_profile_resize_and_changed_code_are_fresh(tmp_path):
 m=work(tmp_path);entry,w=prepared(m.first,[(array('d',[1.25]),)],tmp_path)
 data=array('d',[1.25]);hit=[]
 def profile(frame,event,arg):
  if not hit and event=='call' and frame.f_code is type(w)._invoke.__code__:
   hit.append(True);data[0]=8.5;data.append(4.0)
 sys.setprofile(profile)
 try:assert w(data)==8.5
 finally:sys.setprofile(None)
 assert hit and w.flat_calls==1
 m.first.__code__=m.first.__code__.replace(co_consts=(None,1))
 assert w(data)==4.0 and w.flat_calls==1 and w.fallback_calls==1


def test_saved_flat_subprocess_loads_without_numba_or_llvmlite(tmp_path):
 m=work(tmp_path);entry,w=prepared(m.update,[(array('d',[4.5]),0,2.0)],tmp_path)
 path=tmp_path/'flat-entry.json';path.write_text(json.dumps(entry),encoding='utf-8')
 script="""import importlib.abc,json,sys
class Block(importlib.abc.MetaPathFinder):
 def find_spec(self,name,*args):
  if name.split('.')[0] in ('numba','llvmlite'):raise AssertionError('compiler import '+name)
sys.meta_path.insert(0,Block())
sys.path.insert(0,sys.argv[1])
import flat_aot_work as m
from array import array
from recompyler._flat_runtime import FlatAot
w=FlatAot(m.update,json.load(open(sys.argv[2])));data=array('d',[4.5])
assert w(data,0,2.0)==2.75 and data[0]==5.5 and w.flat_calls==1 and w.fallback_calls==0
assert not any(n.split('.')[0] in ('numba','llvmlite') for n in sys.modules)
print('PASS saved flat AOT without compiler')
"""
 result=subprocess.run([sys.executable,'-c',script,str(tmp_path),str(path)],capture_output=True,text=True)
 assert result.returncode==0,result.stdout+result.stderr
 assert 'PASS saved flat AOT without compiler' in result.stdout
