"""Structure primitives through the installed shared IR and native entry."""
import ctypes,importlib.util,sys
from pathlib import Path
import pytest
from llvmlite import binding,ir
from recompyler.ir import structure_lowerings as subject
from recompyler.ir import symbols
from recompyler import _structure_ops_native as provider
PTR=ir.IntType(8).as_pointer()

class Compiled:
 def __init__(self,method,count,status=False,borrowed=False):
  self.lowerings=subject.StructureCalls(symbols.CPythonSymbols(),provider)
  module=ir.Module(name='s73_component');function=ir.Function(module,ir.FunctionType(ir.IntType(32) if status else PTR,[PTR]*count),name='probe');builder=ir.IRBuilder(function.append_basic_block('entry'))
  value=getattr(self.lowerings,method)(builder,*function.args);builder.ret(value)
  self.llvm=str(module)
  assert 'NRT' not in self.llvm and 'numba' not in self.llvm
  binding.initialize_native_target();binding.initialize_native_asmprinter()
  machine=binding.Target.from_default_triple().create_target_machine();native=binding.parse_assembly(self.llvm);native.verify()
  self.engine=binding.create_mcjit_compiler(binding.parse_assembly(''),machine);self.engine.add_module(native);self.engine.finalize_object()
  self.invoke=ctypes.PYFUNCTYPE(ctypes.c_int if status else ctypes.c_void_p,*[ctypes.c_void_p]*count)(self.engine.get_function_address('probe'));self.status=status;self.borrowed=borrowed
 def __call__(self,*args):
  value=self.invoke(*(id(arg) for arg in args))
  if self.status:return value
  if self.borrowed:
   return ctypes.cast(value,ctypes.py_object).value if value else subject.GUARD_MISS
  assert value
  result=ctypes.cast(value,ctypes.py_object).value
  decref=ctypes.pythonapi.Py_DecRef;decref.argtypes=[ctypes.c_void_p];decref.restype=None;decref(value)
  return result

def test_raw_attribute_load_and_mutation_keep_identity_and_descriptor_effects():
 fast=Compiled('load_attr',2);marker=object()
 class Record:pass
 owner=Record();owner.value=marker
 assert fast(owner,'value') is marker
 owner.__dict__={'value':None};assert fast(owner,'value') is None
 events=[]
 class Descriptor:
  def __get__(self,owner,kind):events.append('get');return marker
  def __set__(self,owner,value):raise AttributeError('readonly')
 Record.value=Descriptor();assert fast(owner,'value') is marker and events==['get']
 del Record.value
 with pytest.raises(AttributeError):fast(owner,'missing')

def test_raw_attribute_store_publishes_before_old_value_finalizer():
 fast=Compiled('store_attr',3,status=True);events=[]
 class Record:pass
 owner=Record();marker=object()
 class Old:
  def __del__(self):events.append(owner.value is marker)
 owner.value=Old()
 assert fast(owner,'value',marker)==0 and owner.value is marker and events==[True]

def test_raw_items_preserve_identity_tuple_key_and_subclass_callbacks():
 get=Compiled('getitem',2);put=Compiled('setitem',3,status=True);marker=object();owner={}
 assert put(owner,('key',),marker)==0 and get(owner,('key',)) is marker
 with pytest.raises(KeyError) as error:get(owner,('missing',))
 assert error.value.args==(('missing',),)
 events=[]
 class Mapping(dict):
  def __getitem__(self,key):events.append(('get',key));return marker
  def __setitem__(self,key,value):events.append(('put',key,value))
 mapping=Mapping()
 assert get(mapping,1) is marker and put(mapping,2,marker)==0
 assert events==[('get',1),('put',2,marker)]

def test_raw_contains_retains_mutable_set_protocol_and_callback_error():
 contains=Compiled('contains',2,status=True)
 assert contains({frozenset({1})},{1})==1
 error=ValueError('contains');events=[]
 class Container:
  def __contains__(self,key):events.append(key);raise error
 with pytest.raises(ValueError) as caught:contains(Container(),3)
 assert caught.value is error and events==[3]

from recompyler import ir as shared
from recompyler import heap

def structure_subject(owner,key,value):
 owner.value=value
 owner[key]=value
 return owner.value,owner[key],key in owner

def method_subject(owner,value):return owner.append(value)

def test_selection_preserves_real_helper_ssa_opcode_and_exception_contracts():
 graph=shared.build(heap._find)
 selected=subject.select_structure_calls(graph,{'load_attr','store_attr','getitem','setitem','contains'})
 shared.verify(selected)
 before=[op for block in graph.blocks.values() for op in block.operations]
 after=[op for block in selected.blocks.values() for op in block.operations]
 assert any(op.attributes.get('lowering')=='structure.load_attr' for op in after)
 for left,right in zip(before,after):
  assert (right.name,right.instruction,right.offset,right.block,right.handler,right.arguments,right.results)==(left.name,left.instruction,left.offset,left.block,left.handler,left.arguments,left.results)
  assert all(right.attributes[key]==value for key,value in left.attributes.items())
 assert all('lowering' not in op.attributes for op in before)

def test_selection_uses_pinned_subscript_binary_argument_and_available_helpers_only():
 graph=shared.build(structure_subject)
 selected=subject.select_structure_calls(graph,{'getitem','contains'})
 shared.verify(selected)
 operations=[op for block in selected.blocks.values() for op in block.operations]
 assert {op.attributes.get('lowering') for op in operations if 'lowering' in op.attributes}=={'structure.getitem','structure.contains'}
 assert any(op.name=='binary' and op.attributes['oparg']==26 and op.attributes['lowering']=='structure.getitem' for op in operations)
 assert subject.select_structure_calls(graph,set()) is graph

def test_method_attribute_two_result_and_existing_lowering_stay_unchanged():
 graph=shared.build(method_subject)
 selected=subject.select_structure_calls(graph,{'load_attr'})
 assert selected is graph
 from dataclasses import replace
 graph=shared.build(heap._find)
 for block in graph.blocks.values():
  block.operations[:]=[replace(op,attributes={**op.attributes,'lowering':'other.lowering'}) if op.name=='load_attr' else op for op in block.operations]
 assert subject.select_structure_calls(graph,{'load_attr'}) is graph

def protected_subject(owner):
 try:return owner.value
 except AttributeError:return None

def test_selection_keeps_protected_region_depth_and_exception_edges():
 graph=shared.build(protected_subject)
 selected=shared.PassManager((lambda graph:subject.select_structure_calls(graph,{'load_attr'}),)).run(graph)
 assert selected.exceptions==graph.exceptions
 assert [(key,block.edges) for key,block in selected.blocks.items()]==[(key,block.edges) for key,block in graph.blocks.items()]
 assert any(op.name=='load_attr' and op.handler is not None and op.attributes['lowering']=='structure.load_attr' for block in selected.blocks.values() for op in block.operations)

def test_component_new_reference_keeps_result_alive_then_releases_it():
 import weakref,gc
 class Marker:pass
 fast=Compiled('getitem',2);marker=Marker();owner={'value':marker};ref=weakref.ref(marker)
 result=fast(owner,'value');del marker;owner.clear();gc.collect()
 assert result is ref()
 del result;gc.collect();assert ref() is None

def lookup_subject(owner,key):return owner[key]

def test_native_entry_pins_prepared_llvm_and_cache_owners_component_only():
 # This is an entry/primitive component, no compile_function or frame admission.
 import gc,weakref
 from recompyler.ir import entry as entry_module
 class Body:pass
 body=Body();body.lowerings=subject.StructureCalls(symbols.CPythonSymbols(),provider)
 module=ir.Module(name='s73_native_structure_entry')
 function=ir.Function(module,ir.FunctionType(PTR,[PTR,PTR.as_pointer(),ir.IntType(64),PTR]),name='body')
 builder=ir.IRBuilder(function.append_basic_block('entry'))
 owner=builder.load(function.args[1]);key=builder.load(builder.gep(function.args[1],[ir.Constant(ir.IntType(64),1)]))
 builder.ret(body.lowerings.getitem(builder,owner,key))
 assert 'NRT' not in str(module)
 machine=binding.Target.from_default_triple().create_target_machine();native=binding.parse_assembly(str(module));native.verify()
 body.engine=binding.create_mcjit_compiler(native,machine);body.engine.finalize_object()
 entry=entry_module.create_callable(lookup_subject,body.engine.get_function_address('body'),body)
 ref=weakref.ref(body);del body;gc.collect();assert ref() is not None
 marker=object();assert entry({'value':marker},'value') is marker
 with pytest.raises(KeyError) as caught:entry({},('missing',))
 assert caught.value.args==(('missing',),)
 del caught,entry;gc.collect();assert ref() is None

def test_build_map_calls_original_presized_routine_for_collision_observers():
 fast=Compiled('build_map',12)
 class Key:
  def __init__(self):self.seen=set()
  def __hash__(self):return 32
  def __eq__(self,other):
   if id(other) in self.seen:raise RuntimeError('repeated equality')
   self.seen.add(id(other));return False
 keys=[Key() for _ in range(6)];values=[object() for _ in keys]
 result=fast(*(part for pair in zip(keys,values) for part in pair))
 assert len(result)==6
 assert all(value is wanted for value,wanted in zip(result.values(),values))
 assert all(key is wanted for key,wanted in zip(result,keys))
 assert '_PyDict_FromItems' in fast.llvm

def test_build_map_empty_and_duplicate_keys_preserve_exact_results():
 empty=Compiled('build_map',0);assert empty()=={}
 fast=Compiled('build_map',4);key=object();first,last=object(),object()
 result=fast(key,first,key,last)
 assert list(result)==[key] and result[key] is last

def test_prepared_attribute_sites_do_not_increment_counters_by_default():
 class Record:pass
 owner=Record();marker=object();owner.value=marker
 load_site=Compiled('load_attr',2);store_site=Compiled('store_attr',3,status=True)
 for _ in range(10):
  assert load_site(owner,'value') is marker
  assert store_site(owner,'value',marker)==0
 assert provider.hits(load_site.lowerings.caches[0])==0
 assert provider.hits(store_site.lowerings.caches[0])==0

def test_build_map_loop_buffer_is_allocated_once_at_function_entry():
 ops=subject.StructureCalls(symbols.CPythonSymbols(),provider);module=ir.Module(name='s73_map_loop')
 size=ir.IntType(64);function=ir.Function(module,ir.FunctionType(size,[size]),name='probe')
 entry=function.append_basic_block('entry');loop=function.append_basic_block('loop');done=function.append_basic_block('done')
 builder=ir.IRBuilder(entry);builder.branch(loop);builder.position_at_end(loop)
 index=builder.phi(size);index.add_incoming(ir.Constant(size,0),entry)
 value=ops.build_map(builder)
 decref=ops.symbols.declare(module,'Py_DecRef',ir.VoidType(),[PTR]);builder.call(decref,[value])
 next_index=builder.add(index,ir.Constant(size,1));index.add_incoming(next_index,loop)
 builder.cbranch(builder.icmp_unsigned('<',next_index,function.args[0]),loop,done)
 builder.position_at_end(done);builder.ret(next_index)
 # Fail safely before running native code on the old stack-growing helper.
 assert any(inst.opname=='alloca' for inst in entry.instructions)
 assert not any(inst.opname=='alloca' for inst in loop.instructions)
 native=binding.parse_assembly(str(module));native.verify()
 engine=binding.create_mcjit_compiler(native,binding.Target.from_default_triple().create_target_machine());engine.finalize_object()
 call=ctypes.PYFUNCTYPE(ctypes.c_int64,ctypes.c_int64)(engine.get_function_address('probe'))
 assert call(10)==10 and call(200000)==200000


def test_inline_attribute_hit_has_guards_and_in_place_generic_misses():
 fast=Compiled('load_attr',2)
 assert 'structure_attr_hit' in fast.llvm
 class Record:pass
 owner=Record();first,last=object(),object();owner.value=first
 assert fast(owner,'value') is first
 owner.value=last;assert fast(owner,'value') is last
 # Materializing the dict and replacing it invalidates inline storage.
 owner.__dict__={'value':first};assert fast(owner,'value') is first
 events=[]
 Record.value=property(lambda self: events.append('property') or last)
 assert fast(owner,'value') is last and events==['property']
 del Record.value
 assert fast(owner,'value') is first
 class Custom:
  def __getattribute__(self,name):events.append(name);return last
 assert fast(Custom(),'value') is last and events[-1]=='value'


def test_dict_and_set_contains_lower_to_exact_type_guarded_cpython_calls():
 fast=Compiled('contains',2,status=True)
 assert 'PyDict_Contains' in fast.llvm and 'PySet_Contains' in fast.llvm
 marker=object();assert fast({marker:None},marker)==1
 assert fast({marker},marker)==1
 assert fast({frozenset({1})},{1})==1
 events=[]
 class Mapping(dict):
  def __contains__(self,key):events.append(key);return True
 assert fast(Mapping(),marker)==1 and events==[marker]


def attr_subject(owner):return owner.value

def contains_subject(owner,key):return key in owner

def test_adaptive_selection_uses_original_offsets_and_retains_generic_fallback():
 import dis
 class Record:pass
 owner=Record();owner.value=object()
 for _ in range(50000):attr_subject(owner)
 graph=shared.build(attr_subject)
 selected=subject.specialize_structure_calls(graph)
 operations=[op for block in selected.blocks.values() for op in block.operations]
 actual={i.offset:i.opname for i in dis.get_instructions(attr_subject,adaptive=True)}
 chosen=[op for op in operations if op.attributes.get('lowering')=='structure.load_attr']
 assert chosen and all(op.attributes['specialization']==actual[op.offset] for op in chosen)
 assert all(op.attributes['fallback']=='generic' for op in chosen)
 shared.verify(selected)
 for _ in range(50000):contains_subject({},None)
 chosen=[op for block in subject.specialize_structure_calls(shared.build(contains_subject)).blocks.values() for op in block.operations if op.name=='contains']
 assert chosen[0].attributes['specialization']=='CONTAINS_OP_DICT'
 assert chosen[0].attributes['lowering']=='structure.contains'


def test_cold_profile_types_select_guards_without_claiming_type_proofs():
 graph=shared.build(attr_subject)
 offset=next(op.offset for block in graph.blocks.values() for op in block.operations if op.name=='load_attr')
 selected=subject.specialize_structure_calls(graph,profile_types={offset:(object,)})
 op=next(op for block in selected.blocks.values() for op in block.operations if op.offset==offset)
 assert op.attributes['lowering']=='structure.load_attr'
 assert op.attributes['fallback']=='generic'
 assert 'proven_type' not in op.attributes


def test_dict_getitem_inline_path_hashes_missing_key_once_and_keeps_tuple_args():
 fast=Compiled('getitem',2)
 assert 'PyDict_GetItemRef' in fast.llvm
 class Key:
  def __init__(self):self.calls=0
  def __hash__(self):self.calls+=1;return 17
 key=Key()
 with pytest.raises(KeyError) as error:fast({},key)
 assert key.calls==1 and error.value.args==(key,)
 with pytest.raises(KeyError) as error:fast({},('missing',))
 assert error.value.args==(('missing',),)
