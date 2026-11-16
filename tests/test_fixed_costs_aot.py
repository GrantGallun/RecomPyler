"""AOT native restoration must carry the same fixed-cost proof and live guards."""
import importlib.util
from pathlib import Path
import sys
from unittest.mock import patch
from recompyler import heap, _prepared as pc

def test_real_prepared_scalar_entry_skips_graph_loader_after_binding(tmp_path):
 source=tmp_path/'scalar_work.py';source.write_text('def scalar(x):\n    return x * 2 + 1\n')
 spec=importlib.util.spec_from_file_location('_s41_scalar_aot',source);module=importlib.util.module_from_spec(spec);sys.modules[spec.name]=module;spec.loader.exec_module(module)
 region=heap.lift_region(module.scalar);assert region(2)==5 and region.compiled_calls==1
 section=heap.build_regions([(('scalar',module.scalar.__code__.co_firstlineno),module.scalar,region)],tmp_path/'aot')
 row=section['functions'][0];snapshot={'mode':'standalone','functions':[],'plan':{'aot_regions':section}}
 index=pc.open_index(section,row,plan_snapshot=snapshot);assert index is not None,pc.last_miss()
 rebound=heap.lift_region(module.scalar,prepared=index)
 assert rebound(3)==7 and rebound.aot_calls==1 and rebound.jit_calls==0
 assert rebound.latest.scalar_entry is True
 def forbidden(*args,**kwargs):raise AssertionError('prepared scalar entry repeated graph loading')
 with patch.object(rebound,'load',forbidden):assert rebound(4)==9
 assert rebound.aot_calls==2 and rebound.jit_calls==0 and rebound.fallback_calls==0
 original=module.scalar.__code__
 try:
  module.scalar.__code__=(lambda x:-1).__code__
  assert rebound(4)==-1 and rebound.fallback_calls==1
 finally:module.scalar.__code__=original

def recursive(n):return 0 if n==0 else recursive(n-1)+1

def test_missing_recursion_proof_stays_conservative_when_captured():
 class SourceOnly(dict):
  def __bool__(self):return True
  def get(self,key,default=None):return True
 program=heap._Program(recursive)
 program.widen(program.entry.vars,'n',heap.INT)
 program.compile(SourceOnly())
 assert program.needs_recursion_budget is True
 del program.needs_recursion_budget
 core=pc.capture(program,export='r0',plan_key='0'*64,build_key={})
 assert core['execution']['flags']['needs_recursion_budget'] is True

def test_real_prepared_readonly_object_result_skips_unloader(tmp_path):
 source=tmp_path/'reader_work.py';source.write_text('class Record:\n    def __init__(self,value):self.value=value\n\ndef reader(record):\n    return record.value > 0.0\n')
 spec=importlib.util.spec_from_file_location('_s41_reader_aot',source);module=importlib.util.module_from_spec(spec);sys.modules[spec.name]=module;spec.loader.exec_module(module)
 record=module.Record(1.0);region=heap.lift_region(module.reader);assert region(record) is True and region.compiled_calls==1
 section=heap.build_regions([(('reader',module.reader.__code__.co_firstlineno),module.reader,region)],tmp_path/'aot')
 snapshot={'mode':'standalone','functions':[],'plan':{'aot_regions':section}}
 index=pc.open_index(section,section['functions'][0],plan_snapshot=snapshot);assert index is not None,pc.last_miss()
 rebound=heap.lift_region(module.reader,prepared=index)
 def forbidden(*args,**kwargs):raise AssertionError('prepared readonly scalar result created an unloader')
 with patch.object(heap,'_Unloader',forbidden):assert rebound(record) is True
 assert rebound.latest.boundary_no_writeback is True and not rebound.latest.scalar_entry
 assert rebound.aot_calls==1 and rebound.jit_calls==0 and rebound.fallback_calls==0
 import gc,weakref
 reference=weakref.ref(record);del record;gc.collect();assert reference() is None

def test_prepared_alternating_variants_do_not_rebind(tmp_path):
 source=tmp_path/'variants_work.py';source.write_text('def scalar(x):\n    return x * 2 + 1\n')
 spec=importlib.util.spec_from_file_location('_s41_variants_aot',source);module=importlib.util.module_from_spec(spec);sys.modules[spec.name]=module;spec.loader.exec_module(module)
 region=heap.lift_region(module.scalar);assert region(2)==5 and region(2.5)==6.0
 section=heap.build_regions([(('scalar',module.scalar.__code__.co_firstlineno),module.scalar,region)],tmp_path/'aot')
 index=pc.open_index(section,section['functions'][0],plan_snapshot={'mode':'standalone','functions':[],'plan':{'aot_regions':section}})
 assert index is not None,pc.last_miss()
 rebound=heap.lift_region(module.scalar,prepared=index)
 assert rebound(3)==7 and rebound(3.5)==8.0
 assert rebound.aot_calls==2 and rebound.jit_calls==0 and rebound.fallback_calls==0
 def forbidden(*args,**kwargs):raise AssertionError('retained prepared variant rebound its descriptor')
 with patch.object(index,'iter_bind',forbidden):
  assert rebound(4)==9 and rebound(4.5)==10.0
 assert rebound.aot_calls==4 and rebound.jit_calls==0 and rebound.fallback_calls==0
 original=module.scalar.__code__
 try:
  module.scalar.__code__=(lambda x:-1).__code__
  assert rebound(5)==-1 and rebound.fallback_calls==1
 finally:module.scalar.__code__=original
