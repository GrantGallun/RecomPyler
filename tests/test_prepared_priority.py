"""Authenticated broad-first binding, with exact mutation checks retained."""
from copy import deepcopy
import json
import os
from pathlib import Path
import subprocess
import sys
import pytest
from test_prepared_cache import artifact,row_for,standalone

def opened(artifact,name='work'):
 pc,heap,module,source,section=artifact
 result=pc.open_index(section,row_for(section,name),plan_snapshot=standalone(section))
 assert result is not None,pc.last_miss()
 return result

def test_priority_is_stable_and_uses_paired_authenticated_ids(artifact):
 pc=artifact[0];index=opened(artifact)
 priority={'wide-seed':0,'strict-seed':1,'legacy':2}
 assert any(c['variant']=='wide-seed' for c in index.cores)
 assert [priority[index.cores[i]['variant']] for i in index._bind_order]==sorted(priority[c['variant']] for c in index.cores)
 assert index._core_ids==tuple(pc.core_id(c) for c in index.cores)
 expected=[c['generated']['digest'] for c in index.cores]
 assert [p.digest for p in index.bind(artifact[2].work)]==expected
 assert [p.digest for p in index.iter_bind(artifact[2].work)]==[expected[i] for i in index._bind_order]

@pytest.mark.parametrize('failure',['key','loader','no-wide','tamper-wide','all'])
def test_priority_retry_keeps_full_checks_and_native_behavior(artifact,monkeypatch,failure):
 pc,heap,module,source,section=artifact;index=opened(artifact)
 first=index._bind_order[0];assert index.cores[first]['variant']=='wide-seed'
 original=pc._restore;calls=[]
 wide=index.cores[first]['generated']['digest']
 if failure=='no-wide':
  pairs=[(c,i) for c,i in zip(index.cores,index._core_ids) if c['variant']!='wide-seed']
  index=pc.PreparedIndex(index.module,index.exports,[c for c,i in pairs],index.snapshot_key,index.build_key,_authority=pc._AUTHORITY,_sealed_ids=tuple(i for c,i in pairs))
 if failure=='tamper-wide':index.cores[first]['execution']['written']=[]
 def restore(core,*a,**kw):
  calls.append(core['variant'])
  if failure=='all' or failure=='key' and core['variant']=='wide-seed':raise pc.PreparedMiss('deliberate incompatible key')
  result=original(core,*a,**kw)
  if failure=='loader' and core['variant']=='wide-seed':result._test_loader_mismatch=True
  return result
 monkeypatch.setattr(pc,'_restore',restore)
 region=heap.Region(module.work,index.exports,prepared=index)
 load=region.load
 def checked_load(program,args):
  if getattr(program,'_test_loader_mismatch',False):raise heap._Mismatch
  return load(program,args)
 monkeypatch.setattr(region,'load',checked_load)
 if failure=='all':
  monkeypatch.setattr(region,'_make_program',lambda:(_ for _ in ()).throw(heap.Unsupported('no regeneration')))
 box,values=module.Box(10),[];result=region(box,values)
 assert result==(box,values,18) and result[0] is box and result[1] is values
 assert region.jit_calls==0
 if failure=='all':assert region.aot_calls==0 and region.fallback_calls==1
 else:
  assert region.aot_calls==region.prepared_hits==1 and region.fallback_calls==0
  assert region.latest.digest!=wide
  assert calls[-1]=='strict-seed'
  assert len(calls)==(2 if failure in ('key','loader') else 1)


def test_open_hashes_each_native_authenticated_record_once(artifact,monkeypatch):
 pc,heap,module,source,section=artifact;calls=[];original=pc.core_id
 def record(core):calls.append(core);return original(core)
 monkeypatch.setattr(pc,'core_id',record)
 index=opened(artifact)
 assert len(calls)==len(section['prepared']['cores'])
 assert len(index._core_ids)==len(index.cores)

@pytest.mark.parametrize('case',['length','order'])
def test_misaligned_authority_ids_fail_closed(artifact,case):
 pc,heap,module,source,section=artifact;old=opened(artifact)
 ids=old._core_ids[:-1] if case=='length' else old._core_ids[1:]+old._core_ids[:1]
 if case=='length':
  with pytest.raises(pc.PreparedMiss):pc.PreparedIndex(old.module,old.exports,old.cores,old.snapshot_key,old.build_key,_authority=pc._AUTHORITY,_sealed_ids=ids)
 else:
  index=pc.PreparedIndex(old.module,old.exports,old.cores,old.snapshot_key,old.build_key,_authority=pc._AUTHORITY,_sealed_ids=ids)
  assert index.bind(module.work)==[]


def test_primitive_grammar_has_no_generator_membership_or_user_hooks(artifact,monkeypatch):
 pc=artifact[0];core=deepcopy(artifact[4]['prepared']['cores'][0])
 def forbidden(*a):raise AssertionError('primitive grammar called generator membership')
 with monkeypatch.context() as m:
  m.setattr(pc,'_is_type',forbidden);pc.validate_core(core)
 events=[]
 class Meta(type):
  def __eq__(self,other):events.append('eq');return True
  __hash__=type.__hash__
 class Hostile(metaclass=Meta):pass
 core['unsupported']=Hostile()
 with pytest.raises(pc.PreparedMiss):pc.validate_core(core)
 assert events==[]


def test_fresh_wide_native_export_preserves_overlapping_and_nullable_aliases(artifact,tmp_path):
 pc,heap,module,source,section=artifact
 code=r'''
import importlib.util,json,sys
from pathlib import Path
from recompyler import heap,_prepared as pc
source=Path(sys.argv[1]);section=json.loads((source.parent/'section.json').read_text())
name='_prepared_cache_fixture_'+source.parent.name.replace('-','_')
spec=importlib.util.spec_from_file_location(name,source);module=importlib.util.module_from_spec(spec);sys.modules[name]=module;spec.loader.exec_module(module)
row=next(r for r in section['functions'] if r['function']=='alias')
index=pc.open_index(section,row,plan_snapshot={'mode':'standalone','functions':[],'plan':{'aot_regions':section}});assert index is not None,pc.last_miss()
wide=next(c for c in index.cores if c['variant']=='wide-seed');native=index.exports[wide['generated']['digest']]
events=[]
def observe(frame,event,arg):
 if event=='c_call' and arg is native:events.append('native')
def forbidden(*a,**kw):raise AssertionError('analysis on prepared hit')
heap._Program.__init__=forbidden
for value in (module.Box(10),None):
 region=heap.Region(module.alias,index.exports,prepared=index);left=[];right=[]
 sys.setprofile(observe)
 try:result=region(value,left,right)
 finally:sys.setprofile(None)
 assert result[0] is left and result[1] is right and result[2] is value and left[0] is value
 assert region.aot_calls==region.prepared_hits==1 and region.jit_calls==region.fallback_calls==0
 assert region.latest.digest==wide['generated']['digest']
assert events==['native','native'],events
print('two actual wide AOT entries; exact overlapping/nullable aliases')
'''
 child=tmp_path/'fresh.py';child.write_text(code)
 completed=subprocess.run([sys.executable,str(child),str(source)],capture_output=True,text=True,env=os.environ.copy())
 assert completed.returncode==0,completed.stdout+completed.stderr
 assert completed.stdout.strip()=='two actual wide AOT entries; exact overlapping/nullable aliases'
