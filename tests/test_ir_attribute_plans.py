"""S74 immutable adaptive offset feedback retains guarded fallback semantics."""
import ctypes,dis
import pytest
from llvmlite import binding,ir
from recompyler import _structure_ops_native as provider
from recompyler.ir import structure_lowerings as subject,symbols
P=ir.IntType(8).as_pointer()

def read(owner):return owner.value

def warmed():
 class Record:pass
 owner=Record();owner.padding=object();owner.value=object()
 for _ in range(2000):read(owner)
 instruction=next(i for i in dis.get_instructions(read,adaptive=True) if i.opname=='LOAD_ATTR_INSTANCE_VALUE')
 return Record,owner,instruction,subject.attribute_plan(read.__code__,instruction.offset)

class Cached:
 def __init__(self,plan,borrowed=False):
  self.ops=subject.StructureCalls(symbols.CPythonSymbols(),provider)
  module=ir.Module();function=ir.Function(module,ir.FunctionType(P,[P,P]),name='probe');builder=ir.IRBuilder(function.append_basic_block('entry'))
  method=self.ops.try_load_attr_cached if borrowed else self.ops.load_attr_cached
  result=method(builder,*function.args,plan);builder.ret(result)
  binding.initialize_native_target();binding.initialize_native_asmprinter()
  target=binding.Target.from_default_triple().create_target_machine();native=binding.parse_assembly(str(module));native.verify()
  self.engine=binding.create_mcjit_compiler(binding.parse_assembly(''),target);self.engine.add_module(native);self.engine.finalize_object()
  self.call=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.c_void_p,ctypes.c_void_p)(self.engine.get_function_address('probe'));self.borrowed=borrowed;self.plan=plan
 def __call__(self,owner,name='value'):
  value=self.call(id(owner),id(name))
  if not value:return subject.GUARD_MISS
  result=ctypes.cast(value,ctypes.py_object).value
  if not self.borrowed:
   decrement=ctypes.PYFUNCTYPE(None,ctypes.c_void_p)(('Py_DecRef',ctypes.pythonapi));decrement(value)
  return result

def test_feedback_decodes_byte_offset_and_cold_or_other_opcode_declines():
 _,owner,instruction,plan=warmed()
 assert plan.name=='value' and plan.version>0
 cache=b''.join(raw for name,size,raw in instruction.cache_info)
 assert plan.version==int.from_bytes(cache[2:6],'little')
 assert plan.offset==int.from_bytes(cache[6:8],'little')
 assert Cached(plan)(owner) is owner.value
 cold=compile('def fresh(owner):return owner.value','cold-attribute-plan','exec');scope={};exec(cold,scope)
 assert subject.attribute_plan(scope['fresh'].__code__,4) is None
 assert subject.attribute_plan(read.__code__,0) is None

def test_immediate_offset_owned_load_retains_same_site_generic_fallback():
 Record,owner,_,plan=warmed();load=Cached(plan);marker=owner.value
 assert load(owner) is marker
 owner.__dict__={'value':None,'other':marker}
 assert load(owner) is None and load(owner,'other') is marker
 events=[]
 Record.value=property(lambda self:events.append('property') or marker)
 assert load(owner) is marker and events==['property']
 del Record.value;del owner.__dict__['value']
 with pytest.raises(AttributeError):load(owner)

def test_immediate_offset_borrowed_guard_never_observes_failed_descriptor():
 Record,owner,_,plan=warmed();load=Cached(plan,borrowed=True)
 assert load(owner) is owner.value
 owner.__dict__={'value':object()}
 assert load(owner) is subject.GUARD_MISS
 Record.value=property(lambda self:pytest.fail('borrowed guard invoked descriptor'))
 assert load(owner) is subject.GUARD_MISS


def test_selection_attaches_feedback_without_changing_ssa_or_exceptions():
 from recompyler import ir as shared
 _,owner,instruction,plan=warmed();graph=shared.build(read)
 selected=subject.specialize_structure_calls(graph,immediate_offsets=True)
 shared.verify(selected)
 before=[op for block in graph.blocks.values() for op in block.operations]
 after=[op for block in selected.blocks.values() for op in block.operations]
 assert next(op for op in after if op.name=='load_attr').attributes['attribute_plan']==plan
 for left,right in zip(before,after):
  assert (left.name,left.offset,left.arguments,left.results,left.handler)==(right.name,right.offset,right.arguments,right.results,right.handler)


def test_shared_lowerer_consumes_the_offset_plan_and_retains_retirement_context():
 from recompyler import ir as shared,_source_frames_native as frames
 from recompyler.ir.lower_llvm import lower
 from recompyler.ir.entry import create_callable
 Record,owner,_,plan=warmed()
 ops=subject.StructureCalls(symbols.CPythonSymbols(),provider)
 graph=subject.specialize_structure_calls(shared.build(read),immediate_offsets=True)
 lowered=lower(graph,structure_calls=ops)
 assert ops.attribute_plans==[plan]
 entry=create_callable(read,lowered.body_address,lowered.keepalive,
                       runner_address=frames.addresses()['run_vectorcall'])
 assert entry(owner) is owner.value
 marker=object();events=[]
 Record.value=property(lambda self:events.append('get') or marker)
 assert entry(owner) is marker and events==['get']


def test_unmeasured_immediate_offset_plan_is_not_automatically_selected():
 from recompyler import ir as shared
 warmed()
 graph=subject.specialize_structure_calls(shared.build(read))
 assert all('attribute_plan' not in op.attributes for block in graph.blocks.values() for op in block.operations)
